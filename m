Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0376AE9A055
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 17:20:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt7fW-0005Rr-SP; Thu, 19 Feb 2026 12:18:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vt7fO-0005Li-L5
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:18:18 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vt7fL-0000QG-Ty
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:18:18 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-65baa72399fso1622977a12.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 09:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771521494; x=1772126294; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tmInN0JteBeMKRB6GTa7UJFQ9ygY8v6TAwibYQDcB7c=;
 b=gNdPaKEmVv1lmFM13V7qEEktc0Kj9TrTuGt/Z2N4p8CGjCPQ33/JVdyf+KVVT86/4g
 P8gYPIyrBvH6JkkgrD78URmSEQJsVlH+b3BfDpwME35PlA/fI+eb2j+kdil945/Hp5/M
 xp78io6n1X9HMNBad1bCWCiLYhh+RJLVPtU66CdpFesTt2hlHp82G/cv6e8vQ2SGA5kH
 9i0OY8jy3j5zZ3ZGzRUuxy9sZNrOAYUcNPjzxa4NWdZzshEW/jytIMTzu9Vaz/srq8CT
 TfxwwS7BH9st1EHKwSAlErxkvn73QLWRcdjJQWJFc2O9inMvr4y+vvW1f5M+SdV9ioWs
 H8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771521494; x=1772126294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tmInN0JteBeMKRB6GTa7UJFQ9ygY8v6TAwibYQDcB7c=;
 b=GcaAclI90WMqu30DRv332YqBsp2zeNXYkpGfUFn+QmWkOwq3XfHP/tU8kfeYdWjFYP
 VYxB1RK9wBpOmFRpDaPJGRM9MkYOMm/hPaNv+gMv5SBgl+0BCwoe1L3xA8+kUoZ7nuqh
 MCcJESgCs8qIwfIcseQs68ynXfO4YIasA6Dm8rQbqoH9NBMizz74Os1SlAc/CUhacJra
 o7ChJKMWIsYxuSiUKM7JfULhvMbn1Bl9JT1Z5lcT24vL9rF1f4osAvXghdxsFIFACjIN
 wDWJ5THdFoqLyv0AdsfWtgx50RotHH/Xa3FtfDbHktDpdoq11T8UOgpPh5/8HDLz6FWA
 wZuw==
X-Gm-Message-State: AOJu0YyJ+QRHqu1uqEe29EBMhmY+xeDcKH/F789jUXJrh5XJNO/xCK0e
 cMiZPF2ZdymiP/tUKyzPEmUrJAbtrwRcNLREdVt8T02P8Q7Yu/Zm9T/PRUnubpkEfm6Hh3ha16Y
 NZM7g
X-Gm-Gg: AZuq6aIdMKVIJonlFYuzrIoxf3I5I7kWkDmXN/h2y0FOH3CdeIpKvmqfXxl4i3DLR9p
 8jVD/buj00SXn5uKP2AWSD8n+0VNHB3KrB4CKjlX7edwnOVfBXjRUqePI1mZ9gyAPZ3DrW+oVY0
 zVbbdR8NhjKqMUCHVCLJeYUnkc2qxJsttouB4XkiUe4t627ijKAXJ90tSe1HoweXkk76lm4lhAD
 tTWkx72QUwyKNbOYtwdeTGXn2HcZjZJLEIYr+Q8XTprx2Fhl+sgkM8aZSvpT1airS/J/Gqc8TpK
 IDGC+DGF0zeE3r70ab79xitdjZTjWiddUi/+embfswQGxr3dEA0Tc+5L72PVPPlqrLs4gcD27/M
 8TaWdCoD8tJ/PRxXr3qOpR2T8KgINYG+XgpPmdWwkqoF8zWW+QHZQOSQNfKv3ItY/rWl1yl4iEm
 keTRwif7U45ZP+xVpCkOdTcL8=
X-Received: by 2002:a17:907:728d:b0:b88:47b4:7626 with SMTP id
 a640c23a62f3a-b8fc3b66536mr1139397566b.27.1771521494227; 
 Thu, 19 Feb 2026 09:18:14 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8fc7385f5dsm591973166b.20.2026.02.19.09.18.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 09:18:11 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DCF205F8BA;
 Thu, 19 Feb 2026 17:18:10 +0000 (GMT)
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
Subject: [RFC PATCH v2 04/14] hw/m68k: update nextcube to 3-phase reset
Date: Thu, 19 Feb 2026 17:18:00 +0000
Message-ID: <20260219171810.602667-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260219171810.602667-1-alex.bennee@linaro.org>
References: <20260219171810.602667-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - re-written, tags dropped.
  - favour cpu_reset over resettable_reset(cs)
---
 hw/m68k/next-cube.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 26177c7b867..b10129dd9d7 100644
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
 
+static void next_cube_reset(MachineState *ms, ResetType type)
+{
+    CPUState *cs = first_cpu;
+    M68kCPU *cpu = M68K_CPU(cs);
+
+    qemu_devices_reset(type);
+    cpu_reset(cs);
+
+    /* Initialize CPU registers.  */
+    cpu->env.vbr = 0;
+    cpu->env.sr  = 0x2700;
+}
+
 static void next_cube_init(MachineState *machine)
 {
     NeXTState *m = NEXT_MACHINE(machine);
@@ -1266,10 +1280,6 @@ static void next_cube_init(MachineState *machine)
     }
     env = &cpu->env;
 
-    /* Initialize CPU registers.  */
-    env->vbr = 0;
-    env->sr  = 0x2700;
-
     /* Peripheral Controller */
     pcdev = qdev_new(TYPE_NEXT_PC);
     object_property_set_link(OBJECT(pcdev), "cpu", OBJECT(cpu), &error_abort);
@@ -1335,8 +1345,8 @@ static void next_cube_init(MachineState *machine)
         /* Initial PC is always at offset 4 in firmware binaries */
         ptr = rom_ptr(0x01000004, 4);
         g_assert(ptr != NULL);
-        env->pc = ldl_be_p(ptr);
-        if (env->pc >= 0x01020000) {
+        cpu->env.direct_kernel_boot_pc = ldl_be_p(ptr);
+        if (env->direct_kernel_boot_pc >= 0x01020000) {
             error_report("'%s' does not seem to be a valid firmware image.",
                          bios_name);
             exit(1);
@@ -1355,6 +1365,7 @@ static void next_machine_class_init(ObjectClass *oc, const void *data)
 
     mc->desc = "NeXT Cube";
     mc->init = next_cube_init;
+    mc->reset = next_cube_reset;
     mc->block_default_type = IF_SCSI;
     mc->default_ram_size = RAM_SIZE;
     mc->default_ram_id = "next.ram";
-- 
2.47.3


