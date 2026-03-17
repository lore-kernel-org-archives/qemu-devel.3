Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9432FF6E97
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 23:25:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2dlQ-0003yQ-Dt; Tue, 17 Mar 2026 19:23:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w2dlO-0003y4-OE
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 19:23:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w2dlN-0006Sy-0W
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 19:23:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773789828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vfA5YcifimYKy9d+Sw13K1+9EHiev9I6GS953l5fS1Y=;
 b=EFt8RCZzBO5KpkXr6TKNzKCUF5Pg5HKatSIKjuNOADoFzEen8Lg3Nf6jkQ71GrJ6TXkjh7
 oq97J0DmlxhOUwyk5mGt8KAmxsoTRQ02WMbO2ryxiqwujERS4k/Ps620xGcmuj6mQvkmUK
 5JmcCLvZ1YZHskykhHMkEqjoXLfj8+8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-Po7e13FrMxqPShKpMuDKFw-1; Tue, 17 Mar 2026 19:23:47 -0400
X-MC-Unique: Po7e13FrMxqPShKpMuDKFw-1
X-Mimecast-MFC-AGG-ID: Po7e13FrMxqPShKpMuDKFw_1773789827
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5092135f2e9so351827611cf.2
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 16:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773789826; x=1774394626; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vfA5YcifimYKy9d+Sw13K1+9EHiev9I6GS953l5fS1Y=;
 b=t3q/NDM2iG29iqSCJeY7vTlWm/B5xXwl0yCIiLuVRj72H14pkLlCSD8n5Q38E/fMvV
 S4iqNPNkbDhCtE6z6YCQhhFh7bVsAqABsgfXW24fasEibmKZrFl0pjl0xSb2vzubB7Sy
 QVUGNyR6p+7PpKXz3w682tRfXRgHB7Zo0P7QSINH8OdUWzjCzYBpJ8leG/MiV1fiYNrj
 P8pIknodgh03JXAA+BtNpWHSbfaqoyCyMAk1Yix6/a2InuuGnSOzMl4PfmYg2Vv1133N
 08yvcBy7Lh6c3H+AFv7mjNCggTo7rGmUr/ltzSFgLu1Up2XS/gPxjFdC89u8/+5qaln/
 Ddbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773789826; x=1774394626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vfA5YcifimYKy9d+Sw13K1+9EHiev9I6GS953l5fS1Y=;
 b=gguMc6Y12fSBPaBXN3FE+3vOc2gEKsf0Nk1gghM+NGXebIF3iXgRv4sAnbFzwc/V9W
 sPphtlalDW/AfCwvkxVWUaA6G7/QsP0gdKxnwoMJj4QW8guyH5bdu1Xk78+Le6+hv0Bh
 gTK/wcYP3rOtlFiacfhVcxC2+JVsFUVT1le2Ufhkbkwddvg9Dl4SyZBZnF2tzHy89B/a
 t0xrX1V3LevqwavWcgQkaRPvsYUnecWtqb23+Ap/twrat2wzVK4Xkhy4EX72PmxxH0j4
 uGctAADoJDkkUnCSb6VQ0d9cEmD4aY2egZrFPM5qu2rhDLU+TZByLXcPVKejeM9Scbci
 HUgg==
X-Gm-Message-State: AOJu0YwMBS7IENO4x+mw+0AcMMfiny8z9XePpVkZowQ8RMyhCt6pE2Zh
 qxUpXMBXbpMy7Y3o5rpaJ0TY9elPvDN9IL5QdGI7/7UZtdMpWuV53GPqlYBUrqEUQb1STBlLi7M
 iWqKYfu5U88NmUsR0h/IVpGsOiexbsTDhWHgli2aSIg+CW1/K82YcbBMMkTPsa86HhNQsIW4jEu
 X9pi/ZKl6N6MAyr0Jqcliq02stcdKmGj4z9f4ngg==
X-Gm-Gg: ATEYQzwI1aGVup5lLz/xukK/Dix5oVWRJT/N8Psy5CdeyuG8u+GbsHBTPwfLofq2QgA
 3l+EMBCJwLzsTj7fOGHZp0KOm92w0gfRU6QRKeLL19PMAEXeShay0L5BCh27m9ZATf7aGXhqJdB
 DrtMRlfCjjFLxD8yJ1Id3E3pHEekHGqnOVHY9aeINVsmAGO8Va7iuGBgyaT6fMZYRwTZ3mqE84z
 OuvDtmICC4BHX95NMNrdFf9RfISK4Kto+wS3iVKR0ox0yXqKCtelbt6IGP0fv8gPvlmRBlPxrLV
 yNsQdsKJCENoocSILyTb1wDXoUYeUa8IP6TAXe6CDvrDim8lrJy/4ksYC9dFuAIVsFy4cLUnhfk
 hcrg+4IZ/OHY53A==
X-Received: by 2002:ac8:7c4a:0:b0:4f1:adf6:5b77 with SMTP id
 d75a77b69052e-50b148c68d1mr14836241cf.59.1773789826306; 
 Tue, 17 Mar 2026 16:23:46 -0700 (PDT)
X-Received: by 2002:ac8:7c4a:0:b0:4f1:adf6:5b77 with SMTP id
 d75a77b69052e-50b148c68d1mr14835901cf.59.1773789825777; 
 Tue, 17 Mar 2026 16:23:45 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89c6b9ea39asm8203806d6.37.2026.03.17.16.23.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 16:23:45 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH RFC 07/10] vmstate: Allow vmstate_info_nullptr to emit
 non-NULL markers
Date: Tue, 17 Mar 2026 19:23:29 -0400
Message-ID: <20260317232332.15209-8-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260317232332.15209-1-peterx@redhat.com>
References: <20260317232332.15209-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

We used to have one vmstate called "nullptr" which is only used to generate
one-byte hint to say one pointer is NULL.

Let's extend its use so that it will generate another byte to say the
pointer is non-NULL.

With that, the name of the info struct (or functions) do not apply anymore.
Update correspondingly.

No functional change intended yet.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/vmstate.h |  9 +++++++--
 migration/vmstate-types.c   | 34 ++++++++++++++++------------------
 migration/vmstate.c         | 29 ++++++++++++++---------------
 3 files changed, 37 insertions(+), 35 deletions(-)

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
index 5a6b352764..a3a5f25946 100644
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
 
@@ -76,7 +76,7 @@ vmsd_create_fake_nullptr_field(const VMStateField *field)
 
     /* See vmstate_info_nullptr - use 1 byte to represent nullptr */
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
@@ -567,7 +567,7 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
             int i, n_elems = vmstate_n_elems(opaque, field);
             int size = vmstate_size(opaque, field);
             JSONWriter *vmdesc_loop = vmdesc;
-            bool is_prev_null = false;
+            bool use_marker_field_prev = false;
 
             trace_vmstate_save_state_loop(vmsd->name, field->name, n_elems);
             if (field->flags & VMS_POINTER) {
@@ -578,7 +578,7 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
             for (i = 0; i < n_elems; i++) {
                 void *curr_elem = first_elem + size * i;
                 const VMStateField *inner_field;
-                bool is_null;
+                bool use_marker_field;
                 int max_elems = n_elems - i;
 
                 if (field->flags & VMS_ARRAY_OF_POINTER) {
@@ -586,17 +586,16 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
                     curr_elem = *(void **)curr_elem;
                 }
 
-                if (!curr_elem && size) {
+                use_marker_field = !curr_elem && size;
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
@@ -612,16 +611,16 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
                  */
                 if (vmdesc && vmsd_can_compress(field) &&
                     (field->flags & VMS_ARRAY_OF_POINTER) &&
-                    is_null != is_prev_null) {
+                    use_marker_field != use_marker_field_prev) {
 
-                    is_prev_null = is_null;
+                    use_marker_field_prev = use_marker_field;
                     vmdesc_loop = vmdesc;
 
                     for (int j = i + 1; j < n_elems; j++) {
                         void *elem = *(void **)(first_elem + size * j);
-                        bool elem_is_null = !elem && size;
+                        bool elem_use_marker_field = !elem && size;
 
-                        if (is_null != elem_is_null) {
+                        if (use_marker_field != elem_use_marker_field) {
                             max_elems = j - i;
                             break;
                         }
@@ -633,7 +632,7 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
                                                     i, max_elems, errp);
 
                 /* If we used a fake temp field.. free it now */
-                if (is_null) {
+                if (use_marker_field) {
                     g_clear_pointer((gpointer *)&inner_field, g_free);
                 }
 
-- 
2.50.1


