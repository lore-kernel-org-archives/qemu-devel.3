Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE3DE77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:00:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX5yv-0005Ik-9X; Sun, 12 Jan 2025 16:58:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX5yt-0005IG-D9
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 16:58:51 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX5yr-0003lo-Mm
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 16:58:51 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4361c705434so26096655e9.3
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 13:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736719128; x=1737323928; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BYtEthfQnNCOi+UxhhX8J2P0h82CeZqIE84msWKC75k=;
 b=MmO003ihHQMrDgoW6ZWQi+x8wpry2njg2/YHzE31KW/Hqmhqk/5x3PRgso4o0XAcgn
 qhGGQLJgujVnMCf0SSrbYsrc22yBipPb+7O9bNANdtor60+3535o2GHsAt8jhDqjCoTA
 ddORZKFTOLCUYbIqkGxYLE+pmo68BquUsjajPWPXcMYFPXVC/Q8rC1cu7wHk3ujegaNr
 ZU0ra8dd/vJ/JOYQKnXL30kOmrQXobFryPMUF4qYByv92YBkqEWWfT4R6UXu/xz5U+IJ
 3c2rT2Cp677VvK8GeJddSoTQkfDMctCw5fH8BBoRFqu7eAIwPOw63+yh0GnCj+OpHUwT
 ZRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736719128; x=1737323928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BYtEthfQnNCOi+UxhhX8J2P0h82CeZqIE84msWKC75k=;
 b=KLiREg3nxh3ZjtmItnkuU8W987wfJaC0suXpY2r+39fd5jVtFuKHOqakCzruiTpteN
 I46cl42usymRE27pDJUx5XNBEwbWDAbcKzK20jF9C56wCelhCshCGBqcarR8x2WF0xQJ
 ON5ZvdgsQIdgGKfZ8G4QrgNmqYvgiXdc5fhJfm+OHFYGaabujuCj5/t3cgHw/nlbzDXr
 wTQLLyREDM7DKBFTkQMVWh9wV7V+BN1GVUwmxnUJA6FuObpMYwqxK0w9WJU6nEEdy4RC
 XyGRmHds7i1yfrJXyQjavxayqpwqqflOFzjI5hGo43p6LQoDi/qmYy8gUaXdebcLr2Mn
 /VVA==
X-Gm-Message-State: AOJu0YzttOuZ7gmpMKZMp28ix/PfMTVIrzgqlCPM4DTpXSp14g9lomkj
 Yp8FqX665lUJ9u2swFtnoLe7updsIQBAOwJrxF8sNiZk5/3uhxdQp2XjcRMDr6iAT3ZY6RRSHLX
 b6JU=
X-Gm-Gg: ASbGnctkLjvJw1SUjxMMEXxCPFXfJVjUobQ0WvUcZ/pcBTeVfKhRUuK9xggG/6RbVJZ
 Jwg4LTJk1At17Js4bwkUc8bUBeilJ1vBwc7gdVWwsglq/AyRV68P0XPAso9rTzWWz+8npYRam1a
 taldA3pJxzp0877iGycxWsrAChj3umXIhvKnRkmawGB0xVtEqcfV6iIz1rFHFq0YtsRLBP1Diqp
 NOlf1oaN5+Yti1Gc7TqI4HMtcT+WjEOMEugXv1a+gdmmS6/IZgRyLan0+Qe9vsKuqo8aSTlo+Wn
 0UCeqjPosRx3aNlbjuduNCIS0IOTVaU=
X-Google-Smtp-Source: AGHT+IFT+BdNYtV47Gvk4jalDPFRU8JxqAPd85oAsAR/zykpSvnZ/vlJv2PVtT37Vg+o2+8DfmZ+/w==
X-Received: by 2002:a05:6000:154f:b0:386:373f:47c4 with SMTP id
 ffacd0b85a97d-38a873579b3mr15575811f8f.49.1736719127908; 
 Sun, 12 Jan 2025 13:58:47 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4b81d7sm10567949f8f.73.2025.01.12.13.58.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 13:58:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 02/11] hw/mips/loongson3_virt: Keep reference of vCPUs in
 machine_init()
Date: Sun, 12 Jan 2025 22:58:26 +0100
Message-ID: <20250112215835.29320-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112215835.29320-1-philmd@linaro.org>
References: <20250112215835.29320-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Keep references of all vCPUs created. That allows
to directly access the first vCPU without using the
&first_cpu global.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/loongson3_virt.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 47d112981a2..4b19941c1dc 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -492,9 +492,8 @@ static void mips_loongson3_virt_init(MachineState *machine)
 {
     int i;
     long bios_size;
-    MIPSCPU *cpu;
+    g_autofree MIPSCPU **cpus = NULL;
     Clock *cpuclk;
-    CPUMIPSState *env;
     DeviceState *liointc;
     DeviceState *ipi = NULL;
     char *filename;
@@ -569,13 +568,16 @@ static void mips_loongson3_virt_init(MachineState *machine)
     cpuclk = clock_new(OBJECT(machine), "cpu-refclk");
     clock_set_hz(cpuclk, DEF_LOONGSON3_FREQ);
 
+    cpus = g_new(MIPSCPU *, machine->smp.cpus);
     for (i = 0; i < machine->smp.cpus; i++) {
+        MIPSCPU *cpu;
         int node = i / LOONGSON3_CORE_PER_NODE;
         int core = i % LOONGSON3_CORE_PER_NODE;
         int ip;
 
         /* init CPUs */
         cpu = mips_cpu_create_with_clock(machine->cpu_type, cpuclk, false);
+        cpus[i] = cpu;
 
         /* Init internal devices */
         cpu_mips_irq_init_cpu(cpu);
@@ -609,7 +611,6 @@ static void mips_loongson3_virt_init(MachineState *machine)
                                pin, cpu->env.irq[ip + 2]);
         }
     }
-    env = &MIPS_CPU(first_cpu)->env;
 
     /* Allocate RAM/BIOS, 0x00000000~0x10000000 is alias of 0x80000000~0x90000000 */
     memory_region_init_rom(bios, NULL, "loongson3.bios",
@@ -640,7 +641,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
         loaderparams.kernel_filename = kernel_filename;
         loaderparams.kernel_cmdline = kernel_cmdline;
         loaderparams.initrd_filename = initrd_filename;
-        loaderparams.kernel_entry = load_kernel(env);
+        loaderparams.kernel_entry = load_kernel(&cpus[0]->env);
 
         init_boot_rom();
         init_boot_param();
-- 
2.47.1


