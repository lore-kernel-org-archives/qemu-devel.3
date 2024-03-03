Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B2BC48BF6
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Mar 2024 18:55:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgqyG-0002yx-LB; Sun, 03 Mar 2024 13:54:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rgqyB-0002xt-0f
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 13:53:55 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rgqy7-0003yQ-UA
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 13:53:53 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-412e2dfa58eso1419405e9.0
 for <qemu-devel@nongnu.org>; Sun, 03 Mar 2024 10:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709492029; x=1710096829; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XUX7oIApRf9quDNJaxBX4ag31s8+YagalHAQ+nw7IxU=;
 b=ggTdwN173rTdNhoCrb4/SDNIi/gwpFuTXUF+kPpZPSYwBioRMIShyvRvz1IVeGtobw
 pKp0cph+ejCAbcsmK9pk5C8Jrl+r7rDB8sB4Y5HPyAlA0DNK1kxNgKk5heHYNeKJ/PM1
 5BzG+Ua9ohHXQSI4q4KI72n/1f3NKjaRozDCz29USHt7jTVEF40D6rScWx6zPaGQcr93
 h11NkbHBTjbRmG6D9Y6ly8588ajZtaH0NvLAb5OR/OZSjj9EmRnq+LZaxhzKIa4SMzj2
 AGWtx3+YW2/yMXh4FVdygmSm7K89i22agQwNoau9F3VUdIFvttDJh67HN45bj9soet+t
 33uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709492029; x=1710096829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XUX7oIApRf9quDNJaxBX4ag31s8+YagalHAQ+nw7IxU=;
 b=falN2SQ/ScTv5i7IJ3pZCM1669qJT/NoHEpdLvx6DbYZi9rv4as1kMSiUOExOZIdf9
 6MeVGrD4dlrQKDGalunm3Z0fX4Y41rSZ4f3XKBDJwu9jI+IC3bZ0RcFbTejNc8h+vmiy
 gmjiW7mbBjJpWgxD43qp+hUooLIwkHF1BdbNxD+llOWJdoJSZDtrmJ96TL8J/wHl2laH
 LvSzcR5Q/ZbKyex2w1ycmrlaejSvbkfBhc/e35AP9hUCNTlWDnKzAhBs5EA7uJmMZbhk
 B4xymdL8IFwDWFfX6rvawqE7JTxY+fEeeLIxK/nHlngnawhc6pn0mbWUHjaNOmzEL0KB
 9hPQ==
X-Gm-Message-State: AOJu0YwuATaVmJ+AbY+HwXkdOU+Vct6Z16tjHzXnvnLSg17ZB8myGWK6
 Uxjg5usjnzakHz/ZKkpcDauNxqSPAxAZvUBU+Rir+DWIFpW37ssLf/xyklTJ
X-Google-Smtp-Source: AGHT+IFUSo8u73blocfm9TEjjHLhAMJGhFpEbLyicahfaMZeqb3X3wML28HjU0iOzGputokKSewqag==
X-Received: by 2002:a05:600c:3b94:b0:412:d1ee:dfa2 with SMTP id
 n20-20020a05600c3b9400b00412d1eedfa2mr3851295wms.0.1709492029404; 
 Sun, 03 Mar 2024 10:53:49 -0800 (PST)
Received: from archlinux.. (dynamic-092-224-118-014.92.224.pool.telefonica.de.
 [92.224.118.14]) by smtp.gmail.com with ESMTPSA id
 o17-20020a05600c4fd100b00412d68dbf75sm5259460wmq.35.2024.03.03.10.53.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Mar 2024 10:53:48 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sergio Lopez <slp@redhat.com>, Paul Durrant <paul@xen.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 4/4] hw/i386/pc: Inline pc_cmos_init() into
 pc_cmos_init_late() and remove it
Date: Sun,  3 Mar 2024 19:53:32 +0100
Message-ID: <20240303185332.1408-5-shentey@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240303185332.1408-1-shentey@gmail.com>
References: <20240303185332.1408-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x332.google.com
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

Now that pc_cmos_init() doesn't populate the X86MachineState::rtc attribute any
longer, its duties can be merged into pc_cmos_init_late() which is called within
machine_done notifier. This frees pc_piix and pc_q35 from explicit CMOS
initialization.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/i386/pc.h |  2 --
 hw/i386/pc.c         | 10 ----------
 hw/i386/pc_piix.c    |  2 --
 hw/i386/pc_q35.c     |  2 --
 4 files changed, 16 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 5065590281..bfdcd64514 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -178,8 +178,6 @@ void pc_basic_device_init(struct PCMachineState *pcms,
                           ISADevice *rtc_state,
                           bool create_fdctrl,
                           uint32_t hpet_irqs);
-void pc_cmos_init(PCMachineState *pcms,
-                  ISADevice *s);
 void pc_nic_init(PCMachineClass *pcmc, ISABus *isa_bus, PCIBus *pci_bus);
 
 void pc_i8259_create(ISABus *isa_bus, qemu_irq *i8259_irqs);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 7780d8d6dd..69e134e141 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -570,14 +570,6 @@ static void pc_cmos_init_late(PCMachineState *pcms)
     mc146818rtc_set_cmos_data(s, 0x39, val);
 
     pc_cmos_init_floppy(s, pc_find_fdc0());
-}
-
-void pc_cmos_init(PCMachineState *pcms,
-                  ISADevice *rtc)
-{
-    int val;
-    X86MachineState *x86ms = X86_MACHINE(pcms);
-    MC146818RtcState *s = MC146818_RTC(rtc);
 
     /* various important CMOS locations needed by PC/Bochs bios */
 
@@ -618,8 +610,6 @@ void pc_cmos_init(PCMachineState *pcms,
     val |= 0x02; /* FPU is there */
     val |= 0x04; /* PS/2 mouse installed */
     mc146818rtc_set_cmos_data(s, REG_EQUIPMENT_BYTE, val);
-
-    /* hard drives and FDC are handled by pc_cmos_init_late() */
 }
 
 static void handle_a20_line_change(void *opaque, int irq, int level)
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index ce6aad758d..637f4d38be 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -342,8 +342,6 @@ static void pc_init1(MachineState *machine,
     }
 #endif
 
-    pc_cmos_init(pcms, x86ms->rtc);
-
     if (piix4_pm) {
         smi_irq = qemu_allocate_irq(pc_acpi_smi_interrupt, first_cpu, 0);
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 45a4102e75..bccd13d162 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -311,8 +311,6 @@ static void pc_q35_init(MachineState *machine)
         smbus_eeprom_init(pcms->smbus, 8, NULL, 0);
     }
 
-    pc_cmos_init(pcms, x86ms->rtc);
-
     /* the rest devices to which pci devfn is automatically assigned */
     pc_vga_init(isa_bus, pcms->pcibus);
     pc_nic_init(pcmc, isa_bus, pcms->pcibus);
-- 
2.44.0


