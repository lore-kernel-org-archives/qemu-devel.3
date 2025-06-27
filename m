Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6781C7EE31
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 11:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV7DC-0005DZ-I8; Fri, 27 Jun 2025 07:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uV7Ct-00056A-P6
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 07:25:30 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uV7Cq-00078Z-Qy
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 07:25:23 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-453066fad06so12578435e9.2
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 04:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751023517; x=1751628317; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=T0Rp0sE1uEAGKm72kO0j4pZeSVakgo90rCJ0WNe2vbE=;
 b=ZF6O5tQLACfcEq2Tyb7hkeQsSd58QFSZPndauhdu452UmUUNAall5y73UeF0/5N10K
 MuuUsgWdGAw0JhNn/f02phwpSWvVbFOvZYW2ryx2ArBRyPhbcGOdApW06YJIlAzymS7x
 zV0nRt73vYM0FKhIByeJC5CdPgeWKwVqw1bXc5UIGVKXgV9roK3E+uWzUlBXOdnldkVD
 G8jPAfO4wv1uyZh0TI64X0osbVKhNLI57j/YdIfUbUKlIYK2oGfbawqt7Q2Hiny5FPQV
 rJWrPohSVjb/Bm1OB3TO/8hy9omu6pUdv6OB52tGlnCW4hIuxm4MV5jMuUPykU/6soWK
 aE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751023517; x=1751628317;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T0Rp0sE1uEAGKm72kO0j4pZeSVakgo90rCJ0WNe2vbE=;
 b=YNWFc1eTOUT/s1lwvM7tHkGKJCcKAoaDILLzsBkzMXBbN7LM7QVF01iGlEP6X12RAI
 Yag+b+VOU+yIcNl70p8yJbLK0L/QWOpp4A+sUD5FDBsxoDnBKD3BYyoSXIiQcKltV9L8
 m5Uz2BtQsO7109WEFaUZi2WTrkxSTvWVn9XVM7J5MMIAP8Oa2PITt3s+yOi/kABUH8i2
 Jizfacw1WugZjqy46WfdP0qgVGr3h68t+JRjfuNNKnMHuXR0ff/0Bor8yWbbR7HZimsV
 jQHMZ2kUT/q76qy/E90ryXKt9E/AqIYqpmgzxdKnAqtateGkO90W0yij0wGqaqRjcNOe
 ZHEw==
X-Gm-Message-State: AOJu0YxLPTW7S8xQ+pKVvo/4/yhUhkgCK6qeK0x4XRIFUeyNhKEFm3KL
 YVDDpzMAt3OdALu3kAeteBesLTAh80tdl10e1VcgO+DksFdjXt8vyBCctBRkRSb0nt8=
X-Gm-Gg: ASbGncsYyUQ/UZss63LkTHmGSZr+forDBm+6wo/hjDEk9vKlT795j1bvsWY0NUeuiJT
 IzyXH/ZkbPSBkuyKETFIcQkQLVbNmw+zteW9fuxwS59YN6wwlNZBxFTpYDQMe+qfNDsh8wl3RL/
 +6obpRqE+JB4aVLF3BuQubjTdznOP0Y6WXsyBzxPMjJQK1bDymnRzu8Tm07HwH7NRfesiQSxXHc
 2UpVbIoVBB3prRaf9MLAdIQTxaP5c1YOqsP8Z1dOie+mT8owtHS+Wg9Xi0ZNagPc+13L+xpRkOT
 etOzH0tPaJk9vveSY3qnI0XoxTQa3FYIwvPCvTpI7/Q9O5Ebz8kqBxGc0JqFILfrzUuyRtLjiw=
 =
X-Google-Smtp-Source: AGHT+IEj6ccMTq51dYmPMnWNWuCf/1eVEyzdnuR0LolKyxFGls/B/4HZrIANPQt7rKaeK88t2SUzuw==
X-Received: by 2002:a05:600c:1552:b0:442:e0f9:394d with SMTP id
 5b1f17b1804b1-4538f8836a6mr23478405e9.24.1751023517456; 
 Fri, 27 Jun 2025 04:25:17 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e62144sm2475188f8f.92.2025.06.27.04.25.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 04:25:13 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2F5A25F82D;
 Fri, 27 Jun 2025 12:25:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 qemu-s390x@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 00/15] Maintainer updates for June (tests, semihosting, plugins,
 gpu) pre-PR
Date: Fri, 27 Jun 2025 12:24:56 +0100
Message-ID: <20250627112512.1880708-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

Hi,

Here is the rolled up set of patches from my various maintainer trees.

From testing/next:

  - new pci hotplug tests

From semihosting/next

  - compile once updates

From plugins/next

  - register write support for plugins
  - memory read/write support (see caveats in APIs)

I've also been tracking the discontinuity changes but I don't know if
they will be ready by 10.1 softfreeze.

From virtio-gpu/next:

  - MAINTAINER updates
  - context init

I've left the other patches which try to untangle the various
memory race conditions until we have a clear path forward.

Only one patch needs review:

  gitlab: mark s390x-system to allow failures

I intend to send the PR in next week.

Alex.

Alex Bennée (3):
  gitlab: mark s390x-system to allow failures
  MAINTAINERS: add myself to virtio-gpu for Odd Fixes
  MAINTAINERS: add Akihiko and Dmitry as reviewers

Gustavo Romero (1):
  tests/functional: Add PCI hotplug test for aarch64

Philippe Mathieu-Daudé (2):
  semihosting/uaccess: Remove uses of target_ulong type
  semihosting/uaccess: Compile once

Rowan Hart (8):
  gdbstub: Expose gdb_write_register function to consumers of gdbstub
  plugins: Add register write API
  plugins: Add enforcement of QEMU_PLUGIN_CB flags in register R/W
    callbacks
  plugins: Add memory virtual address write API
  plugins: Add memory hardware address read/write API
  tests/tcg: Remove copy-pasted notes and from i386 and add x86_64
    system tests to tests
  plugins: Add patcher plugin and test
  plugins: Update plugin version and add notes

Yiwei Zhang (1):
  virtio-gpu: support context init multiple timeline

 MAINTAINERS                                   |  11 +-
 include/exec/gdbstub.h                        |  14 +
 include/hw/core/cpu.h                         |   1 +
 include/qemu/plugin.h                         |  15 ++
 include/qemu/qemu-plugin.h                    | 176 +++++++++++-
 include/semihosting/uaccess.h                 |  12 +-
 accel/tcg/plugin-gen.c                        |  30 +++
 gdbstub/gdbstub.c                             |   2 +-
 hw/display/virtio-gpu-virgl.c                 |  44 +++
 plugins/api.c                                 | 135 +++++++++-
 plugins/core.c                                |  33 +++
 semihosting/uaccess.c                         |  10 +-
 tests/tcg/plugins/patch.c                     | 251 ++++++++++++++++++
 tests/tcg/x86_64/system/patch-target.c        |  22 ++
 .../custom-runners/ubuntu-22.04-s390x.yml     |   2 +
 semihosting/meson.build                       |   5 +-
 tests/functional/meson.build                  |   1 +
 tests/functional/test_aarch64_hotplug_pci.py  |  71 +++++
 tests/tcg/Makefile.target                     |   7 +-
 tests/tcg/plugins/meson.build                 |   2 +-
 tests/tcg/x86_64/Makefile.softmmu-target      |  21 +-
 tests/tcg/x86_64/system/validate-patch.py     |  39 +++
 22 files changed, 862 insertions(+), 42 deletions(-)
 create mode 100644 tests/tcg/plugins/patch.c
 create mode 100644 tests/tcg/x86_64/system/patch-target.c
 create mode 100755 tests/functional/test_aarch64_hotplug_pci.py
 create mode 100755 tests/tcg/x86_64/system/validate-patch.py

-- 
2.47.2


