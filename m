Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B66C4FEC102
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 19:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w57ft-0003R7-LF; Tue, 24 Mar 2026 15:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w57fs-0003P7-15
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 15:44:24 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w57fq-0008H4-An
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 15:44:23 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0371B4D2D7;
 Tue, 24 Mar 2026 19:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774381437; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CKGmz+lKmXdFvQ91j7EaHfHSLwUO7DpcItY8Bz2/bO0=;
 b=SG+MIn1ujA8J03/2tK3CgElz6d4fQBTORqaGA5QX0uHCzFWL/6zLwCvF08hCJXZCPfu5of
 tK+asjnku9MLSeT48qjXVDfUpVpqpe3PB1EYag3lu4A1CotxXv2NOawxRO1fPkBUQrkVJL
 CdHtd+FRD1ouumsBQMA5qwnfCbuftmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774381437;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CKGmz+lKmXdFvQ91j7EaHfHSLwUO7DpcItY8Bz2/bO0=;
 b=nlPayM8pI51QIJeluhDW03aZYIxWpK6p0GtV0CF6hwYSy9kIH0c6jARU7CoUE05AumlHdh
 hssoq/kQ/yxYoIBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774381437; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CKGmz+lKmXdFvQ91j7EaHfHSLwUO7DpcItY8Bz2/bO0=;
 b=SG+MIn1ujA8J03/2tK3CgElz6d4fQBTORqaGA5QX0uHCzFWL/6zLwCvF08hCJXZCPfu5of
 tK+asjnku9MLSeT48qjXVDfUpVpqpe3PB1EYag3lu4A1CotxXv2NOawxRO1fPkBUQrkVJL
 CdHtd+FRD1ouumsBQMA5qwnfCbuftmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774381437;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CKGmz+lKmXdFvQ91j7EaHfHSLwUO7DpcItY8Bz2/bO0=;
 b=nlPayM8pI51QIJeluhDW03aZYIxWpK6p0GtV0CF6hwYSy9kIH0c6jARU7CoUE05AumlHdh
 hssoq/kQ/yxYoIBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D097543FE4;
 Tue, 24 Mar 2026 19:43:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6PajJ3vpwmlkMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 24 Mar 2026 19:43:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [RFC PATCH v1 13/17] vmstate: Drop VMS_ARRAY_OF_POINTER_AUTO_ALLOC
Date: Tue, 24 Mar 2026 16:43:28 -0300
Message-ID: <20260324194333.30004-14-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260324194333.30004-1-farosas@suse.de>
References: <20260324194333.30004-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The semantics of the VMS_ARRAY_OF_POINTER_AUTO_ALLOC of allocating
memory dynamically for an array of pointers could be thought to be the
same as the currently non-existent combination of VMS_ARRAY_OF_POINTER
| VMS_ALLOC. The code is now able to handle such invalid combination,
so drop the new flag and enable the VMS_ARRAY_OF_POINTER | VMS_ALLOC
combo.

Note: I don't quite understand why we cannot allocate the first
element of the array with VMS_ARRAY_OF_POINTER_AUTO_ALLOC, so I
avoided that case when using the other flags as well.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/migration/vmstate.h | 21 +++++----------------
 migration/savevm.c          | 28 ++++++++++++----------------
 migration/vmstate.c         | 12 +++++++-----
 3 files changed, 24 insertions(+), 37 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 70bebc60ed..bf12df66e2 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -146,8 +146,8 @@ enum VMStateFlags {
     /* When loading serialised VM state, allocate memory for the
      * (entire) field. Only valid in combination with
      * VMS_POINTER. Note: Not all combinations with other flags are
-     * currently supported, e.g. VMS_ALLOC|VMS_ARRAY_OF_POINTER won't
-     * cause the individual entries to be allocated. */
+     * currently supported.
+     */
     VMS_ALLOC            = 0x2000,
 
     /* Multiply the number of entries given by the integer at opaque +
@@ -161,19 +161,8 @@ enum VMStateFlags {
      * structure we are referencing to use. */
     VMS_VSTRUCT           = 0x8000,
 
-    /*
-     * This is a sub-flag for VMS_ARRAY_OF_POINTER, so VMS_ARRAY_OF_POINTER
-     * must be set altogether.  When set, it means array elements can
-     * contain either valid or NULL pointers, vmstate core will sync it
-     * between the two QEMU instances via the stream protocol.  When it's a
-     * valid pointer, the vmstate core will be responsible to do the proper
-     * memory allocations.  It also means user of this flag must prepare
-     * the array to be all NULLs otherwise memory may leak.
-     */
-    VMS_ARRAY_OF_POINTER_AUTO_ALLOC = 0x10000,
-
     /* Marker for end of list */
-    VMS_END                         = 0x20000,
+    VMS_END                         = 0x10000,
 };
 
 typedef enum {
@@ -610,7 +599,7 @@ extern const VMStateInfo vmstate_info_qlist;
     .size       = sizeof(_type),                                     \
     .flags      = VMS_POINTER | VMS_VARRAY_UINT8 |                   \
                   VMS_ARRAY_OF_POINTER | VMS_STRUCT |                \
-                  VMS_ARRAY_OF_POINTER_AUTO_ALLOC,                   \
+                  VMS_ALLOC,                                         \
     .offset     = vmstate_offset_pointer(_state, _field, _type *),   \
 }
 
@@ -623,7 +612,7 @@ extern const VMStateInfo vmstate_info_qlist;
     .size       = sizeof(_type),                                      \
     .flags      = VMS_POINTER | VMS_VARRAY_UINT32 |                   \
                   VMS_ARRAY_OF_POINTER | VMS_STRUCT |                 \
-                  VMS_ARRAY_OF_POINTER_AUTO_ALLOC,                    \
+                  VMS_ALLOC,                                          \
     .offset     = vmstate_offset_pointer(_state, _field, _type *),    \
 }
 
diff --git a/migration/savevm.c b/migration/savevm.c
index db0721996c..5170928d87 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -869,7 +869,8 @@ static void vmstate_check(const VMStateDescription *vmsd)
     if (field) {
         while (field->name) {
             if (field->flags & VMS_ARRAY_OF_POINTER) {
-                if (field->flags & VMS_ARRAY_OF_POINTER_AUTO_ALLOC) {
+                if (field->flags & VMS_ARRAY_OF_POINTER &&
+                    field->flags & VMS_ALLOC) {
                     /*
                      * Size must be provided because dest QEMU needs that
                      * info to know what to allocate
@@ -882,22 +883,17 @@ static void vmstate_check(const VMStateDescription *vmsd)
                      * setup of sizes in this case.
                      */
                     assert(field->size == 0 && field->size_offset == 0);
+
+                    /*
+                     * Without VMS_ALLOC, VMS_ARRAY_OF_POINTER must be
+                     * used only together with one of VMS_(V)ARRAY*
+                     * flags.
+                     */
+                    assert(field->flags & (VMS_ARRAY | VMS_VARRAY_INT32 |
+                                           VMS_VARRAY_UINT16 |
+                                           VMS_VARRAY_UINT8 |
+                                           VMS_VARRAY_UINT32));
                 }
-                /*
-                 * VMS_ARRAY_OF_POINTER must be used only together with one
-                 * of VMS_(V)ARRAY* flags.
-                 */
-                assert(field->flags & (VMS_ARRAY | VMS_VARRAY_INT32 |
-                                       VMS_VARRAY_UINT16 | VMS_VARRAY_UINT8 |
-                                       VMS_VARRAY_UINT32));
-            }
-
-            /*
-             * When VMS_ARRAY_OF_POINTER_ALLOW_NULL is used, we must have
-             * VMS_ARRAY_OF_POINTER set too.
-             */
-            if (field->flags & VMS_ARRAY_OF_POINTER_AUTO_ALLOC) {
-                assert(field->flags & VMS_ARRAY_OF_POINTER);
             }
 
             if (field->flags & (VMS_STRUCT | VMS_VSTRUCT)) {
diff --git a/migration/vmstate.c b/migration/vmstate.c
index c1ad0ef9a5..8f0f9383e2 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -115,7 +115,7 @@ static void *vmstate_first(void *opaque, const VMStateField *field,
 {
     void **first = opaque + field->offset;
 
-    if (alloc) {
+    if (alloc && field->flags & VMS_ALLOC) {
         return vmstate_handle_alloc(first, size, n);
     }
 
@@ -142,7 +142,7 @@ static void *vmstate_next(void **first, const VMStateField *field,
     next = *array_elem;
 
     if (alloc) {
-        if (!next || field->flags & VMS_ARRAY_OF_POINTER_AUTO_ALLOC) {
+        if (!next || field->flags & VMS_ALLOC) {
             /*
              * NOTE: do not use vmstate_size() here, because we
              * need the object size, not entry size of the
@@ -291,7 +291,7 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
             int size = vmstate_size(opaque, field);
 
             head = vmstate_first(opaque, field, size, n_elems,
-                                 field->flags & VMS_ALLOC);
+                                 !(field->flags & VMS_ARRAY_OF_POINTER));
 
             for (i = 0; i < n_elems; i++) {
                 /* If we will process the load of field? */
@@ -408,7 +408,8 @@ static bool vmsd_can_compress(const VMStateField *field)
         return false;
     }
 
-    if (field->flags & VMS_ARRAY_OF_POINTER_AUTO_ALLOC) {
+    if (field->flags & VMS_ARRAY_OF_POINTER &&
+        field->flags & VMS_ALLOC) {
         /*
          * This may involve two VMSD fields to be dumped, one for the
          * marker to show if the pointer is NULL, followed by the real
@@ -659,7 +660,8 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
                      * marker first for each element saying if it's populated.
                      */
                     use_dynamic_array =
-                        field->flags & VMS_ARRAY_OF_POINTER_AUTO_ALLOC;
+                        field->flags & VMS_ARRAY_OF_POINTER &&
+                        field->flags & VMS_ALLOC;
 
                     use_marker_field = use_dynamic_array || is_null;
 
-- 
2.51.0


