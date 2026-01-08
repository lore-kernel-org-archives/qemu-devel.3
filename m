Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5BE6D1488B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 14:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdr61-00076E-Mz; Thu, 08 Jan 2026 09:34:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vdr5q-000711-Vx
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 09:34:33 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vdr5n-0000gM-Vr
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 09:34:30 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-47d1d8a49f5so21974595e9.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 06:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767882866; x=1768487666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xegit4ejNTk5f0W5DGBT7IrkTCynuOYYrskO3sfAUpw=;
 b=HLpPbAvlBYEuciJnAg7EivyOW+LuSPk3JAulHjUj09RdTwuxwJqy+ckyKgfQSqm0Mn
 TnHFPRYgvBzvZ69hx8hK/aQMYqiKQYJSuKUUCmSM5neGqYdePXVW2RAKi34QZWX/mf/+
 iEhbUMG61bMt5sVILtbC3+Px55YDKKObMy55yvl4QoE/HEv5S5vJiGjGJAgVnlnKOSKQ
 acPAo34zdYI9oO9wpnb74OzJEXUNLgDAUkRNXBWrXb7G8cpnwwC9bViqQ9L6dBG5B7i+
 /EZKJX4apDSpAUXdWD7z8T5J/kvqGxg81QcBtCWP+jy36vhekb509ezA4eY3repaNxtF
 q3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767882866; x=1768487666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xegit4ejNTk5f0W5DGBT7IrkTCynuOYYrskO3sfAUpw=;
 b=cI3xcjyGDZkKoJdmyPF4Mx9krWfeVAtousE8kwKrDI14m0TVgB5XL+P5apckwKUGxJ
 2S6Bg65OOf0rRWKKAlTbVlNGfTfKEsbAIUsk+44tIpYSjKvMr7vPjaJEgBMSKVaTyLe6
 4xFiZA4S4MUzTBjEnXcgX2jydHysobNrUIAPX2RrgYf6o7eiyMgK2IBwaPgGHZS3tvB1
 17ZbVZhzEBC5Yi+Zz0pQuY8nvadxmAqqLqKoweNDHYzB3165/OxpzUEX0qFeHr6ckX5V
 fk5H1a78mu0x7ByPo4R/Er0Xnx4TOmyiAqXXwON/XHPedFwRpVuGjHLr8JonM2teIe7r
 79Iw==
X-Gm-Message-State: AOJu0Yx/E1zFn0KCkPw80pJcPOMu9SJvnGnPLiZYRq7clpDWBt0EtzyB
 LeEPwxOLXePy4cMplIgmNiANjGnEzyqplruDyymbSucHPmmLlAezIFXCUjGQXqROJII=
X-Gm-Gg: AY/fxX6SKOt7paLH8DV4UX+uEryHnqQTZotUqPwuNv5KcuuOw9i5Lv4KFKALXk/LrJC
 x0QfP2LYjz0Egz/V/o2BdxxaC/pPenAUB1duCckL0kJGD8MTD/q/wIkuy5uTNSzztQ++9epFmfS
 f0o2cG8h/JH2HiBTYAuOXrGnyPIM9+1/rgQy7wAY2QCeyPxdxPKg6iQkbzafhJlQYFdrGkAE1nL
 XSzkL62ZUQzro9ocly5MoJ65/levl3o7+utvXgb0ZmfEaXr/0cz0rTu85jnzB/ZZ7KgsITdAEWt
 CRaxnAhSoEP674fg6YwS0mrr8ye8HmrUBuFVHN1Nz+mT5o2kEVbcoxWpoyVOwCfnQ1kYrHLFtUk
 KdWN7+Rx//V3W0iy0ARXOc57MLhbc4waRRc7JWBwMDSDB9utfJo9R1aF1SRunT+ih4OE3SZTZz3
 +t9KBHyPr7Sdc=
X-Google-Smtp-Source: AGHT+IEx+WjdFSQNuvpe/UppetDTRNkYuwVaL12fCmNTmDl4lE5Wr+4Uohf6JheTbqrvNh2aXPuT0A==
X-Received: by 2002:a05:600c:470c:b0:477:79f8:da9d with SMTP id
 5b1f17b1804b1-47d84b3b522mr82961925e9.24.1767882865921; 
 Thu, 08 Jan 2026 06:34:25 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f410c6csm167037385e9.1.2026.01.08.06.34.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 06:34:24 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 21A055F8ED;
 Thu, 08 Jan 2026 14:34:24 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Yanan Wang <wangyanan55@huawei.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Thomas Huth <huth@tuxfamily.org>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 03/12] hw/m68k: register a nextcube_cpu_reset handler
Date: Thu,  8 Jan 2026 14:34:14 +0000
Message-ID: <20260108143423.1378674-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260108143423.1378674-1-alex.bennee@linaro.org>
References: <20260108143423.1378674-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

This is a fairly simple migration to the handler. Alternatively we
could eschew stashing the value in reset_pc and just re-read the ROM
on reset.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/m68k/next-cube.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 26177c7b867..3d66f5e7607 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -16,6 +16,7 @@
 #include "exec/cpu-interrupt.h"
 #include "system/system.h"
 #include "system/qtest.h"
+#include "system/reset.h"
 #include "hw/core/irq.h"
 #include "hw/m68k/next-cube.h"
 #include "hw/core/boards.h"
@@ -1249,6 +1250,19 @@ static const TypeInfo next_pc_info = {
     .class_init = next_pc_class_init,
 };
 
+static void nextcube_cpu_reset(void *opaque)
+{
+    M68kCPU *cpu = opaque;
+    CPUM68KState *env = &cpu->env;
+    CPUState *cs = CPU(cpu);
+
+    cpu_reset(cs);
+    /* Initialize CPU registers.  */
+    env->vbr = 0;
+    env->sr  = 0x2700;
+    env->pc = env->reset_pc;
+}
+
 static void next_cube_init(MachineState *machine)
 {
     NeXTState *m = NEXT_MACHINE(machine);
@@ -1264,12 +1278,9 @@ static void next_cube_init(MachineState *machine)
         error_report("Unable to find m68k CPU definition");
         exit(1);
     }
+    qemu_register_reset(nextcube_cpu_reset, cpu);
     env = &cpu->env;
 
-    /* Initialize CPU registers.  */
-    env->vbr = 0;
-    env->sr  = 0x2700;
-
     /* Peripheral Controller */
     pcdev = qdev_new(TYPE_NEXT_PC);
     object_property_set_link(OBJECT(pcdev), "cpu", OBJECT(cpu), &error_abort);
@@ -1335,8 +1346,8 @@ static void next_cube_init(MachineState *machine)
         /* Initial PC is always at offset 4 in firmware binaries */
         ptr = rom_ptr(0x01000004, 4);
         g_assert(ptr != NULL);
-        env->pc = ldl_be_p(ptr);
-        if (env->pc >= 0x01020000) {
+        env->reset_pc = ldl_be_p(ptr);
+        if (env->reset_pc >= 0x01020000) {
             error_report("'%s' does not seem to be a valid firmware image.",
                          bios_name);
             exit(1);
-- 
2.47.3


