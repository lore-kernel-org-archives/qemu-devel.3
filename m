Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C7CCF9C6F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 09:33:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssfPR-0001o7-MY; Mon, 23 Sep 2024 05:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssfPP-0001eR-5Y; Mon, 23 Sep 2024 05:31:07 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssfPN-0006wj-Cq; Mon, 23 Sep 2024 05:31:06 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a7aa086b077so540730966b.0; 
 Mon, 23 Sep 2024 02:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727083863; x=1727688663; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MGd/V7b3/Zz9r6wp7tpzWusPdgXCdziXM20jKtJvMrg=;
 b=PRbDOIaaVuJWoU7MTE8lFolwD/FpXSz/bwsBM2iR868OQ3SpTkDaUQDfp4/cT5n1y3
 TsjoGgeOqUhUoD2E8PYMXcRXluEmuJhc7pop0NAHOr1vF4Qe8wxD+KAB1ed2lW5BrLPL
 gL+AzwYxSME24tMl5qt5aConABzVEsbZc8DVBKFh4xANW5d8Nyg4cmkhBxjchGCAs79i
 bPmaDLdqRpPJ53EwdwYL9NiUDbB4R67BtRgVTlRfHzNcU9GL6vNqP5seUMnNiriE/mDp
 bFSB2loGR5t0r5LH3JRtK5LzIDRD6bNzS7vjhcXHTn9Hk7FSzXU7L/M8r0h+8HgSF2pH
 9PCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727083863; x=1727688663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MGd/V7b3/Zz9r6wp7tpzWusPdgXCdziXM20jKtJvMrg=;
 b=gJSQcvEVXcjvhkMCWe8CVnV6zJT5LbjBUNpTKFZSppkSTbAOcs/Pt9VcW4oHX8hniY
 FT/UGMXqt78PsXA+P7L3UoIlt9yV9BnG0Y5hswqyjRwETOmqXhwYCndskwm2rJLcfUQc
 27gtfmfvt+/P8xAhg8lcrotlKsUbcDVqPKj/zJ/fv9sr+nOU2MnKkOJu1C/OXPO5Popf
 BTys8Is/gKR9dQeQ6h5d8nkJ/cah2yCPfZDWibezLnLEKFzyZODBFGtaI9nJyqppurd7
 +GpuCx+sY6t0w/yA6+MJXEpDcLn1eftow98tnFCK7qDf9awpeY1Cxp7FtpdjMq7Wi93L
 6dpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0wzWY4UYB6Ikt//oNFvTr3PRYnhYASf9nLCSy7Y9uOt+nUkwRaQO97LzGlaHqnFg56HRDpIkEs3w=@nongnu.org,
 AJvYcCWHpUYeSPKe7fQj523c6Sj+kzRfhmTEmhc89IymlkkcmUL/ORdQn8LHqU85+KPsSwqtpzonWf9LVJ/r@nongnu.org
X-Gm-Message-State: AOJu0Yytnm2MFxGPGhCyCukEq4WUuu9Ub2bDxCPOVwYTWqp6rNKZZqhb
 HLaLCIHUe517GmOEGgYN0JN5HmYA8frYxcEMEqHRNOfngQrrdV5cExbs8A==
X-Google-Smtp-Source: AGHT+IFZV6X+LEmYS9LvHtJMLinZpKZu/as0ldzmato/mZN18YzhQpOjheM4uufr+/O8oqcvM2o5vA==
X-Received: by 2002:a17:907:9708:b0:a83:8591:7505 with SMTP id
 a640c23a62f3a-a90d5167dc8mr1306071866b.59.1727083862426; 
 Mon, 23 Sep 2024 02:31:02 -0700 (PDT)
Received: from archlinux.. (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612b3f6fsm1188747166b.107.2024.09.23.02.31.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2024 02:31:01 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-ppc@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 02/23] hw/ppc/e500: Reduce scope of env pointer
Date: Mon, 23 Sep 2024 11:29:55 +0200
Message-ID: <20240923093016.66437-3-shentey@gmail.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240923093016.66437-1-shentey@gmail.com>
References: <20240923093016.66437-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x631.google.com
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

The env pointer isn't used outside the for loop, so move it inside. After that,
the firstenv pointer is never read, so remove it.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/ppc/e500.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 75b051009f..f68779a1ea 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -899,7 +899,6 @@ void ppce500_init(MachineState *machine)
     const PPCE500MachineClass *pmc = PPCE500_MACHINE_GET_CLASS(machine);
     MachineClass *mc = MACHINE_CLASS(pmc);
     PCIBus *pci_bus;
-    CPUPPCState *env = NULL;
     uint64_t loadaddr;
     hwaddr kernel_base = -1LL;
     int kernel_size = 0;
@@ -921,7 +920,6 @@ void ppce500_init(MachineState *machine)
     IrqLines *irqs;
     DeviceState *dev, *mpicdev;
     DriveInfo *dinfo;
-    CPUPPCState *firstenv = NULL;
     MemoryRegion *ccsr_addr_space;
     SysBusDevice *s;
     PPCE500CCSRState *ccsr;
@@ -930,6 +928,7 @@ void ppce500_init(MachineState *machine)
     irqs = g_new0(IrqLines, smp_cpus);
     for (i = 0; i < smp_cpus; i++) {
         PowerPCCPU *cpu;
+        CPUPPCState *env;
         CPUState *cs;
 
         cpu = POWERPC_CPU(object_new(machine->cpu_type));
@@ -950,10 +949,6 @@ void ppce500_init(MachineState *machine)
                                  &error_abort);
         qdev_realize_and_unref(DEVICE(cs), NULL, &error_fatal);
 
-        if (!firstenv) {
-            firstenv = env;
-        }
-
         irqs[i].irq[OPENPIC_OUTPUT_INT] =
             qdev_get_gpio_in(DEVICE(cpu), PPCE500_INPUT_INT);
         irqs[i].irq[OPENPIC_OUTPUT_CINT] =
@@ -974,8 +969,6 @@ void ppce500_init(MachineState *machine)
         }
     }
 
-    env = firstenv;
-
     if (!QEMU_IS_ALIGNED(machine->ram_size, RAM_SIZES_ALIGN)) {
         error_report("RAM size must be multiple of %" PRIu64, RAM_SIZES_ALIGN);
         exit(EXIT_FAILURE);
-- 
2.46.1


