Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 225DEC25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 11:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFBe2-0007lL-Ky; Thu, 06 Jun 2024 07:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sFBe0-0007ia-0V
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 07:51:00 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sFBdx-0000t5-C5
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 07:50:59 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-57864327f6eso129371a12.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 04:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717674656; x=1718279456; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XSZ7ULr5xoLbfL40YD36oC8M89gtEpNEdIvx4cfCWlA=;
 b=G9Hoqe1PdvRxEV9/1goDpbjmt1aYS7iD/LryuQ/Munvv2YwUyyc1vnlikY+NLgwLp7
 ly4VBEt6MbRpyu/EVzeIs4GWGfG5jPjZUrFSkxauWdvB+MqJ6U698uWwPvopjm0TU/bH
 SUw2Vv0thm7QYV5XyIJS344fCiQZRCt6zP+TkXGwVlynG2SIO3tIyFwmXbJSd1AxU/mM
 YAE+XAhNDhCxt1bgmYpdHFW6G+clmfL9eSh6QipQs00m4HcIcFTMEkqVeE27LUdXaXh5
 3Bj0Yb4BY8bavqI8237aB710q120odeDKTUX5pQi2Fv+F/LtOYVWBWACvOG6kyEU724e
 J6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717674656; x=1718279456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XSZ7ULr5xoLbfL40YD36oC8M89gtEpNEdIvx4cfCWlA=;
 b=Gr3JWJbYmmMi8I8bZnFLEwmcIKQdMrqWhY7IIOAo5pgYsSI0UTqbbgdEcBEIaehA68
 gn4vgbizYDwzggaXmxQyysberh4CP9+GlTzXyvEMf4UinOPZuJNo335jO5YZWT2UKAiv
 f3gh3madpb9NkUGTgoBxuBzbm8VcX7DiM6Ci9oZHtofrw52XJnsRgt6Z3uwYFofCzAO0
 1xgo6XfCXKcmjYWant/sRyPvJawul16wsudYvGZBAPdLsdGPibV9t1K7wc0MdbbvY/Ph
 UxS2YwfzM+sLpXuEvWW11QNcj7ZqeaXWtURjjAkZ6tvOlc2+A3TY/nsDFnAqZZ+Ruemq
 5u/Q==
X-Gm-Message-State: AOJu0YxJSGzS3tE50Ff7sVkXKFCZekyCdUkMlsptZpDINVOehomyL4aM
 AvThgEZ5q+Detzo/fCxS+hMGWQNvmNBZSvF/q+UTWOx7wuOf9xHr9dooRRACGF0=
X-Google-Smtp-Source: AGHT+IH5kK1yewRu+qfImBTjCDRoeB+UpGZwG7oJ/cYvrcwYM8z8Djb2dI9BF/Yzhh9qlUvOEzAwQA==
X-Received: by 2002:a50:9f86:0:b0:578:635d:67ba with SMTP id
 4fb4d7f45d1cf-57aa5595db7mr2357443a12.18.1717674655731; 
 Thu, 06 Jun 2024 04:50:55 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aadf9e093sm951449a12.13.2024.06.06.04.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 04:50:52 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D76885FA2D;
 Thu,  6 Jun 2024 12:50:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 10/12] tests/lcitool: Install mingw-w64-tools for the Windows
 cross-builds
Date: Thu,  6 Jun 2024 12:50:45 +0100
Message-Id: <20240606115047.421045-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240606115047.421045-1-alex.bennee@linaro.org>
References: <20240606115047.421045-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
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

From: Thomas Huth <thuth@redhat.com>

Beside g++ we also need the mingw-w64-tools for properly building
the code in qga/vss-win32/ , so let's install that package now, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20240601070543.37786-5-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240603175328.3823123-11-alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/fedora-win64-cross.docker b/tests/docker/dockerfiles/fedora-win64-cross.docker
index fef846d5a6..007e1574bd 100644
--- a/tests/docker/dockerfiles/fedora-win64-cross.docker
+++ b/tests/docker/dockerfiles/fedora-win64-cross.docker
@@ -75,6 +75,7 @@ ENV NINJA "/usr/bin/ninja"
 ENV PYTHON "/usr/bin/python3"
 
 RUN nosync dnf install -y \
+               mingw-w64-tools \
                mingw32-nsis \
                mingw64-SDL2 \
                mingw64-SDL2_image \
diff --git a/tests/lcitool/projects/qemu-win-installer.yml b/tests/lcitool/projects/qemu-win-installer.yml
index 86aa22297c..f3663ba030 100644
--- a/tests/lcitool/projects/qemu-win-installer.yml
+++ b/tests/lcitool/projects/qemu-win-installer.yml
@@ -2,3 +2,4 @@
 ---
 packages:
  - g++
+ - mingw-w64-tools
-- 
2.39.2


