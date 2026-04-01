Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8171410FCAD4
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 20:30:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w82BU-0004Ma-Ho; Wed, 01 Apr 2026 16:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w82BR-0004Kr-TB
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 16:29:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w82BP-000399-Ux
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 16:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775075339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n1cYzTfIInVG4krmJT8uaa40fyNhORGhPZ9F1/mWMbo=;
 b=Za/0jEklxfZWkYP+VP6bmiVv9L/GOzGCW+soh1OkLbDKIQJ8uCvZtkTqYzlPbsxD0xY0L0
 svK1rFNQ4sddz/e9LsDXQXyuOt08qihxnO7QBhCmctrjaanhglGs20FkL89AxOnVOj2C3n
 KWpl4r0mS+mqWs8HYUnp8u20tqcJlUQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-Qk5rW2sLOGKTXKNWN_VLxA-1; Wed, 01 Apr 2026 16:28:57 -0400
X-MC-Unique: Qk5rW2sLOGKTXKNWN_VLxA-1
X-Mimecast-MFC-AGG-ID: Qk5rW2sLOGKTXKNWN_VLxA_1775075337
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-89ce2a7fef6so7143646d6.1
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 13:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775075336; x=1775680136; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n1cYzTfIInVG4krmJT8uaa40fyNhORGhPZ9F1/mWMbo=;
 b=SIdvczq9dFQwH1lQL4oh7ZK1pvguWDFiteDHMCS9eAxyq1q073Ak05lV43ottgbaC4
 69FUeKhgADdklAJiRAuxzDPGCZ5/AyEJT7WypVeIUAncLDR0ncdJid5Fkr2bHZ+cyvl5
 zfonby1f0yU5dPBTdI9DjYR1adZSx2bva9fVYkIXzegPxG2F3jHJ7KYehfP+f8Sj4ixh
 ChtBtG6aiD4riSA/h8myiYT7STJhr12rM3vZI3X9JaQe+06lHlMamV6jbADfpzVz/cRU
 vwzm5M2r37ZEEzdY7suB1ku94xUmTcx9bD8nulpGjoL3pJ8ss6rDNgWoPj4CibUWIhSt
 5RRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775075336; x=1775680136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n1cYzTfIInVG4krmJT8uaa40fyNhORGhPZ9F1/mWMbo=;
 b=cY8ePseij8zxiy7THc9ovYn5L7t8AWcwwgWNbJmf9g204tiFl2exEKdNWnSwzkp89J
 BuThbahzzf482eRDCKXJagBiDnl640HfEUt/TqqrFsov0CXnhkp47mTa6PLDrYsKyANy
 aB91hvylv+T1y9pKf2vSIsbUryN5LOlepddZA9bWDMCqfsfKIxkpINGXxcTOJZu2WRVt
 HKq6ZbDubOBZbfvYcNDB1zhBnEj9q88FSrqbfymoy9WYcxWfui5Bqug0Nv+WFdVs5uh3
 3cURItirbkv9phWT7u/P5cf1iyLb01PVaqqGSp/wFyRbadFoDI5kXVYQGbkB4ApcCOlT
 TgvQ==
X-Gm-Message-State: AOJu0YzpT+FZYWc/hOso70hUbvbyhXm9GxmvDFEHJpF3n7Bc2Q3TyMiU
 WsL40d2ylMwl5Nat+is9UOgfQtceuEk0y8j/RjTirNWKKnJp0nCLtxSx5bOi513OglHwr8MZnbZ
 e0uhGN43YuhHeFqOX9yS+vke5Gg4is9WToJVmfrPRY/ueb6RDrkRloQV7M0SfdnrvGbOnWn3Kt+
 wbrQrKwm2x/a1v3I3rvk7R5aeNxD+pgigJcSkAQQ==
X-Gm-Gg: ATEYQzw6JM+I8jPTHThXTz4fFxMW1BJqpTT17QagpUrhZ3mJyL1759N0fSq6cflhihO
 OQfuzanC9DxNIQN+4jO9QvOZJc4I0KzXJ/QJeI/2IeZEGtqN4WwlKSdadzQeBNlJyIaCuxK3hiI
 /1TBwWjgUGk5mFWfs2QFL4TaN7y+3huvKNUbrTIkRG+EaPB+332PnjYuhKDcvXdtY2Z9MAcBBVw
 EANOMpQ6zItUaCCsbTpm2TwCSCEyDcpi1O7WZHtFgdG9Q2T9Q19P7CQLKfOFfgpKPySV49t1wxS
 mp76zgwfjVeJ7gLnCyLL69dmYeLQyGymla2bLzIqPuAI7H0GYd5/yAGYehFzfnaD6Sm+OotCRCo
 fmhHwZxSBcW+uciaj5XoxQUXBpvOoUCnWr6OJTwH1scU=
X-Received: by 2002:a05:620a:404c:b0:8cb:9975:cba8 with SMTP id
 af79cd13be357-8d1b5c5782cmr818803185a.62.1775075336434; 
 Wed, 01 Apr 2026 13:28:56 -0700 (PDT)
X-Received: by 2002:a05:620a:404c:b0:8cb:9975:cba8 with SMTP id
 af79cd13be357-8d1b5c5782cmr818797985a.62.1775075335852; 
 Wed, 01 Apr 2026 13:28:55 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d2a548a4efsm68194085a.8.2026.04.01.13.28.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 13:28:55 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH 07/11] vmstate: Allow vmstate_info_nullptr to emit non-NULL
 markers
Date: Wed,  1 Apr 2026 16:28:40 -0400
Message-ID: <20260401202844.673494-8-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260401202844.673494-1-peterx@redhat.com>
References: <20260401202844.673494-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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
2.50.1


