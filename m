Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9215C0219B
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2025 20:59:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgrtN-0001sn-RG; Sat, 08 Feb 2025 15:57:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tgrtK-0001rh-G3
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 15:57:30 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tgrtI-000572-BJ
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 15:57:30 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21f44e7eae4so46230645ad.2
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2025 12:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739048246; x=1739653046; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=NsOto1j+5oOnmYQYbX8BOWMjGjvkd/bxhwH9yHsapXo=;
 b=LvpKLh/b48B8/m9T6vPjwcBHgKtMnKDNj5ODiuO3PU3xCyI91FEeP5weWF/lBK0Gev
 4EhiVulU2EQNM86gVJrRHdJYV25trX39fhUfGP6zj8aFiKw55QJsnMbF2Zn8X1im065q
 M8fOho8/yfGohRbhuNRN85tkpTIWhIaZmh/lL/Yy2AIvXUorqBBXANGxJV2IFmztDJak
 qjd6kC0v9f0xpKmyZcLpF9B+tSPlqbPOBNjPut+TjZ3EXXwtJXivK4tZ4KwEHso3WOP2
 qBZeSzAcPwnae2OACFCieD3e9c0vg3XbuxStlMXSXBNWcCrEoV8tUgDTkcMIlXH6NwRP
 +tqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739048246; x=1739653046;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NsOto1j+5oOnmYQYbX8BOWMjGjvkd/bxhwH9yHsapXo=;
 b=JqKC9K5JveS5CBPGfhM45saD7j2sg6Jlunlu5e5Fy71UbJzO5+Ozl1YfgVxmOQWXaR
 XYF/h/H2qxuLrLvanDr442FbU70mfd9UULUcTWXAg+qdGYMX0wAz/Hap9gzy2Jlbk03K
 xm0vpPsJZHRR6bB61aYflngQTuoZDa+hqxRsTUKNUBo5QLdkeThN2doz1DmfP/CzAPrN
 XAxezWGjn9g0UC7AB8uiusQxLXWLjZwN735ErNVDgNg5GljggfH+7odWqihL5hjvVK/S
 60XW+MiMzapkHebKfyCuq7GhFSNQu1wCCnLeIJHXj4z/rJPPuYgTOSkH8klPoBO/FNUm
 UoxQ==
X-Gm-Message-State: AOJu0Yy2YxJUuGSlO7Mm2CnZm824+vCWfLtfKbhUsvC5TQwlD/tizhFu
 oaRSOr8wkaSpOjRIp+YonkPUWIRkxMfIFT3Ji4uQtZXIgqLwx+rEGAS+V8zgqAYh3iOTb3cvpk/
 K
X-Gm-Gg: ASbGncsdMHJ4RulZ4NNRcDWsfzUgpPbcGtAKiiBcqej3LCKiSJ6eGVPE0PYV+qz9UGl
 i6VAOhzxHOlaYE0zcBxIvc/+Ry6dJpVBfWKlr3OTxbWdsbUwLcwHKdZdjvwBPA1jWXXaUKmuURM
 fpL9ERy+eXdW+yA/sO7SbDShn3iukBmAx3t4bJ4l419KmitzGFINxRh/cedsyiNQj42v/5FRiL6
 POiPg7vAlXDJT5WOIqf3z1KOb7XyI9bREhb2feSgbBTNVlfLbCedONHNw/5p99ztBg41tZiVBlP
 OKOkw1vZvX0djP/CwFAdxY5kADVtibbyk7svxKs1pgpr2mM=
X-Google-Smtp-Source: AGHT+IHA3D4URVh6CWKAIyXVSQxOUhGwx4ns63cn+otkw77yNcH0qbJvwGi0SVaWtWygLCn2z1DBIw==
X-Received: by 2002:a17:903:985:b0:21f:5b1e:11ef with SMTP id
 d9443c01a7336-21f5b1e1373mr104533695ad.32.1739048246235; 
 Sat, 08 Feb 2025 12:57:26 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3683d58fsm50852685ad.122.2025.02.08.12.57.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 12:57:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/9] meson: Disallow 64-bit on 32-bit emulation
Date: Sat,  8 Feb 2025 12:57:15 -0800
Message-ID: <20250208205725.568631-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

The following changes since commit 04d3d0e9f54d4c42759f3810aa135ce314d98dc4:

  Merge tag 'hppa-system-for-v10-diva-artist-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2025-02-08 09:00:57 -0500)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20250208

for you to fetch changes up to 6d701c9bac1d3571e9ad511e01b27df7237f0b13:

  meson: Deprecate 32-bit host support (2025-02-08 12:41:40 -0800)

----------------------------------------------------------------
meson: Disallow 64-bit on 32-bit emulation

----------------------------------------------------------------
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
 meson.build                                 | 72 ++++++++++++++---------------
 90 files changed, 119 insertions(+), 76 deletions(-)

