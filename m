Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D6A0D68B34
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:03:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcIl-0005OL-Ku; Thu, 14 Nov 2024 11:02:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcIL-00052L-K7
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:02:11 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcID-0002Gg-KD
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:02:06 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2ea0d64e78dso412481a91.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600113; x=1732204913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=X2yiS+ruW+gkzVWGmQM9TvYN4B8BJM2W1/RTtxTmteg=;
 b=SvUGTtTSIHBdbYvIX9y2bH/dIRfNWgZnAMq4nB5nQlWXF6D0cGHJLI1r5/6gUVqt8f
 SCheJco3l8P17/ipSMDikz+/0qFI0RuEKHfYrPjGOly1JS/PdBNBWk7s286tqhXMw1wi
 OwmpkjSTFB95LVykP0z6jbSE4aJp2D40LkeT4rSL+WGyFZhrZWgMEliYhRI2GT7GLfcd
 3QTcyIhSTVZg22EeI5o68xsBfs159dqFIuQHoBYg+AeK5x7RWhoIcM+zcKkFhrGEFLWo
 psqVXQc/m1VzUoskGDbd2hHI71lOsnMhtWpFaWAIVCivh4P8ztFlWPy3bpHYUz0Ka3Gj
 BVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600113; x=1732204913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X2yiS+ruW+gkzVWGmQM9TvYN4B8BJM2W1/RTtxTmteg=;
 b=UBHEtzG4kYyq8jtXm4Lc9Uir/Qn8bXvxWYBqBLE8ck4U1nsCm3aXI/ztFkW45E1zlW
 so8jCciGg/yEJ3cbW9Nhh5vKhMTVtPexG4LKmO1WSU8Gz6bX6xRJfsd78i/UxX6OEFwm
 DMpIBYrr+PRDCGU++yxEwWbwi1DRahSaiFW5GfTJZGJKj5JBB31NIDH/jM5fq6l47Mmy
 EHp7eOhNm4lJ1rFk30IPakL4qVajQjbW+CehOD50Msm5PvWkuPl4Zg9FfAJcAF01uHzI
 iwUhdIh5MUe9plT7gRk3hYXBULhQ/L91GqWuWWil6c2V8DdTOJ23NcRw9nH1mL05smKj
 h3FA==
X-Gm-Message-State: AOJu0YwTk9I1LYzgTQ8JvBH8zWo8X3sJsMAj2ct6lJjWI7bFQZcVQArx
 /l11p4sB3ciTpI1PfSky1CEYfomNIS8OBuZCVqV1f4DYS2qxiwHlHJ27Wcd7wGytV5BRmFo9nOB
 5
X-Google-Smtp-Source: AGHT+IHuqzTniQ8yFTsrocheUor779ihuJrnuyUderscn0uCVN5kbFNNswxyGQ4yCSVvR+90QfRkvw==
X-Received: by 2002:a17:90b:3b8b:b0:2e2:85b8:14e with SMTP id
 98e67ed59e1d1-2e9fe6b8273mr5628147a91.15.1731600111789; 
 Thu, 14 Nov 2024 08:01:51 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024ec723sm1484438a91.46.2024.11.14.08.01.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:01:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 23/54] accel/tcg: Check original prot bits for read in
 atomic_mmu_lookup
Date: Thu, 14 Nov 2024 08:00:59 -0800
Message-ID: <20241114160131.48616-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
References: <20241114160131.48616-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

In the mist before CPUTLBEntryFull existed, we had to be
clever to detect write-only pages.  Now we can directly
test the saved prot bits, which is clearer.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index c975dd2322..ae3a99eb47 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1854,14 +1854,13 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
             flags &= ~TLB_INVALID_MASK;
         }
     }
+    full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
 
     /*
      * Let the guest notice RMW on a write-only page.
      * We have just verified that the page is writable.
-     * Subpage lookups may have left TLB_INVALID_MASK set,
-     * but addr_read will only be -1 if PAGE_READ was unset.
      */
-    if (unlikely(tlbe->addr_read == -1)) {
+    if (unlikely(!(full->prot & PAGE_READ))) {
         tlb_fill_align(cpu, addr, MMU_DATA_LOAD, mmu_idx,
                        0, size, false, retaddr);
         /*
@@ -1899,7 +1898,6 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
     }
 
     hostaddr = (void *)((uintptr_t)addr + tlbe->addend);
-    full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
 
     if (unlikely(flags & TLB_NOTDIRTY)) {
         notdirty_write(cpu, addr, size, full, retaddr);
-- 
2.43.0


