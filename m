Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2BE0C021A0
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 00:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjS6V-0007ik-Ua; Sat, 15 Feb 2025 19:01:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjS68-0007c0-L5
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 19:01:26 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjS66-0006GR-7P
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 19:01:23 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2fc291f7ddbso3229098a91.1
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2025 16:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739664079; x=1740268879; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=K2WH4FlAMIZ4FEc2EEi85vRc1c0fQFd97dzVfYF6JEw=;
 b=ycxiWPu/HxQTziua586pWAD/9E9gMm88Z3SQIAp512ZDbmnzNbi2LVdXrAn+6mydBh
 CWbr+Kt2PBocDKKXL9SMBsy6M5libabWZpjZMJeT+oafvkW2vsfyso/K3psTLn8IJZ40
 PCezd0ho0lxj332js1PkdYCwgzB9uWMa0uGKWPtqo3LVxjUSUIWlzCxKMT0PLX7MERBw
 vFTXQQC0ZBiY1otJ2gv01M5J9Z1QWsJRGQA4SDuluK+B8N16nUky7s3WCr9K2khiwkKg
 dEuWHTEMJinTMRCi3xgZ0PMWuetjFYus8DCzQ/10qRIPkyJPu5t/aNPnjEgQF6MrpWv1
 9vPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739664079; x=1740268879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K2WH4FlAMIZ4FEc2EEi85vRc1c0fQFd97dzVfYF6JEw=;
 b=GDhaIiASe6xpTmteMVy1gx8UqgWaf8fdM3aeMPQ/HRPQ1V2qgg1SjC/r3sHnDUKxDh
 w3WUcVw94awFFKd7NY+dD987w3DNelDj90+vtf98i9+jmy97JIznSfbWnF9k0tngR8jj
 J6I8rdwgOUI74tmyAad4AM7VOUT1Cjcb0zzvjkBML4htNfGsvGCyixOHNKAKQdhwNYu5
 O3r/q/YgY0VaP8YeDZNJS/u15tvyMDEnhcZDnXxPtcbsWYUD1fLcJp7YQoEEV4uXGwdm
 ECHMwE7J2MwsGZs7eJaUHUeaqSjacXp0Gp2VXSF3/XOML4Fp3pamEBhQzHRMYwyCVyxp
 hMjw==
X-Gm-Message-State: AOJu0YxpNoakHCFHqET8Xo53/uJL+1ul4XkAQlj/4bibm4BaG9UYUJQG
 RTnuG82cIx8jON7kn8HdxeOR9d8o7mbaLfZpylJYM7bM2IWo8QpvHDUCz30+mFyxYmacQvMMP5U
 g
X-Gm-Gg: ASbGnctAIzo3SBthDh0Rd5agNrrjnLdYqp8UErByOgyYEcbTO7Jo+iC3oscGC5RSWMl
 zjTwDyVtF0iJKhdGzyUxuOfPRZ2LWD6fr7c7qJm2+3jefIlKJrFf4+MFdZ1ahRVfJDti4ZVW/Yp
 L15/pj6QTNLAU7Z2fZmgvtu2LqrrLCcD7jIgIy5Lsy+2bSU1VCZcWYdQ3U2U38wfjVNz4yp4rUG
 UW8JJBjsBjPnDR/ozRQCRPbO7EIUpdjyq8LXHp1rt6bn9ta8MoYwJOfI6fYp2HfpusDXqJ6fw9/
 gFfycippCjYGgbkTM+h8ZpDYo++fSfcoHdd6EjIf0aquP/k=
X-Google-Smtp-Source: AGHT+IG//8W0zz16Xs7qz2qW2QQPrCw4FjIb4XI+fY/fiq6oQqV8uVOefUSnvnnrWEIYCf5PFrp/3g==
X-Received: by 2002:a17:90b:350a:b0:2fa:13d9:39c with SMTP id
 98e67ed59e1d1-2fc40f10784mr7880508a91.14.1739664079426; 
 Sat, 15 Feb 2025 16:01:19 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5366729sm48960315ad.79.2025.02.15.16.01.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 16:01:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/24] accel/tcg: Fix tlb_set_page_with_attrs, tlb_set_page
Date: Sat, 15 Feb 2025 16:00:55 -0800
Message-ID: <20250216000109.2606518-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216000109.2606518-1-richard.henderson@linaro.org>
References: <20250216000109.2606518-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

The declarations use vaddr for size.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 17e2251695..75d075d044 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1193,7 +1193,7 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
 
 void tlb_set_page_with_attrs(CPUState *cpu, vaddr addr,
                              hwaddr paddr, MemTxAttrs attrs, int prot,
-                             int mmu_idx, uint64_t size)
+                             int mmu_idx, vaddr size)
 {
     CPUTLBEntryFull full = {
         .phys_addr = paddr,
@@ -1208,7 +1208,7 @@ void tlb_set_page_with_attrs(CPUState *cpu, vaddr addr,
 
 void tlb_set_page(CPUState *cpu, vaddr addr,
                   hwaddr paddr, int prot,
-                  int mmu_idx, uint64_t size)
+                  int mmu_idx, vaddr size)
 {
     tlb_set_page_with_attrs(cpu, addr, paddr, MEMTXATTRS_UNSPECIFIED,
                             prot, mmu_idx, size);
-- 
2.43.0


