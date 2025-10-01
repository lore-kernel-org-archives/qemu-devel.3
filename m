Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86744CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:18:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yRw-0003TD-3g; Wed, 01 Oct 2025 11:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3yRI-0002FN-AS
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:08:21 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3yPs-0000mm-TN
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:08:19 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e2826d5c6so57394575e9.1
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 08:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759331203; x=1759936003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j+8g8rOsqAJiSBTC9ZjoJReHOLtdXImU2cZHmlNYY1E=;
 b=R7kiKo/ikCqWyHPuuDymC+THqFz9XRfhxVOEwWRStqTP/5CpCwb2IQmnrOBKPBlSKR
 axBn2IO7mN1q6imFATeTaNG10jtMgMJzB18JCfzisiIEA1t76BFpvoDh5X/OV2hGzn+2
 LPU1eVVjOlyhsxphFzWWrCGbc41aTcWAWkb9B+vwl9ZQcxNbAsNsSMaEogeyBBEM5mOf
 S7hvJeKFsZneX9KdMgIo/mFFJaGHW/wMirT2HdFOXII9WMwhz2+JoCqc52T1b0Gg+486
 PeEtp1vTA8xIcdEOfWetKQnLnGE3+XlaOOXhH85eGIOpFSC98SOXuLOvhWEExcArQ0UN
 Ok1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759331203; x=1759936003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j+8g8rOsqAJiSBTC9ZjoJReHOLtdXImU2cZHmlNYY1E=;
 b=ZYVMhlkGnSXI8NWl/kLwI1sx7xPszvf3P1M7FLbFr2fsD+r67CTNbUY0uBaxdH08zH
 uXJDd0Onak80WpxuoAhkzinRJmn5ruEqeMT7FkJPVM/Lh2P4z4peu2kmtDwfcBQskcua
 F4hZxdij8CsQI6+8aXBZVxWxCuMNLwAkrkv/dI9oTswC22P5nEAyuziTHEnhbV14vo1w
 8U57Er06cM8gXpMQkBfkdWMls+sad+D1XPxkxBfjgtVTdysYnxjUHXQXoMrdc6MT6PU0
 A382JxakGCr1/XwOtzl+XzoNsTdf7LmlmQJ9+8yrjKyASoR/mtEbJ7/9UzezWG11Wx2E
 5aCQ==
X-Gm-Message-State: AOJu0YzWKtE2KpRWcHgeuU1qangvsr26ZIm7YzxDExMta+hg3VGHzPpL
 ZkxZNWfxmiNTSSrq89EeioWQAoa2Egvn2jeJa+M0a7Ll5ldG+mGBNyfYz1W7T0K/2/ED3dnXoZS
 Xl48z8ALECw==
X-Gm-Gg: ASbGnctJioreRCncgw5DxmQYf14MM4HPIiYpMcs9rRA3JOcMZhLaq4C2Xdtpc9irn1X
 dMq4PFhP4+PJpVBrR0ucCViwuG2cdQZ8Srg11ESHa4+djNLoQQcLGL7knD+c15tNodI5sgln4y9
 SEwdsv8QW1xKm1uXHWJdx++pVWiy68OnQbhSQHcC3XnG9C0S24KVpRTxm8gP3GTchu5vbfZxKJY
 Q0YlKqPFkSx0EKS1ZZDtrEypJLZYVGyvMn7Pfed+Mum4IMt7O0bwwGKt3tjtcGpbs2R5J5nCntE
 CapRLixMQVP5iNzz+I69FHjs6QT+T5YyOBECYaMNT3wxACz8FvQ1wgCvqUA8Ld7eYCIjCvse2vn
 hGY2v+yHekpVtL0+7CWhRaQLyf/q6r2HIwmZIgPNY0in9HrGmmGpg5YzexXEqDH2A3YVzEwMFiq
 fDKKwYfQMq8d3cv7XisS6D2KE37d/2mYU=
X-Google-Smtp-Source: AGHT+IGEgI5iMsMDjY03NGn+HZxm+z7Pcynq4eCuhNpqJykpCKTIPoLHt3hnQEPmjweISU5ueU/0/g==
X-Received: by 2002:a05:600c:8717:b0:468:7f92:5a80 with SMTP id
 5b1f17b1804b1-46e61285691mr28349045e9.27.1759331203122; 
 Wed, 01 Oct 2025 08:06:43 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e5c4afb3asm36603595e9.6.2025.10.01.08.06.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 08:06:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Subject: [PATCH 14/22] target/loongarch: Get cpu first addr space with
 cpu_get_address_space()
Date: Wed,  1 Oct 2025 17:05:19 +0200
Message-ID: <20251001150529.14122-15-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001150529.14122-1-philmd@linaro.org>
References: <20251001150529.14122-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

In order to remove the convenient CPUState::as field, access
the vcpu first address space using the cpu_get_address_space()
helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/loongarch/cpu_helper.c     | 5 +++--
 target/loongarch/tcg/tlb_helper.c | 7 +++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 4a9db3ea4c1..f2ee66d0d52 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -110,6 +110,7 @@ static TLBRet loongarch_page_table_walker(CPULoongArchState *env,
                                           int access_type, int mmu_idx)
 {
     CPUState *cs = env_cpu(env);
+    AddressSpace *as = cpu_get_address_space(cs, 0);
     target_ulong index, phys;
     uint64_t dir_base, dir_width;
     uint64_t base;
@@ -134,7 +135,7 @@ static TLBRet loongarch_page_table_walker(CPULoongArchState *env,
         /* get next level page directory */
         index = (address >> dir_base) & ((1 << dir_width) - 1);
         phys = base | index << 3;
-        base = ldq_phys(cs->as, phys) & TARGET_PHYS_MASK;
+        base = ldq_phys(as, phys) & TARGET_PHYS_MASK;
         if (FIELD_EX64(base, TLBENTRY, HUGE)) {
             /* base is a huge pte */
             break;
@@ -155,7 +156,7 @@ static TLBRet loongarch_page_table_walker(CPULoongArchState *env,
         get_dir_base_width(env, &dir_base, &dir_width, 0);
         index = (address >> dir_base) & ((1 << dir_width) - 1);
         phys = base | index << 3;
-        base = ldq_phys(cs->as, phys);
+        base = ldq_phys(as, phys);
     }
 
     context->ps = dir_base;
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 8cfce48a297..5173e30b531 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -600,6 +600,7 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
     CPUState *cs = env_cpu(env);
     target_ulong badvaddr, index, phys;
     uint64_t dir_base, dir_width;
+    AddressSpace *as;
 
     if (unlikely((level == 0) || (level > 4))) {
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -621,12 +622,13 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
         }
     }
 
+    as = cpu_get_address_space(cs, 0);
     badvaddr = env->CSR_TLBRBADV;
     base = base & TARGET_PHYS_MASK;
     get_dir_base_width(env, &dir_base, &dir_width, level);
     index = (badvaddr >> dir_base) & ((1 << dir_width) - 1);
     phys = base | index << 3;
-    return ldq_phys(cs->as, phys) & TARGET_PHYS_MASK;
+    return ldq_phys(as, phys) & TARGET_PHYS_MASK;
 }
 
 void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
@@ -680,6 +682,7 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
             return;
         }
     } else {
+        AddressSpace *as = cpu_get_address_space(cs, 0);
         badv = env->CSR_TLBRBADV;
 
         ptindex = (badv >> ptbase) & ((1 << ptwidth) - 1);
@@ -687,7 +690,7 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
         ptoffset0 = ptindex << 3;
         ptoffset1 = (ptindex + 1) << 3;
         phys = base | (odd ? ptoffset1 : ptoffset0);
-        tmp0 = ldq_phys(cs->as, phys) & TARGET_PHYS_MASK;
+        tmp0 = ldq_phys(as, phys) & TARGET_PHYS_MASK;
         ps = ptbase;
     }
 
-- 
2.51.0


