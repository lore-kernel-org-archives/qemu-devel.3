Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A1EC54F54
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 19:28:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wonS4-0003B2-Sg; Tue, 28 Jul 2026 15:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wonS2-00038R-Ix
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:26:54 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wonS1-0001S3-01
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:26:54 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-38101f85591so1268786a91.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 12:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785266811; x=1785871611; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mFQLzsllffyN31O2DXNS30O6LLhjzrmI1+U27crjJrU=;
 b=UHvSYU7BGMdkvjItJpb/WE6VMxA9x79L4smxoMWRqWRdS7gGWcY1+isut44Is6hf/2
 vex/+1GNGHltvT2SdSR52AC8tUcVjY0HCow7F7pyOnrXYeetZ6Rke5/8H1qcP9n59rW9
 TTGlyJWjKyNUSxFiNOO9m/Fr4585ah+LaUTS+A/+SgKAHZp1eElBy0TXJhA3/ebN2FQ4
 8CmNWfe+XEh0XSTu12g8j6nhR4Lpr227ZnCsGtfIZ0u3GckvAMCGzGjmlJJzO0CMTm06
 qE+q9w10tGbCREpGd9HYgEj08Tz5EBDiRVwwE6yCaGMdSlQNp77/B6fT9oQ3eEnb68sb
 Jj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785266811; x=1785871611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mFQLzsllffyN31O2DXNS30O6LLhjzrmI1+U27crjJrU=;
 b=BUOGV2Z8kOXmwGm6R6OJdVC6iwwKX6Sk91Zk7820DwQBuaX81Gbe+1hGCOAqGzuxer
 j5HUK6/bNr7tmSsXAQXmnL/ZJjB75lR0CTvrdaYPzSOzsIA/vK/D2HEHpmKauaMzdQYr
 7S/arMGMoFYkDoQ1tFQHx1SoTVcooriA5QWntIFM6eG3ov8s44RphNmsTvcDeP9ozBlB
 v3LRwpYvmnMNj3olUOpfXjSxT2GZ8M9IAgWlGGzVKmDjG2g997WFiypbDRIzihCc5C17
 DEILNCpsim3UIWu749Juwam628QruebUX2A7oeLqNYf2itSw7LvXs3EDZSa4rJiLX3O6
 2BTA==
X-Gm-Message-State: AOJu0Yz6BR+yBcxpcQkq0I7cmaNn3T52Zny/jpTBezQcO2yZbeKY8iqu
 41okMy9IwEMGJRJUaAPR7HjW9Mc7whTW1HR2bct7GJV6dbtdbbqWGawWWXtshnisPWs=
X-Gm-Gg: AR+sD10VAsg7bv93gZaZAmddztRioPbm5nalz2Cr+paMIkH+1d7sc7vhVBFEWRBxpMj
 AgbDDknaDGoO5ztIFxcZR5VCGZ3HStCQ1fkQ8+I1C+ioQPEZKiOk/3gpsUPuwLW/FMO1nB/CyAa
 ZmTvUbOqNsBdUL+xzqD9yJdAMOXJ91JeV1W1a63WVfMvokc1gEJ09a0tRcjIpFXZEVHXqf5GXtE
 TF/W1fzLqDyL2+16ntsxAatmPZYT33lzNBN7VkwV594gjAn0b7G6rSe7U83O3uL3Duxhk1F1bww
 dWyuZpDVzbo4oknq4npSEWGQrQW27sUiMc+c4SIJx7cOPMbVgLC81FOKee28rwRxvxXdqh6GIvr
 pRhfSWk4VNhHh9oo8gFEornUDkaAolNbSh5DHbUCAL/yyu8NWDQdp4k6rU0mK+zCYgiAviVh0PE
 2aqkjTVTsKJWfhDmOE69GtgAn3EzCi
X-Received: by 2002:a17:90b:582d:b0:37d:a52a:ff12 with SMTP id
 98e67ed59e1d1-38f6a30c7ddmr3585247a91.10.1785266811540; 
 Tue, 28 Jul 2026 12:26:51 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:b9d1:87c9:a085:86c9])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f7f1353fdsm372650a91.8.2026.07.28.12.26.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 12:26:49 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v2 08/24] target/arm/kvm: Use kvm_vm_check_extension() where
 necessary
Date: Tue, 28 Jul 2026 13:26:14 -0600
Message-ID: <20260728192630.240375-9-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728192630.240375-1-mathieu.poirier@linaro.org>
References: <20260728192630.240375-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

The Arm KVM code can return different values from KVM_CHECK_EXTENSION
depending on the VM type. Use kvm_vm_check_extension() where necessary
to ensure we get the right response from KVM.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/kvm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index d86e66e056b9..ca25b707a0a8 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -331,7 +331,7 @@ static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
                              1 << KVM_ARM_VCPU_PTRAUTH_GENERIC);
     }
 
-    if (kvm_check_extension(kvm_state, KVM_CAP_ARM_PMU_V3)) {
+    if (kvm_vm_check_extension(kvm_state, KVM_CAP_ARM_PMU_V3)) {
         init.features[0] |= 1 << KVM_ARM_VCPU_PMU_V3;
         pmu_supported = true;
         features |= 1ULL << ARM_FEATURE_PMU;
@@ -636,7 +636,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         return -EINVAL;
     }
 
-    if (kvm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER)) {
+    if (kvm_vm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER)) {
         if (kvm_vm_enable_cap(s, KVM_CAP_ARM_NISV_TO_USER, 0)) {
             error_report("Failed to enable KVM_CAP_ARM_NISV_TO_USER cap");
         } else {
@@ -667,11 +667,11 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         }
     }
 
-    max_hw_wps = kvm_check_extension(s, KVM_CAP_GUEST_DEBUG_HW_WPS);
+    max_hw_wps = kvm_vm_check_extension(s, KVM_CAP_GUEST_DEBUG_HW_WPS);
     hw_watchpoints = g_array_sized_new(true, true,
                                        sizeof(HWWatchpoint), max_hw_wps);
 
-    max_hw_bps = kvm_check_extension(s, KVM_CAP_GUEST_DEBUG_HW_BPS);
+    max_hw_bps = kvm_vm_check_extension(s, KVM_CAP_GUEST_DEBUG_HW_BPS);
     hw_breakpoints = g_array_sized_new(true, true,
                                        sizeof(HWBreakpoint), max_hw_bps);
 
@@ -1913,7 +1913,7 @@ void kvm_arm_pvtime_init(ARMCPU *cpu, uint64_t ipa)
 
 void kvm_arm_steal_time_finalize(ARMCPU *cpu, Error **errp)
 {
-    bool has_steal_time = kvm_check_extension(kvm_state, KVM_CAP_STEAL_TIME);
+    bool has_steal_time = kvm_vm_check_extension(kvm_state, KVM_CAP_STEAL_TIME);
 
     if (cpu->kvm_steal_time == ON_OFF_AUTO_AUTO) {
         if (!has_steal_time || !arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
-- 
2.43.0


