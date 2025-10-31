Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED9ECCFA04
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 21:28:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEweA-0006Yg-Qv; Fri, 31 Oct 2025 17:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vEwT9-0000HG-Dy
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 17:15:35 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vEwT3-0001xD-HN
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 17:15:35 -0400
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-290ab379d48so27396845ad.2
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 14:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761945326; x=1762550126; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CPCl8R+I/SKh5BgbKo9T2ZRm8RcVBHVWYZqEpXNjYEs=;
 b=HpdTJWazIvAAoIsaHzDAZhjsC2EtX7Uzib4ECZjrzB7w6o7AVO1JRtlkB2yYN23tOu
 1tUACkJR8FDEl7kjCe1RBSD4+tcZPYYMqQcgAF0VQvCkMscnTsZhtw69+2IpiOV5FIzL
 c/v8QUjWeC9usS9FaJhd0VluqYM54b9keMKP1LEpf7yl4csKaT3tMwlG5XWiIyQXuR6O
 I1Mw5b3ljsOw5ChVli5opXvxHJZ5mmvHGWTA0w48W4KbPHC0ByXzVjLYRN6ZI2eUAGKA
 coWo5xzDdJCFbbITHmdbCI4LmzcMF7nIWsKBq9GZpkJN9xFLqTG91INQG+U1rDtBfHf2
 am+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761945326; x=1762550126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CPCl8R+I/SKh5BgbKo9T2ZRm8RcVBHVWYZqEpXNjYEs=;
 b=bc7+A0HGutiUdShE0Iv0H6+zzBDFyGsVtlL3/7UEnRLhnQz3EBSCpWPSHxLgtEzsy1
 6+QIuXSWr0SYtw9c6VzMQMekFljifAR3Rlvae+oSjmz2bNE6EwiRIcpsOyuvKm1SKKvh
 /pnc8vEfwHb+bQ67M8+MnXoNkrB0z6VHqQN29ySOlBw40JgJOU+A6pPL5WVu6STuCfzX
 phtCCukuVYepCuXMZVDIRDoDvUOYBh56fMkjhssXWsJQStmr33eHlmHiuOzG0fahq4iK
 P6CVXxCEICrp9acq+xyj+3v8xuRxC9YzXiQ2MHGhSO+jAuXdarrAq1WsBE50fdgnVp5s
 vIrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/VvgnH5k6gqrgnj+v1TM2qBa3jNO6UGhEKEJlZ2XIEeuilVlio2Dy//CwwsDNDOLfG4OempNQAOm7@nongnu.org
X-Gm-Message-State: AOJu0Yzcql6gj4AtvwtD/28Ceu7PVFnc3H+ElbMUvppSfKADAjqxonaL
 nT1CFSPOlAsK/1R/7bOO+MUDLcNo99oVWcjd30snujH3CbuT3FgeulSp
X-Gm-Gg: ASbGncuNimEtz4mZS+xlRY5nNGLwRUSXIONd1X2fBpbiONLYvymiKnl8VdSJ99fFGeZ
 Qn1QSullKKc/rZjupNTg9uYiSIADqDFjhGtqGkp31L0Epdhn3Nl+zUfpXSxRzx1/7YAkQHPUfC7
 NUYrbC5hnFtJItDU/6I+ldtx1/M6q0tR0mh+4VapvhCiOzD5f46bJyFPKQAKp7w592PTK8S5O4a
 54Slo0P08KFRdLk6RCEz3kBLO3apZL1BHCGJYwxKydSVPr20aAQ6dlSb+v65GuUsl5yhX8Tv006
 eQ5o4fDTdMxHWsJjeF2w7FIGmu92UF2qK1PvDcWERGQ/tapFMwtBBaQnwSP7jac0nfILxSkZxmY
 QDxvoKIF8k5XB03KRH2qiJpQZQ2xm1IjPChC4d2NaevYYNk6/JHT161S1vawSLPiV4fpv/Sn6SZ
 rERhJEEWY4NspTlS3I6MCD380nODrBD3+YjbLKKluckeaHdbWpow==
X-Google-Smtp-Source: AGHT+IEq3lfre9hD92z9FNfx9DNUM/AdLVlGEkeIARsp/WDSLXluMDWOdqWB4RdC003cJPByynEH4w==
X-Received: by 2002:a17:902:c408:b0:295:54cb:a8df with SMTP id
 d9443c01a7336-29554cba9d6mr8834745ad.36.1761945326428; 
 Fri, 31 Oct 2025 14:15:26 -0700 (PDT)
Received: from fedora.. ([103.2.232.250]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b93b8aa3ff1sm3023320a12.14.2025.10.31.14.15.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 14:15:26 -0700 (PDT)
From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
To: deller@gmx.de,
	qemu-devel@nongnu.org
Cc: sarkarsoumyajyoti23@gmail.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>,
 RemZapCypher <soumyajyotisarkar23@gmail.com>
Subject: [PATCH 1/3] hw/hppa: Enable LASI i82596 network on 715 machine
Date: Sat,  1 Nov 2025 02:45:14 +0530
Message-ID: <20251031211516.208488-2-soumyajyotisarkar23@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251031211516.208488-1-soumyajyotisarkar23@gmail.com>
References: <20251031211516.208488-1-soumyajyotisarkar23@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=soumyajyotisarkar23@gmail.com; helo=mail-pl1-x641.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 31 Oct 2025 17:26:56 -0400
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

From: RemZapCypher <soumyajyotisarkar23@gmail.com>

Enable the i82596 network chip which is included in the LASI
multi I/O chip. Since LASI has different start addresses on
the various machines, always initialize the LASI components
by their offsets.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/hppa/hppa_hardware.h | 20 ++++++++++++--------
 hw/hppa/machine.c       | 25 +++++++++++--------------
 2 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/hw/hppa/hppa_hardware.h b/hw/hppa/hppa_hardware.h
index d422af0429..a8a496c0e1 100644
--- a/hw/hppa/hppa_hardware.h
+++ b/hw/hppa/hppa_hardware.h
@@ -21,14 +21,6 @@
 #define DINO_SCSI_HPA   0xfff8c000
 #define LASI_HPA_715    0xf0100000
 #define LASI_HPA        0xffd00000
-#define LASI_UART_HPA   0xffd05000
-#define LASI_SCSI_HPA   0xffd06000
-#define LASI_LAN_HPA    0xffd07000
-#define LASI_RTC_HPA    0xffd09000
-#define LASI_LPT_HPA    0xffd02000
-#define LASI_AUDIO_HPA  0xffd04000
-#define LASI_PS2KBD_HPA 0xffd08000
-#define LASI_PS2MOU_HPA 0xffd08100
 #define LASI_GFX_HPA    0xf8000000
 #define ARTIST_FB_ADDR  0xf9000000
 #define CPU_HPA         0xfffb0000
@@ -44,6 +36,18 @@
 
 #define SCSI_HPA        0xf1040000      /* emulated SCSI, needs to be in f region */
 
+#define HPA_DISABLED_DEVICE     1       /* add to HPA to disable */
+
+/* LASI offsets */
+#define LASI_LPT        0x02000
+#define LASI_AUDIO      0x04000
+#define LASI_UART       0x05000
+#define LASI_SCSI       0x06000
+#define LASI_LAN        0x07000
+#define LASI_PS2        0x08000
+#define LASI_RTC        0x09000
+#define LASI_FDC        0x0A000
+
 /* offsets to DINO HPA: */
 #define DINO_PCI_ADDR           0x064
 #define DINO_CONFIG_DATA        0x068
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index cbca0026ab..7c5297c071 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -50,8 +50,6 @@ struct HppaMachineState {
 #define HPA_POWER_BUTTON        (FIRMWARE_END - 0x10)
 static hwaddr soft_power_reg;
 
-#define enable_lasi_lan()       0
-
 static DeviceState *lasi_dev;
 
 static void hppa_powerdown_req(Notifier *n, void *opaque)
@@ -376,13 +374,6 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
         }
     }
 
-    /* Network setup. */
-    if (lasi_dev) {
-        lasi_82596_init(addr_space, translate(NULL, LASI_LAN_HPA),
-                        qdev_get_gpio_in(lasi_dev, LASI_IRQ_LAN_HPA),
-                        enable_lasi_lan());
-    }
-
     if (pci_bus) {
         pci_init_nic_devices(pci_bus, mc->default_nic);
 
@@ -595,6 +586,11 @@ static void machine_HP_715_init(MachineState *machine)
         lasi_ncr710_handle_legacy_cmdline(dev);
     }
 
+    /* LASI i82596 network */
+    lasi_82596_init(addr_space, translate(NULL, LASI_HPA_715 + LASI_LAN),
+                    qdev_get_gpio_in(lasi_dev, LASI_IRQ_LAN_HPA),
+                    true);
+
     /* Add NICs, graphics & load firmware */
     machine_HP_common_init_tail(machine, NULL, translate);
 }
@@ -638,7 +634,7 @@ static void machine_HP_B160L_init(MachineState *machine)
     assert(isa_bus);
 
     /* Serial ports: Lasi and Dino use a 7.272727 MHz clock. */
-    serial_mm_init(addr_space, translate(NULL, LASI_UART_HPA + 0x800), 0,
+    serial_mm_init(addr_space, translate(NULL, LASI_HPA + LASI_UART + 0x800), 0,
         qdev_get_gpio_in(lasi_dev, LASI_IRQ_UART_HPA), 7272727 / 16,
         serial_hd(0), DEVICE_BIG_ENDIAN);
 
@@ -647,7 +643,8 @@ static void machine_HP_B160L_init(MachineState *machine)
         serial_hd(1), DEVICE_BIG_ENDIAN);
 
     /* Parallel port */
-    parallel_mm_init(addr_space, translate(NULL, LASI_LPT_HPA + 0x800), 0,
+    parallel_mm_init(addr_space,
+                     translate(NULL, LASI_HPA + LASI_LPT + 0x800), 0,
                      qdev_get_gpio_in(lasi_dev, LASI_IRQ_LPT_HPA),
                      parallel_hds[0]);
 
@@ -657,11 +654,11 @@ static void machine_HP_B160L_init(MachineState *machine)
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
                        qdev_get_gpio_in(lasi_dev, LASI_IRQ_PS2KBD_HPA));
     memory_region_add_subregion(addr_space,
-                                translate(NULL, LASI_PS2KBD_HPA),
+                                translate(NULL, LASI_HPA + LASI_PS2),
                                 sysbus_mmio_get_region(SYS_BUS_DEVICE(dev),
                                                        0));
     memory_region_add_subregion(addr_space,
-                                translate(NULL, LASI_PS2KBD_HPA + 0x100),
+                                translate(NULL, LASI_HPA + LASI_PS2 + 0x100),
                                 sysbus_mmio_get_region(SYS_BUS_DEVICE(dev),
                                                        1));
 
@@ -832,7 +829,7 @@ static void HP_715_machine_init_class_init(ObjectClass *oc, const void *data)
     /* can only support up to max. 8 CPUs due inventory major numbers */
     mc->max_cpus = MIN_CONST(HPPA_MAX_CPUS, 8);
     mc->default_ram_size = 256 * MiB;
-    mc->default_nic = NULL;
+    mc->default_nic = "lasi_82596";
 }
 
 
-- 
2.49.0


