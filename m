Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD99CC0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 17:02:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbjXj-0006nm-I6; Sat, 25 Jan 2025 12:01:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbjXH-0006Rc-1K
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:01:38 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbjXF-0000NS-HL
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:01:30 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-435f8f29f8aso21806595e9.2
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 09:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737824487; x=1738429287; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3hYPVAzpnJ23ZkjHGBfSkrx4kDLIP1Cp884q0U/4z1c=;
 b=qOxRVnLINdBw4ByoWSHXLXcL17oKMxrPbkFjKTytu4Gh6BJ/aGeBPdo7ds+WkeIRE/
 ZCojnU2Em+4nHr9QS1hxDwlcqvYM62LPhlV2ykCp0BEsoFXGkHF8KcIK8o28ZFFX0ANL
 gbDFrS6K26mmrTTBFQNJI+pUX/sZZCbTpFGFMqTT4XKDtrSipfYyFADZDg7pK5/8l5xk
 WfO375/rJG5n/m1SaoVC11cRWeRDTDTBadE/dAlyQGib/TVcUO8lXrnFoY8grkSyJSYy
 xrGQZI7Nx8pmwERGEufwWN8c9r5RPiQ+lCWPgPhBdmMHVj9xMDlDVOLUqacacCk4pQIr
 AT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737824487; x=1738429287;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3hYPVAzpnJ23ZkjHGBfSkrx4kDLIP1Cp884q0U/4z1c=;
 b=A5+tuD3U14q+MGlGgyyi+OpqAgh1j7aM+XZImyxGex4VwBR4wRm1E/9WeBo4R4eJpC
 GvugvlvVRFKTgCKHQakSUIAPhFKGGgKcpeSTKt2XFjH23TONl+ts6p/667yY3JXjiyRk
 TPkaHUHIpx1EnPFhx70f3Z72fBOimaaZnnQhtYf+YYcvTXUDCcm0ztLXHOcSt6vPIwxv
 aQrITIBLiCx1YNVYpw7KsDdZQfVs2iiUUbT3PXDRo6XSNIO+gx6eBxmFKx57NkH2qj5C
 NQmu5+2Qd5Qiv1e/7JP84t5otw6lwePyDZ9gw9MUl9dWvF9sL6hVxpwcYl530qjXSf6v
 dGBA==
X-Gm-Message-State: AOJu0Yx4v5VESNJkxOu3yeq4xvNSyoUX9KysdJlPfhEbQze2+xn7U5cI
 6tdBpXR3VL0Zi+Pnc4ptq2BCK77ZrcqP3k3ZBO3JdbZMEanCaYUqSshS7cSMnMHHzBUeQcXc7gN
 s694=
X-Gm-Gg: ASbGnctvMYhvgxJAQC4255ShVBq7lV9Ma0xa7D9bV60MoXLYAqggyt307FR3mM4QnB0
 nCzWBgGjhyChGwRBV8rxzmW6V0HtGDQPgBbb0t34/A18MEEI+tKcnk4EDeQ7+dpfEURnMtGeP8k
 E4PPkfNFhXmMpaDD0krQyn5iR4Mh6CNGoKtVZIJM+WxDrXX7aANSHUE5pv62rWGmqYgvX1feLAF
 8V8iyQaZBYd/DzlPxWvk5v0W8UKyaFZtYa1OCMnV3P+2jMYMPEX7Vm0wifHifoP7/hIfrl7bFLN
 WHcW3Y9ssYLNuNnCf2iOySr/LXCxslJdppgHH0Eikf+27Y7wlOYH/5M=
X-Google-Smtp-Source: AGHT+IEoy6yXoECX+NuuVn7nIpfOgcwdzkCF8JNluAVk3TpkSaCDMEPhYYWsuFG0daBnM6mi0QLCgA==
X-Received: by 2002:a05:600c:4f8e:b0:438:ad4d:cf01 with SMTP id
 5b1f17b1804b1-438ad4dd129mr239994775e9.7.1737824487478; 
 Sat, 25 Jan 2025 09:01:27 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd501f1esm66511965e9.12.2025.01.25.09.01.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 09:01:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 00/24] cpus: Restrict CPU has_work() handlers to system
 emulation
Date: Sat, 25 Jan 2025 18:01:01 +0100
Message-ID: <20250125170125.32855-1-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Missing review: 16

(I plan to merge this myself once reviewed)

Since v2:
- Check mandatory SysemuCPUOps handlers in class_post_init()

v1 cover:

On user emulation, threads always have work to do, and
CPUClass::has_work() is never called. Restrict it to system
emulation, allowing to simplify a bit and reduce code built
on user emulation.

Based-on: <20250125165855.32168-1-philmd@linaro.org>
 "qom: Introduce class_post_init() handler"
Based-on: <20250121114056.53949-1-philmd@linaro.org>
 "cpus: Prefer cached CpuClass over CPU_GET_CLASS() macro"

Philippe Mathieu-Daudé (24):
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

 include/hw/core/cpu.h            | 27 +++++++++++----------------
 include/hw/core/sysemu-cpu-ops.h |  4 ++++
 include/hw/core/tcg-cpu-ops.h    |  2 +-
 target/i386/cpu.h                |  4 ++--
 target/mips/internal.h           |  4 ++--
 target/riscv/internals.h         |  4 +++-
 target/s390x/s390x-internal.h    |  5 +++++
 cpu-target.c                     |  8 ++++++++
 hw/core/cpu-common.c             | 12 ++++++------
 hw/core/cpu-system.c             |  5 +++++
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
 target/rx/cpu.c                  |  2 +-
 target/s390x/cpu-system.c        | 18 ++++++++++++++++++
 target/s390x/cpu.c               | 18 ------------------
 target/s390x/interrupt.c         |  8 ++------
 target/sh4/cpu.c                 |  4 ++--
 target/sparc/cpu.c               |  4 +++-
 target/tricore/cpu.c             |  2 +-
 target/xtensa/cpu.c              | 12 +++++-------
 31 files changed, 113 insertions(+), 94 deletions(-)

-- 
2.47.1


