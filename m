Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A27FE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUQ7-0001z5-0O; Thu, 19 Dec 2024 23:15:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUPP-000115-OO
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:14:39 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUPO-0006pg-Be
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:14:39 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-725f2f79ed9so1245380b3a.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734668077; x=1735272877; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=atQvaPE2FE0PiFVNmcXbnVbK/0bdfapYYtNsmIEQxj0=;
 b=gxIE6seK8VkIVMydtdQxUewAPF+3uItJm3rRtUUTT0fhOKok2Um0OorOEJ6tlHWvvK
 OmiqHfL+kxaySoEoSigZ0urSfzb30yGu7qfYAO1WCDyVPsxJEOylE7Yu1wX0ABe66Jxq
 vqCprHqqbXlSeNcSP8ZoBsZdR4zoAo91CERFYd+djJHBlkz5Vifcqz9VKL7Fyvgz55nC
 Bqwb4TJVrPfPpmH9yOhGri5T/jOzVZ467lGTJ1XzdiuOEusLG33PF5v0x52TmkwBrbf5
 xJNR+TqEkjKUKWzLGfi8pBJp6GJAE/IKWPki9luSJzWf6no71ON7hsD8xDyyEVoofKGz
 SHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734668077; x=1735272877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=atQvaPE2FE0PiFVNmcXbnVbK/0bdfapYYtNsmIEQxj0=;
 b=aMdFu8cyBuLOORDebXC4/I/5sILw6lkrxGgQkSpARfrp8iitAfKRAEcK6JgxfMyJ3g
 czoxSu4IWZgSftfCUZjP4HoQuCUhlOkjQiyFhPYW+iHUrwaoxCiAD0SdSlF4CyYnPBEb
 UT6Nw8+tFzxzBo/C9+OR5o38W9NPra/Kh3Kft0DNN67xPe/DPNvIzf2SN780rUEB9NB3
 o8qCYu69dze0kw965Yu+8p07zom5tUSdTwA4EHHlhEeruwfRqTmkeJqjuVrZzYYYCqMC
 HHQDkiGqHzx+WHL1M9umxJOjDq2DgEXDQBXw3UOB1aEOMe/Ez78N2K0aukE7kjG+jUKM
 nnNg==
X-Gm-Message-State: AOJu0Yz36sX+I4F7X8/LEeEXK5rrE+Tz1xwZa2qIZcbBKo5+7tk+/Q6h
 fbAaKuyoa9N0NO3EUUvezyAj+UxXTB2eNcsVxP9aCB52nGQNSxtld562IvvOGsQwUJTWrJb6kT/
 1
X-Gm-Gg: ASbGncvfV3zY1UZ6cy8339B44JJ6x5zyp/F9aXfC1ZkW/SlR8tEcIx5ZI9kqEawMjss
 WvPXpG4BqeZR5bD8/V+eQYnFLatSct6CqT0Oftvwq6PuyFDSyUFekfwefl9ZIThlFIbi8jmEeAy
 5082ASAQbwBpgan4CXBKH5a/wNrMu5C44zxG73km4c7OwkF95bU++BDp/N1+paPrUZJrjnO2oGi
 bXqlMtDTSWnYSdtoODWYqzfum3YXiK9M+FGs/qv2mQ4+zBHWg2AO8aL6rEVztE=
X-Google-Smtp-Source: AGHT+IE8dPTk93IhqzS/ajh76BoRXEs/W0Df7bG2QH3W6L/g+HDw2AHsmpyGo1J8j6WTHly5W0vTeg==
X-Received: by 2002:a05:6a21:3987:b0:1e1:dbfd:582b with SMTP id
 adf61e73a8af0-1e5e0461e18mr2930372637.15.1734668077050; 
 Thu, 19 Dec 2024 20:14:37 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-8529e78a55dsm506952a12.80.2024.12.19.20.14.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:14:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 42/51] tcg/optimize: Simplify sign bit test in fold_shift
Date: Thu, 19 Dec 2024 20:10:54 -0800
Message-ID: <20241220041104.53105-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220041104.53105-1-richard.henderson@linaro.org>
References: <20241220041104.53105-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Merge the two conditions, sign != 0 && !(z_mask & sign),
by testing ~z_mask & sign.   If sign == 0, the logical and
will produce false.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index da48aadd12..7219415fe2 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2590,7 +2590,7 @@ static bool fold_shift(OptContext *ctx, TCGOp *op)
          * will not reduce the number of input sign repetitions.
          */
         sign = (s_mask & -s_mask) >> 1;
-        if (sign && !(z_mask & sign)) {
+        if (~z_mask & sign) {
             return fold_masks_s(ctx, op, s_mask);
         }
         break;
-- 
2.43.0


