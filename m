Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0506E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:44:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuKy-0001px-Pt; Wed, 18 Dec 2024 08:43:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNuKW-0001Jz-Vk
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:43:14 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNuKV-0005fm-9B
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:43:12 -0500
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3eb8559b6b0so3467274b6e.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 05:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734529389; x=1735134189; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=75drLZGsEas3R26qUilFhzjUTWE9A4kYs2fwKy7AL8A=;
 b=AwkRJOHoAFgP2GrNCgajlmRk13RVaQ4n6URUqddACxMnhxiBJJDkZmgiYccU3Ht95I
 xiCZB0TH9L6fa0StitCK5Ubl25RCbOEyKRrObBtdDJs9KfstoypsHEKD8puQcPs+1PAn
 wdOluwow4J+lJBPO102NWLhb0LQVLKwSV/JUcpN4fx1YK28lQReGQGPbIhDXYx7OTYWW
 TUBbechVrlr61MkV+OBGFqj0hdCtGu3mahk4Z9PjO1743rlpvf2ZY813ad6IxmfiCHY2
 wd54u0DV8TR3cdQQJZTtxJkZFKf1IljQbylxdBorFpkIlcLTgRSzAKAXeKsshUIA5m5h
 wE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734529389; x=1735134189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=75drLZGsEas3R26qUilFhzjUTWE9A4kYs2fwKy7AL8A=;
 b=IQaT1SoViemqgWpEHw/Uf7yR2HmTq5QozO8Jh/mXLbAc8duXfc/BCg5mlyydl+Fx4z
 2eOBvtBgMvdcferqpkB1rOb2WPI6GfM0AXsDTk3eR7neQcOXcUsDu+z61aInbBnxBaiy
 HDUXo8/1v7Uztbno8QQzrkZvy4Ty2C8wEr51JtFoO+id8keI4t708s1oGXgx4I4hy166
 wZqQXWBWsihuXBSQ9v1RA8y0uAYwC8e1fxBfl3aXrUxGId+auBHdfDJVQTKa2Hpa56jG
 m43zq4PhBqilT0n+froSKjznK72mvMd78Fum5pwe3uncrYC/KuwRea9t92l2k6CLuJxS
 8LIA==
X-Gm-Message-State: AOJu0YxVHMNnw2AGQBOeOOI4yBkybbKwGK/d+ReLvjCewbKXZ4BYUfXK
 y8/2Lw/l4CIyiHEL/coTv0dn9ICXpmz7LWY03PKNmCkZNr5+AcmoHQj9M2B417VwFeu55qh8TKB
 uTupzEUuG
X-Gm-Gg: ASbGncsHwjxNYj1894HEWzof6v/9xZ744aUz5xbPmKH6PDIpgtpmd9qEN78oI1SIzT/
 0EpGZUa1mR3n+b0UrcyDxwUfLlHnIq0/jTjEleDpxqfA87hwpjR5jPbYPG5+m7ZI7/IyRpw4yyw
 ZPjQnU5qdcXSUiaKfAZJKobeXoOKRdQF1JX0y/bSp7XGWTfNM+5foCXgauKvry2OU/oU3y6IoGx
 M91+AMORsG/QALkD6OgOC4RpzogoM5mR8smrplY3ST0wty11wsdc0AnBsKuqjWN
X-Google-Smtp-Source: AGHT+IH+pNMHzlwR8/iERwkER0vN33G2F8JwHdsG26t4pLM/9eeeF2X8zV/RGBCltOtEf01BlUwvuA==
X-Received: by 2002:a05:6808:2220:b0:3e7:a201:dc31 with SMTP id
 5614622812f47-3eccbf9aed6mr1893871b6e.23.1734529389280; 
 Wed, 18 Dec 2024 05:43:09 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a502sm2870951b6e.9.2024.12.18.05.43.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 05:43:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 11/24] hw/virtio: Remove empty Property lists
Date: Wed, 18 Dec 2024 07:42:38 -0600
Message-ID: <20241218134251.4724-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218134251.4724-1-richard.henderson@linaro.org>
References: <20241218134251.4724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x235.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/virtio/vdpa-dev-pci.c       | 5 -----
 hw/virtio/vhost-user-snd-pci.c | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/hw/virtio/vdpa-dev-pci.c b/hw/virtio/vdpa-dev-pci.c
index 5446e6b393..787926801a 100644
--- a/hw/virtio/vdpa-dev-pci.c
+++ b/hw/virtio/vdpa-dev-pci.c
@@ -48,10 +48,6 @@ static void vhost_vdpa_device_pci_instance_init(Object *obj)
                               "bootindex");
 }
 
-static Property vhost_vdpa_device_pci_properties[] = {
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 static int vhost_vdpa_device_pci_post_init(VhostVdpaDevice *v, Error **errp)
 {
     VhostVdpaDevicePCI *dev = container_of(v, VhostVdpaDevicePCI, vdev);
@@ -80,7 +76,6 @@ static void vhost_vdpa_device_pci_class_init(ObjectClass *klass, void *data)
     VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
 
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-    device_class_set_props(dc, vhost_vdpa_device_pci_properties);
     k->realize = vhost_vdpa_device_pci_realize;
 }
 
diff --git a/hw/virtio/vhost-user-snd-pci.c b/hw/virtio/vhost-user-snd-pci.c
index d61cfdae63..0cb86b7d85 100644
--- a/hw/virtio/vhost-user-snd-pci.c
+++ b/hw/virtio/vhost-user-snd-pci.c
@@ -23,10 +23,6 @@ typedef struct VHostUserSoundPCI VHostUserSoundPCI;
 DECLARE_INSTANCE_CHECKER(VHostUserSoundPCI, VHOST_USER_SND_PCI,
                          TYPE_VHOST_USER_SND_PCI)
 
-static Property vhost_user_snd_pci_properties[] = {
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 static void vhost_user_snd_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
 {
     VHostUserSoundPCI *dev = VHOST_USER_SND_PCI(vpci_dev);
@@ -44,7 +40,6 @@ static void vhost_user_snd_pci_class_init(ObjectClass *klass, void *data)
     PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
     k->realize = vhost_user_snd_pci_realize;
     set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
-    device_class_set_props(dc, vhost_user_snd_pci_properties);
     pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
     pcidev_k->device_id = 0; /* Set by virtio-pci based on virtio id */
     pcidev_k->revision = 0x00;
-- 
2.43.0


