Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F23D4C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 21:31:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thbLY-0003aV-Pl; Mon, 10 Feb 2025 16:29:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thbLW-0003ZM-Vk
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 16:29:38 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thbLU-00027z-7u
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 16:29:38 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4364a37a1d7so48379835e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 13:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739222974; x=1739827774; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=E11/JwIYJ2Y/faM5TyQQeEFRyrnATjEUmt+z2LzNUFo=;
 b=ZqgIKDCqe75sh97vi6bERdmW29pgiuBnT3fOMOiAGOdHXrFDLa4aVcbCjwDDUKrhhd
 QU76vYU8xDbc9tddS0TyyGJq1eeT8dvDxg8QzLw3EUME/vi60XuVNA0Tb9aOTo6amQQe
 ENnDN6fcdRVsKSCAk25EEQva1+3LcfkOHvRQDtu0gEoNupoAxiD8Xi1YR1l285vP+xHX
 0nBLFqMks+Tqw7xU64zQFf+qjZ9novztLhnC/67HI4ElCNNbkmYbsV+Y2azknNKUZlJY
 NqOZtWc9x1N+YHLY5peuKPr+GvD/Y7Of/cLh7EcCqCQ5PX6ylqCMyUh7/IgQiOqOkUpL
 xUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739222974; x=1739827774;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E11/JwIYJ2Y/faM5TyQQeEFRyrnATjEUmt+z2LzNUFo=;
 b=WGJTHkmwzZPoLwU9zMIpYKj6bjnlZxUkS6/J67zNrxCrlrVCla/bPPN2Vnwel4UUdx
 5KFqjG6ajd97D1scwo1bl0gE63fYZBqjSxVlZm6aMD6IKBMEx3MUwV0s2LesxgglGXab
 VgNzbwP99MNlnkgIChHBShm9COKXzCnADLHc2j8YVdF/IS2etxIeeMBjzfIFoDpl9TLk
 bOuLLK+xvzHAQyk9xCy4QZYCf0mcDWf9OynVG1fNGfZC0QP5B5jmNG2xn+yEoIojoxTh
 Xr1cBvdyO3Mqofy649dno4k/NXP9x3Rz0eNANkz2mqMcE0+ngRuzdDwHilKx49XfbxaX
 u9ZQ==
X-Gm-Message-State: AOJu0Yy8Ebykf4qKvbs6H+HJ/AZy6Sggj75snWIiI4Ie1aEkiXGhGH2Y
 l0HCJkzMS+dmuKwu/C+GNEGstXBuUXm0BwH3yLtnaKT9KiD2mr5lVB396wD1IbvIpuTXRA/+tvk
 XSXQ=
X-Gm-Gg: ASbGncvB7UpR1ayz7nk6UF0iiqbiBxC2bdu3bEnsbTSkde5og5DR/NTqwmPeyAhdVV0
 zkQ0zg9uk3jYS1uvYch4/2qeBFgjUkRGkpd61GlB1Vd0Q/ppEf1E0uHujQA9Q07/C/aOVCq5T6e
 C2MR8ZUiZDFI+YUhq0DvAHdmq2Z5XGnAzH9NktyeokC1WT80PoyRI/GPTstW+JlBoiQqwRZMYR3
 YJP48+Y19gpbu9gmpcThl5dE99IUxEhDzCBaFb03C6jmyxV/tqPIwcZutYtV1ShzqTLmUnK136t
 fE3x/ByG5CH/RCbQhTELdon9pykME5KXOBTnVORqfjFKCkKTbAc1/yHOwM20XgbOpg==
X-Google-Smtp-Source: AGHT+IE68ynsK/wASOcJs0pRITvbtSHVSB8gudxc7aIIlXAUz/Bc5/0bOUrhzcK4cSC+ZB6ptMyPdw==
X-Received: by 2002:a05:600c:34ce:b0:439:3254:4bf1 with SMTP id
 5b1f17b1804b1-43932544f7cmr78777475e9.8.1739222973651; 
 Mon, 10 Feb 2025 13:29:33 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd530cce2sm7356427f8f.88.2025.02.10.13.29.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 13:29:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 00/10] disas: Have CPUClass::disas_set_info() callback set
 the endianness
Date: Mon, 10 Feb 2025 22:29:20 +0100
Message-ID: <20250210212931.62401-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Missing review: patch #3

Since v1:
- Addressed Thomas & Richard comments

Targets are aware of their endianness. No need for a global
target_words_bigendian() call in disas/ where we call the
CPUClass::disas_set_info() handler which already update
disassemble_info fields. Specify the target endianness in
each CPUClass handler.

Philippe Mathieu-Daudé (10):
  target: Set disassemble_info::endian value for little-endian targets
  target: Set disassemble_info::endian value for big-endian targets
  target/arm: Set disassemble_info::endian value in disas_set_info()
  target/microblaze: Set disassemble_info::endian value in
    disas_set_info
  target/mips: Set disassemble_info::endian value in disas_set_info()
  target/ppc: Set disassemble_info::endian value in disas_set_info()
  target/riscv: Set disassemble_info::endian value in disas_set_info()
  target/sh4: Set disassemble_info::endian value in disas_set_info()
  target/xtensa: Set disassemble_info::endian value in disas_set_info()
  disas: Remove target_words_bigendian() call in
    initialize_debug_target()

 disas/disas-common.c    | 13 ++++---------
 target/alpha/cpu.c      |  1 +
 target/arm/cpu.c        | 10 +++-------
 target/avr/cpu.c        |  1 +
 target/hexagon/cpu.c    |  1 +
 target/hppa/cpu.c       |  1 +
 target/i386/cpu.c       |  1 +
 target/loongarch/cpu.c  |  1 +
 target/m68k/cpu.c       |  1 +
 target/microblaze/cpu.c |  1 +
 target/mips/cpu.c       |  3 +++
 target/openrisc/cpu.c   |  1 +
 target/ppc/cpu_init.c   |  2 ++
 target/riscv/cpu.c      |  9 +++++++++
 target/rx/cpu.c         |  1 +
 target/s390x/cpu.c      |  1 +
 target/sh4/cpu.c        |  5 +++++
 target/sparc/cpu.c      |  1 +
 target/tricore/cpu.c    |  6 ++++++
 target/xtensa/cpu.c     |  5 +++++
 20 files changed, 49 insertions(+), 16 deletions(-)

-- 
2.47.1


