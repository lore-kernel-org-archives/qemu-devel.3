Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F0F3C54F56
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wok7A-0002cY-3J; Tue, 28 Jul 2026 11:53:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wok78-0002bl-QQ
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:53:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wok76-0005dN-JB
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785253983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BKwNCkad/nDAoxO3VtxghR8FEOqxqC88f/O9yJcu0uI=;
 b=B37QSVJ73bJ2KC5lLmYSLCV2cCvm1WiiWMV+wMbSUraa132M58To85jQJfeJ6d+MqGpn5t
 ULGagBC4QZ/Zx8KEgz0+qCiWV9gFfwUcacNi7vNMz+MInZ2C7Kah+JNBp7YW/Dx+ZQTzmA
 MkBZvdA0THw2iZJLO298vkO7DlPaQ0k=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-e4Eu831-Meqj6ZfVO3S_WA-1; Tue, 28 Jul 2026 11:53:01 -0400
X-MC-Unique: e4Eu831-Meqj6ZfVO3S_WA-1
X-Mimecast-MFC-AGG-ID: e4Eu831-Meqj6ZfVO3S_WA_1785253981
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51bff5c7035so85504421cf.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785253981; x=1785858781; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BKwNCkad/nDAoxO3VtxghR8FEOqxqC88f/O9yJcu0uI=;
 b=XpqC07RfDwoDuqzLnnlHuos07Kv29VVHzkBcfqqZure39khtiUfd99PhUUUR646Kfv
 OA1WkS2/zIKAOQDZAPjnGbGfJM0INFJ7pW9bEoZrUdmv32axXPfzUaNHMsZ9zjcenOOk
 YbsAtIWGfKfOxAtafeRPAeU8Naj4r4w/cqDdDs9b5FLk4lOuHJwBKtUPwhfnIxv7oizj
 LZjaNmshwHroqQlwNyvz0bWRbu25rhyGaTzSCMo5jALAuznItCN4hcLxUNA3abbkAUlT
 9qPd0sR+ytG9CIoFalNZ1+yn9qIMRQ1H0uAv0VYWnnbnlXVNGlMR2QoN0yXtKUNUgKbu
 RmBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785253981; x=1785858781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BKwNCkad/nDAoxO3VtxghR8FEOqxqC88f/O9yJcu0uI=;
 b=sU2Cm4RBzxQZiDunDEG0qM9fFLRY75fqnuSfnF+UWc1XNP4uUZtA2K0A8VhXZMlpwk
 BzKCnT1q5qa0eTwIOCEA1ER8S1i5XZhh2OfMcQITB8JMHcXBv8hUDHeHGSvimp2fx22r
 Z1M/WVZNSBjZbgQksJmLAVoXPCbcXG+zDvxmCeGITbqwpZr9RRAgkit6dA2HVcg8mEtz
 3YMlwD1PO58XK+AmarAZOwtzOgNT9CcIF9GqpA06Oxt3EtJklSx+ejmB96ccyr9js4DV
 OjXb32EC+14aZ7VKsuHs8/LVnMMV8Tl+bockht4WbLCly3cIJHzBzVZm8a+ZDNYEAlVZ
 ylPw==
X-Gm-Message-State: AOJu0Yy5tFwK5egWn8Pjbia/Y5+WA2KSmxsMzUKomycrhMumLt10KscB
 Q2YjizXc+QrK9F3axduCFXbD1GN8rXfC1iHGKzGAHrW/nms9nSDx04dRCcxTMRMyccKEsZPwSph
 crSkCH1pvA/VQIMvhbJVhrQOwFZeQ4PUsZLPL5E5+iAIWdydTrBIetxObYiKUFDHNtDJe128ou+
 ewBhVN+GwyS5hBJCrNtL77wPNdu/k0PQ4Pfpkm2A==
X-Gm-Gg: AR+sD10ijNy9zKoA98Gpk689rapaOIMqeE/Vzky6p0FVe/wbbpC7F2iyeVbN0PI/YhZ
 qRQg3llFjzPdxPXvOXg25U8FkzJKLyVvII8XMqR/09e2xO+n46B8a/utoCB5cEA8wZ2pTg6KwNm
 YwU1yv0aSLNcDIOxXcmUzQBBzRk3LDEHWZ4rhZvJDMVFFxd3+C0MedlrkQf6hgFXk/rf22X/1MD
 Rehz+RBzk314XJRZy6vThdpRWvgBWTlFHsCr9wBE2nBXlV91l0rPoWXnilMSQY2srjDGORKvSlx
 PhwBqfvW+tabhXnzy3nuI0qy3f4O29lek+paa39SNpmgLxNn9Htx1Ykr5LyxA8AJeg==
X-Received: by 2002:a05:622a:111:b0:51c:1811:6eae with SMTP id
 d75a77b69052e-529d70eb754mr26494701cf.47.1785253980840; 
 Tue, 28 Jul 2026 08:53:00 -0700 (PDT)
X-Received: by 2002:a05:622a:111:b0:51c:1811:6eae with SMTP id
 d75a77b69052e-529d70eb754mr26494471cf.47.1785253980342; 
 Tue, 28 Jul 2026 08:53:00 -0700 (PDT)
Received: from x1.com ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-529e2dd54dbsm492481cf.23.2026.07.28.08.52.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 08:52:59 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>, Feifan Qian <bea1e@proton.me>,
 qemu-stable <qemu-stable@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 1/5] migration: Fix possible overflow in vmstate_handle_alloc()
Date: Tue, 28 Jul 2026 11:52:43 -0400
Message-ID: <20260728155247.1894355-2-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260728155247.1894355-1-peterx@redhat.com>
References: <20260728155247.1894355-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Migration incoming side almost always trusted the stream data and allows
allocation to happen with whatever size received.  With it, malicious
migration stream can manipulate destination QEMU behavior on g_malloc(), in
path of vmstate_handle_alloc() on specific VMSD fields.  Fix it by limiting
all sizes with int32_t positive values (INT_MAX) explicitly.

We have quite a few bug reports recently leveraging this defect. It can be
reproduced in many ways for (I think) all archs binaries, but the simplest
reproducer is:

  $ hexdump -C ./vm.img
  00000000  51 45 56 4d 00 00 00 03  07 80 00 00 00 00 00 00  |QEVM............|

  $ ./qemu-system-x86_64 -incoming file:./vm.img
  VNC server running on ::1:5900
  qemu-system-x86_64: GLib: ../glib/gmem.c:106: failed to allocate 18446744071562067968 bytes
  Aborted                    (core dumped) ./qemu-system-x86_64 -incoming file:./vm.img

We could assert here, but since we have errp right above the stack this
patch routes the errp over to allow destination QEMU fail gracefully.  This
means there's no way to DoS coredumpctl as well because we don't generate
core dumps at all. The output message could also hopefully help triage
issues when it's not a malicious stream but only wrong image used.

When at this, making sure multiplex also won't overflow.

After patched:

  $ ./qemu-system-x86_64 -incoming file:./vm.img
  VNC server running on ::1:5900
  qemu-system-x86_64: load of migration failed: Invalid argument: vmstate_size: VMState field 'name' overflow

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3805
Reported-by: Feifan Qian <bea1e@proton.me>
Reported-by: dong ling (@dongling226655)
Cc: qemu-stable <qemu-stable@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/vmstate.c | 91 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 77 insertions(+), 14 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 50ebe37845..7bf0c2bae5 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -78,9 +78,10 @@ vmsd_init_ptr_marker_field(VMStateField *fake, const VMStateField *field)
     };
 }
 
-static int vmstate_n_elems(void *opaque, const VMStateField *field)
+static int32_t vmstate_n_elems(void *opaque, const VMStateField *field,
+                               Error **errp)
 {
-    int n_elems = 1;
+    int32_t n_elems = 1;
 
     if (field->flags & VMS_ARRAY) {
         n_elems = field->num;
@@ -94,18 +95,35 @@ static int vmstate_n_elems(void *opaque, const VMStateField *field)
         n_elems = *(uint8_t *)(opaque + field->num_offset);
     }
 
+    if (n_elems < 0) {
+        error_setg(errp, "%s: VMState field '%s' num_offset overflow",
+                   __func__, field->name);
+        return -EINVAL;
+    }
+
     trace_vmstate_n_elems(field->name, n_elems);
+
     return n_elems;
 }
 
-static int vmstate_size(void *opaque, const VMStateField *field)
+static int32_t vmstate_size(void *opaque, const VMStateField *field,
+                            Error **errp)
 {
-    int size;
+    int32_t size;
 
     if (field->flags & VMS_VBUFFER) {
+        /* For both int32_t/uint32_t we only allow 2GB limit for VBUFFER */
         size = *(int32_t *)(opaque + field->size_offset);
+
+        /* Check this explicitly for untrusted length input first */
+        if (size < 0) {
+            goto overflow;
+        }
+
         if (field->flags & VMS_MULTIPLY) {
-            size *= field->size;
+            if (smul32_overflow(field->size, size, &size)) {
+                goto overflow;
+            }
         }
     } else if (field->flags & VMS_ARRAY_OF_POINTER) {
         /*
@@ -115,21 +133,45 @@ static int vmstate_size(void *opaque, const VMStateField *field)
         size = sizeof(void *);
     } else {
         size = field->size;
+        assert(size >= 0);
     }
 
     return size;
+
+overflow:
+    error_setg(errp, "%s: VMState field '%s' overflow",
+               __func__, field->name);
+    return -EINVAL;
 }
 
-static void vmstate_handle_alloc(void *ptr, const VMStateField *field,
-                                 void *opaque)
+static bool vmstate_handle_alloc(void *ptr, const VMStateField *field,
+                                 void *opaque, Error **errp)
 {
     if (field->flags & VMS_POINTER && field->flags & VMS_ALLOC) {
-        gsize size = vmstate_size(opaque, field);
-        size *= vmstate_n_elems(opaque, field);
+        int32_t size, n;
+
+        size = vmstate_size(opaque, field, errp);
+        if (size < 0) {
+            return false;
+        }
+
+        n = vmstate_n_elems(opaque, field, errp);
+        if (n < 0) {
+            return false;
+        }
+
+        if (smul32_overflow(size, n, &size)) {
+            error_setg(errp, "%s: VMState field '%s' multiply overflow",
+                       __func__, field->name);
+            return false;
+        }
+
         if (size) {
             *(void **)ptr = g_malloc(size);
         }
     }
+
+    return true;
 }
 
 static bool vmstate_ptr_marker_load(QEMUFile *f, bool *load_field,
@@ -335,10 +377,22 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
 
         if (exists) {
             void *first_elem = opaque + field->offset;
-            int i, n_elems = vmstate_n_elems(opaque, field);
-            int size = vmstate_size(opaque, field);
+            int i, n_elems = vmstate_n_elems(opaque, field, errp);
+            int size;
+
+            if (n_elems < 0) {
+                return false;
+            }
+
+            size = vmstate_size(opaque, field, errp);
+            if (size < 0) {
+                return false;
+            }
+
+            if (!vmstate_handle_alloc(first_elem, field, opaque, errp)) {
+                return false;
+            }
 
-            vmstate_handle_alloc(first_elem, field, opaque);
             if (field->flags & VMS_POINTER) {
                 first_elem = *(void **)first_elem;
                 assert(first_elem || !n_elems || !size);
@@ -650,8 +704,7 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
     while (field->name) {
         if (vmstate_field_exists(vmsd, field, opaque, version_id)) {
             void *first_elem = opaque + field->offset;
-            int i, n_elems = vmstate_n_elems(opaque, field);
-            int size = vmstate_size(opaque, field);
+            int i, n_elems = vmstate_n_elems(opaque, field, errp);
             JSONWriter *vmdesc_loop = vmdesc;
             bool is_prev_null = false;
             /*
@@ -660,6 +713,16 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
              */
             bool use_dynamic_array =
                 field->flags & VMS_ARRAY_OF_POINTER_AUTO_ALLOC;
+            int32_t size;
+
+            if (n_elems < 0) {
+                return false;
+            }
+
+            size = vmstate_size(opaque, field, errp);
+            if (size < 0) {
+                return false;
+            }
 
             trace_vmstate_save_state_loop(vmsd->name, field->name, n_elems);
             if (field->flags & VMS_POINTER) {
-- 
2.54.0


