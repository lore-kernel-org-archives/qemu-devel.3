Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1819DC3ABCC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 08:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEOm2-0005sT-Ry; Mon, 12 May 2025 04:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEOkG-0002Qm-8H
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:42:46 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEOkC-0001sI-Pn
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:42:43 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a0b9e2d640so3815086f8f.2
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 01:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747039359; x=1747644159; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=abVDebT8BBZMs6MJ6dO6mHGwZDtT7ZXaTDXgCLMhAz0=;
 b=dAwOAwrQl9QcPUEXP+1992Pw8gyyTRKITC9SZRDQf3THUPHbVPwWtaF4MAgIHNZ8fB
 ljrqgqLJmZirMUe/Jb4zPv2rGQJ5dAR853jCYyVwJWaDa0mZA1IuSwn7g9MYj8l6WxFS
 Kyk9QlDKVv5IdOl+YzOI6OxwrweQc4cUayhClptjk03OaB+zv3e/jJs/ybjyHQKd6Hve
 fBfkSk8XJMFJDgudkec5VvBXdQ0TbkgoosV6qEPmwb2F9rvBp7Fy9Fbwz6z9jYW6Hu5b
 cLYlbmBmguTp+pv0EyqjlBjYYJXWvw7Vnc3aWUifpFjLpL9jx/Kj8TCOi8PSYzyJAw2v
 iscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747039359; x=1747644159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=abVDebT8BBZMs6MJ6dO6mHGwZDtT7ZXaTDXgCLMhAz0=;
 b=d5bd4xmaS5j+fufPgFAS2pMTmqCta5yfvnajiaH90q8BldbjPkCwW59MQXnENe8QVR
 Cf0TL2DWcaK3h3Pph+8+HABb73PBUlXWcogAQCcbWxVJrF+tEHPFHdLQcxIqFcZNbfIJ
 2z1MKZbZeCDfZbED97GfSCQ/fTupcl68dlxzgscUf1zWoqqg+p9Yu37d7LFZmvjcqa0Z
 Kc+zIVrk7k7O73N2woe2PlTB8a6iXOvBeQYpCWCk5kChbDqDcB2lhoe7TUwvdWFskjz0
 uFkAa5xPiZ3GPFuQ3Xg/AdHCdYkDAGVESOGhGZxyFOhKZoCbGjRczjO2imKbf90HvIpw
 HGLA==
X-Gm-Message-State: AOJu0Yx0hfkwR6B+4acq32zmMYq4lU8sFgePhh4ADiRsnCM8p38r8CdE
 K5x0jlC5dr0uxAGGS+4C/okMl/euW/B2z5UnNbyIlwYS8TObFi7h6jqeEuqpfL/KbQYSanp4JGw
 vF66r3g==
X-Gm-Gg: ASbGncu7Er3pXUW5P8RAM3dY0OpIxzHbLkKli9WbPMM/y0JQ4B0FcT5wYo9pS1dUeZU
 3oknYK8Gtrbk96xQfMfc2w3V89vpV0CaqX7tDSL6d38jdLsaEfsBv9CELZSQstZZQqj/56T+2MU
 YMhRI3MktXDYF4cyDOVCHCGFNSsl8q+MXlMdw4hUFpLyj8UVdBwo/+YuIAoQAbmOIMX0lYkcg64
 6zUmnc2MUfjz5W72ILeoRp67in4iCxEr8XrzsyzPWNmAmqmc6RaMIzOx+wnn6alIYGY+FNhX44B
 TKO6wBGYnj8JcGc5Gmg21r2akse5Qo/tDNTOZe3cMNVzzlwmL4A9CigOqbx0WMEy60RctHHVDpI
 rf900oWa4Wo/ugPGr3pIWOLw=
X-Google-Smtp-Source: AGHT+IGfGLUcVsJ+Jf5sf5aS7QYzxNLQmEIdj0Mn62NajlulR975aTIlVHWqkzqQ21yGoTYevMI+9Q==
X-Received: by 2002:a05:6000:4008:b0:39f:175b:a68d with SMTP id
 ffacd0b85a97d-3a1f643a59emr8276841f8f.11.1747039358822; 
 Mon, 12 May 2025 01:42:38 -0700 (PDT)
Received: from localhost.localdomain (129.163.185.81.rev.sfr.net.
 [81.185.163.129]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a2d2e9sm11636692f8f.75.2025.05.12.01.42.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 May 2025 01:42:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, John Snow <jsnow@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 19/19] hw/net/vmxnet3: Merge DeviceRealize in InstanceInit
Date: Mon, 12 May 2025 10:39:48 +0200
Message-ID: <20250512083948.39294-20-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512083948.39294-1-philmd@linaro.org>
References: <20250512083948.39294-1-philmd@linaro.org>
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

Simplify merging vmxnet3_realize() within vmxnet3_instance_init(),
removing the need for device_class_set_parent_realize().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/net/vmxnet3.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index d080fe9b38a..7c0ca56b7c0 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -2238,6 +2238,7 @@ static void vmxnet3_instance_init(Object *obj)
     device_add_bootindex_property(obj, &s->conf.bootindex,
                                   "bootindex", "/ethernet-phy@0",
                                   DEVICE(obj));
+    PCI_DEVICE(obj)->cap_present |= QEMU_PCI_CAP_EXPRESS;
 }
 
 static void vmxnet3_pci_uninit(PCIDevice *pci_dev)
@@ -2463,22 +2464,10 @@ static const Property vmxnet3_properties[] = {
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
 static void vmxnet3_class_init(ObjectClass *class, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(class);
     PCIDeviceClass *c = PCI_DEVICE_CLASS(class);
-    VMXNET3Class *vc = VMXNET3_DEVICE_CLASS(class);
 
     c->realize = vmxnet3_pci_realize;
     c->exit = vmxnet3_pci_uninit;
@@ -2489,8 +2478,6 @@ static void vmxnet3_class_init(ObjectClass *class, const void *data)
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


