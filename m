Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7DC9C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 11:50:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkN7F-0006Ep-UA; Wed, 13 Mar 2024 07:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rkN6u-00063F-69
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 07:49:33 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rkN6c-0003NL-0J
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 07:49:27 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4133100bccdso13429075e9.0
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 04:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710330548; x=1710935348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DHC0ACrNIuYRz4G1OaWWg9lq1EE8PUCMUKSz9aqMvd4=;
 b=A47Mnsuh3//bLtVqUYriqWXvgUfvmHM/wBuK9zOaoLlWqtYRcsGhBxQa00BrpWmgrV
 PP07omhw/4di+IJ0/J12kXKlWdB9CdFUT2vOQr1ZEb+as2OjzUjUv/RR7c8RT6gZrPG+
 FNcKS/qgrVGvOstwhdr8soXLIBdkojwYt1SXDdWGi1rTtlokWXVIiruNvsz5Zx5LAkTn
 m/qbtxrOhBbCd/JHlTV5Uq0nh6gdlEky+iCprBqAukqgLic+4+4I+ocG201KAFyShDTi
 ndI3dCAGKqI+P36z1AysJVAjFFKe3ruL1ym/CP/Bmd1Dzg2an+WMZDZn/PuNCGGiR7UZ
 h8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710330548; x=1710935348;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DHC0ACrNIuYRz4G1OaWWg9lq1EE8PUCMUKSz9aqMvd4=;
 b=EJAxRZsYHlVIhmHdlJB9zwtxFtDi66WQx71Frv38OVU1/jmEz+oLmPaU+77CYLtpQy
 NtzQt3iWo7KmhRkvBnp//UXe27AuLEfkQR8p9Gn2ARv3dEe67YZYADmlQF9U/Ku5YlyI
 WtXMDxJoRHIjnEBDQDP34VlsrJUD2gv11lEcDSFzL/FOUPLIgNYzw0RkMFZysEo850Ti
 OkHp8q44JuN+cYg++gLlBNCCgCJwb+1c3dmzRp0kI9uWT6gUb+gBA5yEYvgtNei8h6v4
 AXkE7f04RDv68LiqCraRMAz1WqcwNYv9+xYBrO1bjAQJnugEj7jpV20VlXkvshTpmIWO
 abWw==
X-Gm-Message-State: AOJu0Yz9NliOd9aUfu5xYn8Tm8a2PyuC3RBvTJdZplgJMopsOR8Vg1Zu
 KWET26iZH6L0QAwcvyzXS8LOo4YbFiZ4XN5Mm6gYDS07YJTPlvPN6IL2wPX1nDRiQ4pJXHQq9nv
 N
X-Google-Smtp-Source: AGHT+IF9rRAEj8rqwmzx+AYKxbXmqGMmTxazzIx6FYBwthFWJRzA0GFts+FwWETnfPM2aoRvFvB1+A==
X-Received: by 2002:a05:600c:4586:b0:413:1f57:aba6 with SMTP id
 r6-20020a05600c458600b004131f57aba6mr8864403wmo.12.1710330548106; 
 Wed, 13 Mar 2024 04:49:08 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 c11-20020adfe70b000000b0033e41e1ad93sm11500842wrm.57.2024.03.13.04.49.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 04:49:07 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EE7BF5F8D8;
 Wed, 13 Mar 2024 11:49:06 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL v2 for 9.0 0/7] final maintainer updates (testing, gdbstub)
Date: Wed, 13 Mar 2024 11:49:06 +0000
Message-Id: <20240313114906.20979-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 0748129684be2773117b0b8fc3c60161abdb7bb8:

  Merge tag 'ui-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2024-03-12 16:56:13 +0000)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-maintainer-final-130324-1

for you to fetch changes up to 6971998e241d8edc842b165b447f706c05166ae6:

  gdbstub: Fix double close() of the follow-fork-mode socket (2024-03-13 11:43:52 +0000)

----------------------------------------------------------------
final updates for 9.0 (testing, gdbstub):

  - fix the over rebuilding of test VMs
  - support Xfer:siginfo:read in gdbstub
  - fix double close() in gdbstub

----------------------------------------------------------------
Alex Bennée (1):
      tests/vm: ensure we build everything by default

Gustavo Romero (5):
      gdbstub: Rename back gdb_handlesig
      linux-user: Move tswap_siginfo out of target code
      gdbstub: Save target's siginfo
      gdbstub: Add Xfer:siginfo:read stub
      tests/tcg: Add multiarch test for Xfer:siginfo:read stub

Ilya Leoshkevich (1):
      gdbstub: Fix double close() of the follow-fork-mode socket

 gdbstub/internals.h                                |  1 +
 include/gdbstub/user.h                             | 19 +++------
 linux-user/signal-common.h                         |  2 -
 bsd-user/main.c                                    |  2 +-
 bsd-user/signal.c                                  |  5 ++-
 gdbstub/gdbstub.c                                  |  8 ++++
 gdbstub/user.c                                     | 49 +++++++++++++++++++---
 linux-user/aarch64/signal.c                        |  2 +-
 linux-user/alpha/signal.c                          |  2 +-
 linux-user/arm/signal.c                            |  2 +-
 linux-user/hexagon/signal.c                        |  2 +-
 linux-user/hppa/signal.c                           |  2 +-
 linux-user/i386/signal.c                           |  6 +--
 linux-user/loongarch64/signal.c                    |  2 +-
 linux-user/m68k/signal.c                           |  4 +-
 linux-user/main.c                                  |  2 +-
 linux-user/microblaze/signal.c                     |  2 +-
 linux-user/mips/signal.c                           |  4 +-
 linux-user/nios2/signal.c                          |  2 +-
 linux-user/openrisc/signal.c                       |  2 +-
 linux-user/ppc/signal.c                            |  4 +-
 linux-user/riscv/signal.c                          |  2 +-
 linux-user/s390x/signal.c                          |  2 +-
 linux-user/sh4/signal.c                            |  2 +-
 linux-user/signal.c                                | 15 +++++--
 linux-user/sparc/signal.c                          |  2 +-
 linux-user/xtensa/signal.c                         |  2 +-
 tests/tcg/multiarch/segfault.c                     | 14 +++++++
 tests/tcg/multiarch/Makefile.target                | 10 ++++-
 .../multiarch/gdbstub/test-qxfer-siginfo-read.py   | 26 ++++++++++++
 tests/vm/basevm.py                                 |  2 +-
 31 files changed, 149 insertions(+), 52 deletions(-)
 create mode 100644 tests/tcg/multiarch/segfault.c
 create mode 100644 tests/tcg/multiarch/gdbstub/test-qxfer-siginfo-read.py

-- 
2.39.2


