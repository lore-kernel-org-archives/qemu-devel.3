Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC939E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:33:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOod-0004yS-L3; Sun, 22 Dec 2024 11:28:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOoV-0004pg-6E
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:28:20 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOoT-0003j2-H9
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:28:18 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7fbc65f6c72so3098526a12.1
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884896; x=1735489696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TgcJ7Z7nrgk+v/P/ZXkaQjdlJl1hSkN9qRtEzlqQEjo=;
 b=ZQXcirOP+XDiqb8vftlIcUoatVSbb4EjLAD+HItYKEshfzPYJfHbFv7zdJviXoqVeP
 aaVEmIN1ji9QtYPXA4r8TPfMfW31mE3s3LAj1x5ts1BMhnLHE4qx1FMpeaG6Oj5BgtO+
 AjvDfmKgvSWRoCCWKTyn1tmgRR/jUtRIi06JfpaP0Tzfww18eqFYewq0FsE6E91DVW/f
 /XUR88ZchEmosNG29ajAjj0mz0g6vlol6zjrzcVXc4PE9bU1ElMlhUanDN2hKJjw+nGZ
 cs9bDjP3CholuRvw9ByZZbFA/ris4efivvu/OxRunRVdZ0F7vyI9001T2Nlhgyye/35/
 J7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884896; x=1735489696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TgcJ7Z7nrgk+v/P/ZXkaQjdlJl1hSkN9qRtEzlqQEjo=;
 b=eTQx6bYWbOhe60a7ZypO1PbCbfybCPHmY4C6x5+cXDJQ3vNhN0ApTL2K39pO4vV0MJ
 4VPRSPiNTF2lO3A9fK9NJJ6iTziwtQ/lne6juw7A6d+mcQxRip5YHcnwSec/5y6LLZCR
 fGtwG71TPnlrmgwrm08ru1sb1kdlhlhx7VyNW+zUjKBzdE4SQyQcjufSei/ITOWuJVwQ
 lalYzx6LpD+/CtujrqD3Ahfx4txkG5lK55/+T5cwi3XZGZ1jcqpuel0ATzv9x50TZJnP
 RqFPVBhuCuf5OR5u8AiE2gWYXIzkxUf0w0gAXIWKQmwU1pMHzlomsbDuyyyssqmKxA70
 iKCA==
X-Gm-Message-State: AOJu0YxVitYY36tFeWDhsjUvakkzw6xqoRntprR+8lOucrKnJizk3j5w
 7yQd3MeNhYBDwrhMzPfVi816siaHbVNXuOQUXcFlP9fXHqsqToPwBg9sRMnq0uOqOFhfgX3YKeT
 Ie4M=
X-Gm-Gg: ASbGncuqVwKHZ75mRBPBG9foG2Pxmc+F052rp7G23If4svhlrvJw1FfqPC5C9SWiojK
 1mSeC1vIndjmnhH7HuAGe3Kp0N9ktft8aKFtgNMso6iJMnWNzPqioKuXdAhry8rbTamFBFmKs+M
 rHEPslB1UR0XB8PmMQ6L1/0RjoC2hzaqCgQ1uHoLXarx9zu8j3B7N0IGr08NTaRvijs3DYSV7cM
 jzR8bgmHET+zNfEd1N0DgOjYv/LRF3XKpB7j48dk2rXzEnEQCuWgLWHtcRQVo8=
X-Google-Smtp-Source: AGHT+IGGEp5De6Iu1Ti+/AVfcJKTn7NlSPyLXyPgZdzFepMLIT8IxhBEi1RnRs2PfmNqhuu0e9LbgQ==
X-Received: by 2002:a05:6a20:7f99:b0:1e0:c50c:9842 with SMTP id
 adf61e73a8af0-1e5e0801cd4mr18919367637.31.1734884896196; 
 Sun, 22 Dec 2024 08:28:16 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-842dcaca43bsm5848808a12.66.2024.12.22.08.28.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:28:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 43/51] tcg/optimize: Use fold_masks_zs in fold_tcg_ld
Date: Sun, 22 Dec 2024 08:24:38 -0800
Message-ID: <20241222162446.2415717-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241222162446.2415717-1-richard.henderson@linaro.org>
References: <20241222162446.2415717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

Avoid the use of the OptContext slots.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 14d3d6253d..cd12985537 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2633,30 +2633,32 @@ static bool fold_sub2(OptContext *ctx, TCGOp *op)
 
 static bool fold_tcg_ld(OptContext *ctx, TCGOp *op)
 {
+    uint64_t z_mask = -1, s_mask = 0;
+
     /* We can't do any folding with a load, but we can record bits. */
     switch (op->opc) {
     CASE_OP_32_64(ld8s):
-        ctx->s_mask = MAKE_64BIT_MASK(8, 56);
+        s_mask = INT8_MIN;
         break;
     CASE_OP_32_64(ld8u):
-        ctx->z_mask = MAKE_64BIT_MASK(0, 8);
+        z_mask = MAKE_64BIT_MASK(0, 8);
         break;
     CASE_OP_32_64(ld16s):
-        ctx->s_mask = MAKE_64BIT_MASK(16, 48);
+        s_mask = INT16_MIN;
         break;
     CASE_OP_32_64(ld16u):
-        ctx->z_mask = MAKE_64BIT_MASK(0, 16);
+        z_mask = MAKE_64BIT_MASK(0, 16);
         break;
     case INDEX_op_ld32s_i64:
-        ctx->s_mask = MAKE_64BIT_MASK(32, 32);
+        s_mask = INT32_MIN;
         break;
     case INDEX_op_ld32u_i64:
-        ctx->z_mask = MAKE_64BIT_MASK(0, 32);
+        z_mask = MAKE_64BIT_MASK(0, 32);
         break;
     default:
         g_assert_not_reached();
     }
-    return false;
+    return fold_masks_zs(ctx, op, z_mask, s_mask);
 }
 
 static bool fold_tcg_ld_memcopy(OptContext *ctx, TCGOp *op)
-- 
2.43.0


