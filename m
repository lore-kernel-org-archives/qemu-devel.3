Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F63E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 16:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM8Bo-0001qa-1f; Fri, 13 Dec 2024 11:06:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tM8BV-0001hO-Py
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 11:06:35 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tM8BS-0006fC-2w
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 11:06:32 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-aa6a618981eso305146366b.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 08:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1734105988; x=1734710788;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fihiqrNtU1lwhsHeAONN51DAQcAharB3DZgDkSerMcA=;
 b=O82mEmU5wgtM0/rxInRCjPUGWmP7NOJgEqYwmO+qH63jHrhjsC8Q2osWnqKB7EvINz
 Lcsae9bmzFDrcZB2bWQ33l+YO3DpUzTiHFJt68rHGVCqnzJJ0x/bApzup1FOBfW+ILqN
 IOnKQ57WPVvrrh4GwoeMqXn7kTzgMRYegvlz6BbjfobYpGbEeaWB5npmiQxUgzkkF2xs
 3qKnZ8NFVsbxjai5VhSpckoxkAq/Jz8JkmZj6kemtJ6U7m07WYSuOrypd0TBTv+8qPio
 qGbtbbiRJoCT2d23ygJeRAU1Gu1ggDSElon835+k0NWflIE0H7lNva1oOdefVr6QBcxZ
 Dnvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734105988; x=1734710788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fihiqrNtU1lwhsHeAONN51DAQcAharB3DZgDkSerMcA=;
 b=UkRx33DI+yS+T0c5+JRhskErXx0NVRCvF8bZoi6rGtkXdLajCc3aSzhKLyEFoWzQ/d
 /m153bGWZedjzs1us0952OAIsi5hXE0kaJ6dk5urFn46Uija/mmbCVOsJNO6yhaufk6a
 a7eFF1VWZMdSeOl507VlXzGyvrLxVJsqjn4uzBR0iNQIMxN6+Vqmvj0w2QcbWl98bHrO
 YE4Pt9TG+LXsC/1IQ722VLHrq7Mw59eTD2aC+obyFmdDrDC8y1xIEzvjcdFr/NoUSard
 TcqqAe3MsCx5nOZctCAqdbJpmXmAe0yPNZT6ko9XPaQwmgpZXnAVLjWhlcnj9Is0r2do
 J/MQ==
X-Gm-Message-State: AOJu0YxUSP0lqpc04HfoE+YmiqWF6Rx4fCylP+CumdDwXLRA2+XrJitG
 HYkJSnPcxezczLErh26/ZxM00MHKL9CsoLs1Yj6iAxmLV0/NzP9UrzIxLjoUnOGyw+9C4zj/uh4
 Ffg==
X-Gm-Gg: ASbGncsLj+4yLKBEOA/b+NJRToZBOmIPBb4syJS4wf009Iqa1slpOXJU+mTJwzDmU/B
 B9rfMJNtFD1NlM4wiioSbs2mvu8TZ7iFeVYK9TctNrgZTKl0VcbBcf320lIzL6Dh+RbuZn7eNeN
 oczZ6h9fW/I64oN6DNMxFV2849I0gZTq+xH9796JcamCXLqesEG95Af6If6jNTpENlW2CuPlddo
 J0YlROGYYkzlWxVpaUq9oVOtx08AeTMNABvYLfeUBp5NUIZD2jE9EK4aGnBy0FPSln+a0yGr9SG
 DBuCLeUPXKHArEZ2gUPYKJojY1v7v5x8
X-Google-Smtp-Source: AGHT+IGbLr4aTsymNfaH75Z2bJMqEr3EOhZyD6GFUrKB2s+aUZk/p8xc8VKloIeb2T2o2FQGihY4DQ==
X-Received: by 2002:a17:906:c102:b0:aa6:6885:e2f6 with SMTP id
 a640c23a62f3a-aab779b7968mr350830766b.36.1734105987948; 
 Fri, 13 Dec 2024 08:06:27 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa667843413sm916683166b.24.2024.12.13.08.06.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Dec 2024 08:06:27 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, thuth@redhat.com,
 zhao1.liu@intel.com, imammedo@redhat.com, akihiko.odaki@daynix.com,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v2 4/6] hw/usb/hcd-xhci-pci: Adds property for disabling
 mapping in IRQ mode
Date: Fri, 13 Dec 2024 17:06:17 +0100
Message-Id: <20241213160619.66509-5-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241213160619.66509-1-phil@philjordan.eu>
References: <20241213160619.66509-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::634;
 envelope-from=phil@philjordan.eu; helo=mail-ej1-x634.google.com
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

This change addresses an edge case that trips up macOS guest drivers
for PCI based XHCI controllers. The guest driver would attempt to
schedule events to XHCI event rings 1 and 2 even when using PCI
pin-based interrupts. Interrupts would therefore be dropped, and events
only handled on timeout.

So, in addition to disabling interrupter mapping if numintrs is 1, a
callback is added to xhci to check whether interrupter mapping should be
enabled. The PCI XHCI device type now provides an implementation of
this callback if the new "conditional-intr-mapping" property is enabled.
(default: disabled) When enabled, interrupter mapping is only enabled
when MSI-X or MSI is active.

This means that when using pin-based interrupts, events are only
submitted to interrupter 0 regardless of selected target. This allows
the macOS guest drivers to work with the device in those configurations.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2705
---
 hw/usb/hcd-xhci-pci.c | 24 ++++++++++++++++++++++++
 hw/usb/hcd-xhci-pci.h |  1 +
 hw/usb/hcd-xhci.c     |  3 ++-
 hw/usb/hcd-xhci.h     |  5 +++++
 4 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
index 35f02132bb4..6027eed2d26 100644
--- a/hw/usb/hcd-xhci-pci.c
+++ b/hw/usb/hcd-xhci-pci.c
@@ -82,6 +82,21 @@ static bool xhci_pci_intr_raise(XHCIState *xhci, int n, bool level)
     return false;
 }
 
+static bool xhci_pci_intr_mapping_conditional(XHCIState *xhci)
+{
+    XHCIPciState *s = container_of(xhci, XHCIPciState, xhci);
+    PCIDevice *pci_dev = PCI_DEVICE(s);
+
+    /*
+     * Implementation of the "conditional-intr-mapping" property, which only
+     * enables interrupter mapping if MSI or MSI-X is available and active.
+     * Forces all events onto interrupter/event ring 0 in pin-based IRQ mode.
+     * Provides compatibility with macOS guests on machine types where MSI(-X)
+     * is not available.
+     */
+    return msix_enabled(pci_dev) || msi_enabled(pci_dev);
+}
+
 static void xhci_pci_reset(DeviceState *dev)
 {
     XHCIPciState *s = XHCI_PCI(dev);
@@ -119,6 +134,9 @@ static void usb_xhci_pci_realize(struct PCIDevice *dev, Error **errp)
     object_property_set_link(OBJECT(&s->xhci), "host", OBJECT(s), NULL);
     s->xhci.intr_update = xhci_pci_intr_update;
     s->xhci.intr_raise = xhci_pci_intr_raise;
+    if (s->conditional_intr_mapping) {
+        s->xhci.intr_mapping_supported = xhci_pci_intr_mapping_conditional;
+    }
     if (!qdev_realize(DEVICE(&s->xhci), NULL, errp)) {
         return;
     }
@@ -201,6 +219,8 @@ static void xhci_instance_init(Object *obj)
 static Property xhci_pci_properties[] = {
     DEFINE_PROP_ON_OFF_AUTO("msi", XHCIPciState, msi, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_ON_OFF_AUTO("msix", XHCIPciState, msix, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_BOOL("conditional-intr-mapping", XHCIPciState,
+                     conditional_intr_mapping, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -216,6 +236,10 @@ static void xhci_class_init(ObjectClass *klass, void *data)
     k->exit         = usb_xhci_pci_exit;
     k->class_id     = PCI_CLASS_SERIAL_USB;
     device_class_set_props(dc, xhci_pci_properties);
+    object_class_property_set_description(klass, "conditional-intr-mapping",
+        "When true, disables interrupter mapping for pin-based IRQ mode. "
+        "Intended to be used with guest drivers with questionable behaviour, "
+        "such as macOS's.");
 }
 
 static const TypeInfo xhci_pci_info = {
diff --git a/hw/usb/hcd-xhci-pci.h b/hw/usb/hcd-xhci-pci.h
index 08f70ce97cc..5b61ae84555 100644
--- a/hw/usb/hcd-xhci-pci.h
+++ b/hw/usb/hcd-xhci-pci.h
@@ -40,6 +40,7 @@ typedef struct XHCIPciState {
     XHCIState xhci;
     OnOffAuto msi;
     OnOffAuto msix;
+    bool conditional_intr_mapping;
 } XHCIPciState;
 
 #endif
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 5fb140c2382..b607ddd1a93 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -644,7 +644,8 @@ static void xhci_event(XHCIState *xhci, XHCIEvent *event, int v)
     dma_addr_t erdp;
     unsigned int dp_idx;
 
-    if (xhci->numintrs == 1) {
+    if (xhci->numintrs == 1 ||
+        (xhci->intr_mapping_supported && !xhci->intr_mapping_supported(xhci))) {
         v = 0;
     }
 
diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
index fe16d7ad055..fdaa21ba7f6 100644
--- a/hw/usb/hcd-xhci.h
+++ b/hw/usb/hcd-xhci.h
@@ -193,6 +193,11 @@ typedef struct XHCIState {
     uint32_t max_pstreams_mask;
     void (*intr_update)(XHCIState *s, int n, bool enable);
     bool (*intr_raise)(XHCIState *s, int n, bool level);
+    /*
+     * Callback for special-casing interrupter mapping support. NULL for most
+     * implementations, for defaulting to enabled mapping unless numintrs == 1.
+     */
+    bool (*intr_mapping_supported)(XHCIState *s);
     DeviceState *hostOpaque;
 
     /* Operational Registers */
-- 
2.39.5 (Apple Git-154)


