Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8499CF042D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 00:08:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syKCe-0004WI-Sh; Tue, 08 Oct 2024 20:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syKCY-0004Q6-4J
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 20:05:14 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syKCW-0002vP-FL
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 20:05:13 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-20c693b68f5so674385ad.1
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 17:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728432311; x=1729037111; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nPsGlRApUHllpr7HECmYu85LwKI3gq1PeB/gQzKhtMY=;
 b=RCevTzLB/Xw8viAlhPQPqUOQhWu0Gmnlo7fqMLuL82t8w0awlbAcTdh2TdY7vmta4E
 q7FtrPfI9f32kgmUcH2mAPlrLEp69Z0MkKD0M5H1Tpew6YJqkVvVulwztFUo6JUAw8ru
 Ns0QAbnWHEm+CJGS/tzuA3HNfvTK4dwmf6K5XhembELKT16PzhVg+c9YFLAINyIH6RK5
 lB0t2jIVzF5pZRt4DuZXOce4JpZteIkK0S7UNNI8kNn+NPkx7z+Z2GdgqblS9KALoNid
 o5wUFqlM1DFmA5ylm0n67ZWmTrzSazoS2iAa4A1AjU6wXmJspa28kPYFcX0+aXEBu0Z2
 acaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728432311; x=1729037111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nPsGlRApUHllpr7HECmYu85LwKI3gq1PeB/gQzKhtMY=;
 b=lqIWOklmVPhrT1r4A75bR54F7XMZlp7jFk+dUJpSCcGvixseyrsSAGv5YDrwR1ZntP
 rxtaRkCVrRfgNl/8PI7LOLykiNip/9RaYSRYY8/JTylynct9t0NClzJOEY/2pMR1T7K4
 xi4BA+c0puhWhcd02xYA6ROqistjM0v1HIJTitIzKifR3EUmJeQxeH+1HcFx49s16OlO
 VuuFtbtDcgr80dvzxgt2j/QrqJKWSFhPGsOajiJwie6zrOmkadNEZtM2QPOIrv6YeKwK
 5jgSa9SGUeE7YHlm/uP+rQ8TjbG3b0YcBEE4IKEd2POaSzfWjAA1pAyrttXjz7s29Y9d
 ptHw==
X-Gm-Message-State: AOJu0YxehA0klsT9ufZmQu6N333go4ekkqoDHHwC/ln2xWqHSH7/910E
 fWJweKakNp7Y433DdjoSX/dSO6cbncj4C2i8+wKOZ5lAf1V8j61+XE5Vv1cr3ZfRs3R81Q/o2bS
 b
X-Google-Smtp-Source: AGHT+IGJ8O2nfVebXs/rTPoybsu6FDn6yseoR+E5sJTRxCOXXVZpsC04cUko3bF+v5+Uw1ma0m9ncw==
X-Received: by 2002:a17:902:d585:b0:20b:a739:bd60 with SMTP id
 d9443c01a7336-20c6378d2acmr8950605ad.51.1728432310616; 
 Tue, 08 Oct 2024 17:05:10 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c138cecf2sm60705105ad.104.2024.10.08.17.05.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 17:05:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 16/20] target/arm: Pass MemOp through get_phys_addr_twostage
Date: Tue,  8 Oct 2024 17:04:49 -0700
Message-ID: <20241009000453.315652-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009000453.315652-1-richard.henderson@linaro.org>
References: <20241009000453.315652-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Pass memop through get_phys_addr_twostage with its
recursion with get_phys_addr_nogpc.

Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 0445c3ccf3..f1fca086a4 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3301,7 +3301,7 @@ static bool get_phys_addr_disabled(CPUARMState *env,
 
 static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
                                    vaddr address,
-                                   MMUAccessType access_type,
+                                   MMUAccessType access_type, MemOp memop,
                                    GetPhysAddrResult *result,
                                    ARMMMUFaultInfo *fi)
 {
@@ -3313,7 +3313,8 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
     ARMSecuritySpace ipa_space;
     uint64_t hcr;
 
-    ret = get_phys_addr_nogpc(env, ptw, address, access_type, 0, result, fi);
+    ret = get_phys_addr_nogpc(env, ptw, address, access_type,
+                              memop, result, fi);
 
     /* If S1 fails, return early.  */
     if (ret) {
@@ -3339,7 +3340,8 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
     cacheattrs1 = result->cacheattrs;
     memset(result, 0, sizeof(*result));
 
-    ret = get_phys_addr_nogpc(env, ptw, ipa, access_type, 0, result, fi);
+    ret = get_phys_addr_nogpc(env, ptw, ipa, access_type,
+                              memop, result, fi);
     fi->s2addr = ipa;
 
     /* Combine the S1 and S2 perms.  */
@@ -3469,7 +3471,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
         if (arm_feature(env, ARM_FEATURE_EL2) &&
             !regime_translation_disabled(env, ARMMMUIdx_Stage2, ptw->in_space)) {
             return get_phys_addr_twostage(env, ptw, address, access_type,
-                                          result, fi);
+                                          memop, result, fi);
         }
         /* fall through */
 
-- 
2.43.0


