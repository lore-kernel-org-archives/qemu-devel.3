Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBFCC54E66
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 19:31:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj2Lq-0001qr-3u; Sat, 09 Mar 2024 14:27:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2L8-0007xO-OE
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:26:40 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2L6-0003a5-72
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:26:38 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a460185d1a7so75796566b.0
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 11:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710012393; x=1710617193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+XiYruIl/Mk62y3f+ezGiMfqf4PWIQGmn/ntaltbgg8=;
 b=Cr32ogUMNB0hteF1iaaW05vW7XjpElPE8zvNhxVnw81+J0EDe9HxEIKbCrDfPKKuEQ
 TL/HuoIP2NcEvsf0SFxvmpXf17aOtmX2IXYTdg0J24JjW/UTtrHYvJoOKliK5FBjZveF
 fY6vlQ/w2qb/z8BazEx0tpMDJkgpijIlhYUHhRQUaCQN8H2ZuzXX9c2hqbE01OGJwFLm
 lTqxcFGm7VFNJIDFPZHQoAAZjnm8IZhnp+Mwb59idf6Y3aF29VzHpKlJl6z6jKVbx85P
 4Kim4sn4A1++dOJjyi5JYpk1P2NKz4jRu3eAPRihh5DXouWGcUMBKm8gsRgHn5CtG60S
 4K5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710012393; x=1710617193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+XiYruIl/Mk62y3f+ezGiMfqf4PWIQGmn/ntaltbgg8=;
 b=o1sMGGoZepxOlo53lvjwKgZUNLHUzvuj1mk/sKEkvGywPULyEnQGs+Tb/Y8BhppG9+
 suzs5EJryvRRyc107kyQlFaxIELz+mQDrxso32Wd0C/KB/7MqLcOn408RtkkyGrwpVSe
 W0efw4/oa43a4UuiaEfFuE311MhzC7t6ti2PhqzIUF9d51lzrex6a9iBDkQYUnG38AFE
 xg4EhKwRXYiDHPLHo2kA6wzGc/XosGCTXzw2Alk5zeD0qD+dZNOVa07+OwFldcRp7zLq
 qmMX4UGGXfIQ9CFDcXG1EIQhFXDXbI8WCldG2w6Ym3DLA3YtS1E2GGjXzeZPHNb/FERM
 zXgA==
X-Gm-Message-State: AOJu0YzDgDp8Oc/c3kIW3E/YHkY2zU5WbxA51niUwNyx98hM5gQJcs6y
 ahbCcRXmcj8iBx07EXVezYTWxKUmJYTquf9vWKeFaeWG9B27B+zr9iSVhof7oM7o9r4cgORp27f
 a
X-Google-Smtp-Source: AGHT+IF5fXiTsXQM4PqHHP471lMuzrbFz64dQ8BACzdPeoX2Pnz8+csmIkUXGA5SOpRFZc8lVkCELA==
X-Received: by 2002:a17:906:a1c8:b0:a44:1cb4:f496 with SMTP id
 bx8-20020a170906a1c800b00a441cb4f496mr1343853ejb.75.1710012393290; 
 Sat, 09 Mar 2024 11:26:33 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.237])
 by smtp.gmail.com with ESMTPSA id
 pw2-20020a17090720a200b00a456573f9c5sm1187380ejb.0.2024.03.09.11.26.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 09 Mar 2024 11:26:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Angelo Dureghello <angelo@kernel-space.org>,
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 43/43] hw/m68k/mcf5208: add support for reset
Date: Sat,  9 Mar 2024 20:22:10 +0100
Message-ID: <20240309192213.23420-44-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240309192213.23420-1-philmd@linaro.org>
References: <20240309192213.23420-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Angelo Dureghello <angelo@kernel-space.org>

Add reset support for mcf5208.

Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Message-ID: <20240309093459.984565-1-angelo@kernel-space.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/m68k/mcf5208.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index 0cfb806c20..ec14096aa4 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -40,6 +40,8 @@
 #define PCSR_PRE_SHIFT  8
 #define PCSR_PRE_MASK   0x0f00
 
+#define RCR_SOFTRST     0x80
+
 typedef struct {
     MemoryRegion iomem;
     qemu_irq irq;
@@ -185,12 +187,50 @@ static const MemoryRegionOps m5208_sys_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-static void mcf5208_sys_init(MemoryRegion *address_space, qemu_irq *pic)
+static uint64_t m5208_rcm_read(void *opaque, hwaddr addr,
+                               unsigned size)
+{
+    return 0;
+}
+
+static void m5208_rcm_write(void *opaque, hwaddr addr,
+                            uint64_t value, unsigned size)
+{
+    M68kCPU *cpu = opaque;
+    CPUState *cs = CPU(cpu);
+    switch (addr) {
+    case 0x0: /* RCR */
+        if (value & RCR_SOFTRST) {
+            cpu_reset(cs);
+            cpu->env.aregs[7] = ldl_phys(cs->as, 0);
+            cpu->env.pc = ldl_phys(cs->as, 4);
+        }
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX "\n",
+                      __func__, addr);
+        break;
+    }
+}
+
+static const MemoryRegionOps m5208_rcm_ops = {
+    .read = m5208_rcm_read,
+    .write = m5208_rcm_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static void mcf5208_sys_init(MemoryRegion *address_space, qemu_irq *pic,
+                             M68kCPU *cpu)
 {
     MemoryRegion *iomem = g_new(MemoryRegion, 1);
+    MemoryRegion *iomem_rcm = g_new(MemoryRegion, 1);
     m5208_timer_state *s;
     int i;
 
+    /* RCM */
+    memory_region_init_io(iomem_rcm, NULL, &m5208_rcm_ops, cpu,
+                          "m5208-rcm", 0x00000080);
+    memory_region_add_subregion(address_space, 0xfc0a0000, iomem_rcm);
     /* SDRAMC.  */
     memory_region_init_io(iomem, NULL, &m5208_sys_ops, NULL, "m5208-sys", 0x00004000);
     memory_region_add_subregion(address_space, 0xfc0a8000, iomem);
@@ -265,7 +305,7 @@ static void mcf5208evb_init(MachineState *machine)
     mcf_uart_create_mmap(0xfc064000, pic[27], serial_hd(1));
     mcf_uart_create_mmap(0xfc068000, pic[28], serial_hd(2));
 
-    mcf5208_sys_init(address_space_mem, pic);
+    mcf5208_sys_init(address_space_mem, pic, cpu);
 
     mcf_fec_init(address_space_mem, 0xfc030000, pic + 36);
 
-- 
2.41.0


