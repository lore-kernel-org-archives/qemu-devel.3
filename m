Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E610DC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 16:08:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcSdb-00025r-Ik; Tue, 20 Feb 2024 11:06:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcSda-00024E-2B
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 11:06:30 -0500
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcSdX-0005En-Ik
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 11:06:29 -0500
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2d23114b19dso31699451fa.3
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 08:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708445186; x=1709049986; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fbwlnbkTELmw0yuCS8YQeiT81oI84UQospsJeFLv0YU=;
 b=nJ4ap+3Scjx3YWWryHjsn/arO4mJ3aWqlLktScKPo8/4AFLhpmWDmimA32SiLgFOdz
 8FyXCzBWaVLm9pw4JWrlLU4apu6vf0VYPwGUYSATnPCOBQroLaGPt8x25lz9yNRjdsYx
 brACJu/eoAdI6CHdKFXajFlmV7Ax3EGWOaBbnRV1iES8T9peOjqW0Iy6IPPoyOOlxtDr
 mHsaYp67vhp3ncd7AScEIGQLoofeRaIsTEPzw/lVD1B5nTqRqlAiqrU9/zhFy4bzRARb
 cjHFMDPqDBdUIdDTDSJYiDw/ZKaawYror9HcH5WLmhZ/IKyn4vNO8cZvKrggnkzxmLyR
 erKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708445186; x=1709049986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fbwlnbkTELmw0yuCS8YQeiT81oI84UQospsJeFLv0YU=;
 b=L1uSzihshyLW/pyPs1oxj9bkVRySMpmxmXdU7fB/8wuyVlUO8clh+T6a5jYX0fxiRe
 6Hlyby8CykgFjK0wAVWUIXoet5dSL4ybHIsoBUwvwgRG8c5DkCJafsl1SNfnPiM0qNzq
 GhUnNZuJKNcy9Gj7mLJCfGcPvN+3Ho+97aKNS0qjqhqwBYsR8HG9fCBUDy7MirHFZpO3
 ZW2YSxglJuJ9UGvzbGzSUOESuAjwmN0JaGUQcuH/G6aLMsXrQCmKdznULjyNueGivtlL
 KAfoWVdg4f5OQjJvlVDiS2N/T/0RUVEk9J3hc1bmTsRxmQVdNpppxIESmeBGL+aIuq31
 BbkA==
X-Gm-Message-State: AOJu0Yw1Lq2gY5dVfe2nb/2vjrCD3rGrz+dEF7GrcZh1SMkK/uL5+CiQ
 pFg/bTxU8myJLoSjw/4qQphjXKZrD2Ki6St8LSGiwD2HrSj3KSpQ3FdHqEr9l3Bv2lSTwyXNJy2
 9
X-Google-Smtp-Source: AGHT+IEqgrymnA16eKPoYPJ9nEqD5pDnpQUglY2tnRRJJJWx4Yf1pQRqyLbb9uQif3AzgEOtdzX8Iw==
X-Received: by 2002:a2e:9446:0:b0:2d2:4c72:b24 with SMTP id
 o6-20020a2e9446000000b002d24c720b24mr1628879ljh.50.1708445185881; 
 Tue, 20 Feb 2024 08:06:25 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a05600c4e8800b0040f0219c371sm15299927wmq.19.2024.02.20.08.06.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 08:06:25 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: [PATCH 02/10] hw/i386/pc: Do pc_cmos_init_late() from
 pc_machine_done()
Date: Tue, 20 Feb 2024 16:06:14 +0000
Message-Id: <20240220160622.114437-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220160622.114437-1-peter.maydell@linaro.org>
References: <20240220160622.114437-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22d.google.com
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
---
 hw/i386/pc.c | 39 ++++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 8b0f54e284c..4c3cfe9fc35 100644
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
2.34.1


