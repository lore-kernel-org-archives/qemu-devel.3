Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC64EE3691
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:49:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqXvG-0005kB-DM; Thu, 12 Feb 2026 09:44:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXux-0005Nm-Qw
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXuZ-000636-Ph
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770907399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zub/LVsTjWjVZ5bQ3GCjLklkh++VWzGkXKT/zQbO43U=;
 b=EWkf+97R1+nPSCuUhTnY1XamX52zdfmcEc/99j7KNx2DIDgqEcNtFX+3ATiLMElA1JPncb
 jVccxynmPJNQnjZZ19XVnaFFqAlUmvptddGMGAR1aGtT5bfl6UqgcARBkTF100Qt1N/K3i
 2au3kBU6W6vBW/vPqb11VQNDWPGIC2U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-44Ebw3feN2uC8aaiGlI7NQ-1; Thu, 12 Feb 2026 09:43:18 -0500
X-MC-Unique: 44Ebw3feN2uC8aaiGlI7NQ-1
X-Mimecast-MFC-AGG-ID: 44Ebw3feN2uC8aaiGlI7NQ_1770907397
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43623cfb160so5112845f8f.1
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770907396; x=1771512196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zub/LVsTjWjVZ5bQ3GCjLklkh++VWzGkXKT/zQbO43U=;
 b=L8IQsiE1ilMfmjLgpwE0qQmWVAwJ4Ho8QZxQc+G8Lb+objeBcZ79TruYvvzx0W8/Uj
 tXOgGkSDK4LdXnCwWjl+RtX0/jih/SVfDEhO9Z+vI95Wf5CuBPdGfZ13BYmDUiq+z4VL
 gqF9v5fTeWph9V3prVs1J1PlbHsb4yf0u3+RmYv1h+YZtZC5MOdYR8FoPh0fZBIcKqr/
 fycjaCgB4GTJr08KDfpH4X9DTmkouMwMxMrMfIajz7fHIQY72S6ADRfaMvadqZR7m6Kx
 15YZApD2d3467T0AfXZ38lNlr+9n3jDbj5KZ5qPxxGHpP/zQIpuVCATxi0jMKMZ279mo
 K5PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770907396; x=1771512196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Zub/LVsTjWjVZ5bQ3GCjLklkh++VWzGkXKT/zQbO43U=;
 b=SWFh+5LzScWpp7AQlSQmW0OkKV3arlri6tBWgh7hqFgpO95DIxSxg/dxI6Ta0+BZDG
 TXTXXS05uj9T0hyIvyFVPfLytlr+np38cgJLiQdOLKHqJQnIXjNrz2m6JfXBuPDOo1jX
 bVIYgWRDaGTZekwC6621cU77zIFVJdp65hyTS7xcfB6AG+Sc/k6EI/W7plseJuW77XO2
 BbwkQ+wleBL9H1aKP7FHf9ce88MbW9S63tKf0Flzyb4VKv2gNYcC5CPlN1+KJMs9bD7p
 EgvuSnCFrDKQAlEf/YhVFwpfc039vDNIzmtNM7jZVOkyj55/MPgAoVlkalldLd7XkgAt
 +mfg==
X-Gm-Message-State: AOJu0Yz/UIrHGeTwQUjec0zAq4x+r+nne9w3QdFbh1ER+pBl0hpdVPkF
 Rjm54E1zW9ngHNSbZgWvv+IgCaw8Q94Bapp90pgQfSlYIC+53aYkZxgM6rXPqfgW9O1vRmb4p6K
 KYfxEcmmUL4SAjqYJ65VTOFXYt9+n+H4nHow+937C3LzigpMWOMQWMkO9gCXVzk3V9RxB05SCdy
 S29SZCgnSKAaa6UD8ciK1l/rsbTuUwXCDFo3ViUq43
X-Gm-Gg: AZuq6aJGQyBaILHm5kMJm39PKcC2m3wtInsl4tZMSt8j2upciiJp8+gZ3zHXTRiE4Pi
 fwrsuhTal2ZG6iyOrI4NMymX0QEkS3oBMXDKeb+P9oQ1JyPeA0dQUL3WC2V0KBMNja/lGKsg2mO
 XDbJVdMXFPW9VoM4z+QJtFJeCdn8yAaAL8R3q658RsVZNJMBrkkSAb3Fb8g5/ggQ19b/uJx3UtI
 yTNyNy+LMl2G0XCU7bFcTBpTrzo3N7cyfuXkUQqZA6Zl4OE91FOuMJTPJQDOWz9z16cxxDxAcs8
 UyZbm/DRsm9IEwx65B9UiLIORwCZ8InVZROWEq9e/YNIAheAPRAA5I+/BkhgVvcpO/Z4uSVf0zl
 bCeCpadXqkHvmj3ZeiR2fcS6zmzJmVeg4S7ponltJWS5b0rm43SP5ZS4Jq9j0uMB8FGi8wVyIwZ
 k5b0LCGlxOnGUvGi6Jgq19qdjt18XUhLAr37YvvoWtNfnX5EmDbzE=
X-Received: by 2002:a5d:5f55:0:b0:437:7168:af52 with SMTP id
 ffacd0b85a97d-4378aa021c2mr5864555f8f.11.1770907396168; 
 Thu, 12 Feb 2026 06:43:16 -0800 (PST)
X-Received: by 2002:a5d:5f55:0:b0:437:7168:af52 with SMTP id
 ffacd0b85a97d-4378aa021c2mr5864479f8f.11.1770907395609; 
 Thu, 12 Feb 2026 06:43:15 -0800 (PST)
Received: from [10.60.241.123] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783d56b44sm12344505f8f.16.2026.02.12.06.43.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 06:43:12 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 13/41] hw/i386/x86: Remove X86MachineClass::fwcfg_dma_enabled
 field
Date: Thu, 12 Feb 2026 15:42:15 +0100
Message-ID: <20260212144244.22579-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212144244.22579-1-pbonzini@redhat.com>
References: <20260212144244.22579-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The X86MachineClass::fwcfg_dma_enabled boolean was only used
by the pc-q35-2.6 and pc-i440fx-2.6 machines, which got
removed. Remove it and simplify.

'multiboot.bin' isn't used anymore, we'll remove it in the
next commit.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20260108033051.777361-13-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/i386/x86.h | 2 --
 hw/i386/microvm.c     | 3 ---
 hw/i386/multiboot.c   | 7 +------
 hw/i386/x86-common.c  | 3 +--
 hw/i386/x86.c         | 2 --
 5 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index 0dffba95f9a..23be6274377 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -30,8 +30,6 @@
 struct X86MachineClass {
     MachineClass parent;
 
-    /* use DMA capable linuxboot option rom */
-    bool fwcfg_dma_enabled;
     /* CPU and apic information: */
     bool apic_xrupt_override;
 };
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 8cf99ad6623..7ff20512636 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -640,7 +640,6 @@ GlobalProperty microvm_properties[] = {
 
 static void microvm_class_init(ObjectClass *oc, const void *data)
 {
-    X86MachineClass *x86mc = X86_MACHINE_CLASS(oc);
     MicrovmMachineClass *mmc = MICROVM_MACHINE_CLASS(oc);
     MachineClass *mc = MACHINE_CLASS(oc);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
@@ -674,8 +673,6 @@ static void microvm_class_init(ObjectClass *oc, const void *data)
     hc->unplug_request = microvm_device_unplug_request_cb;
     hc->unplug = microvm_device_unplug_cb;
 
-    x86mc->fwcfg_dma_enabled = true;
-
     object_class_property_add(oc, MICROVM_MACHINE_RTC, "OnOffAuto",
                               microvm_machine_get_rtc,
                               microvm_machine_set_rtc,
diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index 8b6acfee9ba..0e960a15dda 100644
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
index 85b90ff4324..192e91042f2 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -645,7 +645,6 @@ void x86_load_linux(X86MachineState *x86ms,
                     int acpi_data_size,
                     bool pvh_enabled)
 {
-    bool linuxboot_dma_enabled = X86_MACHINE_GET_CLASS(x86ms)->fwcfg_dma_enabled;
     uint16_t protocol;
     int setup_size, kernel_size, cmdline_size;
     int dtb_size, setup_data_offset;
@@ -1004,7 +1003,7 @@ void x86_load_linux(X86MachineState *x86ms,
 
     option_rom[nb_option_roms].bootindex = 0;
     option_rom[nb_option_roms].name = "linuxboot.bin";
-    if (linuxboot_dma_enabled && fw_cfg_dma_enabled(fw_cfg)) {
+    if (fw_cfg_dma_enabled(fw_cfg)) {
         option_rom[nb_option_roms].name = "linuxboot_dma.bin";
     }
     nb_option_roms++;
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index c29856c810a..01872cba073 100644
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
2.52.0


