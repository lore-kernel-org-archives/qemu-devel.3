Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A35CFB42B
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 20:08:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxB2s-0006UA-IU; Sat, 05 Oct 2024 16:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxB2i-0006S1-Dj
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 16:06:20 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxB2g-0001oJ-Ob
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 16:06:20 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-20b9b35c7c7so22719815ad.1
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 13:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728158777; x=1728763577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oB3S/z+Tf/YurYPbjZAkQ2iOmy2pkllXkguo9aONGm0=;
 b=Z81JQxamY/5IMjBFOjU5Qo4rmxWDSF7rUAPlpeNZVZRoJt0HgQE4QSQZQ9CARxwbWQ
 k2a/w9ERxKkfstauPyLojlPVWFEELh4HepdX6N3YJPcA7fkXNcAvVto9au0hhhxSYzk/
 p9nAXPZydfCzN9L6jB0zpuOBtMIFkQhtyXoN+AWCIk3Zn2A6p2JleRdI/LbmdcN1MO7e
 PdrVrwXOPNri+UFk57nu3IPS51rf0Oc/F2DFGsP+OCLPyLUo7IR3WcwpSQZzNHzHYlVv
 2xUWRTrqEjYN0ExYdIOL3em7frb8LJJ8HPOI1WvS5VEso20kow9KyU3CP3Tv3gbSWZc8
 8PyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728158777; x=1728763577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oB3S/z+Tf/YurYPbjZAkQ2iOmy2pkllXkguo9aONGm0=;
 b=uD7WnBiSQ5AjiGt8/iBk+7Qlg7lLOE1uwA1hV1H6g1MMCnZ5ADEESeQwGjPkLx8cLM
 ZZM19ExDv68FGkVprQCP8++/pRPxaBg6/kuOswlONsFTmQWz3vB9dzJdGAx3FnCNz5v4
 pN9E9PL7kULjN1cZcu3fJb7dPBw9xljd0dCO/51z8boUaJdHih4wz3EmQ4W7p8O9w5GR
 dBWTxTAqyhPRtZFIBcOLK1lZhPK8Wp2PUyPdiON3xB/b8bgj528BS2PPi37JwD5AlsNi
 KwW9oRv0c+u/45CSbGwz6cKooakvWrPs6XEhmOdigVTH86uyfVEY1jdgXPovjZrum1YR
 NjHw==
X-Gm-Message-State: AOJu0YwlQ5r/Pk2urjZOqELISEy50JZMK8BnPNk+Zgz9v/UjSwqUUkz4
 YsT44uPvsoXfEnmjtrKhKM/IRTzpJd9GTVHp/FV6nZxwh8bf3SOUNZEcVUmZulPCDwX19caGSoA
 r
X-Google-Smtp-Source: AGHT+IFI03P/ZwqgMEeykQf6RuuyTdik7GAJO+0IxSS0VbFT5FxKQ+by1C3Nfg/VbMmCSMS//V9B9g==
X-Received: by 2002:a17:902:dac5:b0:20b:b132:4dec with SMTP id
 d9443c01a7336-20bfde57e80mr119970415ad.11.1728158777552; 
 Sat, 05 Oct 2024 13:06:17 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c13931055sm16493405ad.139.2024.10.05.13.06.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 13:06:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Subject: [PATCH v2 17/21] target/arm: Pass MemOp through get_phys_addr_twostage
Date: Sat,  5 Oct 2024 13:05:56 -0700
Message-ID: <20241005200600.493604-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241005200600.493604-1-richard.henderson@linaro.org>
References: <20241005200600.493604-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Pass memop through get_phys_addr_twostage with its
recursion with get_phys_addr_nogpc.

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


