Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A95C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 17:55:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEBsM-00070I-5s; Mon, 03 Jun 2024 13:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sEBsF-0006xi-9c
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 13:53:35 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sEBsB-00007W-BE
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 13:53:34 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42148c0cb1aso398555e9.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 10:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717437209; x=1718042009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KTRxmIL3SU4VJlyA1cjmobcLWnY2X/3wy5s8zKTtyRs=;
 b=Djxo5p07V/RP9FaGN9sPYETE6hM8YZuPHGM6GTzYNEUs6O9zjStTiWs97iJ98Mlbgn
 UniNSGIJQgKuJOPLk6WmzHwjvEcyR0AGP/cyagUV/c/HViRJb6Y7r/SH46uBehOA1cQS
 YOKRwTcDlWGMlkwnzEAyIWsQsxa0NnY4uwlvIWIS5mqjzlkwrbeRCh7AxXcenPeIuUFD
 OjMfNHbMMCp2y5GiRWd4RxcDZ3wohRodIhYRbpvHDtzl29pOts5SL/SYaVFhoLgty9Xq
 4xYs8K4p2snwPjJIfac6a2rUietWwIeRoT63iExnu5e85YC0NB38S/nqD7Pj73qmEFdd
 6ipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717437209; x=1718042009;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KTRxmIL3SU4VJlyA1cjmobcLWnY2X/3wy5s8zKTtyRs=;
 b=QgIS3v3/LuP5cnqzOwRp/AwfRGLxN7oEFCdYK59ikyWpwrv1tqN9BKHbnxBwldJSbC
 Vt4O/b//Jhirb1znrEz9FT5ZhldQSZr4TZmXuIw3E43ZIULnD2vxBVK7BkHuuYrtgohb
 B6VUuc2eZbaBhYoY/JomgS0o2KyojFMXeU1GfHcuG3BsjJo9r3MtCjtUdkkff9X2WIcM
 pHz22xhnUPhnoFUGes+oQHm/8D/addYUQNbadLefgqu3553dp06/DyfcN8w4c5wTeoUi
 ZsJ+g9ewh67Wb0p5KcIh1bkaoonfoLQ1IWGG83Lk8a3xeOC7u5BYX5LYHhkkB5VkUL/L
 mfAw==
X-Gm-Message-State: AOJu0YwiMsDc1nGeXgYCQ1XxMAfqRHQojS2n2m+IrHt9aX+fsQRwxw7B
 3HBYf3R/XPklpfsajHaZv6e0PfG41mBhQ+NMhN9SJ6aJDW3UQ+CLxd9gncHTtok=
X-Google-Smtp-Source: AGHT+IE1/RfFneomKV/X3OI2WC2Jz9YmKZz1UvWCwKHY8cH5q9eQPILB5Rbs9Pz1wN6Y3n1euO5Zdw==
X-Received: by 2002:a05:600c:a4b:b0:41f:fb7b:bc53 with SMTP id
 5b1f17b1804b1-4212e066be2mr80254555e9.22.1717437209459; 
 Mon, 03 Jun 2024 10:53:29 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4213e75eef3sm34987555e9.6.2024.06.03.10.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 10:53:29 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 78DBA5F860;
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
Subject: [PATCH v3 00/12] testing/next: purging centos and more lcitool
 (pre-PR)
Date: Mon,  3 Jun 2024 18:53:16 +0100
Message-Id: <20240603175328.3823123-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

There are a few more bits referencing centos8 in the tree which needed
cleaning up. After this we can remove the dedicated runner from the
gitlab registration. If we want to keep a dedicated Centos runner then
we can add back the bits needed to set it up.

Due to some failures with the santizers on the latest Fedora I've
merged a few of Thomas's fixes and updates.

I plan to generate the PR on Wednesday.

Changes for v3:
  - added Thomas' clean-ups and disable function ptr sanitizer check
  - all lcitool bits merged in upstream now

Changes for v2:

  - I've completed the migration to drive the ansible pacakge lists from lcitool.
  - sbsa-ref test update from Marcin

The following patches need review:

  scripts/ci: drive ubuntu/build-environment.yml from lcitool
  tests/lcitool: generate package lists for ansible
  docs/ci: clean-up references for consistency
  scripts/ci: remove CentOS bits from common build-environment

Alex Bennée (8):
  ci: remove centos-steam-8 customer runner
  docs/devel: update references to centos to non-versioned container
  tests/vm: update centos.aarch64 image to 9
  tests/vm: remove plain centos image
  scripts/ci: remove CentOS bits from common build-environment
  docs/ci: clean-up references for consistency
  tests/lcitool: generate package lists for ansible
  scripts/ci: drive ubuntu/build-environment.yml from lcitool

Thomas Huth (4):
  tests/lcitool: Delete obsolete centos-stream-8.yml file
  .gitlab-ci.d/buildtest.yml: Use -fno-sanitize=function in the
    clang-system job
  tests/lcitool: Bump to latest libvirt-ci and update Fedora and Alpine
    version
  tests/lcitool: Install mingw-w64-tools for the Windows cross-builds

 docs/devel/ci-jobs.rst.inc                    |   7 -
 docs/devel/ci-runners.rst.inc                 |  13 +-
 docs/devel/testing.rst                        |   8 +-
 .gitlab-ci.d/buildtest.yml                    |   1 +
 .gitlab-ci.d/custom-runners.yml               |   1 -
 .../custom-runners/centos-stream-8-x86_64.yml |  24 --
 .../custom-runners/ubuntu-22.04-aarch32.yml   |   2 +-
 .../custom-runners/ubuntu-22.04-aarch64.yml   |   2 +-
 .../custom-runners/ubuntu-22.04-s390x.yml     |   2 +-
 .../org.centos/stream/8/build-environment.yml |  82 -----
 .../ci/org.centos/stream/8/x86_64/configure   | 198 ------------
 .../org.centos/stream/8/x86_64/test-avocado   |  65 ----
 scripts/ci/org.centos/stream/README           |  17 --
 scripts/ci/setup/build-environment.yml        | 284 ------------------
 scripts/ci/setup/ubuntu/build-environment.yml |  69 +++++
 .../ci/setup/ubuntu/ubuntu-2204-aarch64.yaml  | 127 ++++++++
 .../setup/ubuntu/ubuntu-2204-armhf-cross.yml  | 127 ++++++++
 .../ci/setup/ubuntu/ubuntu-2204-s390x.yaml    | 125 ++++++++
 tests/docker/dockerfiles/alpine.docker        |   4 +-
 .../dockerfiles/fedora-win64-cross.docker     |   6 +-
 tests/docker/dockerfiles/fedora.docker        |   5 +-
 tests/lcitool/libvirt-ci                      |   2 +-
 tests/lcitool/projects/qemu-win-installer.yml |   1 +
 tests/lcitool/projects/qemu.yml               |   1 +
 tests/lcitool/refresh                         |  22 +-
 tests/lcitool/targets/centos-stream-8.yml     |   3 -
 tests/vm/Makefile.include                     |   1 -
 tests/vm/centos                               |  51 ----
 tests/vm/centos.aarch64                       |  10 +-
 29 files changed, 497 insertions(+), 763 deletions(-)
 delete mode 100644 .gitlab-ci.d/custom-runners/centos-stream-8-x86_64.yml
 delete mode 100644 scripts/ci/org.centos/stream/8/build-environment.yml
 delete mode 100755 scripts/ci/org.centos/stream/8/x86_64/configure
 delete mode 100755 scripts/ci/org.centos/stream/8/x86_64/test-avocado
 delete mode 100644 scripts/ci/org.centos/stream/README
 delete mode 100644 scripts/ci/setup/build-environment.yml
 create mode 100644 scripts/ci/setup/ubuntu/build-environment.yml
 create mode 100644 scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
 create mode 100644 scripts/ci/setup/ubuntu/ubuntu-2204-armhf-cross.yml
 create mode 100644 scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml
 delete mode 100644 tests/lcitool/targets/centos-stream-8.yml
 delete mode 100755 tests/vm/centos

-- 
2.39.2


