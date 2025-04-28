Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCEACC369DC
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 13:00:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9O5O-0008Gy-Ml; Mon, 28 Apr 2025 08:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u9O50-0007sk-Ha
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 08:59:27 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u9O4x-00036L-3X
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 08:59:25 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5eb92df4fcbso9078194a12.0
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 05:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745845161; x=1746449961; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jhcZnu+Y1TIeUDuUOI6qKcuAJbQrXxQgcrFBlI5eh30=;
 b=ChkFS2oGlIUdvk3dcuGuoLxujrulNR87jXBJ74zIt859im84W+HZeTGepoQ1y9jO2r
 GmGShvg1ZQAxCcBm2bya0zHScW4f4ph6h4yqDxTIDvN/i87UnROuoLzm/PJN41oDBn48
 fGVqAy4XbJpU2ath7spafBAPlWdaMhK+baBgz30kQORlEFjuxX3CVfP6OH8eWg42+YrL
 hG3zQn8y5Ltx61z8SFnEU3hvRX6qwiAZyKAL2WT8cbyexaDH8tCtBMOME1xubZiyOaJ1
 OZRcaQDEdenGzby7LpiLDDx9U2f9rYHCV2i871WSVF1wSOx1NFjlQ7d6C8j/X8jdxNtY
 GmBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745845161; x=1746449961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jhcZnu+Y1TIeUDuUOI6qKcuAJbQrXxQgcrFBlI5eh30=;
 b=iaPP79/TczlrpWJomwwavMAX9cfHTtCRWzSwCeirLcusWu5LVpyz/KJQm0hGoJX5lQ
 O5yd+0y+FUlxMHPqJXNWcCptsQOVJkElwj/O5RG4UMPPnqVmdP6ljn9X11wCh4TFzYBi
 +4yTtBRLiHXr+KOJEta8QejihZQDbALbPw6ZQY5MnfMB1WuFQZlVqkhMgoxyUdzgxcF4
 gZ0pFYC29TPZMm29p5pFYLI+UtVQHBsOhQ5uGjhk5O+icV5rcT8t/0qbVG14RzShh5qP
 sg27OeZPZoEwO+w/M4T8KsxTx21R15q2CnlY9g0qeEN8+SmRvQZKcSzt45bs2fktrGdA
 KJIw==
X-Gm-Message-State: AOJu0Yz0w8TfRxgYmGcNQh0rRrSMWUEdysPiIQTiP5bvzp0YTlE2VUtU
 z25Wmk+wdMBYrF5I48wBQRE/8MFFvA9h9Jkpt7EBP7UOI0eMb+m4QWOeqnQ3JbY=
X-Gm-Gg: ASbGnctfUDz4NIZyKz/VhRveV3yb4yZF+II2MSem+k3t8q8ghjGvSM2pnskzHAPNQg9
 BkgMIiSRLdHezJ4atPqGf/dUXcuD5BZVfdAwh3rzgzG6j1+mWg3P+eIKWVMzr77a+jWLTpUebEu
 alWtEuuTzMGQHN00WoNbWvCBVYq2U1jJSwfNyLRHcXziS1e6K/S1egIY2G2JZdM4iUG4ihpRSXC
 aPJwrIaeRg7aDmiHTpCLA/AJSwPt+p7pQ3iHHAr8Ge3b2oSMrBwpYytILMS50bkQhOWoTbPrP2V
 1Fzac91a7aTtjdL+PedC1JcjokjgRgF1YIblNXrrj8/7wD4czwWc8g==
X-Google-Smtp-Source: AGHT+IHzwrW8Z6/xL77xr5HDqwIXyleV3+13Qsst/3fwmkro5hoQrL7uKBd9zbvHvdOS1HoFqzKkHw==
X-Received: by 2002:a17:907:9405:b0:ace:6bfb:4a12 with SMTP id
 a640c23a62f3a-ace848c2190mr861793366b.7.1745845160665; 
 Mon, 28 Apr 2025 05:59:20 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ace6e41bc62sm618677666b.25.2025.04.28.05.59.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 05:59:19 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 592E05F93C;
 Mon, 28 Apr 2025 13:59:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH 1/9] tests/docker: expose $HOME/.cache as docker volume
Date: Mon, 28 Apr 2025 13:59:10 +0100
Message-Id: <20250428125918.449346-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250428125918.449346-1-alex.bennee@linaro.org>
References: <20250428125918.449346-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
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

If you want to run functional tests we should share .cache so we don't
force containers to continually re-download images.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index fa1cbb6726..56a8d9f8ff 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -224,6 +224,7 @@ docker-run: docker-qemu-src
 			$(if $(NOUSER),,				\
 				-e CCACHE_DIR=/var/tmp/ccache 		\
 				-v $(DOCKER_CCACHE_DIR):/var/tmp/ccache:z \
+				-v $(HOME)/.cache:$(HOME)/.cache 	\
 			)						\
 			-v $$(readlink -e $(DOCKER_SRC_COPY)):/var/tmp/qemu:z$(COMMA)ro \
 			$(IMAGE) 					\
-- 
2.39.5


