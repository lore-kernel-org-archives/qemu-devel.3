Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2BBECD8CAB
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 13:47:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWaJH-0001gD-Lt; Mon, 08 Jun 2026 09:46:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wWaJB-0001fP-Ua
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 09:46:29 -0400
Received: from mail-dl1-x1243.google.com ([2607:f8b0:4864:20::1243])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wWaJA-0001nU-F8
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 09:46:29 -0400
Received: by mail-dl1-x1243.google.com with SMTP id
 a92af1059eb24-1382533d428so30756c88.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 06:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780926386; x=1781531186; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2AsBAt4ofYYD3HWvIECkW2Aa4aB4woL/62DS1Pf6WdI=;
 b=hzflAIy1qhtkQxI6iWwLvQCR5YbT46NWdtzQ2ufocqgCO95uxLRGgZkstFTHuswdx/
 EOWD/gdsSJX9Im5+9xsiHmHwebjLW1M7I77Sdh7ay91xCKsvnBe9KBOCulhZ1+hqA/xW
 FvhLbBoTFzEZeqx1HipISCenr9ok/3HUocFlhSJdrMh7KmLx4usdfLAJDPNXN+h1j/Zb
 A7ShSOzKSly+NzZqCGTqE2faiI8PvMTDgJVvXE9qucgRpAgSx++36w7at9gUK4cPwP30
 hqU83TUXjEQ3jq0wMBuF8R6QQc1QMtg/LKfrBVCj5UuKuQ1PNbWhGmRy9DGqCE4HD1iu
 Od+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780926386; x=1781531186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2AsBAt4ofYYD3HWvIECkW2Aa4aB4woL/62DS1Pf6WdI=;
 b=JIaNrji+adceGiiQgwS0Vza1yMMOatBSfGsukwJRG+MpcoBflYEHIRKzu2/HWEZPtF
 tjFuG4AwQUEclPOo0stDuDl8825tgDKyh/0el8/ZCCdZIZE3aHfGFVz+gXhsQVvDeO6I
 /bKdX838qjCDvk3wyQANuuSRIH54EGvfaRTQzrEqg89hg020WZkALqc6i+FIvDiGZUy9
 Mr0LYsJfmy7ympZLKKc9DEqNuKwsGT/QBzllSv42H1/kY8zgtTBm2GKCpwMqvcDxQ71W
 xt+2JyWeKpWJaF+tjCv4O2as568McD47bCgBCxIefzkp169RFtnkM4KmnD5sdQuN8kGA
 W80w==
X-Gm-Message-State: AOJu0YwS528ToRJza4v0DkOl+QpcMQE89fvLmrOhCWc6Af4vLS5ZHe9Y
 pHRmAzAdkKmB43CbaMRzhdx7Y5hHBIW6e2VzjILmW+1fv39LOVPtIYqQJA6d1jdq1A==
X-Gm-Gg: Acq92OFyUrnli7rukDdjul4RvyP3h7o6dSVd3rFdbMvsbM9sljnPbMcwbq6aE6w7uU4
 v6+GJoPh7NM8yTzb+7eGeAHCFW3XrZpmed8TY5VCCTiErqjQPd+8X1xEPjunOLioj3BEgOScdu7
 e2x4qAzLpKTWWNz74uFoEOVi4YY+4baMaV97PySgXPt/YDpJkS5Q4dWm1UDGE3tMM3y6g1B4IYV
 AjIq+8HdlAmeIgt6zSJVTWPoY8CsSDpsVgBNJBdc4G+qhHn3X8s3+mlJx5s+fJeRgNcpc8VxtOC
 Z39Fg+BpmV1KQfTscR/cqaDT7BXs/UKFYOkhUQbVRfM+8/TYko5p3ZU2R9O+EmZJfb51tpOYgyN
 YHXorvnB+edgv4W0xMXKTU8l4zbl3ul6Dl7ClQu1QRN/e4aFt+HSHjypwrKVwMRVWj4thwo4DI8
 tXA7w/v4HelCeJ1G69PXMArDbJuKhwbP/MiiacrmiLMQ==
X-Received: by 2002:a05:7022:ef18:b0:137:6781:7dd7 with SMTP id
 a92af1059eb24-1380670b7aamr7438089c88.20.1780926386409; 
 Mon, 08 Jun 2026 06:46:26 -0700 (PDT)
Received: from kotori-desktop ([2408:820c:8ffd:b5b0:12ba:d5b5:2236:f1f1])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f54c9c12sm12335970c88.6.2026.06.08.06.46.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 06:46:25 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, K S Maan <kirandeepmaan45@gmail.com>
Subject: [PATCH v2 4/7] hw/pci: Promote pci_patch_ids() to public
 pci_rom_patch_ids()
Date: Mon,  8 Jun 2026 21:45:55 +0800
Message-ID: <20260608134559.23971-5-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608134559.23971-1-tomitamoeko@gmail.com>
References: <20260608134559.23971-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1243;
 envelope-from=tomitamoeko@gmail.com; helo=mail-dl1-x1243.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Remove the static qualifier from pci_patch_ids() and rename it to
pci_rom_patch_ids(), adding a declaration in include/hw/pci/pci.h so
external callers can reuse it.

Reported-by: K S Maan <kirandeepmaan45@gmail.com>
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/pci/pci.c         | 4 ++--
 include/hw/pci/pci.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 0facc05aed..752cea0e77 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2495,7 +2495,7 @@ uint8_t pci_rom_calculate_checksum(const uint8_t *ptr, uint32_t size)
 
 /* Patch the PCI vendor and device ids in a PCI rom image if necessary.
    This is needed for an option rom which is used for more than one device. */
-static void pci_patch_ids(PCIDevice *pdev, uint8_t *ptr, uint32_t size)
+void pci_rom_patch_ids(PCIDevice *pdev, uint8_t *ptr, uint32_t size)
 {
     uint16_t vendor_id;
     uint16_t device_id;
@@ -2657,7 +2657,7 @@ static void pci_add_option_rom(PCIDevice *pdev, Error **errp)
 
         if (pdev->rom_need_patch_id) {
             /* Only the default rom images will be patched (if needed). */
-            pci_patch_ids(pdev, ptr, size);
+            pci_rom_patch_ids(pdev, ptr, size);
         }
     }
 
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 2d8a4ad0eb..298e0e6c31 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -1104,5 +1104,6 @@ void pci_set_power(PCIDevice *pci_dev, bool state);
 int pci_pm_init(PCIDevice *pci_dev, uint8_t offset, Error **errp);
 
 uint8_t pci_rom_calculate_checksum(const uint8_t *ptr, uint32_t size);
+void pci_rom_patch_ids(PCIDevice *pdev, uint8_t *ptr, uint32_t size);
 
 #endif
-- 
2.53.0


