Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF1CC02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 14:45:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1texdL-0003fG-4F; Mon, 03 Feb 2025 09:41:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1texdD-0003VH-Vj
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:41:00 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1texd8-0002MP-Md
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:40:59 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ab39f84cbf1so839225366b.3
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 06:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738593653; x=1739198453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gcYRZ4ZyzU/ziuzqrxT8ocayiAMfq9JGFe4w7hYy1hc=;
 b=D5WNUfCTK9Q7JGJuv919TFw6+1IYn3ysjcTzZUHVOd82kKT+r5VN64+XfWtyre+GMn
 XnNEwewwLowJ7XY209IgkRm7WagzcbLrcwbI7ptmxnsSTMIP+6JTPye1HV1b/AAZqdQZ
 laYxVQJdglF7Iu2sIrrBUD8yREbPJdVyPu7VD5mxtMdNwYbmLfORRz+KOXeR/JUQnvaS
 KwV80z8v+3gVxIOapidsSf40bi3ZBxSSnyu6zaArtG0yXv07R7thL1RScCUpwwV1n6KM
 1symBa8wNd+1jERPEOmFwj+9RFZTpMQwPcIrL8WYrnu6jXOHdRFY91mmJvyJ4r7GiqI7
 tI8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738593653; x=1739198453;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gcYRZ4ZyzU/ziuzqrxT8ocayiAMfq9JGFe4w7hYy1hc=;
 b=mubrfB2tyCJ70MvxdV4pBN4sUZx8nMOnjW3I7axQbVXN0CSuva/lLXWAaJPqj7AM2g
 gQQ372ZSUJr4MA3fmfgUUDXyS3/tEsBYUEcOTMcgsmPRNuvTd7ygNC9mIkMOM9NPq8Zq
 2XDpcvSuxXan7S8PCjX7t7+xptq24PlFljOBVRFwRwCnaWefPftShyWZc1kVKzj/uP2+
 y6dmv78GjmuawT4hbFTU9VD+Lu9MWZ1bCniMbPbkoiVQKRbyDwqG4WVajzwNkVIDGBYx
 y+CfcOPiwdSWL4LsMujz4VxJDqp5AgDHqx6Bb6tvI59IepyiAyIlFgE6OkBlMNb2zYTU
 cs8w==
X-Gm-Message-State: AOJu0YzB745VZva/SyEk6Yj9lfMuxKmrNKBBWXgvf4Hazk+u02Tszhbm
 p0I2l6CMbhibp8n4hdkh49kdSGW/31IqbruYfDUBo+8T3QL/cYcV74KF2IvHGAI=
X-Gm-Gg: ASbGncumsCsgdDmoC2Ny6uh215Q/ajSbvzoXrPdb7koiGyUlfL0+T6y+NZgkYfgkQ83
 z8LEtpj17Sxpmz3csfv/+XQx4DqqDXSfwvTAimOwPjUhs1zrl+3jTx2Fy+kJOsBDjBNXDwMrrT7
 0W43BLmkw3SwcgMXE8M7VWx7vCv0RquPaUBDXAmg6jsKinq9F3z1UH8QntUhjCCZ5dhWl08JdrW
 Y8xkoeLeOKrJAIfYJSW4RINQvonqECrsoCuyewAzKgJftKhTwAiQpoCuHmRrT35HaXd92F0XbpE
 kFnB70m4RKZI/esTYg==
X-Google-Smtp-Source: AGHT+IGMs1lB4i1YUHZmt1XdOzhLFa17C8lCZ94DCRBbDEkv7u4FH1xlbJA5atWuoKqtZ/yU29iFfw==
X-Received: by 2002:a17:907:3ea8:b0:ab3:8b1:12aa with SMTP id
 a640c23a62f3a-ab6cfcc5182mr2418938466b.8.1738593652739; 
 Mon, 03 Feb 2025 06:40:52 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6ff432351sm578507166b.68.2025.02.03.06.40.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 06:40:49 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8F12F5F8BF;
 Mon,  3 Feb 2025 14:40:48 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Hao Wu <wuhaotsh@google.com>, Peter Xu <peterx@redhat.com>,
 Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Kyle Evans <kevans@freebsd.org>,
 Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-rust@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-riscv@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Tyrone Ting <kfting@nuvoton.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 00/18] maintainer updates for feb25 (qtest, gdbstub, plugins)
Date: Mon,  3 Feb 2025 14:40:30 +0000
Message-Id: <20250203144048.2131117-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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

Another month and another set of updates from across my maintainer
trees. They include:

  * qtest set/step clock cleanups

It seems the earlier patch to avoid deadlock when shutting down was
overly broad. So in this series after a little clean-up to the qtest
reply code we tighten up some checks for steps that make no sense and
eventually revert the original deadlock avoiding patch.

  * reducing migration test scope depending on accel

Fabino's continued work on the migration tests and avoiding them
taking too much of the overall test execution time. KVM guests still
get the full range and we smoke test TCG guests.

  * gdbstub late attachment

These are Ilya's patches to make it easier to debug heavily
multi-process linux-user invocations. Comes with documentation and
a test case ;-)

  * plugins

Fix a compiler false positive.

As this is the first iteration I intend to send out a pre-PR later
this week if everything is reviewed ok with a PR shortly after.

Alex.

Alex Bennée (7):
  tests/docker: replicate the check-rust-tools-nightly CI job
  tests/qtest: don't attempt to clock_step while waiting for virtio ISR
  tests/qtest: don't step clock at start of npcm7xx periodic IRQ test
  tests/qtest: simplify qtest_process_inbuf
  tests/qtest: rename qtest_send_prefix and roll-up into qtest_send
  tests/qtest: tighten up the checks on clock_step
  Revert "util/timer: avoid deadlock when shutting down"

Fabiano Rosas (2):
  tests/qtest/migration: Add --full option
  tests/qtest/migration: Pick smoke tests

Ilya Leoshkevich (8):
  gdbstub: Allow the %d placeholder in the socket path
  gdbstub: Try unlinking the unix socket before binding
  user: Introduce user/signal.h
  user: Introduce host_interrupt_signal
  osdep: Introduce qemu_kill_thread()
  gdbstub: Allow late attachment
  docs/user: Document the %d placeholder and suspend=n QEMU_GDB features
  tests/tcg: Add late gdbstub attach test

Marc-André Lureau (1):
  plugins: fix -Werror=maybe-uninitialized false-positive

 MAINTAINERS                                |   1 +
 docs/user/main.rst                         |  16 ++-
 bsd-user/signal-common.h                   |   1 -
 include/qemu/osdep.h                       |   9 ++
 include/system/qtest.h                     |   1 -
 include/user/signal.h                      |  25 ++++
 linux-user/signal-common.h                 |   1 -
 tests/qtest/migration/framework.h          |   1 +
 bsd-user/main.c                            |   1 -
 bsd-user/signal.c                          |  13 ++
 contrib/plugins/cache.c                    |   2 +-
 gdbstub/user.c                             | 150 ++++++++++++++++-----
 hw/ppc/spapr_rtas.c                        |   1 -
 hw/riscv/riscv_hart.c                      |   1 -
 linux-user/main.c                          |   1 -
 linux-user/signal.c                        |  26 +++-
 linux-user/syscall.c                       |   1 +
 stubs/monitor-fd.c                         |   9 ++
 system/qtest.c                             |  59 +++-----
 tests/qtest/libqos/virtio-pci-modern.c     |   6 +-
 tests/qtest/libqos/virtio-pci.c            |   6 +-
 tests/qtest/migration-test.c               |  25 ++++
 tests/qtest/migration/compression-tests.c  |  15 ++-
 tests/qtest/migration/cpr-tests.c          |   6 +
 tests/qtest/migration/file-tests.c         |  19 ++-
 tests/qtest/migration/misc-tests.c         |  16 ++-
 tests/qtest/migration/postcopy-tests.c     |  14 +-
 tests/qtest/migration/precopy-tests.c      |  23 +++-
 tests/qtest/migration/tls-tests.c          |  14 +-
 tests/qtest/npcm7xx_timer-test.c           |   1 -
 tests/tcg/multiarch/late-attach.c          |  41 ++++++
 util/oslib-posix.c                         |  15 +++
 util/qemu-timer.c                          |  16 +--
 stubs/meson.build                          |   2 +
 tests/docker/Makefile.include              |   3 +
 tests/docker/test-rust                     |  21 +++
 tests/guest-debug/run-test.py              |  15 ++-
 tests/qtest/meson.build                    |  11 +-
 tests/tcg/multiarch/Makefile.target        |   9 +-
 tests/tcg/multiarch/gdbstub/late-attach.py |  28 ++++
 util/meson.build                           |   2 +
 41 files changed, 491 insertions(+), 136 deletions(-)
 create mode 100644 include/user/signal.h
 create mode 100644 stubs/monitor-fd.c
 create mode 100644 tests/tcg/multiarch/late-attach.c
 create mode 100755 tests/docker/test-rust
 create mode 100644 tests/tcg/multiarch/gdbstub/late-attach.py

-- 
2.39.5


