Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E96C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:34:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNH9-0002BO-2I; Fri, 26 Jan 2024 09:33:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNH8-0002B5-4B
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:46 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNH6-0007rK-Bf
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:45 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-336c8ab0b20so462348f8f.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 06:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706279623; x=1706884423; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zP/lYKNH4Nfu30L6dAxijOyJutxvSbBpVMIqdo7k2Lk=;
 b=MtSdYjv0YRMbg/lqAnQ0kgiyHcQG1633SNqoMzaxxNbqfbO0bRVB694tZ2GmlDB3Za
 JsYjgAmdpr/CoYTX/wGVei6JG4M9GxDkW/1EyT2K6POKT5+xjSh5vbRA0txDYHcW2I64
 asH24uO/bCw95eG4dx2noITXt8eNDunk0HBxxw+qj6Dib5rzyLE7/0yhVfERGIMxogxI
 w2e8JIpdxo534AofEGYkb2GbXwMVJzDqQ85Ze5YlG9BkZKVYL10mZg93IHeGS6pOTUlF
 Vcso7l/+nO0suBYroeN4lu3k4+SqxHm+9IomCEf2MB1kFLa+sf11c7EnUbnMH8on2VS/
 I/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706279623; x=1706884423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zP/lYKNH4Nfu30L6dAxijOyJutxvSbBpVMIqdo7k2Lk=;
 b=sVzrBdrMWURDgd1ay9R7SWCiAgL5Qwl+DquFfpVCCBMERG1qbgUGk1ls4p+0nqSpMN
 JfPtHhvQxnhM/MVF932x3Q97ORZ5SFupVf6ZAitu9a8mnWwYNnR640ym1UdFOozkVMJA
 5wF0QeoNjIJiuy2Y8JDFEWVwGwYvkVbZlMXCwMzOQclsSIOviEfQOGKOePwVO5W8OHWV
 o1ZSYv5CrOSyj7VlaQ60GEJE/3UaCmmxo1XVA/fTjopkfVP8GXy3s8A6xWSNqoutxqcU
 7zsYpIRiRRbiJI6U3Z0/RorbewtH8bphlsmRHygn9SPne31Ot3yDBEr4xaaQAg/m2mAN
 +kJA==
X-Gm-Message-State: AOJu0YxPmlfxw35ceFqnFqbcGl4t890PEjr8eLo/nOZoI7PoJpzMlqNH
 TZSNPfGZq7ztiUwdM4C1MHhzl06PKwKtgtU5kiOO5wnu45/fQD/fJfAlc2LB36W3H/Jyw5v4dkx
 2
X-Google-Smtp-Source: AGHT+IFTxB9KxuSb/3KhnTp6lA0Kc+/qfeKdIS95NSRlIDuRfp5nUksU6beol6ljAHM11MONk7EpUg==
X-Received: by 2002:adf:fd07:0:b0:339:431b:90f4 with SMTP id
 e7-20020adffd07000000b00339431b90f4mr1125247wrr.100.1706279622995; 
 Fri, 26 Jan 2024 06:33:42 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a5d4845000000b00337f722e5ccsm1396207wrs.65.2024.01.26.06.33.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 06:33:42 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/36] target/xtensa: fix OOB TLB entry access
Date: Fri, 26 Jan 2024 14:33:06 +0000
Message-Id: <20240126143341.2101237-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126143341.2101237-1-peter.maydell@linaro.org>
References: <20240126143341.2101237-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Max Filippov <jcmvbkbc@gmail.com>

r[id]tlb[01], [iw][id]tlb opcodes use TLB way index passed in a register
by the guest. The host uses 3 bits of the index for ITLB indexing and 4
bits for DTLB, but there's only 7 entries in the ITLB array and 10 in
the DTLB array, so a malicious guest may trigger out-of-bound access to
these arrays.

Change split_tlb_entry_spec return type to bool to indicate whether TLB
way passed to it is valid. Change get_tlb_entry to return NULL in case
invalid TLB way is requested. Add assertion to xtensa_tlb_get_entry that
requested TLB way and entry indices are valid. Add checks to the
[rwi]tlb helpers that requested TLB way is valid and return 0 or do
nothing when it's not.

Cc: qemu-stable@nongnu.org
Fixes: b67ea0cd7441 ("target-xtensa: implement memory protection options")
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20231215120307.545381-1-jcmvbkbc@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/xtensa/mmu_helper.c | 47 ++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/target/xtensa/mmu_helper.c b/target/xtensa/mmu_helper.c
index 12552a33470..2fda4e887cc 100644
--- a/target/xtensa/mmu_helper.c
+++ b/target/xtensa/mmu_helper.c
@@ -224,22 +224,31 @@ static void split_tlb_entry_spec_way(const CPUXtensaState *env, uint32_t v,
  * Split TLB address into TLB way, entry index and VPN (with index).
  * See ISA, 4.6.5.5 - 4.6.5.8 for the TLB addressing format
  */
-static void split_tlb_entry_spec(CPUXtensaState *env, uint32_t v, bool dtlb,
-        uint32_t *vpn, uint32_t *wi, uint32_t *ei)
+static bool split_tlb_entry_spec(CPUXtensaState *env, uint32_t v, bool dtlb,
+                                 uint32_t *vpn, uint32_t *wi, uint32_t *ei)
 {
     if (xtensa_option_enabled(env->config, XTENSA_OPTION_MMU)) {
         *wi = v & (dtlb ? 0xf : 0x7);
-        split_tlb_entry_spec_way(env, v, dtlb, vpn, *wi, ei);
+        if (*wi < (dtlb ? env->config->dtlb.nways : env->config->itlb.nways)) {
+            split_tlb_entry_spec_way(env, v, dtlb, vpn, *wi, ei);
+            return true;
+        } else {
+            return false;
+        }
     } else {
         *vpn = v & REGION_PAGE_MASK;
         *wi = 0;
         *ei = (v >> 29) & 0x7;
+        return true;
     }
 }
 
 static xtensa_tlb_entry *xtensa_tlb_get_entry(CPUXtensaState *env, bool dtlb,
                                               unsigned wi, unsigned ei)
 {
+    const xtensa_tlb *tlb = dtlb ? &env->config->dtlb : &env->config->itlb;
+
+    assert(wi < tlb->nways && ei < tlb->way_size[wi]);
     return dtlb ?
         env->dtlb[wi] + ei :
         env->itlb[wi] + ei;
@@ -252,11 +261,14 @@ static xtensa_tlb_entry *get_tlb_entry(CPUXtensaState *env,
     uint32_t wi;
     uint32_t ei;
 
-    split_tlb_entry_spec(env, v, dtlb, &vpn, &wi, &ei);
-    if (pwi) {
-        *pwi = wi;
+    if (split_tlb_entry_spec(env, v, dtlb, &vpn, &wi, &ei)) {
+        if (pwi) {
+            *pwi = wi;
+        }
+        return xtensa_tlb_get_entry(env, dtlb, wi, ei);
+    } else {
+        return NULL;
     }
-    return xtensa_tlb_get_entry(env, dtlb, wi, ei);
 }
 
 static void xtensa_tlb_set_entry_mmu(const CPUXtensaState *env,
@@ -482,7 +494,12 @@ uint32_t HELPER(rtlb0)(CPUXtensaState *env, uint32_t v, uint32_t dtlb)
     if (xtensa_option_enabled(env->config, XTENSA_OPTION_MMU)) {
         uint32_t wi;
         const xtensa_tlb_entry *entry = get_tlb_entry(env, v, dtlb, &wi);
-        return (entry->vaddr & get_vpn_mask(env, dtlb, wi)) | entry->asid;
+
+        if (entry) {
+            return (entry->vaddr & get_vpn_mask(env, dtlb, wi)) | entry->asid;
+        } else {
+            return 0;
+        }
     } else {
         return v & REGION_PAGE_MASK;
     }
@@ -491,7 +508,12 @@ uint32_t HELPER(rtlb0)(CPUXtensaState *env, uint32_t v, uint32_t dtlb)
 uint32_t HELPER(rtlb1)(CPUXtensaState *env, uint32_t v, uint32_t dtlb)
 {
     const xtensa_tlb_entry *entry = get_tlb_entry(env, v, dtlb, NULL);
-    return entry->paddr | entry->attr;
+
+    if (entry) {
+        return entry->paddr | entry->attr;
+    } else {
+        return 0;
+    }
 }
 
 void HELPER(itlb)(CPUXtensaState *env, uint32_t v, uint32_t dtlb)
@@ -499,7 +521,7 @@ void HELPER(itlb)(CPUXtensaState *env, uint32_t v, uint32_t dtlb)
     if (xtensa_option_enabled(env->config, XTENSA_OPTION_MMU)) {
         uint32_t wi;
         xtensa_tlb_entry *entry = get_tlb_entry(env, v, dtlb, &wi);
-        if (entry->variable && entry->asid) {
+        if (entry && entry->variable && entry->asid) {
             tlb_flush_page(env_cpu(env), entry->vaddr);
             entry->asid = 0;
         }
@@ -537,8 +559,9 @@ void HELPER(wtlb)(CPUXtensaState *env, uint32_t p, uint32_t v, uint32_t dtlb)
     uint32_t vpn;
     uint32_t wi;
     uint32_t ei;
-    split_tlb_entry_spec(env, v, dtlb, &vpn, &wi, &ei);
-    xtensa_tlb_set_entry(env, dtlb, wi, ei, vpn, p);
+    if (split_tlb_entry_spec(env, v, dtlb, &vpn, &wi, &ei)) {
+        xtensa_tlb_set_entry(env, dtlb, wi, ei, vpn, p);
+    }
 }
 
 /*!
-- 
2.34.1


