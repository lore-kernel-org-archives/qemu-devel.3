Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A40DC02193
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 08:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcgeQ-0002Jq-G2; Tue, 28 Jan 2025 03:08:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgbL-0003ZK-Tb; Tue, 28 Jan 2025 03:05:40 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgbJ-0003A3-QK; Tue, 28 Jan 2025 03:05:39 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4621FE1B76;
 Tue, 28 Jan 2025 10:57:09 +0300 (MSK)
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id B5EB81A6329;
 Tue, 28 Jan 2025 10:57:34 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id 37620520E3; Tue, 28 Jan 2025 10:57:34 +0300 (MSK)
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.3 47/58] migration: Fix arrays of pointers in JSON writer
Date: Mon, 27 Jan 2025 23:25:33 +0300
Message-Id: <20250127202547.3723716-47-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.3-20250127232536@cover.tls.msk.ru>
References: <qemu-stable-9.1.3-20250127232536@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Michael Tokarev <mjt@tls.msk.ru>
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Currently, if an array of pointers contains a NULL pointer, that
pointer will be encoded as '0' in the stream. Since the JSON writer
doesn't define a "pointer" type, that '0' will now be an uint8, which
is different from the original type being pointed to, e.g. struct.

(we're further calling uint8 "nullptr", but that's irrelevant to the
issue)

That mixed-type array shouldn't be compressed, otherwise data is lost
as the code currently makes the whole array have the type of the first
element:

css = {NULL, NULL, ..., 0x5555568a7940, NULL};

{"name": "s390_css", "instance_id": 0, "vmsd_name": "s390_css",
 "version": 1, "fields": [
    ...,
    {"name": "css", "array_len": 256, "type": "nullptr", "size": 1},
    ...,
]}

In the above, the valid pointer at position 254 got lost among the
compressed array of nullptr.

While we could disable the array compression when a NULL pointer is
found, the JSON part of the stream still makes part of downtime, so we
should avoid writing unecessary bytes to it.

Keep the array compression in place, but if NULL and non-NULL pointers
are mixed break the array into several type-contiguous pieces :

css = {NULL, NULL, ..., 0x5555568a7940, NULL};

{"name": "s390_css", "instance_id": 0, "vmsd_name": "s390_css",
 "version": 1, "fields": [
     ...,
     {"name": "css", "array_len": 254, "type": "nullptr", "size": 1},
     {"name": "css", "type": "struct", "struct": {"vmsd_name": "s390_css_img", ... }, "size": 768},
     {"name": "css", "type": "nullptr", "size": 1},
     ...,
]}

Now each type-discontiguous region will become a new JSON entry. The
reader should interpret this as a concatenation of values, all part of
the same field.

Parsing the JSON with analyze-script.py now shows the proper data
being pointed to at the places where the pointer is valid and
"nullptr" where there's NULL:

"s390_css (14)": {
    ...
    "css": [
        "nullptr",
        "nullptr",
        ...
        "nullptr",
        {
            "chpids": [
            {
                "in_use": "0x00",
                "type": "0x00",
                "is_virtual": "0x00"
            },
            ...
            ]
        },
        "nullptr",
    }

Reviewed-by: Peter Xu <peterx@redhat.com>
Message-Id: <20250109185249.23952-7-farosas@suse.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
(cherry picked from commit 35049eb0d2fc72bb8c563196ec75b4d6c13fce02)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 52704c822c..82bd005a83 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -425,15 +425,19 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
             int size = vmstate_size(opaque, field);
             uint64_t old_offset, written_bytes;
             JSONWriter *vmdesc_loop = vmdesc;
+            bool is_prev_null = false;
 
             trace_vmstate_save_state_loop(vmsd->name, field->name, n_elems);
             if (field->flags & VMS_POINTER) {
                 first_elem = *(void **)first_elem;
                 assert(first_elem || !n_elems || !size);
             }
+
             for (i = 0; i < n_elems; i++) {
                 void *curr_elem = first_elem + size * i;
                 const VMStateField *inner_field;
+                bool is_null;
+                int max_elems = n_elems - i;
 
                 old_offset = qemu_file_transferred(f);
                 if (field->flags & VMS_ARRAY_OF_POINTER) {
@@ -448,12 +452,39 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                      * not follow.
                      */
                     inner_field = vmsd_create_fake_nullptr_field(field);
+                    is_null = true;
                 } else {
                     inner_field = field;
+                    is_null = false;
+                }
+
+                /*
+                 * Due to the fake nullptr handling above, if there's mixed
+                 * null/non-null data, it doesn't make sense to emit a
+                 * compressed array representation spanning the entire array
+                 * because the field types will be different (e.g. struct
+                 * vs. nullptr). Search ahead for the next null/non-null element
+                 * and start a new compressed array if found.
+                 */
+                if (field->flags & VMS_ARRAY_OF_POINTER &&
+                    is_null != is_prev_null) {
+
+                    is_prev_null = is_null;
+                    vmdesc_loop = vmdesc;
+
+                    for (int j = i + 1; j < n_elems; j++) {
+                        void *elem = *(void **)(first_elem + size * j);
+                        bool elem_is_null = !elem && size;
+
+                        if (is_null != elem_is_null) {
+                            max_elems = j - i;
+                            break;
+                        }
+                    }
                 }
 
                 vmsd_desc_field_start(vmsd, vmdesc_loop, inner_field,
-                                      i, n_elems);
+                                      i, max_elems);
 
                 if (inner_field->flags & VMS_STRUCT) {
                     ret = vmstate_save_state(f, inner_field->vmsd,
diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
index 923f174f1b..8e1fbf4c9d 100755
--- a/scripts/analyze-migration.py
+++ b/scripts/analyze-migration.py
@@ -502,15 +502,25 @@ def read(self):
             field['data'] = reader(field, self.file)
             field['data'].read()
 
-            if 'index' in field:
-                if field['name'] not in self.data:
-                    self.data[field['name']] = []
-                a = self.data[field['name']]
-                if len(a) != int(field['index']):
-                    raise Exception("internal index of data field unmatched (%d/%d)" % (len(a), int(field['index'])))
-                a.append(field['data'])
+            fname = field['name']
+            fdata = field['data']
+
+            # The field could be:
+            # i) a single data entry, e.g. uint64
+            # ii) an array, indicated by it containing the 'index' key
+            #
+            # However, the overall data after parsing the whole
+            # stream, could be a mix of arrays and single data fields,
+            # all sharing the same field name due to how QEMU breaks
+            # up arrays with NULL pointers into multiple compressed
+            # array segments.
+            if fname not in self.data:
+                self.data[fname] = fdata
+            elif type(self.data[fname]) == list:
+                self.data[fname].append(fdata)
             else:
-                self.data[field['name']] = field['data']
+                tmp = self.data[fname]
+                self.data[fname] = [tmp, fdata]
 
         if 'subsections' in self.desc['struct']:
             for subsection in self.desc['struct']['subsections']:
-- 
2.39.5


