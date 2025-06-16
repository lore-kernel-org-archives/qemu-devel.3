Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2275C71159
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 14:08:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRAUY-0001Dq-Pn; Mon, 16 Jun 2025 10:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uRATw-00015D-L7
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 10:06:41 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uRATs-0003yp-A9
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 10:06:40 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-450cb2ddd46so25427055e9.2
 for <qemu-devel@nongnu.org>; Mon, 16 Jun 2025 07:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750082794; x=1750687594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=L67vA0aSsh45bJksX1C5CfPxf17pRwQQix91wLS7SE4=;
 b=jq2LosOgQgZ33brD1TpJW/g043PR3InznTWReX4YxzisjocGbaaoCiwNMBgtGFcEsY
 hHaQnGEO4GxTsyXzZOxla5YBG0GwiuX0RSKFQhKaxNu85GnhTJvZnx5XCBWHP8nAj8Ug
 qt2dWDw7fYFiMlSkZzVCrcmg4LfwzyfLWKe1T/1QlwanHppSPK/4XPb5bsEKLwEN1tVF
 LTOOwQ9vF67jbKfqkpdjWF/qTCzdWTSoFG4pzQQjbZ2Z+vTBMm/DAy3I/3IQ/xpIbYBH
 JKegYdGV5+Gxu7Fi3gBZXmxfr5t+m571HzNrV2vP6eQ7dORf+WNUk/k6v0fUNp/8kNsc
 ekmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750082794; x=1750687594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L67vA0aSsh45bJksX1C5CfPxf17pRwQQix91wLS7SE4=;
 b=IMCCklH38+dIoWajhEOLnfXoqa7G7Jf5KCGEwLNPLVHQI8TSCl5mn8wp0hyy9DGEwd
 A40rEEjM7yhH+Z2Ex1VUUOr9I9YhLr3J+sV2lWAbOBHB9yMdi+HLYMN88EaHMxayN7qx
 6DkLEUNcirnUqBAzRYFqmaPqwhixwZBo/2K1U8X5NeMxnMknfzNaiHSN+UKLoMgrJc8X
 O4sYeK/zuaq2ou0lOslWbBQYlromyF642Xe6FPKpf4AJW0hJ5j2Sruq+ZyX+XMx6NLPl
 xSSyZTx3orQgdp1vyCkgN3q7OWIZKqJcKSynih8BucLug1YdNG7cBLSfByfnsMKuJvfF
 ZeCA==
X-Gm-Message-State: AOJu0Yx0nTqlfoJYBa2yF5YIE4AZMC1AJxUxefrGCC+TNQY8b4xqVgY/
 vQm2NUalLloY9UMqyvo2bqNWQ9JUbujNbpe/k1i9uoyyxsPwwEGL6i3uPf4S9oUdQ4LHIXMizQg
 f1KUV
X-Gm-Gg: ASbGnctAAHxBTHk+ZNnWwh9frwrG/Sd+0rq6R0Xh7+lHXL+SQDwgeqGLOMNNxkDJAQG
 NW3AzfMbaOs9ieIoBoht6TmdWe+q5RDPlNp1P5Dh5NDOH56AuzFKfNk7WYr0UQqF5yvb0lnrIXf
 uyyZ7NTb7h48pBa6hCIduMLO7/PnTTgMpds58kMKeN1ZR4VA3DkW0nym7l5GtqyrSV9JMMx8VQZ
 PdEl0M+OHxYIKI4Ha7hXYTf0v9MnW99GxpWQYyUzwXXUFAtrYag9k1AnsM5owqv/7K5So0MsBq2
 ajikbF0TENTUfESg6/SkMBINlt8E3o/zynUGXj5ZS5zdGT8o80DJl+8M6vKqoA7Db+5f
X-Google-Smtp-Source: AGHT+IHxCWgaBTRw2GeBSmjAqYVyl5rb36FJuSMae1Djyy0cZsVMLQ70IgWxwMWNUxcJP24aCmXGNQ==
X-Received: by 2002:a05:600c:4e14:b0:44a:ac77:26d5 with SMTP id
 5b1f17b1804b1-4533ca572f5mr94117475e9.14.1750082793726; 
 Mon, 16 Jun 2025 07:06:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e13c192sm146561975e9.26.2025.06.16.07.06.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 07:06:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/9] hw/arm/virt: Check bypass iommu is not set for iommu-map
 DT property
Date: Mon, 16 Jun 2025 15:06:22 +0100
Message-ID: <20250616140630.2273870-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250616140630.2273870-1-peter.maydell@linaro.org>
References: <20250616140630.2273870-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

default_bus_bypass_iommu tells us whether the bypass_iommu is set
for the default PCIe root bus. Make sure we check that before adding
the "iommu-map" DT property.

Cc: qemu-stable@nongnu.org
Fixes: 6d7a85483a06 ("hw/arm/virt: Add default_bus_bypass_iommu machine option")
Suggested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Donald Dutile <ddutile@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20250602114655.42920-1-shameerali.kolothum.thodi@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9a6cd085a37..99fde5836c9 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1487,9 +1487,12 @@ static void create_virtio_iommu_dt_bindings(VirtMachineState *vms)
     qemu_fdt_setprop_cell(ms->fdt, node, "phandle", vms->iommu_phandle);
     g_free(node);
 
-    qemu_fdt_setprop_cells(ms->fdt, vms->pciehb_nodename, "iommu-map",
-                           0x0, vms->iommu_phandle, 0x0, bdf,
-                           bdf + 1, vms->iommu_phandle, bdf + 1, 0xffff - bdf);
+    if (!vms->default_bus_bypass_iommu) {
+        qemu_fdt_setprop_cells(ms->fdt, vms->pciehb_nodename, "iommu-map",
+                               0x0, vms->iommu_phandle, 0x0, bdf,
+                               bdf + 1, vms->iommu_phandle, bdf + 1,
+                               0xffff - bdf);
+    }
 }
 
 static void create_pcie(VirtMachineState *vms)
@@ -1612,8 +1615,10 @@ static void create_pcie(VirtMachineState *vms)
         switch (vms->iommu) {
         case VIRT_IOMMU_SMMUV3:
             create_smmu(vms, vms->bus);
-            qemu_fdt_setprop_cells(ms->fdt, nodename, "iommu-map",
-                                   0x0, vms->iommu_phandle, 0x0, 0x10000);
+            if (!vms->default_bus_bypass_iommu) {
+                qemu_fdt_setprop_cells(ms->fdt, nodename, "iommu-map",
+                                       0x0, vms->iommu_phandle, 0x0, 0x10000);
+            }
             break;
         default:
             g_assert_not_reached();
-- 
2.43.0


