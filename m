Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D4BE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:13:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUMZ-00006I-Fn; Thu, 19 Dec 2024 23:11:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUMQ-0008TX-B9
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:35 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUMN-0006Oq-Ul
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:33 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-216634dd574so10044195ad.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734667890; x=1735272690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ln9D/mx3EiGh8lpioXoPks5hCwXKzkMo/aAb3sVv8V8=;
 b=c08SWE+4t97wrT2eeC3SyquMtkvoFQO78UM/g1q6fvY0qe3lKhS6nXJZinFSpZ7z5V
 BdYZPHV2Vdms8qTYQy9tONtd2c6FLVvHKLPZMPgQAqR7NRjzRdA5+R8YSCvd5BpZvS5a
 1kUmK2cVtJhbLq82cvZg65ud5udJEmCv5cNtlfgRGWl00rexVSan7zOEf870q8MgUz2Z
 ROe6TpkWc7+/W8B8FRBL2BQMVQmB5ixkU8foJFJCh9m1Eokwyue4XL8Aovl3DbJA24PD
 zDx29Ihcku7euO9VDNKzFFiKIRRyauPyjHnlQp9fB1Et7LIlrFnrSL6sneQAVa3tGKim
 mhLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667890; x=1735272690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ln9D/mx3EiGh8lpioXoPks5hCwXKzkMo/aAb3sVv8V8=;
 b=LvkCWmCCfqgsLCwfThNLmoeGDgmfxuh/HTG9JY3BoCdyp0k4GZdGYdIQtucfgz/w9p
 vrNuWdHdFT+JwcAVTNWuNCZ73oayrw17uyZJCHEo48T50u/2xAifzhQPiRHHChrcWNZr
 bFmgpvJ9wIZpLTfQWyEmGksEEjLW6vl72l7dADzw/v4XsWKnXCUoV4gRoO2zB2Px2M5A
 WR0MQue0RXXzIovMLhZ1fuQkNh1VFPO/bUOsvc1rm49hHGMLNn3foIk4g8YXRPBHTVRw
 nyer2+dTV96bzvIutBxmYP0Zu3Wn+GiVA1TnxWT9HDoWNL5qQ9AVIENWiLGFIvpkcqGy
 AA7w==
X-Gm-Message-State: AOJu0Yy69EsFAv875LEm2hLy4apSIcEYpU8bLROj42/yjWVy2DH9fYfz
 XhkOgQ4QN0VFpJUkXTpWtKDPmGKl7ETXoK5XvUb5vuHExNZQfCoctmA0Enf1RsksigTC0L2JRx+
 b
X-Gm-Gg: ASbGnctSL+03z2rnl1hit3Tk2NH6tOb0qCGg+TY/1UONMEOqKffVgCxl5SwfrkM9mIq
 J0jjJAsyHWNSlsfN6kxxb3RWKCRNXw0R2LbU0XRYsSCQSDGNiGjpiM4F+RqrC3xGZslc7A8z16k
 Jcyr5q0s2/RGnVYjTL6FewJfRH/H76+MaZfckRuPi//fRoQJ1N0lD57lr8UgzC/Hvt1+21ArlNZ
 MktiCjCmne1LZt5wmtuMfQAY+RzSsIHeIvuq1F5ymAbPEXl4vyzlWA6wbUlzEc=
X-Google-Smtp-Source: AGHT+IEuOIKpw/U94OpcRjNTdfFjukpkoPR96CmT5WIwc3O2Pe2dPS/EOHNCIvP2aE3nolAStiBZiA==
X-Received: by 2002:a17:903:2c9:b0:216:18f9:528b with SMTP id
 d9443c01a7336-219e6eb63c2mr17343375ad.26.1734667890473; 
 Thu, 19 Dec 2024 20:11:30 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee26fc22sm4165260a91.51.2024.12.19.20.11.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:11:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 34/51] tcg/optimize: Use fold_masks_s in fold_negsetcond
Date: Thu, 19 Dec 2024 20:10:46 -0800
Message-ID: <20241220041104.53105-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220041104.53105-1-richard.henderson@linaro.org>
References: <20241220041104.53105-1-richard.henderson@linaro.org>
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

Avoid the use of the OptContext slots.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 079b5b82ba..5bfcb22a0e 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2404,8 +2404,7 @@ static bool fold_negsetcond(OptContext *ctx, TCGOp *op)
     }
 
     /* Value is {0,-1} so all bits are repetitions of the sign. */
-    ctx->s_mask = -1;
-    return false;
+    return fold_masks_s(ctx, op, -1);
 }
 
 static bool fold_setcond2(OptContext *ctx, TCGOp *op)
-- 
2.43.0


