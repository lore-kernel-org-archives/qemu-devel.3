Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D03CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 10:42:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAnKw-0007Wh-57; Mon, 20 Oct 2025 06:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vAnKt-0007UO-Sj
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:41:55 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vAnKr-0000fl-Qj
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:41:55 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b5c18993b73so690485666b.0
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 03:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760956912; x=1761561712; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QjI1tf1SSK5JtEpNnx+nHv2CokSkFY5nLJW1sivoQOc=;
 b=RgKxj82zOJgNMNX3yPePcnptXrdeBpLQvigcLZFn1M7zJ3lmF7Hip12k5WemnUwjRA
 b0QQrgn5wHKzEHM9tvQwytiQooc06w7M5TCxPbDeU73Z/h10tlt4H7pUPUe87TcPVc5t
 a9JksHxFHKHns5zsZ/NNrloQXEa68kFl9k4/AJTMhNla/CMgUYedN7nqbL7egs1tTUGP
 Xr8cw4CMsQs129/dgQFftcGqwrZxHlyQH7gSeb89H2BFZA9g0SzZwe79ggfJtcT/rE2J
 lFtHAFW2isKvsh/VpUZB+9v/5Kw85abRrwjZUzmsH5Cx7EpCYP35ebhVMiITh0yT87SY
 F1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760956912; x=1761561712;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QjI1tf1SSK5JtEpNnx+nHv2CokSkFY5nLJW1sivoQOc=;
 b=SC9SxAT1HnU4YFKitSEOjpU5yi/dcTn36sPCf9JuN9PB/zbQsxgh8V/TPhvyQDK9kt
 eBzp6KG6vqZCnazNGQGoriQm+BZJP5e7gn2q6pHEmaejgqphk58dM+pwc+iaGjgq9x3s
 d7koyRyQ3RyL6f8IOhoV4MZAs32B4Od8aA5/HFbu1ilySNBbgz97DbWL1KeKoSciowoV
 x9YG16DQm0by4m9iONvc3zrYIuFJFpJy2fFXmxIjwtbKKl/49U2n8sfKuElI8WQr5jpt
 okcjHwiFkF02BO6PBgQIIPtpWR6LJEOXaMOHcKSzFMuVp9Kjg3jL0PP6usPaWQVOaJIv
 qLXQ==
X-Gm-Message-State: AOJu0YygrqmwPGBpNS8kR45Y8xoUF4FIML7m6q6q4x5xAsfTnZNlBVE+
 wOiAnDXWdqcMOZ3Z65nX7xSc6PQgl1jqXZWcXd5zmsK7mfWIGMGbzc/dmVB1jsftKrjWSqYxe6r
 Ne2MraZY=
X-Gm-Gg: ASbGncsmuA1l8NF/suxs+c7wqGoWetyVsL9I97kS+DyJvjXr3Kxkwjzma5bLGNNVpDN
 qeaFrhdLptyaWmamDEBjRcyb6nwBrBsp20iWVqNw4YWoI3mEF36mHzCmr2j+OlCc3Jr2jpeYO2M
 5vatZkrekkVNnTSdWT4PXVPkMEE3Ni0IlIQ/VHmRB96/dHj7HJUZq5xsKLbyPM/frQ4KTOhSbhD
 6md5PEl8VgIbVfkyYCiK7cKtYVwLBjRYFwl7hzcFzFiPgur7jSxX0DqD+72RHcHwfHuQUpoDqrU
 AhS3a5IOvEEYQJMtjik7MapptHTKzp63ebeBzTKBIHNtOqjqtxn10rSG8e5HUc6AqEcYiwXHHFE
 IOEZ6WCehDXcSj4cI9lpF2aFG1u+w7Ljh/SGnR5YGvxLMyEM7SkJDjABqj0L/vn05CSBnUCj7VH
 Fn
X-Google-Smtp-Source: AGHT+IH2E5QmxWO8mVuPZ0Art1QyIRvzVIp0iM7WfBnY/Z5oT1QIDlIhW5Os3YATR4fRnGM84555iA==
X-Received: by 2002:a17:907:3e8c:b0:b0a:aa7e:a191 with SMTP id
 a640c23a62f3a-b6475708eafmr1617336566b.57.1760956911768; 
 Mon, 20 Oct 2025 03:41:51 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63c4949beedsm6274074a12.40.2025.10.20.03.41.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 03:41:50 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 91D2C5F83E;
 Mon, 20 Oct 2025 11:41:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 00/11] maintainer updates (gitlab, check-tcg, virtio-gpu,
 plugins, docs)
Date: Mon, 20 Oct 2025 11:41:38 +0100
Message-ID: <20251020104149.4034124-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 3a2d5612a7422732b648b46d4b934e2e54622fd6:

  .gitlab-ci.d/buildtest.yml: Install 'file' for the Coverity job (2025-10-19 11:49:36 -0700)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-10.2-maintainer-201025-1

for you to fetch changes up to 2687249db27b4d23dfc69cb144015509ef72dc40:

  docs/system: merge vhost-user-input into vhost-user-contrib (2025-10-20 10:41:14 +0100)

----------------------------------------------------------------
maintainer updates (gitlab, check-tcg, virtio-gpu, plugins, docs)

  - drop aarch32 runner from custom runners
  - use template for aarch64 custom jobs
  - don't test for atime in linux-test
  - support per-head resolution for virtio-gpu
  - drop extra draw call causing corruption in gtk-gl-area
  - add trace event for blob map/unmap
  - extend ufrace_symbols to generate dbg files
  - group VirtIO devices in device documentation
  - merge vhost-user device docs into single file

----------------------------------------------------------------
Alex Bennée (7):
      gitlab: use template for ubuntu-24.04-aarch64 jobs
      gitlab: drop aarch32 runner and associated bits
      hw/display: add blob map/unmap trace events
      docs/system: split VirtIO devices from the rest
      docs/system: unify the naming style for VirtIO devices
      docs/system: drop vhost-user-rng docs
      docs/system: merge vhost-user-input into vhost-user-contrib

Andrew Keesler (1):
      Support per-head resolutions with virtio-gpu

Dongwon Kim (1):
      ui/gtk-gl-area: Remove extra draw call in refresh

Peter Maydell (1):
      tests/tcg/multiarch/linux/linux-test: Don't try to test atime update

Pierrick Bouvier (1):
      contrib/plugins/uftrace_symbols.py: generate debug files to map symbols to source

 docs/system/device-emulation.rst                   |  18 +-
 docs/system/devices/vfio-user.rst                  |   2 +-
 docs/system/devices/vhost-user-input.rst           |  45 ----
 docs/system/devices/vhost-user-rng.rst             |  41 ----
 docs/system/devices/virtio/index.rst               |  29 +++
 docs/system/devices/virtio/vhost-user-contrib.rst  |  87 ++++++++
 docs/system/devices/{ => virtio}/vhost-user.rst    |  22 +-
 docs/system/devices/{ => virtio}/virtio-gpu.rst    |   4 +-
 docs/system/devices/{ => virtio}/virtio-pmem.rst   |   6 +-
 docs/system/devices/{ => virtio}/virtio-snd.rst    |   2 +-
 qapi/virtio.json                                   |  10 +-
 hw/display/virtio-gpu-base.c                       |   9 +
 hw/display/virtio-gpu-virgl.c                      |   4 +
 tests/tcg/multiarch/linux/linux-test.c             |   9 +-
 ui/gtk-gl-area.c                                   |  17 +-
 .gitlab-ci.d/custom-runners.yml                    |   1 -
 .../custom-runners/ubuntu-24.04-aarch32.yml        |  25 ---
 .../custom-runners/ubuntu-24.04-aarch64.yml        | 230 +++++++++------------
 contrib/plugins/uftrace_symbols.py                 | 120 +++++++----
 hw/display/trace-events                            |   2 +
 scripts/ci/setup/ubuntu/build-environment.yml      |  17 --
 .../ci/setup/ubuntu/ubuntu-2204-armhf-cross.yml    | 127 ------------
 22 files changed, 361 insertions(+), 466 deletions(-)
 delete mode 100644 docs/system/devices/vhost-user-input.rst
 delete mode 100644 docs/system/devices/vhost-user-rng.rst
 create mode 100644 docs/system/devices/virtio/index.rst
 create mode 100644 docs/system/devices/virtio/vhost-user-contrib.rst
 rename docs/system/devices/{ => virtio}/vhost-user.rst (77%)
 rename docs/system/devices/{ => virtio}/virtio-gpu.rst (99%)
 rename docs/system/devices/{ => virtio}/virtio-pmem.rst (98%)
 rename docs/system/devices/{ => virtio}/virtio-snd.rst (99%)
 delete mode 100644 .gitlab-ci.d/custom-runners/ubuntu-24.04-aarch32.yml
 delete mode 100644 scripts/ci/setup/ubuntu/ubuntu-2204-armhf-cross.yml

-- 
2.47.3


