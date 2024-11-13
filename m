Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B589D41C33
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 11:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBBBm-0003Px-1v; Wed, 13 Nov 2024 06:05:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1tBBBe-0003Op-0X
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 06:05:26 -0500
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1tBBBb-0007Jg-Rp
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 06:05:25 -0500
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7b14077ec5aso61333285a.1
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 03:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1731495922; x=1732100722; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=79Qimx1nMyYtTHxLhbx1rj+j53V50WkAMuTu2tDwobI=;
 b=PNJTA7zd0SX2ekw22HRlURZjDOAF7FOricC0j8AmIFcueXt4hTULDUhXMfpDEQzy+y
 WWW7Lx+mm8fXwD6fByXQM4ejJ4HO4xeimWHee2Rt1Ogj69ND0LOH6DrwLjC+vlH5RDAt
 T+9Khaxng14VpxEA7lALqTyTOVbZUWz27dgAttjYBK0xK2VtFKnR/aQ+3xOg9K+BKpjA
 LeHflUQU/dkDykVMuvggRGuXY2pNe8MV9P0B83YEoShryDeioxpc/IsSgLQlo1rlNXkP
 MWBEu5VF+4D7hnzd57Q93vrT5VXoAp4eYfr6sm7wNFQKwUmGLWkl07CQ/Wr051SpU5AF
 hXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731495922; x=1732100722;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=79Qimx1nMyYtTHxLhbx1rj+j53V50WkAMuTu2tDwobI=;
 b=w4OOPFsUB1ZIu9pWZz/2/Gi8lcGQips1G7BkF6D5N8Ih27Y7tmzDsiEppdoBPp32Et
 Af4Qdr8FAa/0C6reOV0c8L560Gjv30ULaLOJSi5qBs0XyeKm4EKC1tEG9ljxPyMynL3f
 /5PJaHC0myFYYBLRnYuWE4DOJwQ7e1qf6oDsH2OktfhtEK3G6ECjYHQGJOfkx8wfm7Kh
 1BwMqR+wiJi5NvcXNax0Mc5aLEPCdo9pYq3Dhxmb4Pna5S1bB3onE5SUxVQqRTfs0FvO
 T5Qu2WRmAS7XsfgeEmhVQkFsMib/k1eF7LWohd+SQIQa1bz+jy+srz3+D7DpaQmz/kDD
 FzDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWip70uvusvpIQxtekaiXer52PTaAOEeru1jgCQ5fJv3Clu+OcoXkeiVgRa3EkMOcXRFIgRRsdEMsP3@nongnu.org
X-Gm-Message-State: AOJu0YyzC3w0eBOafLmCM9yXKlOsSQ5E1FozHIxnIMrcJKRd0bmjQTJH
 FxSsaFfyl9EXPdkwyUjLFUecJ7VyK9fdjvB9J/069C1s8FNrA2tdABR1OGY/9sA=
X-Google-Smtp-Source: AGHT+IF5oet/iFgY9FitxVVtn61AMIFSnuCJ6qiqA7rYdjtWGmAMy9dFn1/PTIjm78xb1VPpZ4nBKQ==
X-Received: by 2002:a05:620a:2687:b0:7b1:21c4:ecf8 with SMTP id
 af79cd13be357-7b33192f706mr3105331985a.28.1731495922192; 
 Wed, 13 Nov 2024 03:05:22 -0800 (PST)
Received: from ausc-rvsw-c-01-anton.tail89d63.ts.net ([38.104.49.66])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b32ac549ffsm676904285a.45.2024.11.13.03.05.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 03:05:21 -0800 (PST)
From: Anton Blanchard <antonb@tenstorrent.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Anton Blanchard <antonb@tenstorrent.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v2] target/riscv: Add Tenstorrent Ascalon CPU
Date: Wed, 13 Nov 2024 22:04:59 +1100
Message-Id: <20241113110459.1607299-1-antonb@tenstorrent.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::735;
 envelope-from=antonb@tenstorrent.com; helo=mail-qk1-x735.google.com
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

Add a CPU entry for the Tenstorrent Ascalon CPU, a series of 2 wide to
8 wide RV64 cores. More details can be found at
https://tenstorrent.com/ip/tt-ascalon

Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
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
index f219f0c3b5..8447ad0dfb 100644
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
@@ -2982,6 +3048,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U54, MXL_RV64,  rv64_sifive_u_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SHAKTI_C,   MXL_RV64,  rv64_sifive_u_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_THEAD_C906, MXL_RV64,  rv64_thead_c906_cpu_init),
+    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_TT_ASCALON, MXL_RV64,  rv64_tt_ascalon_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_VEYRON_V1,  MXL_RV64,  rv64_veyron_v1_cpu_init),
 #ifdef CONFIG_TCG
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE128,   MXL_RV128, rv128_base_cpu_init),
-- 
2.34.1


