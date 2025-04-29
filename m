Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA0AC3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 14:13:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9lfN-00045R-7m; Tue, 29 Apr 2025 10:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9lep-0003V8-Om
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:10:05 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9lem-0006Uy-J6
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:09:59 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso43260795e9.1
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 07:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745935789; x=1746540589; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j41fV/T5fVwdY4VDR58WCPqJo5aDoWrBkyOMJ4Dwydk=;
 b=sSRybMXsNRHONHi260Dy9TnGh+3FDJfPzIKE7STPRsZdNgUpGb+aZ4YaK9pdOBZrxm
 DHtfy5zR0QGXCyQTUcbOj5vFAiLrLaPewqLWEzQWRQkNZlVDkQ1Ap0waox9PGSOU9tnf
 E+Yegwy9udbAAIExgEutNpnlBMMKrkFEqNiu4EPeq4/ZXYL+FxA0qH8gMrzVUpkhnqsC
 qAZqMlQDifVmGwYQ0ONFWkUSGcwhuujTkLjYhAIMLrY3E9Q99tXlIAwDLOIiZKIhqa3s
 6uRHD+sFZhO1Q7QDSuOqee4NWASy8/NGn+pH11vKVne/qJOZikSb6gCRREYGFjxsUjv9
 ri7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745935789; x=1746540589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j41fV/T5fVwdY4VDR58WCPqJo5aDoWrBkyOMJ4Dwydk=;
 b=ITeaLDj7CQ7UkKmI1nwHD2+tiO8hsWkG9xyipjObGZkkF6TvrGIMJxPk8ZuyvdnZlT
 9E2ukNstBRcK/cBnLaAcOgHXCiE4PUh6bg/NT1fWgwn5DqBNHfRKEMhYC76rhwTPL3G2
 gcy8e1pOrwiDLs2N7fr/Gq53RJvdD2RfewdB/wE9qXu2iv99KkYDaKvkuyaiuMNRjJkt
 S5i7zvugNdXZTqMArqeLnp7FxUB+vvIp7QyGGIj8T/oYyl+hPfd0z+IBsZz3+xlmCyAO
 TZjJw42ZudMS5xEfD3eM7YdJPqW0ooKPgtLid/FmwmvncehCuZ83VrZx9G+XX8eRj8Aw
 wDPQ==
X-Gm-Message-State: AOJu0Yxb/ltaWS5plLoj1lU6pSvqS+Ou7/7T5SPraaVEC7GW5nijl1ak
 ic12tJVug7Uj2EvAyaktJ015/AjGJdHwACJaESDMs+GJA4qJ7416i4oGNjwFiw/1J2IZ0mJPKC/
 +
X-Gm-Gg: ASbGncv/xxUAaRxycmryeenriu/c7e6pxsfjl+V7tBHl8F1XpzlWqU6uJnJgJe3tqSf
 aVd2Bak+LGKXQ9n0Rhw0ibrDIMNvOjhAEq6SA077RXCJv8sX4AN5r0Z5m4mjayRoE3l0ISzmc+U
 +PiqPH+QtucKNLU0PVW95fX70POqngzyJDlwNXdxmXYpQnFjMywD1AwxRgllg+fJTLu/gULdR8/
 6LGaY/ZHzqguLdeWWndyQWaXH01jJoKn+QPwwDuWmlwumGWMBtgGQ30c4O0YBb+ZVugofT22TXg
 7nE2JLxJvDeOi25ERaAbL1kQsRQNLV+HJb3gZwhM3G8sQQX+Uy/K1c7t3DDMhB7kROqm8uRXV6q
 75mX06iI3VjsYckeqNVoC
X-Google-Smtp-Source: AGHT+IFb5nYayxjTU8XD3JSTOuyV3WiSXankX9wyKjueE1RtxtuSlbEIWCQvzlEg2kqY9bAFP0Pw1Q==
X-Received: by 2002:a05:600c:1f91:b0:440:9b1a:cd78 with SMTP id
 5b1f17b1804b1-440ab7b7969mr144090985e9.10.1745935789042; 
 Tue, 29 Apr 2025 07:09:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5c6a0sm13996273f8f.86.2025.04.29.07.09.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 29 Apr 2025 07:09:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 16/19] hw/scsi/vmw_pvscsi: Convert DeviceRealize ->
 InstanceInit
Date: Tue, 29 Apr 2025 16:08:22 +0200
Message-ID: <20250429140825.25964-17-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250429140825.25964-1-philmd@linaro.org>
References: <20250429140825.25964-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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


