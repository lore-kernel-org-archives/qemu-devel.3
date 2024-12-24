Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB99E7718D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:08:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBAT-0003Mm-KJ; Tue, 24 Dec 2024 15:06:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBA5-0002pv-NF
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:51 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBA4-0002as-9S
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:49 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21631789fcdso46982955ad.1
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070747; x=1735675547; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8faF0oSE8gzDQC6SYYBtFIF/07pdwecYEYpdE3G9skM=;
 b=KYw7HcC4uVKEqyhythEKIVNaVlby5crkZqqj5TY/qY+5khpcQsasQk4hAI3DBLo9rz
 ezHNhgGlnbnEOB7RPCkRc5Jpf9cTnIWj9FLaLl3s6SVndAlyXLkowpDiSOnA0aao8Ki3
 SQMpWuIqjh8MR8ciIxjGWPv7/J8Ln2UCrhdXnIgXOHoiPU7vljH/U8/p9js+ZdBm7lO0
 DI89uOJA0huyivYIsJHyDE++BLhxXZ6mG8VXCA6TdrU600Kvu5z8aAvrLhKysAFCqg4g
 TXMTEhEOewyQy0jE56CjDpJSR1LOdQg8v1/eiyE7H+BmeXPOD/Q4Mf8aF5pb5flLmYZ9
 JCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070747; x=1735675547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8faF0oSE8gzDQC6SYYBtFIF/07pdwecYEYpdE3G9skM=;
 b=fq79QT9AY/H98kv/WQn2dYEAuXLeXUJGLwKvdvLo17YYbyE7JpdRQRxUKfFde90Vcn
 vNoja9/ZNjOXjT23cKHsMqHucz6Y2SkrCieGh/yO3qDG6nP9wdqD2nOob7th6UFWqj5B
 pQJgvkuDWkv39FTJd7d54CeHNJs8gwVjVzjy9YT+9ohCqCeaQMBaIzTH27PwaRSA/y07
 yYwDeOYQBapnKvb7G2H23g+PeyHD/R2sD4zPa4o56mE43CBKSK8l/eyFaEbSRJnoNbHl
 Zom2S9YTOmRTslHp+pJmBvvvZwLIo+1HPrnj4K8UhTic49IkewHWqyoWzVbcZJ8hhQIu
 KUIw==
X-Gm-Message-State: AOJu0YwgSYdWAH7dV9CAEKFSuwg5zMDKf0T3EKOZnZdaYSG0ZSaT4IQ2
 bEeuAeBiS9REWbgFPmSCkx/h17b0KsMmE/czDJKfcRzcI7Enp7mTB9Qx8Vdq3zRHZFYL9YAaPEO
 +hrA=
X-Gm-Gg: ASbGncswRUiI3SC/bzGRNryVwRl8Ua6fO03EJltNDtR6AtiIc9x4DeZbC5jjY6oM2E/
 3UV5LBFWyXOMD64qSVzuoitKoS7608B+tbqI6G8QY1eeJcN+mWrm0LJSRzPfJCFSsuDlll70gzW
 +BFdOxc7GgxH31Gt9vYc0+0HZPQY5zZFztRDFdNOHXCoYOmjvu5JxStaX3+rdKodwqoIEBveJGq
 GfKcf1xG98N/Nq6VKsChr8XvpSmANOLwM5iYcasBwkajCmeNOxEJNfj26HkOIGmBN+gXA6iGJZe
 vAak9XVkF30ABgyPLCRy6gsj3Q==
X-Google-Smtp-Source: AGHT+IG0VOzgkWI7aRvCq5mwIrcS1j+SH/Lmho8o3KLhpIreHLVw3YWJts5jLUXYUpcWnXn49KPw5A==
X-Received: by 2002:a05:6a20:7484:b0:1e1:9dfb:2384 with SMTP id
 adf61e73a8af0-1e5c7001f32mr29900262637.22.1735070747065; 
 Tue, 24 Dec 2024 12:05:47 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8fb895sm10027159b3a.162.2024.12.24.12.05.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:05:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 26/72] tcg/optimize: Use finish_folding in fold_mul*
Date: Tue, 24 Dec 2024 12:04:35 -0800
Message-ID: <20241224200521.310066-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
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
 tcg/optimize.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 0104582b3a..10d1376f62 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1969,7 +1969,7 @@ static bool fold_mul(OptContext *ctx, TCGOp *op)
         fold_xi_to_x(ctx, op, 1)) {
         return true;
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_mul_highpart(OptContext *ctx, TCGOp *op)
@@ -1978,7 +1978,7 @@ static bool fold_mul_highpart(OptContext *ctx, TCGOp *op)
         fold_xi_to_i(ctx, op, 0)) {
         return true;
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_multiply2(OptContext *ctx, TCGOp *op)
@@ -2023,7 +2023,7 @@ static bool fold_multiply2(OptContext *ctx, TCGOp *op)
         tcg_opt_gen_movi(ctx, op2, rh, h);
         return true;
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_nand(OptContext *ctx, TCGOp *op)
-- 
2.43.0


