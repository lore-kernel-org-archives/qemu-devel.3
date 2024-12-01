Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F65ED49779
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 16:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHmQG-00033q-H9; Sun, 01 Dec 2024 11:03:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tHmQD-00033G-Rj
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 11:03:45 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tHmQ8-0005yQ-5k
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 11:03:42 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-434a83c6b01so29345895e9.0
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 08:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1733069010; x=1733673810;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+wTHBUrXI8QFBkDCD6L4J77EtzYe3TetwP1qRxIJJLM=;
 b=MPUunlX9GgY4NEo5tnRw5+wZUFdT+lOA8blABMajfJRXCIL56BXrqzofiUsGetG1DA
 I0zDsNrfXSg1IlHB/kFLVSfeqSKOyDzH3P9+NuDzSyY+H7IITNr3P+nfBBpbTmjnZWg9
 aNnUX+drYsD3a2umKN6/Bq9wE5I4TiMJZ3Q+PIXvfYaJ1SglIVB7FQsIpBTwQIxim+Pi
 59JziX+CRGifmwd8xxNVzSdAgsBiCrAQP1lBpC4V7uVdJT6+41jYbKwWV0ZTKdqZUc5P
 k+WgFDuisUQDSp5h0RZeD5ug4OJN/hOXmnZiu+mHtI7bF7pUnRvj0L2if8Z2b6JKHwBP
 N7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733069010; x=1733673810;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+wTHBUrXI8QFBkDCD6L4J77EtzYe3TetwP1qRxIJJLM=;
 b=bNp/sEsoFDGdwtqiL07NZN+UCUEBzHC9q8T4TRvj7BFYE83X44kSanXwbHFN3/FdIt
 IpnZgyYUZJ2w/7L7DPjrgaWQJOimdxy71nGiw4VSGvQ8Dz9Ui4lUbQIsoVu4gB2GoNux
 u+yI1BBqD7EciW+Fq66V3dT1M4bE65Cv4Ew8FWcDKNcQzDYbPEuFN7CFYnUJnCMh6zH9
 81a8vBIcfOuruqPdpivpkiGBWaB4pb9em3RbmcjLhZ1X5CAvx3M9lON1liNEdHEMuI9z
 C1LABenT0thp86DPDf6TEDbLHvlNoydyUMUbXtFkbnCHoy0mgGmwIFc3L3lDFIjukgXS
 lpKQ==
X-Gm-Message-State: AOJu0YxAUkv70jnXs3QQq0lFv5DsVsX8FAQxHptx4nyM8u1MNbJ1GQpp
 Q3dO6k7jvtRRNjBHOuN0eJxfFZvS7OLfuKrdET3pGspsoUhvRoCNvo4PBthzHRfdOWUeqwOzw+M
 =
X-Gm-Gg: ASbGncvPbuaP5q7gMVKeEmIEpQQBo4P+BBGN+I0zMgsqZv7xiv6POrLmwoUIWrNQxs8
 HthsFml99i/nARDH5s5Szvf3F7gbZKf5Q/jz+WcZaTfcvHUUbDf/xWQ1xrVuGBEdx1UNcbmQHkv
 Vt8rmu5cscbjZBtfvVbbAWPs5RksSEUo4EOG2WCLN/Qo3fMB5I8oO2b29XT6pBkHmU1naZtS5A2
 5DY3BehyFY6ENNILtnyX9rTsSE01cxsAIve4nQXghLm60g6MUOi8ZbbfLtzuYmJFa1xUmMGyAtq
 QUV73F41Ss4cIEE++EvK3YmmeA==
X-Google-Smtp-Source: AGHT+IFzLxd8tyKsemw29qa1bYxzgtvHcYWZflIZ9k1n2ySQrPwAnsX1qUByB5MSInITYkUyORdEpA==
X-Received: by 2002:a05:600c:3b14:b0:434:a734:d268 with SMTP id
 5b1f17b1804b1-434a9dc02a3mr181069465e9.14.1733069009594; 
 Sun, 01 Dec 2024 08:03:29 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434b0d9bef8sm120393605e9.7.2024.12.01.08.03.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 01 Dec 2024 08:03:29 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, thuth@redhat.com,
 zhao1.liu@intel.com, imammedo@redhat.com, akihiko.odaki@daynix.com,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH RFC-for-10.0] hw/usb/hcd-xhci-pci: Use event ring 0 if
 interrupter mapping unsupported
Date: Sun,  1 Dec 2024 17:03:16 +0100
Message-Id: <20241201160316.96121-1-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::32c;
 envelope-from=phil@philjordan.eu; helo=mail-wm1-x32c.google.com
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
for PCI based XHCI controllers.

The XHCI specification, section 4.17.1 specifies that "If Interrupter
Mapping is not supported, the Interrupter Target field shall be
ignored by the xHC and all Events targeted at Interrupter 0."

The PCI XHCI controller supports MSI(-X) and maxintrs is therefore
reasonably set to 16. The specification does not address whether
interrupter mapping should be considered "supported" if the guest
driver does not enable MSI(-X) via the PCI configuration area, possibly
because the PCI host bus does not support it.

QEMU's XHCI device has so far not specially addressed this case, and
no interrupt is generated for events delivered to event rings 1 and
above. The macOS guest driver does not get along with this
interpretation, so many events are not delivered to the guest OS when
MSI(-X) is off.

This patch changes the xhci_event() function such that event ring 0
is always used when numintrs is 1 (as per spec section 4.17.1) or
if neither MSI nor MSI-X are enabled. The latter is checked by adding
a new, optional intr_mapping_supported function pointer field supplied
by the concrete XHCI controller implementation. The PCI implementation's
supplied function calls msix_enabled and msi_enabled accordingly.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2705
---
I've been chasing this problem for a while, and I've finally figured
out the cause, and I think an acceptable solution. I've explained the
problem and quoted the relevant sections of the XHCI spec in more
detail in the linked GitLab issue:

https://gitlab.com/qemu-project/qemu/-/issues/2705

The fix provided is I think the simplest one in terms of lines of code,
but it's also a little ugly, as we're constantly checking msix_enabled
and msi_enabled via a callback function. Granted, we're already doing
that in xhci_pci_intr_raise and xhci_pci_intr_update, but this adds
a bunch more calls.

The main alternative I can see is to "push" the state of whether
interrupter mapping is supported: provide a custom config_write
implementation for the PCI device, and every time the configuration
area is updated, evaluate whether or not this means that MSI or MSI-X
are enabled and update a corresponding flag inside XHCIState. We could
even use this opportunity to switch out different .intr_raise and
.intr_update functions depending on which interrupt delivery mechanism
is active in the PCI device.


 hw/usb/hcd-xhci-pci.c | 9 +++++++++
 hw/usb/hcd-xhci.c     | 5 +++++
 hw/usb/hcd-xhci.h     | 5 +++++
 3 files changed, 19 insertions(+)

diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
index a039f5778a6..21802211cf7 100644
--- a/hw/usb/hcd-xhci-pci.c
+++ b/hw/usb/hcd-xhci-pci.c
@@ -81,6 +81,14 @@ static bool xhci_pci_intr_raise(XHCIState *xhci, int n, bool level)
     return false;
 }
 
+static bool xhci_pci_intr_mapping_supported(XHCIState *xhci)
+{
+    XHCIPciState *s = container_of(xhci, XHCIPciState, xhci);
+    PCIDevice *pci_dev = PCI_DEVICE(s);
+
+    return msix_enabled(pci_dev) || msi_enabled(pci_dev);
+}
+
 static void xhci_pci_reset(DeviceState *dev)
 {
     XHCIPciState *s = XHCI_PCI(dev);
@@ -118,6 +126,7 @@ static void usb_xhci_pci_realize(struct PCIDevice *dev, Error **errp)
     object_property_set_link(OBJECT(&s->xhci), "host", OBJECT(s), NULL);
     s->xhci.intr_update = xhci_pci_intr_update;
     s->xhci.intr_raise = xhci_pci_intr_raise;
+    s->xhci.intr_mapping_supported = xhci_pci_intr_mapping_supported;
     if (!qdev_realize(DEVICE(&s->xhci), NULL, errp)) {
         return;
     }
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index d85adaca0dc..a2a878e4594 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -644,6 +644,11 @@ static void xhci_event(XHCIState *xhci, XHCIEvent *event, int v)
     dma_addr_t erdp;
     unsigned int dp_idx;
 
+    if (xhci->numintrs == 1 ||
+        (xhci->intr_mapping_supported && !xhci->intr_mapping_supported(xhci))) {
+        v = 0; /* Per section 4.17.1 */
+    }
+
     if (v >= xhci->numintrs) {
         DPRINTF("intr nr out of range (%d >= %d)\n", v, xhci->numintrs);
         return;
diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
index fe16d7ad055..6e901de6e6b 100644
--- a/hw/usb/hcd-xhci.h
+++ b/hw/usb/hcd-xhci.h
@@ -193,6 +193,11 @@ typedef struct XHCIState {
     uint32_t max_pstreams_mask;
     void (*intr_update)(XHCIState *s, int n, bool enable);
     bool (*intr_raise)(XHCIState *s, int n, bool level);
+    /*
+     * Device supports Interrupter Mapping per section 4.17.1 of XHCI spec.
+     * If NULL, assume true if numintrs > 1.
+     */
+    bool (*intr_mapping_supported)(XHCIState *s);
     DeviceState *hostOpaque;
 
     /* Operational Registers */
-- 
2.39.5 (Apple Git-154)


