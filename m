Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC41CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 20:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSKe6-0006Df-AD; Wed, 27 May 2026 16:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSKe4-0006CN-RN
 for qemu-devel@nongnu.org; Wed, 27 May 2026 16:14:28 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSKe3-00058t-5a
 for qemu-devel@nongnu.org; Wed, 27 May 2026 16:14:28 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-490686877a1so25871075e9.0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 13:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779912865; x=1780517665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j6KuZbw0iwf/xssJze0f006ceb1iyBQfISlrUwfPrC0=;
 b=FXM6jnmuQamDZsNy7Y2j6cqr96TEISbRGBcDKSzkCeSoMDECxEX+Mi+pU8Z3qJv+PB
 VZKuDtgukGNs9CHYN1EXUptteuXpuLmwihanYgAsKymyck5Nx9+/tWxxjISrY3n0j4gZ
 SuIH03BCbl6sc/O0nISzei9gaIOIJJXnMEaR8YjsTg8zUJkTChOWG1+fOHkxrknASxbA
 u4dtmrA9r4Vp+b3VwofZIJOolh6B2rej7nBXTuZyk0aMLeYQ2meZmHOffy6Cj3LE2r6j
 0Sh/jx2n+/Exo5ACb1Qma7a1rz5n9NB+PDeHG5xbs4Iqu9xjph8orlviy6xspV/L1Lzg
 BFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779912865; x=1780517665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j6KuZbw0iwf/xssJze0f006ceb1iyBQfISlrUwfPrC0=;
 b=eiDptAaivxNGDwsObO38AsmpSwaq0W2Gou4t1z4wb3jER2TmnQIXMTn21kBnJDFAhL
 xlMMMnmzwXfIjk7cjETLnotey8FNuswJlfMgCrCs9cAhVDRYGUoAivFRB5XNBg3qAnnS
 /gPQcbpxHWQuYHRLtQSDVQJaoRIZyoStXkYrtHycS4QZQU3wvyXw4014GACEiMQH9iC9
 QPW4HU8L5ayydUW1Ju/Qk3eqp7VaXbT4z0BMCcDSTGMwH23fzeztC3wLi4p/6krIrWZL
 zW1VvWQ38b7LlSI74qQ2Vd/H+dQAZS+vimEwvGwkOmc6ui9C5Du8Zm92BYfBXqdEW6bK
 jbgg==
X-Gm-Message-State: AOJu0YwKITppGttDTt1Zq5COsBB3YWWcSAN5BoWYFGQgBTI+Kzw14c4B
 ffL4bOJLV24i+lAvELs+c06D1Cw5rmcJgoqN+e4vY28SscgMH6my8ADY0XuS/AFZe1nXDuu7BcY
 RuAzAWiOPpQ==
X-Gm-Gg: Acq92OH34BkYwQtMfTB0cCUk98wVPIglb4pEH46ZOW4QFySyxQwKoRjjEU1NocM3bFz
 93MeuynHKwcBnxNvT0rdzZI1p4cvHJAJrTZ0imYnyid22Hbq7axmLQhkW+VCM33CGMvOQ8xDgOJ
 R7LOUfF+WhcqOBzpfoQxdS9An5VEi/Pp0OnzrOO0qKZ//FCAh73TLrFRmUvQYkgd7Ng1BYtuzWv
 YVfWSXEIfyZXSP22jtscjoJ04sCwLy0vkPOQNvUVf7/TLlYxaA0oT9VWup4NS0+UvMt2nZixgpp
 M/bQdSDXRGd0p6gClwtH1lW9GV6PzS22rz2cYv+wg5K5kE1xi+eM/8BKJi96nMo6ShC/lv0vKJf
 wTpgpN/bJ/qaZlYnGT/d7beYvhmysv7MJ6J7hvBvEGZpqHFqfCeAomRt2ALRM7t378VQqx62gYz
 wqKMFyt0DU0LmEylrTpYfBFa7AFv/99d2wgBJ8KtahzMIG4+lhENVWh4wjrNLh+3/DS5e57oDeb
 HUc
X-Received: by 2002:a05:600c:a402:b0:48f:e230:29f5 with SMTP id
 5b1f17b1804b1-490426b0c92mr289639835e9.16.1779912865477; 
 Wed, 27 May 2026 13:14:25 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4908f0b5c92sm64055e9.35.2026.05.27.13.14.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 May 2026 13:14:20 -0700 (PDT)
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
Subject: [PATCH v11 04/12] target/riscv: De-indent some code in
 get_physical_address()
Date: Wed, 27 May 2026 22:13:40 +0200
Message-ID: <20260527201348.29511-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527201348.29511-1-philmd@linaro.org>
References: <20260527201348.29511-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

get_physical_address() is quite complex already. In order
to make the two next commits simplers, de-indent one if()
ladder. No logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/cpu_helper.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index f86bfdb32e7..6da67e132eb 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1617,27 +1617,30 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
         hwaddr l = sxlen_bytes, addr1;
         mr = address_space_translate(cs->as, pte_addr, &addr1, &l,
                                      false, MEMTXATTRS_UNSPECIFIED);
-        if (memory_region_is_ram(mr)) {
-            target_ulong *pte_pa = qemu_map_ram_ptr(mr->ram_block, addr1);
-            target_ulong old_pte;
-            if (riscv_cpu_sxl(env) == MXL_RV32) {
-                old_pte = qatomic_cmpxchg((uint32_t *)pte_pa, cpu_to_le32(pte), cpu_to_le32(updated_pte));
-                old_pte = le32_to_cpu(old_pte);
-            } else {
-                old_pte = qatomic_cmpxchg(pte_pa, cpu_to_le64(pte), cpu_to_le64(updated_pte));
-                old_pte = le64_to_cpu(old_pte);
-            }
-            if (old_pte != pte) {
-                goto restart;
-            }
-            pte = updated_pte;
-        } else {
+        if (!memory_region_is_ram(mr)) {
             /*
              * Misconfigured PTE in ROM (AD bits are not preset) or
              * PTE is in IO space and can't be updated atomically.
              */
             return TRANSLATE_FAIL;
         }
+
+        target_ulong *pte_pa = qemu_map_ram_ptr(mr->ram_block, addr1);
+        target_ulong old_pte;
+
+        if (riscv_cpu_sxl(env) == MXL_RV32) {
+            old_pte = qatomic_cmpxchg((uint32_t *)pte_pa, cpu_to_le32(pte),
+                                      cpu_to_le32(updated_pte));
+            old_pte = le32_to_cpu(old_pte);
+        } else {
+            old_pte = qatomic_cmpxchg(pte_pa, cpu_to_le64(pte),
+                                      cpu_to_le64(updated_pte));
+            old_pte = le64_to_cpu(old_pte);
+        }
+        if (old_pte != pte) {
+            goto restart;
+        }
+        pte = updated_pte;
     }
 
     /* For superpage mappings, make a fake leaf PTE for the TLB's benefit. */
-- 
2.53.0


