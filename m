Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D2B1E77183
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 03:53:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN290-0007K6-Ed; Sun, 15 Dec 2024 22:51:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tN28y-0007Ii-1s
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 22:51:40 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tN28w-0005zv-It
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 22:51:39 -0500
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3eb9101419cso1926936b6e.0
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 19:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734321097; x=1734925897; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=75drLZGsEas3R26qUilFhzjUTWE9A4kYs2fwKy7AL8A=;
 b=M68a4p2rhwQ7Bv11DHPR8wseyzQMEEE+ksNZvaW6B7n4HQ0bm021cilCvTI1AxBh5m
 UhXxOWnZ7GURLDd+c6zjDNNrJv5lO50cvgZWepKQtjWun27cLkEBmprpJhU2ryO3OrR8
 voqcPXWCFiPbN6iqtOwUrSXXxLLTvo6h+86JDyq/oBYznuWuEyZUzXDkcT5XmStVOAcq
 p/XTEe4A/0jk1vOrfae9tyimY2LLjfliqh443vD3/+cXQFVZT/MoBeWO4Ozo7gU7Q2Ig
 s9JDEjqihtNBBwJxFCIzxnl+K7YEt56dI4bGtbevYbTpja0ooPrwf/krgMZ65rWPyN1h
 58DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734321097; x=1734925897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=75drLZGsEas3R26qUilFhzjUTWE9A4kYs2fwKy7AL8A=;
 b=rN3YNyniJrcFmf/2xlkeYhhniqXw9uJ6C2Ui7V2WLUBUbjEZHU9t4LGxMPfuvYrKf1
 otnZbd/ms4kzaX4LW3PrxfZOkHG1hJ/2uLCg+kDgohdSLPF/7HHQVS7WVA2cXP/bYYB8
 9COFY4YioHT49bgqXakdXpQJIf5tkrUgj4m/lpR429/liWg01VV/lApvCnwZbEPw/INW
 y1Mby/77Bc21Ld0BET+UY1KHoQep0lhlNfYMZLfNueiINkuXZZI/AuNFnW7+lwVMGEek
 BuzUfJ4t5rxgB3BxexWy2XG5b0wFbzQF3iVjIMCLOvO+1ae+6AYVQng5+GsfgxsfthYf
 Q26w==
X-Gm-Message-State: AOJu0Yw1o1pnK0fu2dIX45ZicWAbgYHC79heT5HPDUBo8/3lRuZrjM5K
 k3kJSsjTlYKkSJosfxD1LPNKs0kh4T+VBMduDQYay1s7CMy7A/k39ejd+PTrSheOZ2XySmPBFDr
 HPw4yfBEt
X-Gm-Gg: ASbGncuRGXiO9aJw5jJc3EL6N3OjPUILiIBEkR7QzzPvOe/Jgy3SFiCQSnYMrBV/CVR
 VaW1VYYIPLBBR6fzHclfFwluCsYn+7hvKVwn6FFnFhOlCKTR7cCwigNlEz6XFBGBdFmZaj6fHmf
 hAaeb7i0UlBqUckQCD1B+svPxzgkrihjRJQ2mv8h8RwBCRsPzzwD2+SvgVdDKawrZz1wt8vlxYh
 /jB26Wsi6/ixVkKkOzv4WwUQFA+bPGes4YCkTG4JvaK9Kv2XQ7DXWkXxZnH1fRZuVRddbKuQx0r
 9bNEpZ6cRW6N6z9Si1J2aJ5gv2L1dAuyUA+op+squ3Y=
X-Google-Smtp-Source: AGHT+IELRxVS+jnRei7PG4blcAAyYE6lMsMyDGgis38mH6KVYH2D0upuRlJO8RMY/W1O9dITbIWBBA==
X-Received: by 2002:a05:6808:f01:b0:3eb:6dd3:12bf with SMTP id
 5614622812f47-3eba695654emr7049296b6e.28.1734321097532; 
 Sun, 15 Dec 2024 19:51:37 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f33a93a6d1sm1287493eaf.33.2024.12.15.19.51.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 19:51:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/24] hw/virtio: Remove empty Property lists
Date: Sun, 15 Dec 2024 21:50:56 -0600
Message-ID: <20241216035109.3486070-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241216035109.3486070-1-richard.henderson@linaro.org>
References: <20241216035109.3486070-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x236.google.com
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


