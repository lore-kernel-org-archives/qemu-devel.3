Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0847FC02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 14:25:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taFAT-0000Je-Cr; Tue, 21 Jan 2025 09:23:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taFAS-0000IG-3I
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 09:23:48 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taFAP-0002wm-Vj
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 09:23:47 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-436345cc17bso41072825e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 06:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737469424; x=1738074224; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=huBnZLMMoWYJ6yRI7yv6u3SXGmIuRg6gkaMshUEQcb4=;
 b=wf3kJWY2nzHFXuAKFGXVp+bjIkUfBgIzC6JWfyyzE8V5a8mEKk1/q+2HmbrzIUdtRL
 ahH03jR5fjKyld7zFTylCNDDfPrTnc6/bF6VOFyBhz4kUK5Dv1BtIA4viEadhvXdbYF9
 ULHthNGDW1/1MEx+CN4bppx2wmw7p26FRdxwpoD5fK22HL9VtO02PzoX2P9DKioWqt1C
 dZFrY7uOc7DlzfeguAQ3uUrvCVspN3tkvAzMNJVRIl8KzFXLnhpcA7629gnEYjmKg55z
 lMC47lhA5Gw2BhskEw/PwhjyJ2yPjbSlszHf/vn9lWYdfiur/DbTWzzLfKpZM/KsBkAj
 16aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737469424; x=1738074224;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=huBnZLMMoWYJ6yRI7yv6u3SXGmIuRg6gkaMshUEQcb4=;
 b=GbWI0BL3AtUqgHxpyfztSNi1qw8PCCBe9ZSRD/wDRCpek+KSTQGhWgDCj/8Tep3JpK
 EuYOB5Ykv3dmg93Hj4JRvIwjbsT7NpBKc6sLppPf407M7jH/AEOZPb/xEVG2tWrbB90p
 1GIqom1W+RptzQrYKmK8nbmgNBz6NFap62DvZaZVMoKOoG5t4AV6dxJ1blHbOKM+fMg/
 qm2MKm0xbqiZcnyh3204EOxaWGBQFSJHXEL1GewnF2NbHay4i1RC8BcMR4rJLgxw7ZFN
 Jyd/JJ0ppxDLJJd9QHjGMy8BDXV+B2sTSro8u6HtcxYD5bbjDufQ+9kebrPIvdZokuH7
 1JGA==
X-Gm-Message-State: AOJu0YxWdkNe2Oicl+Q1p9w9n1/lquuoKuHcIdPAYcLxyzZ2cJ61U7eI
 A99D9nvcI5qKltdm04Od4upSlGr9zEMtfn08hbdboixUWLtrJbEqNrhuDNIHl36fZzk43CDz0Ov
 wBDk=
X-Gm-Gg: ASbGncvH0DbHkDdiQqPgXAHX5ZgCBToItReR7B+xKhxiE2zSTsvPPWX7fxcuLJgpFQA
 aW9y8RrkMzvkh+RTlHyXXCqyZ4uouda8BsaL04oRz/JXvGH+2FJt4izHCW1RA8NKuflk09ec0+e
 g8H6rh7vP36Mq6EYUiazRGtVZJLBRXR+8ICp8reOA6AKlBgp/7km5lGEKqo3OnKVd+9aJ5f6zHf
 LsT5cvoQnWgVVrFN1TFMiKCNo6KLUbWwSQ03NOi9f/YHRZkbKieYB7aVdRo4O97K0Qnc7SLve4j
 3rBvqIwAgQkP39WkR7IVTApSTTfp5IhnfTCql7oOygWT
X-Google-Smtp-Source: AGHT+IENTRqkRL3QRIymaYWOvoK2ecbtBLz5P2eTuEdDsBRulofhxM0CiB5iXk4AtpEAwZvnBOSL5g==
X-Received: by 2002:a05:600c:1da8:b0:434:a711:ace4 with SMTP id
 5b1f17b1804b1-4389eca3ca1mr159671455e9.17.1737469423851; 
 Tue, 21 Jan 2025 06:23:43 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43890469ba8sm178907415e9.37.2025.01.21.06.23.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jan 2025 06:23:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 00/28] cpus: Restrict CPU has_work() handlers to system
 emulation
Date: Tue, 21 Jan 2025 15:23:13 +0100
Message-ID: <20250121142341.17001-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On user emulation, threads always have work to do, and
CPUClass::has_work() is never called. Restrict it to system
emulation, allowing to simplify a bit and reduce code built
on user emulation.

Based-on: <20250121114056.53949-1-philmd@linaro.org>
 "cpus: Prefer cached CpuClass over CPU_GET_CLASS() macro"

Philippe Mathieu-Daudé (28):
  target/hexagon: Ensure not being build on system emulation
  target/rx: Ensure not being build on user emulation
  target/tricore: Ensure not being build on user emulation
  cpus: Restrict cpu_get_memory_mapping() to system emulation
  cpus: Restrict cpu_has_work() to system emulation
  cpus: Un-inline cpu_has_work()
  cpus: Introduce SysemuCPUOps::has_work() handler
  target/alpha: Move has_work() from CPUClass to SysemuCPUOps
  target/arm: Move has_work() from CPUClass to SysemuCPUOps
  target/avr: Move has_work() from CPUClass to SysemuCPUOps
  target/hexagon: Remove CPUClass:has_work() handler
  target/hppa: Move has_work() from CPUClass to SysemuCPUOps
  target/i386: Move has_work() from CPUClass to SysemuCPUOps
  target/loongarch: Move has_work() from CPUClass to SysemuCPUOps
  target/m68k: Move has_work() from CPUClass to SysemuCPUOps
  target/microblaze: Move has_work() from CPUClass to SysemuCPUOps
  target/mips: Move has_work() from CPUClass to SysemuCPUOps
  target/openrisc: Move has_work() from CPUClass to SysemuCPUOps
  target/ppc: Move has_work() from CPUClass to SysemuCPUOps
  target/riscv: Move has_work() from CPUClass to SysemuCPUOps
  target/rx: Move has_work() from CPUClass to SysemuCPUOps
  target/s390x: Restrict I/O handler installers to system emulation
  target/s390x: Move has_work() from CPUClass to SysemuCPUOps
  target/sh4: Move has_work() from CPUClass to SysemuCPUOps
  target/sparc: Move has_work() from CPUClass to SysemuCPUOps
  target/tricore: Move has_work() from CPUClass to SysemuCPUOps
  target/xtensa: Move has_work() from CPUClass to SysemuCPUOps
  cpus: Remove CPUClass::has_work() handler

 include/hw/core/cpu.h            | 30 ++++++++++++------------------
 include/hw/core/sysemu-cpu-ops.h |  4 ++++
 target/hexagon/cpu.h             |  4 ++++
 target/i386/cpu.h                |  4 ++--
 target/mips/internal.h           |  4 ++--
 target/riscv/cpu.h               |  9 +++++----
 target/riscv/internals.h         |  3 ---
 target/rx/cpu.h                  |  6 ++++--
 target/s390x/s390x-internal.h    |  5 +++++
 target/tricore/cpu.h             |  4 ++++
 hw/core/cpu-common.c             |  6 ------
 hw/core/cpu-system.c             |  6 ++++++
 target/alpha/cpu.c               |  4 +++-
 target/arm/cpu.c                 |  4 +++-
 target/avr/cpu.c                 |  2 +-
 target/hexagon/cpu.c             |  6 ------
 target/hppa/cpu.c                |  4 +++-
 target/i386/cpu.c                |  8 +++-----
 target/loongarch/cpu.c           |  8 +++-----
 target/m68k/cpu.c                |  4 +++-
 target/microblaze/cpu.c          |  4 +++-
 target/mips/cpu.c                |  4 +++-
 target/openrisc/cpu.c            |  4 +++-
 target/ppc/cpu_init.c            |  4 +++-
 target/riscv/cpu.c               |  8 +++-----
 target/rx/cpu.c                  |  8 +-------
 target/rx/helper.c               |  4 ----
 target/s390x/cpu-system.c        | 18 ++++++++++++++++++
 target/s390x/cpu.c               | 18 ------------------
 target/s390x/interrupt.c         |  8 ++------
 target/sh4/cpu.c                 |  4 ++--
 target/sparc/cpu.c               |  4 +++-
 target/tricore/cpu.c             |  2 +-
 target/xtensa/cpu.c              | 12 +++++-------
 34 files changed, 114 insertions(+), 113 deletions(-)

-- 
2.47.1


