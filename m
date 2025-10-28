Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE44CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 07:53:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDeVB-0002zW-Fd; Tue, 28 Oct 2025 03:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeV3-0002ld-A4
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:52:13 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeUy-0007Zp-75
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:52:11 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-475dbc3c9efso22253245e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 00:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761637919; x=1762242719; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V9WtpCOfKaEaJh4imVy+lkl1W31r/jVxnQllCP35oEs=;
 b=F9i3tDY01sAzopWX8cOmn9IrIk1vQUiI4NdAGRCwiPNb43yfegqs2Xb8VxsH/EgRQt
 IkNEqgdB2LbzSa54CWH4TRUPXIeoVUhwEzsKKxlC/X2mjzaxtbiJxEWpqFmdqZ/GqpoX
 IWqB9N/+metPp/+CqP2I7D7ydSM70fUcv8pOTE2sTSiRgogJbxebzHJXZCUZDV5mVXCj
 u1awqMO0c9BykoSfQK2g63LktpAT0vK+5nlcbBEYeZm7Id1lFbxauEXDE3hQuiqjdD+8
 OezokR6KiSQ5Dc4FkfcYBbnAnlRce+uT9ZyKG4X/FF/VR2+pZtz/eipQNyptOBsI+Yhs
 b+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761637919; x=1762242719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V9WtpCOfKaEaJh4imVy+lkl1W31r/jVxnQllCP35oEs=;
 b=c2/uASIZfbaHyAchQsptLSqGbxUwMxSGeSEqgSkVXh1FqKc9qDX6mCx4rh0ovqNCVq
 2AeLfaPoRyP5xGEOQDO14lyR7/SJo1B/3PZJ8mBiLWDUflG1mF7ZkcyE9xP0vvmLsE+8
 ntTWWxe26NLmg3FtEsi3bPLMoMjGExqNr3S/wHhUr2njCkf0sLDIlm31bREL43pAI8oZ
 wfZhlDqbjOOSAo/UyDZ59cZlt0qTHmSdqT9zcnIUelnUhE+aczkSSP9l6VeptExiLXXu
 vKhb6pPAXc31WGbcK4gtmdZhOhwfV28wcf76ImaLtHarajVYjQtwd4x4/5QU40W5UZbX
 cjYA==
X-Gm-Message-State: AOJu0YzZ8jt8FMgqHv6pxIer+CP3DzgZpNOrjdfzqMkvZadm1BHZFxLH
 1ILkykem7VhxDeq3NGSVLmCYH+sflNkQNkMt+RBOaAsqfWTEsggDKPxDPnJ2HsGFm+2CzAtTjt+
 KaKI35Nk=
X-Gm-Gg: ASbGncvExThS0JMA3SVqb3OMooOxbYzwIn24T/EHaZB71AGTYytEezLXYKxiQ9lecmj
 pRnidjroZQDmes1+FFbJCz2eakmH5rY0ei6LLD2UbtYMm5jxn7+JhNMqXausUPC4zh69XHCvjF6
 nsIeRWMVc9+XxfGsAo4YVhjoaLoUtuzpp0K+A0v2iDWLJ3ZINCYeEmW7GLFxRCyKfRFqZsCYugq
 PiY+W16onm8U2/0fE3C6/G6P6HfADj7aB2/3YTGXkRgJgSVE8HXsFt4luhAlxZhqh5xuZW+Zb64
 ZuehyzEmpkWZXFeOeSgp2TaMbEzC19fBbjdBJhCeMCC9//vFDzHpXS4cG1ZVMaYdtH13RVJsF5G
 fpFKlZQc21KKVyLjw/k0KbSA7STB3Yk/LSKPEpj4cIh6MRjCSY2RSjhlOz/vgDpMB+X/9Ho8fgs
 1S7jVgUDQl8M6E7Rd+EOsgWmA1F397d4IiokmlTePMscuAlu1FuPVN0Sw=
X-Google-Smtp-Source: AGHT+IEl+H8afhMl8OG56RzAO5MlkxmZV3EBLQpkhhvHV9AK8MOclpchsWQn+kHQcHLc2BPnhgSmQQ==
X-Received: by 2002:a05:600c:1e0f:b0:475:dbb5:2397 with SMTP id
 5b1f17b1804b1-47717d488f1mr17666755e9.0.1761637919411; 
 Tue, 28 Oct 2025 00:51:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd02ce46sm215875605e9.3.2025.10.28.00.51.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Oct 2025 00:51:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 qemu-ppc@nongnu.org
Subject: [PULL 08/23] hw/pci-host/raven: Use DEFINE_TYPES macro
Date: Tue, 28 Oct 2025 08:48:44 +0100
Message-ID: <20251028074901.22062-9-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028074901.22062-1-philmd@linaro.org>
References: <20251028074901.22062-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Convert to using DEFINE_TYPES macro and move raven_pcihost_class_init
so methods of each object are grouped together.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <4ff8a3e1de847846f08d9ea6b389efeb3eb12aed.1761232472.git.balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/raven.c | 57 +++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 31 deletions(-)

diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index ea5ad69547a..1d09a28bff2 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -296,6 +296,15 @@ static void raven_pcihost_initfn(Object *obj)
     h->bus = &s->pci_bus;
 }
 
+static void raven_pcihost_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+    dc->realize = raven_pcihost_realizefn;
+    dc->fw_name = "pci";
+}
+
 static void raven_realize(PCIDevice *d, Error **errp)
 {
     d->config[PCI_CACHE_LINE_SIZE] = 0x08;
@@ -321,37 +330,23 @@ static void raven_class_init(ObjectClass *klass, const void *data)
     dc->user_creatable = false;
 }
 
-static const TypeInfo raven_info = {
-    .name = TYPE_RAVEN_PCI_DEVICE,
-    .parent = TYPE_PCI_DEVICE,
-    .class_init = raven_class_init,
-    .interfaces = (const InterfaceInfo[]) {
-        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
-        { },
+static const TypeInfo raven_types[] = {
+    {
+        .name = TYPE_RAVEN_PCI_HOST_BRIDGE,
+        .parent = TYPE_PCI_HOST_BRIDGE,
+        .instance_size = sizeof(PREPPCIState),
+        .instance_init = raven_pcihost_initfn,
+        .class_init = raven_pcihost_class_init,
+    },
+    {
+        .name = TYPE_RAVEN_PCI_DEVICE,
+        .parent = TYPE_PCI_DEVICE,
+        .class_init = raven_class_init,
+        .interfaces = (const InterfaceInfo[]) {
+            { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+            { },
+        },
     },
 };
 
-static void raven_pcihost_class_init(ObjectClass *klass, const void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
-    dc->realize = raven_pcihost_realizefn;
-    dc->fw_name = "pci";
-}
-
-static const TypeInfo raven_pcihost_info = {
-    .name = TYPE_RAVEN_PCI_HOST_BRIDGE,
-    .parent = TYPE_PCI_HOST_BRIDGE,
-    .instance_size = sizeof(PREPPCIState),
-    .instance_init = raven_pcihost_initfn,
-    .class_init = raven_pcihost_class_init,
-};
-
-static void raven_register_types(void)
-{
-    type_register_static(&raven_pcihost_info);
-    type_register_static(&raven_info);
-}
-
-type_init(raven_register_types)
+DEFINE_TYPES(raven_types)
-- 
2.51.0


