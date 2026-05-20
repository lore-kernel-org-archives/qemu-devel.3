Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D98CD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 11:30:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPf7w-0005dv-5i; Wed, 20 May 2026 07:30:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPf7m-0005Lh-9W
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:30:06 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPf7k-0004km-IB
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:30:05 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-67f7caa33easo10186961a12.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 04:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779276603; x=1779881403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MHj5KgKQwjOCBlbyQHbPjit+W0UarfSBsIQ5wbkhJlI=;
 b=JBw6ahan/sa1yNPkPvkjjUjxO4MbplP68cflyin7cDHtRFsWtR2kNW5q2xVGxGAPFg
 +xvbPOz7MDFoz4cqSZWJRZ+iU8iK+Xk5dmWYMwFT13JtedHOcYfmP2+JghwT3qVudHT5
 AhStzRu2+SLPW/2krAG0Tll1KAovr3oDrABHltKgeiZw0x5nhDlartV/RwPr0V/0cSMO
 HK0rG165LAMtvdwOfYqRaWFS1JX2VLpiWEmwmCzV2dVqD+DNDQ419zQ5WpdRw4n3X354
 G3Q1dYS1Bob3OCyR/GWTWWYg9AD5i3hANzBx871dz8Dti3njSvNRuwFYZLmLcif3gQUU
 6ClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779276603; x=1779881403;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MHj5KgKQwjOCBlbyQHbPjit+W0UarfSBsIQ5wbkhJlI=;
 b=SwoW2prGm//WnXdSt5fU1bZJd32Qg0ND6b6Ig9K5cMK+/Qk0pT7P1QGE5YasTNcA/b
 wBodtKQ+Cm1datDeKDhp0e6fzkNqe11g+VvD6J51H0JYhLYf5SH2sKyp+q/74lkaedHS
 UtPNvyutu/LcZKV6EUQ5rSdyZUmhsvFOdJu8hrmiLoJvaNOFoqCOAOfK4nu/ud+5GFQI
 t9Msd1PyumPvJNZ25mjwEocW6mHpeoAyUM6Iv43LRHIbB29yZnarZQ0D+GJyGYmqILW4
 sSqlHHv9tBIAVK0EZl/FnMbQfPgcF/rnVYXyvyhSpez8HhnFkO+skyEYuehn1qhU+G3+
 GQVQ==
X-Gm-Message-State: AOJu0YxffVejpxDTWS2Lt/srvj2D5w9FGOtp/aG4P+Ezh35PUB+coMq9
 M04J/lSL9E9/5uhmrakYal0VXavbCvOLQWypLfWvFb1AKiae1JmzH9y/UgND8vSya5rQyAi6N0r
 m71nqjPY=
X-Gm-Gg: Acq92OEHDzWYcUI6Hlfc6lqdVUmO8VcTh4fv73J5xvFzvQHjtnw/PyFkOQRrWyBzajJ
 QTrwt9Ix8AubUsFZPoaHwmsi51zBKwBQHJJdjBlbkF+NeYlfNo7gME0HfJM5Z1vWvzOGE6DfKQL
 BrKM+GSuKdTKbCGHPk02GTRi76Av97EBQGiKht9ZjT5cGpCFB8GEVx0U0Z4eJT+wP/ZKkEVyULc
 S7jQpgiSCgrSG5vTmBVdNpYXu75Y9Cjl6g+8JRqFd+9gDuMWrSxppMQmJvM2xI/sRgKTkdca1od
 oZaCmeORVi9Dhd56xm0m34CEWfVBCxaNj5V7zRAhG1NFE/2W97eP743QtWx9rn0L96kSiAcsKda
 U9YQ6AgDYFyV07uthoNPPFW9R+Y+f8RsjIDyTWkaY8qxtwSNElUSOjWpGd/ekvNgPshKXN7IYhl
 7QqKyGBz3gpI+ZLQWVU978rZbY8Kc6QyMpAyEBGFSglm7PIaGtU27rVhWd0RhEZdVKhu/UokhHr
 HZ1oxgK59M+aHCH
X-Received: by 2002:a05:600c:4e47:b0:48f:d835:e0ff with SMTP id
 5b1f17b1804b1-48fe63265a1mr396876055e9.17.1779272289707; 
 Wed, 20 May 2026 03:18:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe5ab52a6sm386586495e9.10.2026.05.20.03.18.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 03:18:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v11 00/24] target/mips: add missing Octeon user-mode support
 (first half)
Date: Wed, 20 May 2026 12:17:41 +0200
Message-ID: <20260520101807.9971-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Respinning first half of James v10, adding tests with each
patch modifying an instruction instead of all at the end.
Split SEQNE/SEQNEI patch to ease review.

James Hilliard (23):
  linux-user/mips: implement sysmips(MIPS_FLUSH_CACHE)
  linux-user/mips: implement sysmips(MIPS_ATOMIC_SET)
  linux-user/mips, target/mips: honor MIPS_FIXADE for unaligned accesses
  target/mips: expose Octeon68XX floating-point support
  tests/tcg/mips: add Octeon instruction smoke test
  target/mips: fix Octeon arithmetic destination handling
  target/mips: drop Octeon zero-register fast paths
  target/mips: split Octeon SEQ/SNE decode
  target/mips: split Octeon SEQI/SNEI decode
  target/mips: add Octeon LBX instruction
  target/mips: add Octeon LHUX instruction
  target/mips: add Octeon LWUX instruction
  target/mips: add Octeon SAA instruction
  target/mips: add Octeon SAAD instruction
  target/mips: add Octeon ZCB and ZCBT instructions
  target/mips: add Octeon multiplier state
  target/mips: add Octeon MTM instructions
  target/mips: add Octeon MTP instructions
  target/mips: add Octeon VMULU instruction
  target/mips: add Octeon VMM0 instruction
  target/mips: add Octeon V3MULU instruction
  target/mips: add Octeon QMAC instructions
  target/mips: add Octeon LA* atomic instructions

Richard Henderson (1):
  tcg: Introduce tcg_gen_addN_i64

 MAINTAINERS                                   |   2 +-
 include/tcg/tcg-op-common.h                   |   1 +
 linux-user/mips/target_syscall.h              |   3 +
 linux-user/mips64/target_syscall.h            |   3 +
 target/mips/cpu.h                             |  16 +
 target/mips/tcg/translate.h                   |   2 +
 target/mips/tcg/octeon.decode                 |  54 ++-
 linux-user/mips/cpu_loop.c                    |   5 +
 linux-user/syscall.c                          |  56 +++
 target/mips/cpu.c                             |  10 +-
 target/mips/system/machine.c                  |  33 ++
 target/mips/tcg/octeon_translate.c            | 411 +++++++++++++++---
 target/mips/tcg/translate.c                   |  24 +-
 tcg/tcg-op.c                                  |  42 ++
 tests/tcg/mips/user/isa/octeon/octeon-insns.c | 204 +++++++++
 target/mips/cpu-defs.c.inc                    |  10 +-
 tests/tcg/mips64/Makefile.target              |  20 +
 tests/tcg/mips64el/Makefile.target            |   8 +
 18 files changed, 844 insertions(+), 60 deletions(-)
 create mode 100644 tests/tcg/mips/user/isa/octeon/octeon-insns.c
 create mode 100644 tests/tcg/mips64/Makefile.target
 create mode 100644 tests/tcg/mips64el/Makefile.target

-- 
2.53.0


