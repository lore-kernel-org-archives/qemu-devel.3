Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51035C0218D
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 16:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbifd-0004ET-SE; Sat, 25 Jan 2025 11:06:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbifa-0004CW-8J
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:06:02 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbifW-0000Wu-7f
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:06:00 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4364a37a1d7so31407845e9.3
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 08:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737821155; x=1738425955; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cAEts8XBE/w/GzcQyp/3lTov0Q8D1trvAtx7Nn9aaUk=;
 b=a8j7RB9tBpLsljUQb94Fv4DHvkBA/qm9OTg/Or7Kmr5tQrlgwF0N0xhANeZve18hzb
 5KFpt+UW+oTBTBM2WId0LUf3D4aId5vxWDNsp5B29B1AVGMZef6i/7BoaCHluVjTfheF
 AsVs4idAQVfJZPfp8v0DY4A3rKtedP3iXlnsSyt1sugrf5G/t8HbNyBG9o6w4tmacKHQ
 6pVv2kpORQwO/Ynkh4lwMpYe2Hw6JvdyH+vjunLGv2hMGEvD/1NgL9RkQoYjqJmeiECt
 fTa8FO7DRA6OG3+2FesWS4mCapzYz6AxiHeWIxKstOF54jjGybqJ5F3lMT0ZfjgajFK1
 h0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737821155; x=1738425955;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cAEts8XBE/w/GzcQyp/3lTov0Q8D1trvAtx7Nn9aaUk=;
 b=L3gw4lG72G7mjZk/63cNzvLTsOW1pZN0fnRfq3Cuz+P6GARmRwW9UidcPu3ZfGxanz
 bsNQAzM2ArQAeste8sjYlYoefY7AP90VdS+GmQ/QzqKV95UT11ywHrsfvtiKPF7owAY1
 OKk+mD86kRYobq9XMbgTkoS/UtCgF3qoabqZMWEIda1Vc4KN8ZbZQMLbFVF47HLno5co
 1suRUCquBzSEPk6gX+WHTuO39AxnsumlNz13CDxEd6ALtuVTC8a1pGO6rAGpOPAsr11n
 EgEoxdQXCvKjVDMgVf2YS62a3bTa91+Cd83Sh+4g8hN/u0Zem6c0JvaCL4YZGa4+s7Xk
 B5CQ==
X-Gm-Message-State: AOJu0Yyew2CS2QuJrOGY4y1NdidoLiB/dKll3xQIDxTiuZA5ttNCqISs
 dt21GL6gOIuu7ypYQlzj7ZkD0U5Ealxbo/k+fgLVtcKB1HydDvCp/ee9Ww6sowOGtTLsya59LB3
 bSwg=
X-Gm-Gg: ASbGncvZcNshLcJvRHiHd174IH+wLv3+PoEopN8niVVF0mUuwXiNjsyjQ0aaANLXkWF
 41iFkumNYTmmUYyh1V3I7bcDH/fCGFLFrrUldqLtiF75dk+UOjXhSPj46ydZrEVMxijN6I2I8Af
 gVsIiZcBJPlLDbGxqgGHnJbX2CQHPJRgkcX6al+ponacvy/3wcocTRbbkh9DPyEoYG3AwMAG6Bn
 2dtrybF8XP3CVLj7TSjDWPed6KcaBU7W8elxXEleKLp+1O03TxeW/hitlYfKm8f6HnFpUWhOfbP
 LOZjV8oGij4QbC9NZn2UAom4FRN4NwlU4H0R64AcY5AfkkH/x83bJmHymb+x
X-Google-Smtp-Source: AGHT+IFCNrYv9sKsYzYaDbLUoq50wx+ZfqCvZzKXA3crLPOdsHzHntC84LlSb8aTw2dg1FUZBqtCnw==
X-Received: by 2002:a05:600c:468d:b0:436:4708:9fb6 with SMTP id
 5b1f17b1804b1-43891437546mr291149795e9.20.1737821155461; 
 Sat, 25 Jan 2025 08:05:55 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4d3393sm64694735e9.37.2025.01.25.08.05.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 08:05:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 00/24] cpus: Restrict CPU has_work() handlers to system
 emulation
Date: Sat, 25 Jan 2025 17:05:28 +0100
Message-ID: <20250125160552.20546-1-philmd@linaro.org>
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

v1 cover:

On user emulation, threads always have work to do, and
CPUClass::has_work() is never called. Restrict it to system
emulation, allowing to simplify a bit and reduce code built
on user emulation.

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

 include/hw/core/cpu.h            | 26 ++++++++++----------------
 include/hw/core/sysemu-cpu-ops.h |  4 ++++
 include/hw/core/tcg-cpu-ops.h    |  2 +-
 target/i386/cpu.h                |  4 ++--
 target/mips/internal.h           |  4 ++--
 target/riscv/internals.h         |  4 +++-
 target/s390x/s390x-internal.h    |  5 +++++
 cpu-target.c                     |  4 ++++
 hw/core/cpu-common.c             |  6 ------
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
 31 files changed, 102 insertions(+), 94 deletions(-)

-- 
2.47.1


