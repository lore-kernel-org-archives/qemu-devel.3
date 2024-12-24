Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD82DE7718E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBAx-00049j-G2; Tue, 24 Dec 2024 15:06:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBAE-0002y4-5h
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:59 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBAC-0002dP-Lb
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:57 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21680814d42so52215035ad.2
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070755; x=1735675555; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JbV7ezqIGFwEAzD5BKNZbxFvhvTByi12RrhcY98hJws=;
 b=xXLKM4kFYrGX7RiViWCzc9XzH6BfI9I5Ylrn6AicxTBNZaCcSGkYP46lQcDrtG32Yz
 DH2cUbQPkgXNLSra6hk3feMcx+usx3WHolQvpKOIacr6sPLNTOZt35CsjcbbLcgRxbwP
 4leseye2NBacgwfOKzje5DSwwDU8Rghh+uxR+KB2ls6jeJYWwvkZh1tg9yTmEZyMOtLW
 BB1BSUozwzEy/9ecgixvXiMv+X/mVN4IUT+83ecwu1kWW1MPIx5RNF0uDIz9CnTGyVe5
 3okr02jBf0OlKsmVvz3kk7Bpnz57+p2/PlvEXIEYZ+takVJfLzWZB+Tq5vuzxnRGAbVq
 Ifgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070755; x=1735675555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JbV7ezqIGFwEAzD5BKNZbxFvhvTByi12RrhcY98hJws=;
 b=IHS6eSk/IxSYs0vImqaNGDzy/TCvLvHIL7OiWdMAlHt9A0A3/3MUsSYuwvWDHWDU5T
 An9tdViURx/KuvhyIoRLtJ4QLqjykCXeVA2RV4MttZMHTZ6hVghrbt3mz3IF+JFoIow6
 w8lagvSaS4EX1676P8E6wIC622QzvpF3+YXs403A9KCMkNKz30KXGz9M2NzsMuuDVhaC
 /ReQxCl6z9G8U7YQPrDgOQW3S8izDz5MSHR9JgTXZm76MAjYbWCDq8GnDnRkY0U1TBuJ
 zpDubeXDv3zsGRGA98c50lxi74Dl6L5Ljc0NRUTYvvZtUlnB9cMGv+egF++MMMG5/win
 WbHw==
X-Gm-Message-State: AOJu0YzNInejlDakDVC0L2j1s8Pp5zXqs+TncWVlEtLRGp4ReBcNqABi
 QQEuoZ/2zU9dLhmzA/tL/G1FODVHw89vNNcuTVjhBgmyraZJCpipDEtRiDN3fIvbHXx59RcaC/z
 MY0o=
X-Gm-Gg: ASbGncvG4BT8g/1GLv0ov3r6bDQvSTR2J/Pw/dgD/Rhf4kJbW3AQEx8qCcr6syBQYBB
 D6n3DelXK5g3lKqO+po44PFrb0d6d98xHaEcfB1vJruNeSSgd5sIE81krZyskbLCbAbxviwatxX
 6evy/cSKzzcuu26rWG1h4uUZCe4sXcyxoQu+8uGCZTwkWZxMnLWIAf5Yx897t1mzLNwmuvoRem9
 DyphBANeX/jhWhAl0YcjGPE2fGV/lKTIvaQ1V+Nv/0zRuG80eqk3BsrkWAg7XCc7l5KoVVNF5ob
 R13vWhbDdX+dcsq66/KhXDafDA==
X-Google-Smtp-Source: AGHT+IFZ8gM0uXHoR2APVEDoOHqfSyNnge6oyo+GEbhHN2FXdD/iPsEv5n1FX78gERtM/x0dmXfBXw==
X-Received: by 2002:a05:6a20:1588:b0:1e1:e2d9:307 with SMTP id
 adf61e73a8af0-1e5e0802532mr22399254637.33.1735070755101; 
 Tue, 24 Dec 2024 12:05:55 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8fb895sm10027159b3a.162.2024.12.24.12.05.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:05:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 35/72] tcg/optimize: Use finish_folding in fold_remainder
Date: Tue, 24 Dec 2024 12:04:44 -0800
Message-ID: <20241224200521.310066-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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
index 07792c5351..e78f5a79a3 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2152,7 +2152,7 @@ static bool fold_remainder(OptContext *ctx, TCGOp *op)
         fold_xx_to_i(ctx, op, 0)) {
         return true;
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
-- 
2.43.0


