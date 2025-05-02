Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CDDC3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 18:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAvZj-0004xO-0h; Fri, 02 May 2025 14:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAvZh-0004u7-GQ
 for qemu-devel@nongnu.org; Fri, 02 May 2025 14:57:29 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAvZe-0005QW-IC
 for qemu-devel@nongnu.org; Fri, 02 May 2025 14:57:29 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ac289147833so421327666b.2
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 11:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746212244; x=1746817044; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J7AMA5ZLAGtFwb46rBtPIk1KAapPoLENY9+BSCyDrfE=;
 b=ypk5WA1C4A/fcy518pQFbQm1rsFP/AKOFh01dgBEDWDoOmxOP3sXtmT09WB9yvQWSi
 8RtOZNBhtwlGoBO2L873D36F1+/58e1Dki+AtnktIpeXEGU+GUXJtmy3AO1xpNGbiDXN
 lcG9sOg3aUkkOZpDqsrsQSD/6NGh8CC0QOVs4ZHqDRwxf1d2E+GCwamjAH7vtGU6DgeT
 iBrf04sJSaEOQn0h6+SmBjTULCuDYa0G+uWNr5C2p0eY/2YB7hqQYcq2JykqFnGCXN9s
 yknay9yVlpnLYrImXePNrFqkwn3jffa7bb3pTcWM6yKTb+/gh79EHtzLNMlWuO7ZFSdK
 VOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746212244; x=1746817044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J7AMA5ZLAGtFwb46rBtPIk1KAapPoLENY9+BSCyDrfE=;
 b=hXcT+q1cJ2qz6ifFwIopnXZH+rQfbK4E+/1/213+U6vN7MTzBDIGKcxHb9ajfCMfks
 Df7LafNZa+oqiRBFYOXoJ5AB598ZIyy/gY+3DgTo224opFabLnTgm/nJEFNKMCCvePDO
 u+6oNY/u9mOMBBZ1pvnCSTkHQYdp6Xja02D8Rvz0oBciAdfrtjzaXNzGJJ1suqWTXXWm
 Cb13Xs5XdyJYrgAR1zFbD9AgyMZMvxf3EQ1Rbiz/UkdILZlMICYpkl8XnDnqwrzXPwhW
 rsR/BA9XK5zZKRQwBCO8Joab8kXMljgH6R+YKj9pSq2lp9RfgsdScvEiaJopxi6OTQF/
 Ut4Q==
X-Gm-Message-State: AOJu0YwV8SbunczQJAGd3ObGCyRGSGKXWx14mrTpH2nGyG9EGfLciynz
 AdFbE0wsgWCEi9kGGmH3S6tCwNFVGAg/CtkLhZLYJRonfM04bNMqijh5SXe3XSXqBVz8nBk126d
 H
X-Gm-Gg: ASbGncuvLnXU29vAb+7REISncPBoESTUB/WcYpK2bKPomTY9/YcrxIs85IXvfZDch7B
 6Plt1YS9s/4yftOZ9S+IHmWjDRa0cw+xP8ux3/0wyIJMnILDN+M8j7Slu8B7ZliTPVRKlaQVPEp
 lJ1c3STwK0yKrds0+a3B+6GeNteBY1f6n2OgjmwAxXHrxqyQJCCBKyrI4uAmZZvwgdpuTzndO15
 +mgmT3GXncdF7jyARYoKyy0cSoU8dqYCockBDxncy1uCFZ0jKMGRGA4YCh2EiOtIDPG0KPbMseM
 O0BS52gQ6qTtb9/+/fUJFvWs2ZMzLAJlXduVs2QpC8r7rm5nnP70phSuqRXTqtw5nIeF4F4SuKC
 uDqWVIeppWXaCyNcFrq2z
X-Google-Smtp-Source: AGHT+IHOrLBhP4Vy5pTvcWU5rKusvLwJVDj2lwtcu8T/Vt8PNpsjzBz9dIOC9aRjbDDGFPBU3I6dLg==
X-Received: by 2002:a17:907:86a3:b0:ace:6a25:f56a with SMTP id
 a640c23a62f3a-ad17ad89a93mr422212666b.29.1746212244582; 
 Fri, 02 May 2025 11:57:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1891a2d87sm86057966b.45.2025.05.02.11.57.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 02 May 2025 11:57:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Amit Shah <amit@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 05/19] hw/i386/x86: Remove
 X86MachineClass::fwcfg_dma_enabled field
Date: Fri,  2 May 2025 20:56:37 +0200
Message-ID: <20250502185652.67370-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502185652.67370-1-philmd@linaro.org>
References: <20250502185652.67370-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

The X86MachineClass::fwcfg_dma_enabled boolean was only used
by the pc-q35-2.6 and pc-i440fx-2.6 machines, which got
removed. Remove it and simplify.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/x86.h | 2 --
 hw/i386/microvm.c     | 3 ---
 hw/i386/multiboot.c   | 7 +------
 hw/i386/x86-common.c  | 3 +--
 hw/i386/x86.c         | 2 --
 5 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index fc460b82f82..29d37af11e6 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -29,8 +29,6 @@
 struct X86MachineClass {
     MachineClass parent;
 
-    /* use DMA capable linuxboot option rom */
-    bool fwcfg_dma_enabled;
     /* CPU and apic information: */
     bool apic_xrupt_override;
 };
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index e0daf0d4fc3..b1262fb1523 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -637,7 +637,6 @@ GlobalProperty microvm_properties[] = {
 
 static void microvm_class_init(ObjectClass *oc, const void *data)
 {
-    X86MachineClass *x86mc = X86_MACHINE_CLASS(oc);
     MicrovmMachineClass *mmc = MICROVM_MACHINE_CLASS(oc);
     MachineClass *mc = MACHINE_CLASS(oc);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
@@ -671,8 +670,6 @@ static void microvm_class_init(ObjectClass *oc, const void *data)
     hc->unplug_request = microvm_device_unplug_request_cb;
     hc->unplug = microvm_device_unplug_cb;
 
-    x86mc->fwcfg_dma_enabled = true;
-
     object_class_property_add(oc, MICROVM_MACHINE_RTC, "OnOffAuto",
                               microvm_machine_get_rtc,
                               microvm_machine_set_rtc,
diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index 6e6b96bc345..bfa7e8f1e83 100644
--- a/hw/i386/multiboot.c
+++ b/hw/i386/multiboot.c
@@ -153,7 +153,6 @@ int load_multiboot(X86MachineState *x86ms,
                    int kernel_file_size,
                    uint8_t *header)
 {
-    bool multiboot_dma_enabled = X86_MACHINE_GET_CLASS(x86ms)->fwcfg_dma_enabled;
     int i, is_multiboot = 0;
     uint32_t flags = 0;
     uint32_t mh_entry_addr;
@@ -402,11 +401,7 @@ int load_multiboot(X86MachineState *x86ms,
     fw_cfg_add_bytes(fw_cfg, FW_CFG_INITRD_DATA, mb_bootinfo_data,
                      sizeof(bootinfo));
 
-    if (multiboot_dma_enabled) {
-        option_rom[nb_option_roms].name = "multiboot_dma.bin";
-    } else {
-        option_rom[nb_option_roms].name = "multiboot.bin";
-    }
+    option_rom[nb_option_roms].name = "multiboot_dma.bin";
     option_rom[nb_option_roms].bootindex = 0;
     nb_option_roms++;
 
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index 1b0671c5239..27254a0e9f1 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -634,7 +634,6 @@ void x86_load_linux(X86MachineState *x86ms,
                     int acpi_data_size,
                     bool pvh_enabled)
 {
-    bool linuxboot_dma_enabled = X86_MACHINE_GET_CLASS(x86ms)->fwcfg_dma_enabled;
     uint16_t protocol;
     int setup_size, kernel_size, cmdline_size;
     int dtb_size, setup_data_offset;
@@ -993,7 +992,7 @@ void x86_load_linux(X86MachineState *x86ms,
 
     option_rom[nb_option_roms].bootindex = 0;
     option_rom[nb_option_roms].name = "linuxboot.bin";
-    if (linuxboot_dma_enabled && fw_cfg_dma_enabled(fw_cfg)) {
+    if (fw_cfg_dma_enabled(fw_cfg)) {
         option_rom[nb_option_roms].name = "linuxboot_dma.bin";
     }
     nb_option_roms++;
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index f80533df1c5..dbf104d60af 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -375,14 +375,12 @@ static void x86_machine_initfn(Object *obj)
 static void x86_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
-    X86MachineClass *x86mc = X86_MACHINE_CLASS(oc);
     NMIClass *nc = NMI_CLASS(oc);
 
     mc->cpu_index_to_instance_props = x86_cpu_index_to_props;
     mc->get_default_cpu_node_id = x86_get_default_cpu_node_id;
     mc->possible_cpu_arch_ids = x86_possible_cpu_arch_ids;
     mc->kvm_type = x86_kvm_type;
-    x86mc->fwcfg_dma_enabled = true;
     nc->nmi_monitor_handler = x86_nmi;
 
     object_class_property_add(oc, X86_MACHINE_SMM, "OnOffAuto",
-- 
2.47.1


