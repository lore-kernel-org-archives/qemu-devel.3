Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23FAFCA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 01:24:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur4du-0000mr-Hy; Tue, 26 Aug 2025 21:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4di-0008EF-V3
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:07:51 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4db-0007cr-PD
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:07:49 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-770d7dafacdso3339227b3a.0
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756256859; x=1756861659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fQtW1VuVxg7+Obq+lNxml0rtcuIJugDUSAdlvV8elWI=;
 b=AC1LResSl6bciqRPQXO8pWFHlUgQGoiRe6Bnep7JTqLRYWEooCsRchPsSd/Rq1W0Im
 TsE7oGstBnJ6jY2AZyaTUZOROafQTAB7rd/uGsyv1NwTbqpRlDXgoZZ8yVDO5vnP+yFz
 SWjwWNo3BVfQXdcTges++SkkAnFvA26H0GlPXZ0xacU6juaeGggY0u6dxnMGneRbuAKp
 7HgnoexUzIzBUMMVVSpNzWy3vE0pgD0QV2sAvX+pbmo+RMnuTJFVySc0q/PCQCe6l/Zs
 lJNKpq7NSKHo3zBekOOe31FIitrW7EdUHM6Mv0/veiqNuJKxPDq3UlBy7crqlwLGIkml
 mPDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756256859; x=1756861659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fQtW1VuVxg7+Obq+lNxml0rtcuIJugDUSAdlvV8elWI=;
 b=i5oFSbv2ZhBcMXR09kRgUD24QYxQDeWwiiUy1flC9huPp0z1vjsCvUZcAEz40Q6TNo
 tN+hsVGOoSUqCdXNPUYykUabdzT83kUgU4C5ecmqKXENj704M7RBuYesVNCW6aan8+il
 RkD+iEG3AlpWnE4DIuheNU2HLgmctRFJ5qT4OjyNtEOeHWTW3OlnKAzoGT1mYYR7usJy
 AEoqn9OCjy2qlrbdXCdeXcLbJAFHcUoVpOwC6/55PSO+C0ezcmDyuoNaFFON5lQk4qFS
 1ann8GmvNB/m+4vsI+A8jF3RiVynks2sG8HJVEzzDncEg7JlZWczAeu22m28GhTccXT+
 Xu+g==
X-Gm-Message-State: AOJu0YwStdn75Hiemxqlb3+jDytZXUOMZ79dShW6kZvccNN7T4uAqyWU
 sWRocRSKZoz7vpAIVHrmZuWty/LDx+VGVEoc3I3scyRspHiqfawYoAVJ0s07E1TZKXD+DdIPqBP
 WGaBwbH8=
X-Gm-Gg: ASbGncvWq5YcRGYnPyDkFRhK8RioTeu+XxgQyaXKuIUBUVtKo8cgauPCshAZq1En252
 QbCie9jI0qIuIngqd61vUyycYT5aF850octuDcDfexeG4YjWoDwC1Iex90Z4JAtondmiGEKG2kQ
 VKlCDOVpqsE53zyGBTiPMwIoaKU7sy6F8NtGUU9eFo+evHyshxQOa9u4tYwROUJHzSjYGfFe8/a
 I9ECDsti8qlws+8R2gUPeZfxwVePqqOFM2vaI/TTMv9aqLUNq8LmyLQ0HgGMG/XWl6iLhCJz9ks
 lGwkYvL/9D1JMy5WWLzgrTp5AiE2Obg9C4qCD79aojS4Rq1MYSbxxmMiWi1LapzNmBT4uBTZ63W
 lmxlivZDCXPDnxecG12GYsr4kEXVzKQKFdaMh9S8psq2oqeM=
X-Google-Smtp-Source: AGHT+IF08gwjfpY/vHIP/8p+0uA04w7LU4wFS5OH5xw1i/uEKMfARoFXDE0Mg9KlRiHq+dzPIyL1BA==
X-Received: by 2002:a05:6a21:328b:b0:240:2d32:500 with SMTP id
 adf61e73a8af0-24340b58571mr25942695637.13.1756256858784; 
 Tue, 26 Aug 2025 18:07:38 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7720274534esm1419241b3a.47.2025.08.26.18.07.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 18:07:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 29/61] target/arm: Move writeback of CP_ANY fields
Date: Wed, 27 Aug 2025 11:04:20 +1000
Message-ID: <20250827010453.4059782-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827010453.4059782-1-richard.henderson@linaro.org>
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Move the writeback of cp, crm, opc1, opc2 to define_one_arm_cp_reg,
which means we don't have to pass all those parameters down
to subroutines.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 52 ++++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 1a321ad181..66e70abc76 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7291,7 +7291,6 @@ static ARMCPRegInfo *alloc_cpreg(const ARMCPRegInfo *in, const char *suffix)
  */
 static void add_cpreg_to_hashtable(ARMCPU *cpu, ARMCPRegInfo *r,
                                    CPState state, CPSecureState secstate,
-                                   int cp, int crm, int opc1, int opc2,
                                    uint32_t key)
 {
     CPUARMState *env = &cpu->env;
@@ -7358,12 +7357,8 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, ARMCPRegInfo *r,
 
     /*
      * Update fields to match the instantiation, overwiting wildcards
-     * such as CP_ANY, ARM_CP_STATE_BOTH, or ARM_CP_SECSTATE_BOTH.
+     * such as ARM_CP_STATE_BOTH or ARM_CP_SECSTATE_BOTH.
      */
-    r->cp = cp;
-    r->crm = crm;
-    r->opc1 = opc1;
-    r->opc2 = opc2;
     r->state = state;
     r->secure = secstate;
 
@@ -7379,8 +7374,7 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, ARMCPRegInfo *r,
     g_hash_table_insert(cpu->cp_regs, (gpointer)(uintptr_t)key, r);
 }
 
-static void add_cpreg_to_hashtable_aa32(ARMCPU *cpu, ARMCPRegInfo *r,
-                                        int cp, int crm, int opc1, int opc2)
+static void add_cpreg_to_hashtable_aa32(ARMCPU *cpu, ARMCPRegInfo *r)
 {
     /*
      * Under AArch32 CP registers can be common
@@ -7388,7 +7382,8 @@ static void add_cpreg_to_hashtable_aa32(ARMCPU *cpu, ARMCPRegInfo *r,
      */
     ARMCPRegInfo *r_s;
     bool is64 = r->type & ARM_CP_64BIT;
-    uint32_t key = ENCODE_CP_REG(cp, is64, 0, r->crn, crm, opc1, opc2);
+    uint32_t key = ENCODE_CP_REG(r->cp, is64, 0, r->crn,
+                                 r->crm, r->opc1, r->opc2);
 
     assert(!(r->type & ARM_CP_ADD_TLBI_NXS)); /* aa64 only */
 
@@ -7397,27 +7392,26 @@ static void add_cpreg_to_hashtable_aa32(ARMCPU *cpu, ARMCPRegInfo *r,
         key |= CP_REG_AA32_NS_MASK;
         /* fall through */
     case ARM_CP_SECSTATE_S:
-        add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA32, r->secure,
-                               cp, crm, opc1, opc2, key);
+        add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA32, r->secure, key);
         break;
     case ARM_CP_SECSTATE_BOTH:
         r_s = alloc_cpreg(r, "_S");
-        add_cpreg_to_hashtable(cpu, r_s, ARM_CP_STATE_AA32, ARM_CP_SECSTATE_S,
-                               cp, crm, opc1, opc2, key);
+        add_cpreg_to_hashtable(cpu, r_s, ARM_CP_STATE_AA32,
+                               ARM_CP_SECSTATE_S, key);
 
         key |= CP_REG_AA32_NS_MASK;
-        add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA32, ARM_CP_SECSTATE_NS,
-                               cp, crm, opc1, opc2, key);
+        add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA32,
+                               ARM_CP_SECSTATE_NS, key);
         break;
     default:
         g_assert_not_reached();
     }
 }
 
-static void add_cpreg_to_hashtable_aa64(ARMCPU *cpu, ARMCPRegInfo *r,
-                                        int crm, int opc1, int opc2)
+static void add_cpreg_to_hashtable_aa64(ARMCPU *cpu, ARMCPRegInfo *r)
 {
-    uint32_t key = ENCODE_AA64_CP_REG(r->opc0, opc1, r->crn, crm, opc2);
+    uint32_t key = ENCODE_AA64_CP_REG(r->opc0, r->opc1,
+                                      r->crn, r->crm, r->opc2);
 
     if ((r->type & ARM_CP_ADD_TLBI_NXS) &&
         cpu_isar_feature(aa64_xs, cpu)) {
@@ -7442,12 +7436,11 @@ static void add_cpreg_to_hashtable_aa64(ARMCPU *cpu, ARMCPRegInfo *r,
         }
 
         add_cpreg_to_hashtable(cpu, nxs_ri, ARM_CP_STATE_AA64,
-                               ARM_CP_SECSTATE_NS, 0, crm, opc1, opc2,
-                               nxs_key);
+                               ARM_CP_SECSTATE_NS, nxs_key);
     }
 
-    add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA64, ARM_CP_SECSTATE_NS,
-                           0, crm, opc1, opc2, key);
+    add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA64,
+                           ARM_CP_SECSTATE_NS, key);
 }
 
 void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
@@ -7667,17 +7660,24 @@ void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
                     r2->type |= ARM_CP_ALIAS | ARM_CP_NO_GDB;
                 }
 
+                /* Overwrite CP_ANY with the instantiation. */
+                r2->crm = crm;
+                r2->opc1 = opc1;
+                r2->opc2 = opc2;
+
                 switch (r->state) {
                 case ARM_CP_STATE_AA32:
-                    add_cpreg_to_hashtable_aa32(cpu, r2, cp, crm, opc1, opc2);
+                    add_cpreg_to_hashtable_aa32(cpu, r2);
                     break;
                 case ARM_CP_STATE_AA64:
-                    add_cpreg_to_hashtable_aa64(cpu, r2, crm, opc1, opc2);
+                    add_cpreg_to_hashtable_aa64(cpu, r2);
                     break;
                 case ARM_CP_STATE_BOTH:
                     r3 = alloc_cpreg(r2, NULL);
-                    add_cpreg_to_hashtable_aa32(cpu, r2, cp, crm, opc1, opc2);
-                    add_cpreg_to_hashtable_aa64(cpu, r3, crm, opc1, opc2);
+                    r2->cp = cp;
+                    add_cpreg_to_hashtable_aa32(cpu, r2);
+                    r3->cp = 0;
+                    add_cpreg_to_hashtable_aa64(cpu, r3);
                     break;
                 default:
                     g_assert_not_reached();
-- 
2.43.0


