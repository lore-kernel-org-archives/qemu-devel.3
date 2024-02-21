Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB454C5478B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rctyh-0005KS-Ue; Wed, 21 Feb 2024 16:18:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctyb-0004rF-Bb
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:18:01 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctyZ-00012x-6U
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:18:00 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-512cc3ea7a5so2518049e87.3
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 13:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708550277; x=1709155077; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=27hOzulyzznR+8+N4cQ8+ljTXaEP/WvWvivYVWJzeRw=;
 b=kex/o3hY7dTIqeyR0VHiV5Uq41H7oL+U6aqLO8K0kz1ICVxCGYdI+4PVIjKj5BHR/z
 k+bhIgU+Kxe5nIzWzFSN/v3bBZ9NOXGyGxdjKKK9xa1B7lcxzFQWVvmGExuAc4nMzmab
 E8oZy2giWmhTM5RayoRBAzx6u9j0UHQIUJScGLzfmeocBRpsPz3al5EJyp9wYe0WKT0r
 pazQZX8MVkjqHDu8gZJ7rxobnMKa5nwlX+jFOKL6Wk4/yCZTGvbGCcRDLSDwu+n6NXl7
 zfgiAVWu7VQdglxQUReAK/VKGJ0qhG3bivrHbRJ6AzoBGaLdjQ8iM2b9r8cTt4LEWFmY
 u2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708550277; x=1709155077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=27hOzulyzznR+8+N4cQ8+ljTXaEP/WvWvivYVWJzeRw=;
 b=X4Qt/OUTnjpqwFl7nrkFABFiSBvHvbg/1AJ8vArvt/Uqj+Gb5yGyPAQgrugZmdR51h
 qa5GDzjrTFFkVxzmWxKAKDroUMTNSPnL5PvecO8t65j6DOCabRJBcE5QZaNc8LO+rlS8
 oOVPPVIsSi2qg6OQ4+sJt98C/ihSr3Qrz2DVGPTUZNdxZAhQFrmXZh0oHf97z9QEBeHI
 8dorgkSAoo14AywdMkOdFRpIppsMJ7egKWDkt2RJKPG2CgolbR6Tb1+POMadJGWw4N8X
 ZwUjwCMLYooDHij+vm9EXFqRVhMXoVftHf95W5UvZ1tR/rPxtU1xwfk9FaHfweHfRs+9
 ZBvA==
X-Gm-Message-State: AOJu0Yz8SM5NS9U8bTYl/VfdNV5r4k91hiSKhnYaoQB9bej80Nw0+bMZ
 jHxxBPZq9wxjTD36OKpQKDBszI8f7kiqpkGrIPlvcFN0Fc/25IDeyqXHcqz4LisWxHNJVJ9gwPL
 fgVc=
X-Google-Smtp-Source: AGHT+IFzT8wTP8E+HGgD4Or9PcIuXyyx4pxAfJb3U4WBWtEU/CCrqqqaxt+yChCdtBqiw70PgVh+SA==
X-Received: by 2002:a2e:878a:0:b0:2d2:3594:49f6 with SMTP id
 n10-20020a2e878a000000b002d2359449f6mr7329948lji.14.1708550277021; 
 Wed, 21 Feb 2024 13:17:57 -0800 (PST)
Received: from m1x-phil.lan ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 bs20-20020a056000071400b0033d449f5f65sm12676547wrb.4.2024.02.21.13.17.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 21 Feb 2024 13:17:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 10/25] hw/i386/pc: Do pc_cmos_init_late() from pc_machine_done()
Date: Wed, 21 Feb 2024 22:16:10 +0100
Message-ID: <20240221211626.48190-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240221211626.48190-1-philmd@linaro.org>
References: <20240221211626.48190-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

In the i386 PC machine, we want to run the pc_cmos_init_late()
function only once the IDE and floppy drive devices have been set up.
We currently do this using qemu_register_reset(), and then have the
function call qemu_unregister_reset() on itself, so it runs exactly
once.

This was an expedient way to do it back in 2010 when we first added
this (in commit c0897e0cb94e8), but now we have a more obvious point
to do "machine initialization that has to happen after generic device
init": the machine-init-done hook.

Do the pc_cmos_init_late() work from our existing PC machine init
done hook function, so we can drop the use of qemu_register_reset()
and qemu_unregister_reset().

Because the pointers to the devices we need (the IDE buses and the
RTC) are now all in the machine state, we don't need the
pc_cmos_init_late_arg struct and can just pass the PCMachineState
pointer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240220160622.114437-3-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc.c | 39 ++++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 3e9ca6295f..1733dffc00 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -465,11 +465,6 @@ static void pc_cmos_init_floppy(MC146818RtcState *rtc_state, ISADevice *floppy)
     mc146818rtc_set_cmos_data(rtc_state, REG_EQUIPMENT_BYTE, val);
 }
 
-typedef struct pc_cmos_init_late_arg {
-    MC146818RtcState *rtc_state;
-    BusState *idebus[2];
-} pc_cmos_init_late_arg;
-
 typedef struct check_fdc_state {
     ISADevice *floppy;
     bool multiple;
@@ -530,23 +525,25 @@ static ISADevice *pc_find_fdc0(void)
     return state.floppy;
 }
 
-static void pc_cmos_init_late(void *opaque)
+static void pc_cmos_init_late(PCMachineState *pcms)
 {
-    pc_cmos_init_late_arg *arg = opaque;
-    MC146818RtcState *s = arg->rtc_state;
+    X86MachineState *x86ms = X86_MACHINE(pcms);
+    MC146818RtcState *s = MC146818_RTC(x86ms->rtc);
     int16_t cylinders;
     int8_t heads, sectors;
     int val;
     int i, trans;
 
     val = 0;
-    if (arg->idebus[0] && ide_get_geometry(arg->idebus[0], 0,
-                                           &cylinders, &heads, &sectors) >= 0) {
+    if (pcms->idebus[0] &&
+        ide_get_geometry(pcms->idebus[0], 0,
+                         &cylinders, &heads, &sectors) >= 0) {
         cmos_init_hd(s, 0x19, 0x1b, cylinders, heads, sectors);
         val |= 0xf0;
     }
-    if (arg->idebus[0] && ide_get_geometry(arg->idebus[0], 1,
-                                           &cylinders, &heads, &sectors) >= 0) {
+    if (pcms->idebus[0] &&
+        ide_get_geometry(pcms->idebus[0], 1,
+                         &cylinders, &heads, &sectors) >= 0) {
         cmos_init_hd(s, 0x1a, 0x24, cylinders, heads, sectors);
         val |= 0x0f;
     }
@@ -558,10 +555,11 @@ static void pc_cmos_init_late(void *opaque)
            geometry.  It is always such that: 1 <= sects <= 63, 1
            <= heads <= 16, 1 <= cylinders <= 16383. The BIOS
            geometry can be different if a translation is done. */
-        if (arg->idebus[i / 2] &&
-            ide_get_geometry(arg->idebus[i / 2], i % 2,
+        BusState *idebus = pcms->idebus[i / 2];
+        if (idebus &&
+            ide_get_geometry(idebus, i % 2,
                              &cylinders, &heads, &sectors) >= 0) {
-            trans = ide_get_bios_chs_trans(arg->idebus[i / 2], i % 2) - 1;
+            trans = ide_get_bios_chs_trans(idebus, i % 2) - 1;
             assert((trans & ~3) == 0);
             val |= trans << (i * 2);
         }
@@ -569,15 +567,12 @@ static void pc_cmos_init_late(void *opaque)
     mc146818rtc_set_cmos_data(s, 0x39, val);
 
     pc_cmos_init_floppy(s, pc_find_fdc0());
-
-    qemu_unregister_reset(pc_cmos_init_late, opaque);
 }
 
 void pc_cmos_init(PCMachineState *pcms,
                   ISADevice *rtc)
 {
     int val;
-    static pc_cmos_init_late_arg arg;
     X86MachineState *x86ms = X86_MACHINE(pcms);
     MC146818RtcState *s = MC146818_RTC(rtc);
 
@@ -631,11 +626,7 @@ void pc_cmos_init(PCMachineState *pcms,
     val |= 0x04; /* PS/2 mouse installed */
     mc146818rtc_set_cmos_data(s, REG_EQUIPMENT_BYTE, val);
 
-    /* hard drives and FDC */
-    arg.rtc_state = s;
-    arg.idebus[0] = pcms->idebus[0];
-    arg.idebus[1] = pcms->idebus[1];
-    qemu_register_reset(pc_cmos_init_late, &arg);
+    /* hard drives and FDC are handled by pc_cmos_init_late() */
 }
 
 static void handle_a20_line_change(void *opaque, int irq, int level)
@@ -703,6 +694,8 @@ void pc_machine_done(Notifier *notifier, void *data)
         /* update FW_CFG_NB_CPUS to account for -device added CPUs */
         fw_cfg_modify_i16(x86ms->fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus);
     }
+
+    pc_cmos_init_late(pcms);
 }
 
 void pc_guest_info_init(PCMachineState *pcms)
-- 
2.41.0


