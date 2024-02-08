Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1986FC4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 22:06:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYCV7-0007Gx-1G; Thu, 08 Feb 2024 17:04:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rYCV5-0007GU-GL
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 17:04:07 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rYCV3-0005EM-Rx
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 17:04:07 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a3850ce741bso29487566b.3
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 14:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707429843; x=1708034643; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uLRRI7JaWxueGy30xNOeOTuX8cbsB2oZVyCqXBekoKA=;
 b=Xuc+RoXJK+A8dKrWK8eZsAQKLc6NhpcAuKl90efpSuN5+B0aP28ARi3oBxHtAODJyQ
 /kptiWMoOIGvRsYYFF41dDaaS+P8qKRqZTJWgx1YX3xDsLGO+OrXasb15m7QvTh4pbcQ
 K8tL08YMgajbhMrw+O+NTM6moQHW0B26H2+Wvm01ABkpza+AGyumMT5jFqYwyCGAHsIS
 8xmt1y4pjsms5+ncQVLfNpV1BDMjQoVVG/drhCsup/syaP2/+Y9ojDbanNM3Rh6kBon1
 xd8IgXSYor4P4N3h01WAJZxJQakBJp4kpSE2DtoJNohnDzeDrk9S+m+cXrWb2qabM41q
 2lSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707429843; x=1708034643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uLRRI7JaWxueGy30xNOeOTuX8cbsB2oZVyCqXBekoKA=;
 b=cNC4u5+z275BY0Qn6JfEAUeCFion6wSIs30pzHKHbxU6AhOGjAMWGIO1IZWeOy3Fmi
 Yo+eSObuQxFf5mAk5RuzFVliiJ9a0ca2P+sbKbinVb81udLp+RYumSqT0Grguzfm4hOw
 9wX1Et73NGXqUNzzap0d1Lbm7lsxufDiI9+7uYq+sewwCPVFrUZ4wkYLNxBxhHogGO5s
 ncD41gnhKT1XMWVJ88eLWHpPcDl9ey0dCLNBE3mb6aV7pP+8NVulDIhileVJ+2WikeW4
 cO8xvk7eBpWFTiOSbqdFzeAj7X7VlpuTM7+h6Q4O3JMZ4Q2EKJvUZhVl7MjnTq3BzElL
 HNKg==
X-Gm-Message-State: AOJu0YwMqC8UpRP8TaXkeFzPrs3eNXyS+b8gN5cs/df8b34I2cMW/f9b
 qM7fvYrzT3ZaN9DYzl76g82ja2RbWJwq7JUWIejtLoaa2719ICnzf2LZxOwm
X-Google-Smtp-Source: AGHT+IHM7+bDwhtPN8JRaFblhESriQEG63pRAgEs3bcOLucy4h6vswm/KolMmVtpw9eFYkEeX89cHg==
X-Received: by 2002:a17:906:240b:b0:a38:174c:c985 with SMTP id
 z11-20020a170906240b00b00a38174cc985mr393327eja.63.1707429843306; 
 Thu, 08 Feb 2024 14:04:03 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVpl7cnf1xCI3cTOlfIoD2TzMKJGzsvRabKLL8tBxJD2akCLPyjkk05lDjhMGbdkxLop0Ba4BihCP25/3h5JWb0JxKl26R+gyVb6L4vzBEQ43L7VWkHf26E+Pc4ED+KKD65wiOWJSVOJ3BhRRNjCqPlyt9jL43u0v9K4SGCYEshiVFmiJ+8L8YFBn9UboBJpZ2JgISbe1514AdKTee7UD8vE7w1HSw/D+daZTeSVQaVlDfql5F+
Received: from archlinux.. (pd95ed842.dip0.t-ipconnect.de. [217.94.216.66])
 by smtp.gmail.com with ESMTPSA id
 ti9-20020a170907c20900b00a3109a492d4sm109753ejc.20.2024.02.08.14.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Feb 2024 14:04:02 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 6/9] hw/i386/pc: Confine system flash handling to pc_sysfw
Date: Thu,  8 Feb 2024 23:03:46 +0100
Message-ID: <20240208220349.4948-7-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240208220349.4948-1-shentey@gmail.com>
References: <20240208220349.4948-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Rather than distributing PC system flash handling across three files, let's
confine it to one. Now, pc_system_firmware_init() creates, configures and cleans
up the system flash which makes the code easier to understand. It also avoids
the extra call to pc_system_flash_cleanup_unused() in the Xen case.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/i386/pc.h | 2 --
 hw/i386/pc.c         | 1 -
 hw/i386/pc_piix.c    | 1 -
 hw/i386/pc_sysfw.c   | 6 ++++--
 4 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 0e6c41e908..77228822f5 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -191,8 +191,6 @@ void pc_i8259_create(ISABus *isa_bus, qemu_irq *i8259_irqs);
 #define TYPE_PORT92 "port92"
 
 /* pc_sysfw.c */
-void pc_system_flash_create(PCMachineState *pcms);
-void pc_system_flash_cleanup_unused(PCMachineState *pcms);
 void pc_system_firmware_init(PCMachineState *pcms, MemoryRegion *rom_memory);
 bool pc_system_ovmf_table_find(const char *entry, uint8_t **data,
                                int *data_len);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 369c21fb99..4e73cd8a3b 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1740,7 +1740,6 @@ static void pc_machine_initfn(Object *obj)
 #endif
     pcms->default_bus_bypass_iommu = false;
 
-    pc_system_flash_create(pcms);
     pcms->pcspk = isa_new(TYPE_PC_SPEAKER);
     object_property_add_alias(OBJECT(pcms), "pcspk-audiodev",
                               OBJECT(pcms->pcspk), "audiodev");
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 5addaae978..5c928ac71b 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -232,7 +232,6 @@ static void pc_init1(MachineState *machine,
         assert(machine->ram_size == x86ms->below_4g_mem_size +
                                     x86ms->above_4g_mem_size);
 
-        pc_system_flash_cleanup_unused(pcms);
         if (machine->kernel_filename != NULL) {
             /* For xen HVM direct kernel boot, load linux here */
             xen_load_linux(pcms);
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index c8d9e71b88..b4c3833352 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -91,7 +91,7 @@ static PFlashCFI01 *pc_pflash_create(PCMachineState *pcms,
     return PFLASH_CFI01(dev);
 }
 
-void pc_system_flash_create(PCMachineState *pcms)
+static void pc_system_flash_create(PCMachineState *pcms)
 {
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
 
@@ -103,7 +103,7 @@ void pc_system_flash_create(PCMachineState *pcms)
     }
 }
 
-void pc_system_flash_cleanup_unused(PCMachineState *pcms)
+static void pc_system_flash_cleanup_unused(PCMachineState *pcms)
 {
     char *prop_name;
     int i;
@@ -212,6 +212,8 @@ void pc_system_firmware_init(PCMachineState *pcms,
         return;
     }
 
+    pc_system_flash_create(pcms);
+
     /* Map legacy -drive if=pflash to machine properties */
     for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
         pflash_cfi01_legacy_drive(pcms->flash[i],
-- 
2.43.0


