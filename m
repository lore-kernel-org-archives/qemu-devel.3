Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3717CC9EC8D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:31:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfHuT-0004BC-5r; Mon, 12 Jan 2026 08:24:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHuG-0003PQ-MX
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:24:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHuC-0003pw-64
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:24:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768224263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UZjupKNTcRQ4mvrXCw54dQwnzt6+1apWExSeFIvKWxA=;
 b=cUwgn/K3tQZc5po2fSIJco/Ztk2QsB2Ua/zy7OM4NqMDG56OomJ1mSYmeuN/3JGDp6Lj7P
 cNQQrzCFmWvH8cbB4sW8MNlcaXLEgJrT7STXCKTHWNlEamViCPFhoCZTL8TzOTIJBJbRgw
 nU3g5UrP2n9jOIFozOkKosmeU5msML4=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-wrKA5dj7MSe0ZRyBy19qrg-1; Mon, 12 Jan 2026 08:24:21 -0500
X-MC-Unique: wrKA5dj7MSe0ZRyBy19qrg-1
X-Mimecast-MFC-AGG-ID: wrKA5dj7MSe0ZRyBy19qrg_1768224261
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c5539b9adbcso4785863a12.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 05:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768224261; x=1768829061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UZjupKNTcRQ4mvrXCw54dQwnzt6+1apWExSeFIvKWxA=;
 b=Le0fOqRZV/S5OriZ8+aZNZW6p2ItEiVCBjJ3kbzcR9DLhZUsi/lTsLHNCcfCPHSdON
 ClAkOZ2I0rYRWVlB38E6LMzv85kJQI/oDICwfWDke13YHXH4DxnZG1iIfmh6NHVGM9TN
 lqckvKfo0HwWe+XSsrghyhGYj26OYhDNkUIi4o+dhXRlq4r55vf/MZcm0/e7idu6iLgR
 qSJNrLbMpeMLk2vBf7OlH6SrQzXUwg3n7SuVCqyyHIy4LfJ+bwWAG5nQPuB7M/C+GRlp
 vLSxPG42CjIgxRUw5e3R5RnGSnkttNdkpUtUdGqcfgv64jwnzbF3mumzDixBTMwCYLBv
 htoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768224261; x=1768829061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UZjupKNTcRQ4mvrXCw54dQwnzt6+1apWExSeFIvKWxA=;
 b=Dsj5Uv+bb6RounEwohCBW1FOYWypP/y4i3RHS90lSVk8u8marKw6zE8Z7aqvbRqI/q
 Ya3Wm0y614uHfqMmTXc+XrFUKXPCSsRpRVS6Aubi/w7BUyTpW7mZVl6+ayHflAUXPeVy
 H6vPt3/8xueqdsexRUrmy/gZy2SnvZ3Zuk4vHtX/bDyxZEtiloZfnAqTva9+6+H3boWR
 pFSMmSiXvtHCfZ4YWTb+yJwAMJU0klDpiEEkhv3MjFXlCsrnqzcnlkDV9KyqcCBdFrLl
 jVIXPvMppY+6jMZSkTCxAt/Wi4FxTd3O5A+inOiHHIDE3bJPv3wnOZDnVsMdCzNbjmwu
 cuZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVunJv9PZWXLqSkiFpOUBRppWctMFd1gdVDobKCTLcnmciZ6UR22Ndxtp7sbvsnLksHv2PGXcHYUg8@nongnu.org
X-Gm-Message-State: AOJu0Yw+A6KFx1Dnlq1CAChe4iaQpU/8rTbzsT9qdg1iWVczW56kHdm2
 tPwfD8mdfyO2c+qkM1yDDU6HxiWHhCswB7ZdhO5S18k0GfZDcIt9PThD66/8j3ugQDpV664NLw3
 /22v0WQf0rO0EYVy/C+2PlwccNMCmXNHMagwBtUzsUmctfYBGIyxanEe4
X-Gm-Gg: AY/fxX7wobp7ZJ0+IwHZJGYjpmEGpkugmTMdJKq29Fi4mE/+SZHk2TVqKxSJTdwuiN6
 retRgPZGIzA7sF1zj9YaZtEwFo7Q1vqiWAwhqCkWduph0g6kb9nlxmtoSzHnBx8uecvevIjD1pK
 JeQnU+wIeep03yUD/r7JIZZEPPqlMxLII7KYNHVBF+d1FCuT6rbXr5rnIWuYMjuD2FyYTJJUQhr
 RTHolRA4S0hj8IF9PqRn8aTLrvV6hdv4Vq748wC/JCpoICeMn4HWEtl9Sf83gGg4z1eV1+dYhte
 eshmkJ2Gi4KbTHF8a277I2aAvZjqXW58bC8uEQPPurJjzG8fLJzjrFBq15tgEpmeXsnqZwpidlT
 KchL7W/wbHbj3ksFlo2C2q5naklCMN0OqGWrAyES4rp0=
X-Received: by 2002:a05:6a20:3ca3:b0:366:23a6:c962 with SMTP id
 adf61e73a8af0-3898f91d1efmr17834723637.29.1768224260816; 
 Mon, 12 Jan 2026 05:24:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGz1IkZ96oXJFBb8G5LoyDpm7qWMw8Wh30UfPa7yjwgIeLGzgyc1L8pL8jObYETbVCv8P8FMg==
X-Received: by 2002:a05:6a20:3ca3:b0:366:23a6:c962 with SMTP id
 adf61e73a8af0-3898f91d1efmr17834709637.29.1768224260414; 
 Mon, 12 Jan 2026 05:24:20 -0800 (PST)
Received: from rhel9-box.lan ([110.227.88.119])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd87asm17544771a12.15.2026.01.12.05.24.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 05:24:20 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Ani Sinha <anisinha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 21/32] kvm/i8254: refactor pit initialization into a helper
Date: Mon, 12 Jan 2026 18:52:34 +0530
Message-ID: <20260112132259.76855-22-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260112132259.76855-1-anisinha@redhat.com>
References: <20260112132259.76855-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The initialization code will be used again by VM file descriptor change
notifier callback in a subsequent change. So refactor common code into a new
helper function.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/i386/kvm/i8254.c | 68 +++++++++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 30 deletions(-)

diff --git a/hw/i386/kvm/i8254.c b/hw/i386/kvm/i8254.c
index 81e742f866..255047458a 100644
--- a/hw/i386/kvm/i8254.c
+++ b/hw/i386/kvm/i8254.c
@@ -60,6 +60,43 @@ struct KVMPITClass {
     DeviceRealize parent_realize;
 };
 
+static void do_pit_initialize(KVMPITState *s, Error **errp)
+{
+    struct kvm_pit_config config = {
+        .flags = 0,
+    };
+    int ret;
+
+    ret = kvm_vm_ioctl(kvm_state, KVM_CREATE_PIT2, &config);
+    if (ret < 0) {
+        error_setg(errp, "Create kernel PIC irqchip failed: %s",
+                   strerror(-ret));
+        return;
+    }
+    switch (s->lost_tick_policy) {
+    case LOST_TICK_POLICY_DELAY:
+        break; /* enabled by default */
+    case LOST_TICK_POLICY_DISCARD:
+        if (kvm_check_extension(kvm_state, KVM_CAP_REINJECT_CONTROL)) {
+            struct kvm_reinject_control control = { .pit_reinject = 0 };
+
+            ret = kvm_vm_ioctl(kvm_state, KVM_REINJECT_CONTROL, &control);
+            if (ret < 0) {
+                error_setg(errp,
+                           "Can't disable in-kernel PIT reinjection: %s",
+                           strerror(-ret));
+                return;
+            }
+        }
+        break;
+    default:
+        error_setg(errp, "Lost tick policy not supported.");
+        return;
+    }
+
+    return;
+}
+
 static void kvm_pit_update_clock_offset(KVMPITState *s)
 {
     int64_t offset, clock_offset;
@@ -241,42 +278,13 @@ static void kvm_pit_realizefn(DeviceState *dev, Error **errp)
     PITCommonState *pit = PIT_COMMON(dev);
     KVMPITClass *kpc = KVM_PIT_GET_CLASS(dev);
     KVMPITState *s = KVM_PIT(pit);
-    struct kvm_pit_config config = {
-        .flags = 0,
-    };
-    int ret;
 
     if (!kvm_check_extension(kvm_state, KVM_CAP_PIT_STATE2) ||
         !kvm_check_extension(kvm_state, KVM_CAP_PIT2)) {
         error_setg(errp, "In-kernel PIT not available");
     }
 
-    ret = kvm_vm_ioctl(kvm_state, KVM_CREATE_PIT2, &config);
-    if (ret < 0) {
-        error_setg(errp, "Create kernel PIC irqchip failed: %s",
-                   strerror(-ret));
-        return;
-    }
-    switch (s->lost_tick_policy) {
-    case LOST_TICK_POLICY_DELAY:
-        break; /* enabled by default */
-    case LOST_TICK_POLICY_DISCARD:
-        if (kvm_check_extension(kvm_state, KVM_CAP_REINJECT_CONTROL)) {
-            struct kvm_reinject_control control = { .pit_reinject = 0 };
-
-            ret = kvm_vm_ioctl(kvm_state, KVM_REINJECT_CONTROL, &control);
-            if (ret < 0) {
-                error_setg(errp,
-                           "Can't disable in-kernel PIT reinjection: %s",
-                           strerror(-ret));
-                return;
-            }
-        }
-        break;
-    default:
-        error_setg(errp, "Lost tick policy not supported.");
-        return;
-    }
+    do_pit_initialize(s, errp);
 
     memory_region_init_io(&pit->ioports, OBJECT(dev), NULL, NULL, "kvm-pit", 4);
 
-- 
2.42.0


