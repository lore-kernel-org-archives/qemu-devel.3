Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E14C25B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 16:13:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCLs0-0000Ox-Je; Wed, 29 May 2024 12:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sCLry-0000N6-Qx
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:09:42 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sCLru-0003H4-Rx
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:09:42 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a634e03339dso279867466b.3
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 09:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716998977; x=1717603777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nz2uRvqfqRWpF78icFLVRZPuUfMs6whhaS/0uUa4g9Q=;
 b=iN2/+8CuduFE/nl1HWR3FBA7EQTzaKai3k4bTjsQ+gh3a3rFwOdCOWpfD/1FpXdp9W
 /XBa7KxdKOYdQtM4J1aLoB2dh6pkWXNA3YIRB4T01gCsOBBG//o7n0eA6myQMCWmwkrv
 JSeHTFOdLKlh0vGZNDGz3pMaZsIWCvr4M8B2NGIIAnI9xDISBGzj42xC+kwTnBg6HMm4
 bbAQAc0dPiw+VonS7Q9bIWGxOY1c1Btc+dq8F6O+PMovuBeqRwHXyEXPeG75xbqGmQMl
 9MgZxnQic5+RoZcbvxGQDMeW6XAXfTpzZ8A+gWYg+qaS8eCPHc4IpcEqDgqTka0UyA1y
 4tDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716998977; x=1717603777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nz2uRvqfqRWpF78icFLVRZPuUfMs6whhaS/0uUa4g9Q=;
 b=YVYN3qFAg9sgRn/L9bMG2JeI3JTaoND57LgazqaJU0SuTg5T7C8oN+vTqZl/1Uhr0Y
 4zWYwue0vp7GXrXWduwKMSsM2BL+JOmEiXQ/6tuhP0P7dPKN90mQhzmz4sELV+eytDEQ
 uMtG45Jht8EjQr+xhLmPnoyggOfQba0A5KFxJwd0xJm+Byf9s8Bd3gjLks36H3RE8wFY
 CMtiHjHBXgUy2kDUdAkxZ2BSybdDQEneZZYmlG7EwrxzDkFbKOKyLghMLDfZxb1Spgh+
 /ZVQbsx0phi9IgxIWD7IxbXFSUt+nbPYk+rKfwf8tUjqMfoALoeOoz7LKduKW4URAy7y
 BFXw==
X-Gm-Message-State: AOJu0Yz9Gxx589CwQWTVRn1CGIVWdQ6oujpT42M2XAlauGrd5ZzDDoG0
 ZX0zKSxebXWfI9cGzz48U8c2dVZe/uRtOIvNHrsGLtR2w1YC2nj8ge2rBI0L9VI=
X-Google-Smtp-Source: AGHT+IGAnCxlQy0ULVV8Qyq+4kwYSwwXgopUkqhd/S73ixfJ9HQFAOTPo2BAQ7dweOFV0YibQpZASw==
X-Received: by 2002:a17:906:f158:b0:a65:4083:97d1 with SMTP id
 a640c23a62f3a-a654083a0f0mr136385866b.7.1716998976829; 
 Wed, 29 May 2024 09:09:36 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cc514e5sm734407366b.103.2024.05.29.09.09.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 09:09:35 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3A9655F8E3;
 Wed, 29 May 2024 17:09:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-arm@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 Radoslaw Biernacki <rad@semihalf.com>
Subject: [PATCH 02/10] docs/devel: update references to centos to
 non-versioned container
Date: Wed, 29 May 2024 17:09:26 +0100
Message-Id: <20240529160934.982373-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529160934.982373-1-alex.bennee@linaro.org>
References: <20240529160934.982373-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240521125314.1255403-3-alex.bennee@linaro.org>

---
v2
  - replaced centos with debian, tweaked commit message
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


