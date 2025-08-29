Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBEF8CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:32:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNHT-0000lZ-Sc; Sat, 30 Aug 2025 11:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryi5-0000yO-5D
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 09:00:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryi3-00089D-CL
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 09:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756472402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yxoy21IR96c+Q5DUdbsmFFGBfBDLqDyltAfmnPFJ63I=;
 b=jKubaDgeaIZrJB1PKQKMzLH0miypLUnrhdZWwJXksAIDcZa1FJIj9UXCBhoa4+q8A4usnw
 NUqQqGxbykl1MbmvDJmdhQXBwAc39L453YkMW4nZ/Mv1YdL+4eX8s4UhIsFSoOJyrftpTJ
 DqI8BGIJUpzNEi9pSScRTnd19sNFNk4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-Ama32dD4N3-_cD1UL_wOHw-1; Fri, 29 Aug 2025 09:00:00 -0400
X-MC-Unique: Ama32dD4N3-_cD1UL_wOHw-1
X-Mimecast-MFC-AGG-ID: Ama32dD4N3-_cD1UL_wOHw_1756472399
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45a1b0bd6a9so11531135e9.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 06:00:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756472398; x=1757077198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yxoy21IR96c+Q5DUdbsmFFGBfBDLqDyltAfmnPFJ63I=;
 b=axUYXNUhGWC8qA8dicht80IknMMgBan41tIHAzu4jZX+515r+w9XhNV04NkbdXSgVV
 5i5rAespkWv4OE28rl2meuetJb22moWiPgfJHYWbGNFtrOdstmyd+eRaZ0H/GdWG3wiD
 guhBbgu52lJB8nl7o6Gcm2J3j6nxzjMSzTuZhF9JiEEb7nMA+L4RuDBpTJe9L/kszVJa
 8PBZ1bQKTVTy1g/run9Z2eYjLia4rsWmq0iSY01hf+DN+4Ymd1B+tQQzeVjnEnqiJK3W
 jbFJm5/L8XG6lTvkgfFFQ6HWUAUu5bzbsq+bWu8JERtRsp8idrpGmUiTIwhPjW9kCewt
 hjSw==
X-Gm-Message-State: AOJu0YzPWfNMUQ4FNNZMXlcT/VgRgIF7M9kBLpuJ+58c2qBmi86lbJRJ
 0is1Hd4F5TxncsNS7jHZd/4rv0bGDEq42q1OX+7lyaBMISIcu9jVeatYix88CRHwHszY2pzjXj/
 CwjADm/rH9lbCu6AfbfyJanvm79K4cDEGGwgXgrJUDm0Ex4kMCHTPiwq9+0+zl/dmjLHUNn0ecM
 sMUMOor+sitlFz0MyUt/f1OWDbJRnSaL76tDtWhKoh
X-Gm-Gg: ASbGncsouyLIBHhzP0B6mV3PmzB3C5hHI5e2TbMebfMD7kD4Pg8wuv07j9VaD7a4NVD
 689PSOpNPmzFTvxi+WI7DpFC9mikbfcxUvJuquhvOkH6yuT2saRm0TjQRp+1g1PEidHv3ktGAYK
 xKSFyu4S4P1S6oRxNJSXTm3NpTXr8245+VTu8jO2DEh9MObFQuMYQZVwBKtywYUZ1AjyMTVKKuY
 7MRC9ZCmdJFGNcweGU2i+/I5KlvRyAF5nwCaSFpJnt5L4Zh6VNZpZ3ofHmVlf1iFwKszlv8RHrN
 eQzD8/VMJRXwp7/MAs+ZlBLA7sZZr7b7+aRViQkSrge19/HSJ2toUwN7Q3jJz2bxQAlWWlcn1w3
 sUnwOoo9YszRmQueD46ewOnP8N6yXL5cmBrStblwl7R8=
X-Received: by 2002:a05:6000:26d2:b0:3d0:d6e6:5d76 with SMTP id
 ffacd0b85a97d-3d0d6e664b1mr1445343f8f.55.1756472398143; 
 Fri, 29 Aug 2025 05:59:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHt0cX2L/zzLDzf7Rh9RUDJy1nUsZVdlXOQZJTOPoem8luhXtgrmrOY7rCXPWMS+/1u1hgagg==
X-Received: by 2002:a05:6000:26d2:b0:3d0:d6e6:5d76 with SMTP id
 ffacd0b85a97d-3d0d6e664b1mr1445311f8f.55.1756472397658; 
 Fri, 29 Aug 2025 05:59:57 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf276cc915sm3273840f8f.21.2025.08.29.05.59.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 05:59:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 08/28] hw/i386/pc_piix.c: remove SMI and piix4_pm
 initialisation from pc_init_isa()
Date: Fri, 29 Aug 2025 14:59:15 +0200
Message-ID: <20250829125935.1526984-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829125935.1526984-1-pbonzini@redhat.com>
References: <20250829125935.1526984-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Mark Cave-Ayland <mark.caveayland@nutanix.com>

These are based upon the PIIX4 PCI chipset and so can never be used on an isapc machine.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20250828111057.468712-9-mark.caveayland@nutanix.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc_piix.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 5ae265bd538..57b02da5a82 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -441,8 +441,6 @@ static void pc_init_isa(MachineState *machine)
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *system_io = get_system_io();
     ISABus *isa_bus;
-    Object *piix4_pm = NULL;
-    qemu_irq smi_irq;
     uint32_t irq;
     GSIState *gsi_state;
     MemoryRegion *ram_memory;
@@ -618,23 +616,6 @@ static void pc_init_isa(MachineState *machine)
     }
 #endif
 
-    if (piix4_pm) {
-        smi_irq = qemu_allocate_irq(pc_acpi_smi_interrupt, first_cpu, 0);
-
-        qdev_connect_gpio_out_named(DEVICE(piix4_pm), "smi-irq", 0, smi_irq);
-        pcms->smbus = I2C_BUS(qdev_get_child_bus(DEVICE(piix4_pm), "i2c"));
-        /* TODO: Populate SPD eeprom data.  */
-        smbus_eeprom_init(pcms->smbus, 8, NULL, 0);
-
-        object_property_add_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
-                                 TYPE_HOTPLUG_HANDLER,
-                                 (Object **)&x86ms->acpi_dev,
-                                 object_property_allow_set_link,
-                                 OBJ_PROP_LINK_STRONG);
-        object_property_set_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
-                                 piix4_pm, &error_abort);
-    }
-
     if (machine->nvdimms_state->is_enabled) {
         nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
                                x86_nvdimm_acpi_dsmio,
-- 
2.51.0


