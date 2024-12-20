Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A229AE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:14:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUMY-00005N-Mp; Thu, 19 Dec 2024 23:11:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUMS-0008UD-ND
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:36 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUMQ-0006PJ-1o
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:36 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7fd17f2312bso1114430a12.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734667892; x=1735272692; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z2JQONporu2R9RbXK5tPk1t1tzVQToa5YMeaL9LgHVo=;
 b=PZQE8AGzzQbaEgQWDnat1m2lgEqvG8gGAYQEG/odWBTvn/VpbIiApuQti/751qyMwy
 FYzPZWutRbhHqouPegiRgVzznwMWL3HA7VjvIC5qc63aYSB5jAzpwRoAnnF/aj3wZR4s
 mh9fLNoDeNiMq/I9yOTfVt8UqZkGPcFpJqcZcBMisRjX598v4KpgKJ0m8KELt9gDtkGM
 1O0TmClGpZIBvQiAlkXjgZ6CB3TDtsQsPpAH/eMg7DaSKg5svrfJ7cNWW7LtfFgQljfw
 kxUqEsQ25bZCnvVbl2l0F6i/YZHcMDGaoXXDH2fPaHJzyCJiJhkq37wlNICp+30cvHdS
 dGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667892; x=1735272692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z2JQONporu2R9RbXK5tPk1t1tzVQToa5YMeaL9LgHVo=;
 b=cr0OuuIngHbmzqqGlQlKpMn3qvtmbFOzaKtWjxZzGYs6puPElny7/3IYBxptvjy4M8
 rZ4QBFqEt7/Pciwa2xPNwdcRgLPjIjstXRFQNwYhOvM2h5P5nHwtUxDZZRimEtZv0okP
 yiz5dAGn/oT4sSXu0H4OVeVyYQ2AIE6rNw/J9VDeXKGfRnpd9DC50Dtfx7OrQ5I9eUTf
 SKqDeLyhSaPbdx2BVFVmwXAvA/b0V1J6BJ1W3G/IaMwLB6wCBJBrWA8VWsqSJqjXXjnt
 kovRxKsO2czgGMzR8nYNxrLpRADa1xqC4KSB+/USIMHeoxVnyBH9x5TQ7i+U3ZjUFs9U
 u6tA==
X-Gm-Message-State: AOJu0Yz9hF0hgaNopwcRHp99seS3Pl98eJpT06jJjOviXT09TlJrKphP
 M5dka7oT1ZxIzyiw7MdRbDfsUzOPvFJWafq2bCF/S9ARZeCbgTzmo2Zc8OObcj96sRLHg8h/zrJ
 E
X-Gm-Gg: ASbGnctrLD7mdQZU3CQqSFLskKN/8n2VSs9tApd2qyN2pKHOIh+sR3rq5R1l/0p9JFw
 f9UgZ6N4pjga7sA7rXqbmLHHA2gvaELEJJZS7Tohv3s0Qm3uM8FURYaj0MWz0DqKAi4OfkT3rux
 Jl54lR9hyRjGkEcKudKek4io6sPBOEmsjEXi2msBkOYtMblOoqyPhpKzEqVesGOCim7+TI6sqaI
 Lqdmmjoca/zjW3aCcgdgF8I8N3Ahc5ghWLyzsSglG9RqwFMsZPDBRsNv2Bk5Rw=
X-Google-Smtp-Source: AGHT+IGuR2URfmYASE3inYk7se3IDxaxqUxQmfRhDExeYRqmYcQO1f/hGzIt/cMeHBlWVGGPG8A+GQ==
X-Received: by 2002:a17:90b:2b8e:b0:2ee:3cc1:793b with SMTP id
 98e67ed59e1d1-2f452ec6ed2mr1987033a91.26.1734667892455; 
 Thu, 19 Dec 2024 20:11:32 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee26fc22sm4165260a91.51.2024.12.19.20.11.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:11:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 37/51] tcg/optimize: Use finish_folding in fold_cmp_vec
Date: Thu, 19 Dec 2024 20:10:49 -0800
Message-ID: <20241220041104.53105-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220041104.53105-1-richard.henderson@linaro.org>
References: <20241220041104.53105-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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
 tcg/optimize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index a7f37a1e6e..9ce90eee7f 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2497,7 +2497,7 @@ static bool fold_cmp_vec(OptContext *ctx, TCGOp *op)
     if (swap_commutative(NO_DEST, &op->args[1], &op->args[2])) {
         op->args[3] = tcg_swap_cond(op->args[3]);
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_cmpsel_vec(OptContext *ctx, TCGOp *op)
-- 
2.43.0


