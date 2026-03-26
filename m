Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD28210AB82A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 21:07:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5rtr-0004AM-Nt; Thu, 26 Mar 2026 17:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5rtm-00048d-TU
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 17:05:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5rtk-00037M-Ky
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 17:05:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774559148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=drzSSQlOSjoFXZvAA8C13NBR1l8WjpxMK8cEocL7tFk=;
 b=gCshdkB7ghR2AhJ+umAT8Pnart6ak7znr5w37awV6yY4TYK0UjlxNNG4Wc9jOQObh5cr67
 XM1qSBd20bUFLTJEd5Tw6Lq+OisfTQaveedIUFSx+pkNKdLH/+xHDuP3ffe59Jihut9jQf
 nvux7i4qGsGoYDOfCyXt/wK3thyE/w0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-3vcvptPhM3iQ_7TlSJOigA-1; Thu, 26 Mar 2026 17:05:46 -0400
X-MC-Unique: 3vcvptPhM3iQ_7TlSJOigA-1
X-Mimecast-MFC-AGG-ID: 3vcvptPhM3iQ_7TlSJOigA_1774559146
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8cfc61fc9b8so392397385a.1
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 14:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774559146; x=1775163946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=drzSSQlOSjoFXZvAA8C13NBR1l8WjpxMK8cEocL7tFk=;
 b=bmD0M9zm67szEcrqC5BBWxcb4YipPB0z9bxfNzo/FWopx2oFPHaJJAmNmSPWP1Mzws
 K+m4vpKbotd4RCaYaKUkQlRcxUpOaN35ZEHQNCtEGq8lfaB0026lXRkiXy870RAlyaAy
 EcrSs7B004KAAuCZ69tlWu0n9z5eC/CuMt808BXgQMVm96NORHDymGgsLMOyalQB2unh
 qDk+ZuF+CAXtJ1N6KbA6NSkYTpw7p3k6OftCVMgQ9PttD/nuIa8Az5miuaFrv1bvSJ8L
 yEF2QurBzCEcEe/OKc531/yBmjiTPRnTE8SE8vf7tN6mZGl9sLV37oNQEAJNDnwRYTHc
 QzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774559146; x=1775163946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=drzSSQlOSjoFXZvAA8C13NBR1l8WjpxMK8cEocL7tFk=;
 b=I8lreW0MooP+niLBP+cElV8GdwX4J57KSgYVQbTZN3c0OYMJY1amS658iHgqxYN02L
 3grOl5Zrr18PhoS3vy+SUK0SzDvbVmZrfO7TyjK5qXqLoSVj/7zx1Jg08W+Bf45FMfXv
 zcipUl8qNF/EksGLqvxbUwuQdVq/W3jtvfO4T9Rg3o6UlAJhrmalfTepgevr/djcFOol
 c7oe2nFzzoOMAVYl+pJbkmLdEwIp6wmHtlWdtt48QWxNUQ2hxKpWNy0ViKik4M0oC/Bq
 AGF/0I5x5tJrpy/bHFpqLe28YS2JPbTrKXecPwoi4w9PDvc549x1HF+1EuRp/uW2DPKo
 Tllg==
X-Gm-Message-State: AOJu0Yzd1f8Te6bySNvFfc+syhL9BvyKygASXUhuSHaQj7RPsj6FON2H
 HW1No2QW895W3Gd2Npv41hc577J4CNNRS6rijI0qPTX3bJvHEi/prAJUsRMZzI2cijZHzdIksmq
 HcGEVtMI1W4EPmO4uTQtRf1Xdl0JxHgZfTxexma45MPNKMPVp6AyhY902Cy8kIc9hM7iqN3smll
 aS4F2Hju5HmJfFmDFFnS/YkiRZZBxx7TldKOGCKg==
X-Gm-Gg: ATEYQzyvJgfN/8jQfmf0nzhFHGYCDMXkjGTCnm/gXLdQqFYryWkfKRBgV8+DOdEy302
 74Jyjb9skkRfxgIppMwhJ0Gxdp/oizBuIv8B9tYHwEDKenqhuf01KkU0IzwFx2dtmrdH2RUEStx
 /lC+MHLT4hg2Sdr7/xThIrAIz0rPothfP+npQm3EQ/PcqMdSx3TaaskYyp3tLJEr3TshAuAXESP
 KN5+MPeeSpPQLqSyZDuQWWIr1rWjVeD6ghuV/wBGXizKE59qU+tTPhVJxKFOD96cGdBIzhwPOeV
 0wH8t0T+UQLv4iuAJakxnQqa9PWVl66rLixCymtvDfrIY1nqbxYZOv1fFi6pD+ZA274xj1aDhTv
 Afo5Fobwztfk=
X-Received: by 2002:a05:620a:46aa:b0:8cf:ed8d:20a3 with SMTP id
 af79cd13be357-8d0010f03a6mr1401551885a.42.1774559145591; 
 Thu, 26 Mar 2026 14:05:45 -0700 (PDT)
X-Received: by 2002:a05:620a:46aa:b0:8cf:ed8d:20a3 with SMTP id
 af79cd13be357-8d0010f03a6mr1401544585a.42.1774559144888; 
 Thu, 26 Mar 2026 14:05:44 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d00e4fa7d9sm353479785a.32.2026.03.26.14.05.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 14:05:44 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH RFC v2 07/11] vmstate: Allow vmstate_info_nullptr to emit
 non-NULL markers
Date: Thu, 26 Mar 2026 17:05:28 -0400
Message-ID: <20260326210532.379027-8-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260326210532.379027-1-peterx@redhat.com>
References: <20260326210532.379027-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/vmstate.h  |  9 +++++++--
 migration/vmstate-types.c    | 34 ++++++++++++++++------------------
 migration/vmstate.c          | 25 +++++++++++++------------
 scripts/analyze-migration.py | 22 ++++++++++++----------
 4 files changed, 48 insertions(+), 42 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 092e8f7e9a..2e51b5ea04 100644
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


