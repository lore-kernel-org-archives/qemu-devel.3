Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA48C87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 15:49:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufKcd-0003mU-Hz; Fri, 25 Jul 2025 11:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufKc0-00039a-19
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 11:45:38 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufKby-0002TE-AZ
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 11:45:31 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-607434e1821so3220951a12.0
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 08:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753458328; x=1754063128; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q4sxpQUxIXO6b5aTsXXmhMZvicKhgqHiA13ifXZz278=;
 b=d3WC6DJtb6uCxKzQscR5SQP48snBA5TI8YjGqkYssURAaj9kxL0/zBlqJscuouk3Co
 l5h7HiKpuZn21CSuHuH1/cd5RXasuZ9FTmXbGW6dOmr1bEVmQYfZUuwltAfjhpY2Ddm2
 b6XchgL5BK/ake23hmVoGqaGxP/EMyo6PCC1q+O8rj7sn5nygE9LJPInJpDyaXmJVrAk
 rqSxACqLpgsY8GaUXFqZvCPbwM+ybpGYs9XaXpoMczHfH3OwcLgO/kXfRTgM8P+sKIL1
 OBOxymui/OcP/bWgvPtUpeeHdl0JN32juU9dbWTkmwo09B7BFCKiAPP6AW4o4WBGlQif
 rSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753458328; x=1754063128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q4sxpQUxIXO6b5aTsXXmhMZvicKhgqHiA13ifXZz278=;
 b=Hgmm8IgZIbXisT2R3Kvuo75T2hVF8Agu+5ZfCg6j/cHVlSV1NkRga9E0NnmBy2uKO8
 TrxGFWu8yBUPMgQyCWbKEEZGvqatF+oMAdQxPMoS9hmOpQAYx/GMgdbY9kvCbuydUzP+
 QnjRiRXVE3Xt6IWrh6N5yokNM3/dkw4FNUJMsVjP2uBKqwGLm2gFA4fZiouk+hUxRPs6
 BVwW5YabR8H2Vthhp+KS/9leGpmb4GejlqsIaZXVFxhsNaNkpmYQhs4MRvbn0HUIWIKb
 v5mBrYEzq07ZG+BYsBNEIfgXzii1Y5TSCINGd5fBr+jwyygVrsS0YYOVWg7TPYqvUVdz
 xXRg==
X-Gm-Message-State: AOJu0YxhqrFp6/2bavvobWwoCIhqj2HeTwUy7PiLp7pvs1+qiYhjceKu
 G+nY6pNOqzr1ujXFu3/LmvDM3eWYMrDrvdP5gRFKSIkgzaOFdlOQfGWV197B5cAylXw=
X-Gm-Gg: ASbGncsI/bFcxaheNfzfRlfvvr8CYSVWY6dg3RSwcC4tkNGtdnpDIj5JNJou+sGZAtd
 ImtmhOgG1jeAOFm+JKjKY3tnym4hnX1TQ4+E49AH8hy4c9RUMwQ0lnqmJH4TeHdqCWMoG+n3j22
 3o9MR0Bq3yrOD447dbXbJfpDhbKzUhnt6z6sfBB2aKwRcY6M0GHrXiDpYyyNNC3dRPDZEjAYTL4
 OePusC1LfTrOpvjz3jAiFvAxoSgRhtClPfmnk8vC/kF3MGbB93uoAcqHRV6iT2S2x0ZQXXKXpQI
 BOhMfj/IKM9Mu+YbOwQdi4s0rLjcewWSVymqPI4oa2q4P9M+67GWvG2/WuSrWMiE7VuxdBdfN21
 mHFHDsXa3dIVB3cFukxBQ3FXJBSlr3YYq/w==
X-Google-Smtp-Source: AGHT+IFB84to3S4f3Zwv2w9pnM3WezHPnmM8+ZMISkr9y/9hyjWW38pHT4jyvjbMclE95UBxb7ofZA==
X-Received: by 2002:a05:6402:27c6:b0:612:b150:75f3 with SMTP id
 4fb4d7f45d1cf-614f1bf83d1mr2485584a12.8.1753458328049; 
 Fri, 25 Jul 2025 08:45:28 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61500ad045esm8029a12.38.2025.07.25.08.45.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 08:45:25 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 892995F8E1;
 Fri, 25 Jul 2025 16:45:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH for 10.1 v2 08/14] tests/tcg: remove ADDITIONAL_PLUGINS_TESTS
Date: Fri, 25 Jul 2025 16:45:11 +0100
Message-ID: <20250725154517.3523095-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725154517.3523095-1-alex.bennee@linaro.org>
References: <20250725154517.3523095-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52d.google.com
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

We never actually used this is the end. Remove it to enable
re-factoring.

Fixes: 7cefff22d54 (tests/tcg: add mechanism to run specific tests with plugins)
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/Makefile.target | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 3d96182a7b9..97ebe8f9bc9 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -169,11 +169,10 @@ PLUGINS=$(filter-out $(DISABLE_PLUGINS), \
 # only expand MULTIARCH_TESTS which are common on most of our targets
 # to avoid an exponential explosion as new tests are added. We also
 # add some special helpers the run-plugin- rules can use below.
-# In more, extra tests can be added using ADDITIONAL_PLUGINS_TESTS variable.
 
 ifneq ($(MULTIARCH_TESTS),)
 $(foreach p,$(PLUGINS), \
-	$(foreach t,$(MULTIARCH_TESTS) $(ADDITIONAL_PLUGINS_TESTS),\
+	$(foreach t,$(MULTIARCH_TESTS),\
 		$(eval run-plugin-$(t)-with-$(p): $t $p) \
 		$(eval RUN_TESTS+=run-plugin-$(t)-with-$(p))))
 endif # MULTIARCH_TESTS
-- 
2.47.2


