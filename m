Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3200C54791
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 19:26:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj2J2-00040e-PW; Sat, 09 Mar 2024 14:24:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2J0-0003oT-Re
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:24:26 -0500
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2Iy-0002mV-CT
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:24:26 -0500
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2d382a78c38so36700091fa.1
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 11:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710012262; x=1710617062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gNfhZGSEMDNFGE0Bt1N9Am3VGUZ7rx8bc74P/nXROpw=;
 b=ne1rZ2Vf3nDTNU1KeRP3pQ0Lt+fHPTUsppkIg+7v1TPYIUOiMcBQXh6XwMaUTYVhVd
 RMJfoLOozhUJTEGaj+XOBH4Ry/zMU9JYd30J3FLYBWOqOFJNyo6APzniQP8MJtDYnCmE
 02+SQsQmgQk69x9Qz7GfydSlp3iZlxgD5SCpSd9ehFL3KKbvtP6Kico/FFA4WjYdIPZg
 BjX8lQKkKxZUjhsJ1NCAB2+bNrwbcY37axSFYxl66KVESr6oMs5Gc8EOp8SaqZbuV6Nh
 uJVNBOcP4aFnNkihA3/ejWlspGhk02ondPBcgPvRz8fVfBmzjizdfZZw5WyZApNZDjsx
 4vxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710012262; x=1710617062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gNfhZGSEMDNFGE0Bt1N9Am3VGUZ7rx8bc74P/nXROpw=;
 b=Jnz8+X5qauhyNFMItKW4YYZX4zmdutuDqS9ZKcWbAyO7k1+s9iqXPUB/aZNRjENQHW
 CQA9vdw1ywBTGLelFdR0/SvZc6kYWqzeyWwmeOB+q+2jde2iemJLBO2vXn4slXuA3PdV
 Tg6UO6QDKI4FU2pqPj7UJDjBDwhc3ndcMpQsMD3BC7lr4SE7+eWUEXfK2A8NM8ZxV2Ok
 SFMWkdGIPas1LHD1Yj0DKDHqifFp/uAb0S59Vw++FD/4ihqitCStVakngSH/v6vfPk1x
 yNXwpJehiTYLeYbFKVUKXFSzFfW0l5JwR8JEqrF84rdQRnbd2bxVNkrk4MhnwOtJ2sOZ
 5fFA==
X-Gm-Message-State: AOJu0Yzu/VwPKZG7OF3qCQPNQLtM4l64znpEnTeAn4+OqBX9gGEuWBAo
 jQ/LyE4CtHJgHPMXmS01EAR5no4SUhtopZTJ4I3z7+dcePYRxCEknqU6VkWsBtZ4QQSLyRka0e1
 8
X-Google-Smtp-Source: AGHT+IH6VnIz1HhzZeWVzNFZZ81KnZan2vqiOitrnrYT+7W7ejewWsh1Bm28ZWgBPoyVvTrmJWk+3w==
X-Received: by 2002:ac2:484a:0:b0:513:3741:7357 with SMTP id
 10-20020ac2484a000000b0051337417357mr1595051lfy.56.1710012262092; 
 Sat, 09 Mar 2024 11:24:22 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.237])
 by smtp.gmail.com with ESMTPSA id
 l6-20020a1709060e0600b00a42ea946917sm1177309eji.130.2024.03.09.11.24.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 09 Mar 2024 11:24:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 21/43] hw/i386/pc: Remove 'host_type' argument from pc_init1()
Date: Sat,  9 Mar 2024 20:21:48 +0100
Message-ID: <20240309192213.23420-22-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240309192213.23420-1-philmd@linaro.org>
References: <20240309192213.23420-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
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

All callers use host_type=TYPE_I440FX_PCI_HOST_BRIDGE.
Directly use this definition within pc_init1().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240301185936.95175-4-philmd@linaro.org>
---
 hw/i386/pc_piix.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index ed777e3d61..e14dce951d 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -101,8 +101,7 @@ static void piix_intx_routing_notifier_xen(PCIDevice *dev)
 }
 
 /* PC hardware initialisation */
-static void pc_init1(MachineState *machine,
-                     const char *host_type, const char *pci_type)
+static void pc_init1(MachineState *machine, const char *pci_type)
 {
     PCMachineState *pcms = PC_MACHINE(machine);
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
@@ -194,7 +193,7 @@ static void pc_init1(MachineState *machine,
         memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
         rom_memory = pci_memory;
 
-        phb = OBJECT(qdev_new(host_type));
+        phb = OBJECT(qdev_new(TYPE_I440FX_PCI_HOST_BRIDGE));
         object_property_add_child(OBJECT(machine), "i440fx", phb);
         object_property_set_link(phb, PCI_HOST_PROP_RAM_MEM,
                                  OBJECT(ram_memory), &error_fatal);
@@ -451,7 +450,7 @@ static void pc_compat_2_0_fn(MachineState *machine)
 #ifdef CONFIG_ISAPC
 static void pc_init_isa(MachineState *machine)
 {
-    pc_init1(machine, TYPE_I440FX_PCI_HOST_BRIDGE, TYPE_I440FX_PCI_DEVICE);
+    pc_init1(machine, TYPE_I440FX_PCI_DEVICE);
 }
 #endif
 
@@ -461,9 +460,7 @@ static void pc_xen_hvm_init_pci(MachineState *machine)
     const char *pci_type = xen_igd_gfx_pt_enabled() ?
                 TYPE_IGD_PASSTHROUGH_I440FX_PCI_DEVICE : TYPE_I440FX_PCI_DEVICE;
 
-    pc_init1(machine,
-             TYPE_I440FX_PCI_HOST_BRIDGE,
-             pci_type);
+    pc_init1(machine, pci_type);
 }
 
 static void pc_xen_hvm_init(MachineState *machine)
@@ -488,8 +485,7 @@ static void pc_xen_hvm_init(MachineState *machine)
         if (compat) { \
             compat(machine); \
         } \
-        pc_init1(machine, TYPE_I440FX_PCI_HOST_BRIDGE, \
-                 TYPE_I440FX_PCI_DEVICE); \
+        pc_init1(machine, TYPE_I440FX_PCI_DEVICE); \
     } \
     DEFINE_PC_MACHINE(suffix, name, pc_init_##suffix, optionfn)
 
-- 
2.41.0


