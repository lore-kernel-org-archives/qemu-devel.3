Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 381A5CDD55C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 21:08:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr1tR-0004tg-Lt; Wed, 18 Sep 2024 17:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sr1tO-0004ny-CI
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 17:07:18 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sr1tM-0001ZS-9O
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 17:07:18 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c260b19f71so162158a12.1
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 14:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726693634; x=1727298434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ks5/wrLiZwCRT9EDngSHy2v9fqTgGdlLApkRDdegi/Q=;
 b=U+W3o4yQGozhbQCVOWp1WKQb44vWx6ERTEqgfUh1ZdCVHaJpVXCrJ6sGjIbx5imCeY
 Mfvl2JbwUTpGTfkXzWkKPIzjqNYN/dcRsSyl/kCVwGMh4GPzn4ur05fQCqThu3zVkcBR
 +78awqMsPareAk4S2q0gXTHuzQiE31n61VNLSyMIRKxqbSDOe/p3BQwAJcpQ6aKSwzPd
 rNhU537O/dyDGzmNSzauK0QuuCYQPk+SiPxNWnIt25r77NVB/aI4uUuuc8xQmjyXrvnf
 XViu9qWxA0WELGtnoeavYiHX7qrmhSnl0J4+HuEujtxFobFjYvi14uspbZ/fuWxAkylj
 U6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726693634; x=1727298434;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ks5/wrLiZwCRT9EDngSHy2v9fqTgGdlLApkRDdegi/Q=;
 b=T5EerS7codvQhKfe4cxE6bing0hyAjfRO5GfJcyo0Q2es5CyLvDTJg3tyRS/jfavMT
 BYLmeiMcBK7pxwvC+Ck3qI0LJmzOlOAKrNl40Qv3axw4gevfuL2gbpyfyQ9GPcpRPRlY
 z78qd2OWv3cVAv92/Pa+NzOzBN79CSte4b2JwjLtiCqcG/8gZGbAledS4G1L59uZZSKM
 UzHCj8BnUQBxyAO8jtleypJ2OGJrIAbQAno7zUhesq8afDrckWfOHayD1r5d4wNXMSW5
 mRpH22t0iybZPkBt1dywXcPib50lXw6P25IvSr17yJNUVUuPOUHb+UmcWibnxEDqPNij
 S2GQ==
X-Gm-Message-State: AOJu0YwocH395rSQIpIaFxhOloUhCntczX92Ws5XhaGJxs7b2NX6fzIK
 Ui8ynBe2GDf3kvNb82BNqk1HF7WsYKagfDRKhJyakc1oq9sZOXwUTvhpcXZyVTbCCcQCyPy3xsA
 RU4I=
X-Google-Smtp-Source: AGHT+IETW8dasX3DUik6lXD0bB0CAixOXdqdSeBS6nJjJLQntgkbN+ngfZud00j/i7XlZVeH5/KLQw==
X-Received: by 2002:a17:907:f752:b0:a86:a481:248c with SMTP id
 a640c23a62f3a-a90294465abmr1990352466b.19.1726693633518; 
 Wed, 18 Sep 2024 14:07:13 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90c39cbceesm19098266b.132.2024.09.18.14.07.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 14:07:13 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3770E5F885;
 Wed, 18 Sep 2024 22:07:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 00/18] tcg plugins (deprecations, mem apis, contrib plugins)
Date: Wed, 18 Sep 2024 22:06:54 +0100
Message-Id: <20240918210712.2336854-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
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

The following changes since commit 2b81c046252fbfb375ad30632362fc16e6e22bd5:

  Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2024-09-17 14:02:18 +0100)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-tcg-plugin-memory-180924-2

for you to fetch changes up to a33f4871e0a0f4bf1cb037ab29fae7df7f2fc658:

  contrib/plugins: avoid hanging program (2024-09-18 21:02:36 +0100)

----------------------------------------------------------------
TCG plugin memory instrumentation updates

  - deprecate plugins on 32 bit hosts
  - deprecate plugins with TCI
  - extend memory API to save value
  - add check-tcg tests to exercise new memory API
  - fix timer deadlock with non-changing timer
  - add basic block vector plugin to contrib
  - add cflow plugin to contrib
  - extend syscall plugin to dump write memory
  - validate ips plugin arguments meet minimum slice value

----------------------------------------------------------------
Akihiko Odaki (1):
      contrib/plugins: Add a plugin to generate basic block vectors

Alex Bennée (9):
      deprecation: don't enable TCG plugins by default on 32 bit hosts
      deprecation: don't enable TCG plugins by default with TCI
      contrib/plugins: control flow plugin
      tests/tcg: clean up output of memory system test
      tests/tcg: only read/write 64 bit words on 64 bit systems
      tests/tcg: ensure s390x-softmmu output redirected
      tests/tcg: add a system test to check memory instrumentation
      util/timer: avoid deadlock when shutting down
      contrib/plugins: avoid hanging program

Pierrick Bouvier (6):
      plugins: save value during memory accesses
      plugins: extend API to get latest memory value accessed
      tests/tcg: add mechanism to run specific tests with plugins
      tests/tcg: allow to check output of plugins
      tests/tcg/plugins/mem: add option to print memory accesses
      tests/tcg/multiarch: add test for plugin memory access

Rowan Hart (2):
      plugins: add plugin API to read guest memory
      plugins: add option to dump write argument to syscall plugin

 docs/about/deprecated.rst                          |  19 +
 docs/about/emulation.rst                           |  44 ++-
 configure                                          |  32 +-
 accel/tcg/atomic_template.h                        |  66 +++-
 include/hw/core/cpu.h                              |   4 +
 include/qemu/plugin.h                              |   4 +
 include/qemu/qemu-plugin.h                         |  64 +++-
 contrib/plugins/bbv.c                              | 158 +++++++++
 contrib/plugins/cflow.c                            | 388 +++++++++++++++++++++
 contrib/plugins/ips.c                              |   6 +
 plugins/api.c                                      |  53 +++
 plugins/core.c                                     |   6 +
 tcg/tcg-op-ldst.c                                  |  66 +++-
 tests/tcg/multiarch/system/memory.c                | 123 ++++---
 tests/tcg/multiarch/test-plugin-mem-access.c       | 177 ++++++++++
 tests/tcg/plugins/mem.c                            | 250 ++++++++++++-
 tests/tcg/plugins/syscall.c                        | 117 +++++++
 util/qemu-timer.c                                  |  14 +-
 accel/tcg/atomic_common.c.inc                      |  13 +-
 accel/tcg/ldst_common.c.inc                        |  38 +-
 contrib/plugins/Makefile                           |   2 +
 plugins/qemu-plugins.symbols                       |   2 +
 tests/tcg/Makefile.target                          |  12 +-
 tests/tcg/alpha/Makefile.softmmu-target            |   2 +-
 tests/tcg/alpha/Makefile.target                    |   3 +
 tests/tcg/multiarch/Makefile.target                |  11 +
 tests/tcg/multiarch/check-plugin-output.sh         |  36 ++
 tests/tcg/multiarch/system/Makefile.softmmu-target |   6 +
 .../tcg/multiarch/system/validate-memory-counts.py | 130 +++++++
 tests/tcg/ppc64/Makefile.target                    |   5 +
 tests/tcg/s390x/Makefile.softmmu-target            |   8 +-
 31 files changed, 1776 insertions(+), 83 deletions(-)
 create mode 100644 contrib/plugins/bbv.c
 create mode 100644 contrib/plugins/cflow.c
 create mode 100644 tests/tcg/multiarch/test-plugin-mem-access.c
 create mode 100755 tests/tcg/multiarch/check-plugin-output.sh
 create mode 100755 tests/tcg/multiarch/system/validate-memory-counts.py

-- 
2.39.5


