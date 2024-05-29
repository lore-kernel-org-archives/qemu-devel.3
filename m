Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC252C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 16:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCLs1-0000QJ-9K; Wed, 29 May 2024 12:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sCLs0-0000OB-2O
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:09:44 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sCLru-0003H1-S1
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:09:43 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-52388d9ca98so3525182e87.0
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 09:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716998977; x=1717603777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yR89rhD4yRRLjWWqfHJdmUlWY7/Liid4HiZzjPPatfg=;
 b=jn46mcPAtWguvT7CXFpL1SofMXskASeu1qZunEFsnoOM2UmIHIlSveBdFpCVWZ9ZDR
 1KUGkqZXxuDxT88S1XAXHSXMMLLCZ0TDsfNJhzaodEVKdxXoabPPSfaADie3u0XEme+B
 KCUeMznlRbvWQM+ZCT0pGpDJ/TNsoxRhf3sBHt2iRPeqZhIqYR7hO71OYei3+LFLWanX
 s0G1brpFnjl7BxDw9/vBgNrPurD+0JayuRszVHFmyguXbQNms5oFHsf7OQozNgzdRdJ1
 wW30/cTlnLxG6KhWpNwphxV2Jy3YG/RCvgSN6c2p2FlwlrXVJ5tx79DUo+atv0KKWPXH
 IL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716998977; x=1717603777;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yR89rhD4yRRLjWWqfHJdmUlWY7/Liid4HiZzjPPatfg=;
 b=IYmgYfvLu5Q9dRQrseyu0Gcblxm2xhAqkB4Dn9BdQpO8kOfBgEH/EioZ9E0h4VkyZo
 3X6DaEQ4DY6719Z1UuImNx4D4piyvA34kITLtWYoAPZCVL0kfSyKbQgwMmC9wkA0AmBI
 I/VXq9pJ5W/af3/0iB74mn3FAMDtzVzsP5VV8la4Rgdj9EDsGYKBaqoZxKeW32eAWAiB
 1EFjdlVYlVC7DQqg8AH9zuyVEdITMx6wVoVKYIW6TzOm9j9Pllo8VtQNvmvfgCt5qK65
 r6AKOCXW7n2n9O9wRQhTSn0Wwzb0FmbVagY831RJe7W561mEY2AqTDF/osMK59Q1kcm9
 yqIg==
X-Gm-Message-State: AOJu0YzB/ws3mmcW+50VXqNrGPYfWCSKMP0zDn6qTP1Sb/PjGP6rs/5C
 D4AU0gnOwlZb592zLIvdWKV4jR2sm56Pju/rO7WmVwSrCViWnNkMFgPMK7UMP/0=
X-Google-Smtp-Source: AGHT+IEEqOW/ANFoRRBC1EWnL5mueF1ly3iBxBr/G3wcN+SG/zGBP3S0W0USC8o41a9MgjvaJeldWQ==
X-Received: by 2002:ac2:5dc1:0:b0:522:8352:ff29 with SMTP id
 2adb3069b0e04-5296736bb86mr12581904e87.42.1716998976655; 
 Wed, 29 May 2024 09:09:36 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626c818362sm733011766b.34.2024.05.29.09.09.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 09:09:35 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 068515F760;
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
Subject: [PATCH 00/10] testing/next: purging centos and more lcitool
Date: Wed, 29 May 2024 17:09:24 +0100
Message-Id: <20240529160934.982373-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12a.google.com
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

I plan to generate the PR on Friday.

Changes for v2:

  - I've completed the migration to drive the ansible pacakge lists from lcitool.
  - sbsa-ref test update from Marcin

The following patches need review:

  scripts/ci: drive ubuntu/build-environment.yml from lcitool
  tests/lcitool: generate package lists for ansible
  tests/lci-tool: bump to latest version
  docs/ci: clean-up references for consistency
  scripts/ci: remove CentOS bits from common build-environment

Alex Bennée (9):
  ci: remove centos-steam-8 customer runner
  docs/devel: update references to centos to non-versioned container
  tests/vm: update centos.aarch64 image to 9
  tests/vm: remove plain centos image
  scripts/ci: remove CentOS bits from common build-environment
  docs/ci: clean-up references for consistency
  tests/lcitool: bump to latest version
  tests/lcitool: generate package lists for ansible
  scripts/ci: drive ubuntu/build-environment.yml from lcitool

Marcin Juszkiewicz (1):
  tests/avocado: update sbsa-ref firmware

 docs/devel/ci-jobs.rst.inc                    |   7 -
 docs/devel/ci-runners.rst.inc                 |  13 +-
 docs/devel/testing.rst                        |   8 +-
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
 .../ci/setup/ubuntu/ubuntu-2204-s390x.yaml    | 125 ++++++++
 tests/avocado/machine_aarch64_sbsaref.py      |  20 +-
 tests/docker/dockerfiles/alpine.docker        |   4 +-
 .../dockerfiles/fedora-win64-cross.docker     |   4 +-
 tests/docker/dockerfiles/fedora.docker        |   4 +-
 tests/lcitool/libvirt-ci                      |   2 +-
 tests/lcitool/refresh                         |  22 +-
 tests/lcitool/targets/centos-stream-8.yml     |   3 -
 tests/vm/Makefile.include                     |   1 -
 tests/vm/centos                               |  51 ----
 tests/vm/centos.aarch64                       |  10 +-
 26 files changed, 374 insertions(+), 773 deletions(-)
 delete mode 100644 .gitlab-ci.d/custom-runners/centos-stream-8-x86_64.yml
 delete mode 100644 scripts/ci/org.centos/stream/8/build-environment.yml
 delete mode 100755 scripts/ci/org.centos/stream/8/x86_64/configure
 delete mode 100755 scripts/ci/org.centos/stream/8/x86_64/test-avocado
 delete mode 100644 scripts/ci/org.centos/stream/README
 delete mode 100644 scripts/ci/setup/build-environment.yml
 create mode 100644 scripts/ci/setup/ubuntu/build-environment.yml
 create mode 100644 scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
 create mode 100644 scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml
 delete mode 100644 tests/lcitool/targets/centos-stream-8.yml
 delete mode 100755 tests/vm/centos

-- 
2.39.2


