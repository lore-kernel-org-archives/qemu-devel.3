Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B002E9A059
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 17:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt7fT-0005PN-3u; Thu, 19 Feb 2026 12:18:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vt7fP-0005M8-22
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:18:19 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vt7fN-0000Ql-Gh
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:18:18 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-65a3fdeb7d9so1569598a12.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 09:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771521496; x=1772126296; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Zd4Bit+n8F+fad2IoTdU9p0oAYOcGsBgNed8Vqbx5U=;
 b=gamCJvcRtaQTARmlCY7odq76JS3vR2S8B4PNyyLB/YbWT5vNMOIKCjuFBVXqRBevjO
 SmbteWI3u9qa/+x1TFE9JQxSK/R7iiBv8EnCRX8vQc7jlR5xJerPGcKdgmhJ024TwAIh
 A5YatbHxMWoQR7gAEX2RuC8pFdsuz7PHQdH1FEOutd4dL4zkXR4TGmntvptrGAxoG1yZ
 swj5pyO19o+5dBT+ZylCZrgzD7Nrh0e1xhzqa1qqtYs+F82y9aPc7dGia39Ej6KUeHCd
 oDFjv3GjUGn0g/0Q1BFUk9C6o3uen1ldtO8dd9ymjWvxbzW4TtqKJ3yLHAx/5yfgovg7
 FM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771521496; x=1772126296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8Zd4Bit+n8F+fad2IoTdU9p0oAYOcGsBgNed8Vqbx5U=;
 b=wPw9pMhC3opJtVTwsrrJvA1pKPEmC+jBfYbOrgwwmNlmLvqZG4WDed7GioF8Hc6pKt
 bn6RYbuxUV5oBI/Mfv6lFsimjOx2s4tLCbebwNKAcshX61r5wLOFDlBvcHzB5Hyw3dVd
 Kz/YKzwhwK1xkY35dRZFFqJwjsuoHun4vyJ2va3toOsCL9BRA95WVsCQZx8SoXCu31Il
 0vJnZmXIuZ3ADUEKNdBn+JaJrDjYebDNLZPlwFOSKt90Lgcn4hs+LfVuy2ABsDnrf9S3
 U7+IpbNZ1a86Zl6CgJd79GGJ4aQ1GoEomduG9Y2HrbDjqZQZWsbtdsjGieytseidF4ZV
 vCDA==
X-Gm-Message-State: AOJu0YyNhKLo42S3sAmqm/Ke26zevPFHflzzMSw2rQUlnL94IqLAKnjf
 J+oDa9ruym8olT9ryWY2WKC9kczVIKcCZhQSvvlZgE6EHI27cH2XiYSOy1GOAd1b43o=
X-Gm-Gg: AZuq6aIXEnHLHXgU5P+LHVuwNjCPjc9nszLkgvBgB6KOPcEPaIU8iWaPv2587JfEmdN
 3UQaOO/xDToq+VnyPDtiG/jWHjr1O/utRrytiKI/YkLQfCUhMduQj7kYu3RNRcRzP5AaEB7+ZkB
 X280MrP/KNjWnmzvwzGrx5lde51lasKoCe+Ea+I7vIbdb5vMOE7HgLXwY8rbeMoqwAnJ29an/BZ
 iIKjKd88kPEuUZIhSdFEuoJxkEsDYrEVqk1ZZB4AoB0mGZfY94SVxLbdFjbKyPKJfbYRFrweTly
 xG1PYeL0PWNr/glLH/6/KoE8aIJRouVb+EOaOl6T+jhM8mAMm/9E+k+lZRch18E2SPLPDIJ4zGK
 zbP2vJWVla4P0+5KnhAsiVBRJs3lJ7cyen1OiyjzhKDfBlxkc+3vBVLgX82Cm96m1U79Wfnzz03
 GosJQfXy2Igv62HY1M9VNH9AM=
X-Received: by 2002:a05:6402:2709:b0:658:177a:292 with SMTP id
 4fb4d7f45d1cf-65bb118a752mr11484729a12.17.1771521495832; 
 Thu, 19 Feb 2026 09:18:15 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65bad4fac3dsm4178438a12.32.2026.02.19.09.18.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 09:18:15 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 14F7A5F8C1;
 Thu, 19 Feb 2026 17:18:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <huth@tuxfamily.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH v2 06/14] hw/m68k: update an5206 to 3-phase reset
Date: Thu, 19 Feb 2026 17:18:02 +0000
Message-ID: <20260219171810.602667-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260219171810.602667-1-alex.bennee@linaro.org>
References: <20260219171810.602667-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
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

As the mbar/rambar0 values are currently fixed we can migrate the
setting of them to the reset handler as well.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - re-written, dropped tags
  - favour cpu_reset over resettable_reset(cs)
---
 hw/m68k/an5206.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
index f92a5d6a339..509980db566 100644
--- a/hw/m68k/an5206.c
+++ b/hw/m68k/an5206.c
@@ -15,11 +15,25 @@
 #include "elf.h"
 #include "qemu/error-report.h"
 #include "system/qtest.h"
+#include "system/reset.h"
 
 #define KERNEL_LOAD_ADDR 0x10000
 #define AN5206_MBAR_ADDR 0x10000000
 #define AN5206_RAMBAR_ADDR 0x20000000
 
+static void an5206_reset(MachineState *ms, ResetType type)
+{
+   CPUState *cs = first_cpu;
+   M68kCPU *cpu = M68K_CPU(cs);
+
+   qemu_devices_reset(type);
+   cpu_reset(cs);
+
+   cpu->env.vbr = 0;
+   cpu->env.mbar = AN5206_MBAR_ADDR | 1;
+   cpu->env.rambar0 = AN5206_RAMBAR_ADDR | 1;
+}
+
 static void mcf5206_init(M68kCPU *cpu, MemoryRegion *sysmem, uint32_t base)
 {
     DeviceState *dev;
@@ -49,12 +63,6 @@ static void an5206_init(MachineState *machine)
     cpu = M68K_CPU(cpu_create(machine->cpu_type));
     env = &cpu->env;
 
-    /* Initialize CPU registers.  */
-    env->vbr = 0;
-    /* TODO: allow changing MBAR and RAMBAR.  */
-    env->mbar = AN5206_MBAR_ADDR | 1;
-    env->rambar0 = AN5206_RAMBAR_ADDR | 1;
-
     /* DRAM at address zero */
     memory_region_add_subregion(address_space_mem, 0, machine->ram);
 
@@ -90,13 +98,14 @@ static void an5206_init(MachineState *machine)
         exit(1);
     }
 
-    env->pc = entry;
+    env->direct_kernel_boot_pc = entry;
 }
 
 static void an5206_machine_init(MachineClass *mc)
 {
     mc->desc = "Arnewsh 5206";
     mc->init = an5206_init;
+    mc->reset = an5206_reset;
     mc->default_cpu_type = M68K_CPU_TYPE_NAME("m5206");
     mc->default_ram_id = "an5206.ram";
 }
-- 
2.47.3


