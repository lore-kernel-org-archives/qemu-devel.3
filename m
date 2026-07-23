Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE1DBC531CC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 20:10:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmzjK-000657-Pg; Thu, 23 Jul 2026 16:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wmzjH-000623-7b
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 16:09:15 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wmzjD-0006eU-BM
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 16:09:14 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-47f84023916so990250f8f.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 13:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784837348; x=1785442148; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nv8G7uF/vXKYkD7VAxJ3puA+WTb9xEykj6EMLdleuWo=;
 b=TQxGmei4Qa6uWwXLnBDjqzsgDTG1PAsqJf5SLEdfRmDnr2gNvcBB6M/etGqk5MW3LO
 P1LsUXRXma2oPNQQiKYcdLjYQ/6XKDMMSJdon54avmGggmukuvCZNiDrMD+c/YreNPpi
 fT93UGfoLtYwj/PjL/1rSdSz76MNYYN0Rj0wsrA5J/m7LwamqmmMxl5Dp4EhlaF43RNf
 b+6FHWqL567E2Fyo9iu26Rog+HcFUhPYZdVC+vKee47P2syAgjUMT+sVj0htWRjz1K9x
 H2Qn5A8V3td8RAPY+tHc1iRLjTnD1Z4O2vlG7z69MNHzerB0ckUlM1HlaHcTMiK8dqIw
 HNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784837348; x=1785442148;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nv8G7uF/vXKYkD7VAxJ3puA+WTb9xEykj6EMLdleuWo=;
 b=i+D8vbmhobhg4TclQmFRuMMfkF7KNff+gl+C04a1QgyzRqOXKJawwGSSEAJqCFjGca
 4VIeoNtblnuAO7ZDT0O1baCgCRw45WIXaDveCnpx9BLkaXbov7FJuvWdTMCYfBweOHiJ
 7EXfJnhCiIHRcjYOyTbNS8bgn6U1ep0PW48yRMEs48g9B/NF4EaonwhRa2qv1sGaowo/
 8c0mE5wvYuCHVHQX8Ee9QqOAvow+MgEeKrPoxekayviV+HgsZ8A8WkcVQhC0vDUHzS84
 nF2K6DR1CtngOZLTQHMWADbMrO2T3E0UbOsZPMUK1D4MtlRpg+BuNJtzZN1vbXiHnnAA
 +W9A==
X-Gm-Message-State: AOJu0YzLEio6DyKdyE7QJQL98TuDgxje8LQR3MixPp/okDJ9X1d8S3Qr
 dNuAphDngWXh+DFBmuGSvGlcORgxVIo8BopoPnH4FJuDoS+SFOwbewVQNr6zS4tCBOE=
X-Gm-Gg: AR+sD13KHL63xHg5WelLpq9EqC6yOOcTliFwLk7tOJKETEAYeEoQiCLiW1OjFkyzRVf
 5RjOqrSJp9cEusZGSyBUPV/ymlQHp88vwdi8oriOC1hJziiucTQeX95PngAeDxHGRQbiq46iGG3
 X4FjeYkSQ6lQYVGLwbssJcz/BO8ofpkE5OcYZCFDS+Q6hDFdeGe8qcZzp0t7MYtT3YEEabk0Zqg
 cXJGpwCFLopqjLxaOJnMssrVtGKu3sPrHn6PZGYRsPecLcoZDCGjXlsTItz0OzluZTzr5W7mbl4
 MLyOjJoOPCmLAPoovK/jjHZVDf4EtotUVbhXzJhrc9/KkM5VaTvRyccVKlLHY36dE1DTEb9dpD5
 Jr22i2zS+sG/s7ueHCFPI8O5sIdb8Jpgt71tqAYy40qlv1DHaU1KJRO7McPWmqbhoJShxCnf+uM
 gEeg==
X-Received: by 2002:a05:6000:2c07:b0:47f:7129:6e2d with SMTP id
 ffacd0b85a97d-47f8d71e0f7mr5775603f8f.17.1784837347483; 
 Thu, 23 Jul 2026 13:09:07 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c531afsm17740155f8f.24.2026.07.23.13.09.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 13:09:05 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E99075F8BE;
 Thu, 23 Jul 2026 21:09:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Warner Losh <imp@bsdimp.com>, Brad Smith <brad@comstyle.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <gaosong@loongson.cn>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kyle Evans <kevans@freebsd.org>
Subject: [PATCH 3/3] gitlab: add arm-softmmu tests to the macOS build
Date: Thu, 23 Jul 2026 21:09:04 +0100
Message-ID: <20260723200904.224413-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260723200904.224413-1-alex.bennee@linaro.org>
References: <20260723200904.224413-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Now we have fixed the compiler issues lets have at it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/macos.yml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.d/macos.yml b/.gitlab-ci.d/macos.yml
index bdb3eae18f0..40b9b637b3b 100644
--- a/.gitlab-ci.d/macos.yml
+++ b/.gitlab-ci.d/macos.yml
@@ -22,7 +22,7 @@
     - export PKG_CONFIG_PATH="$PKG_CONFIG_PATH"
     - brew update
     - brew install $PKGS
-    - brew install aarch64-elf-gcc i686-elf-gcc x86_64-elf-gcc
+    - brew install arm-none-eabi-gcc aarch64-elf-gcc i686-elf-gcc x86_64-elf-gcc
     - if test -n "$PYPI_PKGS" ; then PYLIB=$($PYTHON -c 'import sysconfig; print(sysconfig.get_path("stdlib"))'); rm -f $PYLIB/EXTERNALLY-MANAGED; $PIP3 install --break-system-packages $PYPI_PKGS ; fi
   script:
     - mkdir build
@@ -40,8 +40,9 @@ aarch64-macos-15-build:
     PATH_EXTRA: /opt/homebrew/gettext/bin
     PKG_CONFIG_PATH: /opt/homebrew/curl/lib/pkgconfig:/opt/homebrew/ncurses/lib/pkgconfig:/opt/homebrew/readline/lib/pkgconfig
     CONFIGURE_ARGS:
-        --target-list=aarch64-softmmu,i386-softmmu,x86_64-softmmu
+        --target-list=aarch64-softmmu,arm-softmmu,i386-softmmu,x86_64-softmmu
         --cross-prefix-aarch64=aarch64-elf-
+        --cross-prefix-arm=arm-none-eabi-
         --cross-prefix-i386=i686-elf-
         --cross-prefix-x86_64=x86_64-elf-
         --disable-plugins
-- 
2.47.3


