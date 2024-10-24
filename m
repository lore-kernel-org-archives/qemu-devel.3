Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7656FCDDE6A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 09:57:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3uZo-0001A5-6e; Thu, 24 Oct 2024 05:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3uZh-00017d-0E
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 05:56:15 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3uZd-0003mA-NV
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 05:56:12 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-539fbbadf83so969164e87.0
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 02:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729763768; x=1730368568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hfBF4IG40gAq+z9RjB260Feq7LCLvZW5XqsT3NxYVDE=;
 b=mtWLgmuQ+RlKG0X2MAomOroPvfwcwEiRSAFcuk0SnlaGojAcGh4pn1jTrpINZNjSBd
 gPcXkQEgA9LCx9kiTt7ycJ+h6VDqdwPaAqEjCVeNzWaZfJpJphhkK7DEMiMhsWJaD0pQ
 03VJy6KAKK2sGSW0twCSsexYN/TwiIYUivKfqg0dH9hFM23jJqOAkaTxbHgOGKjsNtXY
 RtraGVqHsEyG1xdwowrudKCXkFrMJqGZRdePYoKUR4929simx4EKM3zqbqhCOKNhq8ac
 x9mYv5kyeyl/x7mhzZIR9cxHfKIdPAwCso7u4tRk3jTpo8voBu1+m4aN0EG5uQPrlEmX
 gkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729763768; x=1730368568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hfBF4IG40gAq+z9RjB260Feq7LCLvZW5XqsT3NxYVDE=;
 b=FwlSgZEVc2a0zN/gKFNyCmXAgbYNFRT3q281ZXUn4nvEO1Ha+/vRHJ2bWwKAhRMqhQ
 omdXHfXpOOxwuFqvwYrgm9eFu6EhhyN4G0uSe98pMDzFnZlPbFhvOC9XrLZWkzmcs9N4
 H8KIJ3/8Uuh+WYyteUgTmn3OZh1D37pNLF0TSWuNu+WSuA1tQL11Z0dwywVYIym6CnnB
 BemgKhhbbBLRzi7RZksgkzZpiN1UhApv4u4GiK/XZqcY646ed+GA2YSG/HIigJ3KMbel
 BfAXfCIjrkt3/tGm0LPiH/7Wn6cf4uY01Z58tTkdMNkDkXzeFT3ZaVyR4Mt+imxLgKZ/
 ZTXw==
X-Gm-Message-State: AOJu0YwZxTi714c85KLsTqBUZE8QKzCxx/C+WS2STqlLqTZy8IlGCaPh
 YFm9Xt7LKNTcOZ7ul7Y+IyhS0XzSFqAGl0uF9AOE8363xQgc9adP625ZSFE68B0=
X-Google-Smtp-Source: AGHT+IF7kdZyumI4T2msl7eoIy24jwpbHZUpjzxCoNwJtV029L5SORwtsuiPQHzC/cM9wL8o5/oWqA==
X-Received: by 2002:a05:6512:308b:b0:536:53a9:96d5 with SMTP id
 2adb3069b0e04-53b1a3084c0mr2882148e87.17.1729763767865; 
 Thu, 24 Oct 2024 02:56:07 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cb66a6a8e4sm5491664a12.56.2024.10.24.02.56.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 02:56:04 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 349965F8B5;
 Thu, 24 Oct 2024 10:56:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PULL 02/17] tests/docker: add NOFETCH env variable for testing
Date: Thu, 24 Oct 2024 10:55:48 +0100
Message-Id: <20241024095603.1813285-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241024095603.1813285-1-alex.bennee@linaro.org>
References: <20241024095603.1813285-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x134.google.com
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

Testing non-auto built docker containers (i.e. custom built compilers)
is a bit fiddly as you couldn't continue a build with a previously
locally built container. While you can play games with REGISTRY its
simpler to allow a NOFETCH that will go through the cached build
process when you run the tests.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241023113406.1284676-3-alex.bennee@linaro.org>

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 681feae744..fead7d3abe 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -92,10 +92,10 @@ endif
 docker-image-alpine: NOUSER=1
 
 debian-toolchain-run = \
-	$(if $(NOCACHE), 						\
+	$(if $(NOCACHE)$(NOFETCH),					\
 		$(call quiet-command,					\
 			$(DOCKER_SCRIPT) build -t qemu/$1 -f $< 	\
-			$(if $V,,--quiet) --no-cache 			\
+			$(if $V,,--quiet) $(if $(NOCACHE),--no-cache)	\
 			--registry $(DOCKER_REGISTRY) --extra-files	\
 			$(DOCKER_FILES_DIR)/$1.d/build-toolchain.sh,	\
 			"BUILD", $1),				        \
@@ -177,6 +177,7 @@ docker:
 	@echo '    NETWORK=$$BACKEND     Enable virtual network interface with $$BACKEND.'
 	@echo '    NOUSER=1             Define to disable adding current user to containers passwd.'
 	@echo '    NOCACHE=1            Ignore cache when build images.'
+	@echo '    NOFETCH=1            Do not fetch from the registry.'
 	@echo '    EXECUTABLE=<path>    Include executable in image.'
 	@echo '    EXTRA_FILES="<path> [... <path>]"'
 	@echo '                         Include extra files in image.'
-- 
2.39.5


