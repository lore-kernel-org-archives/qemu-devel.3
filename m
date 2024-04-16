Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB0B4C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 13:55:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwjG3-0002Jf-QP; Tue, 16 Apr 2024 09:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwjFt-00026w-Ip
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 09:53:51 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwjFm-0001n0-M3
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 09:53:49 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5700a9caee0so4083316a12.2
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 06:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713275621; x=1713880421; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aDu2aZ9r50YKxf+dNaxDqKUjAn6DYpDYAzbmilk8iWY=;
 b=QN6TZe4Hi69s/Wjpnif8my+a9u1/mycfsRvLQ03ToLykSMJS4c3UZOnl/FBXmyky2l
 in3XIP4v29jyUprwEGFJziGnZWH92rrhN5K51/e92OwF9rwkxquZaCXdjv0SkAU+eu5t
 hYxZpf2ztOL0E4klNcJpuNUOHvOIgoa0IIRitJnVAEd9sskGx1ocrIz4v1ieFp1YQ+5c
 xZwqC5NmfX5Fm/lqc1TtlcOFbxnFjG6wI5xFCEbsiD18SfLCjDBTujN1JlGpKgSEfOjo
 9gNMb2MMfHkW0MhNzyEHVDhkD9w9rrFk+HCHxswlRIq9TGDkypJ2VwjLUGTF3cBA9G5/
 M1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713275621; x=1713880421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aDu2aZ9r50YKxf+dNaxDqKUjAn6DYpDYAzbmilk8iWY=;
 b=RRtmaRK7KfzuyuFrm+U46tMEDmWQXdHjDPpBChmX8oxHLJWI8+TNV0bGUJnVaVtYDe
 rwYA0SvpJmICMIM++EqyIIXgClPGMMJVqcqyqsy6+fzZi7oHYAOwKVX0NQJ/fH3Mzgqt
 MzLCpzdq0vJKG4wH5n62g45zMKCOhn5nqdnRp8OSfzHDcoNpY4Y0+5RKT9MxGY2llHty
 StQywIdjnJCqm/e025g9NTDZNoT2wjbEgZXvK6eofWTgVRMit8f5bFYXgIxS/nLE9WrB
 U6fh5vXJbeMivXqkiqdNgttdQfJM8q0b4eoMzN0pZIoJ054XcvMjlEvi4qiTjPF3eCx+
 MG6g==
X-Gm-Message-State: AOJu0YxVprtcDCgHAOlMcrraUCiQ+d4E8rEo5xtR7MEZ2L6v1swvHAqQ
 olqP0PnMKY9DFiMf9Yjbe3LWiI7ETib1kJSztBiCJ8MoQKkDVcyzie8RqfF7m+xn3K+a8C/50L4
 f
X-Google-Smtp-Source: AGHT+IG9GwsBxEHqpinP3LonbLPk3v0mIRKVFaq5iYprwUBs67j0MD+3TJfLJxHXzfifNj6VDYrcSA==
X-Received: by 2002:a17:906:ecac:b0:a52:6ba8:8bf1 with SMTP id
 qh12-20020a170906ecac00b00a526ba88bf1mr3357576ejb.77.1713275620894; 
 Tue, 16 Apr 2024 06:53:40 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.155.61])
 by smtp.gmail.com with ESMTPSA id
 ho41-20020a1709070ea900b00a524318c380sm4976387ejc.80.2024.04.16.06.53.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Apr 2024 06:53:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v3 07/22] hw/acpi/ich9: Remove dead code related to
 'acpi_memory_hotplug'
Date: Tue, 16 Apr 2024 15:52:36 +0200
Message-ID: <20240416135252.8384-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240416135252.8384-1-philmd@linaro.org>
References: <20240416135252.8384-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

acpi_memory_hotplug::is_enabled is set to %true once via
ich9_lpc_initfn() -> ich9_pm_add_properties(). No need to
check it, so remove now dead code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/acpi/ich9.c | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 9b605af21a..02d8546bd3 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -153,17 +153,10 @@ static int ich9_pm_post_load(void *opaque, int version_id)
      .offset     = vmstate_offset_pointer(_state, _field, uint8_t),  \
  }
 
-static bool vmstate_test_use_memhp(void *opaque)
-{
-    ICH9LPCPMRegs *s = opaque;
-    return s->acpi_memory_hotplug.is_enabled;
-}
-
 static const VMStateDescription vmstate_memhp_state = {
     .name = "ich9_pm/memhp",
     .version_id = 1,
     .minimum_version_id = 1,
-    .needed = vmstate_test_use_memhp,
     .fields = (const VMStateField[]) {
         VMSTATE_MEMORY_HOTPLUG(acpi_memory_hotplug, ICH9LPCPMRegs),
         VMSTATE_END_OF_LIST()
@@ -335,11 +328,9 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs *pm, qemu_irq sci_irq)
     legacy_acpi_cpu_hotplug_init(pci_address_space_io(lpc_pci),
         OBJECT(lpc_pci), &pm->gpe_cpu, ICH9_CPU_HOTPLUG_IO_BASE);
 
-    if (pm->acpi_memory_hotplug.is_enabled) {
-        acpi_memory_hotplug_init(pci_address_space_io(lpc_pci), OBJECT(lpc_pci),
-                                 &pm->acpi_memory_hotplug,
-                                 ACPI_MEMORY_HOTPLUG_BASE);
-    }
+    acpi_memory_hotplug_init(pci_address_space_io(lpc_pci), OBJECT(lpc_pci),
+                             &pm->acpi_memory_hotplug,
+                             ACPI_MEMORY_HOTPLUG_BASE);
 }
 
 static void ich9_pm_get_gpe0_blk(Object *obj, Visitor *v, const char *name,
@@ -460,12 +451,7 @@ void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
         return;
     }
 
-    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) &&
-        !lpc->pm.acpi_memory_hotplug.is_enabled) {
-        error_setg(errp,
-                   "memory hotplug is not enabled: %s.memory-hotplug-support "
-                   "is not set", object_get_typename(OBJECT(lpc)));
-    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
+    if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         uint64_t negotiated = lpc->smi_negotiated_features;
 
         if (negotiated & BIT_ULL(ICH9_LPC_SMI_F_BROADCAST_BIT) &&
@@ -509,8 +495,7 @@ void ich9_pm_device_unplug_request_cb(HotplugHandler *hotplug_dev,
 {
     ICH9LPCState *lpc = ICH9_LPC_DEVICE(hotplug_dev);
 
-    if (lpc->pm.acpi_memory_hotplug.is_enabled &&
-        object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         acpi_memory_unplug_request_cb(hotplug_dev,
                                       &lpc->pm.acpi_memory_hotplug, dev,
                                       errp);
@@ -545,8 +530,7 @@ void ich9_pm_device_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
 {
     ICH9LPCState *lpc = ICH9_LPC_DEVICE(hotplug_dev);
 
-    if (lpc->pm.acpi_memory_hotplug.is_enabled &&
-        object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         acpi_memory_unplug_cb(&lpc->pm.acpi_memory_hotplug, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU) &&
                !lpc->pm.cpu_hotplug_legacy) {
-- 
2.41.0


