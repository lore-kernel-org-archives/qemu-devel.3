Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF72C8302D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 15:38:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWGSD-0000ds-Pp; Mon, 30 Jun 2025 11:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRl-0000T0-R2
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:34 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRg-0008Fj-Bd
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:27 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-735a6d7c5b1so2381511a34.2
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 08:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751297359; x=1751902159; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YeB08dM1GirUDHHkoGDhYbViaKd2Vk7y8u9Bgs4GdjA=;
 b=TzBOuD39BOLwZA7tTD1rLE6UcDIVbUIyeV4CUPJfBjKdr9mHPF/43iLMEbiLseu7KY
 y7murzcZ/cuYnF5qOvz4w+Jks1Fhe/UUpDWeoX+hVe2mXJpKy4NhQU6jddoc8DsfuZwf
 9TTVodHf0T3PmegpLZQeIpH836Iz59YYlPgXlCgzPtgUDwCmpnLiLMxXLlq4aBneEtGP
 Nm8ThHTga+bYWsndPPBdLNIUfLUu5WrOHCqVpGUD8qCEiioW/9OArinW3yRhsZ9LValj
 WJ4k5OXBVZfaSeJMS6zXQVoNvEfk2/+P0mzNigCDWcCT7DinIfq2YUN1LVRBCHdDXWJ7
 D7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751297359; x=1751902159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YeB08dM1GirUDHHkoGDhYbViaKd2Vk7y8u9Bgs4GdjA=;
 b=RxQFFqRpZtycRBsBmiQumQ++6en59RNZfBKld0bAkZHwg8PY+Tg5QyQQyDvZ4GEEj2
 FeLixCnTwYR8rPuKdd1b/Jfpj4BddxCWxsIbxkOi63n5c35Xa2h+yjJ01TzPFhxjm0bf
 YG91RummjNkQ09YCiVO4tQ7ogFd4wAwyxfrfO/YWVnjfPjkYWjNs/L3IbvCVzk/OpEkG
 jrbJIBxirnOiJioxXhosrc3MlmhjIKbw9AUSCuQ5xefvspAIGgatvI057HMdXD71JQwK
 sunOuLN+3RurZlu8EzyjgAujOVNCazCagoBrcP/r+p2mJJRRteZyvljqCDI2y/rxu+fV
 D7XA==
X-Gm-Message-State: AOJu0YwM1tLH+/lxHi6JKUwsq3y6e9z+4P7yEcEYTjJTfuqxQV1d3U73
 3wqjcwmitJAfpBCPFv4TOKJj4c7xDl5yeiVx9Bz98AjVTbTTAF6nGEXrha6V2Cc2vZ+exvonGwS
 BAXrb
X-Gm-Gg: ASbGncvEnIbRXDs56yyDsBBDl2CrUS6rAZue2nKNRy43gRP5zGNzXyC43EeM9WNqnzz
 +7Qa/lFkMYLpo3+EqSiF+hzWK1wq/ieHBfO3UChcYWoNQqTmJ70G23PbL8mzniSvNIO3HegOqAb
 9K41IXiZIcCyTw6tgr3y0XNjVWp6qjmsGuqa6JhcUyzuDIhiwxJdNdQdpWuKZrjJhTWB+zaJqb2
 DBIaPsc8/nXQqUmJz0Q302tWwB83x/qMpssrv0xLnNMT51WdT7W7oYxqqZBDWV4BMoz1Y8wLFwX
 9Ha5zyT3HDDv7uQpKce4Q55Zt+2RHNLY6qPfAqw5/wxMmZMgVWUnVc7MIxtJEO7Aq08Ymw==
X-Google-Smtp-Source: AGHT+IHnXoFN3+CuigfVCsPEzfixqqjt/O4I/avp1HokV2LFCaxzhP6Ne+91opvNtQp8QkJGE8/oiw==
X-Received: by 2002:a05:6830:6102:b0:73a:96e5:19b9 with SMTP id
 46e09a7af769-73afc43ba7dmr9346645a34.2.1751297358747; 
 Mon, 30 Jun 2025 08:29:18 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb00c48asm1712478a34.27.2025.06.30.08.29.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 08:29:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 22/29] tcg/optimize: Use fold_and in
 do_constant_folding_cond[12]
Date: Mon, 30 Jun 2025 09:28:48 -0600
Message-ID: <20250630152855.148018-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630152855.148018-1-richard.henderson@linaro.org>
References: <20250630152855.148018-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
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

When lowering tst comparisons, completely fold the and
opcode that we generate.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 0b441bc611..aa64f15779 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -784,6 +784,7 @@ static bool swap_commutative2(TCGArg *p1, TCGArg *p2)
  * Return -1 if the condition can't be simplified,
  * and the result of the condition (0 or 1) if it can.
  */
+static bool fold_and(OptContext *ctx, TCGOp *op);
 static int do_constant_folding_cond1(OptContext *ctx, TCGOp *op, TCGArg dest,
                                      TCGArg *p1, TCGArg *p2, TCGArg *pcond)
 {
@@ -834,6 +835,7 @@ static int do_constant_folding_cond1(OptContext *ctx, TCGOp *op, TCGArg dest,
         op2->args[0] = tmp;
         op2->args[1] = *p1;
         op2->args[2] = *p2;
+        fold_and(ctx, op2);
 
         *p1 = tmp;
         *p2 = arg_new_constant(ctx, 0);
@@ -929,9 +931,12 @@ static int do_constant_folding_cond2(OptContext *ctx, TCGOp *op, TCGArg *args)
         op1->args[0] = t1;
         op1->args[1] = al;
         op1->args[2] = bl;
+        fold_and(ctx, op1);
+
         op2->args[0] = t2;
         op2->args[1] = ah;
         op2->args[2] = bh;
+        fold_and(ctx, op1);
 
         args[0] = t1;
         args[1] = t2;
-- 
2.43.0


