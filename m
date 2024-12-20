Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 102F1E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:14:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUM4-0008KJ-DT; Thu, 19 Dec 2024 23:11:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUM2-0008Jf-UN
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:11 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUM0-0006G5-OJ
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:10 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2f43d17b0e3so1413195a91.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734667867; x=1735272667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kwAmrbK+z6InFUYOYJQouqu9jlEe2zkE3MrW95sabRA=;
 b=kJFQp3XDcUGaPuOK4fvrDeNPGWVUsOhxI6bHVAYiSaroStM1WCEOK41N+MFyWJoa2Y
 6Oi8d2O6hr+dt5SDwXH9pP3IAs9X7MxApYEFbPy2beYC/XcWbBJgVv3vFoPHzGO/i5z/
 HHqSoQxA77+DIQIOT9b4NN+O+lzwZu1xCXQdISD7AMJT18dA41ZHZnjG8BJ0Nj+PDmWW
 Iw5cWk2KVX97aHXugwxjODWWu1DVIg3vjeEHx/jL8l4pRW2a2uFuGnDzjU7OBaosiWIM
 Fwh+TuZ624PlWYR6KkrC3epaiCV/n77WOLAGlJqIqFC/aYad6yjobKQzeNxQcsI6R9CQ
 0Yuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667867; x=1735272667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kwAmrbK+z6InFUYOYJQouqu9jlEe2zkE3MrW95sabRA=;
 b=L+mEMhQpb7ceqUusMre14WV1UebCi6Qb9o/UePeqsBcsxHBxOIRpbsxyNri5TUcu9C
 //gjlwfdsHXL9/U2hhWKIfLxIGn7YOehXmWm6fC3etYJBxe8mX2EdBswOCaJ1a3pGK1s
 jsYQfRIITjrEdyjTkQmYk4ucrHnctBYGvZdAHmROGDx9/8IEIN25HfYQQrPyZViNB3By
 31uL7IFw+oRtUZyV/dd+lo6KvkJ5DqDXxqFSNxAumHC9kLEWs51dXLmr6oxUq+qjaCsc
 X8vHoOww6Qf2EQ/UYt/WstMT7havPzzovgS0FPNMsAg/5kk9HctcirLzW5bI1mBAor5N
 N+wA==
X-Gm-Message-State: AOJu0Yyk20jHNis5LOut7mlfgkdC6c3g0H3y0xEAOPXIEXtuEuwlnprQ
 Q12fTDJByuuH8wOEfsfaPoeCRJd9bwenN9mXjftwVrq/PBlVz9DuUmLjQuS010LovDuRAiVYbB+
 b
X-Gm-Gg: ASbGnctuv+nL35KCr3buSvUigeDWeQfUvYwl0M8INuBV2okhuAz1Vy0jrw1lpFdD8rP
 WeilGphkB1c1vdycOSsQkkdQmO3grPJs5dlcO2n1ORHHwU2Wg69hGXW1673HLlSJxxd+V5GV4IL
 lBezSUEYVIBqujIpOQqua/g5JcS3OQEJ3ttrgV+fh/YcjQWR0vM9/rESS4cj6QZkdaFUJhtQ8wF
 j3Uq6LBM3gZ+Du6W/e/aV0jO+vJi9SDSnY55JZYmKFe+2xrxqLrvU4d+gi9zoA=
X-Google-Smtp-Source: AGHT+IEV34fxF/0bTZuo/01YeuxSshEYE/h/B5W7IC/YiloAcbGVqA8Pyg4LxcmFXP6TWLEE3jR2pA==
X-Received: by 2002:a17:90b:50c3:b0:2f2:a664:df20 with SMTP id
 98e67ed59e1d1-2f452def241mr2418160a91.7.1734667867386; 
 Thu, 19 Dec 2024 20:11:07 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee26fc22sm4165260a91.51.2024.12.19.20.11.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:11:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 03/51] tcg/optimize: Copy mask writeback to fold_masks
Date: Thu, 19 Dec 2024 20:10:15 -0800
Message-ID: <20241220041104.53105-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220041104.53105-1-richard.henderson@linaro.org>
References: <20241220041104.53105-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

Use of fold_masks should be restricted to those opcodes that
can reliably make use of it -- those with a single output,
and from higher-level folders that set up the masks.
Prepare for conversion of each folder in turn.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 6757fe0036..2aa57afd64 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1048,6 +1048,12 @@ static bool fold_masks(OptContext *ctx, TCGOp *op)
 {
     uint64_t z_mask = ctx->z_mask;
     uint64_t s_mask = ctx->s_mask;
+    const TCGOpDef *def = &tcg_op_defs[op->opc];
+    TCGTemp *ts;
+    TempOptInfo *ti;
+
+    /* Only single-output opcodes are supported here. */
+    tcg_debug_assert(def->nb_oargs == 1);
 
     /*
      * 32-bit ops generate 32-bit results, which for the purpose of
@@ -1059,14 +1065,19 @@ static bool fold_masks(OptContext *ctx, TCGOp *op)
     if (ctx->type == TCG_TYPE_I32) {
         z_mask = (int32_t)z_mask;
         s_mask |= MAKE_64BIT_MASK(32, 32);
-        ctx->z_mask = z_mask;
-        ctx->s_mask = s_mask;
     }
 
     if (z_mask == 0) {
         return tcg_opt_gen_movi(ctx, op, op->args[0], 0);
     }
-    return false;
+
+    ts = arg_temp(op->args[0]);
+    reset_ts(ctx, ts);
+
+    ti = ts_info(ts);
+    ti->z_mask = z_mask;
+    ti->s_mask = s_mask;
+    return true;
 }
 
 /*
-- 
2.43.0


