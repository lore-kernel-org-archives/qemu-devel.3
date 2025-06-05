Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4167DC61CE7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 16:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNDQh-0006yH-Cj; Thu, 05 Jun 2025 12:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNDQf-0006xj-GU
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 12:26:57 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNDQc-0007vX-Nt
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 12:26:57 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-addda47ebeaso240695266b.1
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 09:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749140812; x=1749745612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Enpaw/TOWx9LZ6jBQIu+TvwC3h63Ulsf0shXSFkVJbI=;
 b=CnwldyBBc/sWYkRgSz/StxA2A2Q2mSMHDqGDMkIFrNNm340QahWbcEvifILl0Pl17m
 zgc0s/v10azQLExNJ8VaABo94gh7EqYr+5ZzbxyKjUDNWvvq3v5ZYBtzwLAw15OGpZEL
 6jUiYQuxI92HGx/jrBmJe8xgwiRScSbzYQol44CJb8DIi8OTPAtFlrrZc5dJ6z57ocsO
 T2Fmmx/RCkGhWbRq8STuvwi/45vz/9U8GL2J3dXDYT6SeyIJzFnQn2iE5bSQ8/j55mIf
 LHhhy2SQqNCr6e9j6TrPXSy0RLbf7g7FGuxGnuVcvGgKi3XsZshMd32K8GF2ATmlCwoR
 YLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749140812; x=1749745612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Enpaw/TOWx9LZ6jBQIu+TvwC3h63Ulsf0shXSFkVJbI=;
 b=kTeY+aW1fUAIO+pgz/2lL4Krtb6gyluAuK7mB6D7/5qJZ7KbvznlMGccsXE1ngKQUF
 QnpR2Ec/ey+JpgtYCyT7BsHYPdwy8bhfGZGN2Pqyq9EJ1X/YWtZ5XwINUzuOwwij1SfY
 Qld3hTG35SV883QputmcAG5kozETwCTidUfVjY4nhaSruDEaU+GXnqX34DAY/zf0Qc+3
 EMcFWsorzkPvDqw5klv0S6PkeOzhHpmSed4Z3fBYRln1bnQp05oviBVDWmM0RxUA2cu/
 EXKqSPVKZxypPdsdLpZx8qNgn+y8ZEvkC6YZSAJE43sey5bKO9n2Hghzis+8hX3gEOOZ
 T7uA==
X-Gm-Message-State: AOJu0Yw9JaS+bWsYI17zp0sxfpO3aoWqHjtfholGiLgwXnYFrUh5kU9I
 PHKQ97RZR9fya4muzlp/sRF1ptnbVqhDVRgViJlQPczF+467fwekeb55El+Fxeci0rk=
X-Gm-Gg: ASbGncuaNLggMjRuJpljxhDuA+/OuIwkvPoWU9pB5OcRKr25qmmMZnmrwSlULtz9cfk
 3m25pNwpAhtz3lGZYBYO99WtHJrYG2zSPaW+rkUaw8m1Y259WMffu82t2PD+TuWA6zJu1UD+Ld5
 m82WOGDnyH8QdshhKSpGjOqY2GEEHOASZZYzrAUsFMJiHiXG93kA34jXWENKyNjU5QS3j8+8Jsh
 /YyuxNqsErTxsH/bv+kysnif3dTGzOOUo6jgOcaCKO4SxGi5KTviPjg4z8ctqtdun7a5hR0ftjM
 hZEyIOEA8a4Pa8m4l4Er0LmYZnnvOlfm2tQemrCQpGLNvaW+klg/
X-Google-Smtp-Source: AGHT+IEuKBSWa5YkUzNYLoont4lxPdwuQE/pAArwDeiG03B/wShr3Z68rOuemRGiUVmOrCL5e/QJzQ==
X-Received: by 2002:a17:907:9624:b0:ad2:1f65:8562 with SMTP id
 a640c23a62f3a-addf8cea96fmr729697466b.14.1749140812585; 
 Thu, 05 Jun 2025 09:26:52 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5dd043edsm1293770566b.96.2025.06.05.09.26.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 09:26:52 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 70CCF5F7F3;
 Thu, 05 Jun 2025 17:26:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/17] tests/docker: expose $HOME/.cache/qemu as docker volume
Date: Thu,  5 Jun 2025 17:26:34 +0100
Message-ID: <20250605162651.2614401-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250605162651.2614401-1-alex.bennee@linaro.org>
References: <20250605162651.2614401-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
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

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250603110204.838117-2-alex.bennee@linaro.org>

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


