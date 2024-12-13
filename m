Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59712E7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 16:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM8Bm-0001nU-KL; Fri, 13 Dec 2024 11:06:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tM8BV-0001hN-PU
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 11:06:35 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tM8BS-0006f4-2E
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 11:06:33 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aa692211331so373676266b.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 08:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1734105987; x=1734710787;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jRHJVPywLGuIe9/mffxsEcUXl8cWfA9NHuC9ZmkCOio=;
 b=rSEacpD31vbCPVqUR+7g/X4YWEeUb9yhR0dFMIscCvrnF0+T+o/aToqA4Uq3RJVHSp
 ugX4kMBqVyFrxYcwPZU2D4292msz7T1/RzDDtzm6YmZbV5j4d4Y7JnImu3dWF0Wos2kB
 YLn6lfZFa70hHst6cV24lvQ9K1RAVZljqltq+R4iH7ZZfkMJdRMifePndLR4Zr58zGuy
 gDKcJ6W+L4qO8U7uLjvKoOpsuQtkU3D+6hkg+7vafYpWrJefTkUXB3ig6T1fFgP6aF0S
 FLYBA3uCIszlkmDGPXYUY0MEW3bOWT00ys9E+yX4zttCFOSmu7x5Q3OwbLmJjeOftqA5
 aaYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734105987; x=1734710787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jRHJVPywLGuIe9/mffxsEcUXl8cWfA9NHuC9ZmkCOio=;
 b=EOvYYOne5jmzd1QCBTlakkxw6awzNh/uzxfJoaCDQLrtRlZBDBQXkZshFIT79x/XQ0
 06XO6+V9/MpEopeYCKJgeF2JdxKHMNz4bUc5Ye5HqG3lEFG9a9YYA/qZk00hC5N8731m
 K0dhsyQ30ptrNvS0WHjvpyc8o+XM1cfFK2biGzd/7ym/LEYkTnbSsYWUWDHJESR67Qiw
 w37K+opxwFHY+mtQsFU+LKnNgZnUDo0dYmOyoBhVaQCwcX5zPTR7770VM5+7DZUnZZXZ
 f47+ea7bEfk8K9nrrsGlD5CjO9LlQLnAb+pskE5h6R4DComZmKx+OD1yG/dj2Un191L6
 I+Dw==
X-Gm-Message-State: AOJu0YywESfc3F+Ln/LsaCaOOrL/IfGcUpXPxf9FuI1pjcjHQ6cPosKf
 8rbnwNKDqYphofQePYyjFO85XFvgG3MvxXQnrE32EcEV7Z9zZnqaDcnVGwWZVltmxi/dDyiGdcr
 15Q==
X-Gm-Gg: ASbGncsQ+tBiaqSYt66rhYwjKnWvx/7ULBPy9f7cTaDp1X/oAHyYNCmrPxDFeqljTal
 7qcMNVJl6HlBw22YWhgSI1eazBKVKVxsp9t80IlqVruWYYR8Z03sTLBQddnh1BsKp2SxRXtack6
 PS6X/2kYYMIHnRZ6MShnvnmZbgJBNbVgcPzcVruPYe45vBdEnHXssABxbqShyIY6gqqXm14tGPK
 4k8AAz3rxqTZ1gU6pR/4TMYlZ0Ep0fonOP27gZHZlOHichjwxoZPcnRyD06nvEkpAMmYttNwB4o
 oFw7q4Ft7/7TZV3ZzApwHH+NOd+9cyQE
X-Google-Smtp-Source: AGHT+IGYTDh2abbXkhDKixrPRTb0iMB6Hr2e1jrwj4SdyViS695Qp5O496VJwB7HuqNIWNbOF3A4Dg==
X-Received: by 2002:a17:907:1c9e:b0:aa6:489e:5848 with SMTP id
 a640c23a62f3a-aab7b8485admr241965266b.25.1734105985939; 
 Fri, 13 Dec 2024 08:06:25 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa667843413sm916683166b.24.2024.12.13.08.06.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Dec 2024 08:06:25 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, thuth@redhat.com,
 zhao1.liu@intel.com, imammedo@redhat.com, akihiko.odaki@daynix.com,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v2 2/6] hw/usb/hcd-xhci-pci: Move msi/msix properties from NEC
 to superclass
Date: Fri, 13 Dec 2024 17:06:15 +0100
Message-Id: <20241213160619.66509-3-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241213160619.66509-1-phil@philjordan.eu>
References: <20241213160619.66509-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::62b;
 envelope-from=phil@philjordan.eu; helo=mail-ej1-x62b.google.com
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
---
 hw/usb/hcd-xhci-nec.c | 2 --
 hw/usb/hcd-xhci-pci.c | 7 +++++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/usb/hcd-xhci-nec.c b/hw/usb/hcd-xhci-nec.c
index 0c063b3697d..408bf065e5a 100644
--- a/hw/usb/hcd-xhci-nec.c
+++ b/hw/usb/hcd-xhci-nec.c
@@ -39,8 +39,6 @@ struct XHCINecState {
 };
 
 static Property nec_xhci_properties[] = {
-    DEFINE_PROP_ON_OFF_AUTO("msi", XHCIPciState, msi, ON_OFF_AUTO_AUTO),
-    DEFINE_PROP_ON_OFF_AUTO("msix", XHCIPciState, msix, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_UINT32("intrs", XHCINecState, intrs, XHCI_MAXINTRS),
     DEFINE_PROP_UINT32("slots", XHCINecState, slots, XHCI_MAXSLOTS),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
index 516e6909d20..35f02132bb4 100644
--- a/hw/usb/hcd-xhci-pci.c
+++ b/hw/usb/hcd-xhci-pci.c
@@ -198,6 +198,12 @@ static void xhci_instance_init(Object *obj)
     qdev_alias_all_properties(DEVICE(&s->xhci), obj);
 }
 
+static Property xhci_pci_properties[] = {
+    DEFINE_PROP_ON_OFF_AUTO("msi", XHCIPciState, msi, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO("msix", XHCIPciState, msix, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void xhci_class_init(ObjectClass *klass, void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
@@ -209,6 +215,7 @@ static void xhci_class_init(ObjectClass *klass, void *data)
     k->realize      = usb_xhci_pci_realize;
     k->exit         = usb_xhci_pci_exit;
     k->class_id     = PCI_CLASS_SERIAL_USB;
+    device_class_set_props(dc, xhci_pci_properties);
 }
 
 static const TypeInfo xhci_pci_info = {
-- 
2.39.5 (Apple Git-154)


