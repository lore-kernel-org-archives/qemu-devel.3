Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8554CC25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 17:54:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEBsH-0006yH-8p; Mon, 03 Jun 2024 13:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sEBsD-0006xN-HN
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 13:53:33 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sEBsB-00007b-9m
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 13:53:32 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-421208c97a2so40499485e9.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 10:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717437210; x=1718042010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dS1wHb51U0tVZQjhFJevCxPL30JQW4gCH0ItBvKNOkM=;
 b=QrB/TD6gQOy6azwGTZxmWEdyeb8G7WpjB1K1w5Nm35XPqIgMqmk3lgJKxhssUoi98S
 iW9rkQznFzpsNp+xnRmET85LoHqkOHFsJMcaxyWZuo9zlSJ7hnx6Foft1g0rQCkox3CR
 TrqK+Ctt5c/G1KblzavvMYtG3ak6BqsQYfgiMVMGxCKaqA48JpAbRWZ8xws4QeOYtEPg
 PtOQcq8r3mZg5rgkIT4wsvBBFVgO2UJ5jdJgsCUitIlJIaQnSsL86igZuTGpKbZyz3Tw
 wScL1q1cD0Ir+ZapwqGHlYgsF4Ctun+ucGBAV9eZH+yeB7jSOQP+tALSnwqxNewfb+Cr
 V5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717437210; x=1718042010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dS1wHb51U0tVZQjhFJevCxPL30JQW4gCH0ItBvKNOkM=;
 b=vdEvs70Vg0JPG1OawaeV2EGj5qD65Gpm9jCcdD5XRtoy12E0LDVItn+7I9LAJT8hpS
 s3q2yt5mCAxNM6alvcc8ZTOSMcf/u0F41lzn5iMNbcQYjotfgloBU1IyIBe6xuvbzBoe
 TrWoi0gur/x89FqFctjprekcSPlyeGcz012U2BEeTl3EOT1+LKdktqc0YB8SvsnQ/k9M
 VrF1LoyXkvCyJenMCsA+JRHL7bYeehYqBiOcgCckbHrxkRJNmC/KG4nWsTLSVlOQ7Kg0
 EwDSxGawzREUGqJ0+MHS2joFHE9N2PPpW0r7Pl1m5khHWYx+csvIlvNv73k5tG9bU82p
 1cWA==
X-Gm-Message-State: AOJu0YxtZOA04eWZmHUrOkyBGTnD9OovMrX/6J7EV9Pi59sC5FRlICeY
 xePtMP6YyY5fSwC3VOUn4MDv31Kp1HpjK2p8Ydr3hlztyXo8S+d6D4HMLuQUO1E=
X-Google-Smtp-Source: AGHT+IEtct6vC0Sy2O3e64G5sDT8x4gJXTdHmqUBCLpeMcQN/KKiSuc5wL/N43BCmAU1tbgvZigF7g==
X-Received: by 2002:a05:600c:4454:b0:421:c8a:424e with SMTP id
 5b1f17b1804b1-4212e04982fmr95839145e9.10.1717437209676; 
 Mon, 03 Jun 2024 10:53:29 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4213ab7ca26sm59434535e9.25.2024.06.03.10.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 10:53:29 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AAD925F8F7;
 Mon,  3 Jun 2024 18:53:28 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Leif Lindholm <quic_llindhol@quicinc.com>,
 qemu-s390x@nongnu.org, Beraldo Leal <bleal@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Radoslaw Biernacki <rad@semihalf.com>
Subject: [PATCH v3 02/12] docs/devel: update references to centos to
 non-versioned container
Date: Mon,  3 Jun 2024 18:53:18 +0100
Message-Id: <20240603175328.3823123-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240603175328.3823123-1-alex.bennee@linaro.org>
References: <20240603175328.3823123-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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
Message-Id: <20240521125314.1255403-3-alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240529160934.982373-3-alex.bennee@linaro.org>
---
 docs/devel/testing.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

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


