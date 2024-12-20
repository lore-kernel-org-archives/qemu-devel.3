Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 164DAE77184
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 02:01:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOSEx-0006G6-36; Thu, 19 Dec 2024 20:55:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSEi-0006Db-Lj
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:55:28 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSEg-0004Qo-Ln
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:55:28 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-725ea1e19f0so1278592b3a.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 17:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734659724; x=1735264524; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W+a5eLWtazjKjyGdseEIBKLBcCSyugHNCLmPRqaOCVY=;
 b=L75dT5An23yZYu+HZKgnQ7qyfPDxJVzUX/wJEew6aJot7enDkeAYT0cmBfHocG4XbS
 B1fyGUTrbatto5qPPuVGo0noG1crDtXRGGe2Z7WyEzfemBzO0UkSs+jGV8HQXBvKpLF9
 XFJINlyj84LDwSn0nxgbVD+XnGIWDxkO1Dryu22Rh6KiNhfl8vvJF6iIa324zgxxC4CS
 hH9sWF1aP+y9d4tTXUJEPok9vnsPdJuE4Z94vntIu/Rf/7UV8E/zGBWdd2hyg3uFy54j
 9Vo9QskA/s7S5gw7NeEl0hni2nu2a8e2B1ynvmPlopw2cNjY2HnEfH/Vjfnb8EshEEtj
 0N/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734659724; x=1735264524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W+a5eLWtazjKjyGdseEIBKLBcCSyugHNCLmPRqaOCVY=;
 b=aZBJcKrMROE7TSfErDG0Y945aopK05aN88Ef9AIKRAofx+qsJ9VCjHotUqYluhOWXw
 S6v2TfFWKoMzMigc4ifsyrwU8jz0TRME/f3mgaLpO4me4twu1m/8HiCa6tslxUNZQF5I
 RSppIGbl8Dgs3svj1oOdbmfM0Q3b8z57yBTY56gci53AcpNT6d8RCLTlGyoRX8tw+ndI
 HuLGvnV4Ij1XWwJOM6lCRZvVaRjZnC3RlYDRcjJ/VkEW+9erAG5+7pkAODGNF93borEU
 96pEft/W7B0p16yeabT07/29tKwA4PqLGqEZQV1z73IsvrYmsFYSAgX8I8SRPsIsHvEr
 JLFw==
X-Gm-Message-State: AOJu0YwKAtb6QHlxeupl0z/F428h8jMqUd5T8tqy7E+6+MnDmaYs0vgZ
 1JiXfUu/TllXjrH8jOY+r1aOgC+qWlvj74tjlM/8lTljNMc90zmHnyhWwg/u
X-Gm-Gg: ASbGnctesj+qwSGxuGYJ4Eb+V5NyCiSsVYoMWcImex9fyB1gfKGowzBUtZuQS7kzPBn
 l4wgwTIPbMGzn/OJ4EAwcWYjrKwYJQ6Th/UdT8FFXbGlXkUUTdV1aGzovPTN66k4hBOz8v+cm/L
 dfAD25md7esXlxN2PSPsLYdeQ3RV61r/5bBmtzi2A0ImLfF9S+IiNz2aCsEWPlAif4bu4jHt8Mc
 5iw8lcIzYEmaOgqhUL5MH6zkgnq1o2RElNoe0R90lgdws2L8psaxNvJRQKavYN092yQIVogiJqP
 Gv+8BW1ezaPhZA8PZXlQ/fhDMOlEUj8W23gMuqELDbXzkY/V4OYkUUlnbtiswlo=
X-Google-Smtp-Source: AGHT+IF7pu5sOzVMQagBNFw2HSUyf58p0ionaciagDP4g8Z39+gaCWnk9djx1OYyIJt66Ie0rKzQFg==
X-Received: by 2002:a05:6a00:4096:b0:729:c7b:9385 with SMTP id
 d2e1a72fcca58-72abdd7bdecmr1443652b3a.6.1734659723952; 
 Thu, 19 Dec 2024 17:55:23 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8164d3sm2002539b3a.15.2024.12.19.17.55.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 17:55:23 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Anton Blanchard <antonb@tenstorrent.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL v2 10/39] target/riscv: Add Tenstorrent Ascalon CPU
Date: Fri, 20 Dec 2024 11:54:10 +1000
Message-ID: <20241220015441.317236-11-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220015441.317236-1-alistair.francis@wdc.com>
References: <20241220015441.317236-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42e.google.com
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


