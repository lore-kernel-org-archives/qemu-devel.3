Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71698C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 18:00:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rag1a-00064r-EN; Thu, 15 Feb 2024 12:59:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag1P-0004tx-VB
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:59:44 -0500
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag1N-0001ou-NG
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:59:43 -0500
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2d0e5212559so14438451fa.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708019979; x=1708624779; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+yletPVGxCa3h+9fKZJUuwx/+JgKNE8xagr9A+vDkAQ=;
 b=nXcj+rQMG6vw+E98opsk+Hg+m0ph7Y5vJ78Z88k50ciCUvb3ckWc8bgYIQYGeInMg1
 8sJgMYPM+1I2mTviW0A19IRVSXnGynd8CmN7pWVmUlaINhyGkJz7GnMjERNCZfeePLkb
 iA/6BpqjdJ8o/LEQaPnjW+/LNKRNy3n+Ud9jFWAREWKmfCmakaquvsFWvM9zYzQzSyxu
 ka6wyQtn4BXFB3D5UPtPAm2WSxRJi2PycXhJMJV8nGffX4DYsFrrHeb6ceH+X9dvgdJI
 ikY4E6f3zwDiQuHaFppf8PZsc9No30OUelFpltwPicGzRoSgIwUSel5z/76UycGxjpP7
 OrIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708019979; x=1708624779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+yletPVGxCa3h+9fKZJUuwx/+JgKNE8xagr9A+vDkAQ=;
 b=uUYj2rIUSw2YHI39EN5PuTd6LhVasdPknQRE8pU/4Gja0ngbsWe0EdLABUobKSnQtW
 TDYo5WTId1DdLjybqHzL/Gscr/ZowZBSSr6Hvg7F4XNja5dbK0VawUAZWd0NWoAhr9M4
 F2JF+qRj5ILmaq4n4g0TuM954VwQnNFxef6UG3OJFgF6BJnOYhGH47HRdkp/tNLHxBs9
 Er79WCaoYmGQ40eF+oneuP80wPCgbcHjucJDhumI+vLQLwbl/Te0RW5pUbZ3e6kzkrpK
 DH+5Uos6R/YiJEEt0x0f5fJqzj/fBDely8oUwHWkSmwRS9hxprb2KGuxw+ytoRoXoX2d
 3lkw==
X-Gm-Message-State: AOJu0YyRUQTppSlwLxR1Wm9Y2d5wxU+NxAPNvUXesdqzCOZDPXUJvwGL
 Wr3DuMKIZNKqb/ZS6ZDJDpwmBf3vk20jsY/xCd7C6K9NeYusfrcynGgqdQ9AMHsKasYRMgLg5/U
 NIDM=
X-Google-Smtp-Source: AGHT+IF66rV3aU3g4fgzulsr7GiHI4mOnV3F/89y5fF2Iq1ZQG9pE1UIZefq13qOMjYnmsnK1ivRBw==
X-Received: by 2002:a2e:7e0e:0:b0:2d0:9902:16 with SMTP id
 z14-20020a2e7e0e000000b002d099020016mr1744614ljc.17.1708019979263; 
 Thu, 15 Feb 2024 09:59:39 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 b20-20020a05600c4e1400b00411a595d56bsm2868021wmq.14.2024.02.15.09.59.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 09:59:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 16/56] hw/mips/Kconfig: Remove ISA dependencies from MIPSsim
 board
Date: Thu, 15 Feb 2024 18:57:10 +0100
Message-ID: <20240215175752.82828-17-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215175752.82828-1-philmd@linaro.org>
References: <20240215175752.82828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Bernhard Beschow <shentey@gmail.com>

The board doesn't have a working ISA bus, only some I/O space.
Selecting ISA_BUS and including hw/isa/isa.h is not necessary.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20230109204124.102592-3-shentey@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240213155005.109954-4-pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/mipssim.c | 7 +++++--
 hw/mips/Kconfig   | 3 +--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/mips/mipssim.c b/hw/mips/mipssim.c
index 16af31648e..a12427b6c8 100644
--- a/hw/mips/mipssim.c
+++ b/hw/mips/mipssim.c
@@ -31,7 +31,6 @@
 #include "hw/clock.h"
 #include "hw/mips/mips.h"
 #include "hw/char/serial.h"
-#include "hw/isa/isa.h"
 #include "net/net.h"
 #include "sysemu/sysemu.h"
 #include "hw/boards.h"
@@ -206,7 +205,11 @@ mips_mipssim_init(MachineState *machine)
     cpu_mips_irq_init_cpu(cpu);
     cpu_mips_clock_init(cpu);
 
-    /* Register 64 KB of ISA IO space at 0x1fd00000. */
+    /*
+     * Register 64 KB of ISA IO space at 0x1fd00000.  But without interrupts
+     * (except for the hardcoded serial port interrupt) -device cannot work,
+     * so do not expose the ISA bus to the user.
+     */
     memory_region_init_alias(isa, NULL, "isa_mmio",
                              get_system_io(), 0, 0x00010000);
     memory_region_add_subregion(get_system_memory(), 0x1fd00000, isa);
diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
index ab61af209a..afcfb2b8ec 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -6,8 +6,7 @@ config MALTA
 
 config MIPSSIM
     bool
-    select ISA_BUS
-    select SERIAL_ISA
+    select SERIAL
     select MIPSNET
 
 config JAZZ
-- 
2.41.0


