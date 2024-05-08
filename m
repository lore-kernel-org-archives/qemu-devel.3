Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49801C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 17:49:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4lNL-0001Ix-6V; Wed, 08 May 2024 13:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4lMw-0000ZY-RS
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:46:22 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4lMu-0007fK-18
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:46:17 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-51fdc9af005so7098907e87.3
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 10:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715190373; x=1715795173; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6stDyKXFGIAMi9PnetBYz+6nX0n+ya95MLEN0LwCIIY=;
 b=eB0B7BxStzHWRsMhXhbLNWbrDUoA4Xo0mGw2OpZWyUNfFJOLbHmCVVgVVMdHs/F+do
 PNjxaq6pGdBnEg3vLoE4QbaU1TRHdKimXUzLJgBcC//BDXS54ZpKbT688O1Ug96uI5lN
 HU3GEXVG0Dvp6XdIopn66w2lGxPntERwLRUU8rt6U93pjx35LrOH0uxf0DCJx6XAOxEo
 edh76BGFmirj3JtPml/5Uop2e+N+EBjhJ5kC7LN90UARG1BS/deLZWOub6lc0Svfh1Xu
 zR9PYNBcaEYu0qADEe65rRszCj0yUNX6A1gH20sY0oo6s2AGX2JpKY0RZ0l71dMYTCAL
 kx2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715190373; x=1715795173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6stDyKXFGIAMi9PnetBYz+6nX0n+ya95MLEN0LwCIIY=;
 b=B+FMn6p4mvkgVivavjjbZrWbblSsYNvWpIdykOCBvVodl8XWqv97FuuqKnAWnEESB7
 YVkqqtZLUFkzOsNMLZQ8dH0lflSmOVl6pb6J55LOj2kvM1XjuFhM4VORhWwI6P3+8r2p
 0eSjcQ0IPITt24kOWxbL7wTS3DI/pxaOaeTJkWrMEELAnuPnd6tj9ONJm+4AQGuHmzMp
 cGmfF33Zd3YzqzGD7/vuLIKGFYlaOGD1CDrfyKI30y1iB78g9mkU0CNFt4y4QH21bLvC
 RYB9OMLFZyG4shn2h3W7V0jpSXgULLA0ITC9m54YutN654UZsD8ZSLoJ7k/E7eAuHd9g
 DQLA==
X-Gm-Message-State: AOJu0Yy9A9Ag/ojWRIaAgKKjN0FI4/RdeX2KUxlLJDRmazvavvZs1BQ9
 2LsYNFtKbmvHQTzI4czXHZVaKXNXadGkjzb+pYkH/0BAlDXsiAInwI1jmoivdNyFKFdianCDMtH
 w
X-Google-Smtp-Source: AGHT+IFDtPj91HHZf867uKJDZvpTgM2Vu5rcgiaVP+jt4Jpewi/J+mORZiXgK4Z4Wr//N2ftqO1tzQ==
X-Received: by 2002:ac2:5bc7:0:b0:51f:6ab6:9e5b with SMTP id
 2adb3069b0e04-5217c7605e0mr2635058e87.36.1715190373527; 
 Wed, 08 May 2024 10:46:13 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 wk16-20020a170907055000b00a59db6e54e2sm3290909ejb.85.2024.05.08.10.46.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 May 2024 10:46:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/26] hw/i386: Add the possibility to use i440fx and isapc
 without FDC
Date: Wed,  8 May 2024 19:44:55 +0200
Message-ID: <20240508174510.60470-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240508174510.60470-1-philmd@linaro.org>
References: <20240508174510.60470-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
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

From: Thomas Huth <thuth@redhat.com>

The i440fx and the isapc machines can be used in binaries without
FDC, too. We just have to make sure that they don't try to instantiate
the FDC when it is not available.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240425184315.553329-4-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 6 ++++--
 hw/i386/Kconfig   | 2 --
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 8850c49c66..99efb3c45c 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -317,8 +317,8 @@ static void pc_init1(MachineState *machine, const char *pci_type)
     }
 
     /* init basic PC hardware */
-    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc, true,
-                         0x4);
+    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
+                         !MACHINE_CLASS(pcmc)->no_floppy, 0x4);
 
     pc_nic_init(pcmc, isa_bus, pcms->pcibus);
 
@@ -501,6 +501,7 @@ static void pc_i440fx_machine_options(MachineClass *m)
     m->default_machine_opts = "firmware=bios-256k.bin";
     m->default_display = "std";
     m->default_nic = "e1000";
+    m->no_floppy = !module_object_class_by_name(TYPE_ISA_FDC);
     m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_VMBUS_BRIDGE);
@@ -931,6 +932,7 @@ static void isapc_machine_options(MachineClass *m)
     pcmc->has_reserved_memory = false;
     m->default_nic = "ne2k_isa";
     m->default_cpu_type = X86_CPU_TYPE_NAME("486");
+    m->no_floppy = !module_object_class_by_name(TYPE_ISA_FDC);
     m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
 }
 
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 58ca8f246d..40b1e44580 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -72,7 +72,6 @@ config I440FX
     imply VMPORT
     imply VMMOUSE
     select ACPI_PIIX4
-    select FDC_ISA
     select PC_PCI
     select PC_ACPI
     select PCI_I440FX
@@ -88,7 +87,6 @@ config ISAPC
     depends on I386
     imply VGA_ISA
     select ISA_BUS
-    select FDC_ISA
     select PC
     select IDE_ISA
     # FIXME: it is in the same file as i440fx, and does not compile
-- 
2.41.0


