Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59834C61DBE
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 11:21:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzBfM-0004Sp-3j; Wed, 26 Aug 2026 07:19:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBfJ-0004Mq-LB
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:19:33 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBfD-0005gC-E0
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:19:31 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6a0de062db5so1466092a12.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 04:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787743164; x=1788347964; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LuCcXjHXrf83mUUXD5w1NFE3wBY+3o2UhexvMEmhWRE=;
 b=efJcoiVOn73GTP8fnBnAxPgEV9gr3fI0j0WWHHzQrq/0QA2uxMtSZm/1ZboeW08Qqd
 vJyBw8/AJxESnUbYKYJA+23ETAfZR8MMDLiENGejGPZLyCEXir2ctfDAvXF+ZEdDFxHa
 smIocBdugaT70FNfmtTmB5GZNZthxyxWUU29L5Fweo7/Ren7XkQw9WImTDZbFjtqV2zN
 run9Ftzog7ZNRstIhDSr5v8O2ZiND18R5SH31TTwNZORy2Dvmt/lx8tyLKrlxFK5F1xO
 /tKG2pAD9HESomnm4wuPL/a8p9WaZ/qNrbbDeDsVMycIe9FEucnDC+W9M4E4rEC2oEjW
 0wWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787743164; x=1788347964;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LuCcXjHXrf83mUUXD5w1NFE3wBY+3o2UhexvMEmhWRE=;
 b=dlpwyfj7JI29q1K0r8uGFltoT4fThkFm0DcShjbABw13Djdid4sWffHziLeVQFI2JA
 jfI72h9cDDjAVOsaDNTj4WaYaWTt20n1ikL7vFQeLEX/UCPvitQ1ypERbcwLDEZhZDyC
 JnhpQ2BRh2+S2W35ljZy63hKRMYdwPRbk+3pEjDWt2mHzwrY+LL6OTqMcy1UplgqpDDx
 SR8n/MlWvaqnfH0TH3zYJA6YQ454ICVRyB+V4COSk1d2DANWqIYGJMtDukOGmC3PxzUV
 5AGFZ8OOUonCcXGgB2tmvb0u4wHPscG48yJJpJbYqofztHsRrvEwV8H2FjItMLu59H+t
 3kPg==
X-Gm-Message-State: AFuF++kUJoHdtGGd24EWLeBic05tOw2krtr68OhcwkchuUEo4837EJLk
 mg9YX60Qe4rZsp/nF0flsM+UAJo0Xpk6IILvioezjXuyvfGdX7d1cTJG5CI2esuPi/ErTkVgcM7
 Q2ViH
X-Gm-Gg: AR+sD11b4k29Cm52SdAM+zTv2O1LnTDlevKxRIERUu+owMINJafwIWENVEn/7ShRPTg
 KLozVk2Pw2xVYlidECgtlmeQ0IdWrubcOmqUylejroCBpLi/6eJWb6pRkjx0hQ/JsUyRPt0Tct0
 3WRgvUB9k39u9w+itrU1HUizvbFNG3f/hAKtAriT047zWgKxsFrSL84DXlgMcjQNaGA7q9s5RGj
 /GzFuQwfymNGgHlZU2F6gxsy0GUpykHPQcCnGLi1bEO+BYowDd87e35aESrEvoE7eBQBJKczczp
 eja0Rtr7tzY27cqrejh5QEE7K+vjIXf0n8l2Y3MzVJCpZBkkN/zWY9lzhwzEQrxQJGjXWjSxI7q
 kF3g7iHdXGGLNVBvuo2Ngdjz7zGCRAmKHouQHVS/qSkQa/B3RKN9QnH/IhB65dMOxEaWPgmtGGO
 9WCNf1fkK72kMyRSgLzmRTOpbs94ZkAaVKCjSdd9EZSc0hmihv9LPFUUK1iDE=
X-Received: by 2002:a05:6402:304c:b0:6a5:d8f0:dc10 with SMTP id
 4fb4d7f45d1cf-6a5df63b144mr7184878a12.13.1787743164484; 
 Wed, 26 Aug 2026 04:19:24 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:8a5:68e8:91b1:8a17])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5deaa8473sm4838366a12.21.2026.08.26.04.19.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 04:19:24 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 15/28] hw/ide: revert the CHS translation on a hardware reset
Date: Wed, 26 Aug 2026 13:19:02 +0200
Message-ID: <20260826111915.3387926-6-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826111915.3387926-1-den@openvz.org>
References: <20260826111524.3383479-1-den@openvz.org>
 <20260826111915.3387926-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=den@openvz.org; helo=mail-ed1-x536.google.com
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

From: Denis V. Lunev <den@openvz.org>

A power on or hardware reset returns the device parameters to their
power-on defaults (ATA-5 9.1). A software reset keeps them unless the
guest asked with SET FEATURES 0xCC for the next reset to revert (ATA-5 9.2
and 8.16.6). ide_reset() applied the second rule to every reset, so a
translation a guest selected outlived the reset of the machine it selected
it on, and the guest that came up next addressed the disk through a
geometry it never asked for.

Neither ide_reset() nor, for AHCI, ide_bus_reset() could tell the two
apart: a guest clearing SRST in the second host to device FIS of the
software reset protocol lands in the same ahci_reset_port() as a COMRESET
or a reset of the host adapter. Pass the kind down from the callers, which
do know.

ide_drive_pre_load() stays necessary: it restores the same fields, but a
vmstate cannot depend on its device having been reset first.

Cc: John Snow <jsnow@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Fixes: 176e4961bb33 ("hw/ide/core.c: Implement ATA INITIALIZE_DEVICE_PARAMETERS command")
Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/ide/ahci.c         | 12 ++++++------
 hw/ide/cmd646.c       |  2 +-
 hw/ide/core.c         | 18 +++++++++---------
 hw/ide/ide-internal.h |  7 ++++++-
 hw/ide/isa.c          |  2 +-
 hw/ide/macio.c        |  2 +-
 hw/ide/mmio.c         |  2 +-
 hw/ide/piix.c         |  2 +-
 hw/ide/sii3112.c      |  6 +++---
 hw/ide/via.c          |  2 +-
 10 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 749f0efa1d..49f3047e6f 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -37,7 +37,7 @@
 
 static void check_cmd(AHCIState *s, int port);
 static void handle_cmd(AHCIState *s, int port, uint8_t slot);
-static void ahci_reset_port(AHCIState *s, int port);
+static void ahci_reset_port(AHCIState *s, int port, IDEResetKind kind);
 static bool ahci_write_fis_d2h(AHCIDevice *ad, bool d2h_fis_i);
 static void ahci_clear_cmd_issue(AHCIDevice *ad, uint8_t slot);
 static void ahci_init_d2h(AHCIDevice *ad);
@@ -334,7 +334,7 @@ static void ahci_port_write(AHCIState *s, int port, int offset, uint32_t val)
     case AHCI_PORT_REG_SCR_CTL:
         if (((pr->scr_ctl & AHCI_SCR_SCTL_DET) == 1) &&
             ((val & AHCI_SCR_SCTL_DET) == 0)) {
-            ahci_reset_port(s, port);
+            ahci_reset_port(s, port, IDE_RESET_HARDWARE);
         }
         pr->scr_ctl = val;
         break;
@@ -619,7 +619,7 @@ static void ahci_set_signature(AHCIDevice *ad, uint32_t sig)
                              s->lcyl, s->hcyl, sig);
 }
 
-static void ahci_reset_port(AHCIState *s, int port)
+static void ahci_reset_port(AHCIState *s, int port, IDEResetKind kind)
 {
     AHCIDevice *d = &s->dev[port];
     AHCIPortRegs *pr = &d->port_regs;
@@ -628,7 +628,7 @@ static void ahci_reset_port(AHCIState *s, int port)
 
     trace_ahci_reset_port(s, port);
 
-    ide_bus_reset(&d->port);
+    ide_bus_reset(&d->port, kind);
     ide_state->ncq_queues = AHCI_MAX_CMDS;
 
     pr->scr_stat = 0;
@@ -1244,7 +1244,7 @@ static void handle_reg_h2d_fis(AHCIState *s, int port,
                  * COMRESET or by setting and clearing the SRST bit. Therefore,
                  * the logic for this is found in ahci_init_d2h() and not here.
                  */
-                ahci_reset_port(s, port);
+                ahci_reset_port(s, port, IDE_RESET_SOFTWARE);
             }
             break;
         }
@@ -1650,7 +1650,7 @@ void ahci_reset(AHCIState *s)
         pr->irq_mask = 0;
         pr->scr_ctl = 0;
         pr->cmd = PORT_CMD_SPIN_UP | PORT_CMD_POWER_ON;
-        ahci_reset_port(s, i);
+        ahci_reset_port(s, i, IDE_RESET_HARDWARE);
     }
 }
 
diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
index d44a90a162..79ab65d64a 100644
--- a/hw/ide/cmd646.c
+++ b/hw/ide/cmd646.c
@@ -214,7 +214,7 @@ static void cmd646_reset(DeviceState *dev)
     unsigned int i;
 
     for (i = 0; i < 2; i++) {
-        ide_bus_reset(&d->bus[i]);
+        ide_bus_reset(&d->bus[i], IDE_RESET_HARDWARE);
     }
 }
 
diff --git a/hw/ide/core.c b/hw/ide/core.c
index 5a5f072630..3716cf1b5d 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -1347,7 +1347,7 @@ void ide_ioport_write(void *opaque, uint32_t addr, uint32_t val)
     }
 }
 
-static void ide_reset(IDEState *s)
+static void ide_reset(IDEState *s, IDEResetKind kind)
 {
     trace_ide_reset(s);
 
@@ -1356,7 +1356,7 @@ static void ide_reset(IDEState *s)
         s->pio_aiocb = NULL;
     }
 
-    if (s->reset_reverts) {
+    if (kind == IDE_RESET_HARDWARE || s->reset_reverts) {
         s->reset_reverts = false;
         s->heads         = s->drive_heads;
         s->sectors       = s->drive_sectors;
@@ -1424,7 +1424,7 @@ static bool cmd_device_reset(IDEState *s, uint8_t cmd)
     ide_cancel_dma_sync(s);
 
     /* Reset any PIO commands, reset signature, etc */
-    ide_reset(s);
+    ide_reset(s, IDE_RESET_SOFTWARE);
 
     /* RESET: ATA8-ACS3 7.10.4 "Normal Outputs";
      * ATA8-ACS3 Table 184 "Device Signatures for Normal Output" */
@@ -2348,7 +2348,7 @@ static void ide_perform_srst(IDEState *s)
     ide_cancel_dma_sync(s);
 
     /* Cancel PIO callback, reset registers/signature, etc */
-    ide_reset(s);
+    ide_reset(s, IDE_RESET_SOFTWARE);
 
     /* perform diagnostic */
     cmd_exec_dev_diagnostic(s, WIN_DIAGNOSE);
@@ -2553,7 +2553,7 @@ static void ide_dummy_transfer_stop(IDEState *s)
     s->io_buffer[3] = 0xff;
 }
 
-void ide_bus_reset(IDEBus *bus)
+void ide_bus_reset(IDEBus *bus, IDEResetKind kind)
 {
     /* pending async DMA - needs the IDEState before it is reset */
     if (bus->dma->aiocb) {
@@ -2564,8 +2564,8 @@ void ide_bus_reset(IDEBus *bus)
 
     bus->unit = 0;
     bus->cmd = 0;
-    ide_reset(&bus->ifs[0]);
-    ide_reset(&bus->ifs[1]);
+    ide_reset(&bus->ifs[0], kind);
+    ide_reset(&bus->ifs[1], kind);
     ide_clear_hob(bus);
 
     /* reset dma provider too */
@@ -2679,7 +2679,7 @@ int ide_init_drive(IDEState *s, IDEDevice *dev, IDEDriveKind kind, Error **errp)
         pstrcpy(s->version, sizeof(s->version), QEMU_HW_VERSION);
     }
 
-    ide_reset(s);
+    ide_reset(s, IDE_RESET_HARDWARE);
     blk_iostatus_enable(s->blk);
     return 0;
 }
@@ -2816,7 +2816,7 @@ void ide_bus_init_output_irq(IDEBus *bus, qemu_irq irq_out)
 
     for(i = 0; i < 2; i++) {
         ide_init1(bus, i);
-        ide_reset(&bus->ifs[i]);
+        ide_reset(&bus->ifs[i], IDE_RESET_HARDWARE);
     }
     bus->irq = irq_out;
     bus->dma = &ide_dma_nop;
diff --git a/hw/ide/ide-internal.h b/hw/ide/ide-internal.h
index 281d07c9d5..094772209d 100644
--- a/hw/ide/ide-internal.h
+++ b/hw/ide/ide-internal.h
@@ -393,7 +393,12 @@ extern const VMStateDescription vmstate_ide_drive;
 #define VMSTATE_IDE_DRIVE(_field, _state) \
     VMSTATE_STRUCT(_field, _state, 1, vmstate_ide_drive, IDEState)
 
-void ide_bus_reset(IDEBus *bus);
+typedef enum {
+    IDE_RESET_HARDWARE, /* power on, hardware reset or COMRESET, ATA-5 9.1 */
+    IDE_RESET_SOFTWARE, /* SRST or DEVICE RESET, ATA-5 9.2 */
+} IDEResetKind;
+
+void ide_bus_reset(IDEBus *bus, IDEResetKind kind);
 int64_t ide_get_sector(IDEState *s);
 void ide_set_sector(IDEState *s, int64_t sector_num);
 
diff --git a/hw/ide/isa.c b/hw/ide/isa.c
index c97b7a1ff4..30f02867b1 100644
--- a/hw/ide/isa.c
+++ b/hw/ide/isa.c
@@ -51,7 +51,7 @@ static void isa_ide_reset(DeviceState *d)
 {
     ISAIDEState *s = ISA_IDE(d);
 
-    ide_bus_reset(&s->bus);
+    ide_bus_reset(&s->bus, IDE_RESET_HARDWARE);
 }
 
 static const VMStateDescription vmstate_ide_isa = {
diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index a7ed41fa26..40fb4f3b4f 100644
--- a/hw/ide/macio.c
+++ b/hw/ide/macio.c
@@ -368,7 +368,7 @@ static void macio_ide_reset(DeviceState *dev)
 {
     MACIOIDEState *d = MACIO_IDE(dev);
 
-    ide_bus_reset(&d->bus);
+    ide_bus_reset(&d->bus, IDE_RESET_HARDWARE);
 }
 
 static int ide_nop_int(const IDEDMA *dma, bool is_write)
diff --git a/hw/ide/mmio.c b/hw/ide/mmio.c
index 0de904ac56..00819d559d 100644
--- a/hw/ide/mmio.c
+++ b/hw/ide/mmio.c
@@ -55,7 +55,7 @@ static void mmio_ide_reset(DeviceState *dev)
 {
     MMIOIDEState *s = MMIO_IDE(dev);
 
-    ide_bus_reset(&s->bus);
+    ide_bus_reset(&s->bus, IDE_RESET_HARDWARE);
 }
 
 static uint64_t mmio_ide_read(void *opaque, hwaddr addr,
diff --git a/hw/ide/piix.c b/hw/ide/piix.c
index a0f2709c69..a8472f3e58 100644
--- a/hw/ide/piix.c
+++ b/hw/ide/piix.c
@@ -111,7 +111,7 @@ static void piix_ide_reset(DeviceState *dev)
     int i;
 
     for (i = 0; i < 2; i++) {
-        ide_bus_reset(&d->bus[i]);
+        ide_bus_reset(&d->bus[i], IDE_RESET_HARDWARE);
     }
 
     /* PCI command register default value (0000h) per [1, p.48].  */
diff --git a/hw/ide/sii3112.c b/hw/ide/sii3112.c
index 9b28c691fd..03313eb271 100644
--- a/hw/ide/sii3112.c
+++ b/hw/ide/sii3112.c
@@ -185,7 +185,7 @@ static void sii3112_reg_write(void *opaque, hwaddr addr,
     case 0x100:
         d->regs[0].scontrol = val & 0xfff;
         if (val & 1) {
-            ide_bus_reset(&d->i.bus[0]);
+            ide_bus_reset(&d->i.bus[0], IDE_RESET_HARDWARE);
         }
         break;
     case 0x148:
@@ -194,7 +194,7 @@ static void sii3112_reg_write(void *opaque, hwaddr addr,
     case 0x180:
         d->regs[1].scontrol = val & 0xfff;
         if (val & 1) {
-            ide_bus_reset(&d->i.bus[1]);
+            ide_bus_reset(&d->i.bus[1], IDE_RESET_HARDWARE);
         }
         break;
     case 0x1c8:
@@ -243,7 +243,7 @@ static void sii3112_reset(DeviceState *dev)
 
     for (i = 0; i < 2; i++) {
         s->regs[i].confstat = 0x6515 << 16;
-        ide_bus_reset(&s->i.bus[i]);
+        ide_bus_reset(&s->i.bus[i], IDE_RESET_HARDWARE);
     }
 }
 
diff --git a/hw/ide/via.c b/hw/ide/via.c
index 3a77d744ca..6c0610ff41 100644
--- a/hw/ide/via.c
+++ b/hw/ide/via.c
@@ -127,7 +127,7 @@ static void via_ide_reset(DeviceState *dev)
     int i;
 
     for (i = 0; i < ARRAY_SIZE(d->bus); i++) {
-        ide_bus_reset(&d->bus[i]);
+        ide_bus_reset(&d->bus[i], IDE_RESET_HARDWARE);
     }
 
     pci_config_set_prog_interface(pci_conf, 0x8a); /* legacy mode */
-- 
2.53.0


