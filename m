Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC90BC3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJW4-0004Ai-EU; Tue, 06 May 2025 10:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJTD-000885-8T
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:40:36 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJTA-0001qU-Tf
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:40:30 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-39129fc51f8so3822244f8f.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542427; x=1747147227; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j41fV/T5fVwdY4VDR58WCPqJo5aDoWrBkyOMJ4Dwydk=;
 b=wmpFEQURYW9fcrJGc4PuDjVX/XM/MlmA1avmYzmTiJ6wfdpWe/JhZNIEYnsilVGfkl
 vNoqBy/wFZzSNQty+iJBLXmyhOdwFWxHccICPqlHCHbv6cAKj6TTNgojf1VkbS4WVQA7
 PbEC8/IM+hclckm1UIgEPw2SwOU468C9a7d1hpo7SLmZkxhFY6f94AfChdhJXQWRTJnX
 vx7MW980FmO9KM/pNh05dVpuRTLQk7BBGQdteo1OsomVg8/SkBZJ/RAEdUQ8bCY3L4JN
 PiZN1EUdrJf98ydQyBQi2knqbPvuteD0qpaptfK8k/1PSdA/LZn+9GBUUrsnKPRFZ3iO
 8ayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542427; x=1747147227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j41fV/T5fVwdY4VDR58WCPqJo5aDoWrBkyOMJ4Dwydk=;
 b=Af+VYYGafEZGxmLqIsjR7SmvnMuwpMYh1Np70+EySOmTvAvMzFpOBeN3J1DWgGPUHz
 5WtQ733ovWF2rXkF1j6ubGuMbFrhhYID2kXBLMek63Jg2YUzXS4plkKuu+7EiZgxrb9e
 JDJQlsnT5ABwqVYzBdg5IAyHyUCwr1klRFaBmb+KyKG7OsGwe9Quk+cqFqkboEoBlSJ+
 S1hNwREHo0rOaCquJJuVooDqWicP50xIm3bsVcLwpI0JfJmS+7DJnjQ9hNX0pAWAcFVV
 wIo0HHoejK4Pbjuz001BUfZJPRqt5BzmYT9TD3imugcuKKnTEVuao8U3uvhnNedMtawp
 M6Ow==
X-Gm-Message-State: AOJu0YypirPAtlK1NpbEbkVP5dmC1yNzS7fQ0Y/8TVucwzk+eoY1mwND
 2/Y6e5VzQYweMpWQYLn34axla4IjmrEti++7xIoAWEBwPlXUFP1K3FK3cTmTM5i6DFpoUjnSZoU
 8
X-Gm-Gg: ASbGncumSrGkVgHeCVn1nYCAObS8mGBigfs3/nEkaG+kSI9HTKef2tYjk4NXX+VU9Kq
 UbOadsXst6R9+cIcywiPNUppjhJIuEJRm4umFoOLBaLbwSWbZuATp5o//H4A9xtCn3Ajr7ktvy9
 NIcC8WDUQA5Ljiqe1ou/hL7N+4blz/EjLtL8KyKsN05j+sPeMcSTx5IsVHJ6LGHK300seqY1RKz
 cuP0XLNREo0LWc6HN3S7GryhO1XE3mz/SbFRyAD4aSROqeFn3vUqtTbXuCbklL+t6jNPhT7x0GT
 59RceZhLJo9lupmgWLRI23dglcszv3rWPxNtQPezqWVFmaavx0MCAMjaNCcy09gvvRkJcYgvymz
 DRZOk+R0M8KsITkiBEOID
X-Google-Smtp-Source: AGHT+IGJd63f1aBzGm2VOibTt2HPEM3GOrmBR1zXP7t/gMjPs+FDvA7wJ4kzunrvNPdanDzrOiYXjA==
X-Received: by 2002:a5d:64e8:0:b0:3a0:83a2:1e79 with SMTP id
 ffacd0b85a97d-3a09fd79f80mr10257819f8f.11.1746542426955; 
 Tue, 06 May 2025 07:40:26 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099b16f92sm13639579f8f.81.2025.05.06.07.40.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 May 2025 07:40:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-block@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, John Snow <jsnow@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 16/19] hw/scsi/vmw_pvscsi: Convert DeviceRealize ->
 InstanceInit
Date: Tue,  6 May 2025 16:39:02 +0200
Message-ID: <20250506143905.4961-17-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250506143905.4961-1-philmd@linaro.org>
References: <20250506143905.4961-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Simplify replacing pvscsi_realize() by pvscsi_instance_init(),
removing the need for device_class_set_parent_realize().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/scsi/vmw_pvscsi.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index e163023d14c..7c98b1b8ea6 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -1267,21 +1267,15 @@ static const Property pvscsi_properties[] = {
     DEFINE_PROP_UINT8("use_msg", PVSCSIState, use_msg, 1),
 };
 
-static void pvscsi_realize(DeviceState *qdev, Error **errp)
+static void pvscsi_instance_init(Object *obj)
 {
-    PVSCSIClass *pvs_c = PVSCSI_GET_CLASS(qdev);
-    PCIDevice *pci_dev = PCI_DEVICE(qdev);
-
-    pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
-
-    pvs_c->parent_dc_realize(qdev, errp);
+    PCI_DEVICE(obj)->cap_present |= QEMU_PCI_CAP_EXPRESS;
 }
 
 static void pvscsi_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
-    PVSCSIClass *pvs_k = PVSCSI_CLASS(klass);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
 
     k->realize = pvscsi_realizefn;
@@ -1290,8 +1284,6 @@ static void pvscsi_class_init(ObjectClass *klass, const void *data)
     k->device_id = PCI_DEVICE_ID_VMWARE_PVSCSI;
     k->class_id = PCI_CLASS_STORAGE_SCSI;
     k->subsystem_id = 0x1000;
-    device_class_set_parent_realize(dc, pvscsi_realize,
-                                    &pvs_k->parent_dc_realize);
     device_class_set_legacy_reset(dc, pvscsi_reset);
     dc->vmsd = &vmstate_pvscsi;
     device_class_set_props(dc, pvscsi_properties);
@@ -1306,6 +1298,7 @@ static const TypeInfo pvscsi_info = {
     .class_size    = sizeof(PVSCSIClass),
     .instance_size = sizeof(PVSCSIState),
     .class_init    = pvscsi_class_init,
+    .instance_init = pvscsi_instance_init,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { INTERFACE_PCIE_DEVICE },
-- 
2.47.1


