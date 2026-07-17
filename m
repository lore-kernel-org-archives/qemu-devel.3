Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2264C44522
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 12:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkhaY-0005Jr-RR; Fri, 17 Jul 2026 08:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wkhaU-0005JJ-0c
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 08:22:42 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wkhaR-0007Mx-AN
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 08:22:41 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-47db714766aso762464f8f.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 05:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1784290957; x=1784895757; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AcdABhduBfIyF9jmlRfUpPTbHo+gEE4RXMS6KpMg4VQ=;
 b=jVuAC/tvFz1aqqjZEtbAiBRTKBqtFzt6nmQYi235Yu4yyvam4ITAUlPVEtlLFcnWfR
 10981MxQPVZcUMMX98YNPMVHYZ8Gz/DDQp2oyw6x4cPSXwbAcRbAvG5hbXAyiftzrTUv
 LSM7QpH8V0SC6M/q6hDKHL/bxrJoKRNJ5VV6mkdJdD1R7GyDgRC6yK9GJHCZQ0spnwYf
 MhCz3u1biGN80qN2upO7XqJ0kAw52WfzuYvqtMtb+Ar1fdZsN/Jx6vo9Ut9K7aEQrhRo
 nYBDKWfmP03EQ4+22wFQYJvEb6gav3kVUu1apjbWEUPvBWZa0YkSNpvDiZE7+CAPe+6A
 3EXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784290957; x=1784895757;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AcdABhduBfIyF9jmlRfUpPTbHo+gEE4RXMS6KpMg4VQ=;
 b=EN84UxPnPf0ML0RpaiCB+t6lCyre+hG/sQWpuIq8d8+Dbrk0pB8QFCPg452IsvXSn3
 NPNg8xj609zEyzxFOJikbEbyAizirb0Hi/e6yS7IJ78iB8Ky3rrXK5jZ6Ec9amgnEtyO
 /Bpb/cKbHTAL4qkDOHl95bwNwjYvGjIdr8iT9NCV7SdTekxxQHfXmFEadMqszQ4GOYa8
 7vm7seGL0LPu5xViYrQX/CfYPKyMDBghGa0IdFtaIm5JcixBvBXt3yfPAb9pU5PdjNtT
 yLa+584mg86egFLJ5S62qjyZcZPkhWxM2jd0Or3ZXOJmYTRQ7Vg/K6evwgOWyu3F5XYs
 pkXQ==
X-Gm-Message-State: AOJu0Yz59/QUhY9+c+CaJP8qzVtCGBn+ntpi/5tBXFW6flkHYim5/nAC
 wAONHoIWN7oCJL5UQt7S0ksMeIcz8IR2YaIiSsZX99zWlVVW3nTZy1Ec+UF01RWjWzP0A74DETT
 5qEaxHMQ=
X-Gm-Gg: AfdE7cnCwjBPfKhEpFzNIBmvioElCD3c4l/2lzBxqR4rC2jMQR79g5SKi/P5IvFGiGU
 P1JRaimNSSo77R582v4waLIUIsJtATe4vEvdDkuE2RUKQdnxTVfKTTzyGwbex6ENsKQWC0aTLOU
 lqf21t4isnZHGXMRSu3apLwrHIvPjP93yfxlghNRKGCbaPoDfzO0dIzwVeetZNQ7CQAl8XlzYdM
 HEfReddpcTz7+6B3TJZqS4PtXy9OlJ08ZmNEJn1NmZ/kOpuFoRYaFJQblW9zd/4vQlp9ptCsunt
 5cudHEXtwUyRGSYg79SlTZNcSiMgOnOqVzmSxkaWuy2zCwN1pf6Obhb6buzOrYWp3m3tmX32BWa
 6aPRNzPGTXecd0xLWY8xQvrvUfFitb7Q48eWJgFcZgsxJehKA98g0nmEaILxGFn7ynK83OXYh55
 0+SA==
X-Received: by 2002:a05:600c:45d2:b0:493:ee34:d875 with SMTP id
 5b1f17b1804b1-4954a339294mr25879815e9.10.1784290957168; 
 Fri, 17 Jul 2026 05:22:37 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:819a:eb1f:262d:7641])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954a2f210csm48055935e9.15.2026.07.17.05.22.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 05:22:36 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 1/2] vfio/pci: don't narrow a failed config read to a
 plausible value
Date: Fri, 17 Jul 2026 14:22:29 +0200
Message-ID: <20260717122232.468955-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715191735.2454719-1-den@openvz.org>
References: <20260715191735.2454719-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=den@openvz.org; helo=mail-wr1-x434.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

vfio_pci_read_config() signals a failed host-side read by returning
(uint32_t)-1, regardless of the requested length. vfio_intx_enable()
and vfio_pci_pre_reset() both narrowed that return value straight
into a uint8_t/uint16_t local before checking anything, which
truncates -1 into 0xff or 0xffff - values a real 1- or 2-byte
register read can legitimately produce. From that point on, a
failed read and real all-ones content are indistinguishable.

Keep the full uint32_t result and check it against (uint32_t)-1
before narrowing. In vfio_pci_pre_reset(), skip the corresponding
write-back on a failed read instead of writing back constructed
garbage to the device.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Alex Williamson <alex@shazbot.org>
CC: "Cédric Le Goater" <clg@redhat.com>
---

 hw/vfio/pci.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index c204706e63..8b8e8b6379 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -323,10 +323,16 @@ static void vfio_irqchip_change(Notifier *notify, void *data)
 static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
 {
     PCIDevice *pdev = PCI_DEVICE(vdev);
-    uint8_t pin = vfio_pci_read_config(pdev, PCI_INTERRUPT_PIN, 1);
+    uint32_t val = vfio_pci_read_config(pdev, PCI_INTERRUPT_PIN, 1);
+    uint8_t pin;
     Error *err = NULL;
     int32_t fd;
 
+    if (val == (uint32_t)-1) {
+        error_setg(errp, "failed to read PCI_INTERRUPT_PIN");
+        return false;
+    }
+    pin = val;
 
     if (!pin) {
         return true;
@@ -2764,6 +2770,7 @@ bool vfio_pci_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
 void vfio_pci_pre_reset(VFIOPCIDevice *vdev)
 {
     PCIDevice *pdev = PCI_DEVICE(vdev);
+    uint32_t val;
     uint16_t cmd;
 
     vfio_disable_interrupts(vdev);
@@ -2772,23 +2779,34 @@ void vfio_pci_pre_reset(VFIOPCIDevice *vdev)
      * Stop any ongoing DMA by disconnecting I/O, MMIO, and bus master.
      * Also put INTx Disable in known state.
      */
-    cmd = vfio_pci_read_config(pdev, PCI_COMMAND, 2);
-    cmd &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER |
-             PCI_COMMAND_INTX_DISABLE);
-    vfio_pci_write_config(pdev, PCI_COMMAND, cmd, 2);
+    val = vfio_pci_read_config(pdev, PCI_COMMAND, 2);
+    if (val != (uint32_t)-1) {
+        cmd = val;
+        cmd &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER |
+                 PCI_COMMAND_INTX_DISABLE);
+        vfio_pci_write_config(pdev, PCI_COMMAND, cmd, 2);
+    }
 
     /* Make sure the device is in D0 */
     if (pdev->pm_cap) {
         uint16_t pmcsr;
         uint8_t state;
 
-        pmcsr = vfio_pci_read_config(pdev, pdev->pm_cap + PCI_PM_CTRL, 2);
+        val = vfio_pci_read_config(pdev, pdev->pm_cap + PCI_PM_CTRL, 2);
+        if (val == (uint32_t)-1) {
+            return;
+        }
+        pmcsr = val;
         state = pmcsr & PCI_PM_CTRL_STATE_MASK;
         if (state) {
             pmcsr &= ~PCI_PM_CTRL_STATE_MASK;
             vfio_pci_write_config(pdev, pdev->pm_cap + PCI_PM_CTRL, pmcsr, 2);
             /* vfio handles the necessary delay here */
-            pmcsr = vfio_pci_read_config(pdev, pdev->pm_cap + PCI_PM_CTRL, 2);
+            val = vfio_pci_read_config(pdev, pdev->pm_cap + PCI_PM_CTRL, 2);
+            if (val == (uint32_t)-1) {
+                return;
+            }
+            pmcsr = val;
             state = pmcsr & PCI_PM_CTRL_STATE_MASK;
             if (state) {
                 error_report("vfio: Unable to power on device, stuck in D%d",
-- 
2.53.0


