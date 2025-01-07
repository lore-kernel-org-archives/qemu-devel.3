Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA4C1E77199
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 19:53:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVFbP-0003Bq-SN; Tue, 07 Jan 2025 14:50:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tVFb8-00038g-EV
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 14:50:43 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tVFb6-0002FJ-IS
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 14:50:41 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 50D261F391;
 Tue,  7 Jan 2025 19:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736279439; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HjwAIhieiDI4jccyYYVOBI5lsGpwJh5VFeLMMjjUJTE=;
 b=aIIvF5kcUM5Qs9tjqLXMwNA5Zpwux2a/hWQOamTegb5cXRy9iqHe9N9ZuTLiNTExvo1ysH
 HMzjeJyj/c8Ls8gUapZNUXivBtVPlrI5L0QmFw2DUoa+jCe2ObIIpApUpV61pWOeba7vM/
 6jB0/MXWRzrzEjw7QvbSND6gEIAeHOQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736279439;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HjwAIhieiDI4jccyYYVOBI5lsGpwJh5VFeLMMjjUJTE=;
 b=GHdpA6no72lUggHWUkwAzAe+gDCHyAnCjAiJQa9kOXhmSSQC3ngk7QOqV0bfFxwhGZxT+D
 Yd+UFh6RHmdWyoAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736279439; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HjwAIhieiDI4jccyYYVOBI5lsGpwJh5VFeLMMjjUJTE=;
 b=aIIvF5kcUM5Qs9tjqLXMwNA5Zpwux2a/hWQOamTegb5cXRy9iqHe9N9ZuTLiNTExvo1ysH
 HMzjeJyj/c8Ls8gUapZNUXivBtVPlrI5L0QmFw2DUoa+jCe2ObIIpApUpV61pWOeba7vM/
 6jB0/MXWRzrzEjw7QvbSND6gEIAeHOQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736279439;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HjwAIhieiDI4jccyYYVOBI5lsGpwJh5VFeLMMjjUJTE=;
 b=GHdpA6no72lUggHWUkwAzAe+gDCHyAnCjAiJQa9kOXhmSSQC3ngk7QOqV0bfFxwhGZxT+D
 Yd+UFh6RHmdWyoAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 24C9013A6A;
 Tue,  7 Jan 2025 19:50:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yDHFNo2FfWeCGAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 07 Jan 2025 19:50:37 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Thomas Huth <thuth@redhat.com>
Subject: [PATCH 6/7] migration: Fix arrays of pointers in JSON writer
Date: Tue,  7 Jan 2025 16:50:24 -0300
Message-Id: <20250107195025.9951-7-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250107195025.9951-1-farosas@suse.de>
References: <20250107195025.9951-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
doesn't define a "pointer" type, that '0' will now be an uint64, which
is different from the original type being pointed to, e.g. struct.

That mixed-type array shouldn't be compressed, otherwise data is lost
as the code currently makes the whole array have the type of the first
element.

While we could disable the array compression when a NULL pointer is
found, the JSON part of the stream still makes part of downtime, so we
should avoid writing unecessary bytes to it.

Keep the array compression in place, but break the array into several
type-contiguous pieces if NULL and non-NULL pointers are mixed.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/vmstate.c          | 33 ++++++++++++++++++++++++++++++++-
 scripts/analyze-migration.py |  9 ++++++++-
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 52704c822c..a79ccf3875 100644
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
+                 * vs. uint64_t). Search ahead for the next null/non-null
+                 * element and start a new compressed array if found.
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
index 4836920ddc..9138e91a11 100755
--- a/scripts/analyze-migration.py
+++ b/scripts/analyze-migration.py
@@ -497,7 +497,14 @@ def read(self):
                     raise Exception("internal index of data field unmatched (%d/%d)" % (len(a), int(field['index'])))
                 a.append(field['data'])
             else:
-                self.data[field['name']] = field['data']
+                # There could be multiple entries for the same field
+                # name, e.g. when a compressed array was broken in
+                # more than one piece.
+                if (field['name'] in self.data and
+                    type(self.data[field['name']]) == list):
+                    self.data[field['name']].append(field['data'])
+                else:
+                    self.data[field['name']] = field['data']
 
         if 'subsections' in self.desc['struct']:
             for subsection in self.desc['struct']['subsections']:
-- 
2.35.3


