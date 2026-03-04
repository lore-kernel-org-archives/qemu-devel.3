Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE37EF8FE2
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 13:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxmEg-0006pm-O3; Wed, 04 Mar 2026 08:25:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vxmEO-0006iA-6N
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:25:41 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vxmEH-00023q-0B
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:25:34 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-8274843810cso3936762b3a.3
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 05:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1772630731; x=1773235531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yLrMOOfJRndwrguF9Yjw86k+4kSMb46Puxz6hJTHups=;
 b=Ow5o9QemFXhumASo0dl9hmthGXSy1JR1TcSDJt4bymhuGuRRC/OBkWLxfVMOhzwbJH
 qzMqWwMWmPsXyZoHiA3csXQKjTL0JXLjnDjdbtaO4R4b7KN+McRj8JLy0uWiZdyghNEz
 sqK07Jc4VOVPCICKwyuFFghzYqecWPWYXpnpJu9Lb+2dLVqqihOLCkao8V6a5yd23Bpt
 JMD7cq81e7dAuMokY9fF7RamcPtKx7OWs9hRWyU75IyaV8+8n2sfv4/W9Z2qgar60uPo
 YDI26FpJ4Oax+D/mZLLjbyIbivoFPAboD42mDGSRXU50nswsfghNWzHEy5aRovGYhows
 ud2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772630731; x=1773235531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yLrMOOfJRndwrguF9Yjw86k+4kSMb46Puxz6hJTHups=;
 b=sM/4jZzL+fReu8K+P2cRG3ZZ+NehBWUB7//FSdOgwj0lYTotqV65qRm0upZ8VL21Fu
 ef8hhpBDQBLGI8dFTsqUv0uS192RgnoByjxxSN2S2kTG8ftb566HtrJOiUiZql1c7ybS
 FVABDarzTPXxD8+ddkU+tACl6Bk98NVZ1Go7AEof4+1Carcx82ccYyWp7HlV8n3DGE59
 mmNGue033PU72D9pa2be9ZOUoB2zf5J76/TygDVIrBusX8WLI3NJi7V0r7z/YNA1z9lF
 JkxxLOmO8Sz/wsRPuxWa18UzzHd6OjbZGJv4G0+pT6j7Qexl0xt+15gJ2yONNsklp3Tf
 8UZw==
X-Gm-Message-State: AOJu0Yyzwj+tVeJs28ogf+C8OybgPgkcO9Tj3+BilQ5ymiHXvfsMPi/R
 cHAvFf7LduXHM4nJ6/5cVLIzFIuN2AkujiVZAsWD+n+Y3apl6sAiUPCSLMMeIbvgX4tORZ5IeTd
 p27v0AwruO3zwyfKwkQKyMiHS/DWgnJGOLkbu5ffoRkuy+mMTBn6Qq+Jpqaq4PGfCLPC83wyYwB
 xI85ziMCnXi/Tz7dwARBw4sZKdAfu4Wt9I5VUdk4DJCA==
X-Gm-Gg: ATEYQzwVkKRE2QemAQL5SxelLXuo6Ft5tHLe5kOm0GEzImNpdsOa7YBZHX3I5uQAoHY
 HnDNgv+MWchFFfyBBWyWwBIxcjbZxDf4fWT6/JYXOYgidBpkKGC2chrh+Fwj5CazCVYbKJa2mPv
 QNd22d/j/ZUdfBld1DxAr42LkKqZkZaPQU3ZVcDN9vqLz1by/QoHT0uIkuFZS+Dbu3aLPZDEHAn
 ASAAxXya+L/QXW7+Y2K8wa6gqqhmaGJ0OZnnwmH0buff+KP1Bmx7UHRCqn78UfAHIZFi3kRuWSs
 Cr+Gov+ih25s4zd28fLhwPu/nG+3/SFcpNGQKEVBZnmGRGat1lxrFQpcQ60Tx1WZV6nzlBxTFUK
 FXH/bFybyPTWwm6ca0NZva6nPOHfv5TGO6cfJ3TMckfU1kPul3tKH57PJicp/E0VoBGYL/BjLza
 MtFSSgOFkdfFEBMEuzNWR4jnebQm19Vszb8cAaIiHsTPIt9aJqBMQBHGw3nTla6wi56X3Bj46fB
 ipwEqpLTDzznKhcToYgHy7fkFb0ow5GdDpsXA==
X-Received: by 2002:a05:6a00:438f:b0:827:2ee0:411f with SMTP id
 d2e1a72fcca58-82972b61332mr1712416b3a.4.1772630731321; 
 Wed, 04 Mar 2026 05:25:31 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82739db1d6dsm16968505b3a.26.2026.03.04.05.25.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 05:25:30 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v4 5/9] target/riscv: Use the tb->cs_base as the extend tb
 flags.
Date: Wed,  4 Mar 2026 21:25:09 +0800
Message-ID: <20260304132514.2889449-6-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260304132514.2889449-1-max.chou@sifive.com>
References: <20260304132514.2889449-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

We have more than 32-bits worth of state per TB, so use the
tb->cs_base, which is otherwise unused for RISC-V, as the extend flag.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 include/exec/translation-block.h | 1 +
 target/riscv/cpu.h               | 3 +++
 target/riscv/tcg/tcg-cpu.c       | 7 ++++++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/exec/translation-block.h b/include/exec/translation-block.h
index 4f83d5bec9..40cc699031 100644
--- a/include/exec/translation-block.h
+++ b/include/exec/translation-block.h
@@ -65,6 +65,7 @@ struct TranslationBlock {
      * arm: an extension of tb->flags,
      * s390x: instruction data for EXECUTE,
      * sparc: the next pc of the instruction queue (for delay slots).
+     * riscv: an extension of tb->flags,
      */
     uint64_t cs_base;
 
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 962cc45073..4c0676ed53 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -703,6 +703,9 @@ FIELD(TB_FLAGS, BCFI_ENABLED, 28, 1)
 FIELD(TB_FLAGS, PM_PMM, 29, 2)
 FIELD(TB_FLAGS, PM_SIGNEXTEND, 31, 1)
 
+FIELD(EXT_TB_FLAGS, MISA_EXT, 0, 32)
+FIELD(EXT_TB_FLAGS, ALTFMT, 32, 1)
+
 #ifdef TARGET_RISCV32
 #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
 #else
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 720ff0c2a3..378b298886 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -104,6 +104,7 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
     RISCVCPU *cpu = env_archcpu(env);
     RISCVExtStatus fs, vs;
     uint32_t flags = 0;
+    uint64_t ext_flags = 0;
     bool pm_signext = riscv_cpu_virt_mem_enabled(env);
 
     if (cpu->cfg.ext_zve32x) {
@@ -118,6 +119,7 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
 
         /* lmul encoded as in DisasContext::lmul */
         int8_t lmul = sextract32(FIELD_EX64(env->vtype, VTYPE, VLMUL), 0, 3);
+        uint8_t altfmt = FIELD_EX64(env->vtype, VTYPE, ALTFMT);
         uint32_t vsew = FIELD_EX64(env->vtype, VTYPE, VSEW);
         uint32_t vlmax = vext_get_vlmax(cpu->cfg.vlenb, vsew, lmul);
         uint32_t maxsz = vlmax << vsew;
@@ -133,6 +135,7 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
         flags = FIELD_DP32(flags, TB_FLAGS, VMA,
                            FIELD_EX64(env->vtype, VTYPE, VMA));
         flags = FIELD_DP32(flags, TB_FLAGS, VSTART_EQ_ZERO, env->vstart == 0);
+        ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, ALTFMT, altfmt);
     } else {
         flags = FIELD_DP32(flags, TB_FLAGS, VILL, 1);
     }
@@ -189,10 +192,12 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
     flags = FIELD_DP32(flags, TB_FLAGS, PM_PMM, riscv_pm_get_pmm(env));
     flags = FIELD_DP32(flags, TB_FLAGS, PM_SIGNEXTEND, pm_signext);
 
+    ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, MISA_EXT, env->misa_ext);
+
     return (TCGTBCPUState){
         .pc = env->xl == MXL_RV32 ? env->pc & UINT32_MAX : env->pc,
         .flags = flags,
-        .cs_base = env->misa_ext,
+        .cs_base = ext_flags,
     };
 }
 
-- 
2.52.0


