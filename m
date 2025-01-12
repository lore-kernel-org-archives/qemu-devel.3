Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D435E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 21:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX57U-0006kg-Im; Sun, 12 Jan 2025 16:03:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tX55e-0004YX-JA
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 16:01:56 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tX55Y-0006QC-Ue
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 16:01:45 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5d437235769so6272450a12.2
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 13:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1736715699; x=1737320499;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c4OQlrQ2lOwO235fKNtUs/AAw1axl2Gl19Nw0aS3zkY=;
 b=ELJ3koK560D8f8/Wm7V9QlWpmSNKkIVcrAq1ykFqbaHq2rKwCZCz5kWI72KoW6UJrt
 6YMoaeCC3Rm/Rm8k31O6bGmXOdpoZv0X+FoFNre1QbKMISB/HyQr4jG2yXaomXlJX55r
 IAaSdm3Q6tQgVF6Auc+myNGKCRPfkN7GAdIDMrA7J+qCcK2dDToDB3Y3CGRN93Snk+jw
 cUvrGhrLNSz8bhaVmbJTY7TWQg/SxRlzAapadbo/VnKd+dGO6r+Jb8pkxMNxnactLW6p
 8KARZLbC3xoZyO34aj0+mnBfwVFiBSPa7dKoM0LQ+UnoJu4cHztAmLUuR0NZYMRN60RS
 UHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736715699; x=1737320499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c4OQlrQ2lOwO235fKNtUs/AAw1axl2Gl19Nw0aS3zkY=;
 b=AyLe/YOlG+9FHZUvuJt+FjEsy2sJv2n/cKCybuLh9o5TgmW8Dorp8dDId7lMbbH3pK
 en1dLfAzUDpq64l4/uKdA4mURGwOpreE4P/WVw8vOjUUQNda12z927lkTVRDLuRvO1JG
 TFHum4jHdIG3BCea5wM2AtJBwCOMYyLvyuZS6cd4mbfaAFRTf3GeqXNj618pAa+UlXmm
 YHLr1bbrcUbPxtwFrivQgfH0wpKWH72NP9M7T6WumLBIJfivHxbznUcy/NlEug8bHFeN
 hGMsSBMJssCutGqSJyYJ0kP4exMz56ZaRJWMdKfnYYyJIlRmfJUXuASfNEloddzJXM9M
 BGbQ==
X-Gm-Message-State: AOJu0YzBzdKQ4/OF4z+smbNPqtxE0EyBw6MeCb7doUsuoUOwYEfSd1fZ
 wRlrIafzeqEzvvFSOXxkLRlKJUzBXiBEOZKHCYnQvi/UZqxZo6KHsk71qO1jkJVc++0zhWJOYF/
 bvQ==
X-Gm-Gg: ASbGnctmjDv2Asy4icHpb6jGn3derQDAlbq8xqbf8MoGPkB+gkIsNGQmJUBlGu4vjvd
 FbjTcZtl6DQaprcsyFoK0/QeXLCFresbU3WycuNFbpcBgPb4888HUFh7QrclJgJucxkEHaPMFjW
 8VsTBv7PG5mB4H8sdArgDehF5RxKfLY/DBEZCl34Agwp6wgf5GxkD6jm8W7GP+V4xVK4cMI24Rn
 yJi1SGg9RAN7lJNhVvgHoPgpW8yHetQRMtPf0K/eIQ6vOcVdvPKGDMpFJLZUIn8/s/JZbxG44au
 nAE2+8+cj+6Ea++tEPcyaqc+KTMSAqVs
X-Google-Smtp-Source: AGHT+IEqNQNdagW68QI1u45pshUbyN9H59FOdViHKvwNJPRDM6TZvUhCw480XzfnsSghy0h/hwQjzg==
X-Received: by 2002:a17:907:1c21:b0:aab:d8df:9bbb with SMTP id
 a640c23a62f3a-ab2abc925cbmr1809514566b.41.1736715699279; 
 Sun, 12 Jan 2025 13:01:39 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c905e283sm418276666b.31.2025.01.12.13.01.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 13:01:38 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: agraf@csgraf.de, phil@philjordan.eu, peter.maydell@linaro.org,
 pbonzini@redhat.com, mst@redhat.com, stefanha@redhat.com, kwolf@redhat.com,
 hreitz@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, marcandre.lureau@redhat.com, philmd@linaro.org,
 eblake@redhat.com, armbru@redhat.com, qemu-block@nongnu.org,
 qemu-arm@nongnu.org
Subject: [PATCH v17 09/11] hw/usb/hcd-xhci-pci: Adds property for disabling
 mapping in IRQ mode
Date: Sun, 12 Jan 2025 22:00:54 +0100
Message-Id: <20250112210056.16658-10-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250112210056.16658-1-phil@philjordan.eu>
References: <20250112210056.16658-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::534;
 envelope-from=phil@philjordan.eu; helo=mail-ed1-x534.google.com
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
index 49642aab58..d908eb787d 100644
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
 static const Property xhci_pci_properties[] = {
     DEFINE_PROP_ON_OFF_AUTO("msi", XHCIPciState, msi, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_ON_OFF_AUTO("msix", XHCIPciState, msix, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_BOOL("conditional-intr-mapping", XHCIPciState,
+                     conditional_intr_mapping, false),
 };
 
 static void xhci_class_init(ObjectClass *klass, void *data)
@@ -215,6 +235,10 @@ static void xhci_class_init(ObjectClass *klass, void *data)
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
index 08f70ce97c..5b61ae8455 100644
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
index 00d5bc3779..64c3a23b9b 100644
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
index 9609b83514..9c3974f148 100644
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


