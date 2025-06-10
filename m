Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E9FC5B543
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 13:02:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOyXR-0006dn-1E; Tue, 10 Jun 2025 08:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyXP-0006dc-KM
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:57:11 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyXN-0002bp-0O
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:57:11 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43ea40a6e98so68231575e9.1
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 05:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749560227; x=1750165027; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xJktEGesb57H1K7TS/YxXCRYfzhDd1PRqPB5jPa4EVc=;
 b=Qns5WSH1Zw1AZauWb0DPt62QIp5BmydrO9Lkz0Zmvnpp1WyBvLRPooRbmPYABv6VCL
 dzxaoQ3bEJBfP0nqXxaBm/FiDT1IfYbQlrnrSMKVxdfT8l723AoQ4+Yc8YDYSHmGrdPZ
 TwI/OUyHUPu1O84h1nAEajEJnlb35zD/OAZlASaPTA9zHcUdC7Y6LuL69A8Px6jXdlEt
 ae49af97tDrIgrtc0Namx9wEKZv8+J77FbNW6oLRFf/jTC23tJdrSj93za2GCTHeEBeK
 ot/YQLSfdvN6Mu4ynhYU5aRuyWeNEqi4jnz7QpucrwdhUG4x/sH22OiBpqBmwkmyACUc
 HWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749560227; x=1750165027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xJktEGesb57H1K7TS/YxXCRYfzhDd1PRqPB5jPa4EVc=;
 b=FyHKfd+3xBVCauCfzdtTx4AyTE9OwU1Ek+/bVRmAsnLS21SGS97RxvlUE0AjKYk2m4
 EA1j1xXhVIzMzq9pophhQLyY5KdasfCPidmt7DRgg0Cp0ZUbrTSusbQ5tg/geptuFLyV
 /7Drgo1ooyrK/h52QU9QArgn+TFPWmlkYbgJ7eOx+qJMZUQQ6haOg2GMF6aIzV/8EFcd
 9E5MJOSsKjbZlc+GEIaEWraNY1rNTm4nMPmqNjPI7MgsWS+KxcdhNRevEJlUE6r5NeXG
 36+5p5X8/0xWBTz31koj6AWGmZqCKfWH7njc0TCZE5D1907NErWkXDczCkSzbziwfELf
 fF1Q==
X-Gm-Message-State: AOJu0YxoAM/0LHUZwtrNXU7HTbIo3jGRH0N0rW3ESzccnsSS919nqVCp
 vkiu1vP4IlwH1m/OpCLgdf6Aq86tWmT6Xx8WNLvh8WnazB3+axRtvM8dMNYcXJEukjiMADa/FzD
 I5DwLDlQ=
X-Gm-Gg: ASbGnct2azTEUUwZNBEtlT8H0H65tZpZvseOn9MRvL3mdfkPb1Z1ji6xdRE9KId7xhG
 7+DKUD/rbCY2pOMl6wywfa1Csp7u2z9138XnOTEBJ/w7T7/sdTYbMWID5XjhSMgjEWYmQufplrh
 PlCrprJQoX7z3PSKG2P1vf9rx3N9DUXctJxaEQePEThnrHEzbKzW0anOEkQJrvqnz5OHkTajAf9
 bxV6bEA8PESkOZ5xdJCL9z9x9j3Zv2IqK1ZMCSLK69JBlPjtoOoKNqw9POTLPZkZbMW8BlHCXxo
 rh3KzSjQeuSJKk9Wn0V+l+RQBFyWH10WwIpo/MlIZdCRyea6XpoZbcvapn5U6jA+20X91gkFa5M
 IN9UW8Fi+2QvJ6hTFB0KiXHJg+vgtyrHHewPYz9XXBA==
X-Google-Smtp-Source: AGHT+IGSBkBsAbt60yhWLd4WbX+087ot2kU8vdzQ+AOh8/CxXgqIfPYlvlbqXNQSTX5Gm59+hF+UBA==
X-Received: by 2002:a05:600c:8210:b0:44b:eb56:1d45 with SMTP id
 5b1f17b1804b1-4531de1a1a6mr28731865e9.15.1749560226831; 
 Tue, 10 Jun 2025 05:57:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45209ce5045sm140173425e9.16.2025.06.10.05.57.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Jun 2025 05:57:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 07/24] hw/ppc/e500: Move clock and TB frequency to machine class
Date: Tue, 10 Jun 2025 14:56:16 +0200
Message-ID: <20250610125633.24411-8-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610125633.24411-1-philmd@linaro.org>
References: <20250610125633.24411-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Different machines have different frequencies so make this
configurable in machine class instead of using a hard coded constant.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Acked-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <431166f96ff12ff3dbc670d40544974415f11305.1748012109.git.balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/e500.h      |  4 ++++
 hw/ppc/e500.c      | 18 +++++++++---------
 hw/ppc/e500plat.c  |  2 ++
 hw/ppc/mpc8544ds.c |  2 ++
 4 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/e500.h b/hw/ppc/e500.h
index 01db102625f..00f490519c2 100644
--- a/hw/ppc/e500.h
+++ b/hw/ppc/e500.h
@@ -5,6 +5,8 @@
 #include "hw/platform-bus.h"
 #include "qom/object.h"
 
+#define PLATFORM_CLK_FREQ_HZ (400 * 1000 * 1000)
+
 struct PPCE500MachineState {
     /*< private >*/
     MachineState parent_obj;
@@ -37,6 +39,8 @@ struct PPCE500MachineClass {
     hwaddr pci_mmio_base;
     hwaddr pci_mmio_bus_base;
     hwaddr spin_base;
+    uint32_t clock_freq;
+    uint32_t tb_freq;
 };
 
 void ppce500_init(MachineState *machine);
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 809078a2c3a..dedd96b0574 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -79,8 +79,6 @@
 #define MPC85XX_ESDHC_IRQ          72
 #define RTC_REGS_OFFSET            0x68
 
-#define PLATFORM_CLK_FREQ_HZ       (400 * 1000 * 1000)
-
 struct boot_info
 {
     uint32_t dt_base;
@@ -120,7 +118,7 @@ static uint32_t *pci_map_create(void *fdt, uint32_t mpic, int first_slot,
 }
 
 static void dt_serial_create(void *fdt, unsigned long long offset,
-                             const char *soc, const char *mpic,
+                             const char *soc, uint32_t freq, const char *mpic,
                              const char *alias, int idx, bool defcon)
 {
     char *ser;
@@ -131,7 +129,7 @@ static void dt_serial_create(void *fdt, unsigned long long offset,
     qemu_fdt_setprop_string(fdt, ser, "compatible", "ns16550");
     qemu_fdt_setprop_cells(fdt, ser, "reg", offset, 0x100);
     qemu_fdt_setprop_cell(fdt, ser, "cell-index", idx);
-    qemu_fdt_setprop_cell(fdt, ser, "clock-frequency", PLATFORM_CLK_FREQ_HZ);
+    qemu_fdt_setprop_cell(fdt, ser, "clock-frequency", freq);
     qemu_fdt_setprop_cells(fdt, ser, "interrupts", 42, 2);
     qemu_fdt_setprop_phandle(fdt, ser, "interrupt-parent", mpic);
     qemu_fdt_setprop_string(fdt, "/aliases", alias, ser);
@@ -382,8 +380,7 @@ static int ppce500_load_device_tree(PPCE500MachineState *pms,
     int fdt_size;
     void *fdt;
     uint8_t hypercall[16];
-    uint32_t clock_freq = PLATFORM_CLK_FREQ_HZ;
-    uint32_t tb_freq = PLATFORM_CLK_FREQ_HZ;
+    uint32_t clock_freq, tb_freq;
     int i;
     char compatible_sb[] = "fsl,mpc8544-immr\0simple-bus";
     char *soc;
@@ -484,6 +481,9 @@ static int ppce500_load_device_tree(PPCE500MachineState *pms,
         if (kvmppc_get_hasidle(env)) {
             qemu_fdt_setprop(fdt, "/hypervisor", "has-idle", NULL, 0);
         }
+    } else {
+        clock_freq = pmc->clock_freq;
+        tb_freq = pmc->tb_freq;
     }
 
     /* Create CPU nodes */
@@ -564,12 +564,12 @@ static int ppce500_load_device_tree(PPCE500MachineState *pms,
      */
     if (serial_hd(1)) {
         dt_serial_create(fdt, MPC8544_SERIAL1_REGS_OFFSET,
-                         soc, mpic, "serial1", 1, false);
+                         soc, pmc->clock_freq, mpic, "serial1", 1, false);
     }
 
     if (serial_hd(0)) {
         dt_serial_create(fdt, MPC8544_SERIAL0_REGS_OFFSET,
-                         soc, mpic, "serial0", 0, true);
+                         soc, pmc->clock_freq, mpic, "serial0", 0, true);
     }
 
     /* i2c */
@@ -968,7 +968,7 @@ void ppce500_init(MachineState *machine)
         env->spr_cb[SPR_BOOKE_PIR].default_value = cs->cpu_index = i;
         env->mpic_iack = pmc->ccsrbar_base + MPC8544_MPIC_REGS_OFFSET + 0xa0;
 
-        ppc_booke_timers_init(cpu, PLATFORM_CLK_FREQ_HZ, PPC_TIMER_E500);
+        ppc_booke_timers_init(cpu, pmc->tb_freq, PPC_TIMER_E500);
 
         /* Register reset handler */
         if (!i) {
diff --git a/hw/ppc/e500plat.c b/hw/ppc/e500plat.c
index 775b9d8da00..4f1d659e723 100644
--- a/hw/ppc/e500plat.c
+++ b/hw/ppc/e500plat.c
@@ -93,6 +93,8 @@ static void e500plat_machine_class_init(ObjectClass *oc, const void *data)
     pmc->pci_mmio_base = 0xC00000000ULL;
     pmc->pci_mmio_bus_base = 0xE0000000ULL;
     pmc->spin_base = 0xFEF000000ULL;
+    pmc->clock_freq = PLATFORM_CLK_FREQ_HZ;
+    pmc->tb_freq = PLATFORM_CLK_FREQ_HZ;
 
     mc->desc = "generic paravirt e500 platform";
     mc->init = e500plat_init;
diff --git a/hw/ppc/mpc8544ds.c b/hw/ppc/mpc8544ds.c
index 97fb0f35ba9..582698559d2 100644
--- a/hw/ppc/mpc8544ds.c
+++ b/hw/ppc/mpc8544ds.c
@@ -55,6 +55,8 @@ static void mpc8544ds_machine_class_init(ObjectClass *oc, const void *data)
     pmc->pci_mmio_bus_base = 0xC0000000ULL;
     pmc->pci_pio_base = 0xE1000000ULL;
     pmc->spin_base = 0xEF000000ULL;
+    pmc->clock_freq = PLATFORM_CLK_FREQ_HZ;
+    pmc->tb_freq = PLATFORM_CLK_FREQ_HZ;
 
     mc->desc = "mpc8544ds";
     mc->init = mpc8544ds_init;
-- 
2.49.0


