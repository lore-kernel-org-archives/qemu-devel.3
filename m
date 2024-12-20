Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 090E3E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:16:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUMW-0008WN-IR; Thu, 19 Dec 2024 23:11:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUME-0008P4-Dj
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:22 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUMC-0006Ke-Pu
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:22 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7ea9739647bso967896a12.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734667878; x=1735272678; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m3AWL6HxtV2uFTdmZozJUF3KalTOisLiJ8sjQ5ZB2Vs=;
 b=scUzPaISNr7yqA9e0UJGGEfGGJSbhYp2MVgn9Yynjy337Q1Cvjhm/WDe/TKJsYDdpX
 5qHUoYyrm8duvN2OeuuZOJrtjOubR3K3s9dxMP4o86GjupFkpWHXBS4dTaUSyhMDEH5i
 YMrW7eKoPlJb8hMwosTxo3y8AOND1BnBFw1xli8Y19q3rAL2n4+wIaIT/UYIeYPHt5Ir
 pzZADyvJW7ZUXeyFmvNHq+YvmILnq1hKItQHQ4K06iP5E1QIixn8UOH/enpLtTv1bufE
 hDaWAhrvkh9lT1IefV5WsHrfD/MxpvygXVqqkyrzYtXMQ9pvhChVeKiUHnW3MFjVZe8R
 GAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667878; x=1735272678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m3AWL6HxtV2uFTdmZozJUF3KalTOisLiJ8sjQ5ZB2Vs=;
 b=JvARlqc3oQaRKkZzBs0BRToJX08/XoOl3X20YuDGX6WZ2frIRonFBcPFFGYDuewxOQ
 oEdCFF/qFuDYjJTxMCw5PI8BpNjdmwoteC9meH419C4Grh9SOUxvEdkTnHPYdtgthgQ7
 tzfmDebzL7IWuZLApiqO2COJcelB1ayDBJKw5Wmc/7iURshll4PAwD3Jy/GPuZEJghUN
 xfroJSmrOkwYQl7vuQJ1YYgyRcAPuTxT+aDXWCvROECZk4gK+gsdYBnhkJCaTj8IXE4u
 xbL5vn7MSKshioyEiz7gORIYC+UQdVE2WHQran34dtSecChCM/pHBq/0Cqq0yry7foan
 zTHw==
X-Gm-Message-State: AOJu0YzjPv9YghGSQWvACS3MWKBqoKdME//QORqU1lJcnSQ/m6cMHAQZ
 5ITeB7ajcDQ6tMJRxD0mXMFRLfztRDVhEvPzGB7VBJyF8h4hXievUEfz9N9bNvCaRaKxzSBBw8u
 k
X-Gm-Gg: ASbGncvYBb7JxFajeK7TXUc3JXhVFQMytf7keai99A/COei1nl/TEnxBi78MT8r9LOa
 Qh5jj4Fgd8B3pmT/4s2Kobl9b1wU1a3SMKVfPQFmZnutd7VlgRvOmxKa3/CmjBXMKmP2wG6qaxA
 2Rzmo/5SeXj/gB70qlWo/R+rpuR92vEQ6xfC48NZfbEm2AeVaso6LMssQMzRSMnXB1lN7Zo27Yc
 f9scuj4u4qOu4jB9hNsu9bQxgDAbKpKaGkGdFMeiyTjmwHAbo18m8cb+xTaceI=
X-Google-Smtp-Source: AGHT+IE4H+EYoCowirJF6/SSZUuv48qI7Bgi0t/rnS+KFE/Femva1HMZUf0FH+07w1ChzhzBcXi1/A==
X-Received: by 2002:a17:90b:2e4a:b0:2ee:ab04:1037 with SMTP id
 98e67ed59e1d1-2f452e36956mr2448055a91.17.1734667877991; 
 Thu, 19 Dec 2024 20:11:17 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee26fc22sm4165260a91.51.2024.12.19.20.11.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:11:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 18/51] tcg/optimize: Use finish_folding in fold_extract2
Date: Thu, 19 Dec 2024 20:10:30 -0800
Message-ID: <20241220041104.53105-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220041104.53105-1-richard.henderson@linaro.org>
References: <20241220041104.53105-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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
index 6f7166414f..30bce33ca6 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1789,7 +1789,7 @@ static bool fold_extract2(OptContext *ctx, TCGOp *op)
         }
         return tcg_opt_gen_movi(ctx, op, op->args[0], v1 | v2);
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_exts(OptContext *ctx, TCGOp *op)
-- 
2.43.0


