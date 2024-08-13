Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83567C3DA7F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 00:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdf4q-00028K-KH; Mon, 12 Aug 2024 20:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdf4m-00027e-Cl
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 20:07:48 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdf4j-0002zb-DB
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 20:07:48 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2cd5e3c27c5so3214418a91.3
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 17:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723507663; x=1724112463; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=157xaMoQ1wBHg5AP7mTAiNkrbkrM8xUbKEuFo0jGCag=;
 b=yqwYrGosr2rDd4kKFvOUmtM2btTIFbyLSm8mbvpQYnEuOPQss0hbtFoAN/o7iuSdCe
 6cpUAWz9xSRqkC5mMqpkK9EJH2bZ25+2kNx0fAyMmwXepueX0sCxgrIzGRbRovln6xl3
 0sYhhF8AF5HXgDWjTU/JhHTyVzjxnYHqczFgsiiOM2EfGwQGHcx05hgYrzT+5awMjh3q
 LhL9DLeLU5SYdWP762FAMBH9K6rUSKjevmFTA/45ISRkDw5IGr3crcNVbfJb+YsV3g8d
 OtRt8HiOAleHElR7tAbcqrJ1iJMl3eCUqmGUZ9mGE3dfy7i2xjvCQIektJx++jP3G3bV
 yp4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723507663; x=1724112463;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=157xaMoQ1wBHg5AP7mTAiNkrbkrM8xUbKEuFo0jGCag=;
 b=m/dOa/p44Z63yWoufNg3nIrQnzUGQzT+DebyTM9fp9goyfViInInw0xoKiIxSs+4wU
 TQwlqiEvvUG13gtv+o4usqH5y6/GmoMdK9pT55t7XoLK8tfYhk8/f0nqutSUR4HW+9nA
 5N0mP1SLQW4soJ7JBJvmOZmuew7ULR2Q5IkrDUAmXZyNNW2SGrSOQxtsTla8boPfKgHc
 qT4n6PzgZqqBJLcmqdVZZ2d3JeG10wPhFlO/wbtS9jnbWK/esS6I11mKphuzLAyjrzcU
 F6ygr+S1QYPaaPQJC7MqHVYHI6Z+E3jw4jFAyZVekwG40BEaWFBSHgLUOcM0syDiHhNy
 GWAw==
X-Gm-Message-State: AOJu0YwH2sNWZ8G9XjEkAey/eFLqtV1S0Vskby0v/SeCeaFRe09kLcBJ
 vbDNFliJnlmKjrWbQnyXa7yu2dZCktwmWxHwkq+hYUiBv8hGQxSn5ReOuMrp3lJvKEOPrmsnq3W
 FxOw=
X-Google-Smtp-Source: AGHT+IEJBeQWkPKgXtzYFcHBOh1H38mMvLf9uwjK4c8Fc4YzlxUyBiaHLgxUmYHn8zqbitg5D2Knlg==
X-Received: by 2002:a17:90a:4b0c:b0:2cd:b938:770b with SMTP id
 98e67ed59e1d1-2d3924e0bdemr2033227a91.5.1723507663297; 
 Mon, 12 Aug 2024 17:07:43 -0700 (PDT)
Received: from stoup.. ([203.30.4.111]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d1c9c7ad59sm9055186a91.13.2024.08.12.17.07.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 17:07:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-9.1] target/m68k: Always return a temporary from
 gen_lea_mode
Date: Tue, 13 Aug 2024 10:07:37 +1000
Message-ID: <20240813000737.228470-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Returning a raw areg does not preserve the value if the areg
is subsequently modified.  Fixes, e.g. "jsr (sp)", where the
return address is pushed before the branch.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2483
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index fb5ecce0c3..5e2be846b7 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -723,7 +723,9 @@ static TCGv gen_lea_mode(CPUM68KState *env, DisasContext *s,
         }
         /* fallthru */
     case 2: /* Indirect register */
-        return get_areg(s, reg0);
+        tmp = tcg_temp_new();
+        tcg_gen_mov_i32(tmp, get_areg(s, reg0));
+        return tmp;
     case 4: /* Indirect predecrememnt.  */
         if (opsize == OS_UNSIZED) {
             return NULL_QREG;
-- 
2.43.0


