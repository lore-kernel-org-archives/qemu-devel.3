Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 411A5E77184
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 02:00:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOSGD-0002LL-HG; Thu, 19 Dec 2024 20:57:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSG8-00025z-Cq
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:56:57 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSG6-0004oB-38
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:56:56 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-728ea1e0bdbso1323810b3a.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 17:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734659813; x=1735264613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6OcdwbkoPrDb9Qge/cmZ/mgcryes+4iIeOwDz5QvakI=;
 b=H4dzbA86pG9VJ+HlcO/ua9NJLUSWNIprtQfC9kiztKc4l7yeyTxQgEqKz8n8xArXvI
 roYh0QD/L7NEvDm36uaX8qTyt3hagbwqzyEG/C6WvctBZ7875qLVnMCKjl37MJjkWJCA
 xTsTR7UXzicIQ5O6/rKlL3Les+hcnNDlnOy/nMUBjM2crb/C89/XtomBXQbgY7c0ZQEm
 ZLNjEYsxVlvNDjhEvD7OvufjTpC8qpqppU8edlDJxot2mE17dPeb24Yp9PkpvyQ9LnrL
 0uNI1DUSUroAm8HL5Oh70X2nh4jSJ718rKbhHaOg+IvZmi2XIy2Fyd3fLC/FGfOKziJN
 RY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734659813; x=1735264613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6OcdwbkoPrDb9Qge/cmZ/mgcryes+4iIeOwDz5QvakI=;
 b=Lqu8ZOCKkttPRQT7aQdtv17m2YuBNBvsic9rf+VnUafWtxGi3Wtz1V0MAHuTETxkaP
 rU7XHBHNErfd9MEFDpUbdrU0P3K6T3qrocL6CTLK2Qko4grg/ur0nj7xj+QW1x2Pwrkb
 5eUZjDtej25ALiU7r7+VLCdIkRN9Ii1Qm9k5eLznuVxTG4IbRGPRmv+jXDNGh93T73Ei
 GUdeeiEfbMKXoehloRLyZmyZeWa+pHAJ8QKt6Cj2ZbXKDik5HMvFnoNNewVOJJ288CS9
 SK6Md4jm5nY/ScqSut2N+cnWwLkUvEAz8SjF0Y7hHrmqi5QOXjnDCsDvMomQreyZ1cI4
 8zRg==
X-Gm-Message-State: AOJu0Yzh0ngGzZK9ZP+96+aI/MYe78L/KkbNFmm4TIpNOmoCVveBeIR+
 1L+AiB+sFkA7GFZUqbz6AkXRIjYj18Cmru8vMrJbj2dCvl4s25ZvqIa6Wl7T
X-Gm-Gg: ASbGncsCT9LkYLy4jPPZ6yExIM2tvGIKgtMrkT559czVt1JfRfaJmEqKC9rknsm/71u
 jW9nTo8yqXHQSc2t9dMWLOBI8yt20P1yu+XAZRR413hLbRO9Mi4oxzO8zJHCP4Lrv/n3BsvjXP/
 JMF9GVwSPiSIsdJxp8FCzjqoTLdK51Z+fHYkKTjBUwjWkTjDZZlXXj1q2QtMYTT45HE6e40ov1F
 0IY9oeJy84ENUKxKdw0/Ung3kRmxBhxFk9NAAQ55ZrbY5AOCBbqyy9HHgX67gfJcGd0opSCHlmU
 2aZqxLiV7Pw3on713JsLHzmLc9PzhrZv3Nj5m5N3EJ8NkI8GA4+IhZ5Lgr3mIMQ=
X-Google-Smtp-Source: AGHT+IFeAJLlyyrTOwQTf3LQL2dclGKH4mT2xpcnsw9m7/NZSfWRsuIOLNSJiaePcJqWpS9sx+cLSg==
X-Received: by 2002:a05:6a00:35c3:b0:725:ea30:aafc with SMTP id
 d2e1a72fcca58-72abdd3bf6fmr1570673b3a.5.1734659812640; 
 Thu, 19 Dec 2024 17:56:52 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8164d3sm2002539b3a.15.2024.12.19.17.56.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 17:56:52 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, MollyChen <xiaoou@iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL v2 39/39] target/riscv: add support for RV64 Xiangshan Nanhu CPU
Date: Fri, 20 Dec 2024 11:54:39 +1000
Message-ID: <20241220015441.317236-40-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220015441.317236-1-alistair.francis@wdc.com>
References: <20241220015441.317236-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42a.google.com
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

From: MollyChen <xiaoou@iscas.ac.cn>

Add a CPU entry for the RV64 XiangShan NANHU CPU which
supports single-core and dual-core configurations. More
details can be found at
https://docs.xiangshan.cc/zh-cn/latest/integration/overview

Signed-off-by: MollyChen <xiaoou@iscas.ac.cn>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20241205073622.46052-1-xiaoou@iscas.ac.cn>
[ Changes by AF
 - Fixup code formatting
]
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu-qom.h |  1 +
 target/riscv/cpu.c     | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 6547642287..d56b067bf2 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -50,6 +50,7 @@
 #define TYPE_RISCV_CPU_THEAD_C906       RISCV_CPU_TYPE_NAME("thead-c906")
 #define TYPE_RISCV_CPU_VEYRON_V1        RISCV_CPU_TYPE_NAME("veyron-v1")
 #define TYPE_RISCV_CPU_TT_ASCALON       RISCV_CPU_TYPE_NAME("tt-ascalon")
+#define TYPE_RISCV_CPU_XIANGSHAN_NANHU  RISCV_CPU_TYPE_NAME("xiangshan-nanhu")
 #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
 
 OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d7b830d489..58bb5196a8 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -647,6 +647,34 @@ static void rv64_tt_ascalon_cpu_init(Object *obj)
 #endif
 }
 
+static void rv64_xiangshan_nanhu_cpu_init(Object *obj)
+{
+    CPURISCVState *env = &RISCV_CPU(obj)->env;
+    RISCVCPU *cpu = RISCV_CPU(obj);
+
+    riscv_cpu_set_misa_ext(env, RVG | RVC | RVB | RVS | RVU);
+    env->priv_ver = PRIV_VERSION_1_12_0;
+
+    /* Enable ISA extensions */
+    cpu->cfg.ext_zbc = true;
+    cpu->cfg.ext_zbkb = true;
+    cpu->cfg.ext_zbkc = true;
+    cpu->cfg.ext_zbkx = true;
+    cpu->cfg.ext_zknd = true;
+    cpu->cfg.ext_zkne = true;
+    cpu->cfg.ext_zknh = true;
+    cpu->cfg.ext_zksed = true;
+    cpu->cfg.ext_zksh = true;
+    cpu->cfg.ext_svinval = true;
+
+    cpu->cfg.mmu = true;
+    cpu->cfg.pmp = true;
+
+#ifndef CONFIG_USER_ONLY
+    set_satp_mode_max_supported(cpu, VM_1_10_SV39);
+#endif
+}
+
 #ifdef CONFIG_TCG
 static void rv128_base_cpu_init(Object *obj)
 {
@@ -3056,6 +3084,8 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_THEAD_C906, MXL_RV64,  rv64_thead_c906_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_TT_ASCALON, MXL_RV64,  rv64_tt_ascalon_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_VEYRON_V1,  MXL_RV64,  rv64_veyron_v1_cpu_init),
+    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_XIANGSHAN_NANHU,
+                                                 MXL_RV64, rv64_xiangshan_nanhu_cpu_init),
 #ifdef CONFIG_TCG
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE128,   MXL_RV128, rv128_base_cpu_init),
 #endif /* CONFIG_TCG */
-- 
2.47.1


