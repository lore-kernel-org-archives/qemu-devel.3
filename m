Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C91CFC52D70
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 06:51:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZm7a-0001Q3-7l; Fri, 02 Aug 2024 02:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZm7Y-0001Ha-5J
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 02:50:36 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZm7W-0000wb-Lf
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 02:50:35 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-6e7e23b42c3so4998127a12.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 23:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722581433; x=1723186233;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZZGRu8v6oxuF32W/xrA/69BjX55/YFUQg7PXZsmlE7o=;
 b=bwQhuOwtdn8cs7TWkvhG7XUHPvhXg5Fop+3Imn0OTePQBH8Vn74GjoIC8HgSCN9Ee1
 oWMb+GjiWmUKqhwxwVbIfbbIx08l4jqA46em7scmE/7o6ELYVYASuTRCPaOIj5wgD8UZ
 qs7Y3sZq2in73kjTuJV5EzGcAW4SNobmjhewfq+VhzBQqDqXiq3DwBzZyU9ufO14CXwb
 z/TdVFTQdo3wIrAtP+L6RSucybC4pnJ+mM6W4DCpSpBF72HcbrWFJ0CGq9LuypIA4yvo
 +ppOzFjv7UALEedynQ9eecLun3M6CE7r6KYCyif18JjkADlq/EID1WS+QyacK8fRDPHw
 ejaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722581433; x=1723186233;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZZGRu8v6oxuF32W/xrA/69BjX55/YFUQg7PXZsmlE7o=;
 b=PWxSls3jOms5GhqIHONgGQNtaR3m+oYza4jT5q4SLAAf2Nd7h0HiBmCi1s6x7VOPkB
 duh/tCEuBC46VjRo0KFRHjzwotEVswzOpqnEyM9sfmbvoL1s7kaMqk5DmlK+tcdA1a57
 olW9ILj/4mo7mH1MoShhKYahGuDiXG4TqQYcJOMpY3s5va1SbKhs+deefJjV5dnHR9vC
 dyA+6FIblA4mQMAtrU0+1ca24zGi7pLSEonXpFQ1imcktfSgPvItIN+2T7vouF/a3/Ic
 bvRnrd+Dlnul+A0u8eZWzJ1citBkDycYifWN6MfCsa0Z0YobFvZb7mM6yqurlNL02BZf
 CuNg==
X-Gm-Message-State: AOJu0YySFbSQ9PMwkCTGlyiTO4J7MX8rqTPLNnvt0rK+dTWNSaFcYrA3
 ZBpSrSwKGyfY7Vvsm82eHukETOIoprD81jPSqcX+KejVrVR5CJMEp5BhQKVmTZU=
X-Google-Smtp-Source: AGHT+IGwVSyhB8pGmmvcsq34mHa6UqBFBHAfw36HYcu5TpzyDqYgSyynLNp5G3/5WfJuDonlIjlRUQ==
X-Received: by 2002:a05:6a21:b85:b0:1c4:a30a:c819 with SMTP id
 adf61e73a8af0-1c699559e30mr2937915637.21.1722581433243; 
 Thu, 01 Aug 2024 23:50:33 -0700 (PDT)
Received: from localhost ([157.82.201.15]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1ff58f5a473sm9934605ad.106.2024.08.01.23.50.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 23:50:32 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 02 Aug 2024 15:49:47 +0900
Subject: [PATCH for-9.2 v6 3/9] pcie_sriov: Ensure PF and VF are mutually
 exclusive
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-sriov-v6-3-0c8ff49c4276@daynix.com>
References: <20240802-sriov-v6-0-0c8ff49c4276@daynix.com>
In-Reply-To: <20240802-sriov-v6-0-0c8ff49c4276@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::535;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

A device cannot be a SR-IOV PF and a VF at the same time.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pcie_sriov.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 56523ab4e833..ec8fc0757b92 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -42,6 +42,11 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
     uint8_t *cfg = dev->config + offset;
     uint8_t *wmask;
 
+    if (pci_is_vf(dev)) {
+        error_setg(errp, "a device cannot be a SR-IOV PF and a VF at the same time");
+        return false;
+    }
+
     if (total_vfs) {
         uint16_t ari_cap = pcie_find_capability(dev, PCI_EXT_CAP_ID_ARI);
         uint16_t first_vf_devfn = dev->devfn + vf_offset;

-- 
2.45.2


