Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E4DE77188
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:33:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOlu-0002vN-II; Sun, 22 Dec 2024 11:25:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlG-0002ZV-59
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:00 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlE-0002xr-7v
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:24:57 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-219f8263ae0so3323925ad.0
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884695; x=1735489495; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v0/++pnX2KVVLLQdhBqnyliWML+d0h3zcBmgp7ILjk0=;
 b=xRG2uLHJUxPICh8zQMtyh4UUrZ3q0wb8/LHckpkdMVPkgYtL74W0n9+fT6+XOyu2lM
 KCPsWlpQeWS8TWy9FqeBnxuu59NzvGEbYmVIGHK+MQQVHH+rtzqkJ01vhsQzJyCXgpPp
 jniovhCf2coM24hPmY0q5DdCRDHZnUuzfUluF+aFfC4Qn3wAJ3ekVTaUOmi/QAeTxRPp
 cU3UZuVoCVOrFgWFcK/5JpVeK3RPqmEIvz/mph1LwxaFzecqcI27Asstw2yX9K00Mq6J
 5kxN2NR072CNlbt41m4CTOB5hAbuFElj5Oeag3YO/NyPwlzFzv/ORcsMTkh9Q0HCQOJz
 G1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884695; x=1735489495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v0/++pnX2KVVLLQdhBqnyliWML+d0h3zcBmgp7ILjk0=;
 b=OaJbHF90IMlSC2Rpf3CWbtCsedHcuLnYFJD+90imVDwXACLUFQZujiOGpcTtpbTIvn
 3lpPdYRLGqQ2BfVttBmPA4Ri8HYTxqjh/K+4ID1oluDGdN3pzeCpJaAGkJKnzYfumBT8
 1k0zedYFTqLT4oS2lkascTGwao+sJWzaRuqITUlvkwwIYP8n/n0+brUYqigvCk3hGsYe
 vJhqihNcPNMjbnsyurmV36UdnXsvGgTZzZMpV3AiHR4euKPFOPh2KTq+wj8PNpvbJ4YH
 LCittokqYtvbVrF1WSnvCoV/1odPfHOG7BGwp1r/8JSQUn+4HTVLnDUpIickcw1r6VO8
 zV1w==
X-Gm-Message-State: AOJu0Yxf+SAhut2qChzdTVeYH5EIW7+bFIzGb5A14EVZ6T1096IcMkVc
 jzxWesTDWc5MB3JQpdGPxGUj6PcY7X+dVkIkPZ/X+ok+reHkCMVRbsDM65FI9iLe0X3tYcHSUoy
 ocos=
X-Gm-Gg: ASbGncsjt6XXen3wJ2TdxPAfD7w9cmcw3/SzSV5ci9TTmnnmpWvmG8SseEDyscrOxnE
 iDPBv6PoHSGvunm3z8Hv/HARpydLyC4YWJVYBpKcfdaugVJEfYb7c5gbNY6YBEzJ5bR7tG1bVWW
 DC5RZ+/P7zNy6x04q4XTwwpBVD5xe5eikzQnCuqTbKRsVdbrkbE8wLYBHVY8TkDNw/XU24sjrS9
 MiehrRLU32TDO7GAZkSBhl8ULHjF14I4J9uA0Pn7PqqHpaki97gU0OGgBpeR4o=
X-Google-Smtp-Source: AGHT+IEs2p2zrncpMSuodhhrLmlLyiC6eqyYqYz/3Etg2itNsj2spFXHRXlrT2wYlxCSJYVR+qMJHQ==
X-Received: by 2002:a17:902:ce83:b0:216:5b8b:9062 with SMTP id
 d9443c01a7336-219e70dd21cmr147196835ad.54.1734884694773; 
 Sun, 22 Dec 2024 08:24:54 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc971814sm58461385ad.79.2024.12.22.08.24.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:24:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 11/51] tcg/optimize: Use fold_masks_zs in fold_count_zeros
Date: Sun, 22 Dec 2024 08:24:06 -0800
Message-ID: <20241222162446.2415717-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241222162446.2415717-1-richard.henderson@linaro.org>
References: <20241222162446.2415717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Avoid the use of the OptContext slots. Find TempOptInfo once.
Compute s_mask from the union of the maximum count and the
op2 fallback for op1 being zero.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 27b8f90453..b98597f500 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1550,10 +1550,12 @@ static bool fold_call(OptContext *ctx, TCGOp *op)
 
 static bool fold_count_zeros(OptContext *ctx, TCGOp *op)
 {
-    uint64_t z_mask;
+    uint64_t z_mask, s_mask;
+    TempOptInfo *t1 = arg_info(op->args[1]);
+    TempOptInfo *t2 = arg_info(op->args[2]);
 
-    if (arg_is_const(op->args[1])) {
-        uint64_t t = arg_info(op->args[1])->val;
+    if (t1->is_const) {
+        uint64_t t = t1->val;
 
         if (t != 0) {
             t = do_constant_folding(op->opc, ctx->type, t, 0);
@@ -1572,8 +1574,11 @@ static bool fold_count_zeros(OptContext *ctx, TCGOp *op)
     default:
         g_assert_not_reached();
     }
-    ctx->z_mask = arg_info(op->args[2])->z_mask | z_mask;
-    return false;
+    s_mask = ~z_mask;
+    z_mask |= t2->z_mask;
+    s_mask &= t2->s_mask;
+
+    return fold_masks_zs(ctx, op, z_mask, s_mask);
 }
 
 static bool fold_ctpop(OptContext *ctx, TCGOp *op)
-- 
2.43.0


