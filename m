Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D142C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 00:36:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUyaI-0005WD-TY; Tue, 30 Jan 2024 19:36:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUyaG-0005W5-Qg
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 19:36:08 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUyaC-0005wZ-E3
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 19:36:08 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d8a66a2976so40938595ad.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 16:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706661362; x=1707266162; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=z4TKu/oocA0kYxGYSvMCRJUvyKgDJLJvgkWf1sMFFJM=;
 b=WsUMFItkoAxSZLWZTS/yiH7xl3VuVunNcDoPHA2MqtLGfnBlKD1KdGKZ11cPLRfGgo
 UHzNW9X5WbaYrDkOI32sPYCeprylrE7Aw2NQmml6Hp/S6MWE5QTa2bJ7j2oDnSm+7wJM
 brdXbH6BP60l8GmKT+Jkn0c6eUxsoTBq0hmHQaENJ8Ve9lVL1fBthTA2S9ZBCYY9LCJ2
 mNKP3M5St00RDAUsexUn+CCYEdeoAYk3MGUtMH0sIGyccjuQbYBPzsRg64WGxykzONjD
 S0KQaC2hKM/Dp4MLfGo/d8pT+77pgiAhFnRBTtamSbIRFooDB1XUHBusx5TT0mZXcAsh
 B6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706661362; x=1707266162;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z4TKu/oocA0kYxGYSvMCRJUvyKgDJLJvgkWf1sMFFJM=;
 b=ldz9HruFZAGCzP+CWQbxeHfjmZGDHt7hbHLoT8zr4GimX41bmlBTxZ5aM65LVv+AxQ
 Ad/rvo+edm+BGihxu0SleZ13av/wJoIG7kw0fYRGvFCLhGZbyOk4Zwm5ULnJy+XF2f9U
 pq2FHlABYCjlK1m1QdyPBBodgoqwpogELt2Rl9790Bm/38CRC6ox7UEb9dx4/heehAHO
 ofZg/EShHcJA2Xg+FqRcLE1CCx0gaVJK4ptSjNYOoVhU27idmAYVrWHrMAh8iuF+5qn/
 I2SPOjp7MPfm76tJwEVV5YLt9802lNlHvjvb9vgb9dDp5PVtAu8Va84a41pSyV9RsU2Q
 y99w==
X-Gm-Message-State: AOJu0Yy3zZVphX+TENOE/YUB4/gx5VixUc4VtIObxAKSDKAMyOm0unWU
 8TrHRXppDGdy5rsvllo4nku7ETCVo+TVCZ0Nab6lkq0g4FoBrSr6Y3rAS65a3PMUxhpLF+gVpuE
 wHyM=
X-Google-Smtp-Source: AGHT+IEtP/ASIpbzCoG4ir17vTD4+e0yl772J8cSpJGiIxebIql9WXq5pqLce8Wb3AHw5wuCEMkPOg==
X-Received: by 2002:a17:902:6848:b0:1d7:1315:ad2d with SMTP id
 f8-20020a170902684800b001d71315ad2dmr234548pln.22.1706661361896; 
 Tue, 30 Jan 2024 16:36:01 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 jd20-20020a170903261400b001d8f6b95dcbsm3270309plb.20.2024.01.30.16.36.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 16:36:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: gustavo.romero@linaro.org
Subject: [PATCH] linux-user/aarch64: Extend PR_SET_TAGGED_ADDR_CTRL for
 FEAT_MTE3
Date: Wed, 31 Jan 2024 10:35:57 +1000
Message-Id: <20240131003557.176486-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

When MTE3 is supported, the kernel maps
  PR_MTE_TCF_ASYNC | PR_MTE_TCF_SYNC
to
  MTE_CTRL_TCF_ASYMM
and from there to
  SCTLR_EL1.TCF0 = 3

There is no error reported for setting ASYNC | SYNC
when MTE3 is not supported; the kernel simply selects
the ASYNC behavior of TCG0=2.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/target_prctl.h | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/linux-user/aarch64/target_prctl.h b/linux-user/aarch64/target_prctl.h
index 5067e7d731..49bd16aa95 100644
--- a/linux-user/aarch64/target_prctl.h
+++ b/linux-user/aarch64/target_prctl.h
@@ -173,21 +173,22 @@ static abi_long do_prctl_set_tagged_addr_ctrl(CPUArchState *env, abi_long arg2)
     env->tagged_addr_enable = arg2 & PR_TAGGED_ADDR_ENABLE;
 
     if (cpu_isar_feature(aa64_mte, cpu)) {
-        switch (arg2 & PR_MTE_TCF_MASK) {
-        case PR_MTE_TCF_NONE:
-        case PR_MTE_TCF_SYNC:
-        case PR_MTE_TCF_ASYNC:
-            break;
-        default:
-            return -EINVAL;
-        }
-
         /*
          * Write PR_MTE_TCF to SCTLR_EL1[TCF0].
-         * Note that the syscall values are consistent with hw.
+         * Note that SYNC | ASYNC -> ASYMM with FEAT_MTE3,
+         * otherwise mte_update_sctlr_user chooses ASYNC.
          */
-        env->cp15.sctlr_el[1] =
-            deposit64(env->cp15.sctlr_el[1], 38, 2, arg2 >> PR_MTE_TCF_SHIFT);
+        unsigned tcf = 0;
+        if (arg2 & PR_MTE_TCF_ASYNC) {
+            if ((arg2 & PR_MTE_TCF_SYNC) && cpu_isar_feature(aa64_mte3, cpu)) {
+                tcf = 3;
+            } else {
+                tcf = 2;
+            }
+        } else if (arg2 & PR_MTE_TCF_SYNC) {
+            tcf = 1;
+        }
+        env->cp15.sctlr_el[1] = deposit64(env->cp15.sctlr_el[1], 38, 2, tcf);
 
         /*
          * Write PR_MTE_TAG to GCR_EL1[Exclude].
-- 
2.34.1


