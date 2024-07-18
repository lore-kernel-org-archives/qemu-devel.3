Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384D6C3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 09:46:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUNhc-0003Ct-2q; Thu, 18 Jul 2024 05:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sUNha-00037j-OB
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 05:45:30 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sUNhY-0007bU-Jb
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 05:45:30 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-52eeae38f6aso187790e87.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 02:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721295926; x=1721900726; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VCcCdQ4di4T2/A7zb/8TQdnfq5IolIO6f3nIRIyu+ok=;
 b=OZYydzstDeFCgYCDTAuwDqadtJ7IM5F7i8RWHRtxKEcv+bpZEV5h1m+WeEHA4tpzIE
 m54uuzCWnPFmkjiAOqQf8k3axnyjXrpmkqaGaNxXy29z5ni1d5qhYquKwBg5EdrDjCXf
 29VKAR2bpNpgJR0iTbUy7CXNasaVAkuZMfVF50oOtVr5QywrzyOBUIhtmN/JZP5vfSXF
 2Zq1EstFA4Mf3jX8MToorVSfcH7C3m0El5pyyXj4eFwq0UHu18XKxktYqpDn7YA29eeu
 FejIyad4zTlcFi/I6EeZiLz82Zh2GOtyexKg0N+wjOgPtCe0suJLS7lPHHvAUa/vadAH
 AOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721295926; x=1721900726;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VCcCdQ4di4T2/A7zb/8TQdnfq5IolIO6f3nIRIyu+ok=;
 b=oV2UfzlJPHijIjraC746e8eiDlIgWm3718/+iGx+XCPmTcHoCeiukFmws6YMZeF6E1
 jCLu8kwqP9OM+ZgQ1tDbiAR/WHEnU3twYNhPfyB6/NakxdoTrKABkEo/5U1WIwwGAxTP
 2+nqHIq6aV4Bw169dBafvqSA18W6FapqAIO487H0wkpiTSuk9Pi/bh2HvIGJTp2BcZpx
 GP9ZnxuRQZEwTno9Xo51/FFusDG4yceWiGvIkv0DCuhhaPOQ60GMlsvWo6ZnHDlNvL4k
 L2KmyBvYp9CnZAfPRDPjQu4rH1syIrdVRtEz7ZuTz3j1teJisQPaOzzZBp2GIICmDKJd
 aLYQ==
X-Gm-Message-State: AOJu0YzoUN0kxLJbruqd0//XlHgglXM21UjWrGhAu7agEKZc4fHUdujz
 ykXQ8dQhoCY1FiOkWtJV/lNN9ry8O8OlakhFDqN++ZqO2SYOd4/eUVT9PTTSVRk=
X-Google-Smtp-Source: AGHT+IEZI5/ptCMtWnju0G4wF7V+k1fdGZWu8PsWsZqYpshInK0v8RdrO5S06QRXKMzxe+3qTZoeWA==
X-Received: by 2002:a05:6512:3056:b0:52c:8024:1db with SMTP id
 2adb3069b0e04-52ee544c90amr2837327e87.63.1721295925873; 
 Thu, 18 Jul 2024 02:45:25 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc5b7ebfsm534274966b.67.2024.07.18.02.45.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 02:45:24 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EDBC25F762;
 Thu, 18 Jul 2024 10:45:23 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Thomas Huth <thuth@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Bin Meng <bmeng.cn@gmail.com>, qemu-riscv@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Beraldo Leal <bleal@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Ed Maste <emaste@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 00/15] Final bits for 9.1-rc0 (docker, plugins, gdbstub,
 semihosting)
Date: Thu, 18 Jul 2024 10:45:08 +0100
Message-Id: <20240718094523.1198645-1-alex.bennee@linaro.org>
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

I'm just flushing my various maintainer queues for the up-coming 9.1
soft freeze. Mostly this is a collection of fixes and tweaks although
there is a new plugin in contrib. We've also bumped the libvirt-ci for
the BSD python updates.

The following still need review:

  tests/plugins: use qemu_plugin_outs for inline stats
  testing: bump to latest libvirt-ci

Alex Bennée (3):
  testing: bump to latest libvirt-ci
  gdbstub: Re-factor gdb command extensions
  tests/plugins: use qemu_plugin_outs for inline stats

Frédéric Pétrot (1):
  plugins/execlog.c: correct dump of registers values

Philippe Mathieu-Daudé (8):
  semihosting: Include missing 'gdbstub/syscalls.h' header
  target/m68k: Add semihosting stub
  target/mips: Add semihosting stub
  target/m68k: Restrict semihosting to TCG
  target/mips: Restrict semihosting to TCG
  target/riscv: Restrict semihosting to TCG
  target/xtensa: Restrict semihosting to TCG
  semihosting: Restrict to TCG

Pierrick Bouvier (1):
  plugins: fix mem callback array size

Simon Hamelin (1):
  plugins/stoptrigger: TCG plugin to stop execution under conditions

Thomas Huth (1):
  tests/avocado: Remove non-working sparc leon3 test

 MAINTAINERS                               |   1 -
 docs/devel/tcg-plugins.rst                |  22 ++++
 include/gdbstub/commands.h                |  19 ++-
 include/semihosting/syscalls.h            |   2 +
 target/arm/internals.h                    |   4 +-
 accel/tcg/plugin-gen.c                    |   3 +-
 contrib/plugins/execlog.c                 |   2 +-
 contrib/plugins/stoptrigger.c             | 151 ++++++++++++++++++++++
 gdbstub/gdbstub.c                         | 142 +++++++++++---------
 target/arm/gdbstub.c                      |  16 +--
 target/arm/gdbstub64.c                    |  11 +-
 target/m68k/semihosting-stub.c            |  15 +++
 target/mips/tcg/sysemu/semihosting-stub.c |  15 +++
 tests/plugin/inline.c                     |  58 +++++----
 .gitlab-ci.d/cirrus/freebsd-13.vars       |   2 +-
 contrib/plugins/Makefile                  |   1 +
 semihosting/Kconfig                       |   1 +
 target/m68k/Kconfig                       |   2 +-
 target/m68k/meson.build                   |   5 +-
 target/mips/Kconfig                       |   2 +-
 target/mips/tcg/sysemu/meson.build        |   6 +-
 target/riscv/Kconfig                      |   4 +-
 target/xtensa/Kconfig                     |   2 +-
 tests/avocado/machine_sparc_leon3.py      |  37 ------
 tests/lcitool/libvirt-ci                  |   2 +-
 tests/vm/generated/freebsd.json           |  14 +-
 26 files changed, 370 insertions(+), 169 deletions(-)
 create mode 100644 contrib/plugins/stoptrigger.c
 create mode 100644 target/m68k/semihosting-stub.c
 create mode 100644 target/mips/tcg/sysemu/semihosting-stub.c
 delete mode 100644 tests/avocado/machine_sparc_leon3.py

-- 
2.39.2


