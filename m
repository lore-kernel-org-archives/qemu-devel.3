Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 028D7C52D7D
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 20:26:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdy3h-0005BE-Fs; Tue, 13 Aug 2024 16:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sdy3b-0004vs-57
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 16:23:52 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sdy3M-0006An-Lb
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 16:23:50 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-428141be2ddso44008985e9.2
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 13:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723580613; x=1724185413; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ri3Nj6KnAAwYce4sttu64DfuUubHB313LE/IKlWaOgg=;
 b=aeEU176dq4nhJKQTyjoAkDam/7Ylawm+ubG5pALrrGqOqvo7D+SfVes27PEJvSghsm
 /DdnJj0wITFC+TsRbSq293g3hCzg8qpTD8P+yhvbUyypiAIh6f9XGC2M6fP2+TewpUj8
 DGi6AGaPoMHbEIIc5S4XmNbXnDKtHFZSmRJpPrc8UjepXcnkEIyDQgvTux3P5gwO2inM
 avzlETjIQUok5CsFWY5u0/7eUwptxTn4rvLFdESMWsnZ/eXOE75Jr0H1c4SZKhxCl7Wp
 09xHIvBuupvdodwOS72T2VtOPPygxK9FOeb6TZVc05T4jDTshk4m25SJ7vryjpTnPaVi
 mKMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723580613; x=1724185413;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ri3Nj6KnAAwYce4sttu64DfuUubHB313LE/IKlWaOgg=;
 b=fhjhrtAcm2K5FEUWJcMqV9HleEP76s7HKT1ZjnthHAbfMF3c9GnkyGDot43waFworY
 shx149qwBQVrxDhXj9cTiNcIITeKWT2VYTo90NRmS4kr0UIYJEJb9thVpHJ6On1Yo7qf
 YM+jA96mKc1UUvhpZRMdoxMuW3eA+FATzogyyGbpWa8W84+EYkd2xaLEU3nj94BL/UcV
 Hw01lH65Xg/xDa2WqQcAobtXstCPCOtmCFQOROH09XkRldgOVryFIcEvo+hEt8MkCTGp
 mmeJ+horA2jtEDjHrUCOQ7esk4NVHcjoRqIKSB7GD3+hwveS66i4JCHa9pm3AuB0HWpz
 P/Rg==
X-Gm-Message-State: AOJu0YyePKVtbRk38nnfxWFrxMhJmfG4f4ZA1N5qosxGsNb6z4oL7Brs
 BGN+B8/SLPn4/SL5U5e9u7f2fqNwFYlMtZ5gQAVx+SvQzAb/0/FQ5Qgsnz4OxQU=
X-Google-Smtp-Source: AGHT+IFD8ANyBvg4OSR2ZhYQmfVP1TQ7DO4yNZiDq9xDn7AZHbSFs0ZxBh7mRmBN4sy1ikDi4bR0Aw==
X-Received: by 2002:adf:a21a:0:b0:360:9cf4:58ce with SMTP id
 ffacd0b85a97d-371778095eamr386414f8f.46.1723580612100; 
 Tue, 13 Aug 2024 13:23:32 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4cfee676sm11229207f8f.49.2024.08.13.13.23.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 13:23:30 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5F5195F7A3;
 Tue, 13 Aug 2024 21:23:29 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Michael Roth <michael.roth@amd.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Weiwei Li <liwei1518@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eric Auger <eric.auger@redhat.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Peter Xu <peterx@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Eric Blake <eblake@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-s390x@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 John Snow <jsnow@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-riscv@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH v2 00/21] Various fixes and tweaks for 9.1-rc2/3
Date: Tue, 13 Aug 2024 21:23:08 +0100
Message-Id: <20240813202329.1237572-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

As usual during soft freeze I switch to cleaning up the various
niggles and bugs which have accumulated over the years.

New for this iteration are some late breaking plugin updates, fixes
for record/replay and a few documentation updates. Everything is
reviewed so I will roll a pull request later this week.

Alex Bennée (2):
  Makefile: trigger re-configure on updated pythondeps
  target/i386: allow access_ptr to force slow path on failed probe

Gustavo Romero (3):
  configure: Fix arch detection for GDB_HAS_MTE
  configure: Avoid use of param. expansion when using gdb_version
  configure: Fix GDB version detection for GDB_HAS_MTE

Nicholas Piggin (10):
  scripts/replay-dump.py: Update to current rr record format
  scripts/replay-dump.py: rejig decoders in event number order
  tests/avocado: excercise scripts/replay-dump.py in replay tests
  replay: allow runstate shutdown->running when replaying trace
  Revert "replay: stop us hanging in rr_wait_io_event"
  tests/avocado: replay_kernel.py add x86-64 q35 machine test
  chardev: set record/replay on the base device of a muxed device
  virtio-net: Use replay_schedule_bh_event for bhs that affect machine
    state
  virtio-net: Use virtual time for RSC timers
  savevm: Fix load_snapshot error path crash

Philippe Mathieu-Daudé (2):
  tests/avocado: Re-enable gdbsim-r5f562n8 testing U-Boot
  buildsys: Fix building without plugins on Darwin

Pierrick Bouvier (2):
  docs/devel: update tcg-plugins page
  plugins: fix race condition with scoreboards

Stefan Weil (1):
  docs: Fix some typos (found by typos) and grammar issues

Stefano Garzarella (1):
  scripts/checkpatch: more checks on files imported from Linux

 docs/about/emulation.rst                  |  49 ++++++-
 docs/devel/migration/uadk-compression.rst |   4 +-
 docs/devel/tcg-plugins.rst                |  13 +-
 docs/interop/qemu-ga.rst                  |   2 +-
 docs/tools/qemu-vmsr-helper.rst           |   4 +-
 configure                                 |   8 +-
 Makefile                                  |   3 +-
 qapi/rocker.json                          |   4 +-
 include/exec/memory.h                     |   2 +-
 include/sysemu/replay.h                   |   5 -
 include/sysemu/runstate.h                 |   1 +
 accel/tcg/tcg-accel-ops-rr.c              |   2 +-
 chardev/char.c                            |  71 ++++++---
 hw/arm/smmu-common.c                      |   2 +-
 hw/net/virtio-net.c                       |  17 +--
 migration/savevm.c                        |   1 +
 plugins/core.c                            |  43 ++++--
 qga/main.c                                |   2 +-
 replay/replay.c                           |  23 +--
 system/runstate.c                         |  31 +++-
 target/i386/tcg/access.c                  |  27 ++--
 plugins/meson.build                       |  50 +++----
 scripts/checkpatch.pl                     |  24 ++++
 scripts/replay-dump.py                    | 167 +++++++++++++++-------
 tests/avocado/machine_rx_gdbsim.py        |   2 -
 tests/avocado/replay_kernel.py            |  31 +++-
 tests/avocado/replay_linux.py             |  10 ++
 27 files changed, 406 insertions(+), 192 deletions(-)

-- 
2.39.2


