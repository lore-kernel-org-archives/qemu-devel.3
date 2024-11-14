Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBCFCD68B34
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcMx-0002fI-1p; Thu, 14 Nov 2024 11:06:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcLS-0001mR-M3
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:05:27 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcLQ-000372-E2
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:05:22 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-723f37dd76cso758026b3a.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600318; x=1732205118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hjYrYa5EsHh3SE2oZ1zQ8eTrBOhtgNkNlLaG4FiIf5M=;
 b=iXIqKF3UcTJ2ELfpuHHTsvloBCJ/VdGkHM58d54rtNF0yPlMwgHAwUOou+jBxyVqhJ
 SQX290WHeKHa1+mCnt6GTvEPiXn/4ycs+mNWr1dDAU3s+Jvc6EfuYMsh8c84kP+nvYHK
 lHgQcnJGh8ugv61XTgdFGnatANCQsNCEorJmob3qckucanMJGmBVBOMdmRxRLO87nLui
 FudC8LOsE5xymPywi2v/Iz+20vrm9E1j2aSGyiU7KcJnTEeh0tAnbkmgiuz9Ts8PAj7D
 Mp7iXPtxr7I1POxIE0cXRMy3mb7/S5ju5gfukUzhS2jpB903d31vMNXtTOCAIDl+KZ28
 bA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600318; x=1732205118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hjYrYa5EsHh3SE2oZ1zQ8eTrBOhtgNkNlLaG4FiIf5M=;
 b=t6HDKuMUeeNjqfjwaRQgoLpIAoN75CJzcWQWE0hcUJj6/XjaBeg5V6Rg47J8FKuC4M
 A/qGrh627c166P7IdEjscVU3nAb3DcoitDvxehs+5Om1zniy/SeXPk6W7MCyAP93up+t
 kzxBSE23Zt4hscPsO2tdjhj+YJ75qOAw96QiJXUCeHg14zDOiVLH3mXimmUErCOxtenZ
 7mC8MzyZEYgeorGAKeyRUBAZHpItddYYbC8n3mQVe5hmbVidyo4TrGU08VSfbiO/m0sO
 qni+73XpCXvg+3HwNY+SYbEn0RdAL30bqoTq/Wpg8tIdIittRo0Xk+poRMx9RVygV5rj
 iCaw==
X-Gm-Message-State: AOJu0YzpVafqnm88nUftXCidAXtYZkFJ7ufmvBVMh47cg0RZ54XALamf
 Ik3j8rBkGvXBRM30hC/ZJGPeLfLjn6lCd6bFogMVZXS/kckYWoZqgwZwsIacJN+jGQHGaZq88vZ
 f
X-Google-Smtp-Source: AGHT+IGfHX5pYHxsHA7K4uM46iOMwPpNfvOwCwQV10VKTCN6yRoVDj0v4MXJ81BIqIbxRSbsPDjEqA==
X-Received: by 2002:a05:6a00:234b:b0:71e:7d52:fa8c with SMTP id
 d2e1a72fcca58-72457a7563bmr9083242b3a.22.1731600318394; 
 Thu, 14 Nov 2024 08:05:18 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a9bab70sm1417926b3a.152.2024.11.14.08.05.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:05:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 51/54] accel/tcg: Drop TCGCPUOps.tlb_fill
Date: Thu, 14 Nov 2024 08:01:27 -0800
Message-ID: <20241114160131.48616-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
References: <20241114160131.48616-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Now that all targets have been converted to tlb_fill_align,
remove the tlb_fill hook.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/tcg-cpu-ops.h | 10 ----------
 accel/tcg/cputlb.c            | 19 ++++---------------
 2 files changed, 4 insertions(+), 25 deletions(-)

diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-ops.h
index 663efb9133..70cafcc6cd 100644
--- a/include/hw/core/tcg-cpu-ops.h
+++ b/include/hw/core/tcg-cpu-ops.h
@@ -157,16 +157,6 @@ struct TCGCPUOps {
     bool (*tlb_fill_align)(CPUState *cpu, CPUTLBEntryFull *out, vaddr addr,
                            MMUAccessType access_type, int mmu_idx,
                            MemOp memop, int size, bool probe, uintptr_t ra);
-    /**
-     * @tlb_fill: Handle a softmmu tlb miss
-     *
-     * If the access is valid, call tlb_set_page and return true;
-     * if the access is invalid and probe is true, return false;
-     * otherwise raise an exception and do not return.
-     */
-    bool (*tlb_fill)(CPUState *cpu, vaddr address, int size,
-                     MMUAccessType access_type, int mmu_idx,
-                     bool probe, uintptr_t retaddr);
     /**
      * @do_transaction_failed: Callback for handling failed memory transactions
      * (ie bus faults or external aborts; not MMU faults)
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 7f63dc3fd8..ec597ed6f5 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1222,23 +1222,12 @@ static bool tlb_fill_align(CPUState *cpu, vaddr addr, MMUAccessType type,
                            int mmu_idx, MemOp memop, int size,
                            bool probe, uintptr_t ra)
 {
-    const TCGCPUOps *ops = cpu->cc->tcg_ops;
     CPUTLBEntryFull full;
 
-    if (ops->tlb_fill_align) {
-        if (ops->tlb_fill_align(cpu, &full, addr, type, mmu_idx,
-                                memop, size, probe, ra)) {
-            tlb_set_page_full(cpu, mmu_idx, addr, &full);
-            return true;
-        }
-    } else {
-        /* Legacy behaviour is alignment before paging. */
-        if (addr & ((1u << memop_alignment_bits(memop)) - 1)) {
-            ops->do_unaligned_access(cpu, addr, type, mmu_idx, ra);
-        }
-        if (ops->tlb_fill(cpu, addr, size, type, mmu_idx, probe, ra)) {
-            return true;
-        }
+    if (cpu->cc->tcg_ops->tlb_fill_align(cpu, &full, addr, type, mmu_idx,
+                                         memop, size, probe, ra)) {
+        tlb_set_page_full(cpu, mmu_idx, addr, &full);
+        return true;
     }
     assert(probe);
     return false;
-- 
2.43.0


