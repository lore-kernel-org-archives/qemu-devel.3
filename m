Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B3EC02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 21:55:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfQrv-0001YZ-U2; Tue, 04 Feb 2025 16:54:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfQrt-0001Xo-IF
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 16:54:05 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfQrq-0008TC-K2
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 16:54:04 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2f9c3124f31so1780717a91.0
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 13:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738706040; x=1739310840; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZHGk4p3byPyeKlgAUGx5bC7Rt4ZTms7YKJhqNict/Y4=;
 b=nls6fyaRLvVAf2LXXY8/4cbh23pNvIXfhzTtF0fq9N/Jn531OWUuI4QbsPE5p4Oddm
 6343rlB91GwbJB2xMYvcKXpu3pqQ8sK8BG5SzgbGMSslAGzuk1kdcSiHLV9Gw/XWXk3A
 gQ3O3JIvF0kA3xCBDSlsjDmVBfIoADq8ps1KKUP2xL5AMcAks7cnUaziDbUUdloZauIe
 c7Eezhx2Iot0bM+0AEkkp7NC/yKyaFQiS7NRD3zo/pZDbqstxgVbrPOU+72V4cZDaQDq
 okqxP8FJWd+dd9/l5+vr00eykgSt6FCFuyLgIKUsQyZNsem1pScjPqEMUWvAeRW6QouX
 92dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738706040; x=1739310840;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZHGk4p3byPyeKlgAUGx5bC7Rt4ZTms7YKJhqNict/Y4=;
 b=VkDyk1oEXSVSxjc3gOlBT5HadCEsNIVk/Klmxno+FokoYKx9ShQeqGzlbvELTaJiiU
 lxEBfCFyX76fBGaA984s5K2TBQafO3OlPq4m40X0u7SuAO1zQ39H5b+ZWmDubuiwKISo
 dVgybWEQY9BQJgJAHSELOR39pern2tjFTFJrSJSsnHsaxNAW2GJCx8pEaJ/N3W46c4BS
 rR8euE/1cve+LRqlTt2VAIxdl2+KAhZPrcFsPkwkxLA5nlSVmLFRXGxfc9jIfkg0sFcf
 VGEGOOdL8wO6hQPkPuMFjKZ//lLNpqugBVBp/5e2trUcNzz+2ChL1xu0aBYG61QNoQUo
 Fd1g==
X-Gm-Message-State: AOJu0Yz6lkFo9HdifUI8VZRrf4SN5JJAe1FAEvYeRcc5wzO+ugmXk2QI
 H0uyTd1Sre/49xxtxhaJAeomzTZOHSjQuPVprgoIwaHF/JO+aI4XY9a1UlwjdpUHgD9ps7e8Od6
 0
X-Gm-Gg: ASbGncvrf93EUuqy23F0lq1jitxI+ouSq4mL31cV8Yd4YP2ZS+PFQmfMhWWC0lwtMh2
 KQiyL6TwVyvAKdgvwCDT16cCFmFdMMBPWS+cdge1ywYtU24QzPaVGsbxKn0WI3hjL8Bu4M15e5i
 lO7Nb8a1VZhDqNU3Qcaw4kwd8EovIdITOU4zaU0ssW2544jY0iQhNNTIoFYxLBGJH4vB+Pbge4R
 Xpf1Go+fdrtCE3NJA1bUyKMWlHMzahpMMxDYmA9oK0RnNixbJn9ps8bGp7ln+1Eu3CErMna3SYf
 plqVZB+/GEujdhKqP8DwNB5xnMqrMwWoUCz/1bW+KjAEpIk=
X-Google-Smtp-Source: AGHT+IGBUih4lbonlY6s+QjkGhN1dngVkaAjdcDaA0lTWnZZytNHO/YuQ7hbK4fLBPhiAGR0Q5Mlkg==
X-Received: by 2002:a17:90b:4c4b:b0:2ee:a6f0:f54 with SMTP id
 98e67ed59e1d1-2f9e076c892mr588331a91.13.1738706040626; 
 Tue, 04 Feb 2025 13:54:00 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f9e1d60b57sm33888a91.9.2025.02.04.13.54.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 13:54:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 philmd@linaro.org, thuth@redhat.com
Subject: [PATCH v3 00/12] meson: Deprecate 32-bit host support
Date: Tue,  4 Feb 2025 13:53:47 -0800
Message-ID: <20250204215359.1238808-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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
v2: 20250203031821.741477-1-richard.henderson@linaro.org

For v3, immediately disable 64-on-32 for all accelerators.
This eliminates most of the hoops through which v2 jumped.


r~


Richard Henderson (12):
  meson: Drop tcg as a module
  tcg: Move stubs in tcg/perf.h to tcg/perf-stubs.c
  plugins: Uninline qemu_plugin_add_opts
  meson: Disallow 64-bit on 32-bit KVM emulation
  meson: Disallow 64-bit on 32-bit Xen emulation
  meson: Disallow 64-bit on 32-bit HVF/NVMM/WHPX emulation
  gitlab-ci: Replace aarch64 with arm in cross-i686-tci build
  configure: Define TARGET_LONG_BITS in configs/targets/*.mak
  target/*: Remove TARGET_LONG_BITS from cpu-param.h
  meson: Disallow 64-bit on 32-bit emulation
  meson: Deprecate 32-bit host support
  tcg: Remove TCG_OVERSIZED_GUEST

 include/qemu/atomic.h                       | 18 +----
 include/qemu/plugin.h                       |  9 +--
 include/tcg/oversized-guest.h               | 23 ------
 include/tcg/perf.h                          | 23 ------
 target/alpha/cpu-param.h                    |  2 -
 target/arm/cpu-param.h                      |  2 -
 target/avr/cpu-param.h                      |  1 -
 target/hexagon/cpu-param.h                  |  1 -
 target/hppa/cpu-param.h                     |  2 -
 target/i386/cpu-param.h                     |  2 -
 target/loongarch/cpu-param.h                |  1 -
 target/m68k/cpu-param.h                     |  1 -
 target/microblaze/cpu-param.h               |  2 -
 target/mips/cpu-param.h                     |  5 --
 target/openrisc/cpu-param.h                 |  1 -
 target/ppc/cpu-param.h                      |  2 -
 target/riscv/cpu-param.h                    |  2 -
 target/rx/cpu-param.h                       |  1 -
 target/s390x/cpu-param.h                    |  1 -
 target/sh4/cpu-param.h                      |  1 -
 target/sparc/cpu-param.h                    |  2 -
 target/tricore/cpu-param.h                  |  1 -
 target/xtensa/cpu-param.h                   |  1 -
 accel/tcg/cputlb.c                          |  7 --
 accel/tcg/tcg-all.c                         |  9 ++-
 plugins/loader.c                            |  7 +-
 target/arm/ptw.c                            | 34 ---------
 target/riscv/cpu_helper.c                   | 13 +---
 tcg/perf-stubs.c                            | 26 +++++++
 .gitlab-ci.d/crossbuilds.yml                |  2 +-
 accel/tcg/meson.build                       | 11 ++-
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
 configs/targets/microblaze-softmmu.mak      |  3 +
 configs/targets/microblazeel-linux-user.mak |  1 +
 configs/targets/microblazeel-softmmu.mak    |  3 +
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
 docs/about/deprecated.rst                   |  7 ++
 docs/devel/multi-thread-tcg.rst             |  1 -
 meson.build                                 | 77 +++++++++++----------
 tcg/meson.build                             |  2 +
 102 files changed, 167 insertions(+), 205 deletions(-)
 delete mode 100644 include/tcg/oversized-guest.h
 create mode 100644 tcg/perf-stubs.c

-- 
2.43.0


