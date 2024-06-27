Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A82CEC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 13:41:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMpKt-00019R-1D; Thu, 27 Jun 2024 09:38:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMpKe-00015R-0X
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:38:38 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMpKW-0006MV-53
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:38:35 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1fa75f53f42so18712395ad.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 06:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719495507; x=1720100307;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=H1Ud2sffuzrWRWcIEMkaft+gSFV/vM2qExG+yzsFHsg=;
 b=tOKzzI5S818bX1RcOKyIwWKZVxz8/r54xTNsQwNydWljGZga1ugk+/vcE+78DbdDKK
 zSzw2n2nBLUaMVn0QE+P/H0IGdr0xwEBfgF/fehCGtU7u7A3s3WXOSm3rc1TEFSHesDB
 qs8IA1Ecl8v3KHGWubjuQKgJUhEGOPd5r1/sUfHGmygbfJ0IGebPRLNOTa0qZKkQkNBn
 FmFN5MR1s0vKWP3YFmnYKSYQ71xMA5kqiBa+Xcz1ejOV24q75wIdm6l/YoJgVMBpWbIw
 uk0Ykm96GLf762CYZmZkxxTBT6GCa2UludZMzh2i5xkHyOBhWV/IVOD5gLlSvQ2rsxrN
 cWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719495507; x=1720100307;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H1Ud2sffuzrWRWcIEMkaft+gSFV/vM2qExG+yzsFHsg=;
 b=MiYy2R+bDs9twW36BjacCO/+unOT8Y+mspQse8LK+qB7w7yZ4CYM4Lq4bktsVj7zxL
 gFqBTYMCQle7rybWhxJ3ods3dQiZZaKSJai1Y34yY3MpnriejpUmXKGUHORhPXy7gbpa
 Icqy91AD1FjJWMoiBGG52f/wvoO+lcAf52oyxzpv9chcDvCzfBNUG6voMTt96vrOoiiF
 DYhapWGhioAfSgFztN7hmHWD/T6RYarzMFo95xNtoyCdpRwNJeiEXEn1V/s5iHCc1am4
 Atf67GLNN88cwMy9vTqaQBEeo25q+Ew9JgFP7fdm//Can/xYvJu7venNgmpx9vCJanbx
 wGgg==
X-Gm-Message-State: AOJu0YwiMpEkpYBv9ZI2oWati/DPRC59BZ8YYb6CvrFdPD8ed5LmMAYL
 GiC8Bs6yT12QvxzwbJh+cavB1H1cGv4/wQQTrKEPez0KJFgyOMNdGhPhofuVfHc=
X-Google-Smtp-Source: AGHT+IGlthtRlIAOrErKWBa0d4JJXHENu4FzsbU9EBlxzWOmvVmo/stPsHEbzaIw8JmTtJTtru3wgw==
X-Received: by 2002:a17:902:ec8e:b0:1f9:f559:d8c7 with SMTP id
 d9443c01a7336-1fa240c5353mr166234385ad.57.1719495506752; 
 Thu, 27 Jun 2024 06:38:26 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1faac979f54sm13182435ad.153.2024.06.27.06.38.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 06:38:26 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 27 Jun 2024 22:37:46 +0900
Subject: [PATCH v2 03/15] hw/ide: Remove internal DMA qemu_irq
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-san-v2-3-750bb0946dbd@daynix.com>
References: <20240627-san-v2-0-750bb0946dbd@daynix.com>
In-Reply-To: <20240627-san-v2-0-750bb0946dbd@daynix.com>
To: Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

A function pointer is sufficient for internal usage. Replacing qemu_irq
with one fixes the leak of qemu_irq.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/ppc/mac_dbdma.h |  5 +++--
 hw/ide/macio.c             | 11 +++++++----
 hw/misc/macio/mac_dbdma.c  | 10 +++++-----
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/include/hw/ppc/mac_dbdma.h b/include/hw/ppc/mac_dbdma.h
index 4a3f644516b3..1e1973c39580 100644
--- a/include/hw/ppc/mac_dbdma.h
+++ b/include/hw/ppc/mac_dbdma.h
@@ -32,6 +32,7 @@
 typedef struct DBDMA_io DBDMA_io;
 
 typedef void (*DBDMA_flush)(DBDMA_io *io);
+typedef void (*DBDMA_irq)(DBDMA_io *io);
 typedef void (*DBDMA_rw)(DBDMA_io *io);
 typedef void (*DBDMA_end)(DBDMA_io *io);
 struct DBDMA_io {
@@ -154,7 +155,7 @@ typedef struct dbdma_cmd {
 typedef struct DBDMA_channel {
     int channel;
     uint32_t regs[DBDMA_REGS];
-    qemu_irq irq;
+    DBDMA_irq irq;
     DBDMA_io io;
     DBDMA_rw rw;
     DBDMA_flush flush;
@@ -172,7 +173,7 @@ typedef struct DBDMAState DBDMAState;
 
 /* Externally callable functions */
 
-void DBDMA_register_channel(void *dbdma, int nchan, qemu_irq irq,
+void DBDMA_register_channel(void *dbdma, int nchan, DBDMA_irq irq,
                             DBDMA_rw rw, DBDMA_flush flush,
                             void *opaque);
 void DBDMA_kick(DBDMAState *dbdma);
diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index 9c96a857a7c1..425b670a52a9 100644
--- a/hw/ide/macio.c
+++ b/hw/ide/macio.c
@@ -427,9 +427,8 @@ static void macio_ide_realizefn(DeviceState *dev, Error **errp)
     s->bus.dma = &s->dma;
 }
 
-static void pmac_irq(void *opaque, int n, int level)
+static void pmac_irq(MACIOIDEState *s, int n, int level)
 {
-    MACIOIDEState *s = opaque;
     uint32_t mask = 0x80000000u >> n;
 
     /* We need to reflect the IRQ state in the irq register */
@@ -446,6 +445,11 @@ static void pmac_irq(void *opaque, int n, int level)
     }
 }
 
+static void pmac_dma_irq(DBDMA_io *io)
+{
+    pmac_irq(io->opaque, 0, 1);
+}
+
 static void pmac_ide_irq(void *opaque, int n, int level)
 {
     pmac_irq(opaque, 1, level);
@@ -461,7 +465,6 @@ static void macio_ide_initfn(Object *obj)
     sysbus_init_mmio(d, &s->mem);
     sysbus_init_irq(d, &s->real_ide_irq);
     sysbus_init_irq(d, &s->real_dma_irq);
-    s->dma_irq = qemu_allocate_irq(pmac_irq, s, 0);
     qdev_init_gpio_in_named_with_opaque(DEVICE(obj), pmac_ide_irq, s, NULL, 1);
 
     object_property_add_link(obj, "dbdma", TYPE_MAC_DBDMA,
@@ -513,7 +516,7 @@ void macio_ide_init_drives(MACIOIDEState *s, DriveInfo **hd_table)
 
 void macio_ide_register_dma(MACIOIDEState *s)
 {
-    DBDMA_register_channel(s->dbdma, s->channel, s->dma_irq,
+    DBDMA_register_channel(s->dbdma, s->channel, pmac_dma_irq,
                            pmac_ide_transfer, pmac_ide_flush, s);
 }
 
diff --git a/hw/misc/macio/mac_dbdma.c b/hw/misc/macio/mac_dbdma.c
index 2a528ea08caf..3450105ad851 100644
--- a/hw/misc/macio/mac_dbdma.c
+++ b/hw/misc/macio/mac_dbdma.c
@@ -114,7 +114,7 @@ static void kill_channel(DBDMA_channel *ch)
     ch->regs[DBDMA_STATUS] |= DEAD;
     ch->regs[DBDMA_STATUS] &= ~ACTIVE;
 
-    qemu_irq_raise(ch->irq);
+    ch->irq(&ch->io);
 }
 
 static void conditional_interrupt(DBDMA_channel *ch)
@@ -133,7 +133,7 @@ static void conditional_interrupt(DBDMA_channel *ch)
     case INTR_NEVER:  /* don't interrupt */
         return;
     case INTR_ALWAYS: /* always interrupt */
-        qemu_irq_raise(ch->irq);
+            ch->irq(&ch->io);
         DBDMA_DPRINTFCH(ch, "%s: raise\n", __func__);
         return;
     }
@@ -148,13 +148,13 @@ static void conditional_interrupt(DBDMA_channel *ch)
     switch(intr) {
     case INTR_IFSET:  /* intr if condition bit is 1 */
         if (cond) {
-            qemu_irq_raise(ch->irq);
+            ch->irq(&ch->io);
             DBDMA_DPRINTFCH(ch, "%s: raise\n", __func__);
         }
         return;
     case INTR_IFCLR:  /* intr if condition bit is 0 */
         if (!cond) {
-            qemu_irq_raise(ch->irq);
+            ch->irq(&ch->io);
             DBDMA_DPRINTFCH(ch, "%s: raise\n", __func__);
         }
         return;
@@ -562,7 +562,7 @@ void DBDMA_kick(DBDMAState *dbdma)
     qemu_bh_schedule(dbdma->bh);
 }
 
-void DBDMA_register_channel(void *dbdma, int nchan, qemu_irq irq,
+void DBDMA_register_channel(void *dbdma, int nchan, DBDMA_irq irq,
                             DBDMA_rw rw, DBDMA_flush flush,
                             void *opaque)
 {

-- 
2.45.2


