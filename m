Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1737DC5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 11:05:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMPPR-000856-EW; Tue, 03 Jun 2025 07:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uMPPI-0007vb-SO
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:02:13 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uMPPE-00029s-EU
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:02:12 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ad89c32a7b5so885354966b.2
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 04:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748948527; x=1749553327; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qDImHvyM+O+Vef4oVOgEwt3nOLQwPNOaNlg1VossPhA=;
 b=pH8nznyrVJVTvxoNLVCEr0IuuIpgGkah2f7cE2eIxWU371kJnMlIOp4rruVvg6TBGe
 yIV01mvuDRVnh6c1o/wY2PTe1OCtvfU2Q9hNHL0Ywh1gEaWpnSo3T52EeHZu+QNvyk5G
 WgzJ1SzzBVQK46yUugfr8FuLL5cz8lTcW0mHmdaBfJ1bjKCJYMtVeb/r9hocLGJoJYjb
 gqgRkqrXUvWfBuYSdmxQAxIusYtSeL6ef2iq81LZyhrEqI4LeUL8djbXtEJDu5yRva6y
 Ui7FCpWADlq+kNXtMkimRKF/QST53TMzsTwdw+9eWH6KWrI61xbDBp4f5TMYDvEeUyaE
 0TvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748948527; x=1749553327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qDImHvyM+O+Vef4oVOgEwt3nOLQwPNOaNlg1VossPhA=;
 b=RxWk7smWur+4QU/mNHE74tw4yUWAc9P2dMeg6lGcDEXhXCqEqXCZVAMdjT7r/0GUzN
 9dN1wz60AkDvpFzWGi7cSiU5n1q3Wh6npDlz1Nbv3lFvGIUktct5pJQ+WUQsWZf4pYoO
 z8n2Mf6GlU8Jfos0gBc8KtOq1julf4zbhT1gvWqzQ0wC4L6TK2iFcBsd+QHZkvMmfUH7
 VEV6660FIBp2SChKafAqhiFQg2O+57pYoov27jsv5hQ4fpIUX23q2EFSvjtq99379MJz
 +ANlXHnF/pLFeV9g2yelfYT7yL6sFqfaDHY44EiEucD1g1PqTJ2v5/VGR0JjpsX2iwat
 QEGQ==
X-Gm-Message-State: AOJu0YxdOOUAVItFBM986sBuA7FL5bTOIphw+ipHoi/kvhfKIf7kju5S
 RF27s3uGbHWPC1Lx4AbTPSu65kssMJGeu2/u5oya+LlcnXS0C2bIfJvbK2FD/nweUQ8=
X-Gm-Gg: ASbGnctGlgB8CmzIH/W2BPFyYPNJ9VxSgByPX+gTUR2yXE/dhnCxVHZwcHCrPXmE1fj
 ZnCOHf2DSxb+XEEervykDe8YZFRk6Jitua2jLIbXe7qPaudDyxodpbHHvV7/aHBsxyRsPvn/DHe
 1oybfQ1oZWVNwKn2FywrFGB5X81p9hm6nNkdrrHwcA2MA15h2sMhYpp1SAwADmqkqAaJMvHnXgR
 qDPIHBh0+gJG9m2F2cIMgYZeo/JyvnR/SX236YgRittD7Ca0xi0nKVpVc3dMVdV3WpgSrGXwtFb
 5mTiKy8dEgv2HQDuLgM598ik4mwLA96FAfFYx9gNyF4ITG8Hfg1c
X-Google-Smtp-Source: AGHT+IFYR27+0hmtrAlCQgeTt4UM1g0rBDyw6O9t6Wkih+IUSxorA8OiXpaJ83EcGNwDTGFlXjsjgw==
X-Received: by 2002:a17:907:d7c2:b0:ad8:8efe:31fa with SMTP id
 a640c23a62f3a-adb32599e63mr1653947966b.58.1748948526429; 
 Tue, 03 Jun 2025 04:02:06 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-adb35af4456sm733280266b.182.2025.06.03.04.02.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 04:02:05 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EC66B5F9CC;
 Tue, 03 Jun 2025 12:02:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v4 01/17] tests/docker: expose $HOME/.cache/qemu as docker
 volume
Date: Tue,  3 Jun 2025 12:01:48 +0100
Message-ID: <20250603110204.838117-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250603110204.838117-1-alex.bennee@linaro.org>
References: <20250603110204.838117-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
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
don't force containers to continually re-download images. We also move
ccache to use this shared area.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>

---
v3
  - mention ccache
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
2.47.2


