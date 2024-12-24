Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 792B9E7718D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBDp-0000OY-EI; Tue, 24 Dec 2024 15:09:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDM-00063m-Cb
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:12 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDK-0002wJ-Vh
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:12 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-216728b1836so49418655ad.0
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070949; x=1735675749; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6T4dE7mQpDnGfqvX4E7RoeAOsu5gIGr+d/C7xqfvwqU=;
 b=WA7r/kv98jIqIyrR0lXubhAKkPAptY1YtU+ANHVSfUkbfXmqOBa5VojI/oiJ/DvMZy
 IBjxxnobd3enwmxfKkmbmiBzCEvhMplm4FKdeSKi2mUwqIQjJhqN7CCbFEOsmQ6Gz5Ne
 D+avwK21PUl2m6DMpjFkbk8HMpId4DChfQdSoKTvnFYsEIpzdO6d3Ydla9W1AUwUA6F0
 /Oz9l+GLuXXF9kB7WtF1E+8/bhJqsL9OIzvl/vzcqmN7QwuO1OgeZlvwKGBMrSbov66V
 swHkLOUZdDB+ObtZvbPgxZpXSra4zipIw0mZ3/vbrnRbklU7h2ds8RmFdMOkUsk7m2XX
 o+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070949; x=1735675749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6T4dE7mQpDnGfqvX4E7RoeAOsu5gIGr+d/C7xqfvwqU=;
 b=pEcXuhoc2luTkCe8jy8GwmqTospgCbzMP9RXhRvgVfs7pY7iOKKwdQTs5H9v/k6LLr
 UT/L0zatTOt8K3GOi/QWJ/mSbYag6YF+K4c4T0myA9GpBZ8DQMZyClAtucctCzJx+Mym
 stgbL3au8mP41Ah/QXUzyFft0e1Tm+S88sW2ESVR205oT3FWQPsWHtkLiMMec8JDp2/Z
 /Cun2TogbhuN3+rAB5ZHHFPCXMWO7uWpTn7c+u3a4Wr5XgAybOYaU7TLcU8jjNo0BeUz
 KfP0f/YiLJEjNlO0Rw+D7OShviHMzgy6lLFdc+Vuyo1GqXjEXe1qqlJ1U+e6l0RDOZQv
 kk8Q==
X-Gm-Message-State: AOJu0YwD0bu2TpECMifLO09umwZC51xgLRGpPfJU6vUs66P+wUd8EryH
 YPWtVLdazIqddrEt9YIQaiLD59OrP2J2PqqHfplk7oAbXGe6eYDeQx5QTbDE/RXtVFwffjnkDa2
 95B4=
X-Gm-Gg: ASbGncvdZXjgj0Q0McSmHUILILseZquzdffgZWk73sLG+Dq2ddyfmpQO/ofnyC/Dqrw
 uZ0imfmKfN1+7ufapNrbXeGeV+hgxEI28con0JaUtOs5jouNG7DzdxLuLkUm8qa4AodyzZ71q8A
 O/DMMAVPpWTh7fgas9WgtmJsXelVoUPTHIHobJ2R6EbQWFqIum+93+1kdNlEL8LVwYjw1yIgixt
 b5hT2QVxpp794F+EoOxa6rNjbSqm9XcIFYEuN1Hg7IMsoqtBb86fvuLK5dlqquH88QfsisTrP2c
 OJTQril4LWYmFPZM+LuVheUWWg==
X-Google-Smtp-Source: AGHT+IEtQdXCZNho2AFaueBaqoZzg/SSoGPNShyclq/I7z5ze6tvWOhrOlJENfvRT94/O9jPeHa/Ag==
X-Received: by 2002:a05:6a00:1144:b0:729:597:4f97 with SMTP id
 d2e1a72fcca58-72abde828c1mr28376953b3a.20.1735070949616; 
 Tue, 24 Dec 2024 12:09:09 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8309acsm10033521b3a.45.2024.12.24.12.09.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:09:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 49/72] tcg/optimize: Use finish_folding in fold_bitsel_vec
Date: Tue, 24 Dec 2024 12:04:58 -0800
Message-ID: <20241224200521.310066-50-richard.henderson@linaro.org>
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
index d543266b8d..4271d14d2c 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2833,7 +2833,7 @@ static bool fold_bitsel_vec(OptContext *ctx, TCGOp *op)
             return fold_orc(ctx, op);
         }
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 /* Propagate constants and copies, fold constant expressions. */
-- 
2.43.0


