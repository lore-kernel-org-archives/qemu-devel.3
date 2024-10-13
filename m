Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AEC7CF258E
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2024 22:18:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t06q1-0007HF-1T; Sun, 13 Oct 2024 18:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t06pg-0007CP-Ok
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 18:13:01 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t06pf-0000xB-B2
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 18:13:00 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2e2a97c2681so2633640a91.2
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2024 15:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728857578; x=1729462378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nPsGlRApUHllpr7HECmYu85LwKI3gq1PeB/gQzKhtMY=;
 b=a5eVqYWvGSmnfNWZMVOyApLbkdqJSqPmd1kq8lKCw8RJ4d15JR6JnZHiByyvEDEmXf
 N7768V2wn5RPh4kH0A0JLJSIskaQb+K9jUnHTscJTbDzmdTQ6UALuThB/GQ+8K7lrHti
 gcELCjrtYRmZuLhCbzCr+/bwfoWZfBm33wBXJhiMqfkdwHXQEnHq55AcPh6SsoNv+K6P
 0YB7KCX4zAF1u4Wi6NmwZwaGrfXFBXXtq3fMluyaTjNjZYklKF7RWBJIh0rlrTXM4gYt
 /dg9MXsXkIDdt5sIK7jGfzlLo8bKiXJMS3BSG3cc1MVFVyhhcV4KdljPShLjm5PGqi/F
 o0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728857578; x=1729462378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nPsGlRApUHllpr7HECmYu85LwKI3gq1PeB/gQzKhtMY=;
 b=W0u99OF+JTpmJQsZU2Uta0EVddGCtGudoEHxeMq/Ujz0IrxUqS1e/mxDoSUucf+YlG
 qH2+ouI1QvFZ8YonRKmePTxw7lSU1+hgw+gUYdBbCb1MACJ1rAlpUNBVzYfRK1Rru16R
 NDoCh/8qGZeaaRNnWpgrj1Q9SoGnAqB6uQ9EhFTf/J20WQi+CGzsvi9Gl3J/bkNCVC9Y
 Pi2lBeqsFuCZqZiBvEyhIpcNnvXi9BJXronFAKFyY/cQb2NffZXK74TJhgrbSLQD/DpX
 PL9O2mb+cX1v01mRjDxmNuzDYPYJSUccH70S8zMPKJsu4AAMZa60A7oW3BDoMzvTb934
 Qt3A==
X-Gm-Message-State: AOJu0YxnsKyxVS0jV/e0ZpBWWrZha6Zqo+PgoZPaR7TcGW/QY4XbALnq
 ycXwjXPfIVYiV+HARxqJu2dW0e3MDPm+YWXCypOBT9V1toBzHUlfVqEfLgsJ2uBpzPWNIpXS3a+
 A
X-Google-Smtp-Source: AGHT+IE4nIwz6w08ekeXRdEwDegLKka9MgNchvoOvimoEiuvQBp8xoACW+i9qBtGCwecY+miEzU6/w==
X-Received: by 2002:a17:90b:1056:b0:2e0:db81:4f79 with SMTP id
 98e67ed59e1d1-2e2f0a2fb2cmr11105444a91.2.1728857578022; 
 Sun, 13 Oct 2024 15:12:58 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2d5df1eebsm7271958a91.17.2024.10.13.15.12.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 15:12:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 23/27] target/arm: Pass MemOp through get_phys_addr_twostage
Date: Sun, 13 Oct 2024 15:12:31 -0700
Message-ID: <20241013221235.1585193-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241013221235.1585193-1-richard.henderson@linaro.org>
References: <20241013221235.1585193-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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


