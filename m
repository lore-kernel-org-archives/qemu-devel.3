Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5023CCCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 20:19:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8lJG-00027E-O4; Tue, 14 Oct 2025 16:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lJE-000262-A3
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:07:48 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lIt-0005KH-10
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:07:48 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b633b54d05dso3738298a12.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 13:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760472443; x=1761077243; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nVLp2fMlNwwT84vDf2syQ7Ds5F9iDytds/Dwe6kgLt8=;
 b=BRsx4Z51DGoR5yBPilIF/AJZTSGUjXttk6NkCHrOKYjK/FSS69i4a/TTrpnPJG2yGI
 SPCQ0h0TE8XH+xXaZ8C2wBUAyA/MyJiIojG7nDdd+dmbZnOoci9V8ariCUjtQ1MuAlZk
 3BAHkxDvnrehLt20OGWPDHtnNIbpqTzR06eu2xZRqM073WPDpF4EsFGXKgdNwgTMhaKb
 1Tym61M1FD0V/9TbJntsUp3qgm7VDFWbAOWHSserilkvwq2fjs5W3iqDCaNlZ7VDUlgQ
 gBi/WJXr3uEW5dHt5noxtv9x/RnqYn0AOLCOQsCAtV/1/mfxuqR1Nvkzp207+eDKoDZ1
 s6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760472443; x=1761077243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nVLp2fMlNwwT84vDf2syQ7Ds5F9iDytds/Dwe6kgLt8=;
 b=JPViOlFiqixFKWKtKO4UKgIy/UTfUVt8rlW6p571SRFa7XOsQSMHGyKAavVjQV1vtM
 oj3SqQ77SovBxhDfVmc2ncPG7ffnINZkTFX9+syYF4b49hhfKM3j87/dnm//LSCVSGLh
 /On1N+/iTck+S/z4tY39xH0ham3VRUK3MImG/ubpCVgQcTrPLXC1mg9JkND8oFVehUuA
 00yg2GKu9vd1McXhBGqPbeuK3BTQ7HT4y6ocL7RVWVXTiUeJstbHEj0D20eWzNtzjhox
 rBRa5NT36zsk5IUzkdPil3/yZDt1EHDhHqjDyPcLWXsMjOE6Ls93lXZp2JSvG+8DHXhI
 ktzw==
X-Gm-Message-State: AOJu0YzFGkJFvBOzHIl2qBlDijuQFpyXpMwYEeLX/okXErmFQFbMuPim
 bjsAJ55nLCSXeRQ18WIHS5yjL/ls+nSYkQpAxNbktVgSN2tdRGusgoyc1wo3js8iD/35ejGqGCd
 QrdCnzLo=
X-Gm-Gg: ASbGnctgwCkYFz3X17UXfQ7E6l2zdUa1Tm2XcZHKyae52G7jKJ/0AH1/BvuFED0oBV4
 bXjZ5uLhbukMgC6czJqwcdLY/fzv9FY2atb2B5YwW6/lQqE94su75THzu2MzBGz/iKV5+EpTt3i
 KwRwQawLLgqTBYH9TWaGJklAXLvxvAPEaDdSKTMbL4y8Ww48nw/2hYGA0hc36aYD9LHjFz8o/9c
 LFXLMeI/rA8mdm9u86gK8LGuOPWwK+XTX8VU1UWgkfBfFMWRJorkPPJ8/ZCmzQTDY4qgZqc57Pn
 q/qqdSLyun9J05AVJ3e70kx/+/qP/6/bwT0kvnkPTQRRJx6T48hpiA4xxw9DTvNWkaQ96Su/Je6
 8zFTkR7GyTMWRBKwkHus9QM/Mz4JgJccboBmWfL71FsKSZUjS/stAaM/Yh/2+MWrLvQEPymHotX
 2dCpxyRi3Iyw==
X-Google-Smtp-Source: AGHT+IF3BrAmthwPP0cKfOYrGdFnqXDCZjrsoW5R/7pgybN6uH6v2dWfQrTGHH7lapZcdSv4utMSVA==
X-Received: by 2002:a17:903:32cd:b0:269:8fa3:c227 with SMTP id
 d9443c01a7336-2902721310amr330372025ad.8.1760472442677; 
 Tue, 14 Oct 2025 13:07:22 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f93ea2sm172100975ad.126.2025.10.14.13.07.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 13:07:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 05/37] target/arm: Split add_cpreg_to_hashtable_aa64
Date: Tue, 14 Oct 2025 13:06:46 -0700
Message-ID: <20251014200718.422022-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014200718.422022-1-richard.henderson@linaro.org>
References: <20251014200718.422022-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

Rename the existing add_cpreg_to_hashtable_aa64 as *_1.
Introduce a new add_cpreg_to_hashtable_aa64 that handles
128-bit and 64-bit views of an AArch64 system register.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 61 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3b06704963..c240edf182 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7668,11 +7668,9 @@ static void add_cpreg_to_hashtable_aa32(ARMCPU *cpu, ARMCPRegInfo *r)
     }
 }
 
-static void add_cpreg_to_hashtable_aa64(ARMCPU *cpu, ARMCPRegInfo *r)
+static void add_cpreg_to_hashtable_aa64_1(ARMCPU *cpu, ARMCPRegInfo *r,
+                                          uint32_t key)
 {
-    uint32_t key = ENCODE_AA64_CP_REG(r->opc0, r->opc1,
-                                      r->crn, r->crm, r->opc2);
-
     if ((r->type & ARM_CP_ADD_TLBI_NXS) &&
         cpu_isar_feature(aa64_xs, cpu)) {
         /*
@@ -7740,6 +7738,10 @@ static void add_cpreg_to_hashtable_aa64(ARMCPU *cpu, ARMCPRegInfo *r)
         r2->writefn = NULL;
         r2->raw_readfn = NULL;
         r2->raw_writefn = NULL;
+        r2->read128fn = NULL;
+        r2->write128fn = NULL;
+        r2->raw_read128fn = NULL;
+        r2->raw_write128fn = NULL;
         r2->accessfn = NULL;
         r2->fieldoffset = 0;
 
@@ -7761,6 +7763,57 @@ static void add_cpreg_to_hashtable_aa64(ARMCPU *cpu, ARMCPRegInfo *r)
                            ARM_CP_SECSTATE_NS, key);
 }
 
+static void add_cpreg_to_hashtable_aa64(ARMCPU *cpu, ARMCPRegInfo *r)
+{
+    uint32_t key64 = ENCODE_AA64_CP_REG(r->opc0, r->opc1,
+                                        r->crn, r->crm, r->opc2);
+
+    /*
+     * All 128-bit system registers and instructions have 64-bit aliases.
+     * If the 128-bit feature is enabled, create a duplicate.
+     */
+    if (r->type & ARM_CP_128BIT) {
+        if (cpu_isar_feature(aa64_sysreg128, cpu) ||
+            cpu_isar_feature(aa64_sysinstr128, cpu)) {
+            ARMCPRegInfo *r128 = alloc_cpreg(r, NULL);
+            uint32_t key128 = key64 | CP_REG_AA64_128BIT_MASK;
+
+            r128->accessfn = r128->access128fn;
+            r128->access128fn = NULL;
+            r128->readfn = NULL;
+            r128->writefn = NULL;
+            r128->raw_readfn = NULL;
+            r128->raw_writefn = NULL;
+
+            if (r128->vhe_redir_to_el2) {
+                r128->vhe_redir_to_el2 |= CP_REG_AA64_128BIT_MASK;
+            }
+            if (r128->vhe_redir_to_el01) {
+                r128->vhe_redir_to_el01 |= CP_REG_AA64_128BIT_MASK;
+            }
+
+            add_cpreg_to_hashtable_aa64_1(cpu, r128, key128);
+
+            /*
+             * The 128-bit definition is the canonical view.
+             * The 64-bit definition is an alias, hidden from gdb.
+             */
+            r->type |= ARM_CP_ALIAS | ARM_CP_NO_GDB;
+        }
+
+        /* Squash the original to create the 64-bit view. */
+        r->type &= ~ARM_CP_128BIT;
+        r->access128fn = NULL;
+        r->read128fn = NULL;
+        r->write128fn = NULL;
+        r->raw_read128fn = NULL;
+        r->raw_write128fn = NULL;
+        r->fieldoffsethi = 0;
+    }
+
+    add_cpreg_to_hashtable_aa64_1(cpu, r, key64);
+}
+
 void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
 {
     /*
-- 
2.43.0


