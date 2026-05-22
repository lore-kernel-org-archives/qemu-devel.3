Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F2DCD5BAF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 00:07:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQDO5-0002XE-WC; Thu, 21 May 2026 20:05:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDNk-00023s-7j
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:04:52 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDNe-0003cq-7o
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:04:51 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2ba928852a5so46546815ad.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 17:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779408283; x=1780013083; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cLkPtVdev/JOC/NRIei3L8ZewJsnH2MkRoBf5Bketn0=;
 b=i6HwENcx8TAvgGaP6d6erFwhRSfYDllrG7cwmVqoFKQ4c0C+7OwbPq3g2Ntt32sDPP
 YqTvG2KzWc8Kr/VDFylH/baQcNAsJtd/Ya9etzwpQm4ZVjL48DA8LYvu1ZpsmVBjuqPz
 WUNUzGsRS+m5WOwPIZhaNcccknFY34aY9J9gIxiPxDXmjLksKTeeg1V7bTjVfJWizDVw
 6MrXbI9uwKxbzbd6Af1LnkqcMYt6iDwwsDpuiI+6oQfa9DQhcbNtHpa6q+zhmQD72y5G
 LePAfziRVfhpp3BW5pjgvc0iJkCf8m6Yj2+esUxLhNZWguTR3h6CpKwJoI+s0PbAKO+Z
 +AjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779408283; x=1780013083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cLkPtVdev/JOC/NRIei3L8ZewJsnH2MkRoBf5Bketn0=;
 b=jVgb4aIzm0R7NjsGJV7ttS9A7TrmgGMjN1FQoMAfoF5zHy2tK9Y1suM1Gul3Lw/Kd9
 fSX1/0H7MSpAU5Unxu5S8wTOvNs2mexO/XK7pQgSitocRNcz2YJ3GRi7SSl/ecD+c1zH
 DlM4GG9mIx/VuY3XclnVdC8uVh7ahiP/d9EPepfjAGG6pA2Q0O8KX+cvH9AJqX6Ca4fb
 rFif3I9b544U7iA8WQFa0WwPGqS72EwHrLGu6EmzmGa8xxik0yDqci48G8Z2Y0J2KkXk
 APT8kG9fhHIQTGu/Zkqfk+1Ku/Ck/Ma3L2Retp33L6HMIkfRWx3ASA+aPSU1RgMjRg+2
 dNbQ==
X-Gm-Message-State: AOJu0YxtApjhOEMapgjWo2Vh0/5msxVFmcC4adaowmJmhaRLORL5nfsS
 mGx5GP3chP4Nc5fS8ierQI9akIlZuhttUjsxnrHFlHPTNbL+3owTiqMl2Lblm9jR
X-Gm-Gg: Acq92OFtmHbyrrzDHziDZ2iN9H2FSFPNU7lBZ1jaXmYrA3QlEWqPtQEMsB80dpvOZmS
 fMLhXXvFuNQkQcIVcmbMBnATtHcW08hxi2gpR64q0stUSlHPhu1XdBVuqKSXX4eWuaE5VgA49fH
 g0HJ3YubtwSswtBOwHerM5raeYZmaxMaUnuK+6xfz23DWZrTVkXMWxFYvbOw7pO0t6ubyZETlUk
 SFt/YnUDj/y4eeZkgbDPlqUQM3S3PDr/w4lacfnGdP9eCqeldcmELiyzCtRIS9E92k30OdAeyKL
 p2xyCWK1Xuj01lwE1sf8S163VRYyECu5YIRaY+HMmpQaeUa22ERR17strVWvTjuReUpqkBJUoQW
 NfWkYAw9NW+EPdF2n9ImqtMgBehBjrKv6VF5SyImhO75jq7CEYQ7o9Ti64r4qmHtai50PAopmi8
 t8Jsnw+WOAowPFGrLX3JYCgOcoRa7nbBzA1dqAH0avBA==
X-Received: by 2002:a17:903:1a2d:b0:2bd:5ddd:17ab with SMTP id
 d9443c01a7336-2beb080c8fdmr9113705ad.32.1779408282811; 
 Thu, 21 May 2026 17:04:42 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb114b54csm3915475ad.42.2026.05.21.17.04.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 17:04:42 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Zongmin Zhou <zhouzongmin@kylinos.cn>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 21/48] target/riscv/kvm: add KVM support for Zicbop extension
Date: Fri, 22 May 2026 10:02:57 +1000
Message-ID: <20260522000324.23255-22-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522000324.23255-1-alistair.francis@wdc.com>
References: <20260522000324.23255-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Zongmin Zhou <zhouzongmin@kylinos.cn>

When the Zicbop extension is available expose it to the KVM guest.
Also read and validate cbop_blocksize from the host via KVM interface.

Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <9e388aa9984ea9d3d0c85e1630c9195023938952.1778653159.git.zhouzongmin@kylinos.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index b047ffa9c0..608495630f 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -293,6 +293,7 @@ static void kvm_cpu_csr_set_u64(RISCVCPU *cpu, KVMCPUConfig *csr_cfg,
 
 static KVMCPUConfig kvm_multi_ext_cfgs[] = {
     KVM_EXT_CFG("zicbom", ext_zicbom, KVM_RISCV_ISA_EXT_ZICBOM),
+    KVM_EXT_CFG("zicbop", ext_zicbop, KVM_RISCV_ISA_EXT_ZICBOP),
     KVM_EXT_CFG("zicboz", ext_zicboz, KVM_RISCV_ISA_EXT_ZICBOZ),
     KVM_EXT_CFG("ziccrse", ext_ziccrse, KVM_RISCV_ISA_EXT_ZICCRSE),
     KVM_EXT_CFG("zicntr", ext_zicntr, KVM_RISCV_ISA_EXT_ZICNTR),
@@ -439,6 +440,12 @@ static KVMCPUConfig kvm_cboz_blocksize = {
     .kvm_reg_id = KVM_REG_RISCV_CONFIG_REG(zicboz_block_size)
 };
 
+static KVMCPUConfig kvm_cbop_blocksize = {
+    .name = "cbop_blocksize",
+    .offset = CPU_CFG_OFFSET(cbop_blocksize),
+    .kvm_reg_id = KVM_REG_RISCV_CONFIG_REG(zicbop_block_size)
+};
+
 static KVMCPUConfig kvm_v_vlenb = {
     .name = "vlenb",
     .offset = CPU_CFG_OFFSET(vlenb),
@@ -1293,6 +1300,10 @@ static void kvm_riscv_init_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
         kvm_riscv_read_cbomz_blksize(cpu, kvmcpu, &kvm_cbom_blocksize);
     }
 
+    if (cpu->cfg.ext_zicbop) {
+        kvm_riscv_read_cbomz_blksize(cpu, kvmcpu, &kvm_cbop_blocksize);
+    }
+
     if (cpu->cfg.ext_zicboz) {
         kvm_riscv_read_cbomz_blksize(cpu, kvmcpu, &kvm_cboz_blocksize);
     }
@@ -2014,8 +2025,8 @@ void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
     int ret;
 
     /* short-circuit without spinning the scratch CPU */
-    if (!cpu->cfg.ext_zicbom && !cpu->cfg.ext_zicboz &&
-        !riscv_has_ext(env, RVV)) {
+    if (!cpu->cfg.ext_zicbom && !cpu->cfg.ext_zicbop &&
+        !cpu->cfg.ext_zicboz && !riscv_has_ext(env, RVV)) {
         return;
     }
 
@@ -2062,6 +2073,25 @@ void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
         }
     }
 
+    if (cpu->cfg.ext_zicbop &&
+        riscv_cpu_option_set(kvm_cbop_blocksize.name)) {
+
+        reg.id = KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_CONFIG,
+                                        kvm_cbop_blocksize.kvm_reg_id);
+        reg.addr = (uint64_t)&val;
+        ret = ioctl(kvmcpu.cpufd, KVM_GET_ONE_REG, &reg);
+        if (ret != 0) {
+            error_setg_errno(errp, errno, "Unable to read cbop_blocksize");
+            return;
+        }
+
+        if (cpu->cfg.cbop_blocksize != val) {
+            error_setg(errp, "Unable to set cbop_blocksize to a different "
+                       "value than the host (%lu)", val);
+            return;
+        }
+    }
+
     /* Users are setting vlen, not vlenb */
     if (riscv_has_ext(env, RVV) && riscv_cpu_option_set("vlen")) {
         if (!kvm_v_vlenb.supported) {
-- 
2.53.0


