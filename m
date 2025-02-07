Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F502C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 21:08:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgVZ2-0007GE-1C; Fri, 07 Feb 2025 16:07:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tgVYy-00071M-Ma
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 16:07:00 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tgVYx-00022l-0m
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 16:07:00 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21f573ff39bso19490235ad.1
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 13:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738962417; x=1739567217; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cig0Ikc7b5qhuUpLi3eI6xYC2TiI0bWHi40sfAzfUrY=;
 b=H1s8libf0zAULVI9dlYo10ptLmsgHqvvdIRzHHOVWFnzm7h/suse4nJmH5DGblev21
 rZYIMQWp7D+rv5/INNWaBODogghMn+KctnpB+GghRNs2ORsUTEl9wClL7k3tKVMm5wYE
 +bR1GMbcWK2RWYt+slo7EA2haoS0kGsAnlW1WNt3j6uoTrufuEwXwejNi1QJqvN72lfe
 Ia2CGSAJFY9g7yzq+AQTZ9/Ph2z32tpUAbO9pFw6lTgf8pmZBDyeN3nhTxF6wngPl3z5
 bW8EvnJq/Jzk7RRExEiYqn0Jes2bRi2kkwCLRoJRUDirpanm8Fwwx9OHNhPA64hTwXhV
 KfIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738962417; x=1739567217;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cig0Ikc7b5qhuUpLi3eI6xYC2TiI0bWHi40sfAzfUrY=;
 b=t6Ccp0uvuc34QMtubHwyRMY3Y+1n3LJqeiQZGwE/jKhjA9TanD18L4M3xYC9xVOs0x
 U3rvGcv+sxoIlSNDH6qI4BtkYCHlbwEXyZDFv9v/rwsRBQkYMg/AmyYTGnvzFIEW3ha8
 ZO03Ga+Pw5goo8DMpT9DRcLo7xvGtVbkKSB8wKAhOuH4MJdLrwPi1njstJ0zXVTnXX69
 a62nm3+aGUXU7vcmaAeuM6TgreonkSeqbnln6oJMD8ctaCgS4NwrfGOncxM8uyZNI52W
 FGWIdARJwkPiA8eSTYI6gFik8SLFxJ9RGUhQ6PAnkRWyj1C8C95Mv2TLj+R1w1WYYATb
 h/QA==
X-Gm-Message-State: AOJu0YywqREMYCNJ1gaY4QgRcTc7LXFYvX1w06AKWuOkqXDEuObWUZq+
 JyABD+SCMHiqhA9wKgLrmWrXsPPz+dfcaG21GNjEilhNRKMOrNDYMymekYm+9diIdIi5l8vDq/q
 9
X-Gm-Gg: ASbGncuB6BLTJbRaZuhXxWDDgayGq0jl81lwC7+cSs6cr9N3KGbvXv2xZ6MECWunN6a
 jg04MgkHa2eBPogZElxgOiYhXpONmqIjz59EyP6ycEimQeHz57ms//441ebG6q/YrwDzINgNWGQ
 lDM10Cm3QvMcyE94AuxQyCNcl1TTaP7QuPqI5G3EIx8JSN2BwQgUo8G/YBthQkalbjiGjhRU8Yf
 GgdimZCoSkHiknmvtKjtl/Fzif1VEKN6TktyHqQrLIrDR/lx/bHNX9LFZPWx5KZS9eVVvcHDPzR
 5MgtGQgLNL2WV7mBh39evsL+TMcADIQzR3JUyICUuXYA9s4=
X-Google-Smtp-Source: AGHT+IEnaiMfhGA+nc27lff0A2YYBWLP4oCEQ/W24NCR5JiwmZ+WXAnONS5K4QZM3DTMvxvluvlx2g==
X-Received: by 2002:a05:6a21:350d:b0:1dc:2a02:913b with SMTP id
 adf61e73a8af0-1ee03a475c3mr8468504637.15.1738962417095; 
 Fri, 07 Feb 2025 13:06:57 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ad51af64c1dsm3539043a12.52.2025.02.07.13.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 13:06:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 philmd@linaro.org, thuth@redhat.com
Subject: [PATCH v4 0/9] meson: Deprecate 32-bit host support
Date: Fri,  7 Feb 2025 13:06:46 -0800
Message-ID: <20250207210655.16717-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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
v3: 20250204215359.1238808-1-richard.henderson@linaro.org

For v4, tidy NVMM/WHPX per Thomas' review.
Drop two more stubs patches which were intended to be dropped with v3.


r~


Richard Henderson (9):
  meson: Drop tcg as a module
  meson: Disallow 64-bit on 32-bit KVM emulation
  meson: Disallow 64-bit on 32-bit Xen emulation
  meson: Disallow 64-bit on 32-bit HVF/NVMM/WHPX emulation
  gitlab-ci: Replace aarch64 with arm in cross-i686-tci build
  configure: Define TARGET_LONG_BITS in configs/targets/*.mak
  target/*: Remove TARGET_LONG_BITS from cpu-param.h
  meson: Disallow 64-bit on 32-bit emulation
  meson: Deprecate 32-bit host support

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
 .gitlab-ci.d/crossbuilds.yml                |  2 +-
 accel/tcg/meson.build                       | 11 ++--
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
 meson.build                                 | 72 ++++++++++-----------
 90 files changed, 119 insertions(+), 76 deletions(-)

-- 
2.43.0


