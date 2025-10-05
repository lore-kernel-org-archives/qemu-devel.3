Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4388ECAC5B8
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:22:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UEt-0000O8-TR; Sun, 05 Oct 2025 15:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UEh-0008TX-6t
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:17:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UEc-0006Vi-Fl
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:17:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MyvBGvCg5pKlLTnNdcKGwoTb8nQEpmQV3fi/odf1v+M=;
 b=gYVBDav8EWPWF88A7R81gY+s4BLc1brIzWOBmpDkLbw0yAAGuTyjZoQpNPNzlGD7UQUOxX
 lh4aaRSdwLVJuesidMRVSuOVIz7cN0vVdVRiJ6IDF5xnUOyi6+JTg3587Ambq9kxnusER4
 yby8TH+l4yPFBHEgW1/zzLgDa/vT12M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-QpO14XHxPoyqJZ_OTpQr5A-1; Sun, 05 Oct 2025 15:17:28 -0400
X-MC-Unique: QpO14XHxPoyqJZ_OTpQr5A-1
X-Mimecast-MFC-AGG-ID: QpO14XHxPoyqJZ_OTpQr5A_1759691847
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3f42b54d159so3228678f8f.2
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:17:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691847; x=1760296647;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MyvBGvCg5pKlLTnNdcKGwoTb8nQEpmQV3fi/odf1v+M=;
 b=bCdmTdml5G6q0TGovz3PA/+MQx5a099WJrPIqpOCqBanPBpUDCRJJZBjoBHQmaoOeB
 Urr9+qHd+71O6WKns5CqenuxpUtLBAB8itfatFsZlNh+xu5umuNuOzpiKgawp7sVMigR
 bKs2jXHDQlg0kVyZI4ip8LgtFsGNsITuaYleI3MQ2skJJhjDxhhrGAgHBqiGOnx2oLgH
 IN4VXHO/bL/j5pL/9zbq7oxPQE/iOnULsLhzW2iB6u80O2Kyw2ho3yLFsQveLXibxIJk
 kmJhtHSChVrn3fvMmijHDPu27Mpc+PtpMPfGR85WcLptnRNADq+f5ZQznc2tsLHZv5II
 x2OA==
X-Gm-Message-State: AOJu0YwK2I+gBgVhu46vv+GO0R3swAqzEKyCcuWBQ/WdXSL5q/XKQIZ3
 m+tYUphRunbw0EcsQhY59VmxfHUoqmMFCF02foETpRxtuKOQw+KXiMTd0IImF8kbsXKMW0zCqF1
 rxNi8I4aBPdYsbAAjihMFFkUr5Lgt4wyeZktQeB5R24lebM9DaSEmn53yoisASJnpU5xuLBqXe+
 vG1nozym+w7YB/cBv7Oc5WKJichezn0yCuFg==
X-Gm-Gg: ASbGncugk6mk6gnZWRvlidjjNWl3Juw9sT2kY92e5In6Alm7MyYiDMdKsyAru+NQBb3
 ABVTuE5BkCPaS9VqpIN5HXj+hheanmNrkxFri0h6YKjJzDjH+ySHdfyXGg4kGOvSDmNCimWrBmd
 qs4e4/epjO5ibJLCmEoyFQg3oT4dfed1XMiUnbJ4NV3VNkpJeMqBXWgzs+7xLNTV44QNQNozAYs
 Zbjo0tY0nPjHJs732NPXok8ZnOPlIfXVrA+lZerQiRLmbNmN1OOBbEkd+ydJb0EnllY1nsCPAEd
 qFA63RPYw6luamb480TwEPisaV4RnEc4ntS7AyA=
X-Received: by 2002:a05:6000:2dc3:b0:3f7:b7ac:f3d2 with SMTP id
 ffacd0b85a97d-425671ab145mr6411636f8f.43.1759691846940; 
 Sun, 05 Oct 2025 12:17:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAKyTMToGPV/1BWGvkojDp3/sLUXg8J7hMSRVG4xXSiZ/2ZkWU0rdhU2Aey3ssz3wIgWRVNg==
X-Received: by 2002:a05:6000:2dc3:b0:3f7:b7ac:f3d2 with SMTP id
 ffacd0b85a97d-425671ab145mr6411620f8f.43.1759691846410; 
 Sun, 05 Oct 2025 12:17:26 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e619b86e1sm216921485e9.5.2025.10.05.12.17.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:17:25 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:17:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 37/75] pcie: Add a way to get the outstanding page request
 allocation (pri) from the config space.
Message-ID: <ec450d185e4c885396a8e9b9bd2a435c9e0c118f.1759691708.git.mst@redhat.com>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759691708.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250901111630.1018573-2-clement.mathieu--drif@eviden.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pcie.h | 1 +
 hw/pci/pcie.c         | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index ff6ce08e13..42cebcd033 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -158,6 +158,7 @@ void pcie_pasid_init(PCIDevice *dev, uint16_t offset, uint8_t pasid_width,
 void pcie_pri_init(PCIDevice *dev, uint16_t offset, uint32_t outstanding_pr_cap,
                    bool prg_response_pasid_req);
 
+uint32_t pcie_pri_get_req_alloc(const PCIDevice *dev);
 bool pcie_pri_enabled(const PCIDevice *dev);
 bool pcie_pasid_enabled(const PCIDevice *dev);
 bool pcie_ats_enabled(const PCIDevice *dev);
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index eaeb68894e..b302de6419 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -1266,6 +1266,14 @@ void pcie_pri_init(PCIDevice *dev, uint16_t offset, uint32_t outstanding_pr_cap,
     dev->exp.pri_cap = offset;
 }
 
+uint32_t pcie_pri_get_req_alloc(const PCIDevice *dev)
+{
+    if (!pcie_pri_enabled(dev)) {
+        return 0;
+    }
+    return pci_get_long(dev->config + dev->exp.pri_cap + PCI_PRI_ALLOC_REQ);
+}
+
 bool pcie_pri_enabled(const PCIDevice *dev)
 {
     if (!pci_is_express(dev) || !dev->exp.pri_cap) {
-- 
MST


