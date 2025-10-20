Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB5C3CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 12:49:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vApJt-0008G5-7D; Mon, 20 Oct 2025 08:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vApJr-0008Fv-Eq
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 08:48:59 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vApJo-0002U9-Tq
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 08:48:59 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-63c0eb94ac3so7634890a12.2
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 05:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760964533; x=1761569333; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Pf27woCY/QbeJT6OsSE2E4mzSP9ULa6TcpqQcYjqjnE=;
 b=jwoR6S3om6SSuTpSsUHyRbMLw5TnAcTZDVjb0AjsIreDmAiyBATyTNM1aNHffOwO+J
 1Jnr4L8wK9sLc8vRh21xRT5sh1+kyG7XhlCfhLhNWT+GyxvR8YZMiZuHV0y8rynGaR4z
 ZIpo/KtLv7ejS0zq/IOFovLttj0NVgz3Swv3WkVNhByKDamv3YB4nO/T004L4YIknjib
 nn9cJYgo72vyGmBGy01vzjGtkUp8mVB4KxDcy17W0Lv2xVA33EY0QObzDH+t8QnIf6CU
 9S3jf2Wp4y0i0X59ysu/KJr9t8U6nzGnwL25rl2S/k4SLyehqSz7HP5E5oylEJhMq2XL
 XaLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760964533; x=1761569333;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pf27woCY/QbeJT6OsSE2E4mzSP9ULa6TcpqQcYjqjnE=;
 b=fYzs0QEFapOz/fbwnsbjMB7cEWDDG04c3wxxaQjUJwnOR8apN7PesAR+7YgL8ymZww
 D4VmupBcQo9xeBTmXTYyvsb+YULZUhaKPuddBWU9npk16J++kuS/56HazPSynr6c0zLi
 1Gx0g3Xc2dXOc/wXJhYZN0VzPPZ373va6KwQ/6f/tghDWlpcRfVYIDOSX6wYbG9sk3W8
 t7ZYna6wGx9PMLGbDBhjnzcPAlb8gGht13n4A1Kj9AMr4vHYp6fBmC6EJ9qDlyIOjrzs
 S7LjHVyKJS6+e8+9OIAAUe3EhWCMtaLNhJ+55SfGsmViyDqKAxqxXXcLcyZbR/zFn5dR
 tExA==
X-Gm-Message-State: AOJu0YxC43LsGBed2EUHjeMIMSN3EJtJMuxEGFJveWz1K+O9nypL050U
 /GR2rUvBRdA3uNI0ZzP8t000HiWzitG84Un2Poy9AfpeuH6PzUxV3iofaGkK7Srg0aP4yx9M3sF
 qeviTyLs=
X-Gm-Gg: ASbGncsl9fEftpmOBzEBx46QuDmeZ4dxBZ8cC/oUPBdHC6gxOCyigLKMNWZzdkJM1Rh
 oNGYcCL3uSee6t9PyPftlQQ2vr0p79WqZQGab3Cj7aMbzpmLcH1G3Fr/Nvo7VWDvpJkiYXVRUuk
 nwdlUSeRe1Vhk0R/9OelWrpG2Zt4W+/adHJ69nAlO4T+GoxQMSCBppcV2QjuSOHpi15RXp47vci
 U5qEMPIhHPMSDuR/XTYrKCjqvtUI1VDWOeAlMWqdBndpwh8cJQs9mAjgm35bNDP0OQkl1gC2TNZ
 7FdA0TVFTsHHOh7TSh07dKkuWbmXwkvVrDunkWHHjpHg4D3f237xM1tCEscq/CGsiXgN6ozHODu
 5zdpoeQpoodzy+eNVfLx6jU+BIJ99zGpn9GCzOXT9pckvQgg1y+886hjJo+crLpq0jZqh1kR7yM
 vbFsvuxN+xLAw=
X-Google-Smtp-Source: AGHT+IGgwa6OWpIG4sQNp26WMev2F2Bam+JOW4Zp/OgD44pGPrCQzja2u5mPSfv3Im/8wkqjasD5CQ==
X-Received: by 2002:a05:6402:34c5:b0:63b:f5cb:e1fa with SMTP id
 4fb4d7f45d1cf-63c1f64fd4emr12322104a12.11.1760964532601; 
 Mon, 20 Oct 2025 05:48:52 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63c48ab5553sm6673580a12.16.2025.10.20.05.48.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 05:48:51 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BE4675F83E;
 Mon, 20 Oct 2025 13:48:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL v2 00/10] maintainer updates (gitlab, check-tcg, virtio-gpu,
 plugins, docs)
Date: Mon, 20 Oct 2025 13:48:50 +0100
Message-ID: <20251020124850.4122520-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
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

  https://gitlab.com/stsquad/qemu.git tags/pull-10.2-maintainer-201025-2

for you to fetch changes up to faa29110b903fed29ba27bad3d0d8fcc7a8aa0fa:

  docs/system: merge vhost-user-input into vhost-user-contrib (2025-10-20 13:46:28 +0100)

----------------------------------------------------------------
maintainer updates (gitlab, check-tcg, virtio-gpu, plugins, docs)

  - drop aarch32 runner from custom runners
  - use template for aarch64 custom jobs
  - don't test for atime in linux-test
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
 20 files changed, 344 insertions(+), 464 deletions(-)
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


