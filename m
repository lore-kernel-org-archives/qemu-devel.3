Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2BDE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:35:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL25y-0004Db-97; Tue, 10 Dec 2024 10:24:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL25w-0004D0-Mb
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:16 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL25v-0008Iz-6F
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:16 -0500
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3eb441c2f28so648695b6e.2
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733844253; x=1734449053; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Bxi1HjyNLNTXe0raGBUFhP9XEIHnBSHW3k19d8NP0Xg=;
 b=wMM+1Qy2YVulpvusYa/xh49sk7K2T4dWtFpQsbudhg2jLfWiSCNoQabgr2CEoOdypN
 cIr53m+a511+ChH9Hu8V52/Wt5+UxP26Pl+wxENocFM3vaYu9fNkdgOZvMTGyAURB/HS
 scdIXhX5IQCCn0qUXT9vJvm7ZnaKFry3Tn58F8tubIAWnrW2EqQtHNCaoNMEk4OZ/OxQ
 zSxyXsI3NGN6XTLH3Xy5RcDkyLSuYM0ExrNnqwj5VPRfeqSTbP/EO2hjMuovg4vE7sQu
 kbmeGI0pOwYMNiSuyG9kzLcDvEbHYRzLAaGHk+KBlzfVPOi75RIpOb3aI2I1h1Oww+id
 o/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733844253; x=1734449053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bxi1HjyNLNTXe0raGBUFhP9XEIHnBSHW3k19d8NP0Xg=;
 b=KuqqGKW+dLKv1zWZpdIWqbg28pEOKje/ISbstT9ajs1YGnGhT0aS/Yn60vzvQ/abq9
 9UUFDz8ZkDvF5+zk4Xaclevq/rYHzijxcjlpCkkGMnTPbj7JtVWOalQ0+mZc7tbXVX2A
 Z53FS64BElr0iTcSk0bbC4tq4RQ3ti0LsEmZhQj71BGFctRTHgevelCcSFjBWwOzxrOb
 2Jv2YXyuHU0m4VXAzZlkulXsptOqSWy/ZuzAlEnXh4I22NHzX31U5DF0PNqdFNZSDKND
 GI60l/3lsNkNHtNT+G69g8/5+Ajx5Ycy2Zt++k1o3SLbHW/mdVI1vJE4ofY5r/oJw1rE
 9mwQ==
X-Gm-Message-State: AOJu0YwnFWSg01yZReQBnNXXynI2Fba2NWFhY38og77YSdvu2x9ixoiT
 5ksHVeLdUp5cbkrj+91n3skPZwGJOhcTLGIsgQFPbWty7Bv12HZBHyg/uiYOKt0yHOIw3stYuMn
 b1UZ0JNJ5
X-Gm-Gg: ASbGncvdddAuAxsKqwjSPqE0FLzFapne6zVCZUoHJuH0E6adI0Wm0uY3Z9DlWS45Vc0
 FMEdNa4QF2khu/66OvC1b1fddJsGgYREh0EBg19mkuZEUc9o+oNmWc4CwmbSkH386ivM2yDmSHJ
 AVoQPFGEBvhcJowAAtZk24gBu0yoVUsJV2f1mYv5JkCvsTYMEOs/Kp8nrjBmfe+EW/UehhnBfsz
 dk0HGOA9zNMoydvrx4Qp9CYXfkycj1O0m5l/ekzGg5rRHNCkIRB8oOiFwAgOA==
X-Google-Smtp-Source: AGHT+IH3BOn9RA2rkJwhYChtZyF+dUpyZJan6oBSN89niloqzCh70xYfvtfIxBekU8CzwZh9asOdVg==
X-Received: by 2002:a05:6808:bc5:b0:3eb:5fbf:1b98 with SMTP id
 5614622812f47-3eb66dea1e3mr3785401b6e.10.1733844253649; 
 Tue, 10 Dec 2024 07:24:13 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb076b9168sm2776435b6e.14.2024.12.10.07.24.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 07:24:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/46] tcg/optimize: Use finish_folding in fold_add,
 fold_add_vec
Date: Tue, 10 Dec 2024 09:23:19 -0600
Message-ID: <20241210152401.1823648-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210152401.1823648-1-richard.henderson@linaro.org>
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 6644d24da6..3f2f351bae 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -978,7 +978,7 @@ static void finish_ebb(OptContext *ctx)
     finish_bb(ctx);
 }
 
-static void finish_folding(OptContext *ctx, TCGOp *op)
+static bool finish_folding(OptContext *ctx, TCGOp *op)
 {
     const TCGOpDef *def = &tcg_op_defs[op->opc];
     int i, nb_oargs;
@@ -996,6 +996,7 @@ static void finish_folding(OptContext *ctx, TCGOp *op)
             ts_info(ts)->s_mask = ctx->s_mask;
         }
     }
+    return true;
 }
 
 /*
@@ -1214,7 +1215,7 @@ static bool fold_add(OptContext *ctx, TCGOp *op)
         fold_xi_to_x(ctx, op, 0)) {
         return true;
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 /* We cannot as yet do_constant_folding with vectors. */
@@ -1224,7 +1225,7 @@ static bool fold_add_vec(OptContext *ctx, TCGOp *op)
         fold_xi_to_x(ctx, op, 0)) {
         return true;
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_addsub2(OptContext *ctx, TCGOp *op, bool add)
-- 
2.43.0


