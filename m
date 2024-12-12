Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B58E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 14:44:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLkQi-0007oT-Ef; Thu, 12 Dec 2024 09:44:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLkQf-0007ny-9E
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:44:37 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLkQc-0004Cr-Ja
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:44:36 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4361dc6322fso4804345e9.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 06:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734014672; x=1734619472; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=m5fLks2QV5Yxjf0ma6o8/QOU7smgJCwXT7/qpuubMLM=;
 b=aNomyoc3hqMFmtHY07qI3vKxo8J4JITGW+mznZU9pOisRjF4zE+cPwwFYi36K+pOqJ
 ckvcfU0P4mZw12csM9TBRQ6Y6QvUxwIkKS+2//BYdtg8DB4yZGN4ups+gjAmt2hXDexJ
 ALLqU5VgoSLHIzo5DuBd3c10KkUDNN+ojeEfotDVAybnyA+zPTZD2/o7uXqIoPQMDXGU
 fRx8pD37d9mc2SCjr4PPAVS3A9cF59URifeTvnmA35sTDtF13fdvL2BoARhw7B3rVWKM
 gR++Ls3tOC9gwPVlIAVNlbXWlWSBZ1Qet4/0OjcM1RZc+hGIvJIS0+KegiOGkFy0Zm33
 Q8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734014672; x=1734619472;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m5fLks2QV5Yxjf0ma6o8/QOU7smgJCwXT7/qpuubMLM=;
 b=lsohboVPcOe1JeRIP3uxnsEsmKUsv0tZXdpwJjGDim7clhQe8Bs2+iPq9mV43kjYJs
 3d6WcW/iCd24TPDEh7x4EbAwbnlXQtM8nZifr4AU8ku0XmwOlmcrSa9pZfuRP8TqgPO+
 AEIMel/r8uLxPf/v/vmSNW8QMmQ6Deez9aQ70hXzbZKqx4t6amIOCRjIlZikY0rw+6MF
 TerOoyGzJzd/NUNJG1DAzZNeEEfGSS689SGTQ87Vj9s//GTK/hKQOcTdNELze+ERGKzs
 UhdUSHe0EG0h0HUUStIIrSGHPm2d+rReV+mzTnRcvrmdkYmFmHGjOGx5baMA/RKd706b
 HBCw==
X-Gm-Message-State: AOJu0YwDuvN1nL8vg2Ee1HZshzqIHmfz1/VTKe6L5PrFMTMWdD7z7wvY
 52ZyYpQ+sjwxxKDfKIiUGPA4/Pf0V+mt99vYex8ROQ2qlNOeDogFzFzrZgfrXmn+fn9jQGegb0L
 6
X-Gm-Gg: ASbGncv1kmumlSPh7fOXdq9L+/N2ce6Yhrm2A2W5smI+Tpia1dXYU2sra8F2OD9dSog
 YIkTqwo8hg/YK+sanNkldu+q5dN8Y82O/qu+oXtfSgiW5h2UUtrhhrcJ4jWrbdwOfcPmpJkMKHc
 wrUPdTyJaI5a+egrrOXknGos0YuoTcgXBjK+O+4GwmXAfmS0+aJyPzFcI+/WcAPfLxKjxu5sxib
 2XLPPEnVDtc5FVcR3NIxR40+pGSKQeoW2R3KYJuiFay4yiusMOrzaMC8Q//IFKeaSNyNpoyifne
 Qq/zdoeefszRF2oabrEJFJTISMCYgaQ=
X-Google-Smtp-Source: AGHT+IEa8KUeJXD6RJBthCn8B9+MBeOtuiouNJzosdmdCdDQIhm6jWdwrH+YOqpuxQsivAGQpRN+lQ==
X-Received: by 2002:a05:600c:5101:b0:434:a1d3:a331 with SMTP id
 5b1f17b1804b1-4361c3e2350mr49471705e9.22.1734014672339; 
 Thu, 12 Dec 2024 06:44:32 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436257177c5sm18358515e9.43.2024.12.12.06.44.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Dec 2024 06:44:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/2] accel/tcg: Cleanups around 'exec/translation-block.h'
Date: Thu, 12 Dec 2024 15:44:28 +0100
Message-ID: <20241212144430.66224-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Address Richard suggestion from [*], move
tcg_cflags_has/set() and curr_cflags() to
"exec/translation-block.h".

[*] https://lore.kernel.org/qemu-devel/1f0c07f3-6306-4729-99b6-1b8607687711@linaro.org/

Philippe Mathieu-Daudé (2):
  accel/tcg: Move tcg_cflags_has/set() to 'exec/translation-block.h'
  accel/tcg: Include missing 'exec/translation-block.h' header

 accel/tcg/internal-target.h             | 1 +
 accel/tcg/tb-hash.h                     | 1 +
 include/exec/cpu-common.h               | 6 ------
 include/exec/translation-block.h        | 6 ++++++
 target/arm/tcg/translate.h              | 1 +
 accel/tcg/cpu-exec.c                    | 1 +
 accel/tcg/tcg-accel-ops.c               | 1 +
 accel/tcg/watchpoint.c                  | 1 +
 cpu-target.c                            | 1 +
 linux-user/elfload.c                    | 1 +
 linux-user/mmap.c                       | 1 +
 linux-user/syscall.c                    | 1 +
 plugins/api.c                           | 1 +
 system/physmem.c                        | 1 +
 target/alpha/cpu.c                      | 1 +
 target/alpha/translate.c                | 1 +
 target/arm/cpu.c                        | 1 +
 target/arm/helper.c                     | 1 +
 target/avr/cpu.c                        | 1 +
 target/avr/translate.c                  | 1 +
 target/hexagon/cpu.c                    | 1 +
 target/hppa/cpu.c                       | 1 +
 target/hppa/translate.c                 | 1 +
 target/i386/cpu.c                       | 1 +
 target/i386/helper.c                    | 1 +
 target/i386/tcg/tcg-cpu.c               | 1 +
 target/i386/tcg/translate.c             | 1 +
 target/loongarch/cpu.c                  | 1 +
 target/m68k/translate.c                 | 1 +
 target/microblaze/cpu.c                 | 1 +
 target/microblaze/translate.c           | 1 +
 target/mips/tcg/exception.c             | 1 +
 target/mips/tcg/sysemu/special_helper.c | 1 +
 target/openrisc/cpu.c                   | 1 +
 target/openrisc/translate.c             | 1 +
 target/ppc/translate.c                  | 1 +
 target/riscv/tcg/tcg-cpu.c              | 1 +
 target/riscv/translate.c                | 1 +
 target/rx/cpu.c                         | 1 +
 target/rx/translate.c                   | 1 +
 target/s390x/tcg/translate.c            | 1 +
 target/sh4/cpu.c                        | 1 +
 target/sh4/translate.c                  | 1 +
 target/sparc/cpu.c                      | 1 +
 target/sparc/translate.c                | 1 +
 target/tricore/cpu.c                    | 1 +
 target/tricore/translate.c              | 1 +
 target/xtensa/translate.c               | 1 +
 48 files changed, 52 insertions(+), 6 deletions(-)

-- 
2.45.2


