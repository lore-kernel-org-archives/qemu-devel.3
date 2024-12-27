Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7962EE77191
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2024 12:16:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tR9EZ-000309-Iv; Fri, 27 Dec 2024 07:14:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tR9E9-0002v7-BJ
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 07:14:04 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tR9Dz-0005Fc-P5
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 07:13:55 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aaee0b309adso576605966b.3
 for <qemu-devel@nongnu.org>; Fri, 27 Dec 2024 04:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1735301626; x=1735906426;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4U+f2LVOSjCieG+oVfsElVkg5nzALNjfOKDCd96XFZY=;
 b=mIfBtrTkp+px4qWvXFmYlqdfsmTKf2ffLPC7reX8iiJa5f1E5QpkPCFWp4iO+o1Li5
 z02MQHYoae8Ossu82o2t7L13UrEqowTdTzQIuM1g4GeTtQpbESL1Nhn9/iBakwUqlvUP
 pjEl7zDYHpMDOXmqZnwAVNI0yjWCRPqcMqhwdkWGwDxMn4AA1cD99d9clnGMhpdJ4keA
 ya8BbImI5NRzIv7qkKqNqDkVyWi0YACIscvpqokzBzjUgtRZvnMjhSqBHcXQGsYfMBEj
 sKWz1HZa1UF/xMFdS+FtuqNk111R9BhwrLaVaPyF/l1BiBl3whhmHbhA6PxQGTVfsj9L
 z/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735301626; x=1735906426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4U+f2LVOSjCieG+oVfsElVkg5nzALNjfOKDCd96XFZY=;
 b=fpwEaw2OZZ+C0b8p/J5w2CubjORrOkoqo8QmYA5MmryHx6iQ+19PygQdvIYLPv51Ks
 Y1DlER/g1VAVtUwQ/YqBgnrZ+xDMcE6sZOaYOVLgHcKMYC2U+wo6TUYXKNjbogejHVoz
 IXPWj91OndEGZUippaNdup02WahRND1flcAeI9oYCGPbsp4K4b8+ga+c7H4Pj2EtP3Mq
 gVDpnvNG1wurlu1zr9x4UZhv3IiF/J9pTYSrlBsWwfE8WYhJiOuFlV6tbRgaq/vGIT/z
 6q83Ti6Zb4PPda7KmZAxLQl2nLIptLawI3m+U30uUY7DUf9WVooLuUpKirxuoiENiBSf
 6DOw==
X-Gm-Message-State: AOJu0YxAtEh0UCuO1oWAps2OEgfMYtgGWs+JnV6Rov0S7UqoS1N0/fqt
 w5LXaOWyXBPu/Qq9T3JBzOq7EoKwwgjLCzzahGh1OolqL6ZDY8M2IrARUIxMvFeUX5tYgoltsbQ
 =
X-Gm-Gg: ASbGncuJczPQSqn/HlvVVzhVLtdLnH8SDItkJKZeRGM2INd9TlZ8jNgSWxMKbu5jMrQ
 b+hMVfa3FBZwDVThXYu6yiMOPhcrgYK9dkVpRjkjDoCBu+YNrcXvDjDOZ19FvgIt9RgYZmPvWcJ
 xCCj5ZW68Vb4EhPiM3wJFi9C8k9AZGCj1zRj9Su9a3pETP42OZ+zinQ85uteuDmMknjicsY1Vgv
 6GlDyE47h5xLCgmCSYMcvWJAd5TFCRgA5Ao5Ewgy/1e2JQpnTybrBTgzlnffn60qkmH2/C4ecEb
 9XrD4eQWB46vDMRi2qI7s8I2UxXOTacJ
X-Google-Smtp-Source: AGHT+IGTBZTE94nTPwaxzTFbk0znrl3hKxdMssXGV4zjHHxa58vn4O1BDbPoKSJibJo9I2tY1KOr1w==
X-Received: by 2002:a17:907:360e:b0:aa6:8d51:8fdc with SMTP id
 a640c23a62f3a-aac348c4e1bmr2700299566b.58.1735301626121; 
 Fri, 27 Dec 2024 04:13:46 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e82ede9sm1098662766b.2.2024.12.27.04.13.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 27 Dec 2024 04:13:45 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, thuth@redhat.com,
 zhao1.liu@intel.com, imammedo@redhat.com, akihiko.odaki@daynix.com,
 npiggin@gmail.com, Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v3 2/6] hw/usb/hcd-xhci-pci: Move msi/msix properties from NEC
 to superclass
Date: Fri, 27 Dec 2024 13:13:32 +0100
Message-Id: <20241227121336.25838-3-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241227121336.25838-1-phil@philjordan.eu>
References: <20241227121336.25838-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::62a;
 envelope-from=phil@philjordan.eu; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

The NEC XHCI controller exposes the underlying PCI device's msi and
msix properties, but the superclass and thus the qemu-xhci device do
not. There does not seem to be any obvious reason for this limitation.
This change moves these properties to the superclass so they are
exposed by both PCI XHCI device variants.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---

v3:

 * In line with recent upstream changes, the property table is now
   const and no longer carries an end-of-list marker.

 hw/usb/hcd-xhci-nec.c | 2 --
 hw/usb/hcd-xhci-pci.c | 6 ++++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/usb/hcd-xhci-nec.c b/hw/usb/hcd-xhci-nec.c
index b1df95b52a..1df518baf5 100644
--- a/hw/usb/hcd-xhci-nec.c
+++ b/hw/usb/hcd-xhci-nec.c
@@ -37,8 +37,6 @@ struct XHCINecState {
 };
 
 static const Property nec_xhci_properties[] = {
-    DEFINE_PROP_ON_OFF_AUTO("msi", XHCIPciState, msi, ON_OFF_AUTO_AUTO),
-    DEFINE_PROP_ON_OFF_AUTO("msix", XHCIPciState, msix, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_UINT32("intrs", XHCINecState, intrs, XHCI_MAXINTRS),
     DEFINE_PROP_UINT32("slots", XHCINecState, slots, XHCI_MAXSLOTS),
 };
diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
index e5e7330387..49642aab58 100644
--- a/hw/usb/hcd-xhci-pci.c
+++ b/hw/usb/hcd-xhci-pci.c
@@ -198,6 +198,11 @@ static void xhci_instance_init(Object *obj)
     qdev_alias_all_properties(DEVICE(&s->xhci), obj);
 }
 
+static const Property xhci_pci_properties[] = {
+    DEFINE_PROP_ON_OFF_AUTO("msi", XHCIPciState, msi, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO("msix", XHCIPciState, msix, ON_OFF_AUTO_AUTO),
+};
+
 static void xhci_class_init(ObjectClass *klass, void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
@@ -209,6 +214,7 @@ static void xhci_class_init(ObjectClass *klass, void *data)
     k->realize      = usb_xhci_pci_realize;
     k->exit         = usb_xhci_pci_exit;
     k->class_id     = PCI_CLASS_SERIAL_USB;
+    device_class_set_props(dc, xhci_pci_properties);
 }
 
 static const TypeInfo xhci_pci_info = {
-- 
2.39.5 (Apple Git-154)


