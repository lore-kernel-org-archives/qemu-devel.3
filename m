Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 148F1E7718A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 22:31:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO2ZH-00038R-JJ; Wed, 18 Dec 2024 17:30:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2ZB-00034u-Ou
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:30:53 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2Z9-00035z-2E
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:30:53 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2161eb95317so1625625ad.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 14:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734561046; x=1735165846; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W+a5eLWtazjKjyGdseEIBKLBcCSyugHNCLmPRqaOCVY=;
 b=GCFunTculouJLGV2LL3Day2YOOcpMzGZjm1Md+L/Gj9g3XF0hS+Uzjh42olPJ2UZX+
 Omsqc1C3IjRHVg8l6kErXWkjIrcbc6ZviBJasGcpChHbw3ZFs5ufWnux5iZgBapeOcl2
 1643/8C6SetGXCGx5odBoRfxd5oVVWq/Yc7vzLmDQ4635Uo6J78XSsH9/PxCA4RPNo+G
 Ax5LFCTNYUzWt5pc3IJxdIw+MThP/dJcjXIfOC5zurUxgNhKZQz4yrzvjiK1mMDZdVPe
 60LZ8X7CRw4aHi/01hroDZb9KGsNURYegF50DrLoJ9BSCfueFzCO3HweHDrx8ZNB8jBr
 hMtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734561046; x=1735165846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W+a5eLWtazjKjyGdseEIBKLBcCSyugHNCLmPRqaOCVY=;
 b=D4Gafz2zRWAcXaaGbwPFC/J4BpOvNiyJ/Q7gMm0XTrkPHoVVZSFV6AN6/ZUsbvkkto
 E8CtHHpTNR7zGT6B04I7yAOL9aPlyhVVhEpgSCN28Kb0Pdma1+SHr2ZE3biU1h9rEvcB
 sWKaQoTUzOqZFMXqRiD/Mb8axlgprwkS4QnLC6eaDs5MCOqZDIamSQLC65xZM0t2qYK5
 P+9b/J3BtIZo+qSCJwkVMuw8SbJK+V6mkLkGHGAGembB74P6lkYQRLc3LEJSC0glUSAl
 bhpQpy32terlmFgZPC+wx6hct7x2BCgIThwJvt6VquwrQp6OgmV8efjQbrYYUY/HqG42
 NWFA==
X-Gm-Message-State: AOJu0YxEa7/Ht8Dy7eN+YyA+tfYKCJ9hwMLfm3YTin8AxZi/h8Cbu57Q
 s3DrQMXG7ePEHfcjJmXrIxE0wRIHQ1FjcKQdblLgyRklmQjB0w934dzm6EL8
X-Gm-Gg: ASbGncutQqwBX87b0Aj9W9xr0TNkFdBBHHiDxAH1h8ttT1qEu0kCoX7+zzoZySvMcJn
 YNTqUOQy7eqx/xgcgbdKjMBEGxW/3FgsxJDJOk5HKu1Jx9WGajz6Ah8gCdBfzAnSo17lgpu8+Q7
 GD6VhwWmUVw3Pw+dAQ9WcF9GhousA4pJegaV+gOXyO8JrHjQfftP16GdPKZIPmHtHU5xtMpuTYL
 O538I7rcaK24J7cgD4CizUMqdbt+MAHNQyp07RyVQK2yaLfLSCQ2gaAjP5jW3B1v3ED4dQLueFz
 OeuDotqeZmaibQveB0r+v0Zy+RIpqcXfcg/Cc20OeQmbnFqt1IneyCSb+1+JEDA=
X-Google-Smtp-Source: AGHT+IEInN5/UQDwHf/qZRz7ebyXuljPOR+s78JZe56MAD0oHq30jW1z8SwgxLLIQslomO6a7IugIg==
X-Received: by 2002:a17:902:e74f:b0:215:6f5d:b756 with SMTP id
 d9443c01a7336-219d966e986mr13262705ad.7.1734561046464; 
 Wed, 18 Dec 2024 14:30:46 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9705d7sm375775ad.102.2024.12.18.14.30.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 14:30:45 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Anton Blanchard <antonb@tenstorrent.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 10/39] target/riscv: Add Tenstorrent Ascalon CPU
Date: Thu, 19 Dec 2024 08:29:40 +1000
Message-ID: <20241218223010.1931245-11-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218223010.1931245-1-alistair.francis@wdc.com>
References: <20241218223010.1931245-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62c.google.com
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

From: Anton Blanchard <antonb@tenstorrent.com>

Add a CPU entry for the Tenstorrent Ascalon CPU, a series of 2 wide to
8 wide RV64 cores. More details can be found at
https://tenstorrent.com/ip/tt-ascalon

Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20241113110459.1607299-1-antonb@tenstorrent.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu-qom.h |  1 +
 target/riscv/cpu.c     | 67 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 62115375cd..6547642287 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -49,6 +49,7 @@
 #define TYPE_RISCV_CPU_SIFIVE_U54       RISCV_CPU_TYPE_NAME("sifive-u54")
 #define TYPE_RISCV_CPU_THEAD_C906       RISCV_CPU_TYPE_NAME("thead-c906")
 #define TYPE_RISCV_CPU_VEYRON_V1        RISCV_CPU_TYPE_NAME("veyron-v1")
+#define TYPE_RISCV_CPU_TT_ASCALON       RISCV_CPU_TYPE_NAME("tt-ascalon")
 #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
 
 OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4329015076..66e00ed260 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -579,6 +579,72 @@ static void rv64_veyron_v1_cpu_init(Object *obj)
 #endif
 }
 
+/* Tenstorrent Ascalon */
+static void rv64_tt_ascalon_cpu_init(Object *obj)
+{
+    CPURISCVState *env = &RISCV_CPU(obj)->env;
+    RISCVCPU *cpu = RISCV_CPU(obj);
+
+    riscv_cpu_set_misa_ext(env, RVG | RVC | RVS | RVU | RVH | RVV);
+    env->priv_ver = PRIV_VERSION_1_13_0;
+
+    /* Enable ISA extensions */
+    cpu->cfg.mmu = true;
+    cpu->cfg.vlenb = 256 >> 3;
+    cpu->cfg.elen = 64;
+    cpu->env.vext_ver = VEXT_VERSION_1_00_0;
+    cpu->cfg.rvv_ma_all_1s = true;
+    cpu->cfg.rvv_ta_all_1s = true;
+    cpu->cfg.misa_w = true;
+    cpu->cfg.pmp = true;
+    cpu->cfg.cbom_blocksize = 64;
+    cpu->cfg.cbop_blocksize = 64;
+    cpu->cfg.cboz_blocksize = 64;
+    cpu->cfg.ext_zic64b = true;
+    cpu->cfg.ext_zicbom = true;
+    cpu->cfg.ext_zicbop = true;
+    cpu->cfg.ext_zicboz = true;
+    cpu->cfg.ext_zicntr = true;
+    cpu->cfg.ext_zicond = true;
+    cpu->cfg.ext_zicsr = true;
+    cpu->cfg.ext_zifencei = true;
+    cpu->cfg.ext_zihintntl = true;
+    cpu->cfg.ext_zihintpause = true;
+    cpu->cfg.ext_zihpm = true;
+    cpu->cfg.ext_zimop = true;
+    cpu->cfg.ext_zawrs = true;
+    cpu->cfg.ext_zfa = true;
+    cpu->cfg.ext_zfbfmin = true;
+    cpu->cfg.ext_zfh = true;
+    cpu->cfg.ext_zfhmin = true;
+    cpu->cfg.ext_zcb = true;
+    cpu->cfg.ext_zcmop = true;
+    cpu->cfg.ext_zba = true;
+    cpu->cfg.ext_zbb = true;
+    cpu->cfg.ext_zbs = true;
+    cpu->cfg.ext_zkt = true;
+    cpu->cfg.ext_zvbb = true;
+    cpu->cfg.ext_zvbc = true;
+    cpu->cfg.ext_zvfbfmin = true;
+    cpu->cfg.ext_zvfbfwma = true;
+    cpu->cfg.ext_zvfh = true;
+    cpu->cfg.ext_zvfhmin = true;
+    cpu->cfg.ext_zvkng = true;
+    cpu->cfg.ext_smaia = true;
+    cpu->cfg.ext_smstateen = true;
+    cpu->cfg.ext_ssaia = true;
+    cpu->cfg.ext_sscofpmf = true;
+    cpu->cfg.ext_sstc = true;
+    cpu->cfg.ext_svade = true;
+    cpu->cfg.ext_svinval = true;
+    cpu->cfg.ext_svnapot = true;
+    cpu->cfg.ext_svpbmt = true;
+
+#ifndef CONFIG_USER_ONLY
+    set_satp_mode_max_supported(cpu, VM_1_10_SV57);
+#endif
+}
+
 #ifdef CONFIG_TCG
 static void rv128_base_cpu_init(Object *obj)
 {
@@ -2984,6 +3050,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U54, MXL_RV64,  rv64_sifive_u_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SHAKTI_C,   MXL_RV64,  rv64_sifive_u_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_THEAD_C906, MXL_RV64,  rv64_thead_c906_cpu_init),
+    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_TT_ASCALON, MXL_RV64,  rv64_tt_ascalon_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_VEYRON_V1,  MXL_RV64,  rv64_veyron_v1_cpu_init),
 #ifdef CONFIG_TCG
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE128,   MXL_RV128, rv128_base_cpu_init),
-- 
2.47.1


