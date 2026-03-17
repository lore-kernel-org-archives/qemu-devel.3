Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4034FF6E9E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 23:25:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2dlT-0003zE-OW; Tue, 17 Mar 2026 19:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w2dlS-0003yr-4N
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 19:23:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w2dlP-0006TP-Us
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 19:23:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773789831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5vkvO/aSwVfWwyf4C8OnQy+aocu9TdzvUh0BD1i35+o=;
 b=XykeSZvZjYqLI1eoVzSUbSiGuOqPMqkMZWRp8lQ3MZq2BTBbIiesWLPE1UG2Zqeq5IsBso
 DYpYkDi1GKw/nZvfA7BRN9qspA8BsE4fj/8BRJRdSUnqasVnWWg8FZWY4D7wAcn0XM40//
 jLxwSrHAbPjpblVF3dwia7vwkO/FNW4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-OtvGoDePMH6E8_Sdz7hP6w-1; Tue, 17 Mar 2026 19:23:50 -0400
X-MC-Unique: OtvGoDePMH6E8_Sdz7hP6w-1
X-Mimecast-MFC-AGG-ID: OtvGoDePMH6E8_Sdz7hP6w_1773789829
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8950562d351so536728406d6.3
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 16:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773789829; x=1774394629; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5vkvO/aSwVfWwyf4C8OnQy+aocu9TdzvUh0BD1i35+o=;
 b=GORS2I3m8WYytfXy6yEvnVaZuc2d4GFmXNTnzdbf0G4nChL3VseQp8xCplLJToSyb1
 3Z1sStnEdlocg8F2LXH3cnTOFu4rijiSrHHNQaGinAHNCdKcyeZbKYqnwf5lyfQvMhMC
 8r4S9ywk+OVqeg14TNSOYSo5LZXb9ipqaMNbrosQ8yaDwzfY7TSFcUVMEftSnOOnkexf
 4j8wdOMcWvKpjP7j0PrFTaj8F0yEfjKN9X2Awi+USbKBlBRJ64c1kR91vMz3Ozb16kNO
 JGKodo3NzcvyJZIFelcTfqBglxAmhfTYdjDKNtsGEsTR7cN38dDKJIFZ0LeSHtbqU8kh
 AqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773789829; x=1774394629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5vkvO/aSwVfWwyf4C8OnQy+aocu9TdzvUh0BD1i35+o=;
 b=eqjHu4fZnDS/k2647WoclEV+OeaI+oY/nN8IMn6Ln9dRgDOUPBcL7zFuIQ1XiJ365l
 YkRtv1+8uj81j+0j+2Wt5w38t3KS9KJNUPGYCYhK9u1js0/7w8AfZMY1OAeDBCzW99LL
 UOlwy7qt2LH/BeEYEkRzEXe3Ede6nSzo+WK2Xq5YAfFyuCI/auFN3GzXgmKwsZU/Vlc6
 zGWHYUA7BiaVFGxmNfkYb9jSVNddzgI4VD6GMaxOfor0AQsMKpy+dShA18YLovEklbZX
 yCxbY1UdalDZER4NAyLfIPmJTc7nr8DlF4AVh6a0m8g2UJZZ24QVxoW5QLs6y9TDSZvZ
 PuHQ==
X-Gm-Message-State: AOJu0YwZsh6AeeIgLqnymeEgyhpana640J8NdUbvQrGa0o8tsaghuq+m
 tnJ8/xQHxC5sWUfLg+RNKFXLgy33BFdYSuwmt5NL5oDbvzeLjDroc+Sjvy53ik0T90fuaIDU912
 Gg7wiZxcZ5ihYbyA/ZIilGfqBd6YV3ClcFlHojY55X9v9VBLYoE1nrg6Z6EAloxEHrKMJ7UtIjT
 9hLyW54fBosjeKfnJ413und+RxCIoiV7nEjETvdQ==
X-Gm-Gg: ATEYQzxg7c/evdvle6DDgptBTxhgwlI2kyjghNqZHbgPVhQ5XDrM9eyndo08jmfjBm6
 vcMrXOVjPpF32eTFLxuHGBZQ2v2MnXDy+1C6kAZ2FrzJtvdCASe1/STtL4y3MHW5Aa5H4w0EG2E
 pZxQJ8Tk10Baz/D78ntn/m962O4ihD0ojyLjCMWwxf3tQwKfBH9bbJzg/RlSNzzmkPPBTWvfAPF
 7y3Y1Syk/osbYWGYjMUNH6MdqiOPkE+RPhOUbkQc/CtoYPDTmYyi0W8NCJUjfU3GRXKDZYnbxtD
 NdKuhIVDcqqlFS2o3/p56u0vFHbLkLSe1RsHAKQf0sfDCPpsiErOKAmdKZxOOPx3wkUZg+vq+t3
 ftsBtzuaB72rSSg==
X-Received: by 2002:a05:6214:6115:b0:89c:488b:bd37 with SMTP id
 6a1803df08f44-89c6b50c95amr20820986d6.21.1773789828990; 
 Tue, 17 Mar 2026 16:23:48 -0700 (PDT)
X-Received: by 2002:a05:6214:6115:b0:89c:488b:bd37 with SMTP id
 6a1803df08f44-89c6b50c95amr20820596d6.21.1773789828333; 
 Tue, 17 Mar 2026 16:23:48 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89c6b9ea39asm8203806d6.37.2026.03.17.16.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 16:23:47 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH RFC 09/10] vmstate: Implement VMS_ARRAY_OF_POINTER_AUTO_ALLOC
Date: Tue, 17 Mar 2026 19:23:31 -0400
Message-ID: <20260317232332.15209-10-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260317232332.15209-1-peterx@redhat.com>
References: <20260317232332.15209-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Introduce a new flag, VMS_ARRAY_OF_POINTER_AUTO_ALLOC, for VMSD field.  It
must be used together with VMS_ARRAY_OF_POINTER.

It can be used to allow migration of an array of pointers where the
pointers may point to NULLs.

Note that we used to allow migration of a NULL pointer within an array that
is being migrated. That corresponds to the code around vmstate_info_nullptr
where we may get/put one byte showing that the element of an array is NULL.

That usage is fine but very limited, it's because even if it will migrate a
NULL pointer with a marker, it still works in a way that both src and dest
QEMUs must know exactly which elements of the array are non-NULL, so
instead of dynamically loading an array (which can have NULL pointers), it
actually only verifies the known NULL pointers are still NULL pointers
after migration.

Also, in that case since dest QEMU knows exactly which element is NULL,
which is not NULL, dest QEMU's device code will manage all allocations for
the elements before invoking vmstate_load_vmsd().

That's not enough per evolving needs of new device states that may want to
provide real dynamic array of pointers, like what Alexander proposed here
with the NVMe device migration:

https://lore.kernel.org/r/20260317102708.126725-1-alexander@mihalicyn.com

This patch is an alternative approach to address the problem.

Along with the flag, introduce two new macros:

  VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT{8|32}_ALLOC()

Which will be used very soon in the NVMe series.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/vmstate.h |  49 ++++++++++++++++-
 migration/savevm.c          |  31 ++++++++++-
 migration/vmstate.c         | 101 ++++++++++++++++++++++++++++++++----
 3 files changed, 169 insertions(+), 12 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 2e51b5ea04..70bebc60ed 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -161,8 +161,19 @@ enum VMStateFlags {
      * structure we are referencing to use. */
     VMS_VSTRUCT           = 0x8000,
 
+    /*
+     * This is a sub-flag for VMS_ARRAY_OF_POINTER, so VMS_ARRAY_OF_POINTER
+     * must be set altogether.  When set, it means array elements can
+     * contain either valid or NULL pointers, vmstate core will sync it
+     * between the two QEMU instances via the stream protocol.  When it's a
+     * valid pointer, the vmstate core will be responsible to do the proper
+     * memory allocations.  It also means user of this flag must prepare
+     * the array to be all NULLs otherwise memory may leak.
+     */
+    VMS_ARRAY_OF_POINTER_AUTO_ALLOC = 0x10000,
+
     /* Marker for end of list */
-    VMS_END = 0x10000
+    VMS_END                         = 0x20000,
 };
 
 typedef enum {
@@ -580,6 +591,42 @@ extern const VMStateInfo vmstate_info_qlist;
     .offset     = vmstate_offset_array(_s, _f, _type*, _n),          \
 }
 
+/*
+ * For migrating a dynamically allocated uint{8,32}-indexed array of
+ * pointers to structures (with NULL entries and with auto memory
+ * allocation).
+ *
+ * _type: type of structure pointed to
+ * _vmsd: VMSD for structure _type (when VMS_STRUCT is set)
+ * _info: VMStateInfo for _type (when VMS_STRUCT is not set)
+ * start: size of (_type) pointed to (for auto memory allocation)
+ */
+#define VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT8_ALLOC(\
+    _field, _state, _field_num, _version, _vmsd, _type) {            \
+    .name       = (stringify(_field)),                               \
+    .version_id = (_version),                                        \
+    .num_offset = vmstate_offset_value(_state, _field_num, uint8_t), \
+    .vmsd       = &(_vmsd),                                          \
+    .size       = sizeof(_type),                                     \
+    .flags      = VMS_POINTER | VMS_VARRAY_UINT8 |                   \
+                  VMS_ARRAY_OF_POINTER | VMS_STRUCT |                \
+                  VMS_ARRAY_OF_POINTER_AUTO_ALLOC,                   \
+    .offset     = vmstate_offset_pointer(_state, _field, _type *),   \
+}
+
+#define VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT32_ALLOC(\
+    _field, _state, _field_num, _version, _vmsd, _type) {             \
+    .name       = (stringify(_field)),                                \
+    .version_id = (_version),                                         \
+    .num_offset = vmstate_offset_value(_state, _field_num, uint32_t), \
+    .vmsd       = &(_vmsd),                                           \
+    .size       = sizeof(_type),                                      \
+    .flags      = VMS_POINTER | VMS_VARRAY_UINT32 |                   \
+                  VMS_ARRAY_OF_POINTER | VMS_STRUCT |                 \
+                  VMS_ARRAY_OF_POINTER_AUTO_ALLOC,                    \
+    .offset     = vmstate_offset_pointer(_state, _field, _type *),    \
+}
+
 #define VMSTATE_VARRAY_OF_POINTER_UINT32(_field, _state, _field_num, _version, _info, _type) { \
     .name       = (stringify(_field)),                                    \
     .version_id = (_version),                                             \
diff --git a/migration/savevm.c b/migration/savevm.c
index f5a6fd0c66..34223de818 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -869,8 +869,37 @@ static void vmstate_check(const VMStateDescription *vmsd)
     if (field) {
         while (field->name) {
             if (field->flags & VMS_ARRAY_OF_POINTER) {
-                assert(field->size == 0);
+                if (VMS_ARRAY_OF_POINTER_AUTO_ALLOC) {
+                    /*
+                     * Size must be provided because dest QEMU needs that
+                     * info to know what to allocate
+                     */
+                    assert(field->size || field->size_offset);
+                } else {
+                    /*
+                     * Otherwise size info isn't useful (because it's
+                     * always the size of host pointer), enforce accidental
+                     * setup of sizes in this case.
+                     */
+                    assert(field->size == 0 && field->size_offset == 0);
+                }
+                /*
+                 * VMS_ARRAY_OF_POINTER must be used only together with one
+                 * of VMS_(V)ARRAY* flags.
+                 */
+                assert(field->flags & (VMS_ARRAY | VMS_VARRAY_INT32 |
+                                       VMS_VARRAY_UINT16 | VMS_VARRAY_UINT8 |
+                                       VMS_VARRAY_UINT32));
             }
+
+            /*
+             * When VMS_ARRAY_OF_POINTER_ALLOW_NULL is used, we must have
+             * VMS_ARRAY_OF_POINTER set too.
+             */
+            if (field->flags & VMS_ARRAY_OF_POINTER_AUTO_ALLOC) {
+                assert(field->flags & VMS_ARRAY_OF_POINTER);
+            }
+
             if (field->flags & (VMS_STRUCT | VMS_VSTRUCT)) {
                 /* Recurse to sub structures */
                 vmstate_check(field->vmsd);
diff --git a/migration/vmstate.c b/migration/vmstate.c
index d65fc84dfa..7d7d9c7e18 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -153,6 +153,12 @@ static bool vmstate_ptr_marker_load(QEMUFile *f, bool *load_field,
         return true;
     }
 
+    if (byte == VMS_MARKER_PTR_VALID) {
+        /* We need to load this field right after the marker */
+        *load_field = true;
+        return true;
+    }
+
     error_setg(errp, "Unexpected ptr marker: %d", byte);
     return false;
 }
@@ -234,6 +240,22 @@ static bool vmstate_post_load(const VMStateDescription *vmsd,
     return true;
 }
 
+
+/*
+ * If we will use a ptr marker in the stream for a field?  Two use cases:
+ *
+ * (1) When used with VMS_ARRAY_OF_POINTER_ALLOW_NULL, it must always be
+ *     present to imply the population status of the pointer.
+ *
+ * (2) When used with normal VMSD array fields, only emit a null ptr marker
+ *     if the pointer is NULL.
+ */
+static inline bool
+vmstate_use_marker_field(void *ptr, int size, bool dynamic_array)
+{
+    return (!ptr && size) || dynamic_array;
+}
+
 bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
                        void *opaque, int version_id, Error **errp)
 {
@@ -271,6 +293,12 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
             void *first_elem = opaque + field->offset;
             int i, n_elems = vmstate_n_elems(opaque, field);
             int size = vmstate_size(opaque, field);
+            /*
+             * When this is enabled, it means we will always push a ptr
+             * marker first for each element saying if it's populated.
+             */
+            bool use_dynamic_array =
+                field->flags & VMS_ARRAY_OF_POINTER_AUTO_ALLOC;
 
             vmstate_handle_alloc(first_elem, field, opaque);
             if (field->flags & VMS_POINTER) {
@@ -282,18 +310,37 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
                 /* If we will process the load of field? */
                 bool load_field = true;
                 bool ok = true;
-                void *curr_elem = first_elem + size * i;
+                bool use_marker_field;
+                void *curr_elem_p = first_elem + size * i;
+                void *curr_elem = curr_elem_p;
 
                 if (field->flags & VMS_ARRAY_OF_POINTER) {
-                    curr_elem = *(void **)curr_elem;
+                    curr_elem = *(void **)curr_elem_p;
                 }
 
-                if (!curr_elem && size) {
-                    /* Read the marker instead of VMSD itself */
+                use_marker_field = vmstate_use_marker_field(curr_elem, size,
+                                                            use_dynamic_array);
+                if (use_marker_field) {
+                    /* Read the marker instead of VMSD first */
                     if (!vmstate_ptr_marker_load(f, &load_field, errp)) {
                         trace_vmstate_load_field_error(field->name, -EINVAL);
                         return false;
                     }
+
+                    if (load_field) {
+                        /*
+                         * When reaching here, it means we received a
+                         * non-NULL ptr marker, so we need to populate the
+                         * field before loading it.
+                         *
+                         * NOTE: do not use vmstate_size() here, because we
+                         * need the object size, not entry size of the
+                         * array.
+                         */
+                        curr_elem = g_malloc0(field->size);
+                        /* Remember to update the root pointer! */
+                        *(void **)curr_elem_p = curr_elem;
+                    }
                 }
 
                 if (load_field) {
@@ -397,6 +444,16 @@ static bool vmsd_can_compress(const VMStateField *field)
         return false;
     }
 
+    if (field->flags & VMS_ARRAY_OF_POINTER_AUTO_ALLOC) {
+        /*
+         * This may involve two VMSD fields to be dumped, one for the
+         * marker to show if the pointer is NULL, followed by the real
+         * vmstate object.  To make it simple at least for now, skip
+         * compression for this one.
+         */
+        return false;
+    }
+
     if (field->flags & VMS_STRUCT) {
         const VMStateField *sfield = field->vmsd->fields;
         while (sfield->name) {
@@ -578,6 +635,12 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
             int size = vmstate_size(opaque, field);
             JSONWriter *vmdesc_loop = vmdesc;
             bool use_marker_field_prev = false;
+            /*
+             * When this is enabled, it means we will always push a ptr
+             * marker first for each element saying if it's populated.
+             */
+            bool use_dynamic_array =
+                field->flags & VMS_ARRAY_OF_POINTER_AUTO_ALLOC;
 
             trace_vmstate_save_state_loop(vmsd->name, field->name, n_elems);
             if (field->flags & VMS_POINTER) {
@@ -596,13 +659,10 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
                     curr_elem = *(void **)curr_elem;
                 }
 
-                use_marker_field = !curr_elem && size;
+                use_marker_field = vmstate_use_marker_field(curr_elem, size,
+                                                            use_dynamic_array);
+
                 if (use_marker_field) {
-                    /*
-                     * If null pointer found (which should only happen in
-                     * an array of pointers), use null placeholder and do
-                     * not follow.
-                     */
                     inner_field = vmsd_create_ptr_marker_field(field);
                 } else {
                     inner_field = field;
@@ -652,6 +712,27 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
                     goto out;
                 }
 
+                /*
+                 * If we're using dynamic array and the element is
+                 * populated, dump the real object right after the marker.
+                 */
+                if (use_dynamic_array && curr_elem) {
+                    /*
+                     * NOTE: do not use vmstate_size() here because we want
+                     * to dump the real VMSD object now.
+                     */
+                    ok = vmstate_save_field_with_vmdesc(f, curr_elem,
+                                                        field->size, vmsd,
+                                                        field, vmdesc_loop,
+                                                        i, max_elems, errp);
+
+                    if (!ok) {
+                        error_prepend(errp, "Save of field %s/%s failed: ",
+                                      vmsd->name, field->name);
+                        goto out;
+                    }
+                }
+
                 /* Compressed arrays only care about the first element */
                 if (vmdesc_loop && vmsd_can_compress(field)) {
                     vmdesc_loop = NULL;
-- 
2.50.1


