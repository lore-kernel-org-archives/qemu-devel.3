Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CF7C02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 23:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYCkU-0004Nq-8s; Wed, 15 Jan 2025 18:24:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCkS-0004DR-EA
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:24:32 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCkQ-00040V-GK
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:24:32 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4363dc916ceso8979265e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 15:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736983468; x=1737588268; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZxdK0rL3TGvxKN2I0NmHhWUdtlccPSUCy16k5xwbSmw=;
 b=mAnPDmv+qc3YX1bMnyJcQI1sATBFawOJxGBR/4oJV49t7NoThggTbNsalisDzc7NlP
 cT7IZYHb5lZHIkbUNlTwz8GIBtqXiIBymxi6CdwfJWLzQB/hw5A5Dk1z0CcTd2P8u5L3
 9mNApMxJoe+4MNmjNYb9vdcsNYrK/JdZ0Q5ES2RFBOZWVEESVevnW+GCbKdeuz26B1Uc
 JekEYG1/jLYwuOTV+ZyA0zNaZAf+wEgSqgeFL+/QNTTQZIgfvDEGx5PKOfDkq7eLo9EV
 Yk+K6e6hrXdZmn6Narg0TgSJ0PpjdgvrVvcvBjWrsHkf+oKOm4ofhrbQIAc0gL2IDmE6
 qgaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736983468; x=1737588268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZxdK0rL3TGvxKN2I0NmHhWUdtlccPSUCy16k5xwbSmw=;
 b=eICLM43q1cIorTWthOXj6DzQPpMTbS0VdO7/HAMcDOsqtOxYYHe0JhIlQHrIc4ujbq
 FC8TOZU2fk8Um0yEb+AIOPz69K6A9sg4GqTeGkDS8aBoZ3QLiGj830WH5ltvW4ID8JM+
 bxAstpXKQ28BWoF9e2h6zLCSRB0hm3jVt/2P8Pw7oR1bMU3gi7t7UQ81W7Wh6CByMMJ4
 EIf6IzWGb8e57MhyZ3CUsY3MXBG+lyK4QqTiZ79mMeNCXCMP8cdiJTQFNRxyup4cmQpZ
 ARRwHjmIXjw1p6p0p5ZIsB5D9NLy4UkRBLQFKOIKdqQ/a9UAXoauWzLxhjHqBUZlaWXy
 3+qg==
X-Gm-Message-State: AOJu0YxD8hk93e0pecogXgiNb93/g7O0vrvtQE2tSr1L7ue4YU1UKiyI
 WvZzNvHzT7m5uKGb9//lcRC4v6eDttmC/uh3j3mLxRyp+kDnXSPzYCcEJCA1PzO4SmC4Mc4JDMb
 6lWc=
X-Gm-Gg: ASbGncudDYGPc1PuAqWB0ZnWAQv/uxOqBB9UfoMM8micU9kAuCNcssFx1PbH3lWKI7t
 zZcU0BmQwBV6Tq2N1LUj4biC3JUriLeG4FPD9GYTHvU2K1adlLW7S99d5qQtTw0yy34JOFl/wop
 K5mUCg4VVmpQD78v22K5KC2XB5xpoQU2oMxm8vJ60kR00dEJ/1RRn7ZfS7gOCUaMsYkBNblS7/1
 FmVl2rd0zeeTT9QrE6668PaUKB75kpw3m/3sXDtpNGRP+Mt5V5TijamfynniMxgn+QHm6Ll8bgx
 OCPf5EXQWKHkcTMsGA508ZXtm7bvo1o=
X-Google-Smtp-Source: AGHT+IF3GqutWvG3Ir3IQx+pJ+/afAGEXy+rbywm4hF++tNe2cEAfDlJArsRGRgEwu2Cnj6jfyTyfw==
X-Received: by 2002:a05:6000:4007:b0:386:37f8:450b with SMTP id
 ffacd0b85a97d-38bec4f5d09mr346740f8f.5.1736983468479; 
 Wed, 15 Jan 2025 15:24:28 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37d154sm19264317f8f.10.2025.01.15.15.24.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Jan 2025 15:24:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 18/21] hw/scsi/vmw_pvscsi: Convert DeviceRealize ->
 InstanceInit
Date: Thu, 16 Jan 2025 00:22:44 +0100
Message-ID: <20250115232247.30364-19-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115232247.30364-1-philmd@linaro.org>
References: <20250115232247.30364-1-philmd@linaro.org>
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
---
 hw/scsi/vmw_pvscsi.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index 4c95794ba1e..02b4b41f4a5 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -1271,21 +1271,15 @@ static const Property pvscsi_properties[] = {
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
 
 static void pvscsi_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
-    PVSCSIClass *pvs_k = PVSCSI_CLASS(klass);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
 
     k->realize = pvscsi_realizefn;
@@ -1294,8 +1288,6 @@ static void pvscsi_class_init(ObjectClass *klass, void *data)
     k->device_id = PCI_DEVICE_ID_VMWARE_PVSCSI;
     k->class_id = PCI_CLASS_STORAGE_SCSI;
     k->subsystem_id = 0x1000;
-    device_class_set_parent_realize(dc, pvscsi_realize,
-                                    &pvs_k->parent_dc_realize);
     device_class_set_legacy_reset(dc, pvscsi_reset);
     dc->vmsd = &vmstate_pvscsi;
     device_class_set_props(dc, pvscsi_properties);
@@ -1310,6 +1302,7 @@ static const TypeInfo pvscsi_info = {
     .class_size    = sizeof(PVSCSIClass),
     .instance_size = sizeof(PVSCSIState),
     .class_init    = pvscsi_class_init,
+    .instance_init = pvscsi_instance_init,
     .interfaces = (InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { INTERFACE_PCIE_DEVICE },
-- 
2.47.1


