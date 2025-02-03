Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4492DC0218F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 03:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1temyi-0007wn-2F; Sun, 02 Feb 2025 22:18:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1temyg-0007wN-UW
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 22:18:26 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1temyf-0002dt-04
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 22:18:26 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2164b1f05caso61920435ad.3
 for <qemu-devel@nongnu.org>; Sun, 02 Feb 2025 19:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738552703; x=1739157503; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5cafx/ah9BLjqPoyOkGojrZFqdmAACc3Ieww0AHYWvk=;
 b=RHkqD3II5sg2Cc7VHZ/qfWlTm0ww5RPQin4tSLmn4TbMVqvQZbe4gPf5UaRiH8AyGb
 O7IXgF1G7Eb8fBHoaGc21iN4d5hVYQGempsAeCGW60VFFWtP+W+tTG+Txn1clHrwWti6
 oh80TsNu9PPAHNqx5xmwiwGno/PiwUZYfT7BWqPA5vI5zeCJIWEec1jSwiGqk0r4oxZt
 eP5VBciCi8qsgc21MJu17Pn4XUcWXDHSzKSxwfz2SqTurygysCDJxHEJoX8VvBywVKS7
 0n83kaRMBUSTecs4hbfPOC3kNy1EtPNEZTcFlgb1q2vOwL3AmuCbSW7tQiFfAfFPQnj1
 IH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738552703; x=1739157503;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5cafx/ah9BLjqPoyOkGojrZFqdmAACc3Ieww0AHYWvk=;
 b=uukoLu3COa7kKyWCDD8XNQ8qFoV19It0u6km9Vq6LqVPYAwvhmSwdwnKKjsAcdB/mj
 tSXym8FDE6KQ0J6lwmunNawG3MxDqiNEH0M33e+93Cg2rYML32xgHCq8objjz4wcMuAY
 0U+di/7qafRgWajd4Hnkft652UpNrz3VEh15fkZ+fWcvawQZ5A9OkNIRvRpxsipkbBiG
 1JYTT+k2sikFjmlqMmWsUybbqokWFo5eZQO31RRN7EJzB3yBw32NQfbvtQGpAGwpi3/8
 271J0IzMA45SpqiqGcir5WkBDMouV72mP7XTYzhzXnzZYES+sl3RanPzpbRAO4GmuOBK
 4ThA==
X-Gm-Message-State: AOJu0YzX9sxa7D/DuDX3lYcu8gJnTJ6q2x5dKHIc9UtYpcVFL0s0UMip
 s4oBdPV2iSz0U6NsZh5qZvgIHDUVV4Gd8scZSOZ8UbtZdoukzjyeV59LlyrJiB5jMXo5YY67mad
 K
X-Gm-Gg: ASbGncv1IV2fsOjRQg1Wpet0oNKgw+Srg9ss4RlwFWt4f9Z7sX49oZfZh7BvM81lZ/S
 FQuqBfmNV12BrXzMego309qWw/Pypn73AIpSTJle8Lehrx/XkZUtib5ArvbR8gVbMF9lWAPAW1V
 VxIVKL6hVtpr4sjgag7jvKF8YBA5kENzXXaPw1y7bQo+uX1SbfB74HVmFSgLUSQ1eBaGvI7pHbT
 u6vsYmpnCUfuIZDghqbxzJzw1mn9xAxp/lbNADPhGQP2q8DJmhxDcIlqDpou7f9aQbRzJA1BdJG
 SSgV28kRoeKyjjL4/Kh5BeUOhNAF03KmpSqv0TWswihVBXc=
X-Google-Smtp-Source: AGHT+IHHcyqMJaLU/rf4tVO+bnwqc6lSJYMPWIIGNQrd/nXcYaYnAHrTo2BocA3sG9wTTuNwT/kQfg==
X-Received: by 2002:a17:903:1cb:b0:21c:2f41:f4cd with SMTP id
 d9443c01a7336-21dd7dea7b3mr342701635ad.43.1738552703143; 
 Sun, 02 Feb 2025 19:18:23 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21de32eb419sm65698135ad.145.2025.02.02.19.18.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Feb 2025 19:18:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 philmd@linaro.org, thuth@redhat.com
Subject: [PATCH v2 00/14] meson: Deprecate 32-bit host support
Date: Sun,  2 Feb 2025 19:18:07 -0800
Message-ID: <20250203031821.741477-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

v1: 20250128004254.33442-1-richard.henderson@linaro.org

For v2, immediately disable 64-on-32 TCG.

I *suspect* that we should disable 64-on-32 for *all* accelerators.
The idea that an i686 binary on an x86_64 host may be used to spawn
an x86_64 guest via kvm is silly and a bit more than niche.
Similarly for mips32 spawning mips64 and ppc32 spawning ppc64.

But in the meantime, jump through a couple of hoops to keep these
kvm and xen cases building, while disabling tcg in the same binaries.


Richard Henderson (14):
  meson: Drop tcg as a module
  tcg: Move stubs in tcg/perf.h to tcg/perf-stubs.c
  plugins: Uninline qemu_plugin_add_opts
  meson: Introduce CONFIG_TCG_TARGET
  tcg: Link only when required in system mode
  plugins: Link only when required in system mode
  accel/stubs: Expand stubs for TCG
  target/mips: Protect objects with CONFIG_TCG
  gitlab: Replace aarch64 with arm in cross-i686-tci build
  configure: Define TARGET_LONG_BITS in configs/targets/*.mak
  target/*: Remove TARGET_LONG_BITS from cpu-param.h
  meson: Disallow 64-bit on 32-bit TCG emulation
  meson: Deprecate 32-bit host support
  tcg: Remove TCG_OVERSIZED_GUEST

 include/qemu/atomic.h                       | 18 ++------
 include/qemu/osdep.h                        |  7 +++
 include/qemu/plugin.h                       |  9 +---
 include/tcg/oversized-guest.h               | 23 ----------
 include/tcg/perf.h                          | 23 ----------
 target/alpha/cpu-param.h                    |  2 -
 target/arm/cpu-param.h                      |  2 -
 target/avr/cpu-param.h                      |  1 -
 target/hexagon/cpu-param.h                  |  1 -
 target/hppa/cpu-param.h                     |  2 -
 target/i386/cpu-param.h                     |  2 -
 target/loongarch/cpu-param.h                |  1 -
 target/m68k/cpu-param.h                     |  1 -
 target/microblaze/cpu-param.h               |  2 -
 target/mips/cpu-param.h                     |  5 ---
 target/openrisc/cpu-param.h                 |  1 -
 target/ppc/cpu-param.h                      |  2 -
 target/riscv/cpu-param.h                    |  2 -
 target/rx/cpu-param.h                       |  1 -
 target/s390x/cpu-param.h                    |  1 -
 target/sh4/cpu-param.h                      |  1 -
 target/sparc/cpu-param.h                    |  2 -
 target/tricore/cpu-param.h                  |  1 -
 target/xtensa/cpu-param.h                   |  1 -
 accel/stubs/tcg-stub.c                      | 24 ++++++++++
 accel/tcg/cputlb.c                          |  7 ---
 accel/tcg/tcg-all.c                         |  9 ++--
 plugins/loader.c                            |  7 ++-
 plugins/stubs.c                             | 49 +++++++++++++++++++++
 target/arm/ptw.c                            | 34 --------------
 target/riscv/cpu_helper.c                   | 13 +-----
 tcg/perf-stubs.c                            | 26 +++++++++++
 .gitlab-ci.d/crossbuilds.yml                |  2 +-
 accel/tcg/meson.build                       | 11 ++---
 configs/targets/aarch64-bsd-user.mak        |  1 +
 configs/targets/aarch64-linux-user.mak      |  1 +
 configs/targets/aarch64-softmmu.mak         |  1 +
 configs/targets/aarch64_be-linux-user.mak   |  1 +
 configs/targets/alpha-linux-user.mak        |  1 +
 configs/targets/alpha-softmmu.mak           |  1 +
 configs/targets/arm-bsd-user.mak            |  1 +
 configs/targets/arm-linux-user.mak          |  1 +
 configs/targets/arm-softmmu.mak             |  1 +
 configs/targets/armeb-linux-user.mak        |  1 +
 configs/targets/avr-softmmu.mak             |  1 +
 configs/targets/hexagon-linux-user.mak      |  1 +
 configs/targets/hppa-linux-user.mak         |  2 +
 configs/targets/hppa-softmmu.mak            |  1 +
 configs/targets/i386-bsd-user.mak           |  1 +
 configs/targets/i386-linux-user.mak         |  1 +
 configs/targets/i386-softmmu.mak            |  1 +
 configs/targets/loongarch64-linux-user.mak  |  1 +
 configs/targets/loongarch64-softmmu.mak     |  1 +
 configs/targets/m68k-linux-user.mak         |  1 +
 configs/targets/m68k-softmmu.mak            |  1 +
 configs/targets/microblaze-linux-user.mak   |  1 +
 configs/targets/microblaze-softmmu.mak      |  3 ++
 configs/targets/microblazeel-linux-user.mak |  1 +
 configs/targets/microblazeel-softmmu.mak    |  3 ++
 configs/targets/mips-linux-user.mak         |  1 +
 configs/targets/mips-softmmu.mak            |  1 +
 configs/targets/mips64-linux-user.mak       |  1 +
 configs/targets/mips64-softmmu.mak          |  1 +
 configs/targets/mips64el-linux-user.mak     |  1 +
 configs/targets/mips64el-softmmu.mak        |  1 +
 configs/targets/mipsel-linux-user.mak       |  1 +
 configs/targets/mipsel-softmmu.mak          |  1 +
 configs/targets/mipsn32-linux-user.mak      |  1 +
 configs/targets/mipsn32el-linux-user.mak    |  1 +
 configs/targets/or1k-linux-user.mak         |  1 +
 configs/targets/or1k-softmmu.mak            |  1 +
 configs/targets/ppc-linux-user.mak          |  1 +
 configs/targets/ppc-softmmu.mak             |  1 +
 configs/targets/ppc64-linux-user.mak        |  1 +
 configs/targets/ppc64-softmmu.mak           |  1 +
 configs/targets/ppc64le-linux-user.mak      |  1 +
 configs/targets/riscv32-linux-user.mak      |  1 +
 configs/targets/riscv32-softmmu.mak         |  1 +
 configs/targets/riscv64-bsd-user.mak        |  1 +
 configs/targets/riscv64-linux-user.mak      |  1 +
 configs/targets/riscv64-softmmu.mak         |  1 +
 configs/targets/rx-softmmu.mak              |  1 +
 configs/targets/s390x-linux-user.mak        |  1 +
 configs/targets/s390x-softmmu.mak           |  1 +
 configs/targets/sh4-linux-user.mak          |  1 +
 configs/targets/sh4-softmmu.mak             |  1 +
 configs/targets/sh4eb-linux-user.mak        |  1 +
 configs/targets/sh4eb-softmmu.mak           |  1 +
 configs/targets/sparc-linux-user.mak        |  1 +
 configs/targets/sparc-softmmu.mak           |  1 +
 configs/targets/sparc32plus-linux-user.mak  |  1 +
 configs/targets/sparc64-linux-user.mak      |  1 +
 configs/targets/sparc64-softmmu.mak         |  1 +
 configs/targets/tricore-softmmu.mak         |  1 +
 configs/targets/x86_64-bsd-user.mak         |  1 +
 configs/targets/x86_64-linux-user.mak       |  1 +
 configs/targets/x86_64-softmmu.mak          |  1 +
 configs/targets/xtensa-linux-user.mak       |  1 +
 configs/targets/xtensa-softmmu.mak          |  1 +
 configs/targets/xtensaeb-linux-user.mak     |  1 +
 configs/targets/xtensaeb-softmmu.mak        |  1 +
 docs/about/deprecated.rst                   |  7 +++
 docs/devel/multi-thread-tcg.rst             |  1 -
 meson.build                                 | 47 +++++++++-----------
 plugins/meson.build                         |  5 ++-
 target/mips/tcg/meson.build                 |  4 +-
 target/mips/tcg/system/meson.build          |  6 +--
 tcg/meson.build                             |  8 +++-
 108 files changed, 241 insertions(+), 202 deletions(-)
 delete mode 100644 include/tcg/oversized-guest.h
 create mode 100644 plugins/stubs.c
 create mode 100644 tcg/perf-stubs.c

-- 
2.43.0


