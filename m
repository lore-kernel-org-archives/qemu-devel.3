Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D71CCC5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 20:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKN5V-0001pN-7Z; Wed, 28 May 2025 16:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uKN5R-0001nk-S5
 for qemu-devel@nongnu.org; Wed, 28 May 2025 16:09:17 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uKN5N-0006NI-4D
 for qemu-devel@nongnu.org; Wed, 28 May 2025 16:09:17 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-70e5d953c0bso3526127b3.1
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 13:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1748462951; x=1749067751; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q75wCLLWuB7OvinkOcqG/BYvN2MthuDZnMoql8kakbM=;
 b=S0xar/gerRZo4bn05X/CODS38KzIrTrX6Gg7TRe9XSPtylCveaZCqAh9cEEDP1KZy9
 0gn3oIKeY6owpmpEjOb0fvj19zPbgibeLaHNPcg1sV0ZGgIx/DgSfzSza5bGmYisSPWu
 jvX2PjSUVNsX0hm1MM4LZKrhRcILOkyyDfHrJfID0MtuZ74rg4Xr/j9k924kHU+zibm6
 X/wzRRuRl+gPCosK6leeqqZvOaR0FI5Xk/LuzLdNK/N+cvSqOqfC/8kUKsCixQAJurb+
 1zqcnmCsddGp98WgnxANzy6i1LMtU8qGvo8AO3jcPKSfesTIJPeV60Ssf8bIZZM1XTF2
 1jkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748462951; x=1749067751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q75wCLLWuB7OvinkOcqG/BYvN2MthuDZnMoql8kakbM=;
 b=F9TM9msjmp6tIJlmyF9DDL2oh6KXmeUuEkNLhvCx2CP3y2ZtGAi3/WZ9Mb1dnz9MLd
 s1lVI9IBOX++m1ufHKazhm10BTmlxHzbLfN9EZj7a9NOdwlBmBBmgX5Azi+QK5CsZI/E
 qtf112LOWD7P17hRayeO7lE9FIrjynTAWrAhhhcW6kGRl6Wea5RfnIagvGwA6yZytNJ5
 ZpCCMEdh3hI2lkjS94EBBlS8TXPw0rqLhp+vLldoTUKQcQ8c8jHhyYwjZDl1MIQfmV2V
 vjGRTM2yDab8CE9qDT9SZKQQe4amkQwPf5olptn6zXcmNSYtY1Cz4TpC0BO1Fufi0a2w
 wnNQ==
X-Gm-Message-State: AOJu0YxR/UtEjDQ7h00nJup3F/G/nAqTe1lsH1D2mCdQ6P6ZyYt1ZDar
 ccbgfJxTfcjxGOuuV2Ks6T29pyoYBl93QVbJtpH8IIMDYdund48KOA4mscBXHNVyincKo0MdW1L
 osh8M
X-Gm-Gg: ASbGncvukqdTNM7N2rMlVB9/FDM+yGZ+Y7rFuFE1FKzqoL/kLHDXtZTJcbTvsLNHrOD
 NY21A7lG6J1zgoLhacfO72iyfwjoGAcVp92Kt9BB7RnTHOTG7w1jxqIGaRdKE2nu/lL2VMSe0wv
 9jhufUfpSnCm5izibTwbmwi+7ZP02g6WO7f9MFdNaZlood+4JiJ7B2GORia/ggsn9gSXPwb+Xvg
 uYUROSVxvJtjOmENEExhob657R/WATgJgQfSKw4ZtvaQMolkjbnbdooVAc0nJEq6NX25qj25Zls
 4YA8si8wrNktDYXekH3WkbN2yqEXtRF2CIcqIBip0JJX+Y8xD2EAx7q8mrnVkix9orm2j2FJ+lA
 U5bUCRxccIdXaEg==
X-Google-Smtp-Source: AGHT+IGluCsb2Vs7swpWUN18rUbgPCDEsX3yvQtgG8cJoAHquuW8ReHmLnmm6r98YJYpfUaLaBYmyw==
X-Received: by 2002:a05:6102:3a08:b0:4de:d08f:672a with SMTP id
 ada2fe7eead31-4e4240bc571mr14731267137.15.1748462509531; 
 Wed, 28 May 2025 13:01:49 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([191.255.35.190])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-4e59fc11a95sm1393736137.3.2025.05.28.13.01.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 13:01:49 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, ajones@ventanamicro.com,
 Fei Wu <wu.fei9@sanechips.com.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 2/4] target/riscv: Add server platform reference cpu
Date: Wed, 28 May 2025 17:01:27 -0300
Message-ID: <20250528200129.1548259-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250528200129.1548259-1-dbarboza@ventanamicro.com>
References: <20250528200129.1548259-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x1129.google.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Fei Wu <wu.fei9@sanechips.com.cn>

The harts requirements of RISC-V server platform [1] require RVA23 ISA
profile support, plus Sv48, Svadu, H, Sscofmpf etc. This patch provides
a virt CPU type (rvsp-ref) as compliant as possible.

[1] https://github.com/riscv-non-isa/riscv-server-platform/blob/main/server_platform_requirements.adoc

Signed-off-by: Fei Wu <fei2.wu@intel.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu-qom.h |  1 +
 target/riscv/cpu.c     | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 1ee05eb393..70978fd53c 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -55,6 +55,7 @@
 #define TYPE_RISCV_CPU_VEYRON_V1        RISCV_CPU_TYPE_NAME("veyron-v1")
 #define TYPE_RISCV_CPU_TT_ASCALON       RISCV_CPU_TYPE_NAME("tt-ascalon")
 #define TYPE_RISCV_CPU_XIANGSHAN_NANHU  RISCV_CPU_TYPE_NAME("xiangshan-nanhu")
+#define TYPE_RISCV_CPU_RVSP_REF         RISCV_CPU_TYPE_NAME("rvsp-ref")
 #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
 
 OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4a30cf8444..ec2fbc0e78 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3166,6 +3166,17 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.max_satp_mode = VM_1_10_SV39,
     ),
 
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RVSP_REF, TYPE_RISCV_VENDOR_CPU,
+        .misa_mxl_max = MXL_RV64,
+        .profile = &RVA23S64,
+
+        /* ISA extensions */
+        .cfg.ext_zkr = true,
+        .cfg.ext_svadu = true,
+
+        .cfg.max_satp_mode = VM_1_10_SV57,
+    ),
+
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
         .cfg.max_satp_mode = VM_1_10_SV57,
-- 
2.49.0


