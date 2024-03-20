Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE674C54E68
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 00:33:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmjsl-00006Q-JQ; Tue, 19 Mar 2024 20:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmjsk-000063-1q
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 20:32:38 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmjsi-0005Xk-IT
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 20:32:37 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6e6bee809b8so5720898b3a.1
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 17:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710894754; x=1711499554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xRQsRljrAfs8L69FUoxySpj8nUCWLZR7KoskL/j5Jqs=;
 b=PGPBS1+1a28Yc/D14I+babu+LGAA/dlv0FZWOX0lYEb8hwJzGN6IFwsyLDXL3aTP3R
 GsZMSCVaz27t+tds+nX0uh/KvwjvJiLvt85EcCuikmAWVLzp23bWMr2Vu9387n94a1sO
 g1q5EawV+x7NxqT9MAcx8jHnaVwAxMgunGHqTpdZ8490+2T4KD2v3LJA8qU338rjop9h
 InKuYDfHmGTCpM1ERD6nkMJEO8Nazj6okyxgFrec+KLmpN/j0ms4LPMexsPF0TnzrfEH
 YP9fd6KEUWogNbbPCZW1AE5xm+qPZierA62goYRLnqyfaflW2Oj4si5WdirReLzqtIgG
 NoTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710894754; x=1711499554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xRQsRljrAfs8L69FUoxySpj8nUCWLZR7KoskL/j5Jqs=;
 b=ty6FGNDMO+59sOrFUMoFhacHNN6vaI5dJ7p6N+6KTpaIw1U4r54r80rCXoa9qey3Vs
 sfVuT3cnO1y30v41p86KXwiENINtnIqbr2tgMGxs/33sc4a0LWTPLKE1Mr+hKBIqs0iy
 zrmq16BuVi8BR0VfuJGSnbjM0XKwpwBnAEtWU8EE4OyJtHsBcSvvvhwikpUIxTNcO7VH
 mGS8U65QbZvdZrQ+XJj4xrkC3rvJ5htrvrcPH0pWZLQXybjYes2wEVNwrHp1hh6KS+pi
 jLKbhC1WKd58sd0ZTGckttUV0Xarbv4g/W0R2FmGEs5Dzey2av47/9WjaQH8STNfPGem
 nwbQ==
X-Gm-Message-State: AOJu0Yyln6Af6jJ6zxDWvwebV5/S4tCwhwbyZsbOIPXb+kYl3fwepM2G
 N0JMTrf2meahwqLb2flvc9j4dRQL4HB6eCWoC4G/aUDMSTUL5IINkNmEZB7yhwU5p2ypPWs14Gv
 n
X-Google-Smtp-Source: AGHT+IHib8PFS/mWitKtm7NwFaD9Z+rXiAb3T8FbuaD98iqmNQaCRIXKgt9sVr7t4UL9YHTNM6Cscw==
X-Received: by 2002:a05:6a20:8418:b0:1a3:17f0:c4f3 with SMTP id
 c24-20020a056a20841800b001a317f0c4f3mr956260pzd.35.1710894754296; 
 Tue, 19 Mar 2024 17:32:34 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 d19-20020a63d653000000b005d553239b16sm8475645pgj.20.2024.03.19.17.32.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 17:32:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Sven Schnelle <svens@stackframe.org>
Subject: [PULL 6/9] target/hppa: fix access_id check
Date: Tue, 19 Mar 2024 14:32:20 -1000
Message-Id: <20240320003223.554145-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320003223.554145-1-richard.henderson@linaro.org>
References: <20240320003223.554145-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Sven Schnelle <svens@stackframe.org>

PA2.0 provides 8 instead of 4 PID registers.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240319161921.487080-4-svens@stackframe.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/mem_helper.c | 80 +++++++++++++++++++++++++++++++---------
 1 file changed, 62 insertions(+), 18 deletions(-)

diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 80f51e753f..84785b5a5c 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -152,6 +152,49 @@ static HPPATLBEntry *hppa_alloc_tlb_ent(CPUHPPAState *env)
     return ent;
 }
 
+#define ACCESS_ID_MASK 0xffff
+
+/* Return the set of protections allowed by a PID match. */
+static int match_prot_id_1(uint32_t access_id, uint32_t prot_id)
+{
+    if (((access_id ^ (prot_id >> 1)) & ACCESS_ID_MASK) == 0) {
+        return (prot_id & 1
+                ? PAGE_EXEC | PAGE_READ
+                : PAGE_EXEC | PAGE_READ | PAGE_WRITE);
+    }
+    return 0;
+}
+
+static int match_prot_id32(CPUHPPAState *env, uint32_t access_id)
+{
+    int r, i;
+
+    for (i = CR_PID1; i <= CR_PID4; ++i) {
+        r = match_prot_id_1(access_id, env->cr[i]);
+        if (r) {
+            return r;
+        }
+    }
+    return 0;
+}
+
+static int match_prot_id64(CPUHPPAState *env, uint32_t access_id)
+{
+    int r, i;
+
+    for (i = CR_PID1; i <= CR_PID4; ++i) {
+        r = match_prot_id_1(access_id, env->cr[i]);
+        if (r) {
+            return r;
+        }
+        r = match_prot_id_1(access_id, env->cr[i] >> 32);
+        if (r) {
+            return r;
+        }
+    }
+    return 0;
+}
+
 int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
                               int type, hwaddr *pphys, int *pprot,
                               HPPATLBEntry **tlb_entry)
@@ -224,29 +267,30 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
         break;
     }
 
-    /* access_id == 0 means public page and no check is performed */
-    if (ent->access_id && MMU_IDX_TO_P(mmu_idx)) {
-        /* If bits [31:1] match, and bit 0 is set, suppress write.  */
-        int match = ent->access_id * 2 + 1;
-
-        if (match == env->cr[CR_PID1] || match == env->cr[CR_PID2] ||
-            match == env->cr[CR_PID3] || match == env->cr[CR_PID4]) {
-            prot &= PAGE_READ | PAGE_EXEC;
-            if (type == PAGE_WRITE) {
-                ret = EXCP_DMPI;
-                goto egress;
-            }
-        }
-    }
-
-    /* No guest access type indicates a non-architectural access from
-       within QEMU.  Bypass checks for access, D, B and T bits.  */
+    /*
+     * No guest access type indicates a non-architectural access from
+     * within QEMU.  Bypass checks for access, D, B, P and T bits.
+     */
     if (type == 0) {
         goto egress;
     }
 
+    /* access_id == 0 means public page and no check is performed */
+    if (ent->access_id && MMU_IDX_TO_P(mmu_idx)) {
+        int access_prot = (hppa_is_pa20(env)
+                           ? match_prot_id64(env, ent->access_id)
+                           : match_prot_id32(env, ent->access_id));
+        if (unlikely(!(type & access_prot))) {
+            /* Not allowed -- Inst/Data Memory Protection Id Fault. */
+            ret = type & PAGE_EXEC ? EXCP_IMP : EXCP_DMPI;
+            goto egress;
+        }
+        /* Otherwise exclude permissions not allowed (i.e WD). */
+        prot &= access_prot;
+    }
+
     if (unlikely(!(prot & type))) {
-        /* The access isn't allowed -- Inst/Data Memory Protection Fault.  */
+        /* Not allowed -- Inst/Data Memory Access Rights Fault. */
         ret = (type & PAGE_EXEC) ? EXCP_IMP : EXCP_DMAR;
         goto egress;
     }
-- 
2.34.1


