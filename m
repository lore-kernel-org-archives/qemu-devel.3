Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A0BE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUMX-000052-41; Thu, 19 Dec 2024 23:11:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUMF-0008Pd-B4
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:24 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUMD-0006LA-K6
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:23 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2ee46851b5eso1121756a91.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734667880; x=1735272680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M3YEuh2xqNooYYBq4iR7eWG+DbYvG5silVCxI+MmVcs=;
 b=F2IspAkYSsoD1nG405XCrWgPQAqtExRmh3d4dY0mJkRoZj80ItdZVzauuymNoLvsge
 5UgtBd9UtQ2KCv6AkEH3/Su3oJ/nYciED0wzRedKcnE5qXch+eq2cTXEr5L5zbUF98k5
 OHMbV397YhqzM4i1aQmaQL/semp7oThX+eRkevp1ycI9FTPBJOpc1GIYAt70xjaoLvQv
 PV5wAPTpLeuKNFqoh6SZ27Z/k0cFHUJEoMJ8vbIbK2nSdzREecNmVmuYQVxal1RBdjzp
 fkZCYHHt7LY3RPldrELRBpyxYuq4OUkTX4VFgZjXAgE+iP/84I+DJ83vX682ZaIAnNkw
 ukXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667880; x=1735272680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M3YEuh2xqNooYYBq4iR7eWG+DbYvG5silVCxI+MmVcs=;
 b=bn5jGi/PBgCrXAEk/cB32BtM5scy8bkyQ+c871EtG5Z+fDGM/G0FNAK48AOuE5O2il
 4o6pslCMUH5qaU0o4VFXTWqCE0Z+L9+SrZPoCcF7Xye5lhrBksBhnQ/gQmu3zlpcmCL0
 /A4tIIPOAGSZqhPC6HCQ5ezIjXJxeo0l/LpyOD1P7kaj4Ys976z7vap0FDnf7IoDPYm+
 aQ20KI5Zeuk/Q6ntKGDhsj43wMafkvZaX0AarrGpQQ+3QRa4e14tX0i2MSPYDbXW9qeA
 syZt8EJy4UP1D3hpH/IK/toSA0SFbCZkeTArYy63ueHkgA+wb2qs3fCISLRd28ZQjX/E
 meNw==
X-Gm-Message-State: AOJu0YzoK5xOeoA0HpeIdtAO5yQTcqqSN9VyeAko15kTbgoqDACs18Q8
 rp0oSV68QwV6v/9FL4hDKizKmTRvmEF8xKdKxg7kKw/8Q3nTnF3/FktFx6U1NCgyoVFs+QJCIym
 Z
X-Gm-Gg: ASbGncuAVHX9DnWZhiVj/X7d+vgSd7Aky9hsLvso25FnuGUAIbyYYNr7pUfsAuS+MO6
 afiRSuFvJVtoMnlwVtg0QfEI1PlLQyotUymQvuNq8B53FdJdiqxreueCwXlJbizudDgzM/Naijf
 5h2+KgvwyIoKmYAvrKBMYQqlkD4lX8L3ipFK8xtyXJec2GfzlUFqAnnUoRd+qggPIVEcumKTFXj
 S67m/YV0rXzfjVRzpfsOm6f1I6jOdH/esdgjRYhORYBnJiT8tSL1FGNcx23TEY=
X-Google-Smtp-Source: AGHT+IGg6vpG8Kge+dgWmadUUesCGOHjq/yhrp09JZXHPxwEyKtnlEC1gLYEtR+0I9ENdSIsr22irA==
X-Received: by 2002:a17:90a:d64d:b0:2ee:b2fe:eeee with SMTP id
 98e67ed59e1d1-2f452e3021cmr2623306a91.15.1734667880491; 
 Thu, 19 Dec 2024 20:11:20 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee26fc22sm4165260a91.51.2024.12.19.20.11.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:11:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 21/51] tcg/optimize: Use fold_masks_zs in fold_movcond
Date: Thu, 19 Dec 2024 20:10:33 -0800
Message-ID: <20241220041104.53105-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220041104.53105-1-richard.henderson@linaro.org>
References: <20241220041104.53105-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

Avoid the use of the OptContext slots.  Find TempOptInfo once.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 85e6dcdb26..e00d86ab2c 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1906,6 +1906,8 @@ static bool fold_mov(OptContext *ctx, TCGOp *op)
 
 static bool fold_movcond(OptContext *ctx, TCGOp *op)
 {
+    uint64_t z_mask, s_mask;
+    TempOptInfo *tt, *ft;
     int i;
 
     /* If true and false values are the same, eliminate the cmp. */
@@ -1927,14 +1929,14 @@ static bool fold_movcond(OptContext *ctx, TCGOp *op)
         return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[4 - i]);
     }
 
-    ctx->z_mask = arg_info(op->args[3])->z_mask
-                | arg_info(op->args[4])->z_mask;
-    ctx->s_mask = arg_info(op->args[3])->s_mask
-                & arg_info(op->args[4])->s_mask;
+    tt = arg_info(op->args[3]);
+    ft = arg_info(op->args[4]);
+    z_mask = tt->z_mask | ft->z_mask;
+    s_mask = tt->s_mask & ft->s_mask;
 
-    if (arg_is_const(op->args[3]) && arg_is_const(op->args[4])) {
-        uint64_t tv = arg_info(op->args[3])->val;
-        uint64_t fv = arg_info(op->args[4])->val;
+    if (tt->is_const && ft->is_const) {
+        uint64_t tv = tt->val;
+        uint64_t fv = ft->val;
         TCGOpcode opc, negopc = 0;
         TCGCond cond = op->args[5];
 
@@ -1973,7 +1975,8 @@ static bool fold_movcond(OptContext *ctx, TCGOp *op)
             }
         }
     }
-    return false;
+
+    return fold_masks_zs(ctx, op, z_mask, s_mask);
 }
 
 static bool fold_mul(OptContext *ctx, TCGOp *op)
-- 
2.43.0


