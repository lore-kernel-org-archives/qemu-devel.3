Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E38CCD195
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 15:08:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9PWe-0002Dy-Eg; Thu, 16 Oct 2025 11:04:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v9PWc-0002DL-Pu
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:04:19 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v9PWN-0001A1-UE
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:04:17 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e34052bb7so9844035e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 08:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760627039; x=1761231839; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dNNcFWcqxb1X8X1fowx3mWVf0mKnSil0ppjSgKrWAv4=;
 b=xEOc5lRj40o47CNBf8/ODUA9aBN01rNMIehOWfW20IqurXIHGvkcvqZvs8UJYYmRlT
 1KY6/cjRbigvGsaigYHuJLMuIgogDsO3XP1YS/vdLD8EDig1FYpRhvUh0gYu3FCEWDTJ
 ks0dcRGuwdGeA4eyjt/W7NEyeE+Bqumu7Q5/3yxD/Lc78yhBKukaVr0hDHglU94hJ232
 wReDol9mbccqgwy7+Zq4ZVp/etEJZDO8Ry7gPTnMsfmcCy0G+0P5+E1c7RNPAzzLs43E
 zu9QcrhlEI9YGF+9xkfUq15we3AUG/XRKUm+Fvufsn9QnTZTloHalkKFN/LhV3Bp8Q7a
 bzKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760627039; x=1761231839;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dNNcFWcqxb1X8X1fowx3mWVf0mKnSil0ppjSgKrWAv4=;
 b=p1guENFXgwvPc/PL+1u6qnEr8wbfgaFEkQbsPGoWUjfN2TlYDIXfC0rB4jJbxg3RGW
 eUOMNmdGCNh60f7LgQKtHgU+Fw6m39fFU2J17zF4detL1wgoeIdIRYaIUCGOqYnwgPOY
 HV6GB3CU6xBZxqdt4THagsrPFZWUadJMICx8fMS7EOMsv28T2iOULiU0yBIuf0CEbFb3
 gR8hrBCTMnwqBl9HJEK/9L/z35sz5wgBPGkNsiWdQCcyzYpI3OStDWueoUSDT4VSj3VR
 Skp/KKASphMFXqDgN2Ucup9qYoYPRp/ZA2ovm8iUdF+/i/giSsKIIt53y5x2PkArylxR
 ee1w==
X-Gm-Message-State: AOJu0Yy48PV4mQeQ4Ci9zMqqitKoYM+SAMCMtbETJK2IOCqPfqpg2sCN
 xxxgEg4vRtOAsiMXAPxCTcleMY1ClduGHvKlCO+en4jAHIjgYMfBduC28VFTDW+Qflc=
X-Gm-Gg: ASbGncvcZB8fNkuFX4oS727rp4Jz1gQyc5kPCL3001/LNDh2o3U9mH34rOyDg3SsQ2a
 0xMCntPFpApTrjoRkqqNDp54q2QIqaZWNWfY40QTlW8+on40NYF1jpxTD9kt7C/EqZyRUzVX32H
 G112MdI0sxVlIOSwQRHcSGwyhVfVeQqn3awfnqQZnEM2d/6188zgpWBSxlrtq8act0brrrixnXe
 cjE6FU+jUTuuQCgHbYijkQ4q9XpEFXqzDCwm8wUlNQcSRwbOLcCbFpK1MCdSn4jPF3g+MximpmG
 aj3I2ChkpWTPljBlhpMNPX1IJgS98DKrQx+nmljTjQ3ovvjEXQaxQs5NcsH93JE6EF4MJ6mlBJq
 iWLYtVW3dnK2x/lZs1U7MPfDnGCe4fRCbxTlRjjEg+tuNoPeaDwuESYH4OXr27kMPoik7mkzwPp
 6bysz7NWAyIYW/eQ4=
X-Google-Smtp-Source: AGHT+IHqaO7k0AEkcy4zJWRYhvvJwpC6xwuCG3X6FtnFAiCUFHnuEaxWgDroiuYglf0fkn04R6vgow==
X-Received: by 2002:a5d:5f44:0:b0:426:d5ab:789 with SMTP id
 ffacd0b85a97d-42704dd6ae1mr351603f8f.53.1760627039038; 
 Thu, 16 Oct 2025 08:03:59 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4270539be85sm84184f8f.7.2025.10.16.08.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 08:03:58 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7602F5F80C;
 Thu, 16 Oct 2025 16:03:57 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH 00/11] maintainer updates for October (gitlab, gpu, plugins,
 docs) pre-PR
Date: Thu, 16 Oct 2025 16:03:45 +0100
Message-ID: <20251016150357.876415-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Softfreeze is only a few short weeks away so I want to flush out what
is ready from my various maintainer trees.

Most have already been reviewed from the various sub-trees but the
following could still do with a quick look over:

  hw/display: add blob map/unmap trace events
  gitlab: drop aarch32 runner and associated bits
  gitlab: use template for ubuntu-24.04-aarch64 jobs

Alex.

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
  contrib/plugins/uftrace_symbols.py: generate debug files to map
    symbols to source

 docs/system/device-emulation.rst              |  18 +-
 docs/system/devices/vfio-user.rst             |   2 +-
 docs/system/devices/vhost-user-input.rst      |  45 ----
 docs/system/devices/vhost-user-rng.rst        |  41 ----
 docs/system/devices/virtio/index.rst          |  29 +++
 .../devices/virtio/vhost-user-contrib.rst     |  87 +++++++
 .../devices/{ => virtio}/vhost-user.rst       |  22 +-
 .../devices/{ => virtio}/virtio-gpu.rst       |   4 +-
 .../devices/{ => virtio}/virtio-pmem.rst      |   6 +-
 .../devices/{ => virtio}/virtio-snd.rst       |   2 +-
 qapi/virtio.json                              |  10 +-
 hw/display/virtio-gpu-base.c                  |   9 +
 hw/display/virtio-gpu-virgl.c                 |   4 +
 tests/tcg/multiarch/linux/linux-test.c        |   9 +-
 ui/gtk-gl-area.c                              |  17 +-
 .gitlab-ci.d/custom-runners.yml               |   1 -
 .../custom-runners/ubuntu-24.04-aarch32.yml   |  25 --
 .../custom-runners/ubuntu-24.04-aarch64.yml   | 230 ++++++++----------
 contrib/plugins/uftrace_symbols.py            | 120 +++++----
 hw/display/trace-events                       |   2 +
 scripts/ci/setup/ubuntu/build-environment.yml |  17 --
 .../setup/ubuntu/ubuntu-2204-armhf-cross.yml  | 127 ----------
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


