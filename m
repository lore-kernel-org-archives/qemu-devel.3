Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0060C83029
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 15:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWGSI-0000p4-IQ; Mon, 30 Jun 2025 11:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRh-0000SD-97
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:28 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRY-0008Da-Ko
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:22 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2eb5cbe41e1so3357478fac.0
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 08:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751297353; x=1751902153; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jecekv+v6ZdBkwcM0IXQBLsbwinUXoi160CeHuz0xhU=;
 b=sXqwiCb3MtvqoVfsL2M074JzdM1mThg0QdiCoMhZM5hmTlv5j6CaerFxZ99r9veVTv
 cGIH24ZEPjvpRQcCqrA8yHVybumZ6oi/fCyX6GdwVSoAPGo5o2yI5ev5Wo8qfII5+M27
 cnxFwV2B/wVYtIM0KrIYVOvHJct157z3P1AwG7eXzYyr/UpfYFFC+Kj9cljkXSXbia/A
 8kEETsMVLElkag7AB3DU5KNfiy5fqGaHtXIJGe9SD1/fcTu245zMXlzHybTn/vcKRRPL
 +SKWTVx0nUCw9v/vntxo4/xquiblTj9IsfCRo4X2qgxkC1eENwIi6lHOt1KDWI5j4rUm
 yRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751297353; x=1751902153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jecekv+v6ZdBkwcM0IXQBLsbwinUXoi160CeHuz0xhU=;
 b=fp6EINyAmtE5bHV2zE1UFt8U2AXjsH9+9GCdE4rbfyCTyZNewCMICHtfmJgTSEzQ+Q
 2W/ocPrLGXfpoSD8zx3vbYF1hSJemdKwSELMPHPug1vztfzUO0rgnayGC/eMQ6G8RUrp
 Gz6Q6h3BUolE9y8ce1tB+mmb8e7slb5V1whWWfKMzxTIoJ0maT1va6+1PwvL1mKee1h7
 MhEz60AHa8QdLo+WhyhkoogFKjC3yxa5GnejhRiMpo25KhlvNZbfH2T5ixN8Qkhk1l9l
 aZgzzREkx9Q+GKwaq9t16SRax7Ei5dC89j5iWfq9X34IrDH6UNWMr+waXARFwjcrBSnd
 udAw==
X-Gm-Message-State: AOJu0Yyc28mPPP+vybpkMvdfYjoDi+vOldTBeAhT4b04v94d5g/p9E9r
 Q9d8oIFqj9NQ/lkUltsFNglKwu/dFnTJHaXI1sAahSKH2zG54jYt8ggzRC9RrzuObTl9DmYlZDM
 ncqVs
X-Gm-Gg: ASbGnctNcYC7KXwPT8Ot0gCl1PzE7j47NA/T6+mK6fwXkuM2Lan2QLYGP2m1Buv1/0S
 N51GRQk3K+P0CiGCCxB/H1OA13I8XPKt9tf7rW5XzOLUBHJgB0VgLKjIz4gi8MY/jUJjjub6pEt
 hn++5rjv90r4+YH9Y0zNUHo7r67BkFAPxP8f50FEqpSpupxvZPvPlj95NRtcT2NJQ2ZfDZQE6+9
 M6QNihSiOskHk6nOKF4qoByCCF0k41n/Sgn41DvUXqfxmUTrt9UwUPLQFgOIM0DUE86LwXSljHR
 0Vp2Ob/xIvvhX0uV0mIThQP8wHJssEkka4IX1uwpSEo0o3GypgRsQClFqy7vI7vXoHsJEw==
X-Google-Smtp-Source: AGHT+IGSX9NflLOndu+Om58F9eq4VbHii/mHMK11mS0WsKTvPvzOJNvf/MTOzmWrBaGryAFabNKs3A==
X-Received: by 2002:a05:6870:b4a5:b0:29e:4340:b1b with SMTP id
 586e51a60fabf-2efed4c0f4amr10477191fac.9.1751297349494; 
 Mon, 30 Jun 2025 08:29:09 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb00c48asm1712478a34.27.2025.06.30.08.29.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 08:29:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 14/29] tcg/optimize: Build and use o_bits in fold_deposit
Date: Mon, 30 Jun 2025 09:28:40 -0600
Message-ID: <20250630152855.148018-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630152855.148018-1-richard.henderson@linaro.org>
References: <20250630152855.148018-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
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
 tcg/optimize.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index c9c53f796f..043568a10d 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1847,7 +1847,7 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
     int ofs = op->args[3];
     int len = op->args[4];
     int width = 8 * tcg_type_size(ctx->type);
-    uint64_t z_mask, s_mask;
+    uint64_t z_mask, o_mask, s_mask;
 
     if (ti_is_const(t1) && ti_is_const(t2)) {
         return tcg_opt_gen_movi(ctx, op, op->args[0],
@@ -1882,7 +1882,9 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
     }
 
     z_mask = deposit64(t1->z_mask, ofs, len, t2->z_mask);
-    return fold_masks_zs(ctx, op, z_mask, s_mask);
+    o_mask = deposit64(t1->o_mask, ofs, len, t2->o_mask);
+
+    return fold_masks_zos(ctx, op, z_mask, o_mask, s_mask);
 }
 
 static bool fold_divide(OptContext *ctx, TCGOp *op)
-- 
2.43.0


