Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE9C9CD5BCF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 04:30:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRjQd-0007Pf-US; Tue, 26 May 2026 00:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lb.workbox@gmail.com>)
 id 1wRjQc-0007Oq-Kp
 for qemu-devel@nongnu.org; Tue, 26 May 2026 00:30:06 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lb.workbox@gmail.com>)
 id 1wRjQa-0007So-VF
 for qemu-devel@nongnu.org; Tue, 26 May 2026 00:30:06 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so105946485e9.0
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 21:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779769803; x=1780374603; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XmJyzF++EuXN5ZLIdNyei6W6W9VYeSiHX7DolYmw/4E=;
 b=GDJ7w57J6amIoTYax/kO1dw2W5q/3jiJ0RlkbbmVyHdLIWGmNTSUXd9VsjAmTxKgCd
 x39O7rlI3aOWYTrgfh+ILQiaBnM8S3KT6DyaudRsO11RUfARFXKK91BM1LI0VwlU1yVI
 sP/YjGjjDhTs+k7rotwvfkkETg8WB2dePzG0TtRfXbTUy+EDrEdaQ0X2xww/ZxuR61kF
 sBzfmYW1tZ1jYP3JfGeSUhSYDiQ0zVeU8ZEWGD2BGid/SiB4m8sRK9ywuVnq4BlQSZ8n
 AkORUEyT/O9m3Vf/wJDekofKCF+tp/OFNP16B+UQAbgUfYf4iXSwiPI6hwZ4e5bpmyOQ
 n6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779769803; x=1780374603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XmJyzF++EuXN5ZLIdNyei6W6W9VYeSiHX7DolYmw/4E=;
 b=ILuXaiI9I7VPyx7beVpdzFcCDtPOAJx2iqyjbrt5aTJjQZUKFDTzzp8XZylHcNfoun
 eBVWgWNjocAIbwA1vJNu5TOTfoCYiRao63r3Y0du3eQ/wbLyejvk4hqHgAyNxwGtTJ+N
 sdW8vEnApfjDxyWr5SEeANRJPH0YOzMvzyXg6mVsGQjL0LSo9MaxUvCYxPZ8Da3wsFgE
 Rn9lYWAS7KUvdfUXOjVikuCsLyHpk92rveTViNIF0lMple4eZJp0qz7+j1++HV+qsnXU
 tJNO5saSHjw1oDww7Yz7qwq3L3eLgwIbMostp/P7fy8pSMZ+06hmXby2vTtYdk6so3vu
 gb4w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9N+e2ejd3vrmnKNEuNdPZPXs990iL/rW2XX8kIR2yUrvl4pMmW02s8bjABbJvG8XmiVY21mEsA58bN@nongnu.org
X-Gm-Message-State: AOJu0YwUC1jTUdoiYp3PWBUHAEWPKomwMYr+gO2HF+k8eLFUmWvbZdlB
 3N7+gkmAUbACqN9X+EQFXGQ64EQdT60/pHAAng/Ey2o+Dmfg26NQxe/A
X-Gm-Gg: Acq92OFZCx4WmSrXN+83F2Gpm3sMscFxOlLVD69L/ZdLyeV/m0Z3l+mdIEnt7VlikwH
 MpYg2h6ih4JzrrqamjK9Sy3RHIrKDirUDeplW2jcRYxNWOJiK4+Sdytb36+DOJ0teTEljMWoIU6
 Cp2p8rw0xjjufdBL8Yk0OcCdHJbivgfJqAEpY55nqnlnw0KEjW2Fp2bSfMDldYCUoJF77IMe5yi
 CbfGhwZ/hlta9PX7dw1hXnZbMPymR7WcBSaQv8dWFEpdKXWsa/JbCvRGnjE41o4EYg0x7xYoYNZ
 +K3XYYqVXy0R72stimQGQUN64jrEbVwMcoEOqV+oE/s5XmTec1ES3MnCRHwPn6KPtVQ/5c0jnNv
 xkMAnECn9ASeP4A8R1z7VTxRJ/It/OSV1OTMwNntg3WYVZ2dMDogCRL9vlJW6P188c0yTL0siOE
 UoVB+V19gWpbUq+W5brY4fHDc0A97Iz+aSBuZRimx6COisM1kllJEPRVnpSSC47IkB8GOS+9F97
 4prqmQYYXrm9NKTHZZWk+GN
X-Received: by 2002:a05:600c:3b97:b0:490:52fb:12dd with SMTP id
 5b1f17b1804b1-49052fb14fdmr230836135e9.10.1779769803206; 
 Mon, 25 May 2026 21:30:03 -0700 (PDT)
Received: from localhost.localdomain (46-116-239-136.bb.netvision.net.il.
 [46.116.239.136]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49076a6abfasm6659625e9.12.2026.05.25.21.30.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 21:30:02 -0700 (PDT)
From: Leonid Bloch <lb.workbox@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
Cc: Leonid Bloch <lb.workbox@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 1/8] hw/acpi: Support extended GPE handling for additional
 ACPI devices
Date: Tue, 26 May 2026 07:29:20 +0300
Message-ID: <20260526042928.9203-2-lb.workbox@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526042928.9203-1-lb.workbox@gmail.com>
References: <20260526042928.9203-1-lb.workbox@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=lb.workbox@gmail.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This patch extends the GPE (General Purpose Event) handling to support
the maximum number of interrupts available based on the machine's GPE
register length, rather than being limited to the first 8 bits.

This change is needed to support additional ACPI devices that will be
introduced in subsequent patches (Battery, AC adapter, and button devices).
These new devices require GPE event bits beyond the first 8, which were
previously not being properly handled by the event sending and SCI
(System Control Interrupt) update mechanisms.

The actual number of available GPE interrupts varies by machine type:
- PIIX4: GPE_LEN = 4 (32 bits total across status and enable registers)
- ICH9: ICH9_PMIO_GPE0_LEN = 16 (128 bits total)

The patch modifies:
- acpi_send_gpe_event(): Now properly propagates status bits across all
  available GPE registers based on the machine's gpe.len value
- acpi_update_sci(): Checks all GPE registers for pending interrupts,
  not just the first byte

Note: A future enhancement could refactor the GPE handling to use the
bitmap API from bitops.h instead of the current manual bit manipulation,
which would provide a cleaner interface for these operations.

Signed-off-by: Leonid Bloch <lb.workbox@gmail.com>
---
 hw/acpi/core.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index a6a62a742d..ad7abe568d 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -733,19 +733,32 @@ uint32_t acpi_gpe_ioport_readb(ACPIREGS *ar, uint32_t addr)
 void acpi_send_gpe_event(ACPIREGS *ar, qemu_irq irq,
                          AcpiEventStatusBits status)
 {
-    ar->gpe.sts[0] |= status;
+    int i;
+    AcpiEventStatusBits st = status;
+
+    for (i = 0; i < ar->gpe.len / 2; i++) {
+        ar->gpe.sts[i] |= st;
+        st >>= TYPE_WIDTH(ar->gpe.sts[0]);
+    }
+
     acpi_update_sci(ar, irq);
 }
 
 void acpi_update_sci(ACPIREGS *regs, qemu_irq irq)
 {
     int sci_level, pm1a_sts;
+    bool gpe_sci = false;
+    int i;
 
     pm1a_sts = acpi_pm1_evt_get_sts(regs);
 
+    for (i = 0; i < regs->gpe.len / 2; i++) {
+        gpe_sci = gpe_sci || !!(regs->gpe.sts[i] & regs->gpe.en[i]);
+    }
+
     sci_level = ((pm1a_sts &
                   regs->pm1.evt.en & ACPI_BITMASK_PM1_COMMON_ENABLED) != 0) ||
-                ((regs->gpe.sts[0] & regs->gpe.en[0]) != 0);
+                gpe_sci;
 
     qemu_set_irq(irq, sci_level);
 
-- 
2.54.0


