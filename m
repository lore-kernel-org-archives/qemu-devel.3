Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A60C7E7718D
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:33:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOlr-0002ul-MI; Sun, 22 Dec 2024 11:25:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlI-0002Zm-Hs
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:01 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlH-0002yy-6S
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:00 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21628b3fe7dso29192665ad.3
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884698; x=1735489498; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HA1Cia3WD3D79+EBDaM7JZkJcsoJHEjvRS4SeBS9TIk=;
 b=OHov2nlr+XllWv9lXIBM92CKcuKFSdReXNEEX0eGiuIgn/aGbtWkG7ZUhRcC+3nV9B
 Yv8m2kg5QjXGyz8oIvO1rplMrWtH+S6D+cQ+qFAlN8MRsW/Z/SABWSdbVHuZ8e/1d7Di
 lcb01HBwT+RaiU3q7sZMsb/nubaYlVLlDSHD2odV2zZqVXpKWsJX/I5YRxoDd8fME4lK
 QPYyefLHThbmJ6nMLYH25B+XDOJKj3MpNAEjPPcmSMd6S4WQkTuI8CVVJ0ppDn508LAq
 QnXnsDLnVuT6omunSDgiMgkZaX/jb/BXTWvBIxwKlpbR269R5Q7H1YKtZNeg0oAYngtz
 MNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884698; x=1735489498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HA1Cia3WD3D79+EBDaM7JZkJcsoJHEjvRS4SeBS9TIk=;
 b=wWSO6TS0JHBOJxSazq6uHGEnOc/13TBtkuYo1StougU3wi4C7ZwcKy7Z4V/WResIkB
 qhse4DKERfWOtttdKBsaaxm9DWvnFNhSGh8dQFHLVHUu/+3aAbK5qJy5ZGC3WHyUYgB/
 KN3dd1NUUZur3HAjyW1KbkvF1QoD0ynd30A4bDYbPKeK6+SCgemqx9zPSrP0g5tw7xl0
 38ETb8ZmhhCz8xq9okjWWTJJ4uC/euBemBOBBp7jXMaZq4/pIgjC9wNXn8H8Z0y+m8rX
 N45JfbFanVsrZsHGWYBM1VYpJIW22o42DBOQvQ2oa195KoDDRtGf1TCJXE4Fdcg6pg7R
 a0tQ==
X-Gm-Message-State: AOJu0Yz2rOiRUyum3P/IoUzieKPf3PGF4Zg6XjiAPBTiV7+CHctC2F5l
 bptxaoHmnkJSrg8ULu+sI7RyKW5tF/G7L0rvMrq85EPE2GcRp+/yJuVEavbK5SWRqEZyPcDiBFj
 OV1U=
X-Gm-Gg: ASbGncs7N7riyzR+PVzpjMFoaJiCBTeTgsCORB3b0ANoo1/g99IcyscfjhA1EeayThC
 nP106kT7Ie9LUtfwqncc/3woQpMniKW6lpPeM0PyBHjHnziiXnd9aPTXzIXEoxdtS890jnkYxjG
 OQ2ginz2q4IlLI0/sRvb4WtBd6bqm0c4QI4sHP/5JATANELOlXFJ7y2VKey5BGyEW1LjZ380/fR
 Bbqe4QML8ZVGmtrL4TZ2OvizVvKG+eu98NuPgiMCDQsxWuDdC+lznxFiBnFcHE=
X-Google-Smtp-Source: AGHT+IGmQ7fLyPE+oU/60OBtLMopMzcqkut61c/4xm+tCMVa3han6qN09TyoZU4E8Edp+KdIMDmPJw==
X-Received: by 2002:a17:902:d582:b0:216:282d:c68c with SMTP id
 d9443c01a7336-219e6e9dff9mr151480545ad.23.1734884697928; 
 Sun, 22 Dec 2024 08:24:57 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc971814sm58461385ad.79.2024.12.22.08.24.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:24:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 16/51] tcg/optimize: Use finish_folding in fold_dup,
 fold_dup2
Date: Sun, 22 Dec 2024 08:24:11 -0800
Message-ID: <20241222162446.2415717-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241222162446.2415717-1-richard.henderson@linaro.org>
References: <20241222162446.2415717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
 tcg/optimize.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 0a617bac71..9906f370de 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1681,7 +1681,7 @@ static bool fold_dup(OptContext *ctx, TCGOp *op)
         t = dup_const(TCGOP_VECE(op), t);
         return tcg_opt_gen_movi(ctx, op, op->args[0], t);
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_dup2(OptContext *ctx, TCGOp *op)
@@ -1696,7 +1696,7 @@ static bool fold_dup2(OptContext *ctx, TCGOp *op)
         op->opc = INDEX_op_dup_vec;
         TCGOP_VECE(op) = MO_32;
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_eqv(OptContext *ctx, TCGOp *op)
-- 
2.43.0


