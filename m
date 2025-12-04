Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2407ED2445A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 18:07:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRDir-0006Au-6P; Thu, 04 Dec 2025 13:06:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vRDij-00067N-SZ
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 13:06:27 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vRDig-0005Xw-8b
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 13:06:24 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-42e2ce8681eso942279f8f.0
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 10:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764871580; x=1765476380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PB2UE02+vaRNynPNG9J56XxSHzWeqyBwXNuiiG3tTJQ=;
 b=rOELjwws89y5aNoh+OplVS/J13KSl4pgHd5HUan+2Qs9919xWIKFtPqV6mVGEuvJn1
 NyFdgr4a9PzaFNDpUbBxwoyXvzRJIb2L7DsGC8QeZysB2hPPTCvCiBMi2GO1h2zlXCIr
 vgzTcGNkJ9zoWvO9x9MI9n378xc16PokAtOncTCxj54WZz4vl1c7A32a0dx3ZfBDoRhG
 JtTrTAGaXm8Tai5k7bdegCSTQZyAHnv5LzncSIrX7V9AAui1wrfMU1h9NtDEXrHlUb3H
 KZpopuiOWiHhUURsdttcG5QTcARghtVWJuBILiIB735bUYoZtE/wALaZSCAswvnkIhNH
 t4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764871580; x=1765476380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PB2UE02+vaRNynPNG9J56XxSHzWeqyBwXNuiiG3tTJQ=;
 b=u6KuQAECgNTE8ZjF7UhC8K6tGmQyMeiMVVj8UYlPEE/46RmbbhFJFGW+oDX68y8BJ/
 FCSGcNW0ones53zelsgPMfnIC6GiRRGdRGGKoyZoLpY9kDzGtDt04yRkCPsOzWbIlcaT
 3v7B59uaH8BF7kQKhbFd5NKHW3tN2ZzUcvFrk5G1oOuWG/iqbAlPl1LByJNnUdcB+AjN
 4uf+9nARMhBcB99eJEWHVa5x136pmdmcJXR3+VJpjnpQxvZo0hzxUIc5n5SudlvL3Saf
 eongyuYCMr43A0RQGuxfAtBhp+0jSTOXdMFSZp4T2NLe5KqWZyqolmV8NM9Xd77LJJ3d
 Ci/A==
X-Gm-Message-State: AOJu0YyITNYAXFDi9u7YqOZyLkG6I83w5tTk/C2PKVzC1A1LUyLZHDBy
 a4d6DFVZE7rpwCrcc+uH8ki9q4aQIJ1FAm3xKfr8bh3OLSxaXsTUldX01qcGEpWZG2qoKE3+hgG
 CkVPM
X-Gm-Gg: ASbGncs2D08Bvtdg6+CFzpMeCsVt9X4ro1qxme//+/UjGqJON20jp4dex2VqUjUj6vF
 4/XefMugfzRWeOIBbfYH+Vs10t7zD771jg0JXwmrMRolT89xUEHn742Jr9EyUOiY7fGzTMaABwS
 LJbETxhxKvTxz8TX9zvB3OR+OruE3iKQZ36Q/4aiJoysKKGxJOJ1mm+WQfkCiwyxyU5+Nae5HBA
 oOBSTM+dQwFVMd4PZiSz8bf370noOH4aLro+4aJ5GyAfL0vd/dc0e+eX7eA6Iv9N5wskp8CAgia
 A2CFedKCeSxtGjPjtzdQVKtF2rWxLalJUvvrYJjGU0Jrl25psCZ+frRhmFeUkmB1var6G+bs2uK
 EEzc4A+e8VLbA9nonxOZneuYWItKp9cLZQbuI/d2Wr6bfZieO/56Pk1WdOWBIE4n0jrm+aTVpH+
 cPYTl2mXLkXEma
X-Google-Smtp-Source: AGHT+IEMrouYXTaWBww9NSpfEqi1VGV6PCmDswP2kxQAg+O2qr1KJSkyJ1pEjTwGKDGKTWEKIN3yOQ==
X-Received: by 2002:a05:6000:4025:b0:42e:28a4:1fc4 with SMTP id
 ffacd0b85a97d-42f731cf0femr7889326f8f.55.1764871580559; 
 Thu, 04 Dec 2025 10:06:20 -0800 (PST)
Received: from jimm-x1.. ([2a10:d582:31e:0:d817:b2ba:2766:5b2a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d331e29sm4589641f8f.32.2025.12.04.10.06.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 10:06:20 -0800 (PST)
From: Jim MacArthur <jim.macarthur@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH 2/4] target/arm: Allow writes to FNG1, FNG0, A2
Date: Thu,  4 Dec 2025 18:04:12 +0000
Message-ID: <20251204180617.1190660-3-jim.macarthur@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204180617.1190660-1-jim.macarthur@linaro.org>
References: <20251204180617.1190660-1-jim.macarthur@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wr1-x434.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This just allows read/write of three feature bits. ASID is still
ignored. Any writes to TTBR0_EL0 and TTBR1_EL0, including changing
the ASID, will still cause a complete flush of the TLB.

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 target/arm/cpu-features.h |  7 +++++++
 target/arm/helper.c       | 18 ++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 579fa8f8f4..d56bda9ce0 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -346,6 +346,8 @@ FIELD(ID_AA64MMFR3, SDERR, 52, 4)
 FIELD(ID_AA64MMFR3, ADERR, 56, 4)
 FIELD(ID_AA64MMFR3, SPEC_FPACC, 60, 4)
 
+FIELD(ID_AA64MMFR4, ASID2, 8, 4)
+
 FIELD(ID_AA64DFR0, DEBUGVER, 0, 4)
 FIELD(ID_AA64DFR0, TRACEVER, 4, 4)
 FIELD(ID_AA64DFR0, PMUVER, 8, 4)
@@ -1369,6 +1371,11 @@ static inline bool isar_feature_aa64_aie(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64MMFR3, AIE) != 0;
 }
 
+static inline bool isar_feature_aa64_asid2(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR4, ASID2) != 0;
+}
+
 static inline bool isar_feature_aa64_mec(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64MMFR3, MEC) != 0;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index c20334fa65..ecb31b058c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6095,6 +6095,7 @@ static void tcr2_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     ARMCPU *cpu = env_archcpu(env);
     uint64_t valid_mask = 0;
+    bool require_flush = false;
 
     if (cpu_isar_feature(aa64_s1pie, cpu)) {
         valid_mask |= TCR2_PIE;
@@ -6102,8 +6103,16 @@ static void tcr2_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
     if (cpu_isar_feature(aa64_aie, cpu)) {
         valid_mask |= TCR2_AIE;
     }
+    if (cpu_isar_feature(aa64_asid2, cpu)) {
+        valid_mask |= TCR2_FNG1 | TCR2_FNG0 | TCR2_A2;
+        require_flush = true;
+    }
     value &= valid_mask;
     raw_write(env, ri, value);
+
+    if (require_flush) {
+        tlb_flush(CPU(cpu));
+    }
 }
 
 static void tcr2_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -6111,6 +6120,7 @@ static void tcr2_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     ARMCPU *cpu = env_archcpu(env);
     uint64_t valid_mask = 0;
+    bool require_flush = false;
 
     if (cpu_isar_feature(aa64_s1pie, cpu)) {
         valid_mask |= TCR2_PIE;
@@ -6121,8 +6131,16 @@ static void tcr2_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
     if (cpu_isar_feature(aa64_mec, cpu)) {
         valid_mask |= TCR2_AMEC0 | TCR2_AMEC1;
     }
+    if (cpu_isar_feature(aa64_asid2, cpu)) {
+        valid_mask |= TCR2_FNG1 | TCR2_FNG0 | TCR2_A2;
+        require_flush = true;
+    }
     value &= valid_mask;
     raw_write(env, ri, value);
+
+    if (require_flush) {
+        tlb_flush(CPU(cpu));
+    }
 }
 
 static const ARMCPRegInfo tcr2_reginfo[] = {
-- 
2.43.0


