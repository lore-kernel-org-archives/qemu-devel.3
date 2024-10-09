Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18149CEDDA4
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 15:12:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syYJV-0001ZT-26; Wed, 09 Oct 2024 11:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syYJT-0001Xv-G1
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:09:19 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syYJR-00080A-UM
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:09:19 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7e9fd82f1a5so2717870a12.1
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 08:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728486556; x=1729091356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cc9On083uJcJ4nXjMqsVER0drsrso2XobYAn0o66lak=;
 b=CxbG1yFBRQtI2UjNkdokLSUfWvUAxpOk3KZzS/Ot3BTbV04GdQgKO7PPn+Gua9BwPv
 0zoWp3F3C4ULVNrmQvn1LYXzmxhFaAgB/mVSnczMCNHRBubmRMhuhjS/dx6qZBwUAhkY
 nj9VBpVApyPk1YYlFllHCv2+uyUMKWpO3erh0Xz17zjey+yaaDNXenl5MR0Vp0RCnntx
 b+l/ZaUtcBqgIhFfpzbwfFCUyN1li+5I/Z1MU28WWBc86Aapow7RP099YmGrNa5ZC5WS
 RyQrxorTEvhjG6bX6mVKlpFnAfMbZVwj9oFbsO5Escr2dZFxg3N81OgBP85ZRrwi8E4z
 tMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728486556; x=1729091356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cc9On083uJcJ4nXjMqsVER0drsrso2XobYAn0o66lak=;
 b=sMfNi8mT4fFbyFRconv2zoJsL2iY9Ev+92PGf3xzNmNJAmUwFi1YrIeAOa+1COeCgW
 QxjUzDvL5WvfMVZFV6DuoaTeqok+JiP9KXjXq3uSXBbQTopFfDFh727XE5/A97gZU2N9
 R0yCUxwioRiWTaVjlFZf17OAXCvtkrmDMyiPYJ7uX06aTGOl6JAM3UKy/LPIp78XEtum
 uIsMewoRmuXIjRRMhTSpEzmhjlM+CHYm+oXAH9v8Frue7/6esfjvVEYPn6znDDlpJ9iP
 dfpRRJP6Wk7SS6eDBA+y4lkgutrt+83j+SJolMOR3yxZkWR467y2kuj+Iwxe03D1p9z0
 YOhg==
X-Gm-Message-State: AOJu0YwiYMbm6uOXAYr2+7bSCSy1D09guEDbUBQ9X6Rf4uR2mh7Z76BV
 llE2Qq6pVWrKdWIHmjaWjdJnImcGEczSyfRwzStaoAnSki9WXdxdFPx4vhLYzOTngcaiKcruQ90
 B
X-Google-Smtp-Source: AGHT+IHlws/m7vB9sx1QyRNFWR8LrP4HM0bf9L3WA5lSr4eae3wHeH/tVgx+IzxjyrfTuVucb85DTg==
X-Received: by 2002:a05:6a21:9102:b0:1d6:d5c1:e504 with SMTP id
 adf61e73a8af0-1d8a3c1e587mr5562929637.26.1728486556599; 
 Wed, 09 Oct 2024 08:09:16 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d65278sm7881094b3a.160.2024.10.09.08.09.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 08:09:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [NOTYET PATCH 22/23] accel/tcg: Drop TCGCPUOps.tlb_fill
Date: Wed,  9 Oct 2024 08:08:54 -0700
Message-ID: <20241009150855.804605-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009150855.804605-1-richard.henderson@linaro.org>
References: <20241009150855.804605-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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
index c932690621..e73c8a03de 100644
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
index 47b9557bb8..55c7bf737b 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1251,23 +1251,12 @@ static bool tlb_fill_align(CPUState *cpu, vaddr addr, MMUAccessType type,
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


