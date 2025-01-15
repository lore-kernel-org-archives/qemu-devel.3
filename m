Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC37C02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 23:25:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYCkv-0005Gh-3v; Wed, 15 Jan 2025 18:25:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCki-0004uM-SO
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:24:54 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCkg-00044M-Jh
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:24:48 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43618283dedso2225635e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 15:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736983484; x=1737588284; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3MeEeWLQLu5S/9pne2OBNrXJxMiShf4rM4A4caNKWSo=;
 b=IgzQDk5//arKXdZPMm2eHpgzcswuNLqGFgGmMOKQYQH0pu9zuLJ9QSZqjnAhf27nz+
 DA9WrsRhWCL/yjg9LWSzAQbjeNRcj1NWzH4f0Enb/OBOOb6k5gUyVJPEPpyJgVIHgdC4
 /0mJjJRzxt5jpkQvp2YMiUyDCZKEdJ88zUCfK4F7YSct/RpO8U4FNR5WLy8ogVbn19yD
 vrlzapHzBWsxoxX2yeQcerMwCKqc03UE/xSCkkcBpqO5GpjqoUlb46xfRCufY5Hx+2Zp
 PIiCbPcJ3K5+BYpmQk9hiN561ytrIiqfbo2Ea4tutQCE4zZIQeM9Q3YtP+UJkNH9K6Au
 mC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736983484; x=1737588284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3MeEeWLQLu5S/9pne2OBNrXJxMiShf4rM4A4caNKWSo=;
 b=O2En8MpPLvu6mjBuZ1l6GSTXHVsspzrqCbQVGPHdw9LfDRrmLSru6tZTxmdDa9gCaY
 MVhfyCVIwCrn+iiYdUcsqs+3EfPZX7kHpcDYuCkC9dz0L31AgCz1DVSjRwYsqZeK6iIM
 9uw58Ze5T98YCDdjVGaUhnJWtibpTt35fK3F+s2ywH1X18oCb/HSyPWq/A3A+pB5pg49
 +rKd88POvQnsyck6X9yQvlDUEwuXi+6DBlID+bjUmkFPvzFcCJPee7Wt4tKkLv5vs+pL
 /XLVSw7wEwLlK2IRBVlK7rlKZl0CAf9bNbNQydApXb9pHLUEKLQXELzwUzuCM6/XuSpt
 Y/2Q==
X-Gm-Message-State: AOJu0Yxs8ZEnybr6N3ALXUR5k68LbQskJa+oCiiBUpHXCTkzj2NGaJVO
 wfQQDwfASMilaL5rolDFrKYtE+J3bynq8oZbJqEiuI7WkfiBeiwcu5fhC8vr48hTLDzZp4Own2N
 8a4o=
X-Gm-Gg: ASbGnctw8ayKZUeFze/fxCcvYZNu7EMB7NVVaMZBOskrF6ne3dl1rb2UIl45LjCRy3N
 iim/L3WJoecDPnygcWx3BhHuDv2ejM1/fQnVJcTgyhwtm/alrebbWJRTHYDPUymlRJ4e5zrNqas
 WHisWRB2BDzQauYiiYHymc8f+AACT5UQmPT9AYXxtHvsS9heeOkVDuZgivBPcIOLsj3968EFMGJ
 bjGzYTCd89QwnbeF+FmBJHsED+6U/Oj8cUsB1IRfnMC4uOusfQTvs/JpsZNr+jKa7TJ3PyySwHj
 6MJjrZUfmPb7MPVB2dg5gNAaEdBdg+8=
X-Google-Smtp-Source: AGHT+IG49VpBEobbS4qDW+iM5udPv1ILB1wWrjPlSRbXrH+NDQcb/Ax56VwAEp+bwh6Q1kcnh+hepA==
X-Received: by 2002:a05:600c:348c:b0:435:14d:f61a with SMTP id
 5b1f17b1804b1-436e2707c4emr241072415e9.25.1736983484554; 
 Wed, 15 Jan 2025 15:24:44 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74ac604sm38605875e9.13.2025.01.15.15.24.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Jan 2025 15:24:44 -0800 (PST)
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
Subject: [PATCH 21/21] hw/net/vmxnet3: Merge DeviceRealize in InstanceInit
Date: Thu, 16 Jan 2025 00:22:47 +0100
Message-ID: <20250115232247.30364-22-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115232247.30364-1-philmd@linaro.org>
References: <20250115232247.30364-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Simplify merging vmxnet3_realize() within vmxnet3_instance_init(),
removing the need for device_class_set_parent_realize().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/vmxnet3.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index d8132773fad..2757fd83505 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -2239,6 +2239,7 @@ static void vmxnet3_instance_init(Object *obj)
     device_add_bootindex_property(obj, &s->conf.bootindex,
                                   "bootindex", "/ethernet-phy@0",
                                   DEVICE(obj));
+    PCI_DEVICE(obj)->cap_present |= QEMU_PCI_CAP_EXPRESS;
 }
 
 static void vmxnet3_pci_uninit(PCIDevice *pci_dev)
@@ -2464,22 +2465,10 @@ static const Property vmxnet3_properties[] = {
     DEFINE_NIC_PROPERTIES(VMXNET3State, conf),
 };
 
-static void vmxnet3_realize(DeviceState *qdev, Error **errp)
-{
-    VMXNET3Class *vc = VMXNET3_DEVICE_GET_CLASS(qdev);
-    PCIDevice *pci_dev = PCI_DEVICE(qdev);
-    VMXNET3State *s = VMXNET3(qdev);
-
-    pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
-
-    vc->parent_dc_realize(qdev, errp);
-}
-
 static void vmxnet3_class_init(ObjectClass *class, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(class);
     PCIDeviceClass *c = PCI_DEVICE_CLASS(class);
-    VMXNET3Class *vc = VMXNET3_DEVICE_CLASS(class);
 
     c->realize = vmxnet3_pci_realize;
     c->exit = vmxnet3_pci_uninit;
@@ -2490,8 +2479,6 @@ static void vmxnet3_class_init(ObjectClass *class, void *data)
     c->class_id = PCI_CLASS_NETWORK_ETHERNET;
     c->subsystem_vendor_id = PCI_VENDOR_ID_VMWARE;
     c->subsystem_id = PCI_DEVICE_ID_VMWARE_VMXNET3;
-    device_class_set_parent_realize(dc, vmxnet3_realize,
-                                    &vc->parent_dc_realize);
     dc->desc = "VMWare Paravirtualized Ethernet v3";
     device_class_set_legacy_reset(dc, vmxnet3_qdev_reset);
     dc->vmsd = &vmstate_vmxnet3;
-- 
2.47.1


