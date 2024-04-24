Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5930BC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 22:53:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzlSj-0006yo-Ah; Wed, 24 Apr 2024 18:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzlSh-0006y9-JK
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 18:51:35 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzlSg-0006gf-0H
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 18:51:35 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-60275a82611so308014a12.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 15:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713999092; x=1714603892; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hIaIEQSm9VCOv6FXtjW2b8GU4ZH5b2a473JIJYHIFaQ=;
 b=B8pj1X+uCGrkrMLRzjaKrI0i7tliJ1bm0K8dIAxN3sEHU3m4UBtUyq7OruVwa2kgaA
 YiJpWBnp8tj0p0stOA54Lvp5akbesHWtSIiyXAlAocSkCsSb2YHraZqbWn3d/wUcV/Zx
 nklwjXawCb6443eydVtxI/m7o7pD0JCgRlG/dytJkWiasFK7jR8DcylUy7u4KDxLS7NV
 8aZjUzqV1eyfS6ejMTto+Bhg9Q7IRcSSrrKpBRK/AOAEyVmdOw+UBCGuaXUT+Zc2Gxpg
 Swe87zIY24U2VpE2GqhYLRPH4dM20pMbUyZWXLFJyE2O2aurHMRsXU88oOimJZrtCWvL
 whbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713999092; x=1714603892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hIaIEQSm9VCOv6FXtjW2b8GU4ZH5b2a473JIJYHIFaQ=;
 b=psmMQJj0Roh83xEh/k1Uj8NBIzi3jIwa5iyodU8zuHo+mukm7UDUDNbtFb+OO+YB0y
 6gBlRpK48Eknl8ORZEnbcM0WdF0BpP9yz6i4q/6gfuiFROvi4THELX3CbUKwTkmTfE8W
 zOor3U7QgZsDWp/KEy9mAESpRCKxTl1fHUavgxZWR49hTtzM4aOnAZXprQS0/xdzq/Id
 P1UfrSprScaAZ+pUD/f1FpHfAc23Nh0IiEeBD6Oasq2kV+R+ugxM/aGAH0rnLVaLLzC1
 4bwj6nCaR1rY9eLAdfUigr5b+7yRv8iFpcmrSLtZalQq/f2bIjiWkKgqjwJmwLLe02lh
 5wtQ==
X-Gm-Message-State: AOJu0YwCXd6nPBd1w+PgPj8vYBjEtKzG+HnGj38RW4EuMnHQca6QLYpt
 dou7yHgA3tBvENltC1BVyMHC2iqkdn0pvxzmEZHnxXJ7CZ9d59MZVJ3sE3NEaRFRTkoxZJouv1w
 N
X-Google-Smtp-Source: AGHT+IGiGpxbEZw2DQTNv1bxlxlGPhFndE2Eurw+VvK1IWTgmhiEcE1OttuHVKnQAf0En7W1X+SDaQ==
X-Received: by 2002:a05:6a20:5605:b0:1a7:a564:14db with SMTP id
 ir5-20020a056a20560500b001a7a56414dbmr3990710pzc.24.1713999092294; 
 Wed, 24 Apr 2024 15:51:32 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 it12-20020a056a00458c00b006ead792b6f2sm11960864pfb.1.2024.04.24.15.51.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 15:51:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Keith Packard <keithp@keithp.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 7/9] target/m68k: Pass semihosting arg to exit
Date: Wed, 24 Apr 2024 15:51:21 -0700
Message-Id: <20240424225123.929152-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424225123.929152-1-richard.henderson@linaro.org>
References: <20240424225123.929152-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

From: Keith Packard <keithp@keithp.com>

Instead of using d0 (the semihost function number), use d1 (the
provide exit status).

Signed-off-by: Keith Packard <keithp@keithp.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20230802161914.395443-2-keithp@keithp.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/m68k-semi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/m68k/m68k-semi.c b/target/m68k/m68k-semi.c
index 546cff2246..6fbbd140f3 100644
--- a/target/m68k/m68k-semi.c
+++ b/target/m68k/m68k-semi.c
@@ -132,8 +132,8 @@ void do_m68k_semihosting(CPUM68KState *env, int nr)
     args = env->dregs[1];
     switch (nr) {
     case HOSTED_EXIT:
-        gdb_exit(env->dregs[0]);
-        exit(env->dregs[0]);
+        gdb_exit(env->dregs[1]);
+        exit(env->dregs[1]);
 
     case HOSTED_OPEN:
         GET_ARG(0);
-- 
2.34.1


