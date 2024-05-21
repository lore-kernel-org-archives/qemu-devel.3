Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B1AFC25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 12:55:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9Ozg-0003CW-AT; Tue, 21 May 2024 08:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s9Oza-00031w-8E
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:53:22 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s9OzV-0005g9-Ll
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:53:21 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-574f7c0bab4so11269572a12.0
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 05:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716295996; x=1716900796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k+bJBrU/UvktmlKrRsArKDtPesIqm0X6BS1JPvuMDaY=;
 b=ZVrAEO+fgg1c83xGhUC+kNlTGzJIVbfMRFufyE9No0hG1JDpr+r/kvghLwIyQQLp/F
 9x8HFlOEC2osRX7tcl6GrJ16GLDeL7Iv0FKjLugS3XKccaYD6i5Om8WwLvFjOlg40XDr
 rHReSh0zcFKbgpzKjVyQp2OC8iWMncRySsvljWWyfzAfHXKb/J9O2vyIxAj+O9Op7zY+
 Lpqh1tyujEvoq0H1AgBEFzULaxwmebLg6/Jz5x/NafpWzc5FRUdUH9pqDW9Hf68ddRKF
 O0m7rwpxOiqJT8ybz7Lt7SP5KqpEGV5MJe1KqIh92ZYeWdCvAr8uvisP4uL9asFWpKsI
 E46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716295996; x=1716900796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k+bJBrU/UvktmlKrRsArKDtPesIqm0X6BS1JPvuMDaY=;
 b=Si8nrs+DsJMgYlZ9faUn0yzZBkBicXsy0Dq2VtkM+s+xc6sF1uiVSwquYXI5n0ohaX
 rXNmqNUvDPOae+sFjrJ3ViyNnMGEer45gO4DFcIzyoIPk6eglFG0Rp983pYtI6tWQM4F
 uVyeB1ChwdXksjr0DohoYV+Jkr4Xi2zzHvaaDx9uko2wCjykemdTPZ0WSv/XFwbKtbNo
 c8ofeZsAmViQAgDAqWz0BeJ7cmjJJWbI9/1cys3gP/+pBfWXPe+oqDkQd46vY8BkjQCj
 f591iGKE8d16gr8sStYmMMEcL7Q4Jeuizt3YEHVKqSnLHjIVABvRdTF9cbrKDJSuAGWU
 sQtQ==
X-Gm-Message-State: AOJu0Ywh92DHqgZK2KWwWVoUyeP4tENWiiPZMPjUQyppqRMtr8gF/jpg
 aM8+7PXkTnhhBcqpfuS3NwAqkt79eROn3o6EkXlVyE3J0/7VMMJGU9fvXkSzjnA=
X-Google-Smtp-Source: AGHT+IFPz2AqkMwHawZZUPMiYaNUNg0j1T4Mw/MBsR/HQSiW763tQQWJosTP3gIPRoRtXlKQyePIOA==
X-Received: by 2002:a17:906:6b85:b0:a5a:3e00:6317 with SMTP id
 a640c23a62f3a-a5d5fd58d23mr662951566b.31.1716295996176; 
 Tue, 21 May 2024 05:53:16 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a1781cd7asm1630614266b.10.2024.05.21.05.53.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 05:53:15 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EE37F5FA1A;
 Tue, 21 May 2024 13:53:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Beraldo Leal <bleal@redhat.com>, qemu-s390x@nongnu.org,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Joel Stanley <joel@jms.id.au>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Aurelien Jarno <aurelien@aurel32.net>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 2/4] docs/devel: update references to centos to later version
Date: Tue, 21 May 2024 13:53:12 +0100
Message-Id: <20240521125314.1255403-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240521125314.1255403-1-alex.bennee@linaro.org>
References: <20240521125314.1255403-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From the website:

"After May 31, 2024, CentOS Stream 8 will be archived and no further
updates will be provided."

We have updated a few bits but there are still references that need
fixing.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/devel/testing.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index fa28e3ecb2..c312465fa7 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -387,9 +387,9 @@ make target):
 
 .. code::
 
-  make docker-test-build@centos8
+  make docker-test-build@centos9
 
-This will create a container instance using the ``centos8`` image (the image
+This will create a container instance using the ``centos9`` image (the image
 is downloaded and initialized automatically), in which the ``test-build`` job
 is executed.
 
@@ -410,8 +410,8 @@ locally by using the ``NOCACHE`` build option:
 Images
 ~~~~~~
 
-Along with many other images, the ``centos8`` image is defined in a Dockerfile
-in ``tests/docker/dockerfiles/``, called ``centos8.docker``. ``make docker-help``
+Along with many other images, the ``centos9`` image is defined in a Dockerfile
+in ``tests/docker/dockerfiles/``, called ``centos9.docker``. ``make docker-help``
 command will list all the available images.
 
 A ``.pre`` script can be added beside the ``.docker`` file, which will be
-- 
2.39.2


