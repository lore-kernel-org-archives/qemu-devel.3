Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 236C7FDEE3F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 19:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFzdJ-0006AN-Es; Thu, 23 Apr 2026 15:22:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzcm-0004jX-5D
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:22:11 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzcj-0002Ji-TC
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:22:07 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 465876A8AB;
 Thu, 23 Apr 2026 19:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cEY8XD3xBrJLvWZZxM6SWztn1MCt3QZRKtvPcKEo8uk=;
 b=IGMohvtOH5DUa+hN+f0aQzeMICyN7UZmmviOIUpmUNCop9aSiJRBQvpixlxsVg9RvH2dtP
 MorXgwpSr8PU7kzt06XuwQEJEYkeab8jajan9mGWzKyFDISvManHzEIoea9DOXNPNbkh5h
 Nf1ImxUPldQcw7yJ5/equz3uZO+usZQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972047;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cEY8XD3xBrJLvWZZxM6SWztn1MCt3QZRKtvPcKEo8uk=;
 b=wMVwALrUh4v++CbqwZx6Ye7u9WydyDriXrIIua7e4uKHUJWIaxgIMIIXzqwK5k59kEBz4H
 /8a61Z98tJVgBwBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cEY8XD3xBrJLvWZZxM6SWztn1MCt3QZRKtvPcKEo8uk=;
 b=IGMohvtOH5DUa+hN+f0aQzeMICyN7UZmmviOIUpmUNCop9aSiJRBQvpixlxsVg9RvH2dtP
 MorXgwpSr8PU7kzt06XuwQEJEYkeab8jajan9mGWzKyFDISvManHzEIoea9DOXNPNbkh5h
 Nf1ImxUPldQcw7yJ5/equz3uZO+usZQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972047;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cEY8XD3xBrJLvWZZxM6SWztn1MCt3QZRKtvPcKEo8uk=;
 b=wMVwALrUh4v++CbqwZx6Ye7u9WydyDriXrIIua7e4uKHUJWIaxgIMIIXzqwK5k59kEBz4H
 /8a61Z98tJVgBwBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 097BF593A3;
 Thu, 23 Apr 2026 19:20:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mDj4MQ1x6mlJCwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 Apr 2026 19:20:45 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 30/43] vmstate: Allow vmstate_info_nullptr to emit non-NULL
 markers
Date: Thu, 23 Apr 2026 16:19:44 -0300
Message-ID: <20260423191958.1440-31-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260423191958.1440-1-farosas@suse.de>
References: <20260423191958.1440-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Peter Xu <peterx@redhat.com>

We used to have one vmstate called "nullptr" which is only used to generate
one-byte hint to say one pointer is NULL.

Let's extend its use so that it will generate another byte to say the
pointer is non-NULL.

With that, the name of the info struct (or functions) do not apply anymore.
Update correspondingly.

Update analyze-migration.py to work with the new layout.

No functional change intended yet.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260401202844.673494-8-peterx@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/migration/vmstate.h  |  9 +++++++--
 migration/vmstate-types.c    | 34 ++++++++++++++++------------------
 migration/vmstate.c          | 25 +++++++++++++------------
 scripts/analyze-migration.py | 22 ++++++++++++----------
 4 files changed, 48 insertions(+), 42 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 7396e38531..492069b8d2 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -282,9 +282,14 @@ extern const VMStateInfo vmstate_info_uint32;
 extern const VMStateInfo vmstate_info_uint64;
 extern const VMStateInfo vmstate_info_fd;
 
-/** Put this in the stream when migrating a null pointer.*/
+/*
+ * Put this in the stream when migrating a pointer to reflect either a NULL
+ * or valid pointer.
+ */
 #define VMS_MARKER_PTR_NULL          (0x30U)   /* '0' */
-extern const VMStateInfo vmstate_info_nullptr;
+#define VMS_MARKER_PTR_VALID         (0x31U)   /* '1' */
+
+extern const VMStateInfo vmstate_info_ptr_marker;
 
 extern const VMStateInfo vmstate_info_cpudouble;
 
diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index 7622cf8f01..b31689fc3c 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -359,36 +359,34 @@ const VMStateInfo vmstate_info_fd = {
     .save = save_fd,
 };
 
-static bool load_nullptr(QEMUFile *f, void *pv, size_t size,
-                         const VMStateField *field, Error **errp)
+static bool load_ptr_marker(QEMUFile *f, void *pv, size_t size,
+                            const VMStateField *field, Error **errp)
 
 {
-    if (qemu_get_byte(f) == VMS_MARKER_PTR_NULL) {
+    int byte = qemu_get_byte(f);
+
+    if (byte == VMS_MARKER_PTR_NULL || byte == VMS_MARKER_PTR_VALID) {
+        /* TODO: process PTR_VALID case */
         return true;
     }
 
-    error_setg(errp, "vmstate: load_nullptr expected VMS_NULLPTR_MARKER");
+    error_setg(errp, "%s: unexpected ptr marker: %d", __func__, byte);
     return false;
 }
 
-static bool save_nullptr(QEMUFile *f, void *pv, size_t size,
-                         const VMStateField *field, JSONWriter *vmdesc,
-                         Error **errp)
+static bool save_ptr_marker(QEMUFile *f, void *pv, size_t size,
+                            const VMStateField *field, JSONWriter *vmdesc,
+                            Error **errp)
 
 {
-    if (pv == NULL) {
-        qemu_put_byte(f, VMS_MARKER_PTR_NULL);
-        return true;
-    }
-
-    error_setg(errp, "vmstate: save_nullptr must be called with pv == NULL");
-    return false;
+    qemu_put_byte(f, pv ? VMS_MARKER_PTR_VALID : VMS_MARKER_PTR_NULL);
+    return true;
 }
 
-const VMStateInfo vmstate_info_nullptr = {
-    .name = "nullptr",
-    .load = load_nullptr,
-    .save = save_nullptr,
+const VMStateInfo vmstate_info_ptr_marker = {
+    .name = "ptr-marker",
+    .load = load_ptr_marker,
+    .save = save_ptr_marker,
 };
 
 /* 64 bit unsigned int. See that the received value is the same than the one
diff --git a/migration/vmstate.c b/migration/vmstate.c
index b274204e66..b333aa1744 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -55,12 +55,12 @@ vmstate_field_exists(const VMStateDescription *vmsd, const VMStateField *field,
 }
 
 /*
- * Create a fake nullptr field when there's a NULL pointer detected in the
+ * Create a ptr marker field when there's a NULL pointer detected in the
  * array of a VMS_ARRAY_OF_POINTER VMSD field.  It's needed because we
  * can't dereference the NULL pointer.
  */
 static const VMStateField *
-vmsd_create_fake_nullptr_field(const VMStateField *field)
+vmsd_create_ptr_marker_field(const VMStateField *field)
 {
     VMStateField *fake = g_new0(VMStateField, 1);
 
@@ -71,12 +71,12 @@ vmsd_create_fake_nullptr_field(const VMStateField *field)
     fake->name = field->name;
     fake->version_id = field->version_id;
 
-    /* Do not need "field_exists" check as it always exists (which is null) */
+    /* Do not need "field_exists" check as it always exists */
     fake->field_exists = NULL;
 
-    /* See vmstate_info_nullptr - use 1 byte to represent nullptr */
+    /* See vmstate_info_ptr_marker - use 1 byte to represent ptr status */
     fake->size = 1;
-    fake->info = &vmstate_info_nullptr;
+    fake->info = &vmstate_info_ptr_marker;
     fake->flags = VMS_SINGLE;
 
     /* All the rest fields shouldn't matter.. */
@@ -278,7 +278,7 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
                      * an array of pointers), use null placeholder and do
                      * not follow.
                      */
-                    inner_field = vmsd_create_fake_nullptr_field(field);
+                    inner_field = vmsd_create_ptr_marker_field(field);
                 } else {
                     inner_field = field;
                 }
@@ -583,26 +583,27 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
             for (i = 0; i < n_elems; i++) {
                 void *curr_elem = first_elem + size * i;
                 const VMStateField *inner_field;
-                bool is_null;
                 /* maximum number of elements to compress in the JSON blob */
                 int max_elems = vmsd_can_compress(field) ? (n_elems - i) : 1;
+                bool use_marker_field, is_null;
 
                 if (field->flags & VMS_ARRAY_OF_POINTER) {
                     assert(curr_elem);
                     curr_elem = *(void **)curr_elem;
                 }
 
-                if (!curr_elem && size) {
+                is_null = !curr_elem && size;
+                use_marker_field = is_null;
+
+                if (use_marker_field) {
                     /*
                      * If null pointer found (which should only happen in
                      * an array of pointers), use null placeholder and do
                      * not follow.
                      */
-                    inner_field = vmsd_create_fake_nullptr_field(field);
-                    is_null = true;
+                    inner_field = vmsd_create_ptr_marker_field(field);
                 } else {
                     inner_field = field;
-                    is_null = false;
                 }
 
                 /*
@@ -638,7 +639,7 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
                                                     i, max_elems, errp);
 
                 /* If we used a fake temp field.. free it now */
-                if (is_null) {
+                if (use_marker_field) {
                     g_clear_pointer((gpointer *)&inner_field, g_free);
                 }
 
diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
index e81deab8f9..1771ff781b 100755
--- a/scripts/analyze-migration.py
+++ b/scripts/analyze-migration.py
@@ -469,26 +469,26 @@ def __init__(self, desc, file):
         super(VMSDFieldIntLE, self).__init__(desc, file)
         self.dtype = '<i%d' % self.size
 
-class VMSDFieldNull(VMSDFieldGeneric):
+class VMSDFieldPtrMarker(VMSDFieldGeneric):
     NULL_PTR_MARKER = b'0'
+    VALID_PTR_MARKER = b'1'
 
     def __init__(self, desc, file):
-        super(VMSDFieldNull, self).__init__(desc, file)
+        super(VMSDFieldPtrMarker, self).__init__(desc, file)
 
     def __repr__(self):
-        # A NULL pointer is encoded in the stream as a '0' to
-        # disambiguate from a mere 0x0 value and avoid consumers
-        # trying to follow the NULL pointer. Displaying '0', 0x30 or
-        # 0x0 when analyzing the JSON debug stream could become
+        # A NULL / non-NULL pointer may be encoded in the stream as a
+        # '0'/'1' to represent the status of the pointer.  Displaying '0',
+        # 0x30 or 0x0 when analyzing the JSON debug stream could become
         # confusing, so use an explicit term instead.
-        return "nullptr"
+        return "null-ptr" if self.data == self.NULL_PTR_MARKER else "valid-ptr"
 
     def __str__(self):
         return self.__repr__()
 
     def read(self):
-        super(VMSDFieldNull, self).read()
-        assert(self.data == self.NULL_PTR_MARKER)
+        super(VMSDFieldPtrMarker, self).read()
+        assert(self.data in [self.NULL_PTR_MARKER, self.VALID_PTR_MARKER])
         return self.data
 
 class VMSDFieldBool(VMSDFieldGeneric):
@@ -642,7 +642,9 @@ def getDict(self):
     "bitmap" : VMSDFieldGeneric,
     "struct" : VMSDFieldStruct,
     "capability": VMSDFieldCap,
-    "nullptr": VMSDFieldNull,
+    # Keep the old nullptr for old binaries
+    "nullptr": VMSDFieldPtrMarker,
+    "ptr-marker": VMSDFieldPtrMarker,
     "unknown" : VMSDFieldGeneric,
 }
 
-- 
2.51.0


