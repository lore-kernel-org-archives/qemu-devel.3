Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE6ED75E25
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 11:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tERhm-0007hi-Nl; Fri, 22 Nov 2024 06:20:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tERhk-0007gu-Vz
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 06:20:05 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tERhf-0006AO-3X
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 06:20:04 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-382296631f1so1417537f8f.3
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 03:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732274396; x=1732879196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uPCQyQvoAOEbN8ixHzSuXBuJXKTD3sl0YDtIawxMPFk=;
 b=hBU+z1wUybSy+lxkI6xKrP23Kp4DM4IWbnRF+heJuUXkHdwqV4nsoeuZKI2bMQ/oFp
 J8DM2nSTyzQZjo6SuFrtM2RCVdeHwRHEwAzlB7KUirRmy/+g6ZTxXo0yXr9+X639EuXN
 Ry0vbTDxYXIcAnMPbPvfoZfgcvmAyCBS4mc4MgMrpm6TkWt7/ZfuZZ2ZEqugMx+VZtdq
 Fvn41TjGMAnt1REUctKgz/QpGw6KQAJ2tjaO23yVVfte30XvqwDSNB46eAReIWQsaFkF
 RKQZcX6gc5+fIlKAZxS29Cxmke2Rcn44jm9cK71cc/avnJ56I17WA0gitnI5XcDP/b5X
 oeew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732274396; x=1732879196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uPCQyQvoAOEbN8ixHzSuXBuJXKTD3sl0YDtIawxMPFk=;
 b=suITvjNvg6meLZ6gUYBJCYPVCsSumApYK7mInAQbPn6mevtmv8Nl6BuI4R9KanG1KZ
 yNoMYqBbwDEeNf+oDwT4spkhkMxY0bX0kEVFOZM9clAhsbQW5NHaMyjuo+b6zPIIrdh8
 HHTYGV4AtA2mka1RbTJ1BnpMYYmPUDJon87cqfc66pMwy0aNZ+U+GX6e6aTdiyL+/7Z8
 yTXvHmsW4EVANWl8W0xEdCzUBpPzJg2S50h94GUSr2BHTHlRNEaq/463tBfW5f7AVXZ6
 h1GJ0EyXWJRvCZ64QXuFt1z6F0tQeyrolA1pQ4aWS+mqtdDmbQfSoJRKmRdEGYbd+ZDb
 IdWg==
X-Gm-Message-State: AOJu0YxmHbelgy15EPsso7UMQy9GwUOUqr875SbFSgQkQln2C4OzbYWH
 /lPNOfKL+L7pjOYxxX6K7vqG6P+tRI8PVsFi2MgrO0sFkH2amn0RGO9dXWOXYTP6Q55QuWagtxR
 F
X-Gm-Gg: ASbGncvOo9nukafS5JfH6Q2xGBU4ln47oQJpDsUnEV89uRwRmg50v0YdBrFEuORdDnF
 iQIz4TDMx3xz+NxB/yOdmrWutK2lDguAB1ybbjxnJXRerSCbkqzhSToSKlKWLuXKFj7ZzocvDMf
 H/MKdaRwOCsFaey5D+wFuHgHLgNQZJGQDVuQ9jZwFBEifL0EAqSEZqgVbvlzitXy0y9CzJWspBA
 SCXBGvsuye1wy/ty2yLC2LrkLsLUx0H7RVE4hpsAq1NfRXwjJhGOzE7iiXbEtx+BR8t09ZqGHg+
X-Google-Smtp-Source: AGHT+IHbPGyismBbvz7VODNzBBvwkWmUJxaspOVpUAKEFBhmQ3qjFrzumVjV8xn78o704Jf1qEEYjw==
X-Received: by 2002:a5d:5987:0:b0:382:4d54:2cd9 with SMTP id
 ffacd0b85a97d-38260b5a0bdmr1957022f8f.20.1732274395769; 
 Fri, 22 Nov 2024 03:19:55 -0800 (PST)
Received: from localhost.localdomain ([176.187.211.33])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825faf9e87sm2108376f8f.29.2024.11.22.03.19.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 22 Nov 2024 03:19:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Helge Deller <deller@gmx.de>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH 2/3] hw/scsi/lsi53c895a: Call scsi_bus_legacy_handle_cmdline()
 once
Date: Fri, 22 Nov 2024 12:19:38 +0100
Message-ID: <20241122111939.11936-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241122111939.11936-1-philmd@linaro.org>
References: <20241122111939.11936-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Call scsi_bus_legacy_handle_cmdline() once in the DeviceRealize
handler, just after scsi_bus_init().
No need for lsi53c8xx_handle_legacy_cmdline(), remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/pci/pci.h | 2 --
 hw/arm/realview.c    | 3 +--
 hw/arm/versatilepb.c | 3 +--
 hw/hppa/machine.c    | 3 +--
 hw/ppc/prep.c        | 1 -
 hw/scsi/lsi53c895a.c | 8 +-------
 6 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index c0717e3121..7a69f0368c 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -655,8 +655,6 @@ PCIDevice *pci_create_simple_multifunction(PCIBus *bus, int devfn,
                                            const char *name);
 PCIDevice *pci_create_simple(PCIBus *bus, int devfn, const char *name);
 
-void lsi53c8xx_handle_legacy_cmdline(DeviceState *lsi_dev);
-
 qemu_irq pci_allocate_irq(PCIDevice *pci_dev);
 void pci_set_irq(PCIDevice *pci_dev, int level);
 
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index b186f965c6..1042c1a1a3 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -294,8 +294,7 @@ static void realview_init(MachineState *machine,
         }
         n = drive_get_max_bus(IF_SCSI);
         while (n >= 0) {
-            dev = DEVICE(pci_create_simple(pci_bus, -1, "lsi53c895a"));
-            lsi53c8xx_handle_legacy_cmdline(dev);
+            pci_create_simple(pci_bus, -1, "lsi53c895a");
             n--;
         }
     }
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index d48235453e..716ed951bc 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -271,8 +271,7 @@ static void versatile_init(MachineState *machine, int board_id)
     }
     n = drive_get_max_bus(IF_SCSI);
     while (n >= 0) {
-        dev = DEVICE(pci_create_simple(pci_bus, -1, "lsi53c895a"));
-        lsi53c8xx_handle_legacy_cmdline(dev);
+        pci_create_simple(pci_bus, -1, "lsi53c895a");
         n--;
     }
 
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index a31dc32a9f..69b822bfc8 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -349,8 +349,7 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
 
     /* SCSI disk setup. */
     if (drive_get_max_bus(IF_SCSI) >= 0) {
-        dev = DEVICE(pci_create_simple(pci_bus, -1, "lsi53c895a"));
-        lsi53c8xx_handle_legacy_cmdline(dev);
+        pci_create_simple(pci_bus, -1, "lsi53c895a");
     }
 
     /* Graphics setup. */
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index fb58c312ac..0e5ff2a75c 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -328,7 +328,6 @@ static void ibm_40p_init(MachineState *machine)
 
         dev = DEVICE(pci_create_simple(pci_bus, PCI_DEVFN(1, 0),
                                        "lsi53c810"));
-        lsi53c8xx_handle_legacy_cmdline(dev);
         qdev_connect_gpio_out(dev, 0, qdev_get_gpio_in(i82378_dev, 13));
 
         /* XXX: s3-trio at PCI_DEVFN(2, 0) */
diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 1f728416e2..d632789434 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -2365,6 +2365,7 @@ static void lsi_scsi_realize(PCIDevice *dev, Error **errp)
     QTAILQ_INIT(&s->queue);
 
     scsi_bus_init(&s->bus, sizeof(s->bus), d, &lsi_scsi_info);
+    scsi_bus_legacy_handle_cmdline(&s->bus);
 }
 
 static void lsi_scsi_exit(PCIDevice *dev)
@@ -2422,10 +2423,3 @@ static void lsi53c895a_register_types(void)
 }
 
 type_init(lsi53c895a_register_types)
-
-void lsi53c8xx_handle_legacy_cmdline(DeviceState *lsi_dev)
-{
-    LSIState *s = LSI53C895A(lsi_dev);
-
-    scsi_bus_legacy_handle_cmdline(&s->bus);
-}
-- 
2.45.2


