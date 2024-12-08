Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8489AE77173
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2024 19:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKMmu-0005Kc-Cs; Sun, 08 Dec 2024 14:17:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tKMml-0005Ix-NY
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 14:17:44 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tKMmk-0001Vx-1B
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 14:17:43 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aa5325af6a0so568070666b.2
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2024 11:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1733685460; x=1734290260;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZDLwO59qMJIads3fEO76SDUFkR5YOH4ziTSFt3LfxpA=;
 b=sC61SZWFa5egoTTtR89TGWcbt+Ym8F7RSF/+Jaf019tZMs9bi2uw3uSZCjlMGqQFAC
 FpDgFs9U5NZDX0eU0ifV/22pGgD1p1VdIFfnq9E/e7Vb00y6ve1msaA8mnbnMZlcnzPr
 JGYMGNnrjt5D23tQ4G2E0svhbdSA5Vk9iKHezdJnpLusBDebKW6zSqaLTGuaNpnCTS4a
 Dx3QPYm8Gb46xvZFyCbThPkjoI85sEsVtwxsMg/+7vpLXYmopNTqBFI5JBlTS0Xww906
 PQP7bCv/7feFTtwOBgIeDWOrjEdYaBeo1JrQEIp2Vv0BuswEXyody1Cpi5Jie/jNaAk/
 Erow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733685460; x=1734290260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZDLwO59qMJIads3fEO76SDUFkR5YOH4ziTSFt3LfxpA=;
 b=KAOiTHsRmNI/lRNdFzAZ5/4f9pIlxVJOpZWvD7twNRyHc80+NnQR7ZjqBcZjqDuboZ
 xnVnh6gGBiBr4IbWqOCNaAPMeGzf3Y9/rFWcNwffaYYtRp3M+vrmN9OccrJw1YenDrJ8
 HpAZX5hjpn4YMrGMGGATW4a2EfHdxbia5VdlSBUQIDYlFs1QjCkKw+9Em8uvQc5kRanm
 M1gLqhqQDfc+3UL9XhzfHiF4nv4xnANOICWYPR9OpFy1qSVu7Q6XuMqscB+WJAbb3x8p
 ZTFq6/Chsm4yf7uLAp6Z+/kpsU7N+TOiGZrcRuIAD0iHQbkvsu3cl9adt2RPSGifC5v2
 nuoQ==
X-Gm-Message-State: AOJu0Yzm4YtIp+435imT4/iagTNg92tC0kXa6g4oZ8xnmXtv+c82e/9f
 0bfIEgcz6FXBzexqCeKe/p+hD0EOmTR8WYP2JTBlktfGCUit4pt078PrySWyuBz/mRc1AdHT7EQ
 GEQ==
X-Gm-Gg: ASbGnctY//VZASMBwylOtXeZ/A+cYa9d2GpvLzvXky+N1FONsEzTi4HO+/cobS2RgHK
 xPbAsL+0e8kucmoGLwH2qyuAxMTrWjCQ53noW9xS6jQGcHx2BmX3r7SWZyKTnloHUZWes0cFub1
 ak1vf08fSCEfCOgHFLahEO2fgRSdQqsjF9WVWnSRShHFhtEuaiw/dWSv7UKnlk3JxmxIqzc7tcj
 c8u2vkUMpFnEZcaXelpDB/+Yo9dsvWDWjqHTltnQqk4+znDHcXiWWXryRPgwdS2x7nw3ROB8eP6
 Za2EGCpwJCo0W6+vIEXBNWWm3A==
X-Google-Smtp-Source: AGHT+IGSUTH0PqdBxOdEhYLxFUrd1SQgJvDp6AJd5F8+uJE77vebklbh+La6rdOxo8r5J/NYYXmHjw==
X-Received: by 2002:a17:906:4d1:b0:aa6:19c9:ad08 with SMTP id
 a640c23a62f3a-aa63a20d60bmr876454066b.48.1733685460493; 
 Sun, 08 Dec 2024 11:17:40 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa665119a06sm240350866b.121.2024.12.08.11.17.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Dec 2024 11:17:39 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, thuth@redhat.com,
 zhao1.liu@intel.com, imammedo@redhat.com, akihiko.odaki@daynix.com,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 2/6] hw/usb/hcd-xhci-pci: Moves msi/msix properties from NEC
 to superclass
Date: Sun,  8 Dec 2024 20:16:42 +0100
Message-Id: <20241208191646.64857-3-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241208191646.64857-1-phil@philjordan.eu>
References: <20241208191646.64857-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::62c;
 envelope-from=phil@philjordan.eu; helo=mail-ej1-x62c.google.com
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
index 376635e889b..0278b0fbce2 100644
--- a/hw/usb/hcd-xhci-pci.c
+++ b/hw/usb/hcd-xhci-pci.c
@@ -197,6 +197,12 @@ static void xhci_instance_init(Object *obj)
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
@@ -208,6 +214,7 @@ static void xhci_class_init(ObjectClass *klass, void *data)
     k->realize      = usb_xhci_pci_realize;
     k->exit         = usb_xhci_pci_exit;
     k->class_id     = PCI_CLASS_SERIAL_USB;
+    device_class_set_props(dc, xhci_pci_properties);
 }
 
 static const TypeInfo xhci_pci_info = {
-- 
2.39.5 (Apple Git-154)


