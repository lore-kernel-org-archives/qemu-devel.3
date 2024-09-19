Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE841CF395D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 17:37:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srL51-0007aC-KC; Thu, 19 Sep 2024 13:36:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1srL4z-0007Yu-Ba
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 13:36:33 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1srL4x-0008Ix-6I
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 13:36:32 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5365a9574b6so1884311e87.1
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 10:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726767388; x=1727372188; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3AF48rdApHgyMQ46yOp36qgbGB9ZkdcNddz/1UO6ePo=;
 b=pHWrqQUxfsaAZJiH+Qm0mnZjaOOB2ADSrchW6Ch0Dfnqn3cusc2/NZF4TvO1rbFRiW
 MF7aNKpczeJu9JufAcaIB6EolT5EUBIQpszs4KgUTEYfFsHOPXUi6mtJCrFMqCOx9Pfv
 v6eGeYu6Mi3+viWLjZs7TdIH28gVyJ502Dz/aqDtX6BgzVEcmXoIfRPCv0txpMkplS5D
 xILJVkgSSBx5uob7dzLIc2bM0CoaczyLGpfLStAMRWL6RMgMMM1nUSUatI1H0xI8+2/u
 gALrtaVKRNK1ZnxnrEPmpWA79zuNuhMiqOcmSDLwOzle7vC4hxv1s/cvYbTBv76J4tRV
 3H4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726767388; x=1727372188;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3AF48rdApHgyMQ46yOp36qgbGB9ZkdcNddz/1UO6ePo=;
 b=lzpbpYRqMjbzILyMx4McqVDuZhWJau9FHZbfz+e2nIyU6pkxa0XX2SzOJ935CbTqeb
 JQvG5HdgZbO5iwU2PmFFRtuCWOGKVdxDrSEisI1KYcwhT8ErAA33FPfQcOFqIQ9i4own
 a36MoLnOOJEymbTd2k6n4xBmrpVPIhvuNp5QcTIVh6CLw5MGgYHwnJh3LlE0QcB1v4Hj
 mFpeW7jPOg3Lg9OkfIBZdt0rnZgfEjPaau6VATXUtruqC8Nb91hZHuf9jM5ojpzyFrSa
 M+2ojsHVShtdmH9zSIwzTskGvl+vx1APZiapPPoOaFP1UH9+qsUOVnimfpIfPW68m+U2
 dpdQ==
X-Gm-Message-State: AOJu0Yxmi8tHNMd5ZQfM3YAKuZReqySMNEBQIwwheV+lI0q+e13oEOqC
 kwC+aC7p3yArpIiyJfxybEkUwolb9xm6M/KSu5jtC5SKrXvwXZLtsO/Cf92ZVKM=
X-Google-Smtp-Source: AGHT+IE69RGGNctT1iruAsbiLuSnmJ8YpnIt/x2kix1IAfamVXAKfU+dhMNk1yXi4xVs3ky+JPo8Xw==
X-Received: by 2002:a05:6512:b01:b0:536:a7e0:131a with SMTP id
 2adb3069b0e04-536ac2f5334mr79239e87.26.1726767388159; 
 Thu, 19 Sep 2024 10:36:28 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612df750sm744187066b.160.2024.09.19.10.36.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 10:36:26 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A50A75F8A7;
 Thu, 19 Sep 2024 18:36:25 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL v2 00/18] tcg plugins (deprecations, mem apis, contrib plugins)
Date: Thu, 19 Sep 2024 18:36:25 +0100
Message-Id: <20240919173625.2859137-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x134.google.com
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

The following changes since commit 14556211bc6d7125a44d5b5df90caba019b0ec0e:

  Merge tag 'qemu-macppc-20240918' of https://github.com/mcayland/qemu into staging (2024-09-18 20:59:10 +0100)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-tcg-plugin-memory-190924-1

for you to fetch changes up to 8148fb56c753908fcc41d52846f9d8e6ae5f7daf:

  contrib/plugins: avoid hanging program (2024-09-19 15:58:01 +0100)

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
 tests/tcg/plugins/mem.c                            | 270 +++++++++++++-
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
 31 files changed, 1796 insertions(+), 83 deletions(-)
 create mode 100644 contrib/plugins/bbv.c
 create mode 100644 contrib/plugins/cflow.c
 create mode 100644 tests/tcg/multiarch/test-plugin-mem-access.c
 create mode 100755 tests/tcg/multiarch/check-plugin-output.sh
 create mode 100755 tests/tcg/multiarch/system/validate-memory-counts.py

-- 
2.39.5


