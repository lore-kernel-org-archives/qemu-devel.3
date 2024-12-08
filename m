Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B930EE77173
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2024 19:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKMmx-0005Ll-8a; Sun, 08 Dec 2024 14:17:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tKMmo-0005JQ-FW
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 14:17:49 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tKMmm-0001WI-Fq
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 14:17:46 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a9e8522445dso722017866b.1
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2024 11:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1733685463; x=1734290263;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j11kvPWanlGrLLqG7zb7nxcA1SYE5rW2xVpp2lF0V4o=;
 b=FcIiuXUEHOTMTxLDOzsUN0bhFxePW6aQxKVhffI8jCSThVLM1zIbmetxy1Eqe9+fxK
 qUK0cUkJ+Y/DNW/nDyMTCH3mD60Om9Q2Am7iBTxi479DSj9RWzwiDVN+65J5t7FrtXsp
 KUCMEhzJGMz4SmlVxtoDDEZBEP3NSTQKdGOMQq4v04aQtazKMmv+xQBoJWR8ShpopCeN
 9wYQfbf78VrFvLHejowMxVuCg8aKAtHrbsYWo2826PaoKb9bHWYEiFq/Tvk1pNRVd3Jk
 uI08bzBLIH/0LCSj3L2pXbY+8gozwoPd8Z5kX5cUW98O70xYkT1es6Voz/j3reeDBdS2
 ZOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733685463; x=1734290263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j11kvPWanlGrLLqG7zb7nxcA1SYE5rW2xVpp2lF0V4o=;
 b=wdvHd853oK+B6IRLnAULdxiUBrSnm2QApTHlKIZKbSvS6SEIFiiA2GbZU9cMus4uTg
 cJcdICI/j/XKKXfpQGSxIgYh0uxpelb7aAoiUhK8zz2IFiCShy/fpYCM9OmPzn0pwNTj
 B79SObexv8oYIJcJt3aXDjt+eEfbAbDcCXECRDQBt+Dit2T9cKEK0SslPhhQeUB3cpM/
 XNwxwnlzFsS+b7BtGdb2mfufn2HqZxQhUMo6qVl4sw0fcDlg7h9R8/sFsEGnY+n3nJtJ
 VopAYXtwtFzmiejjotQHlZ5IWUytHuRhJSMuQQBIpbhcpVDJbTBWvfFMNaJCenbcmAVA
 z53A==
X-Gm-Message-State: AOJu0Yw4XzOlbxALQUC+08a8LOuUc7oIwZRYh0Q2gs+scjbkicwdQJMQ
 p8qXFSbzpSKhmpLSTuEFFOBqbnjguTk0HAO4TIdiczOyYnykB2aFKcrFal8G5oMvVr2uyzgu57H
 O5w==
X-Gm-Gg: ASbGncvlofNExijIeG9mMg1RkpMMFmb/RhllhfQ4/0tVHCq0QBCTCd7WMsmSqXFT1Jo
 x3JieFW2QGIjtLDaySvv7fns3+MyuanUc45FjSRfoDpSQXT2cy/YCT10DkWA/ToANt8e9SQq8v5
 mstJF3sRRDcWIdZweTBWA89eBCxXYipay+1m5awcePMULTo+DVDWx7TaRs6kJ1wU2Lr9Tc/+Aq3
 Wp29Pc8A3t+vPRkJxPKhFQUQuyacE/8RiGW+KMOhTMskiwGYU52hhcN7by+AtdVtl7ZVoI0jdT8
 ZFZklVxsWBKjxqcKbp7jlv/UBA==
X-Google-Smtp-Source: AGHT+IEyqrOvp78VZ1deiWl5GzaALRWisEoRUKmGh3s4KwBeulVCEM/CbvGW+ls5n2n9wyPGgdYOwQ==
X-Received: by 2002:a17:907:1de6:b0:aa6:59ef:ec with SMTP id
 a640c23a62f3a-aa659ef01a8mr445374866b.1.1733685463114; 
 Sun, 08 Dec 2024 11:17:43 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa665119a06sm240350866b.121.2024.12.08.11.17.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Dec 2024 11:17:42 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, thuth@redhat.com,
 zhao1.liu@intel.com, imammedo@redhat.com, akihiko.odaki@daynix.com,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 4/6] hw/usb/hcd-xhci-pci: Adds property for disabling mapping
 in IRQ mode
Date: Sun,  8 Dec 2024 20:16:44 +0100
Message-Id: <20241208191646.64857-5-phil@philjordan.eu>
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

This change addresses an edge case that trips up macOS guest drivers
for PCI based XHCI controllers. The guest driver would attempt to
schedule events to XHCI event rings 1 and 2 even when only one interrupt
line is available; interrupts would therefore be dropped, and events
only handled on timeout when using pin-based interrupts. Moreover,
when MSI is available, the macOS guest drivers would only configure 1
vector and leading to the same problem.

So, in addition to disabling interrupter mapping if numintrs is 1, a
callback is added to xhci to check whether interrupter mapping should be
enabled. The PCI XHCI device type now provides an implementation of
this callback if the new "conditional-intr-mapping" property is enabled.
(default: disabled) When enabled, interrupter mapping is only enabled
when MSI-X is active, or when MSI is active with more than 1 vector.

This means that when using pin-based interrupts, or only 1 MSI vector,
events are only submitted to interrupter 0 regardless of selected
target. This allows the macOS guest drivers to work with the device in
those configurations.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2705
---
 hw/usb/hcd-xhci-pci.c | 23 +++++++++++++++++++++++
 hw/usb/hcd-xhci-pci.h |  1 +
 hw/usb/hcd-xhci.c     |  3 ++-
 hw/usb/hcd-xhci.h     |  5 +++++
 4 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
index 0278b0fbce2..8e293cd5951 100644
--- a/hw/usb/hcd-xhci-pci.c
+++ b/hw/usb/hcd-xhci-pci.c
@@ -81,6 +81,23 @@ static bool xhci_pci_intr_raise(XHCIState *xhci, int n, bool level)
     return false;
 }
 
+static bool xhci_pci_intr_mapping_conditional(XHCIState *xhci)
+{
+    XHCIPciState *s = container_of(xhci, XHCIPciState, xhci);
+    PCIDevice *pci_dev = PCI_DEVICE(s);
+
+    /*
+     * Implementation of the "conditional-intr-mapping" property, which only
+     * enables interrupter mapping if there are actually multiple interrupt
+     * vectors available. Forces all events onto interrupter/event ring 0
+     * in pin-based IRQ mode or when only 1 MSI vector is allocated.
+     * Provides compatibility with macOS guests on machine types where MSI-X is
+     * not available.
+     */
+    return msix_enabled(pci_dev) ||
+        (msi_enabled(pci_dev) && msi_nr_vectors_allocated(pci_dev) > 1);
+}
+
 static void xhci_pci_reset(DeviceState *dev)
 {
     XHCIPciState *s = XHCI_PCI(dev);
@@ -118,6 +135,9 @@ static void usb_xhci_pci_realize(struct PCIDevice *dev, Error **errp)
     object_property_set_link(OBJECT(&s->xhci), "host", OBJECT(s), NULL);
     s->xhci.intr_update = xhci_pci_intr_update;
     s->xhci.intr_raise = xhci_pci_intr_raise;
+    if (s->conditional_intr_mapping) {
+        s->xhci.intr_mapping_supported = xhci_pci_intr_mapping_conditional;
+    }
     if (!qdev_realize(DEVICE(&s->xhci), NULL, errp)) {
         return;
     }
@@ -200,6 +220,9 @@ static void xhci_instance_init(Object *obj)
 static Property xhci_pci_properties[] = {
     DEFINE_PROP_ON_OFF_AUTO("msi", XHCIPciState, msi, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_ON_OFF_AUTO("msix", XHCIPciState, msix, ON_OFF_AUTO_AUTO),
+    /* When true, disable interrupter mapping for IRQ mode or only 1 vector */
+    DEFINE_PROP_BOOL("conditional-intr-mapping", XHCIPciState,
+                     conditional_intr_mapping, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
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


