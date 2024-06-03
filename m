Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C474C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 17:55:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEBsj-0007Fx-2L; Mon, 03 Jun 2024 13:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sEBsM-00071s-Hc
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 13:53:43 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sEBsH-0000AZ-OD
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 13:53:42 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4213870aafdso15695975e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 10:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717437216; x=1718042016; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AFaKUTfBSK0eVS/N0Uc1O+6+nD/libyZ4Mtl7cP6jYI=;
 b=ZbDQSmzQtzbfiZsrk+INYd3TcAf5+tdri73YD79dD6cOhXRZzI3yPYr+Fx4/SxWS7S
 VCLwjjDny2T4Dwn55/3WhXrFoYpUkvEY6YJ6EUSa8IV2fNAM58syjWzCgd2/02xDk7x3
 crMMm/zQ9YXMeeSaJjIzWO/di7iXVnlLxcN32/2sKQq5A2bpYWc9EerwjCIgghszP4b9
 hCy08R57lL0mBDyb6U6R8hbqoWK18a6kIe8EP7ikbFuS3AsKZd4NMFpijiaStIHh32NM
 bmIZ1iCsukwHVvOO0ubyxnk7L26WHO7hHHAA3lRd5mNXIzflN+u/bp/Q3quOYckcullU
 58+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717437216; x=1718042016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AFaKUTfBSK0eVS/N0Uc1O+6+nD/libyZ4Mtl7cP6jYI=;
 b=DO5BOOF6cB7YDBWJKi6Jb7aaUu88fmuk6UT8BVDoZUkYgODlMaDM442TVHXpTADdd8
 +Io0CSya2/MLi7g4sBorhDWkBFctpBconW6oX59JWAYR/IVubvt+o+q36suu1jQS6NTU
 cx5igNLBMpESNxNLKvNPXxBICXAQQwgs5Y2eMFu4QAo6txcSzsp1MXOb1904oIavAvOI
 PpG0jqoV9J/3WcElg0iYR2ylWJ/6JwVfiGvTUFIcFfdSEH9WIpedn5crIgxVja7hzaSS
 7//kCuSqdDf97CMsOcwXpSd6zRvamtVd5UlybDHUnJPprgZq9qIhVcUCvVz7560xqRNh
 YJ8A==
X-Gm-Message-State: AOJu0Yz2DQGVzitcAgzpR0lXX/daai+f7ZPgBEZmmAO+xM0A7CLD/xAE
 BEESdCX0lUeMdh0bUhzEsSYoa1ccmhFQH0rorrCBaDU5VNwhRkyDerseabl7W3s=
X-Google-Smtp-Source: AGHT+IGJ3d3VfeM+Is02YniLVEFdmHcxCkWqQZJ6ljo9qo6IZphHJypRuEp9FZJCkdKTwUQCkAMQcQ==
X-Received: by 2002:a05:600c:34d2:b0:420:177f:c2a6 with SMTP id
 5b1f17b1804b1-4212e049938mr98414825e9.10.1717437216208; 
 Mon, 03 Jun 2024 10:53:36 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212f05157esm113652885e9.20.2024.06.03.10.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 10:53:35 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 86CAA5FA06;
 Mon,  3 Jun 2024 18:53:29 +0100 (BST)
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
Subject: [PATCH v3 10/12] tests/lcitool: Install mingw-w64-tools for the
 Windows cross-builds
Date: Mon,  3 Jun 2024 18:53:26 +0100
Message-Id: <20240603175328.3823123-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240603175328.3823123-1-alex.bennee@linaro.org>
References: <20240603175328.3823123-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Thomas Huth <thuth@redhat.com>

Beside g++ we also need the mingw-w64-tools for properly building
the code in qga/vss-win32/ , so let's install that package now, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20240601070543.37786-5-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/fedora-win64-cross.docker | 1 +
 tests/lcitool/projects/qemu-win-installer.yml      | 1 +
 2 files changed, 2 insertions(+)

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


