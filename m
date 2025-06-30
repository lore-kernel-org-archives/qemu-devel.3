Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33207C8302D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 15:33:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWGRb-0000R6-63; Mon, 30 Jun 2025 11:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRZ-0000PG-BB
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:17 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRW-0008D8-Ep
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:16 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-72c14138668so1388609a34.2
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 08:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751297346; x=1751902146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ed37owTcRXNcXW8DIrgmIBeAmojXykiSQei3JzaOn08=;
 b=liJJz/igZHqOriXDvX39cNO0KnlwJugZXbJnBVi4FV8UARddiWWHSBkqBiZrP4ZGMq
 atN9eZ+JWpzicjt2LSCpWvsTX1TFWgYJpYfZ/QPQH75qaPUVvypqwH1nnjqNAbMiU7qI
 CKGjNwZY1YIIeDy9zigkBfKnA8kiIqlKwtQSZpC4KcdHC+CbxicZjyrailbLuOf/8pkt
 2izIASUkgluiNKkjFjjMOzyYH3HUp8lhw/VbXJLaE9uLFcZEXOcKB+QZCThXwN92h9MZ
 iwb0XIEPxlITEL4MMD2LpyXGo6zpi/FMJky3qzWCpc6kltkW844kfJ1Z8GgREPb1qd+6
 9JPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751297346; x=1751902146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ed37owTcRXNcXW8DIrgmIBeAmojXykiSQei3JzaOn08=;
 b=QVTaq1erYrETfNzfEXgxNYRfCpLHZsM4TqxAXRPG3FlDCrNWge1KLlcfO0RB4YoyHo
 fHZqrloe8JtIFQty6DmBwvqyFmkmY6o9ZgP7Zh28r54bH55+UeFA7wNfdgYm7Hk/3HFI
 lck3JvvIHwRVRyb/pW9rWvmQOQ5WzBeS2VyK2/U8vHN0rE8PVSHYhf7UQ7X8gT2RpaVm
 AXeq8wYME15zCvdvvBO9zf/DnNW+kyXHTrGokG/lCdSfvooFtkm1IRNytvTmd5sV8tfY
 oNEAwzhO//cJ/8KqN140odn518G52vwL6hf5umbPpkkykO22MwpXh2eK3B9GUxJ/cdvS
 8mMQ==
X-Gm-Message-State: AOJu0YzBR7ubl7jkMsqNNkNM3LbUHucReXPTZbw5D9z9PHll/nPXy6Sn
 TpnXuYVcAVYmXsyU/2qbQ3jehuEswX0OHJ8L6G0/IK4F1spcP084dkHWSWx8yVDsk7n/m25x1s4
 1G0gp
X-Gm-Gg: ASbGncu8SZ7UxXIK5P4Cg234HyhRyOawNScJ9NgCeFR3FkseazjF/cE1cleA3pMbDpO
 ZehmKmOqLRMYcrwsPK0DQsNVCvMzLjLNEa4lyvAIXIGAf+gTHyBz88oWeW580k2AR9+sUh3B/zL
 o9Do7um7osehCqgj0lyeW3474Do82nClurmEichOfp7Uoj1FxFVft38JMKuioX+MpHnrt2CjnDB
 KXoovR5thh0jak5LWYbcSkB27e9CMZeIYskZ4zCyZ5yQsCuqO7Vrv0NuZr5+2deM/9omilzgQU0
 8HI7Y5qqHshZTehtFBWRO4UjWYPVPyT+1my1Jopo8RNWai1PrAfX9OT8yC+34R52yF64pg==
X-Google-Smtp-Source: AGHT+IGUke0U0sJhfZdWkrEj2q+qmKIdukEpJ7PbgBGvKa0j2Jqr0OoQHv/qqkisfPAlsOebI72SwA==
X-Received: by 2002:a05:6830:630a:b0:72a:449e:2b69 with SMTP id
 46e09a7af769-73afc6b249bmr9116087a34.28.1751297346265; 
 Mon, 30 Jun 2025 08:29:06 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb00c48asm1712478a34.27.2025.06.30.08.29.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 08:29:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 10/29] tcg/optimize: Build and use one and affected bits in
 fold_or
Date: Mon, 30 Jun 2025 09:28:36 -0600
Message-ID: <20250630152855.148018-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630152855.148018-1-richard.henderson@linaro.org>
References: <20250630152855.148018-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32f.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index d22396f6d7..ce065d0e22 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2263,7 +2263,7 @@ static bool fold_not(OptContext *ctx, TCGOp *op)
 
 static bool fold_or(OptContext *ctx, TCGOp *op)
 {
-    uint64_t z_mask, s_mask;
+    uint64_t z_mask, o_mask, s_mask, a_mask;
     TempOptInfo *t1, *t2;
 
     if (fold_const2_commutative(ctx, op) ||
@@ -2274,9 +2274,15 @@ static bool fold_or(OptContext *ctx, TCGOp *op)
 
     t1 = arg_info(op->args[1]);
     t2 = arg_info(op->args[2]);
+
     z_mask = t1->z_mask | t2->z_mask;
+    o_mask = t1->o_mask | t2->o_mask;
     s_mask = t1->s_mask & t2->s_mask;
-    return fold_masks_zs(ctx, op, z_mask, s_mask);
+
+    /* Affected bits are those not known one, masked by those known zero. */
+    a_mask = ~t1->o_mask & t2->z_mask;
+
+    return fold_masks_zosa(ctx, op, z_mask, o_mask, s_mask, a_mask);
 }
 
 static bool fold_orc(OptContext *ctx, TCGOp *op)
-- 
2.43.0


