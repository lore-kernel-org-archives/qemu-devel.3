Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFCC2C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 21:02:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjllz-0003FU-Q2; Sun, 16 Feb 2025 16:01:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjllu-00037x-KQ
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 16:01:50 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjlls-0007wH-1C
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 16:01:49 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43963935585so36582625e9.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 13:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739739706; x=1740344506; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f2SZToQUGAon9B+NPJXa9k1BqlC2qKJH86P1xDJbKio=;
 b=MjPXibZrEzX6WvzpTo/cupGjFvP6w9YrsM4BJapAH8PHKk+Bp2lcnrv7cgsZCloXbF
 KHo5w18RJa/nzXjuY6AP2/bxtmQXqFXvvjL+fT6/DuIU7x0ctYABSKqUaFw3RS8KLI+P
 KkcgcfUnMbhbDincJ6fSeQFDQVzizHwWsgu20knyAo9XREmKdNNvgwRRKCgYbqYKH9Yn
 KE6RRbE63SLy7/zMBUB1D1TCHTbO/L3LWkdUmDtt9gn0DecUW8CDCTmUit/h8ooj6d68
 tprYlYP2HxEMfeDkKnFyuQzAELQ4EOpTW77xYRmYwd1j0pjfU2AX+fm4hHq7X4G7cU3Y
 /qYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739739706; x=1740344506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f2SZToQUGAon9B+NPJXa9k1BqlC2qKJH86P1xDJbKio=;
 b=u3LLw3PYCAeAWPeZ/ZV+juUjoECCtAoKjsfaxNSRbBMK4AP4iPSVRRmDV4aTJZI0zI
 5X6/qxT3Di2mj5IJNYGxG7QSY6bg38BU+NYfU0bPxTqXTwm74c6uK6pgmOyhAML0MkMv
 r/YRTCt56MBTZNgMxwkZrLLYY+FzCPz8X2hSCCIqnlOBt7AiMV3fTZCLr54dE0nDRdOC
 JI2c8agHGQgqJropWw+7psHIqZZ7MXJqhtEEZ2woZbNGRxp/TuCJCxiI0GK0hREFy/r5
 atmdtyYVIY2LnvjsfM0cg/bC42EKhrNyGKI7S7pg7BB9lqnbGI8cFPx8+cm/otw/Rna2
 MudQ==
X-Gm-Message-State: AOJu0YzQooIeoDYs+UqQAwNLcYufHRpmmSF6L2TFQ9aAiFisFArWklQh
 NnRK6qCEXs/IUWJnfgHNfeMjItU05QvD4cu6UhWueNHo0/UFmyCmZ3VPgq3CPOQ2mpGL/0VWeBc
 uIXQ=
X-Gm-Gg: ASbGncum9Z8wYOMRJwoNXv/aR7p6GQHLcTZ8aSKVp/e9nk1HThxmq2AV90uXsHnjga0
 3/1QVhKfu1MDPvbgQirDPmbH9I6POS8eLERHmOtD+ap24mHySf2Lzh1CXfIeutHkvIU2fJNGC9A
 oRIqDdZ0ZTJshM2OI2UZT/V353k6uRlsIL2e84TGmTgV8KOpF/Jv16dfV097OOEoX/YrjvfcK5D
 v05Ii3YtY8wVjtap90g8e4tzTrpGwJyMK2q5zyVn2z3Y5ycEqIYgSFwIxvMkMgqLTb6QiLOryvp
 wLg33A5kPiwOqAximnrr5NSLvPAK67ShiQ/mP6bjhzPh2+vQ5B7Qb6aFGURmHTIDi17YljM=
X-Google-Smtp-Source: AGHT+IGkdOzMH8hw/qjzMvNzTmuOZ7PVnyVu3Vl2rUrVbTMzUj+Ea88ptOoNWxNcCKWMq2aqdDTauQ==
X-Received: by 2002:a05:600c:4711:b0:439:60ef:ce88 with SMTP id
 5b1f17b1804b1-4396e710d27mr71142705e9.23.1739739706082; 
 Sun, 16 Feb 2025 13:01:46 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439618264a3sm102167645e9.23.2025.02.16.13.01.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Feb 2025 13:01:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 36/39] hw/mips: Mark Boston machine devices as little-endian
Date: Sun, 16 Feb 2025 22:01:00 +0100
Message-ID: <20250216210103.70235-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250216210103.70235-1-philmd@linaro.org>
References: <20250216210103.70235-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

The Boston machine is only built as little-endian.
Therefore the DEVICE_NATIVE_ENDIAN definition expand to
DEVICE_LITTLE_ENDIAN (besides, the DEVICE_BIG_ENDIAN case
isn't tested). Simplify directly using DEVICE_LITTLE_ENDIAN.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250212113938.38692-3-philmd@linaro.org>
---
 hw/mips/boston.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 364c328032a..4690b254dda 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -220,7 +220,7 @@ static void boston_lcd_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps boston_lcd_ops = {
     .read = boston_lcd_read,
     .write = boston_lcd_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static uint64_t boston_platreg_read(void *opaque, hwaddr addr,
@@ -299,7 +299,7 @@ static void boston_platreg_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps boston_platreg_ops = {
     .read = boston_platreg_read,
     .write = boston_platreg_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static void mips_boston_instance_init(Object *obj)
@@ -758,7 +758,7 @@ static void boston_mach_init(MachineState *machine)
 
     s->uart = serial_mm_init(sys_mem, boston_memmap[BOSTON_UART].base, 2,
                              get_cps_irq(&s->cps, 3), 10000000,
-                             serial_hd(0), DEVICE_NATIVE_ENDIAN);
+                             serial_hd(0), DEVICE_LITTLE_ENDIAN);
 
     lcd = g_new(MemoryRegion, 1);
     memory_region_init_io(lcd, NULL, &boston_lcd_ops, s, "boston-lcd", 0x8);
-- 
2.47.1


