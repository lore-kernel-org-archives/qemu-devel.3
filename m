Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFDDBE77188
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:27:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOlf-0002b4-43; Sun, 22 Dec 2024 11:25:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlB-0002YN-RP
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:24:55 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlA-0002wi-Bi
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:24:53 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21628b3fe7dso29192365ad.3
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884690; x=1735489490; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kwAmrbK+z6InFUYOYJQouqu9jlEe2zkE3MrW95sabRA=;
 b=fYTVu4TJz+3vY/6jNfN8D2IixErJFfeGeQpR8BQykX8dxwdkBD2FLivxExmlXmotTQ
 adv0/Q/nmtp68yOto5VSH4PpuoTpfbSfvjhYZUlvwrI7HUVZZuJuwswKPJZ37Yc583Qv
 tm9tIuYBn/O3W081wtXXdq0vxbq+ziz889fbjccnQwNqxkwnvZMu40U5QdOZNb5xTwhI
 EeLYyzOyXdVc+oPklshjWcxPIcAGZC+KCg1mnnzxx4mD/jFPq6NPHH6ew86IgpX3tepg
 BgZI/FFLRlRRD7aH92ChzmqCev7AI2APb6qGPV+GgtGKSy2ui/dXGLwrO52UfGDXhK1f
 YWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884690; x=1735489490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kwAmrbK+z6InFUYOYJQouqu9jlEe2zkE3MrW95sabRA=;
 b=BDGdlaJ5xTbncO6jSS9+m9jEUHkjl7fssZboHRtfhcyVaUDnhcuapa7EyEfSdguzvS
 skm6vd4wKMgf1gCSx+iFJ/xNYJPclncnFO3d82c4q/TYSqAuKO68cs9TwM/z+ZwaXwH3
 DPSqrYuNnuO7NgeD1fOmNWVK/vk7KmvgbxkAkxm47Y+WTw24GHZCariaeH6F10O8uNHl
 gtTJ3IAF0kUCHGS7RaFQAoj4oFdq6jEid2pzuZmO0S1DzFsOa8VEu+1b+cLhts88Rywp
 k0y67FguBeOD+FX7Z7ok2tMB02FrBlJyejU5vpgoRuj0iD8fEC5oUeEZjlZHHseaQehP
 ZRkw==
X-Gm-Message-State: AOJu0Ywrdl3VAhnPXrkkOgvXUOj2EknLs+8bFA4Ly5GNDhOdbsVUhIc+
 7pKJ3MtvNb7MMKzkNV4u/pvJnk0mukNkmqlnQzazb6ZEhDQ7MvKnQGFMbBmG8ihQf4JojDHn6Ck
 Fln8=
X-Gm-Gg: ASbGnctDOoE1hhjVrfFKWvyrC2WRuD6OeO/ALqVaGPS+W+RV0QUhULUcG0Op1DXWWiU
 GhrDYLJ79CAW1a5RvsOyoSxcOaT5ZXw8Bi3uYgiYA/oJg0y27gXz/7X2e1d8MoNvv6PcB7Azjwx
 K9CsMKfPlN6IuKdMdV6/mvVD1kHCLYuaaXKAKxN3Ovbm4H75od6tfMUIufsH8S/YYFST3VFY6Qt
 gHUj6rJKMi0131ZaAQerPO7OAuodk1VOd/e9p7fduH+xsV60LqIqnarWKDjI0Y=
X-Google-Smtp-Source: AGHT+IFk0auuOSEMGnciND4l2mz9+cZddel/KBLfaVzSvurQUP+Dtfp0ANxD1pOywstqQU+3WfbhGA==
X-Received: by 2002:a17:903:947:b0:216:725c:a122 with SMTP id
 d9443c01a7336-219e6e9e0eamr161030895ad.19.1734884689869; 
 Sun, 22 Dec 2024 08:24:49 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc971814sm58461385ad.79.2024.12.22.08.24.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:24:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 03/51] tcg/optimize: Copy mask writeback to fold_masks
Date: Sun, 22 Dec 2024 08:23:58 -0800
Message-ID: <20241222162446.2415717-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241222162446.2415717-1-richard.henderson@linaro.org>
References: <20241222162446.2415717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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


