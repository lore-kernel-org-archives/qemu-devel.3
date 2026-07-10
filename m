Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2645C44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:04:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiIHE-0004ti-7P; Fri, 10 Jul 2026 16:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIFM-000214-Vi
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:54:59 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIF7-0000yR-D9
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:54:56 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-84536ecfc5bso1562214b3a.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783716878; x=1784321678; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Gu1/Z4NGRci2zl7OUGsQFq715jKZAcS9WoRfcTkKu9k=;
 b=UflPqKgUWWqvS5/ScDzpkjsvQ/vUNSh1u2K2BIn/lkpW1RVl28bL1aOew19yzLdS3p
 9d/oFdtfWRNJYQWVfYCSOy3Qki6DK+W8rqEMjq0Fity4DLJFGXe5ZVD1f9+AA9YRpBQD
 Zj99E49j30a0eYM4Md8zvUY3tZiSvngcBBzG5jHNzU6DwZI4W8im/uRv+Fe7QN0eYmRI
 yziA/YNzCKpJymvGN4lU9+pODIxUDaVH6215FECpip59vCUhObtRXJ6D4DVu7PQucDlZ
 aW/Uc+VqnDiC3qtxSKWMnL1QMlN1muzo5KX9OSrB8KidMqf/H+1OiyQdg/AFrmIcZT/O
 uKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783716878; x=1784321678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Gu1/Z4NGRci2zl7OUGsQFq715jKZAcS9WoRfcTkKu9k=;
 b=APryKrs39aoWaSzgWpl10shlGFLQBDRB2+qvoWpz2MPAOuNLOtrCHE9CZOeobPURBF
 K4J6sFTJervSVzEK3srccUP7NO3HnGdpoOjSfJMptfzf7rUhzRYEXcPP1blMKxLY9dIo
 u7iPVb6CE59znvSKDlYtZJFT5RHWiCGkPFD2gevOAExtigT2vT/4j5xEild+e/8sxLeU
 MBfZXCLOTtmhnMZx+NyInJ9pDfZ89bkBtPPGNxK9R4ASMTaqOokb3FE0astJda5dWiwQ
 tuAqkwSJhTk9yGDa20er9eeFem1DcYHDsQzagnux0rFJzHgmhsSipL495P7S215QWorP
 c70w==
X-Gm-Message-State: AOJu0YyM3/h2XFBj55c7uxHG2ZBogF6BBZc2KCI8NH9N7nlyApL66k5k
 MuWlUap9pxegKNLJR3aBqKUybP1uMtW2G8irTMGr8u4S0IUj91yA4fCPuCM1+ipqjC7O7hHIPX5
 T5AQj
X-Gm-Gg: AfdE7cmW8Oomgyz8zHlmCXec6Y32OfS+61cJ7Fv9pShwpoC0vcKgS3B2evBKhQYPML5
 u4WTO1abaTXT9E4QEKcds+3jYTGPCWiQEwShCHFB7Zmo9tIQTUiqNqB8NX+HiG+/wPHnMt0vh/S
 7R7SFx3mY8w7KfVrNQSChrDPSJ2+ZSezIgGoodJlvqEIYXWSzYNaj29aRjMltvKgUrpp2OGuyJ7
 E20IhDcLRyoDfQ13AH1EzojfZN5/JTrCjAfLpAlmler6vQkuIZuqLSX8tM62/vKTjcZNVPjXdYc
 ifuf6+cvCjbee9v8EQ/7CJYggRbSDYxzzluLjjfFpbyu/jvmciPc6KB2FzbW7dXwSf9SL+5wjq8
 KLX8DGHfGUovHy5SxmpBU3NYqhX8X2FehxFJTj5Er8HysjyL7x7OArScn0Girv0sQVqABeXHvkn
 wnico2rkYHikUtElECjg==
X-Received: by 2002:a05:6a00:178e:b0:847:77e9:acbb with SMTP id
 d2e1a72fcca58-84889611685mr564261b3a.13.1783716878244; 
 Fri, 10 Jul 2026 13:54:38 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6d76106sm10780574b3a.40.2026.07.10.13.54.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 13:54:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
Subject: [PATCH v3 33/51] target/ppc: Simplify ppc_cpu_debug_check_watchpoint
Date: Fri, 10 Jul 2026 13:53:43 -0700
Message-ID: <20260710205401.836304-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710205401.836304-1-richard.henderson@linaro.org>
References: <20260710205401.836304-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

We don't need to check either ISA bit, because that's already
done starting with SPR registration.  Replace target_ulong with
uint64_t, as we're under TARGET_PPC64.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/tcg-excp_helper.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index 99ffe4a820..4065440949 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -353,35 +353,23 @@ bool ppc_cpu_debug_check_watchpoint(CPUState *cs, CPUBreakpoint *wp)
 {
 #if defined(TARGET_PPC64)
     CPUPPCState *env = cpu_env(cs);
-    bool wt, wti, hv, sv, pr;
-    uint32_t dawrx;
+    uint32_t dawrx = env->spr[wp->id ? SPR_DAWRX1 : SPR_DAWRX0];
+    bool wt = extract32(dawrx, PPC_BIT_NR(59), 1);
+    bool wti = extract32(dawrx, PPC_BIT_NR(60), 1);
+    bool hv = extract32(dawrx, PPC_BIT_NR(61), 1);
+    bool sv = extract32(dawrx, PPC_BIT_NR(62), 1);
+    bool pr = extract32(dawrx, PPC_BIT_NR(62), 1);
 
-    if ((env->insns_flags2 & PPC2_ISA207S) &&
-        (wp == env->dawr_watchpoint[0])) {
-        dawrx = env->spr[SPR_DAWRX0];
-    } else if ((env->insns_flags2 & PPC2_ISA310) &&
-               (wp == env->dawr_watchpoint[1])) {
-        dawrx = env->spr[SPR_DAWRX1];
-    } else {
+    if ((env->msr & (1ull << MSR_PR)) && !pr) {
         return false;
-    }
-
-    wt = extract32(dawrx, PPC_BIT_NR(59), 1);
-    wti = extract32(dawrx, PPC_BIT_NR(60), 1);
-    hv = extract32(dawrx, PPC_BIT_NR(61), 1);
-    sv = extract32(dawrx, PPC_BIT_NR(62), 1);
-    pr = extract32(dawrx, PPC_BIT_NR(62), 1);
-
-    if ((env->msr & ((target_ulong)1 << MSR_PR)) && !pr) {
-        return false;
-    } else if ((env->msr & ((target_ulong)1 << MSR_HV)) && !hv) {
+    } else if ((env->msr & (1ull << MSR_HV)) && !hv) {
         return false;
     } else if (!sv) {
         return false;
     }
 
     if (!wti) {
-        if (env->msr & ((target_ulong)1 << MSR_DR)) {
+        if (env->msr & (1ull << MSR_DR)) {
             return wt;
         } else {
             return !wt;
-- 
2.43.0


