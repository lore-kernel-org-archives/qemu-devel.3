Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D007CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:03:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRCs-00044n-Sf; Mon, 11 May 2026 10:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wMRCM-0003xf-OG
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:01:35 -0400
Received: from mail-vs1-xe2d.google.com ([2607:f8b0:4864:20::e2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wMRCJ-000663-Lw
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:01:30 -0400
Received: by mail-vs1-xe2d.google.com with SMTP id
 ada2fe7eead31-6313c800372so2265063137.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 07:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778508086; x=1779112886; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Do+ufpOA4YSJpqU1qNqftH/AxWOZ177vIBGpoAZmUk4=;
 b=dQIX7OwEoo0B3dfqJ241fdeZu1AI+nM3BnptVv8/i5Pi5jgU+CW+7FUfeOqR9eSUWV
 5t61FVCtF6MpGMdgi9BAzWkzvkDpf5A9PHDRE6fJLuMWyTurfoXcsnsild5LW5a8biCZ
 PtDm8w330aRlGCkNEk5SNsjzm6fDWVOdX4/wf2lz8viP5i6OAFZKn+3sm1vJCAUmKtnY
 eDgi9LkOYxGf1s7oRkRomC8eU/7eYJR2NC+uXF2scjBh/uABWZhamtFiUJyUFP78/ASV
 77cVmQ+KJwH0HiWeG+jkV378VewIyVLdxfwPeuU1cISqaPGyv6fGyon4K7q/crsUVlGD
 mD/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778508086; x=1779112886;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Do+ufpOA4YSJpqU1qNqftH/AxWOZ177vIBGpoAZmUk4=;
 b=hbXelLqsYkuc/YnzgSA1n8gzKta19e1YuLS7aU76LMdGdKNXbuuJ5Wa1Xvwv8MSXYI
 XlyGcVDCORy+H4TumOF5zO7UPOtY5hGt8V4Z2vPyeHUudeEzoeeq6U/f6Z8K8rqdMXF0
 augwhBmtqvECYbBbJZLHM61AjbJm7nG2c1+x8kLk/BfMvuvTKtXlH76bxyGeZXaay6fR
 TwO0IvCEocf90FdcbhnJVYazvE9tJmANYfPGDZ0fdZ12jP/0E//GJ+fZBrwomA+DFvwB
 OSrj7vi2MLSN7C+GEi08s3cqCmfzQWFkmYH0Zz48D6CXJYCJ/qtjELGhl0CEbk6qxxHR
 XPeg==
X-Gm-Message-State: AOJu0YzW3eGXy8wnC86VI9hxGAXLcMnM0v+q5bXazehWI9Q821VSvcbf
 xIPpFeVGCVNDBfmhNYke3fOMw3ximtvEXIApx6AV4UM3YaRCQYqYb4sQ
X-Gm-Gg: Acq92OEpGvrEBRAng3jsSH5bzSJoUzKb36KG9hmB1Hei7BhRAbOlk6M1NdyZKJ5Bpd4
 y938gKQKAs0AX7CcjUog8gKQEvjN7ma4YT0IGvigTq0y/grZ19iWvKvY6HAKvCV/ea9y55zZIvV
 7/9Nrblt888O2TpeS0knOTN8+q4DAxk/QuYrMZNrkALxScEZC3Gwkub+qsCYRqehfs4ZEgMEU73
 lQUGTz66m/txHGjk431dQQgDnEm6e0UrT4V6keBe9bwFMWITGCkEeVwpBHqXJjZUxMOuxK51UoC
 pJ9MtTmz9lrEBiha1v5tZuDMGM7r0ijtiAKD4dP2MWZBVkCInosuUHZa4eHw/zhldc5iD/HE13j
 sFS1z5kaUNzpC6xs6VIrinE93wq3itYTsBiK5Z+wFqviV8vyjFKhG6bpDkELAu38Jne19ThNRHk
 qrB56WiCYFPVs1Q6XfyNL9CWfwyz5ekcS5pj7LUM/SybC0P2R7T3k=
X-Received: by 2002:a05:6102:3a0c:b0:631:8665:3510 with SMTP id
 ada2fe7eead31-631dc7ac519mr3885381137.31.1778508081818; 
 Mon, 11 May 2026 07:01:21 -0700 (PDT)
Received: from [192.168.1.160] ([2600:4041:54f3:a400:c013:3550:ed5f:a59a])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8bf39c7dd09sm94773756d6.31.2026.05.11.07.01.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 07:01:20 -0700 (PDT)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Mon, 11 May 2026 10:01:09 -0400
Subject: [PATCH v6 11/15] target/arm: skip tag bit bounds check if MTX is
 on
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-feat-mte4-v6-11-8557cc1313b9@gmail.com>
References: <20260511-feat-mte4-v6-0-8557cc1313b9@gmail.com>
In-Reply-To: <20260511-feat-mte4-v6-0-8557cc1313b9@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Gabriel Brookman <brookmangabriel@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778508062; l=5222;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=8jE/ExnW0afjmNINEpEf2ghGWWW+eTv/eM0GgsItKvo=;
 b=IzdpqFoLBsC4f/A5VQt3FOCjt3HJPfl8/b+lLGMG4Wf+JhG9U/uYBm8GGrgbQQNtqhPh9lf7B
 nb1g7CQhkX8DpCHSUB3BqS1jOLvhe5aG4D9PWwp+Lhh9kaXL8rnOULl
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2d;
 envelope-from=brookmangabriel@gmail.com; helo=mail-vs1-xe2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Virtual address canonicity checks should ignore mismatch in tag bits
during translation step if MTX is set. This mismatch is checked during
the tag check instead, in that case.

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
---
 target/arm/helper.c    |  6 +++++-
 target/arm/internals.h |  1 +
 target/arm/ptw.c       | 35 ++++++++++++++++++++++++++++++-----
 3 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 18352bd186..0e70822d34 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9693,7 +9693,7 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
 {
     uint64_t tcr = regime_tcr(env, mmu_idx);
     bool epd, hpd, tsz_oob, ds, ha, hd, pie = false;
-    bool aie = false;
+    bool mtx, aie = false;
     int select, tsz, tbi, max_tsz, min_tsz, ps, sh;
     ARMGranuleSize gran;
     ARMCPU *cpu = env_archcpu(env);
@@ -9730,6 +9730,7 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
         ha = extract32(tcr, 21, 1) && cpu_isar_feature(aa64_hafs, cpu);
         hd = extract32(tcr, 22, 1) && cpu_isar_feature(aa64_hdbs, cpu);
         ds = extract64(tcr, 32, 1);
+        mtx = extract64(tcr, 33, 1) && cpu_isar_feature(aa64_mte_mtx, cpu);
     } else {
         bool e0pd;
 
@@ -9745,6 +9746,7 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
             sh = extract32(tcr, 12, 2);
             hpd = extract64(tcr, 41, 1);
             e0pd = extract64(tcr, 55, 1);
+            mtx = extract64(tcr, 60, 1) && cpu_isar_feature(aa64_mte_mtx, cpu);
         } else {
             tsz = extract32(tcr, 16, 6);
             gran = tg1_to_gran_size(extract32(tcr, 30, 2));
@@ -9752,6 +9754,7 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
             sh = extract32(tcr, 28, 2);
             hpd = extract64(tcr, 42, 1);
             e0pd = extract64(tcr, 56, 1);
+            mtx = extract64(tcr, 61, 1) && cpu_isar_feature(aa64_mte_mtx, cpu);
         }
         ps = extract64(tcr, 32, 3);
         ha = extract64(tcr, 39, 1) && cpu_isar_feature(aa64_hafs, cpu);
@@ -9851,6 +9854,7 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
         .gran = gran,
         .pie = pie,
         .aie = aie,
+        .mtx = mtx,
     };
 }
 
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 779eafabc8..d313d36603 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1407,6 +1407,7 @@ typedef struct ARMVAParameters {
     ARMGranuleSize gran : 2;
     bool pie        : 1;
     bool aie        : 1;
+    bool mtx        : 1;
 } ARMVAParameters;
 
 /**
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 467d815e0d..64778a7649 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1951,9 +1951,18 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
      * validation to do here.
      */
     if (inputsize < addrsize) {
-        uint64_t top_bits = sextract64(address, inputsize,
-                                           addrsize - inputsize);
-        if (-top_bits != param.select) {
+        /*
+         * If MTX is enabled, bits 56-59 aren't checked for canonicity
+         * during translation, since they will later be checked during
+         * the tag check step.
+         */
+
+        uint64_t cmp_mask = MAKE_64BIT_MASK(inputsize, addrsize - inputsize);
+
+        if (param.mtx) {
+            cmp_mask &= ~MAKE_64BIT_MASK(56, 4);
+        }
+        if ((address ^ -param.select) & cmp_mask) {
             /* The gap between the two regions is a Translation fault */
             goto do_translation_fault;
         }
@@ -3513,15 +3522,31 @@ static bool get_phys_addr_disabled(CPUARMState *env,
             int pamax = arm_pamax(env_archcpu(env));
             uint64_t tcr = env->cp15.tcr_el[r_el];
             int addrtop, tbi;
+            bool bit55;
 
             tbi = aa64_va_parameter_tbi(tcr, mmu_idx);
             if (access_type == MMU_INST_FETCH) {
                 tbi &= ~aa64_va_parameter_tbid(tcr, mmu_idx);
             }
-            tbi = (tbi >> extract64(address, 55, 1)) & 1;
+            bit55 = extract64(address, 55, 1);
+            tbi = (tbi >> bit55) & 1;
             addrtop = (tbi ? 55 : 63);
 
-            if (extract64(address, pamax, addrtop - pamax + 1) != 0) {
+            /*
+             * With MTX enabled, bits 56-59 are not checked according to
+             * AArch64.S1DisabledOutput.
+             */
+            uint64_t cmp_mask = MAKE_64BIT_MASK(pamax, addrtop - pamax + 1);
+
+            if (access_type != MMU_INST_FETCH &&
+                cpu_isar_feature(aa64_mte_mtx, env_archcpu(env))) {
+                int mtx = aa64_va_parameter_mtx(tcr, mmu_idx);
+                if (mtx & (1 << bit55)) {
+                    cmp_mask &= ~MAKE_64BIT_MASK(56, 4);
+                }
+            }
+
+            if (address & cmp_mask) {
                 fi->type = ARMFault_AddressSize;
                 fi->level = 0;
                 fi->stage2 = false;

-- 
2.54.0


