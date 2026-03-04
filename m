Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F31CEDEC09
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 04:10:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxdYx-0000GT-Fl; Tue, 03 Mar 2026 23:10:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vxdYu-0000FC-IR
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 23:10:16 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vxdYr-0003QQ-5d
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 23:10:15 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-c6e248aa446so2540970a12.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 20:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1772597411; x=1773202211; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4jomXmSscZNe9sFySbh7BxEdoKVrZTFGKzEhn0haMsY=;
 b=Bio8yWAizMbpZjoGFTTfgbJ0tt/XNVaVnxDMGnboL8+NPLT/WbZYNTToh4BsHpqpA0
 PedMdpp7d4oJ1LXCwDHZpCuANYkZcq9VJe9Rh5PGJxhkp9wSgxGViMdBj2rJfP7+FCRJ
 9viW8hoQXswFmoJ0x535hv9aEbysw39JgqHc8FxUZyL/M3sZcermfbug7WqS2TzPH7BH
 CUs1oc2cbV9vav7JVkZT3k9Nlzx6Ni1evJQ/UUxDllPebPE0vZoXbcXo9Azsfw7cOyC2
 LhnJNOxM4HwnWRbA77fzdOICJ5SuW8jlmVzu26R6/zVInjzxvNqNxqiI13MnN8ZERdFO
 bcwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772597411; x=1773202211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4jomXmSscZNe9sFySbh7BxEdoKVrZTFGKzEhn0haMsY=;
 b=i7Srv3bgREVWsIPcBRc6f6tn2vL1K79YaE+Ay/vDczy9aS2UbK9UgDVy3QqafXRsvJ
 9OP4fak3g5YDX+R+HIovzV6D9Fkr0MOaYYKzgq68KEAsncpJHZ4wVV7irFnNtkc7rHs5
 GiFXD6kmObtzkAwp8RG/t7S3vtrYT4T2Uy9f8coAv2e1HDoha/zootsCQ83tYZ1HlWD7
 iWbN96HHb1TTF0EfCRcTCis38rFGYAsJMcn8NZDfk/anH3pjlf/54Ul292kbkD0paAiP
 NLlajdrCuGgVHc13E5a9p0USnw7OIAftzMb85GL83VAeUTvCGj73GooSrrzAj6H06JZx
 S5xg==
X-Gm-Message-State: AOJu0YxOyn4tMc9RvXzeA7OlySpTrfsw15CDiISGaiABTXXRBMszQGjL
 u4NislEfEY240QVAB7HJ/bRdb2vc+RvgwjHYjJuvWKCpKDUHo1tH15FjgpOq3a0cRIsk176OdGS
 2WL4V5PpRl/JHuhWSW08EPq7mvLfbEarCeaZ2bggobgbwECciLrVU9sSr/nyikcUNS2kXO9Xqpx
 nm9UQqKDzmy1h7fk2uCZQF/0ApULcuMZqdtPjdk65qYSI=
X-Gm-Gg: ATEYQzx7eXsuKbxZ4FJNolINU+6hRaWvoYKISx7YWEBN1ygaxtgQWKJxEkO2bc43RgW
 PaIDR0EG3x53NXrP5rlt6ykMVU0gJMoBdSB+FeNXVKWVvg8r1odd/2miCGEJ9kDmQgNnXDAKPY+
 0iQV14nJCXRmxz65uk6Bu5lcxXUHyAv7gS91cY3wWa3NOJDkSRwzyT0RPDf+eCGOj7TeCpJbDGp
 cQa9WDsXM4TlQZPqMEXx+YYoU2OCg7pO7ugt7Bd5P4vMDdz7UJnPFJ5AvBtWHWqvr4UZ5vrGiJp
 8LghE8Yl47DQzmIiEYCNyIB2brAdXmVbWFvPhtmxQK83oca9GurQ608DDFJi3Y6D5n9N3+4Yjdw
 zRyclJjwFpRnzZ/BK4ZbJR1pQBZmdQH5pQSuZ8U3/jDrMFe2vNu7rHpibkyjjWHajUOAwmmboan
 y8anBSeYZE/5QfxFDXTiJ0lxuG5V5DSY4KwwMCWnS0T9IJkVQ7Ofk3iRk3aijaqQ==
X-Received: by 2002:a17:902:e5c2:b0:2ae:54b2:27c7 with SMTP id
 d9443c01a7336-2ae6ab61f2amr8170345ad.39.1772597410992; 
 Tue, 03 Mar 2026 20:10:10 -0800 (PST)
Received: from jchang-1875.internal.sifive.com ([136.226.240.169])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ae54136b28sm71058815ad.73.2026.03.03.20.10.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Mar 2026 20:10:10 -0800 (PST)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Jay Chang <jay.chang@sifive.com>,
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH 2/2] hw/riscv/riscv-iommu: Add IPSR.PMIP RW1C support
Date: Wed,  4 Mar 2026 12:09:59 +0800
Message-ID: <20260304040959.47267-3-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260304040959.47267-1-jay.chang@sifive.com>
References: <20260304040959.47267-1-jay.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=jay.chang@sifive.com; helo=mail-pg1-x52c.google.com
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

Signed-off-by: Jay Chang <jay.chang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
---
 hw/riscv/riscv-iommu-bits.h | 1 +
 hw/riscv/riscv-iommu.c      | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
index 47fe01bee5..a938fd3eb4 100644
--- a/hw/riscv/riscv-iommu-bits.h
+++ b/hw/riscv/riscv-iommu-bits.h
@@ -189,6 +189,7 @@ enum riscv_iommu_ddtp_modes {
 #define RISCV_IOMMU_REG_IPSR            0x0054
 #define RISCV_IOMMU_IPSR_CIP            BIT(0)
 #define RISCV_IOMMU_IPSR_FIP            BIT(1)
+#define RISCV_IOMMU_IPSR_PMIP           BIT(2)
 #define RISCV_IOMMU_IPSR_PIP            BIT(3)
 
 enum {
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 98345b1280..610cdebac2 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2153,6 +2153,10 @@ static void riscv_iommu_update_ipsr(RISCVIOMMUState *s, uint64_t data)
         ipsr_clr |= RISCV_IOMMU_IPSR_FIP;
     }
 
+    if (!(data & RISCV_IOMMU_IPSR_PMIP)) {
+        ipsr_clr |= RISCV_IOMMU_IPSR_PMIP;
+    }
+
     if (data & RISCV_IOMMU_IPSR_PIP) {
         pqcsr = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_PQCSR);
 
-- 
2.48.1


