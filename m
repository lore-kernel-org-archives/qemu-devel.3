Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB038D6409A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 23:10:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9Y70-0007wm-Fb; Fri, 08 Nov 2024 18:09:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1t9Y6z-0007ue-7Z
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 18:09:53 -0500
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1t9Y6x-0006TS-LT
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 18:09:52 -0500
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7b1474b1377so177480685a.2
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 15:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1731107390; x=1731712190; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bCQCaIcBOvaIRYuz/3oJtVxsAaAVLM6GboWIOAAn8u4=;
 b=bfXn3gprWfDlUPe81Gtn3TgIP+b28tE0P7JqxCkr64PqE8221xUtBNv47L0epbBszl
 8J5wAWAevNqk/GvJSCDqU9emr026Xct7/IWNtC/nLP/rjH/5JS9UHCDjDnusgUCykkbY
 wG63+BaKDPucw7YtgFcobbkAwMTQPkOE77pDlIjTDcBMibomrGp6DsigRJ+XFQzTruKR
 tuzAeRVTd3qkm1Xwyo6n2bvSs0eOGfWxKaGy17DdkRKAeSuCWYVen8R8LlJPj3rvokDX
 TYplwBEK3im47fNwQFIPHOFQDXtK4z0P2OJy2HL/nAY+24jJiLv5TTt3ZVIEd0aHZGPf
 LFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731107390; x=1731712190;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bCQCaIcBOvaIRYuz/3oJtVxsAaAVLM6GboWIOAAn8u4=;
 b=cnXIe3DCjvEF7ECrsUvq6cznOXU/+gUj0Pu7xVEQSVPEiJq1bapdIp4Oar3VrcO6SY
 QgTnf1sMvUysfgvVImAE9MZhC0TYcYswEfSLBIkEbUZ9MbBmovQMEfL6HW8Nz9Jn7duo
 Z1JwYHD8M7x1jLnmBGGQB5KBn+abHkbZRc+d9Su8aSWtohaR9Me6mu/GvGJZuAUrz8Dy
 N1gCXt/yirjEzPG149ZDnnYNHztGhDJID3Mm7/zi9hjB7MVq8XJhjORzope6uX4ltMM1
 hKiTHRI+GBWVbAq0cK21K7awUD2+g50CK71QbqKoFnIdiwne6nP+OpcnBTekIPTuHM4d
 vWIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJr2k3uCxbl4tLyZnTUJA9g31iFDjD/TRo6MNMOcx1+cTTdXMjcc9CQVTJnJkU4imFmuhhGKkxzOrd@nongnu.org
X-Gm-Message-State: AOJu0Yz3WV5MKmjkYps7wQKkYPTPJbXbmhAPVf94l3u0Xwc59w/T5GiX
 TyBm7to7IBwiMVnm4zcRHgS7iemMNn/2oKEEnFoMvp0SGItTgjx+IEn1jPwupTA=
X-Google-Smtp-Source: AGHT+IG3VJ+G+1ob45vgQKVdEU3hQOTecKjrYpdPgSIpNRvfAni9EYgf3KDAuOKN0pPk/5avT+iC6w==
X-Received: by 2002:a05:620a:28c3:b0:7b1:48ff:6b63 with SMTP id
 af79cd13be357-7b331dc5484mr564371885a.22.1731107390252; 
 Fri, 08 Nov 2024 15:09:50 -0800 (PST)
Received: from ausc-rvsw-c-01-anton.tail89d63.ts.net ([38.104.49.66])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b32ac2dbedsm203784985a.9.2024.11.08.15.09.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 15:09:49 -0800 (PST)
From: Anton Blanchard <antonb@tenstorrent.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Anton Blanchard <antonb@tenstorrent.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH] target/riscv: Add Tenstorrent Ascalon CPU
Date: Sat,  9 Nov 2024 10:07:09 +1100
Message-Id: <20241108230709.1466634-1-antonb@tenstorrent.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=antonb@tenstorrent.com; helo=mail-qk1-x72b.google.com
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

Add a CPU entry for the Tenstorrent Ascalon CPU, a series of 2 wide to
8 wide RV64 cores.

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


