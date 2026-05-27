Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3052CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 20:15:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSKeI-0006Fw-Cb; Wed, 27 May 2026 16:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSKeB-0006FK-Ml
 for qemu-devel@nongnu.org; Wed, 27 May 2026 16:14:37 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSKeA-0005Dm-73
 for qemu-devel@nongnu.org; Wed, 27 May 2026 16:14:35 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-49041fb8c23so45884075e9.0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 13:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779912873; x=1780517673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qhljTQ/lMvAqMZBeTUmtazgm5zjo86lQdzWtUmmZ4BA=;
 b=YgHtjtJCq2kDMsRk51WLDDb/OsJzziwLFPTYvdFIpCoCedTMHCztTvIpDCp0jEYT2I
 jl8+3YkgZ+/qBkXkdpLMc8kOT8bMzWmltv/z6qOIwObrCO5QNP3xfgQU+Q5PJg051gyC
 v4I9EP7GP4iKRoJDn9+nvWQyWX71++vJn1EYo1sTqx6tge24gXioFSXPFe5HSxc/gaAD
 nbilE7lQk/6JgHh1VjJ56EYWdzfhH9zmHLo/RHCLApQ+wXxwBsV9/VY8lEagz3g8+hgT
 Z0+pvuNHubQQfiZb80909wPDQjq6y0x2pwO6ZE67LZSl45rAidjOCs3R6k8K6NT94Yy/
 pp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779912873; x=1780517673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qhljTQ/lMvAqMZBeTUmtazgm5zjo86lQdzWtUmmZ4BA=;
 b=FEPrpGCtMO7pINne/+TPo5+2mHNTT9LqMBg+cBw3z+wANi0wWH40J4i0jXD1oCk+1/
 kO2iirzVq/hy3RPcNKB7XdHwbf0jhdTVW8VXTYH5o4dNuZOgVCs2b8p/DIC0Lly7Hj/S
 i+Uk4PLdultWovKB/DNed64noZWKeAhNFoCZkaMD9pNznzlUmuVT1DUCCgzswcMY4Cas
 bWXrplU/4fZ+tJTsxNssPYlvrnV5+VwMSKQp181iuoFtg6ZarZIrrxRI/F+eiBTdo78O
 unh5lQsXdprEbfksuMfTLp7eONink96x84nqH4SC+7V4YojkngRavD5I2qrs41SfOqKz
 c7wg==
X-Gm-Message-State: AOJu0YzgEsncI6PsS9DQchpI514+ykLGDfKR5KB9ig1uvnhbAlQhwhLT
 da9Wr5MNk0KITK4VCzu0FlLcvgNa9Z1IYpEbzs7Jy7nTispnmCSVDUBxTBfBujVz5WLUbbDFYxo
 KZKokXVmZzQ==
X-Gm-Gg: Acq92OHHgQS098rO4091htZBQyz3hqkPjZ97cAq6yWR5d9gU2nZe3g1tmglPd/uy/cG
 V8gqcS6ptX940s09GKXpWkkG3Ou+8n4xtfAREbp6bZ3BhvJ9uxXzWSfoTvNhmj22HkhA4KM8ECm
 HDlQU6L+jc+qa7/V4c8RdXy1Tb38iPWl3DF8Z0/0hDpUcy/FrxDl2vf8WeAJ0kbsU0QMHtHu5r4
 UEqcH6j9XQu2qXFx8mk6+KsoDCRDuUxmnmUFkJMEJwjzC07hUHGqVZpCfp+0nb98akh5GLsFMo7
 v8sYVS+8/zFhbwr4gYIC+eIYaBb5y5PgzHGCJUQF8Iy98JT0V8KmJ3bG0nTVt1DAYbY2K5B6iqf
 N9DIw740YzjlY1uGNGO1uUd/fEdCodUvv6PE5yKXNC3dw2qKxoexpKF31sBBXDmUfcRNlWgebO9
 SKyrFYN73SoaT10Hw2ElcI6lktyQAYEY/JIBIh6PxBtAyYGZoZOZYlG+Vf7hk9pUbMJA==
X-Received: by 2002:a05:600c:8599:b0:48a:525b:e148 with SMTP id
 5b1f17b1804b1-490424ac7ccmr302211295e9.4.1779912872781; 
 Wed, 27 May 2026 13:14:32 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ee5a84e92sm88842f8f.35.2026.05.27.13.14.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 May 2026 13:14:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Anton Johansson <anjo@rev.ng>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v11 05/12] target/riscv: Remove target_ulong use in
 get_physical_address()
Date: Wed, 27 May 2026 22:13:41 +0200
Message-ID: <20260527201348.29511-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527201348.29511-1-philmd@linaro.org>
References: <20260527201348.29511-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Use uint32_t for RV32, uint64_t otherwise.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/cpu_helper.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 6da67e132eb..fd7c6ac1b23 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1625,16 +1625,18 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
             return TRANSLATE_FAIL;
         }
 
-        target_ulong *pte_pa = qemu_map_ram_ptr(mr->ram_block, addr1);
-        target_ulong old_pte;
+        void *pte_pa = qemu_map_ram_ptr(mr->ram_block, addr1);
+        uint64_t old_pte;
 
         if (riscv_cpu_sxl(env) == MXL_RV32) {
-            old_pte = qatomic_cmpxchg((uint32_t *)pte_pa, cpu_to_le32(pte),
-                                      cpu_to_le32(updated_pte));
+            uint32_t cmp = cpu_to_le32(pte);
+            uint32_t val = cpu_to_le32(updated_pte);
+            old_pte = qatomic_cmpxchg((uint32_t *)pte_pa, cmp, val);
             old_pte = le32_to_cpu(old_pte);
         } else {
-            old_pte = qatomic_cmpxchg(pte_pa, cpu_to_le64(pte),
-                                      cpu_to_le64(updated_pte));
+            uint64_t cmp = cpu_to_le64(pte);
+            uint64_t val = cpu_to_le64(updated_pte);
+            old_pte = qatomic_cmpxchg((uint64_t *)pte_pa, cmp, val);
             old_pte = le64_to_cpu(old_pte);
         }
         if (old_pte != pte) {
-- 
2.53.0


