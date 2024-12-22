Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6720E7718D
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOle-0002b0-Q3; Sun, 22 Dec 2024 11:25:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlH-0002ZY-DR
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:00 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlF-0002yV-Va
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:24:59 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2156e078563so30100815ad.2
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884696; x=1735489496; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0oaZkc61YjhIqFxlOS5XCCj6BwBkqMgp5zn8nsQHErI=;
 b=B3vLcZfGfGs9I+0/ZsCzS93rA50Kso4hsoWwP3aGVt6dMtY/U1DTKj7ORM/BZNLk1q
 1gNBl3+AlaxGRcmkpLVgHbjalUjcwJ+U6Dd63chB9/S1W0msDVcfELhHr4lAQ8X7st9z
 4OS1MZrFhJRq3bGHxWkUxFW62o9SnXhACzoJQG9L6R3W7Trj5Q9qBPkDrTET8wbDORZp
 goCqyuKFhj3mqZ3PgpbbbktHD+7hDAERl0a204nZwePIVq2eE6esgvbx4Obt4/FLiphx
 Xguwo11J8R6nNZLU4g0yiCCR7RB59Sn7zq0N6UXmTf9BnKRbseDst1rtb77o4pKjAqQD
 UTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884696; x=1735489496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0oaZkc61YjhIqFxlOS5XCCj6BwBkqMgp5zn8nsQHErI=;
 b=E/ipBDdNvtaimN4ZGpjsNNXQILcfDKV379RPRq7MuHXLUGf+8KU940AZx59dqR8a84
 QxVIZAORCR8Au0xgGXcS5NLFdMyz0IEYByFpdtd9SZzj1z1wH9MXAs2Ci42WkZpdY8fH
 RHqDk7Rhx77vX+dnlKTRXRXJIKWwH15CWW093xnPTdKtqrDXq+XfEvIRmII29QZ1fezE
 BmeqtM9PztVKGBNX2HOdDxKO8IMq99e455gMEL4OOxzbPOUWlLpn22SHVBGDsSXrvRsy
 V2rCIcFYiVFWcb3mRMmpvcP26NnuR75l3KEg3pEx6JlRUDgxzbqhp4sy75L94FFwb9Cx
 AwGA==
X-Gm-Message-State: AOJu0YyyIGrBdzJ9T/q2AkxxRM8YpmfTeZbI6iqSbyD5uDL3WmUdYeoa
 oOX58akf7elCJK4Q/4j4ViVX6XAzRyO6cmFaI0H+wh4z2WemEBukEHvQrQL3oTAQP/argf1xJpZ
 BhFs=
X-Gm-Gg: ASbGncsC+M9kXN2XLTRxvNVm+rgWh/SSmd2jhVHmbLZVWEXBM8rW/7fDCEsDaen9X5J
 KyenZ5JaLn+88/OK0Q/c8BrksWXKWCwu/RqV1PRiVXHkii+VKHxYBswowVDYr27eQHLn3Yew8Eb
 p3k2qiJb5ctUeHKp+W0+qDAm9979Q4PzaaCeK4LbDaa6Wzi+eNvJLGyTUwjJKDHz4CRA9TFV3Do
 yD8srQdGhDfuMy5RORyEFLAPuy/Bm+eohpFc2+K8kVw7bUaUZD2gHc/ndKsduw=
X-Google-Smtp-Source: AGHT+IFgxIKD/q1JF6tKdo0zJUG7yTlWth6Aa1grNjjeL3gbh/HhG+YHTcH1R/g+C01oZmERIWymqg==
X-Received: by 2002:a17:903:94e:b0:215:96bc:b670 with SMTP id
 d9443c01a7336-219e6e9df70mr131406885ad.18.1734884696678; 
 Sun, 22 Dec 2024 08:24:56 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc971814sm58461385ad.79.2024.12.22.08.24.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:24:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 14/51] tcg/optimize: Compute sign mask in fold_deposit
Date: Sun, 22 Dec 2024 08:24:09 -0800
Message-ID: <20241222162446.2415717-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241222162446.2415717-1-richard.henderson@linaro.org>
References: <20241222162446.2415717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

The input which overlaps the sign bit of the output can
have its input s_mask propagated to the output s_mask.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 0f7c2c810e..b6a0bfe64e 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1613,8 +1613,9 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
     TempOptInfo *t2 = arg_info(op->args[2]);
     int ofs = op->args[3];
     int len = op->args[4];
+    int width;
     TCGOpcode and_opc;
-    uint64_t z_mask;
+    uint64_t z_mask, s_mask;
 
     if (t1->is_const && t2->is_const) {
         return tcg_opt_gen_movi(ctx, op, op->args[0],
@@ -1624,9 +1625,11 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
     switch (ctx->type) {
     case TCG_TYPE_I32:
         and_opc = INDEX_op_and_i32;
+        width = 32;
         break;
     case TCG_TYPE_I64:
         and_opc = INDEX_op_and_i64;
+        width = 64;
         break;
     default:
         g_assert_not_reached();
@@ -1651,8 +1654,15 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
         return fold_and(ctx, op);
     }
 
+    /* The s_mask from the top portion of the deposit is still valid. */
+    if (ofs + len == width) {
+        s_mask = t2->s_mask << ofs;
+    } else {
+        s_mask = t1->s_mask & ~MAKE_64BIT_MASK(0, ofs + len);
+    }
+
     z_mask = deposit64(t1->z_mask, ofs, len, t2->z_mask);
-    return fold_masks_z(ctx, op, z_mask);
+    return fold_masks_zs(ctx, op, z_mask, s_mask);
 }
 
 static bool fold_divide(OptContext *ctx, TCGOp *op)
-- 
2.43.0


