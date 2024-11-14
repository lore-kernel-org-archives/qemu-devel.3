Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E47D68B33
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:11:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcO4-0004kx-4V; Thu, 14 Nov 2024 11:08:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcLj-0001ww-H8
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:05:43 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcLg-00039v-Rz
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:05:39 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-20cdb889222so8296595ad.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600332; x=1732205132; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TEPg1Hj+WyfSzdzbNBp7DHrrLsvR0rYuhsge67okkJI=;
 b=Z3M0RlbEIVjs2QMJ8IuimdYZ+paVJ59QyL0/DRbXWo+SE5nFvKY5Q4HoCNZ5T1rliA
 JrbcwMDzcZlf2ED+iLIzUHLvg6cVskMbK1L7uq9Vn5gMO39jzNS1t4/G1ATOrk2vlZt9
 /cElN6ZYFTr4PoNppiidukIk/YrAuWs9h5eIIJztQ2XtG34LN0vMAawsDTXK0BbmFkC+
 BDi2u7KoWyNhIfECvO2Ht1oFebW6W7AkkJqiRYpNdgQxOzNIrUqTMIPWKTnBP4gyaFp6
 w0B7faLsqK34bCA7B0ul09EtBobiHBzstZBR9DKU+mNJx38sSdFQqYKqn6sSk1I41QRA
 nQrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600332; x=1732205132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TEPg1Hj+WyfSzdzbNBp7DHrrLsvR0rYuhsge67okkJI=;
 b=CHktdoFu2acmjo8By3qAmyyMPP+DOlttgZK4CLoQgihfFP3uL0IVgMzeuoj2hRv3Er
 yQhr/6ZyE3jmDoFzWHYyLthdJ9uX5zNJegYOu7vvmDlNos/bOCPqT2k06Xribv9wlApX
 xxDcThDcyW2UWZy465EwtC6DFp6hKYtZJG9ya/6d4UMljgVOIzxuWKWzQAR5ihl7MGYY
 cUa8z03LUslT8W7gASaMllHo1wv5+7BBD1OpANj4rHX2kQS9f/8HCz6YXTQNRsjeBu64
 3+WXrXNpjheFGMxqkxEws2bA1IDtYqv2lUB9Hm2kPIJ3LDD1j6X3bu3M+cpCCsijk6Lu
 1Kjg==
X-Gm-Message-State: AOJu0YxpJNHQvHqoe1wxMXofspraiGk11UZZMpRjVBjgWrX4MOU0cFo/
 W6/sK1pszBAHWUdp6DeZHxway21OfUXnFf+wRLuRRgX2wM10yu8flzt+It/ictdleGT4CfvRswG
 1
X-Google-Smtp-Source: AGHT+IHwD2ZH3nElpu72z9wlCwe5s6d4kK4b2hjowEVGska+Pc3jcr4cK/alUydGLC/WMG1nCq9u7w==
X-Received: by 2002:a17:902:da87:b0:20b:7be8:8eb9 with SMTP id
 d9443c01a7336-211b5d5d4c9mr103164115ad.54.1731600331965; 
 Thu, 14 Nov 2024 08:05:31 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a9bab70sm1417926b3a.152.2024.11.14.08.05.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:05:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 54/54] accel/tcg: Return CPUTLBEntryTree from
 tlb_set_page_full
Date: Thu, 14 Nov 2024 08:01:30 -0800
Message-ID: <20241114160131.48616-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
References: <20241114160131.48616-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Avoid a lookup to find the node that we have just inserted.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 20af48c6c5..6d316e8767 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1037,8 +1037,8 @@ static inline void tlb_set_compare(CPUTLBEntryFull *full, CPUTLBEntry *ent,
  * Called from TCG-generated code, which is under an RCU read-side
  * critical section.
  */
-static void tlb_set_page_full(CPUState *cpu, int mmu_idx,
-                              vaddr addr, CPUTLBEntryFull *full)
+static CPUTLBEntryTree *tlb_set_page_full(CPUState *cpu, int mmu_idx,
+                                          vaddr addr, CPUTLBEntryFull *full)
 {
     CPUTLB *tlb = &cpu->neg.tlb;
     CPUTLBDesc *desc = &tlb->d[mmu_idx];
@@ -1187,6 +1187,8 @@ static void tlb_set_page_full(CPUState *cpu, int mmu_idx,
     copy_tlb_helper_locked(te, &node->copy);
     desc->n_used_entries++;
     qemu_spin_unlock(&tlb->c.lock);
+
+    return node;
 }
 
 static inline void cpu_unaligned_access(CPUState *cpu, vaddr addr,
@@ -1266,18 +1268,14 @@ static bool tlb_lookup(CPUState *cpu, TLBLookupOutput *o,
         tcg_debug_assert(probe);
         return false;
     }
-    tlb_set_page_full(cpu, i->mmu_idx, addr, &o->full);
+    node = tlb_set_page_full(cpu, i->mmu_idx, addr, &o->full);
     o->did_tlb_fill = true;
 
     if (access_type == MMU_INST_FETCH) {
-        node = tlbtree_lookup_addr(desc, addr);
-        tcg_debug_assert(node);
         goto found_code;
     }
 
-    entry = tlbfast_entry(fast, addr);
-    cmp = tlb_read_idx(entry, access_type);
-    node = entry->tree;
+    cmp = tlb_read_idx(&node->copy, access_type);
     /*
      * With PAGE_WRITE_INV, we set TLB_INVALID_MASK immediately,
      * to force the next access through tlb_fill_align.  We've just
-- 
2.43.0


