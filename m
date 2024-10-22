Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4503D1CDDC
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 10:59:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3CYv-0001lO-TD; Tue, 22 Oct 2024 06:56:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3CYo-0001ia-N5
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:56:24 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3CYn-0001yt-47
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:56:22 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c9709c9b0cso7211143a12.1
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 03:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729594580; x=1730199380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LfxPswSzpy5PJY7wIfJ4Znven71oBCSA3p2JUb9OqOg=;
 b=hXzWgu13QIr+QYXUj0yTO/727/OWh1+qF08195R8LmqpA0NEmVZmpMPGHcFWEnY3oq
 hDRjYn51SivmTdwDsF9fvc0xhO9a9DqSl++q0aMnZbejrmNEuJcbPIMK99ovAsZvedM+
 YjpRGUvwuqxxOyZ4JLGykLTo+p3aOp1qwj1yOESz1Qj/5sm7dRonCj8KU3Xd8cB+AbzK
 2irrfiFTh9EcyzbuICBcRuSAJXdARqXl6Aq445UnkNcxyfPHS6HokXGj8TiJ9xDyDdnh
 gKe0HX6NOJAL2x40Uphr6KIN92iQs/Eycy8IxQ/W5n9462h9tHZNMMn2mg9u7DrbMZlv
 0vXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729594580; x=1730199380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LfxPswSzpy5PJY7wIfJ4Znven71oBCSA3p2JUb9OqOg=;
 b=rohM4eX/iRx+43i0oGMoK9wfxS3wt+diSOh7+TWQVRAq91hT9yUAY9hGAYZpU0KbCn
 m0QmMNekQlVyzJAfdvGjrKFQLxCznaGyd3pk+GeMRJPZApXJ586rOvcuqOVVwd+6KYPe
 fnjHXsmNB3LTyfmZcWtQw3xEkMCH9h38RW90mTYVZDLZrGQPDEHtq3WNtHwBl44cK4Qm
 eAS+MNp9gymtg25Xe81Sg8ElN+Hky19AiTe9SRWat5awWsmV9b80cNZO0LQUpHKsYSql
 Sb4jHMEKW9jZjxvVAO147kBf7AzwQNNIBUf/ybX8QQjcGFtRjtCSYePYa6Yw+hFR2SFj
 79bA==
X-Gm-Message-State: AOJu0YwvOXnrmmfCiHRW1o0p9fphg9DAmMKgMmMvUY8MdIVbADUKOkpO
 7QR+OyTzbawZ4vxFlXa5Eq/8N2/QEF4R9uK/sLuKUDcqzWKE940Rs1bav9lxe94=
X-Google-Smtp-Source: AGHT+IEWTHq0nZKsD5+vd+nTSltz6qRpJ8m1ZUA3e2J9fRXNb4Q6Dz/tYps28BHQ7v9MYQ4wj/pQ1w==
X-Received: by 2002:a05:6402:1d49:b0:5c9:57bd:e9d with SMTP id
 4fb4d7f45d1cf-5cb782f9e3fmr2351410a12.19.1729594579617; 
 Tue, 22 Oct 2024 03:56:19 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cb66c7262bsm2981150a12.82.2024.10.22.03.56.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 03:56:15 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D35445F8CC;
 Tue, 22 Oct 2024 11:56:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, devel@lists.libvirt.org,
 Cleber Rosa <crosa@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 02/20] tests/docker: add NOFETCH env variable for testing
Date: Tue, 22 Oct 2024 11:55:56 +0100
Message-Id: <20241022105614.839199-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241022105614.839199-1-alex.bennee@linaro.org>
References: <20241022105614.839199-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

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


