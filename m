Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B0BEC0218C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 09:33:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taX4Z-0001Jq-TF; Wed, 22 Jan 2025 04:30:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taX4E-00018e-Tc
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 04:30:39 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taX4D-0003BA-8V
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 04:30:34 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4361e89b6daso45837965e9.3
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 01:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737538231; x=1738143031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6JCKxl/E/lMfjQGnH4P9B5vjq2aSMsz2teDy8pH82EM=;
 b=m/B1MMkWWSrKSgyIWzgIaeTOlUetUXpzjal2EuskhFuBPVCib1GzovGejuoVVpne4R
 7ZqNSMkW2F7FrlinAMmjbUE3idrIuYabvKGNqc3ATqnh7nkiONgJCtmA89489h+AkNtX
 qNF46DBdUYOQa2IecGMHT+GdqQevd505mdV1K8i+TlqxWr1cfGEQe/o/OXPPvPU29UGD
 b/3rLni3ahMa1S6t4aDcTzpeR3XcpgKWv8YQ6sL0vqgzdSSVdITwNvbgT/+/nUlKNsux
 aH5rDX0RdVhmHiJCVk1Vc1L/Ef00zReWC9bYbmvpNlilYJ+0N+r9mebUlyITumqd9KGq
 NR9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737538231; x=1738143031;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6JCKxl/E/lMfjQGnH4P9B5vjq2aSMsz2teDy8pH82EM=;
 b=GrcBkQGlW+hP281ojBiqkBwxGvK291qLPrDJK/HQGs5HtB+aMlv5qdSXn+PGON6zf0
 pGdGLjq4nYE1rNSMFp/XSeujYTD0Ocvg5KbQVusJidJaG2nwBoMQ3uzgKH6CpohN0LZO
 P2QIs3ktLMfNvR9+MaoNnjXCZqOw47R3uyY5A/c54OhnLd8GOJ3bQeVzaQ8WIH4Ie3+A
 mHrOTxnqF+UguA6TXeyDoRuuzpPEUs4Ad6wnP8by8ZTwAnkJwa+QoOcQi5Xrc59mDVG2
 RCLFZDFl2DO38HQYaaw1iwAKHEfo9Oqnh6q0jrlF96rhQx+lDQQoiZA/0c2MYjRThDmS
 JfCw==
X-Gm-Message-State: AOJu0Yx/0b/NaggEeUS8aJiuKNhpUdLxJ6f3qzQXtQkKzIAo0brPU8Pi
 w6XZDpQ+fhnWxXhQY2CCQsYogAOCh/CwTIGulw9TpPSxtSFgxvSuV5IjO8uYWDm3O5yZo6L59iv
 vTzg=
X-Gm-Gg: ASbGncvsqeKmPUmsQ3iBmftuY/58DYm06bJjY8H/4pemaL6hudM9s/fMRsO/Am3XMX0
 PeK395K6/luGKZQV9sRPN6B4uXJ3g43UUeyoVlaDWGCU6nX9e4r7j2gE2u+dTtnVf1YQ+43WpCU
 CuyOh3mOHUHKMABc6aoUDMghnFyQph9GiXch4F7wwVAdT7LhCb0HxoqqvSPvbdf5hl7P6luGXQx
 FOfmg9b7juJ7ZF2h73Hc6g4iEiR0nUYsGC1oYAl3c7lXmAhBtNKCymr0z++8b4HpbTjCffhjHHq
 i5F065b/jJyVdxWeF5rTewFCJqEA0n2Ach+PsUBR4bHf
X-Google-Smtp-Source: AGHT+IHEJolaNlR785vud4ZQQFbDX1NKMiQ949Usvi04hkcDEpvfNpYc5F2gnYirYUfibGJ87n1ATQ==
X-Received: by 2002:a05:600c:5486:b0:434:a10f:c3 with SMTP id
 5b1f17b1804b1-438913cae48mr176319165e9.9.1737538230734; 
 Wed, 22 Jan 2025 01:30:30 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf321503fsm16019060f8f.12.2025.01.22.01.30.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Jan 2025 01:30:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 00/10] cpus: Prefer cached CpuClass over CPU_GET_CLASS()
 macro
Date: Wed, 22 Jan 2025 10:30:18 +0100
Message-ID: <20250122093028.52416-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Missing review: 1 & 2

v1 cover:
Use cached CPUState::cc to get CPUClass.
Main rationale is overall code style.

Philippe Mathieu-Daudé (10):
  hw/core/generic-loader: Do not open-code cpu_set_pc()
  gdbstub: Clarify no more than @gdb_num_core_regs can be accessed
  cpus: Cache CPUClass early in instance_init() handler
  cpus: Prefer cached CpuClass over CPU_GET_CLASS() macro
  accel: Prefer cached CpuClass over CPU_GET_CLASS() macro
  user: Prefer cached CpuClass over CPU_GET_CLASS() macro
  disas: Prefer cached CpuClass over CPU_GET_CLASS() macro
  gdbstub: Prefer cached CpuClass over CPU_GET_CLASS() macro
  hw/acpi: Prefer cached CpuClass over CPU_GET_CLASS() macro
  target/arm: Prefer cached CpuClass over CPU_GET_CLASS() macro

 include/hw/core/cpu.h          | 12 ++++----
 linux-user/alpha/target_proc.h |  2 +-
 accel/accel-target.c           | 12 ++++----
 accel/tcg/tcg-accel-ops.c      |  3 +-
 accel/tcg/translate-all.c      |  2 +-
 accel/tcg/watchpoint.c         |  9 +++---
 bsd-user/signal.c              |  4 +--
 cpu-common.c                   | 10 +++----
 cpu-target.c                   |  9 ++----
 disas/disas-common.c           |  5 ++--
 gdbstub/gdbstub.c              | 26 ++++++----------
 gdbstub/system.c               |  7 ++---
 gdbstub/user-target.c          |  6 ++--
 gdbstub/user.c                 |  7 ++---
 hw/acpi/cpu.c                  |  4 +--
 hw/acpi/cpu_hotplug.c          |  3 +-
 hw/core/cpu-common.c           | 16 +++++-----
 hw/core/cpu-system.c           | 55 ++++++++++++----------------------
 hw/core/generic-loader.c       |  5 +---
 linux-user/signal.c            |  4 +--
 target/arm/cpu.c               |  3 +-
 target/arm/tcg/cpu-v7m.c       |  3 +-
 target/microblaze/gdbstub.c    |  5 ----
 target/openrisc/gdbstub.c      |  5 ----
 24 files changed, 76 insertions(+), 141 deletions(-)

-- 
2.47.1


