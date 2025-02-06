Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDCBC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 18:20:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg6Sg-0007e2-9a; Thu, 06 Feb 2025 13:18:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg6Sb-0007bx-Ez
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:18:45 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg6SZ-0006oX-9C
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:18:45 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-436249df846so8657445e9.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 10:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738865921; x=1739470721; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FJl7/XCq/mOYxrX7g6HKZEwMAdetJgh4DocsCwIosNE=;
 b=lAde4DnB0uWJJXxZfn03EkrEA80KRWSlSVEr6cFP9UPJ024TjzCEc7GmAbTIUng1Np
 C1E20ILsmX6iKkNZGatVhBfkpsMst/nQa3eAK5Ie8ZOg3r7GEGTApL2sJ/7aMuHjk+Ir
 pQf21fmsn24lQxdYlh6mH6qGcmeYL+1idf5A4/ZWt6KAXlypCdqlwXxnOKxc/IZK/9hT
 J9VfJ4YGLhccyAF+fGKAfxYviGNFp+4n2fFSSJIedm5ddlhA0GOPi1RwFRqCNVOvqFqk
 Ls08RG30/n5p28AzmnRBl5Er5GTGe/7PHVeMQ4Iun4LLMppt5vs46zMdwj+c9YKfi4kC
 pXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738865921; x=1739470721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FJl7/XCq/mOYxrX7g6HKZEwMAdetJgh4DocsCwIosNE=;
 b=ljIKkg/t679Qo0Y5WntrvQrUAcGCEpf7PwodlGW40Sxx+Vt8Mdj6FL+afl5xp392Td
 VHAbUIDYZzGFM2KcxqcwHpQrecVlu1oIKQC2uvkLZ7tLjvXa4K15DKxjByh8TH5bb6ru
 Uf4tR6KR+H/6wEMcKmchlr8ZRQVOG/Od2R2XVU4E6jgbNP/FKWnEGOhz4qsT3M9nKtIA
 u+HU6MsiFjUbkMR1zJpy6XMZ97w8Npp3G2Jl1+/G6olyI62JXcPdOgI2D7TSTZ4W66ds
 PmoTgArts5jYkygOTxIynIxDO++0xkwjnkWo+sBtd6SjTjmpWrMAo07zX3iqNxSPocpH
 slNw==
X-Gm-Message-State: AOJu0YyL63hD9tMC87xxabp/zT5nTgIXYnBtaF7JMIdD3AC/II6Jsaa0
 hV+vnULLTpkaUMq9IQqSHG7Q4l8QFntJq4ZzBaDhrbxuVCIu0gSp6NdhrVa59tDdurLHXZBDICG
 oIHU=
X-Gm-Gg: ASbGncuWHPFRhnR938OLoneeGYDaupVWP1C7+kp7PkPm8hcIMrliAxAeLOQWseBuEIB
 YKbAjRNJSFpsfWavaNXQ1VFp6WrRkXCWInqZJpw9V0rHe6bNvgOz28PnL+2zrCSo+eKD5o4L6xh
 jWNG3n8EIDezFTATv1Biu7K4i+ZOmP5eEBC0IORf+CzqUannlbqg8p+w+CDGF264p/TsgFpOtX+
 z3eucREy6dLPypnvhY7F7cyQkKByKe8O16W48pOsJdqcThP0f14eN3bdLwv/q1Geb9TcWVtg37b
 T5H+5lMBYYrQ/ntDqpQVKv2K0nslfTn9ahI4OebuP7oEKDzUmfWBV0wxeEej5AtHLg==
X-Google-Smtp-Source: AGHT+IHG7C2tyyfiGwe2p+xdnPWu21qDsS92W896e/2VOWr+1H/9f9iYFPgUHovHTeAn5h1rVy4ZOQ==
X-Received: by 2002:a05:600c:1e28:b0:437:c3a1:5fe7 with SMTP id
 5b1f17b1804b1-439249abd7amr3524595e9.20.1738865919619; 
 Thu, 06 Feb 2025 10:18:39 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390db11200sm61574155e9.38.2025.02.06.10.18.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Feb 2025 10:18:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/7] target/riscv: Move target-agnostic definitions to
 'cpu-qom.h'
Date: Thu,  6 Feb 2025 19:18:22 +0100
Message-ID: <20250206181827.41557-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250206181827.41557-1-philmd@linaro.org>
References: <20250206181827.41557-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

"cpu.h" is target-specific. Definitions which can be used
by hw/ code when building QOM blocks can be in "cpu-qom.h",
which is target-agnostic.

Move the MISA bits (removing the pointless target_ulong cast)
and the IRQ index definitions.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/cpu-qom.h  | 40 ++++++++++++++++++++++++++++++++++++++++
 target/riscv/cpu.h      | 24 ------------------------
 target/riscv/cpu_bits.h | 15 ---------------
 3 files changed, 40 insertions(+), 39 deletions(-)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index d56b067bf24..6028aa38fb2 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -55,4 +55,44 @@
 
 OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
 
+/* Interrupt causes */
+#define IRQ_U_SOFT                         0
+#define IRQ_S_SOFT                         1
+#define IRQ_VS_SOFT                        2
+#define IRQ_M_SOFT                         3
+#define IRQ_U_TIMER                        4
+#define IRQ_S_TIMER                        5
+#define IRQ_VS_TIMER                       6
+#define IRQ_M_TIMER                        7
+#define IRQ_U_EXT                          8
+#define IRQ_S_EXT                          9
+#define IRQ_VS_EXT                         10
+#define IRQ_M_EXT                          11
+#define IRQ_S_GEXT                         12
+#define IRQ_PMU_OVF                        13
+
+#define RV(x) (1UL << (x - 'A'))
+
+/*
+ * Update misa_bits[], misa_ext_info_arr[] and misa_ext_cfgs[]
+ * when adding new MISA bits here.
+ */
+#define RVI RV('I')
+#define RVE RV('E') /* E and I are mutually exclusive */
+#define RVM RV('M')
+#define RVA RV('A')
+#define RVF RV('F')
+#define RVD RV('D')
+#define RVV RV('V')
+#define RVC RV('C')
+#define RVS RV('S')
+#define RVU RV('U')
+#define RVH RV('H')
+#define RVG RV('G')
+#define RVB RV('B')
+
+extern const uint32_t misa_bits[];
+const char *riscv_get_misa_ext_name(uint32_t bit);
+const char *riscv_get_misa_ext_description(uint32_t bit);
+
 #endif /* RISCV_CPU_QOM_H */
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 97713681cbe..4e681ad3917 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -54,30 +54,6 @@ typedef struct CPUArchState CPURISCVState;
  */
 #define RISCV_UW2_ALWAYS_STORE_AMO 1
 
-#define RV(x) ((target_ulong)1 << (x - 'A'))
-
-/*
- * Update misa_bits[], misa_ext_info_arr[] and misa_ext_cfgs[]
- * when adding new MISA bits here.
- */
-#define RVI RV('I')
-#define RVE RV('E') /* E and I are mutually exclusive */
-#define RVM RV('M')
-#define RVA RV('A')
-#define RVF RV('F')
-#define RVD RV('D')
-#define RVV RV('V')
-#define RVC RV('C')
-#define RVS RV('S')
-#define RVU RV('U')
-#define RVH RV('H')
-#define RVG RV('G')
-#define RVB RV('B')
-
-extern const uint32_t misa_bits[];
-const char *riscv_get_misa_ext_name(uint32_t bit);
-const char *riscv_get_misa_ext_description(uint32_t bit);
-
 #define CPU_CFG_OFFSET(_prop) offsetof(struct RISCVCPUConfig, _prop)
 
 typedef struct riscv_cpu_profile {
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index f97c48a3943..80701bc77fe 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -720,21 +720,6 @@ typedef enum RISCVException {
 #define RISCV_EXCP_INT_FLAG                0x80000000
 #define RISCV_EXCP_INT_MASK                0x7fffffff
 
-/* Interrupt causes */
-#define IRQ_U_SOFT                         0
-#define IRQ_S_SOFT                         1
-#define IRQ_VS_SOFT                        2
-#define IRQ_M_SOFT                         3
-#define IRQ_U_TIMER                        4
-#define IRQ_S_TIMER                        5
-#define IRQ_VS_TIMER                       6
-#define IRQ_M_TIMER                        7
-#define IRQ_U_EXT                          8
-#define IRQ_S_EXT                          9
-#define IRQ_VS_EXT                         10
-#define IRQ_M_EXT                          11
-#define IRQ_S_GEXT                         12
-#define IRQ_PMU_OVF                        13
 #define IRQ_LOCAL_MAX                      64
 /* -1 is due to bit zero of hgeip and hgeie being ROZ. */
 #define IRQ_LOCAL_GUEST_MAX                (TARGET_LONG_BITS - 1)
-- 
2.47.1


