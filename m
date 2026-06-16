Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5838CCD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:15:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZDT-0003Bi-QO; Tue, 16 Jun 2026 15:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ7u-0004Uw-Qv
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:24 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ7k-0000wA-EE
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:09 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-4600cbb06deso106466f8f.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636814; x=1782241614; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=weeNUWxYJjehY3MuWZ1bYEiCEGF4TezcF0oM8vo2/xw=;
 b=o8BosrEYKiM63g5TjeI/m4c81ENgqLyH7gDpRmnLa03TczldI6cFvGOiH7JT/mLtgV
 rvp5jFfJ1tUZb1L27xF7DtTvONOjTLK1mUHDl3N3I0ZNFvX++4JynNQZ1H1hW9YkWCVj
 5vLfN9mFiUJkGwZzOuO05MAgLvmn1UcSP0JSXXXU6wLlKTZpBG2BK7h/PPf4pq4bgyPe
 Dts46F9NTCFE/5FIT9cPqBwKzm75sJql69la+x/+Ado1FaulGRsIT4SJfI+XmVNTpDwO
 +w3UoY773HBk5MeX9gQRx/DH3V1TONOKYfP8D7AuP2Co4L/669SA5hGiLInFssEysDvX
 hV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636814; x=1782241614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=weeNUWxYJjehY3MuWZ1bYEiCEGF4TezcF0oM8vo2/xw=;
 b=kotS2rsCIHmoN1vPmepYTJsgBBa+IuKBsyQIF9s71HvILNr0kkD7MjorPUF3Ucd8jj
 /ufB+l/Qh2kovIQCKGFg9IiboGJABKJ4WcIk+rJV++dU6Mh8JBJwAchxVARx5JFTs/LI
 eqjEhK2Uh5su1GAJS11Ppl55dBrC34xZjWOxevhIfyuDRBc+TB8sf7DLyTDOqJ9aCnKt
 r2u4V01Aq4vHwCE+5RHlD+5Cjjgn33zMyP4J4lLA7ZiqpNNbHZij0YNAaEqJribUCiEa
 eURIoO8ZWgIHFTylnl6ylZUuV1jAEn68MHSqu4i7BZ9zsfBV9pJdKPjRuNrwdUQ4FvXS
 rdyA==
X-Gm-Message-State: AOJu0Yxx6mcqW3vULBsTwZgwNUiO0Q46w0Re+YfUO0eoiosab3inWux9
 f5HBaV+UX4pj0SFfW8x6Cj5xctewfr7EsTd/2Zm7oMZFsxFdw2hdnNb9pXS0W96YjzgbLE65X8M
 VavWf
X-Gm-Gg: Acq92OGNNXvM+ofVFrJ+ifL4rfi96GbPMSnF81Rq+tQ018+Sb3PMSJ4lWZXjp7DoBKl
 3WjrPqS8Y25/6uaUxU7WbZLPrT8QiXjiZyJEqvewcCrrJbQdGQH76x1xk1XqWYlELAaXy9+82HT
 bysDj42fLzET0Ac9l2MWp1kC9Lcy0oz29H0PwDrLSg5+JTEypNVHyHFP6+JPPnXCj1a61/05Su/
 Lpu9g672SyrMnR4KQiyi4CQ8DiWbLGcMQKy2niha+tCa+b0fIGnpzHdg8hvtyybUEzacR+4x1nO
 swS7A2WaBwneeOPt2Zu58GLmGg/yo+1JekBDq2Z33cOFQxeGiaPNCdjVc1jpyDVP1LyHof0QByG
 7LVJBS0TQUBShvaNxe3sR3rekYAyPq9KIHYSprfYTxIaFbDcrqlJIeuRotTKRhAR0VrCOmqHC4U
 Zj99ZRAnQwe7qh/Y2gf+FTVMmfJzt+v4h+if/Y9pKU6zKbHMpGdfpd3iw3iv9zmDvEcDZ5YisPt
 rMgA0jsR5Flyfz2Ulc6yFDLFImjtZ/H
X-Received: by 2002:a05:6000:220b:b0:44f:69f4:39b5 with SMTP id
 ffacd0b85a97d-4619f325353mr8732365f8f.29.1781636814159; 
 Tue, 16 Jun 2026 12:06:54 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.06.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:06:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/61] hw/pci/pci: Enforce pci_setup_iommu_per_bus() is called
 only once per bus
Date: Tue, 16 Jun 2026 20:05:47 +0100
Message-ID: <20260616190639.3462006-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

From: Eric Auger <eric.auger@redhat.com>

Currently it is possible to attach several arm-smmuv3 devices to the
same bus although it is a wrong setup.

Change the prototype of pci_setup_iommu_per_bus to pass an error
handle. This latter is set when iommu_per_bus is already set and
used by the single caller (smmu_base_realize) to report a useful
error to the end-user.

While at it document pci_setup_iommu_per_bus callback in the header.

Fixes: 66d2f665e163 ("hw/arm/virt: Allow user-creatable SMMUv3 dev instantiation")
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nathan Chen <nathanc@nvidia.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>
Message-id: 20260603124415.1120808-1-eric.auger@redhat.com
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmu-common.c |  4 +++-
 hw/pci/pci.c         |  9 +++++++--
 include/hw/pci/pci.h | 16 +++++++++++++++-
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 58c4452b1f..8e40ba603d 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -981,7 +981,9 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
         }
 
         if (s->smmu_per_bus) {
-            pci_setup_iommu_per_bus(pci_bus, s->iommu_ops, s);
+            if (!pci_setup_iommu_per_bus(pci_bus, s->iommu_ops, s, errp)) {
+                return;
+            }
         } else {
             pci_setup_iommu(pci_bus, s->iommu_ops, s);
         }
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index cec065d108..d3191609e2 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -3314,11 +3314,16 @@ void pci_setup_iommu(PCIBus *bus, const PCIIOMMUOps *ops, void *opaque)
  * IOMMU ops are returned, avoiding the use of the parent’s IOMMU when
  * it's not appropriate.
  */
-void pci_setup_iommu_per_bus(PCIBus *bus, const PCIIOMMUOps *ops,
-                             void *opaque)
+bool pci_setup_iommu_per_bus(PCIBus *bus, const PCIIOMMUOps *ops,
+                             void *opaque, Error **errp)
 {
+    if (bus->iommu_per_bus) {
+        error_setg(errp, "An iommu is already attached to this bus");
+        return false;
+    }
     pci_setup_iommu(bus, ops, opaque);
     bus->iommu_per_bus = true;
+    return true;
 }
 
 static void pci_dev_get_w64(PCIBus *b, PCIDevice *dev, void *opaque)
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 5b179091de..f2448e941a 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -863,7 +863,21 @@ int pci_iommu_unregister_iotlb_notifier(PCIDevice *dev, uint32_t pasid,
  */
 void pci_setup_iommu(PCIBus *bus, const PCIIOMMUOps *ops, void *opaque);
 
-void pci_setup_iommu_per_bus(PCIBus *bus, const PCIIOMMUOps *ops, void *opaque);
+/**
+ * pci_setup_iommu_per_bus: Initialize specific IOMMU handlers for a PCIBus
+ *
+ * Similar to pci_setup_iommu but enforces that the iommu only protects
+ * @bus downstream end points and no other bus hierarchy
+ *
+ * @bus: the #PCIBus being updated.
+ * @ops: the #PCIIOMMUOps
+ * @opaque: passed to callbacks of the @ops structure.
+ * @errp: error handle
+ *
+ * Returns false on failure with @errp set, true on success
+ */
+bool pci_setup_iommu_per_bus(PCIBus *bus, const PCIIOMMUOps *ops,
+                             void *opaque, Error **errp);
 
 pcibus_t pci_bar_address(PCIDevice *d,
                          int reg, uint8_t type, pcibus_t size);
-- 
2.43.0


