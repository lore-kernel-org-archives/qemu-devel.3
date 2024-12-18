Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 370FCE77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 22:41:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO2bo-0005tk-0q; Wed, 18 Dec 2024 17:33:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2ac-0004Om-A8
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:32:22 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2aZ-0003ce-FO
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:32:21 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2166360285dso1732395ad.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 14:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734561136; x=1735165936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6OcdwbkoPrDb9Qge/cmZ/mgcryes+4iIeOwDz5QvakI=;
 b=bJl0g8Maa6oSqJDG61GA1iDtbifJ0VhIt9kt1fL+ReHaOR82bBTrygSf4aKnEnLu2U
 u/ssngR3fdppW05J1HUXW/gPlxgHlbFb4owP3oLUGh61mUOReQiu5u+8AtDTAwIhHFHf
 LXO0z6tFa9aaGu+QKX4oLizaXkl5X8w/7DzH32HUtpWILB6qKQtdRAm8rG3bvgjj6IDT
 rawY7l39UjzIJYcJYee8stp1TamQu2wVOgLf5R5ATIMeVCEJoByjy9FPAcDOPCKC/XP9
 QT6gY0fW/KHYJK+K+d/YM/HVDWka8oSJHQGWQR62gD+xzK9/sczzBGJC6h77AaY6t6HV
 9HSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734561136; x=1735165936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6OcdwbkoPrDb9Qge/cmZ/mgcryes+4iIeOwDz5QvakI=;
 b=B4tL8pmadk43EXAzq5EJ81RN2PEk3hm/FQnS1f8FGyWN+EvgXY280tCvo9lh+k2BXF
 NxA/dkr+Fh+dCqfeoGkt4ZsZH3Uq0504SRv8VOMbqjsn0hokYS9GcS1owOuYApiFE4Sv
 u0+/qxNT1nGMMjqY0CXRT5BGUL7M0BcvkJ2jxsAdMorfYVyvMERa8EVMSALTk+Dqf+nM
 0ea6PRrVePz1FD3fIYJRCy9FoXc13JcXzvNuty7k/IKsUULB4eblulzo575cTliC7EsV
 eDS5NJQo1moC/p8pOBFA6Zw89LkLVOw63Gbj8XcY/89IDMn8UHSDsab9EgheOwvBeGQw
 L16A==
X-Gm-Message-State: AOJu0Yx9oVnvINt8DohanAyeEy2LHHF/4IEDFstks+lPbIb6U8VcBuqI
 pjgc1c76iS9YOz5yepAPfHRDylpLIe5zHS0xdALi1yhR71LCYr1mk0Ec2fpz
X-Gm-Gg: ASbGncuyrcyNCGPJRyGmUZ+o+o+/U93ZuI9xCCs9uXstOWZEsWlVxqdCYGZnUCcHVuJ
 hYV9TKwnSSAB6iFO3U1IAn1WrkEGsa0ymoSHV91W2MEmQyDAFrMVJ7jgw/wujBdUNkKoiUcmIJN
 VsdaauNOnDvht9GoALbC2SIa8stMq1KOOstVZNfH8xSWsQdMWoAcVWtRshXYFXClcX+jo5r9Azi
 Yo8+WdRhLLcRTHew9vvGCes2eYg8ODOdwdNgTVUZdT4Tx1Ypkzbi8MjHOr3q+3NJrkPbA/vOY1y
 5kV9hH5aX9e/+Sv66K55un5jNnOL/sSe1t0zN0sYD8UBEwdLnYdmZpSXLkp9K38=
X-Google-Smtp-Source: AGHT+IFDbpZZcpORf8AGmuvA6TBsJhwPlt10GS3CvFg3h2EIlYeP7JaTm2XU/9/NujuE5PwLb3UKSA==
X-Received: by 2002:a17:902:d2c1:b0:215:9a73:6c45 with SMTP id
 d9443c01a7336-218d7216ce2mr69396155ad.22.1734561135923; 
 Wed, 18 Dec 2024 14:32:15 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9705d7sm375775ad.102.2024.12.18.14.32.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 14:32:15 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, MollyChen <xiaoou@iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 39/39] target/riscv: add support for RV64 Xiangshan Nanhu CPU
Date: Thu, 19 Dec 2024 08:30:09 +1000
Message-ID: <20241218223010.1931245-40-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218223010.1931245-1-alistair.francis@wdc.com>
References: <20241218223010.1931245-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x632.google.com
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


