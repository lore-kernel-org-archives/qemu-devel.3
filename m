Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1917DEDF04B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 06:29:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqQAl-0000aL-Ku; Thu, 12 Feb 2026 01:27:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQAJ-0000DF-3p
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:27:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQAH-0005L2-Ge
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:27:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770877620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UZjupKNTcRQ4mvrXCw54dQwnzt6+1apWExSeFIvKWxA=;
 b=E00qI7/xJTtascKmyzCFBaBkMvpssx986fI85uKZliYzrd0U6hYEKaONMHUvpAZxxq9f0k
 XSg5SVPCxFm0BBr7m1ZsIZM9sdxcLI++fVZlECNgwmx6Jq87QHd4OOLex60bNISu9sdqQd
 vhtZ3hEE1p3D7pl+ny77E3K3k3L1czw=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-Vk9jKtBYPpK3MpMctRupRQ-1; Thu, 12 Feb 2026 01:26:59 -0500
X-MC-Unique: Vk9jKtBYPpK3MpMctRupRQ-1
X-Mimecast-MFC-AGG-ID: Vk9jKtBYPpK3MpMctRupRQ_1770877618
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c6de2c762aaso7163339a12.3
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 22:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770877618; x=1771482418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UZjupKNTcRQ4mvrXCw54dQwnzt6+1apWExSeFIvKWxA=;
 b=oFKxr40o7hbCh8RBA/iyGRHpymxTLoBJX/mSQWTG5NLY1NVeSexLTNmasjUxqNgn9v
 X0quYhi1Qu1e/C4M1AFCvAPhSpemrh5dzEgHmVbcNfTJBwhuduMEhMkuEP1RzfjoSggI
 UIRmrDcVbqBcqp3pg6OhR2FbVbjn2Vm7h9Ah66XEVqWAbPrXwXXIRdO1lvmKS1iKWJkt
 TAIus2QpIYU3lZXqRmpDh/s/58VtmXG686TpveDjzSoa5N6c7hpcHspKu9UVeKDIU71k
 negrqWqcAieHiIQgOQFn1rvxwA5TpR7ejzkAZmrayadJc30zaJj2yF3lMhsLSF7f0X5K
 4DqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770877618; x=1771482418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UZjupKNTcRQ4mvrXCw54dQwnzt6+1apWExSeFIvKWxA=;
 b=RcXDsK7ra9MjlodJ/mjg5/4Eqz+TcLLMcYFqR/r7gKMVMr9fXqvGEeYD2QDKNKXkYO
 ZhRhCm0byqrvBQnXfMCJUf+NUjckLigMIJZdyBpBi1R95TEfbF6tUg4UD/z9ycmrw1DC
 gYpNBUsDmvIIqwwkl55l7szMBUhpztnxmhJMrHouufnEuy4mXsSIYjxXXMwijYfGTnsh
 aSMgbwbOLefenRk6M/AZI1MVfLQsu8R/qVgleUyAvcjRSfWyfzFUaVDfm5k6BZw6HIol
 Cu0/oV0ScKoD2pSht3CQ3rGyTtL6YkSK7/EyrNnxTJ1GMQMEGu4AgZE4teg1PTHHSUfQ
 PK5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbwYZdVGD1R7uW621/1olPJEk4zWRYlulDmW3BCxIVdbHyaBkALES8XMxnpo0u5iYB2F4XjyPyzSv1@nongnu.org
X-Gm-Message-State: AOJu0Yz72FgsDN1yxWVgiyJGCyeSohKW00Qp8JXsmNrlbtvTlQiEAvDB
 0PQhqt1LAiP5p2BJdwl9h7EGLWloiSbsSVqMIfqHXnPB0iBXROii4bvDY23HHWOn7QORNUOA/bn
 8d5ntOyk0+Q3l7KZ85lW4gJNXcLBQS4hVuNFIK4yAPZH+WYuzsjoNfHyn
X-Gm-Gg: AZuq6aKKd+L0W6BlGGpvHKfbC9eBy1Z1I2NNxdSrbYbaWc3POfO6HMz/ucxQpIAvsXj
 wvWPMHFgZRZIA1wI7gieJXYZ/1wiOFlnty+ihXUnLAqyThIPFnL3vBued/mEwdz9p7snJLYSrES
 +UKsdZZeq/hyzu5mhiJ8WZymqcdQffbjN0wJz44PLvPn10gEO0HCbDqPvTxRbZsSO9kdqgP97jq
 zC3kMM2bZg1UDs1I93SgkXglPIbQ1dkxikZgTYSwnlW2ozhDVqIlsAPSUgmnmUwDAe8qD6Ek0O/
 n+mqHOwKj2dnfqOG5D0h/YU67mPqg31mruptgAbLbI8fjR2X2KND+f4PWusikcgq5rV4C8pcS76
 ClyJQjAlI8C2nIWUfwpKUPoo9NuvJFV5hNR0pg2CeKsxfaG5TPoelUG0=
X-Received: by 2002:a05:6a21:9d83:b0:393:39a0:f1e5 with SMTP id
 adf61e73a8af0-39448833aecmr1749573637.48.1770877617872; 
 Wed, 11 Feb 2026 22:26:57 -0800 (PST)
X-Received: by 2002:a05:6a21:9d83:b0:393:39a0:f1e5 with SMTP id
 adf61e73a8af0-39448833aecmr1749052637.48.1770877604107; 
 Wed, 11 Feb 2026 22:26:44 -0800 (PST)
Received: from rhel9-box.lan ([122.164.27.113])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3567e7d95d8sm4894122a91.2.2026.02.11.22.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 22:26:43 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH v4 22/31] kvm/i8254: refactor pit initialization into a helper
Date: Thu, 12 Feb 2026 11:55:06 +0530
Message-ID: <20260212062522.99565-23-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260212062522.99565-1-anisinha@redhat.com>
References: <20260212062522.99565-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


