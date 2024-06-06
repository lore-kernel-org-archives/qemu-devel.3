Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F9CAC27C54
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 11:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFBdw-0007fC-TR; Thu, 06 Jun 2024 07:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sFBdu-0007eV-GR
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 07:50:54 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sFBdr-0000s6-OB
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 07:50:54 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-52b8b638437so933728e87.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 04:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717674649; x=1718279449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sULh2Lp00FVZSOqTk/S9hH2fFR3kYyqs56rr8mBrl0s=;
 b=oZetOmDOntfrU6Dcc5o3q5Kv6wlxmSngumEcaXTjougnjyyZ+ODeWw8/1buNXLEiTh
 sDjAsAOQNpUeUqSYGUB7r9+iN/uPBlxTaSNGXk/PtQmgIv/NROtOCeNaOqPib6UqtBuf
 eE4NUMsXSZTuVPt1t39sI5q4skY13gcczntkL0ASPApYXuVXXkWSI2YliqhvJfHWWqFi
 389q1O16jfJgJIet7f6ft6NrczD6fwDsOrOMYHySCNkNQf1kXjeLAdPkpmydLDevtL4H
 dQaQ6iYw93HhajMJdHSu72ln8KPCC4YBNIG7xpm2QTNyBY2bhlpjTkXMe0vRJXT5UgaF
 vBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717674649; x=1718279449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sULh2Lp00FVZSOqTk/S9hH2fFR3kYyqs56rr8mBrl0s=;
 b=HIbj8sV8hHOpaNPJuDVbtwP2n+HnYGGfUVGJ7Bh4X8/BqLB73JAKxlP0UAwUSp8gsk
 0p77N8fZ7W6ZGlpFXtCmXVIzyL5sYTlBhdPs6A9SINYsQdD1cPphYur5moeJW6nN0uFT
 jLXCcJFoDSHS1/rywEWwMdH8W1XKSPUMPs6EjD7cuiaD5FDlSSwQsn7s+700E9Hg20a5
 sbYgqAk8izfTRdQ0iHcJrx4wnTvSwLVBwDu4dQslGgKGkV6PAJncXE9SrdCFbePmX/KJ
 cH+9PcVeQHSdXxOq1an2JBvYZRjpP9tg9AjiU1oG74SYTz2b3vMJwarQrQr5oWjK+ZTJ
 /rrw==
X-Gm-Message-State: AOJu0Yw1XuJVwRHTzoqhHoGME0kg0SVolZBU5KL+omLnYVnfGgyuNVpS
 gf2tS12hurt9F37qBkvqCDs8sBGAqHBygiXlAvM02kAcmf5ZnDTrQcWYW5oqR2c=
X-Google-Smtp-Source: AGHT+IE+ppdxdWn3D8KFrRB+sx1Lds36ECOLiHs/P5ITaO2sIrAjby7KR9nW+6MJ2YbznItJ0+EAlg==
X-Received: by 2002:ac2:551d:0:b0:52b:aa2f:d8a1 with SMTP id
 2adb3069b0e04-52bab4dd17emr2589986e87.20.1717674648825; 
 Thu, 06 Jun 2024 04:50:48 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c806ec8e4sm86566966b.113.2024.06.06.04.50.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 04:50:48 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1769A5FA1A;
 Thu,  6 Jun 2024 12:50:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 02/12] docs/devel: update references to centos to non-versioned
 container
Date: Thu,  6 Jun 2024 12:50:37 +0100
Message-Id: <20240606115047.421045-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240606115047.421045-1-alex.bennee@linaro.org>
References: <20240606115047.421045-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x130.google.com
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

>From the website:

"After May 31, 2024, CentOS Stream 8 will be archived and no further
updates will be provided."

We have updated a few bits but there are still references that need
fixing. Rather than bump I've replaced them with references to the
Debian image so we don't have to bump at the next update.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240603175328.3823123-3-alex.bennee@linaro.org>

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index fa28e3ecb2..23d3f44f52 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -387,9 +387,9 @@ make target):
 
 .. code::
 
-  make docker-test-build@centos8
+  make docker-test-build@debian
 
-This will create a container instance using the ``centos8`` image (the image
+This will create a container instance using the ``debian`` image (the image
 is downloaded and initialized automatically), in which the ``test-build`` job
 is executed.
 
@@ -410,8 +410,8 @@ locally by using the ``NOCACHE`` build option:
 Images
 ~~~~~~
 
-Along with many other images, the ``centos8`` image is defined in a Dockerfile
-in ``tests/docker/dockerfiles/``, called ``centos8.docker``. ``make docker-help``
+Along with many other images, the ``debian`` image is defined in a Dockerfile
+in ``tests/docker/dockerfiles/``, called ``debian.docker``. ``make docker-help``
 command will list all the available images.
 
 A ``.pre`` script can be added beside the ``.docker`` file, which will be
-- 
2.39.2


