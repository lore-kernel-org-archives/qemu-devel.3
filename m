Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44789C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5zM-000728-PV; Thu, 20 Aug 2026 12:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5zJ-0006aQ-0r
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:51:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5zF-0005gW-V6
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:51:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F2guuM1wTp6iRTx0Z7TJIxxbr09Xo6dPOlmtCxIZch4=;
 b=JxHDwhi9tbUwFEnlExLXOg8Ve/QglcUnAAEDzQqHT0CS7PP6QE2GiF4pn/zoQwJkP3NqAQ
 Xb9/AGvXo2f99YXZObgUQXrF7i7RwwhCKitsc+SxYDyqFkIHFVWYkmDvVaiVJNl7Cd1kcp
 Tcq6VNFkJuaIFYeYpgpvU7d5LnqXfy4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-JjTLlr3-PFq4IoKAbIv6kA-1; Thu, 20 Aug 2026 12:51:26 -0400
X-MC-Unique: JjTLlr3-PFq4IoKAbIv6kA-1
X-Mimecast-MFC-AGG-ID: JjTLlr3-PFq4IoKAbIv6kA_1787244685
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49564d4b849so123935e9.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244685; x=1787849485; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=F2guuM1wTp6iRTx0Z7TJIxxbr09Xo6dPOlmtCxIZch4=;
 b=i/SwFbXUCU29XZuOIQgeeQSxhu633+94zRaJGdJ++f9MENDgcArWY9Kxhw0AFh5J12
 ifDMNdqX/11HJIguhZCASV0AvJQAbAX+2+kpt3URKT+zyZf2P6K4er857iVC2cXIxeOp
 z4jIB9OBxzFfyb2LjCnK2CzAWn54XmXMZ29UF3YIYnz2v/k9lO44H/xh5rsSqUP27lMS
 /KYWsqHEXrAEtjjSCWNmlOvAMMWD1SkpSmpHZUJjLqC7o4BVMGzefey90evAZuBk+QZU
 U/tK+b4nCgWzCsMO5VRdl4L/WjjZt1ovU4b6lsr7cH5f4+ArsYQygVnPUC+tsudBk5aK
 U9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244685; x=1787849485;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=F2guuM1wTp6iRTx0Z7TJIxxbr09Xo6dPOlmtCxIZch4=;
 b=JBs+4IAGhJp7wG+zSs8pR3akOuCtpXqv7S4rKkOq73EmTYW9qnjhcUA0giJfaJ770h
 9XqZlObcR43LefoZnMozuZ28U+NzS7t0kpO7a2obRiiiAgH/P0IrXca8uW5uYSZ1Xvhs
 pZRMFo4y2gOZpfYwMXqNpoAaZq/c+QsQtMdAdY3jwy8k4xfjFI0u5H112ftRy/o6rx0V
 QZXNoEsPJge5f80ugeEeGUABA0Alf8zF7l+fzvffTLZEnzbVKsMsUZYzAvEoEIvDQevF
 sIAjiSxZ7ccT482Z0e4kI1X/meXOXsuD9wG8CZH4kW+EgFi/0lPR4tmDscLDvpn4Bkxl
 wkaA==
X-Gm-Message-State: AOJu0YycN37kONDfO9DutMKkKyUCXHL88LgvCspBNgxO04OeunZnIrvP
 EM59jNzzFGROtZH0kevsyT92OzsKtlK1qLZC6RrpooozpnKDaQNgA6oOVrKPVFJj13kk0FX1oJO
 LZEmVqSbJ+y/OAu+WpMKo6nU4wBrP0ll3d8R3gJFrno7OjAisJC4lL+zOSiNHsW5JL+IU+3DbBk
 SMQkEpe35kEAKu8Ew2K6kBpKGuqtvMwb+pYmSGNO2S
X-Gm-Gg: AR+sD12YMmn7R9kWTc1aB6H73X8oKTPcfL+l/ZS6fw7ANT/aFRHpO2QhrD9KaIHq86Y
 DNAduuAdrIwayWcn/w+KYPi4AK0uGPKcrnD0pTbKKCgURXbjxfBCWm7NQxgQbzzj38Q8Hf/2P+j
 JXOkDXy9FK4Yv/q4SfKscuRvWtmuenTxNqum1+Rwzr/QL/OM8kOn0t50aBkpQhae3yFY4JKYuNX
 IV6sI2sTQFrJkP7e5RdJwEskcDZv1WNgLSVVAbav0uy79jh7clR0eS7VUBd0QCAfBK+Y+/hyo0G
 zpVlQeto5hkxcPiKlu9msHSn6VukA3uzzxTTwItdWONtwE3XQcSlbJffrUWKYuJowN+g6geLLR4
 enT+juK4w/yTRT3QOtL82b0xxN0ex5V93kWxwqXSpXcPUeiRlvdVOtjhsF9NYyQDnzqxWM+vTm5
 FrUPc=
X-Received: by 2002:a05:600c:4f87:b0:499:5a50:b022 with SMTP id
 5b1f17b1804b1-499b830d220mr3631685e9.3.1787244684581; 
 Thu, 20 Aug 2026 09:51:24 -0700 (PDT)
X-Received: by 2002:a05:600c:4f87:b0:499:5a50:b022 with SMTP id
 5b1f17b1804b1-499b830d220mr3630655e9.3.1787244684047; 
 Thu, 20 Aug 2026 09:51:24 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa0fda98sm235869655e9.1.2026.08.20.09.51.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:51:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Naveen N Rao (AMD)" <naveen@kernel.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 29/53] target/i386: SEV: Remove use of __func__
Date: Thu, 20 Aug 2026 18:49:32 +0200
Message-ID: <20260820164957.1895963-30-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164957.1895963-1-pbonzini@redhat.com>
References: <20260820164957.1895963-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: "Naveen N Rao (AMD)" <naveen@kernel.org>

Remove all usages of __func__ in target/i386/sev.c to align with the
general QEMU preference, and replace those with "SEV:" prefix.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/r/20260626070010.1955433-1-naveen@kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 155 +++++++++++++++++++++-------------------------
 1 file changed, 69 insertions(+), 86 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 8acbb01da22..4d875d10ff2 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -363,8 +363,8 @@ sev_ram_block_added(RAMBlockNotifier *n, void *host, size_t size,
     trace_kvm_memcrypt_register_region(host, max_size);
     r = kvm_vm_ioctl(kvm_state, KVM_MEMORY_ENCRYPT_REG_REGION, &range);
     if (r) {
-        error_report("%s: failed to register region (%p+%#zx) error '%s'",
-                     __func__, host, max_size, strerror(errno));
+        error_report("SEV: Failed to register region (%p+%#zx) error '%s'",
+                     host, max_size, strerror(errno));
         exit(1);
     }
 }
@@ -393,8 +393,8 @@ sev_ram_block_removed(RAMBlockNotifier *n, void *host, size_t size,
     trace_kvm_memcrypt_unregister_region(host, max_size);
     r = kvm_vm_ioctl(kvm_state, KVM_MEMORY_ENCRYPT_UNREG_REGION, &range);
     if (r) {
-        error_report("%s: failed to unregister region (%p+%#zx)",
-                     __func__, host, max_size);
+        error_report("SEV: Failed to unregister region (%p+%#zx)",
+                     host, max_size);
     }
 }
 
@@ -518,44 +518,39 @@ static int check_sev_features(SevCommonState *sev_common, uint64_t sev_features,
 {
     if (sev_features && !sev_es_enabled()) {
         error_setg(errp,
-                   "%s: SEV features require either SEV-ES or SEV-SNP to be enabled",
-                   __func__);
+                   "SEV: SEV features require either SEV-ES or SEV-SNP to be enabled");
         return -1;
     }
 
     if (sev_features & ~sev_common->supported_sev_features) {
         error_setg(errp,
-                   "%s: VMSA contains unsupported sev_features: %lX, "
+                   "SEV: VMSA contains unsupported sev_features: %lX, "
                    "supported features: %lX",
-                   __func__, sev_features, sev_common->supported_sev_features);
+                   sev_features, sev_common->supported_sev_features);
         return -1;
     }
 
     if (sev_snp_enabled()) {
         if (!(sev_features & SVM_SEV_FEAT_SNP_ACTIVE)) {
             error_setg(errp,
-                       "%s: SEV_SNP is enabled but is not enabled in VMSA sev_features",
-                       __func__);
+                       "SEV: SEV_SNP is enabled but is not enabled in VMSA sev_features");
             return -1;
         }
         if (SEV_SNP_GUEST(sev_common)->tsc_khz &&
             !(sev_features & SVM_SEV_FEAT_SECURE_TSC)) {
             error_setg(errp,
-                       "%s: TSC frequency can only be set if Secure TSC is enabled",
-                       __func__);
+                       "SEV: TSC frequency can only be set if Secure TSC is enabled");
             return -1;
         }
     } else {
         if (sev_features && sev_es_enabled()) {
             error_setg(errp,
-                       "%s: SEV features are not supported with SEV-ES at this time",
-                       __func__);
+                       "SEV: SEV features are not supported with SEV-ES at this time");
             return -1;
         }
         if (sev_features & SVM_SEV_FEAT_SNP_ACTIVE) {
             error_setg(errp,
-                       "%s: SEV_SNP is not enabled but is enabled in VMSA sev_features",
-                       __func__);
+                       "SEV: SEV_SNP is not enabled but is enabled in VMSA sev_features");
             return -1;
         }
     }
@@ -578,8 +573,8 @@ static int check_vmsa_supported(SevCommonState *sev_common, hwaddr gpa,
      */
     if (gpa != KVM_VMSA_GPA) {
         error_setg(errp,
-                "%s: The VMSA GPA must be %lX but is specified as %lX",
-                __func__, KVM_VMSA_GPA, gpa);
+                "SEV: The VMSA GPA must be %lX but is specified as %lX",
+                KVM_VMSA_GPA, gpa);
         return -1;
     }
 
@@ -634,11 +629,10 @@ static int check_vmsa_supported(SevCommonState *sev_common, hwaddr gpa,
 
     if (!buffer_is_zero(&vmsa_check, sizeof(vmsa_check))) {
         error_setg(errp,
-                "%s: The VMSA contains fields that are not "
+                "SEV: The VMSA contains fields that are not "
                 "synchronized with KVM. Continuing would result in "
                 "either unpredictable guest behavior, or a "
-                "mismatched launch measurement.",
-                __func__);
+                "mismatched launch measurement.");
         return -1;
     }
     return 0;
@@ -1115,8 +1109,8 @@ sev_snp_launch_start(SevCommonState *sev_common)
             rc = kvm_vm_ioctl(kvm_state, KVM_SET_TSC_KHZ, sev_snp_guest->tsc_khz);
         }
         if (rc < 0) {
-            error_report("%s: Unable to set Secure TSC frequency to %u kHz ret=%d",
-                         __func__, sev_snp_guest->tsc_khz, rc);
+            error_report("SEV: Unable to set Secure TSC frequency to %u kHz ret=%d",
+                         sev_snp_guest->tsc_khz, rc);
             return 1;
         }
     }
@@ -1124,8 +1118,8 @@ sev_snp_launch_start(SevCommonState *sev_common)
     rc = sev_ioctl(sev_common->sev_fd, KVM_SEV_SNP_LAUNCH_START,
                    start, &fw_error);
     if (rc < 0) {
-        error_report("%s: SNP_LAUNCH_START ret=%d fw_error=%d '%s'",
-                __func__, rc, fw_error, fw_error_to_str(fw_error));
+        error_report("SEV: SNP_LAUNCH_START ret=%d fw_error=%d '%s'",
+                     rc, fw_error, fw_error_to_str(fw_error));
         return 1;
     }
 
@@ -1167,8 +1161,8 @@ sev_launch_start(SevCommonState *sev_common)
     trace_kvm_sev_launch_start(start.policy, session, dh_cert);
     rc = sev_ioctl(sev_common->sev_fd, KVM_SEV_LAUNCH_START, &start, &fw_error);
     if (rc < 0) {
-        error_report("%s: LAUNCH_START ret=%d fw_error=%d '%s'",
-                __func__, ret, fw_error, fw_error_to_str(fw_error));
+        error_report("SEV: LAUNCH_START ret=%d fw_error=%d '%s'",
+                     ret, fw_error, fw_error_to_str(fw_error));
         goto out;
     }
 
@@ -1341,7 +1335,7 @@ static int sev_launch_update_data(SevCommonState *sev_common, hwaddr gpa,
     ret = sev_ioctl(sev_common->sev_fd, KVM_SEV_LAUNCH_UPDATE_DATA,
                     &update, &fw_error);
     if (ret) {
-        error_setg(errp, "%s: LAUNCH_UPDATE ret=%d fw_error=%d '%s'", __func__,
+        error_setg(errp, "SEV: LAUNCH_UPDATE ret=%d fw_error=%d '%s'",
                    ret, fw_error, fw_error_to_str(fw_error));
     }
 
@@ -1366,8 +1360,8 @@ sev_launch_update_vmsa(SevGuestState *sev_guest)
     ret = sev_ioctl(SEV_COMMON(sev_guest)->sev_fd, KVM_SEV_LAUNCH_UPDATE_VMSA,
                     NULL, &fw_error);
     if (ret) {
-        error_report("%s: LAUNCH_UPDATE_VMSA ret=%d fw_error=%d '%s'",
-                __func__, ret, fw_error, fw_error_to_str(fw_error));
+        error_report("SEV: LAUNCH_UPDATE_VMSA ret=%d fw_error=%d '%s'",
+                     ret, fw_error, fw_error_to_str(fw_error));
     }
 
     return ret;
@@ -1399,8 +1393,8 @@ sev_launch_get_measure(Notifier *notifier, void *unused)
     ret = sev_ioctl(sev_common->sev_fd, KVM_SEV_LAUNCH_MEASURE,
                     &measurement, &error);
     if (!measurement.len) {
-        error_report("%s: LAUNCH_MEASURE ret=%d fw_error=%d '%s'",
-                     __func__, ret, error, fw_error_to_str(errno));
+        error_report("SEV: LAUNCH_MEASURE ret=%d fw_error=%d '%s'",
+                     ret, error, fw_error_to_str(errno));
         return;
     }
 
@@ -1411,8 +1405,8 @@ sev_launch_get_measure(Notifier *notifier, void *unused)
     ret = sev_ioctl(sev_common->sev_fd, KVM_SEV_LAUNCH_MEASURE,
                     &measurement, &error);
     if (ret) {
-        error_report("%s: LAUNCH_MEASURE ret=%d fw_error=%d '%s'",
-                     __func__, ret, error, fw_error_to_str(errno));
+        error_report("SEV: LAUNCH_MEASURE ret=%d fw_error=%d '%s'",
+                     ret, error, fw_error_to_str(errno));
         return;
     }
 
@@ -1467,8 +1461,8 @@ sev_launch_finish(SevCommonState *sev_common)
     ret = sev_ioctl(sev_common->sev_fd, KVM_SEV_LAUNCH_FINISH, 0,
                     &error);
     if (ret) {
-        error_report("%s: LAUNCH_FINISH ret=%d fw_error=%d '%s'",
-                     __func__, ret, error, fw_error_to_str(error));
+        error_report("SEV: LAUNCH_FINISH ret=%d fw_error=%d '%s'",
+                     ret, error, fw_error_to_str(error));
         exit(1);
     }
 
@@ -1627,8 +1621,8 @@ snp_populate_metadata_pages(SevSnpGuestState *sev_snp,
 
         hva = gpa2hva(&mr, desc->base, desc->len, NULL);
         if (!hva) {
-            error_report("%s: Failed to get HVA for GPA 0x%x sz 0x%x",
-                         __func__, desc->base, desc->len);
+            error_report("SEV: Failed to get HVA for GPA 0x%x sz 0x%x",
+                         desc->base, desc->len);
             exit(1);
         }
 
@@ -1644,8 +1638,8 @@ snp_populate_metadata_pages(SevSnpGuestState *sev_snp,
         }
 
         if (ret) {
-            error_report("%s: Failed to add metadata page gpa 0x%x+%x type %d",
-                         __func__, desc->base, desc->len, desc->type);
+            error_report("SEV: Failed to add metadata page gpa 0x%x+%x type %d",
+                         desc->base, desc->len, desc->type);
             exit(1);
         }
     }
@@ -1674,7 +1668,7 @@ sev_snp_launch_finish(SevCommonState *sev_common)
          */
         metadata = pc_system_get_ovmf_sev_metadata_ptr();
         if (metadata == NULL) {
-            error_report("%s: Failed to locate SEV metadata header", __func__);
+            error_report("SEV: SNP_LAUNCH_FINISH failed to locate SEV metadata header");
             exit(1);
         }
 
@@ -1812,8 +1806,7 @@ static int sev_init_supported_features(ConfidentialGuestSupport *cgs,
         .addr = (unsigned long)&sev_common->supported_sev_features,
     };
     if (kvm_ioctl(kvm_state, KVM_GET_DEVICE_ATTR, &attr) < 0) {
-        error_setg(errp, "%s: failed to query supported sev_features",
-                   __func__);
+        error_setg(errp, "SEV: failed to query supported sev_features");
         return -1;
     }
     if (sev_snp_enabled()) {
@@ -1851,8 +1844,8 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
      * comparison against the host value accomplishes that.
      */
     if (host_cbitpos != sev_common->cbitpos) {
-        error_setg(errp, "%s: cbitpos check failed, host '%d' requested '%d'",
-                   __func__, host_cbitpos, sev_common->cbitpos);
+        error_setg(errp, "SEV: cbitpos check failed, host '%d' requested '%d'",
+                   host_cbitpos, sev_common->cbitpos);
         return -1;
     }
 
@@ -1863,9 +1856,9 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
      */
     if (sev_common->reduced_phys_bits < 1 ||
         sev_common->reduced_phys_bits > 63) {
-        error_setg(errp, "%s: reduced_phys_bits check failed,"
+        error_setg(errp, "SEV: reduced_phys_bits check failed,"
                    " it should be in the range of 1 to 63, requested '%d'",
-                   __func__, sev_common->reduced_phys_bits);
+                   sev_common->reduced_phys_bits);
         return -1;
     }
 
@@ -1881,8 +1874,8 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
     ret = sev_platform_ioctl(sev_common->sev_fd, SEV_PLATFORM_STATUS, &status,
                              &fw_error);
     if (ret) {
-        error_setg(errp, "%s: failed to get platform status ret=%d "
-                   "fw_error='%d: %s'", __func__, ret, fw_error,
+        error_setg(errp, "SEV: failed to get platform status ret=%d "
+                   "fw_error='%d: %s'", ret, fw_error,
                    fw_error_to_str(fw_error));
         return -1;
     }
@@ -1892,17 +1885,15 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 
     if (sev_es_enabled()) {
         if (!kvm_kernel_irqchip_allowed()) {
-            error_setg(errp, "%s: SEV-ES guests require in-kernel irqchip"
-                       "support", __func__);
+            error_setg(errp, "SEV: SEV-ES guests require in-kernel irqchip support");
             return -1;
         }
     }
 
     if (sev_es_enabled() && !sev_snp_enabled()) {
         if (!(status.flags & SEV_STATUS_FLAGS_CONFIG_ES)) {
-            error_setg(errp, "%s: guest policy requires SEV-ES, but "
-                         "host SEV-ES support unavailable",
-                         __func__);
+            error_setg(errp, "SEV: guest policy requires SEV-ES, but "
+                             "host SEV-ES support unavailable");
             return -1;
         }
     }
@@ -1949,8 +1940,7 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
              */
             if (sev_common->sev_features & ~SVM_SEV_FEAT_SNP_ACTIVE) {
                 error_setg(errp,
-                           "%s: SEV features can't be specified when using IGVM files",
-                           __func__);
+                           "SEV: SEV features can't be specified when using IGVM files");
                 return -1;
             }
             if (IGVM_CFG_GET_CLASS(x86machine->igvm)
@@ -1974,21 +1964,20 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
         break;
     }
     default:
-        error_setg(errp, "%s: host kernel does not support the requested SEV configuration.",
-                   __func__);
+        error_setg(errp, "SEV: host kernel does not support the requested SEV configuration.");
         return -1;
     }
 
     if (ret) {
-        error_setg(errp, "%s: failed to initialize ret=%d fw_error=%d '%s'",
-                   __func__, ret, fw_error, fw_error_to_str(fw_error));
+        error_setg(errp, "SEV: failed to initialize ret=%d fw_error=%d '%s'",
+                   ret, fw_error, fw_error_to_str(fw_error));
         return -1;
     }
 
     ret = klass->launch_start(sev_common);
 
     if (ret) {
-        error_setg(errp, "%s: failed to create encryption context", __func__);
+        error_setg(errp, "SEV: failed to create encryption context");
         return -1;
     }
 
@@ -2016,7 +2005,7 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
      */
     ret = ram_block_discard_disable(true);
     if (ret) {
-        error_setg(errp, "%s: cannot disable RAM discard", __func__);
+        error_setg(errp, "SEV: cannot disable RAM discard");
         return -1;
     }
 
@@ -2620,8 +2609,7 @@ static int cgs_set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
             const struct sev_es_save_area *sa =
                 (const struct sev_es_save_area *)ptr;
             if (len < sizeof(*sa)) {
-                error_setg(errp, "%s: invalid VMSA length encountered",
-                           __func__);
+                error_setg(errp, "SEV: invalid VMSA length encountered");
                 return -1;
             }
             sev_common->sev_features = sa->sev_features;
@@ -2630,8 +2618,8 @@ static int cgs_set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
     }
 
     if (!sev_enabled()) {
-        error_setg(errp, "%s: attempt to configure guest memory, but SEV "
-                     "is not enabled", __func__);
+        error_setg(errp, "SEV: attempt to configure guest memory, but SEV "
+                         "is not enabled");
         return -1;
     }
 
@@ -2643,9 +2631,8 @@ static int cgs_set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
     case CGS_PAGE_TYPE_VMSA:
         if (!sev_es_enabled()) {
             error_setg(errp,
-                       "%s: attempt to configure initial VMSA, but SEV-ES "
-                       "is not supported",
-                       __func__);
+                       "SEV: attempt to configure initial VMSA, but SEV-ES "
+                       "is not supported");
             return -1;
         }
         if (check_vmsa_supported(sev_common, gpa,
@@ -2666,9 +2653,8 @@ static int cgs_set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
     case CGS_PAGE_TYPE_SECRETS:
         if (!sev_snp_enabled()) {
             error_setg(errp,
-                       "%s: attempt to configure secrets page, but SEV-SNP "
-                       "is not supported",
-                       __func__);
+                       "SEV: attempt to configure secrets page, but SEV-SNP "
+                       "is not supported");
             return -1;
         }
         return snp_launch_update_data(gpa, ptr, len,
@@ -2678,8 +2664,8 @@ static int cgs_set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
         if (kvm_convert_memory(gpa, len, true) < 0) {
             error_setg(
                 errp,
-                "%s: failed to configure required memory. gpa: %lX, type: %d",
-                __func__, gpa, memory_type);
+                "SEV: failed to configure required memory. gpa: %lX, type: %d",
+                gpa, memory_type);
             return -1;
         }
         return 0;
@@ -2687,14 +2673,13 @@ static int cgs_set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
     case CGS_PAGE_TYPE_CPUID:
         if (!sev_snp_enabled()) {
             error_setg(errp,
-                       "%s: attempt to configure CPUID page, but SEV-SNP "
-                       "is not supported",
-                       __func__);
+                       "SEV: attempt to configure CPUID page, but SEV-SNP "
+                       "is not supported");
             return -1;
         }
         return snp_launch_update_cpuid(gpa, ptr, len, errp);
     }
-    error_setg(errp, "%s: failed to update guest. gpa: %lX, type: %d", __func__,
+    error_setg(errp, "SEV: failed to update guest. gpa: %lX, type: %d",
                gpa, memory_type);
     return -1;
 }
@@ -2750,8 +2735,8 @@ static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
     }
 
     if (policy_type != GUEST_POLICY_SEV) {
-        error_setg(errp, "%s: Invalid guest policy type provided for SEV: %d",
-        __func__, policy_type);
+        error_setg(errp, "SEV: Invalid guest policy type provided for SEV: %d",
+                   policy_type);
         return -1;
     }
     /*
@@ -2784,14 +2769,12 @@ static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
                 (struct sev_snp_id_authentication *)policy_data2;
 
             if (policy_data1_size != KVM_SEV_SNP_ID_BLOCK_SIZE) {
-                error_setg(errp, "%s: Invalid SEV-SNP ID block: incorrect size",
-                           __func__);
+                error_setg(errp, "SEV: Invalid SEV-SNP ID block: incorrect size");
                 return -1;
             }
             if (policy_data2_size != KVM_SEV_SNP_ID_AUTH_SIZE) {
                 error_setg(errp,
-                           "%s: Invalid SEV-SNP ID auth block: incorrect size",
-                           __func__);
+                           "SEV: Invalid SEV-SNP ID auth block: incorrect size");
                 return -1;
             }
             assert(policy_data1 != NULL);
@@ -2821,8 +2804,8 @@ static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
         SevGuestState *sev_guest = SEV_GUEST(MACHINE(qdev_get_machine())->cgs);
         /* Only the policy flags are supported for SEV and SEV-ES */
         if ((policy_data1_size > 0) || (policy_data2_size > 0) || !sev_guest) {
-            error_setg(errp, "%s: An ID block/ID auth block has been provided "
-                             "but SEV-SNP is not enabled", __func__);
+            error_setg(errp, "SEV: An ID block/ID auth block has been provided "
+                             "but SEV-SNP is not enabled");
             return -1;
         }
 
-- 
2.55.0


