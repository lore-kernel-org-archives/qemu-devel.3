Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE46CCD187
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 10:45:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8cWE-0005NF-LQ; Tue, 14 Oct 2025 06:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8cVQ-0004aU-65
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 06:43:49 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8cVF-0003Wx-4U
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 06:43:47 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-426edfffc66so529820f8f.1
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 03:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760438605; x=1761043405; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Jil0Ama1zoQrZnPdRDjlJAWkmuZcYK/+OGYeLjiDqe0=;
 b=p154IGX5rhIDLDWv+CwtHRzGTgar/5m/1tLfCuoJmj8NFStWaVRNbw1efoHQTwJ2bE
 jrhsmONqH/XjckqIrOuXGwkEa5CWZFIZHJfznLNKQg8SaaMvs4LEO2793uJ/redep2Cp
 L7MSiYbotGRgUcqGwsXx4Z4DdqkNykvPQhfhCFL3S+Qf8gxvrofjOfEeuAfWBIyVFpck
 vCYQV3YCboWDRaJWN5L2VSA7N+WtKB9S/x4PaE4MM3XxtecuyL2wOw6fMe0ewvk+3yln
 FyMKBZn6kssaxq325OiCHdzJZ14yLzGB3dys9/G5+Yvd0OjD8iChFlo3tbwGYoU5KO76
 5EZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760438605; x=1761043405;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jil0Ama1zoQrZnPdRDjlJAWkmuZcYK/+OGYeLjiDqe0=;
 b=iCwbDtL/M75qTMtVy8s1eqVV8Q5lhEJfkzylaYmE2T6Aec5OLF24+V5zdTbWuwPB92
 JVu4vhSdiFBZtaunD7KrLLsFVcs4l9ZYFgKeMWRIZ1BDtkQj11TnfKSpEFA8ivI5YrVG
 caaRS0lu/frGATJwYQzmR100Jd1txdbqe/YkqOMbZ2WiBEPbImG0UDIuAnnngoYDy3pd
 fGUuONafCOp8oP9BB5bkuaaeDDp1/o/UIOKD4BIfeHdB0wZHk5fxWplHRFolE3dUpihE
 UiqvUy9HLxEec+pJw9ZrVYzBTCeE13VddO6bAO6chzl143Shk7b2p2eQh900n4ISJ0Dx
 EmzQ==
X-Gm-Message-State: AOJu0YzWzaUFyXAzuW2x5CbpabNryd53JoPVlgL8Kk2mby5R333oISOq
 iQg6Ea6FydpNXVh15gdgOhVF+TnsEpQBs/Vy2CEeC84cDv0+WQZ0o9ps7QNhuCcvj94=
X-Gm-Gg: ASbGnctZzF85h9zLer3pc757Esh9XKEC0SYxx0AJKOz1C2oX8u/sGXmwYfJX3fdlF4n
 ZOj74GPe5n51r8dzfRMWgqUHdoe95exD1kqvtbZUlER/HZV8KPaG3nbbLWDU2pwkapF+PQDzZl2
 FpTscjjtKtYhI0/lS5Q6CnXCenAn/jSGojGa+JXoMJzCzk0jEkUiJLTSqJGOpc+BkoKB9ESJx4W
 aEgtHrx7dXCh9Pr5E5QE7LvITGIZsBIQrTkIfVOmTno3pUJaT+fF8qm3pY7DJL/DaKvHTBLoIiO
 Xh6vNofouWkBdJVW5ZQislE1ADjwdD2O0+ojOLZ3uVpXA7sWxchxhU0ItbazXFUYvGnZ0cL6Sao
 b+YvrZBbZ4wdiXrHByfTTzfA7X51pcbT5KyDi7qurfONMgStWWHYXcH2Y
X-Google-Smtp-Source: AGHT+IEapHYNwEsBeHKpfb8hNIa+UaI/5witG9DkXrRFY1Y8kMzrkmWlFHzupl/07WpZBNXGZEKkbQ==
X-Received: by 2002:a05:6000:40c8:b0:410:f600:c35e with SMTP id
 ffacd0b85a97d-425829b0561mr16342480f8f.8.1760438604816; 
 Tue, 14 Oct 2025 03:43:24 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583424sm22685054f8f.21.2025.10.14.03.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 03:43:24 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5264A5F812;
 Tue, 14 Oct 2025 11:43:23 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-s390x@nongnu.org
Subject: [PATCH 0/5] testing/next - arm custom runner tweaks
Date: Tue, 14 Oct 2025 11:43:17 +0100
Message-ID: <20251014104323.3023714-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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

This isn't quite ready yet as there is an in-flight MR for libvirt-ci
and the final patch has to manually drop a couple of packages which
don't cleanly install. I don't know if we should deal with that
upstream or in the lcitool metadata. For reference the two packages
are:

  libcurl4-gnutls-dev:armhf
  libglusterfs-dev:armhf

which I don't think are crucial to coverage. The main motivation was
to include the crypto libs so the block io tests don't fail.

However the the bulk of it works to:

  - improve utilisation of the new CI machines
  - remove hacks that get in the way of private test runners
  - fully drive ansible packages with lcitool
  - widen the testing of 32 bit Arm on the custom runner

Please review.

Alex.

Alex Bennée (5):
  tests/lcitool: bump to latest version and regenerate (!wait on
    upstream)
  gitlab: use template for ubuntu-24.04-aarch64 jobs
  gitlab: modernise the ubuntu24.04-aarch32 jobs
  scripts/setup: update the armhf overlay
  scripts/setup: update build-environment to use armhf yaml (!WIP)

 .../custom-runners/ubuntu-24.04-aarch32.yml   |  15 +-
 .../custom-runners/ubuntu-24.04-aarch64.yml   | 230 ++++++++----------
 scripts/ci/setup/ubuntu/build-environment.yml |  22 +-
 .../ci/setup/ubuntu/ubuntu-2404-aarch64.yaml  |   4 +-
 ...armhf-cross.yml => ubuntu-2404-armhf.yaml} |  67 +----
 .../ci/setup/ubuntu/ubuntu-2404-s390x.yaml    |   4 +-
 tests/docker/dockerfiles/alpine.docker        |  10 +-
 tests/docker/dockerfiles/centos9.docker       |  10 +-
 .../dockerfiles/debian-amd64-cross.docker     |  16 +-
 .../dockerfiles/debian-arm64-cross.docker     |  16 +-
 .../dockerfiles/debian-armhf-cross.docker     |  16 +-
 .../dockerfiles/debian-i686-cross.docker      |  16 +-
 .../dockerfiles/debian-mips64el-cross.docker  |  16 +-
 .../dockerfiles/debian-mipsel-cross.docker    |  16 +-
 .../dockerfiles/debian-ppc64el-cross.docker   |  16 +-
 .../dockerfiles/debian-riscv64-cross.docker   |  16 +-
 .../dockerfiles/debian-s390x-cross.docker     |  16 +-
 tests/docker/dockerfiles/debian.docker        |  10 +-
 .../dockerfiles/fedora-rust-nightly.docker    |  10 +-
 .../dockerfiles/fedora-win64-cross.docker     |  14 +-
 tests/docker/dockerfiles/fedora.docker        |  10 +-
 tests/docker/dockerfiles/opensuse-leap.docker |  10 +-
 tests/docker/dockerfiles/ubuntu2204.docker    |  10 +-
 tests/lcitool/libvirt-ci                      |   2 +-
 tests/lcitool/refresh                         |  11 +
 25 files changed, 259 insertions(+), 324 deletions(-)
 rename scripts/ci/setup/ubuntu/{ubuntu-2204-armhf-cross.yml => ubuntu-2404-armhf.yaml} (63%)

-- 
2.47.3


