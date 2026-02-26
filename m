Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B932FD8FC3
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 15:56:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvdid-0005Qj-1l; Thu, 26 Feb 2026 10:56:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvdiW-0005P3-Jn
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:55:56 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvdiU-0003nT-VB
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:55:56 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-4327790c4e9so710905f8f.2
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 07:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772121353; x=1772726153; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FI7VceYabQwG5X9MORzw6EbePsfkC196o16V3Go1/SI=;
 b=r4kmR11xs68kC7K27XFHqCujjiSze9A3fby81ZlY8aVNCGF+cXfOXzRJs01oxEqHTM
 7OrSvratjdVEveq1Y8PSpm9ba9hOWdophSUNxoRRO+9p/XzBXTwK+Exc0BDvODvuCYVg
 1/ogwl6deK70AsL46uE213KTmf5toYvN27vfsWlchU1FfBOkeXQJB3qRBB6RPy+M/1dB
 2LjnwlsGCzf9fan2cJQesJnaD20oCYzBGbmV25eQXzwwbBMeg9vAqmZuypHMTo4nDK7G
 gFchRHdjovfdu6MUmYLAGeqfUpAV2wsPh3CDWfJOVRjN8xBblRMU/IJVCZ6QT/0sn2nF
 hNwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772121353; x=1772726153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FI7VceYabQwG5X9MORzw6EbePsfkC196o16V3Go1/SI=;
 b=SZ2wtqhIXHir7QZL49L76vjwpiDQGvUO+oeafZJ40xcefxKu2HaKkDQeoB9cZr2JUV
 8CFgcokIsFR+JU67o8A3IzPutQieTp2ufLEB8whHNfAlziBZBWAlK1xIU3/FpuOtuA+F
 scPoGtPNvnZtOv7f+aCdD0JrdawVKYR3syDvxUf2mEpXqWj21ZDa3/98F6WGxooLC06J
 k5iEu9zLLTarMODLdizAaBPJTd3IA+v6+4rNTlCb4D+82R54VMd0dRAzcOlBsw0Ff1eM
 ElWRthLfd8dWLjftM6E8vWtNDmMvpJvZDkO5I6avjQWm632OVdy2/06KQmZoWiUDGEvr
 /g3w==
X-Gm-Message-State: AOJu0YzKY0kEC+VnIXMjplR22e0iFpkfuVOGSYNLMfHhFWQHEyOM7PKf
 c04Y7E7QAMIWopme5fHkS8Ctb9oWPqH7mnI62H+tMNrvKgEocix/3uTwpbWdidSd5MQI9Ih3De/
 hMsjV
X-Gm-Gg: ATEYQzzQXTWJDEPAjWV69enJFsONcGuAL21a8WJXR41lkjs9dWpQdpSEVY3e+Fk7Yxw
 kArZ9Wsqb63wIeWP6Q49lAJhADb2N327//lcD8DKH6/kQPOIzRml5b8IonXJ7DxDAhvsAOeMuWN
 tBIa+/03Z3m6/ppJOI8IYpLxC37ouarnFl+njTy4x80u+EGMR6L0JNBXiJ+q5TsTCTtUto8af/o
 0PlBuEc/bSI1mhXFuoDNul9WoVbGfgJLKJHY4rAyZA2/gS1DZDhAfg6QOgWtct0Hu11V5x6Cwgw
 9giWsTkMh1x/prVdjmq0pie8314FCtlDnzDUfyVnehvtX1XEyry3o8EXz3vCiDhcLqxtgSjBrC+
 rSfiBv5oxwCIp3N0sV5AVL/TbWC8M2OL9CRfDmk3aMiGbiyzrLiMz7qNLorV8+ISk6SxQ9llgpn
 1F45t91iEHU9l2chh1q5PdSNHUEYLzsWvzCVZzL/QWCBogWZNSwFIkuuDoVE+0A/goLB2pxPVMv
 k88Qm0tbUKvGCGaikry1bXoqjv/Zmc=
X-Received: by 2002:a05:6000:e4a:b0:439:852f:c9ce with SMTP id
 ffacd0b85a97d-439852fcf32mr13794860f8f.57.1772121353349; 
 Thu, 26 Feb 2026 07:55:53 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c75b8afsm407235f8f.23.2026.02.26.07.55.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 07:55:52 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/20] target/arm: Drop kvm_arm_pmu_supported
Date: Thu, 26 Feb 2026 15:55:31 +0000
Message-ID: <20260226155535.1171290-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226155535.1171290-1-peter.maydell@linaro.org>
References: <20260226155535.1171290-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

This function has only one use, so inline it and drop the stubs.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260216034432.23912-9-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm-stub.c |  5 -----
 target/arm/kvm.c      |  7 +------
 target/arm/kvm_arm.h  | 13 -------------
 3 files changed, 1 insertion(+), 24 deletions(-)

diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index f1d0ca09e6..169ef5f206 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -32,11 +32,6 @@ bool kvm_arm_aarch32_supported(void)
     return false;
 }
 
-bool kvm_arm_pmu_supported(void)
-{
-    return false;
-}
-
 bool kvm_arm_mte_supported(void)
 {
     return false;
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 495ac0709a..b8aba20f02 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -319,7 +319,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
                              1 << KVM_ARM_VCPU_PTRAUTH_GENERIC);
     }
 
-    if (kvm_arm_pmu_supported()) {
+    if (kvm_check_extension(kvm_state, KVM_CAP_ARM_PMU_V3)) {
         init.features[0] |= 1 << KVM_ARM_VCPU_PMU_V3;
         pmu_supported = true;
         features |= 1ULL << ARM_FEATURE_PMU;
@@ -570,11 +570,6 @@ void kvm_arm_add_vcpu_properties(ARMCPU *cpu)
                                     "Valid values are 0.1, 0.2, 1.0, 1.1, 1.2, 1.3");
 }
 
-bool kvm_arm_pmu_supported(void)
-{
-    return kvm_check_extension(kvm_state, KVM_CAP_ARM_PMU_V3);
-}
-
 int kvm_arm_get_max_vm_ipa_size(MachineState *ms, bool *fixed_ipa)
 {
     KVMState *s = KVM_STATE(ms->accelerator);
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index cee06b5f0b..82ac2aae46 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -168,14 +168,6 @@ void kvm_arm_steal_time_finalize(ARMCPU *cpu, Error **errp);
  */
 bool kvm_arm_aarch32_supported(void);
 
-/**
- * kvm_arm_pmu_supported:
- *
- * Returns: true if KVM can enable the PMU
- * and false otherwise.
- */
-bool kvm_arm_pmu_supported(void);
-
 /**
  * kvm_arm_mte_supported:
  *
@@ -196,11 +188,6 @@ static inline bool kvm_arm_aarch32_supported(void)
     return false;
 }
 
-static inline bool kvm_arm_pmu_supported(void)
-{
-    return false;
-}
-
 static inline bool kvm_arm_mte_supported(void)
 {
     return false;
-- 
2.43.0


