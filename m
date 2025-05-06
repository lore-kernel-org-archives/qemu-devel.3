Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C3F0C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 12:57:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCHrR-0003OI-EP; Tue, 06 May 2025 08:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uCHrO-0003Lf-Nt
 for qemu-devel@nongnu.org; Tue, 06 May 2025 08:57:22 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uCHrL-0003ov-1k
 for qemu-devel@nongnu.org; Tue, 06 May 2025 08:57:22 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-acb2faa9f55so746801266b.3
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 05:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746536236; x=1747141036; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=04euknF6hiqA68aLuG0ENQyvrvDpr8jpqKbpqudmzQg=;
 b=EyuQzSy6XqSFcBaBycfUQ7/1FCXDjdAySxnbj44O/VhgF5bKEeXxnEKL+3wvVOE3KQ
 SzyeExeCIRWM8wrBuwHejde6VhU2yQT47+dC6fAJXqT7sT0dSN4/WPPenKLS1WFcay5b
 pOsttJnJjIdWLWdAP2SSQ8Mcxis5YIz3MF/7+pYpJXnYop69Wbj3OPgIp+LsFMyZPZH6
 TWgaMrbxWsoKdopDgSKiEh70U//pRQ622FtJJOUq1mBaPrX88A83sPph5fiZ2mDzy3vW
 3ROnzM6f1+aMRr9eSokpM9Y+8kzWBl7watxDKCyYd17P8dtLPs/K73XEntWokrUI1pRO
 7YhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746536236; x=1747141036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=04euknF6hiqA68aLuG0ENQyvrvDpr8jpqKbpqudmzQg=;
 b=Cc90VbF2HLNqkPJVZtiaaMV0JxtvXcJ9w9qhGliKWyEiJY652L9ZpYTdMpVVwPGRV3
 ogI4g2zAOhG8ZCV1WJ9PUhuIeePo8Tz2C9pHhL2xCoiDkBRtuQ/31WY79onO14i+35ky
 IoIQQUAK46AQeLlL/oUdasKPjxAiADMpqoGJpvTHNl1Lin56WzCVpJkO/IWWin/tK0hg
 SrdHTPWEBmYnmzSRy/SlxFHgRb6DCkN+YsEZHDZtCsHjKUSyGR57s2TDhiGfGXEWST35
 P4S/UPSgUUvcxhZ6TP2+Reg3yMBwMOzCeA+TgBdUBCaswMk05e2I4HY9mmhy5v9dMcG6
 omYw==
X-Gm-Message-State: AOJu0YwtMwXaGPuPCW+id5eTt0JZf8WeMRaF8uIQJicVwPNXn6NbLAoA
 h2wllTtokmpIaOL1vIlkXQvOSE5rPyqcdZIJ8z6+WTqCEBGkyAphn3LcN4clkR4=
X-Gm-Gg: ASbGnctsQlO9cDlAI3y/18q691ArL/qiBtPiupGUlDrxJdTXomViR+LJm38XQ6mqYj6
 luKlJr4sfOmdumXWZiq9fpFjz8UbA4HEPoAgy78Xy+csBcNjsAAzZrlWuzB2l4auXOd4jeZpiML
 xjhpWj6G+Tj9rhg8jTVNV72fcz+ASNtX3ES8W0FtILs5+Oa8iYo85TetkVif8xle6Rl8Oo+VO5G
 ULu0eQ8j8XJ4r9cwdRUqXKcGMz8O25g3ioKvFyep9lodX/agT8fW4GA7Y7W5u0cyOwY+AMkmTcC
 V84LL45C07RBpz7ilUbVtHilqQ2GMdE+rIZlbLAxrT4=
X-Google-Smtp-Source: AGHT+IG8oOejUaa5cSdB9abs17+Bg2huR4Ig9dY2ZpZkMWO9AqovMeHZFgW/JB2viZ26riW6QFxCXA==
X-Received: by 2002:a17:906:564a:b0:ad1:8e78:3d79 with SMTP id
 a640c23a62f3a-ad1d3466a76mr236444966b.1.1746536236541; 
 Tue, 06 May 2025 05:57:16 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa777c8b12sm7766567a12.24.2025.05.06.05.57.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 05:57:16 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 32BA35F947;
 Tue,  6 May 2025 13:57:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 01/14] tests/docker: expose $HOME/.cache/qemu as docker
 volume
Date: Tue,  6 May 2025 13:57:02 +0100
Message-Id: <20250506125715.232872-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250506125715.232872-1-alex.bennee@linaro.org>
References: <20250506125715.232872-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

If you want to run functional tests we should share .cache/qemu so we
don't force containers to continually re-download images.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - Share a whole .cache/qemu path.
---
 tests/docker/Makefile.include | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index fa1cbb6726..3959d8a028 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -185,8 +185,10 @@ docker:
 
 docker-help: docker
 
+# Where QEMU caches build artefacts
+DOCKER_QEMU_CACHE_DIR := $$HOME/.cache/qemu
 # Use a global constant ccache directory to speed up repetitive builds
-DOCKER_CCACHE_DIR := $$HOME/.cache/qemu-docker-ccache
+DOCKER_QEMU_CCACHE_DIR := DOCKER_QEMU_CACHE_DIR/docker-ccache
 
 # This rule if for directly running against an arbitrary docker target.
 # It is called by the expanded docker targets (e.g. make
@@ -195,7 +197,7 @@ DOCKER_CCACHE_DIR := $$HOME/.cache/qemu-docker-ccache
 # For example: make docker-run TEST="test-quick" IMAGE="debian:arm64" EXECUTABLE=./aarch64-linux-user/qemu-aarch64
 #
 docker-run: docker-qemu-src
-	@mkdir -p "$(DOCKER_CCACHE_DIR)"
+	@mkdir -p "$(DOCKER_QEMU_CCACHE_DIR)"
 	@if test -z "$(IMAGE)" || test -z "$(TEST)"; \
 		then echo "Invalid target $(IMAGE)/$(TEST)"; exit 1; \
 	fi
@@ -222,8 +224,8 @@ docker-run: docker-qemu-src
 			-e V=$V -e J=$J -e DEBUG=$(DEBUG)		\
 			-e SHOW_ENV=$(SHOW_ENV) 			\
 			$(if $(NOUSER),,				\
-				-e CCACHE_DIR=/var/tmp/ccache 		\
-				-v $(DOCKER_CCACHE_DIR):/var/tmp/ccache:z \
+				-v $(DOCKER_QEMU_CACHE_DIR):$(DOCKER_QEMU_CACHE_DIR) 	\
+				-e CCACHE_DIR=$(DOCKER_QEMU_CCACHE_DIR)	\
 			)						\
 			-v $$(readlink -e $(DOCKER_SRC_COPY)):/var/tmp/qemu:z$(COMMA)ro \
 			$(IMAGE) 					\
-- 
2.39.5


