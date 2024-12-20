Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D64E7718A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:18:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUQu-0003Ng-Ok; Thu, 19 Dec 2024 23:16:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUPV-0001W0-9P
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:14:49 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUPT-0006rD-MG
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:14:44 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7242f559a9fso1866827b3a.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734668082; x=1735272882; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r7L4FLUiYXqQ6+VueavIkRjEije4QoOvDQPVTQQ73H4=;
 b=d82HzSP6W+NgQxSV4RRhb9yniV9Z+9QpdBCqSshC/ZcenkGZCCiJGSfkzcS/XFdYuF
 p2jXgelnTrAYt5KXBgCMRwtfZfKJ6RHMnMrZ8FoXAQEXXSlBPpVebArDPHBAIPkWGPkM
 mmI7sfWHfX1pzaIMf64PPRRB9G7y91oj2z62TJvMpP9oMVcRvCsP69QQki5U0TxutnHl
 HNnAjVL9pTP+lmX2uE5V5vXO4W8dXxeOuOBne/vwnnwwKJedetw2/Yp5ym3pqP7xcBN6
 bv/uXk2kONlC/q8IdLTnQNJ2VHHc6Zv71mmHIuVsIPYjcvemGIFd0VV6ile6gnH+l1Qm
 1kXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734668082; x=1735272882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r7L4FLUiYXqQ6+VueavIkRjEije4QoOvDQPVTQQ73H4=;
 b=Hzi/6OjDl0AqcgdzHyuKGdLrzusYec5+FYvCPQxWS4LBPjB4T8lyGLBtDIog+WmBHX
 i3Zxr35hu+H2lCPLSr2jIhbRr+t2mFlC6VICgOlvHfFaGjvETpPrKO0+2MdMU9+/TQSV
 RMdvE9UKijBSUJLKcDj5cH+iJOmHAUV6FOeHxmqXiCkEhaak78btFbF+A6/+OE1Ij4b0
 kEteEybG8PNbJBh+pyr0so+bqkabIFk5JphvcT5AYYqJJtw4AGxTibKAPO+4HpTIoRUo
 oyvEKJBoM5YPkUVDIW88R/ze72Fd2+GhYNWusK0qjTGoQE5IZr4VTROPtkmLC3ABOsmr
 PPhA==
X-Gm-Message-State: AOJu0YxwghNKNeNvg19bSae3I+amFyvyATCPdEmANVOFhIXHk2eQcW7m
 qhuBrxru1PozDAtKi79gnITiPRxlWIgZijXMW5jCcqEjVk7jFBcSJSK/6q0Xg5i4kOFZchauvbt
 B
X-Gm-Gg: ASbGncvEsUaV2Cp7AC+CTB8StsmxyB9zLrTPRTiLVBrhCaGvJZhnVXPwYj1pzLHh5pH
 lU9hy6SuY6nsPf08H5VBHpF/HxI+7yjleM2YLNMh6W8GAyezys6t7rPgghUilFLfJwAJXflDRZE
 c6BlNK62EV6ew24faDUdcBq36C/mFHdbvHkzBr07cSMJPhxcZAukLL9CHVa9zTWpifmDtx2o+Zo
 uygVcQSMIQLaQtkjQtJJ6or5S0HaPNReuZR4eSvnTa+qLQfrjG/QHsmx1nqvUw=
X-Google-Smtp-Source: AGHT+IHhJtZ+WK0dSI7JdxWUDjlx/vDNxyrivZzm5MDS0CGNZOS5tknHLcC2A4bvx6qxK5sqom3+4A==
X-Received: by 2002:a05:6a21:339e:b0:1e1:aba4:209c with SMTP id
 adf61e73a8af0-1e5e07ffc0amr2924286637.29.1734668081957; 
 Thu, 19 Dec 2024 20:14:41 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-8529e78a55dsm506952a12.80.2024.12.19.20.14.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:14:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 48/51] tcg/optimize: Use finish_folding as default in
 tcg_optimize
Date: Thu, 19 Dec 2024 20:11:00 -0800
Message-ID: <20241220041104.53105-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220041104.53105-1-richard.henderson@linaro.org>
References: <20241220041104.53105-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

All non-default cases now finish folding within each function.
Do the same with the default case and assert it is done after.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 74d1ca7484..94be844ee5 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -3124,11 +3124,9 @@ void tcg_optimize(TCGContext *s)
             done = true;
             break;
         default:
+            done = finish_folding(&ctx, op);
             break;
         }
-
-        if (!done) {
-            finish_folding(&ctx, op);
-        }
+        tcg_debug_assert(done);
     }
 }
-- 
2.43.0


