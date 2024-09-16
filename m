Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78064C3ABA2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 08:56:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sq7Ux-0008W4-12; Mon, 16 Sep 2024 04:54:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sq7Uu-0008VT-Mt
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 04:54:16 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sq7Uh-0005Bl-Tt
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 04:54:16 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-374c3eef39eso2514313f8f.0
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2024 01:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726476842; x=1727081642; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xkQtOkT0mjAWCNWbGOh+IDm1Jz0PRhLROXuJtsV3Xts=;
 b=oVgRYBHGUtM1IsfJJAm/RlQUn4Ky5+g1LRfSSlZmcMvQpRbS8WOvUfnkrmL7qmHDNz
 wRCBmzyV89oCTh0YrkpuiE+sS2Amp26F7G5ahATe/kD2o8PwijuvuZxB+Ajv70c0UrPb
 Vt62r/R1/MtaEA3mRYqeEO905dUPKq3t9qmzYIrmnH0W0mtbhlvBR83vjHx8BHtXy6p3
 CMS7eB994BGvdRkDm0ilVfot3jr2gcElxs9IPk1nvLmxOWoHRX0Hm62ynVXXshzb2Jra
 V/+8rZZWkXDvETcD0JTFOPEDdkzGHm6iQSpRs3nMUGh7VrQzBVc3OVPQFZZQUTuXMSjK
 c5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726476842; x=1727081642;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xkQtOkT0mjAWCNWbGOh+IDm1Jz0PRhLROXuJtsV3Xts=;
 b=cEGt4fpf3KYk/+TpU1DWUXS/CS4qYxGCMj0/UAU7Bk+xf0kenwjsLu0E+L/ZC9hANB
 IrRf+pUAaj+ZeY1j2z55UM7jSYZrowTkvSbfrPh4LNh0u5drRtJUtQrY4rdQ5JDZBMdN
 BrPP5zczByoeoR5dHJ/dE900C9u9mPu1c2Cl0KZjlgmtsHJWrFkaMhxcdkf5Jw0+AQeO
 BzcoZ0CiFs+slvtNSKejakYsXA1Hd3aqko3hqQIS/9gnuF5klcgr2WBwAYWBfIeLIWBN
 1vbD4FDfHannCo2CY1FbZhaQTskVQR5GwVRPeJBBCoXyZI+LGl2ztLAgeMzes6Qhd3QY
 yVBA==
X-Gm-Message-State: AOJu0YxMb+OlvbQCT5OAMZzbYA3kPr2caKTVNeZLA6ahgdP3YHfil4xO
 d8rutHZeTt2hiVrB+iIq/anFnZ2N6s8ycZbvrr0LHCYVXThaztQFretnji5XwFk=
X-Google-Smtp-Source: AGHT+IFLSJ+C7djOlxzmSs/LcXG8I7h8IsJ7q2bz7FsS7lw3aGogw+oFwvstYtwzeww+m8UYg8TGqQ==
X-Received: by 2002:adf:fcd2:0:b0:374:c8cc:1bb1 with SMTP id
 ffacd0b85a97d-378c2d51632mr8423847f8f.39.1726476841621; 
 Mon, 16 Sep 2024 01:54:01 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e73e862esm6678795f8f.45.2024.09.16.01.54.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 01:54:01 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 446C45F87D;
 Mon, 16 Sep 2024 09:54:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Eduardo Habkost <eduardo@habkost.net>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Nicholas Piggin <npiggin@gmail.com>,
 David Hildenbrand <david@redhat.com>, devel@lists.libvirt.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 00/18] tcg plugins pre-PR (deprecations, mem apis,
 contrib plugins)
Date: Mon, 16 Sep 2024 09:53:42 +0100
Message-Id: <20240916085400.1046925-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

I think all these are ready to go having been mostly reviewed in previous
series. The following still need review:

  util/timer: avoid deadlock when shutting down
  tests/tcg: add a system test to check memory instrumentation
  tests/tcg: ensure s390x-softmmu output redirected
  tests/tcg/multiarch: add test for plugin memory access (0 acks, 1 sobs, 1 tbs)

v2
  - fix some nits
  - included fix to ips posted as an RFC before

Alex.

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

 docs/about/deprecated.rst                     |  19 +
 docs/about/emulation.rst                      |  44 +-
 configure                                     |  32 +-
 accel/tcg/atomic_template.h                   |  66 ++-
 include/hw/core/cpu.h                         |   4 +
 include/qemu/plugin.h                         |   4 +
 include/qemu/qemu-plugin.h                    |  64 ++-
 contrib/plugins/bbv.c                         | 158 +++++++
 contrib/plugins/cflow.c                       | 384 ++++++++++++++++++
 contrib/plugins/ips.c                         |   5 +
 plugins/api.c                                 |  53 +++
 plugins/core.c                                |   6 +
 tcg/tcg-op-ldst.c                             |  66 ++-
 tests/tcg/multiarch/system/memory.c           | 123 ++++--
 tests/tcg/multiarch/test-plugin-mem-access.c  | 177 ++++++++
 tests/tcg/plugins/mem.c                       | 248 ++++++++++-
 tests/tcg/plugins/syscall.c                   | 117 ++++++
 util/qemu-timer.c                             |  14 +-
 accel/tcg/atomic_common.c.inc                 |  13 +-
 accel/tcg/ldst_common.c.inc                   |  38 +-
 contrib/plugins/Makefile                      |   2 +
 plugins/qemu-plugins.symbols                  |   2 +
 tests/tcg/Makefile.target                     |  12 +-
 tests/tcg/alpha/Makefile.softmmu-target       |   2 +-
 tests/tcg/alpha/Makefile.target               |   3 +
 tests/tcg/multiarch/Makefile.target           |  11 +
 tests/tcg/multiarch/check-plugin-output.sh    |  36 ++
 .../multiarch/system/Makefile.softmmu-target  |   6 +
 .../system/validate-memory-counts.py          | 129 ++++++
 tests/tcg/ppc64/Makefile.target               |   5 +
 tests/tcg/s390x/Makefile.softmmu-target       |   8 +-
 31 files changed, 1768 insertions(+), 83 deletions(-)
 create mode 100644 contrib/plugins/bbv.c
 create mode 100644 contrib/plugins/cflow.c
 create mode 100644 tests/tcg/multiarch/test-plugin-mem-access.c
 create mode 100755 tests/tcg/multiarch/check-plugin-output.sh
 create mode 100755 tests/tcg/multiarch/system/validate-memory-counts.py

-- 
2.39.5


