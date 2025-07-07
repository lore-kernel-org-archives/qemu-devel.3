Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888A6C83030
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 21:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYszZ-00018R-J2; Mon, 07 Jul 2025 17:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uYsLY-0005RW-BK
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 16:22:05 -0400
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uYsLU-0004NS-SC
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 16:21:52 -0400
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-4a752944794so40220171cf.3
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 13:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751919705; x=1752524505; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EnkAI+0vH5Q8DiMF28uLi2XSCeCpfBYEqjdtiHYhus8=;
 b=a8ancvMVLwA+PvPzBxPNoaCo1fbTs43dPlxFGiZNcdLDP0rdAGOY/zL3o9gZbq8c5n
 zrb7L6ELgqpvQblZbkgwtYk6iSpNU/L33+6iOboWGdViaEbvYd4ZZ5Uluzz3Lw/6NGWB
 VhSLnZpyeGf+Zc1VeQkSnLCEFszDysklC4F9pfqHA4efdmFLhOIdfoJb3oRGoY0PF0CI
 HcFuvg8HTldosclCdXKkoi3cs7jP4PqEdbPzyht1FR7ocVSZdqPin5CsaKJgFLJ8nZZV
 e+JH1PNao2a51Ee9zuUoVSUMHEzT8QsLcIR7pDDwOTOu/V5wk1rrkqFf1MSMuaUbHX4N
 omFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751919705; x=1752524505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EnkAI+0vH5Q8DiMF28uLi2XSCeCpfBYEqjdtiHYhus8=;
 b=Yk1jnykGa5w8HDcHhgXPG095wgS7Cznz1y4an34mRZxMcG8/ypWsstylJnGaJsTIkn
 oEowmUp+aRDW09PxOPWTD8e1nRGWbsBHykqh21dtZEhGaP2+NRaqvKRK4hjFI44q7Mc5
 gZN/59Bhoy25vWgd6+pdYpS5xL9gRg+zt5f3VyJ/UtZolu9aIugA5UJ9KhwhvfzAtmEW
 IgK89PnlPPd7945MvXNP4xuB0cQiLCWGpQkrBKSDV/vL2BFNF4oSQNnY/OJftRHAsRCO
 5gYVLlX8++ChtdNH5D7I7twsGtksArCgrRhG17Cy3bwkMUKDTY99tUVmDjAfJtA6kKcD
 XcAQ==
X-Gm-Message-State: AOJu0YyYaNL7wH44Ur1c8A2budIdBUyEQrVM2uSSUOpM+P+wa1p3knAx
 yCXkyzjtK+Q/kJqK9K0Pj5BNMYa0R20YcHCUvJGGc221JJmROWpCsGoP5RT6lCZK4fes3aFQJtJ
 MKnkWgyM=
X-Gm-Gg: ASbGncsp2otMjkMiF5MGYGJpvSIpb4i3Yg2+Lt5s2Js70iSYsD5hpWDEtTie6cIKGjK
 MD4zPGaDExgB6hvyHbaqGfdAvdeh2y7p51odbzmu17tLv1b8uanQmfgs57QsjZf6Kz5kVmSpGei
 iSuxDy1w8iGn8xpYzompWXdoo86itDNSCAqxbdenAupeikiKEh8/6+CWr1jVuNvXhkl4jaqbxA5
 PAGJrA/DJcJDf/RA9UqCey+8r5kd5QSZaItHaAIeKqwBjodFiPpjiQVqLuOR5QKwoZFLG6uvjmP
 isi9aHXmEl+e71XpdwdGvd5cOaY74zRUR9GylDocKRZXEGsysCPs08mSIkMYy9bB4oaCO4ys+Xo
 NnFnDmn09Bpv0JBK8
X-Google-Smtp-Source: AGHT+IEP6xvsYBv4AEeWUmY/PXE/8JsQAShIYTIdC7GgT+0FOgbQUK2dMpvjI91Vb731hqLpo3Wjwg==
X-Received: by 2002:ac8:7d04:0:b0:4a6:ef86:19a1 with SMTP id
 d75a77b69052e-4a9ccac270bmr11148061cf.16.1751919705534; 
 Mon, 07 Jul 2025 13:21:45 -0700 (PDT)
Received: from stoup.. ([172.58.142.143]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a994a78dd4sm69050351cf.51.2025.07.07.13.21.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jul 2025 13:21:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 17/20] target/arm: Skip AF and DB updates for AccessType_AT
Date: Mon,  7 Jul 2025 14:21:08 -0600
Message-ID: <20250707202111.293787-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250707202111.293787-1-richard.henderson@linaro.org>
References: <20250707202111.293787-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We are required to skip DB update for AT instructions, and
we are allowed to skip AF updates.  Choose to skip both.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 19a53ec707..ecb20f65e5 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -58,6 +58,10 @@ typedef struct S1Translate {
      * and will not change the state of the softmmu TLBs.
      */
     bool in_debug;
+    /*
+     * in_at: is this AccessType_AT?
+     */
+    bool in_at;
     /*
      * If this is stage 2 of a stage 1+2 page table walk, then this must
      * be true if stage 1 is an EL0 access; otherwise this is ignored.
@@ -1922,7 +1926,14 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
     descaddr &= ~(hwaddr)(page_size - 1);
     descaddr |= (address & (page_size - 1));
 
-    if (likely(!ptw->in_debug)) {
+    /*
+     * For debug, never change cpu state, so do not update AF or DB.
+     *
+     * For AccessType_AT, DB is not updated (AArch64.SetDirtyFlag),
+     * and it is IMPLEMENTATION DEFINED whether AF is updated
+     * (AArch64.SetAccessFlag; qemu chooses to not update).
+     */
+    if (likely(!ptw->in_debug && !ptw->in_at)) {
         /*
          * Access flag.
          * If HA is enabled, prepare to update the descriptor below.
@@ -3546,6 +3557,7 @@ bool get_phys_addr_for_at(CPUARMState *env, vaddr address,
     S1Translate ptw = {
         .in_mmu_idx = mmu_idx,
         .in_space = space,
+        .in_at = true,
     };
     /*
      * I_MXTJT: Granule protection checks are not performed on the final
-- 
2.43.0


