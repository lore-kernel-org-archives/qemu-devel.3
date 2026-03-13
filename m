Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3913107BCCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 17:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w15v7-0005iH-NW; Fri, 13 Mar 2026 13:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.69b43f98.v1-79041865b121492dbb1dcf5cc39c7459@bounce.vates.tech>)
 id 1w15ur-0005hJ-Nj
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 13:03:20 -0400
Received: from mail136-12.atl41.mandrillapp.com ([198.2.136.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.69b43f98.v1-79041865b121492dbb1dcf5cc39c7459@bounce.vates.tech>)
 id 1w15uo-0000gh-Tj
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 13:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
 s=mte1; t=1773420440; x=1773690440;
 bh=BfeVwu07GpLrZnkbH1KHTfsb175OP+VcYPCDwc2bXBA=;
 h=From:Subject:To:Cc:Message-Id:In-Reply-To:References:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=VAcI6tTSK5w/V8dPnfOqMa21UdpOI2JaiSrxCu7eQ3wFafekWG+SxYK52H/Zf8rg7
 CnBLKL1u4vBT73Y9Zjo8O7IOLmwhPQfyBAGPNesgcdAQ0GvnB7AUAHU/rEWx6VwHEz
 o6kQBZWIlxdHh984pS7XBkknLRGEqLxfaXaCWFHIS/7tCMS506geVhNUTSBJXYSy3X
 LzbMDHMmczBaHo12e2PU2W9ZsvLq4MuMjjhVvbSajt6I1kcKAc1MiFyT9M5rlWzMav
 qxy7PWELKEeBlkegmYNDuh+AL9Ri+xpETxFrrO5uDQPux5oeXIGaKhjelyCP+zcm4M
 aSSPm9ElW77cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
 t=1773420440; x=1773680940; i=thierry.escande@vates.tech;
 bh=BfeVwu07GpLrZnkbH1KHTfsb175OP+VcYPCDwc2bXBA=;
 h=From:Subject:To:Cc:Message-Id:In-Reply-To:References:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=0C1+M/hNJ/PXKbzmhP1sAXXgIql9jwyvWMNpfI2vxpF9AD/AA962uysI/jC+VQebX
 FqcPSQxXBxiolMmCKxkr3ND4x06E/zhBZvHsi5VqNokF/7pEKffJpHw4XaPIYAaDWE
 JRnDIyKTJABlUXIHGt693E8Wa0eJl4vI4vkje7nKCq0W/ktlyLg26NwDT97WkYGFFW
 /7RtJa+oW30dsQVLERRKtuj+dKeFSGjer2aCwiMliuwvyj6st6++9el9x8C/sKGwOU
 3JMRjBvvmZxghq174rWYGjRvEI7fQeab9FgTU4z4aneVMcHuJ16Tb/0OvAtiRvJyVi
 NuHtUhAUnzJFA==
Received: from pmta11.mandrill.prod.atl01.rsglab.com (localhost [127.0.0.1])
 by mail136-12.atl41.mandrillapp.com (Mailchimp) with ESMTP id
 4fXVlD3bsCz5QtNbF
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 16:47:20 +0000 (GMT)
From: "Thierry Escande" <thierry.escande@vates.tech>
Subject: =?utf-8?Q?[PATCH=204/4]=20xen:=20Handle=20PCIe=20config=20space=20size=20in=20cpu=5Fioreq=5Fconfig()?=
Received: from [37.26.189.201] by mandrillapp.com id
 79041865b121492dbb1dcf5cc39c7459; Fri, 13 Mar 2026 16:47:20 +0000
X-Mailer: git-send-email 2.51.0
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1773420439492
To: qemu-devel@nongnu.org
Cc: "Thierry Escande" <thierry.escande@vates.tech>,
 "Paolo Bonzini" <pbonzini@redhat.com>,
 "Richard Henderson" <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, "Eduardo Habkost" <eduardo@habkost.net>,
 "Anthony PERARD" <anthony@xenproject.org>, xen-devel@lists.xenproject.org
Message-Id: <20260313164649.794591-5-thierry.escande@vates.tech>
In-Reply-To: <20260313164649.794591-1-thierry.escande@vates.tech>
References: <20260313164649.794591-1-thierry.escande@vates.tech>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,
 =20including=20all=20headers,
 =20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.79041865b121492dbb1dcf5cc39c7459?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20260313:md
Date: Fri, 13 Mar 2026 16:47:20 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.2.136.12;
 envelope-from=bounce-md_30504962.69b43f98.v1-79041865b121492dbb1dcf5cc39c7459@bounce.vates.tech;
 helo=mail136-12.atl41.mandrillapp.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This change allows to read and write to the extended config space of PCI
Express devices by setting the size limit to 4096 bytes. The size limit
remains 256 bytes for non PCIe devices.

Signed-off-by: Thierry Escande <thierry.escande@vates.tech>
---
 hw/xen/xen-hvm-common.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index 62d88804c4..15090d77cf 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -396,6 +396,7 @@ static void cpu_ioreq_config(XenIOState *state, ioreq_t *req)
 {
     uint32_t sbdf = req->addr >> 32;
     uint32_t reg = req->addr;
+    uint32_t limit;
     XenPciDevice *xendev;
 
     if (req->size != sizeof(uint8_t) && req->size != sizeof(uint16_t) &&
@@ -412,10 +413,12 @@ static void cpu_ioreq_config(XenIOState *state, ioreq_t *req)
             continue;
         }
 
+        limit = pci_is_express(xendev->pci_dev) ?
+                    PCIE_CONFIG_SPACE_SIZE : PCI_CONFIG_SPACE_SIZE;
         if (!req->data_is_ptr) {
             if (req->dir == IOREQ_READ) {
                 req->data = pci_host_config_read_common(
-                    xendev->pci_dev, reg, PCI_CONFIG_SPACE_SIZE,
+                    xendev->pci_dev, reg, limit,
                     req->size);
                 trace_cpu_ioreq_config_read(req, xendev->sbdf, reg,
                                             req->size, req->data);
@@ -423,7 +426,7 @@ static void cpu_ioreq_config(XenIOState *state, ioreq_t *req)
                 trace_cpu_ioreq_config_write(req, xendev->sbdf, reg,
                                              req->size, req->data);
                 pci_host_config_write_common(
-                    xendev->pci_dev, reg, PCI_CONFIG_SPACE_SIZE,
+                    xendev->pci_dev, reg, limit,
                     req->data, req->size);
             }
         } else {
@@ -431,7 +434,7 @@ static void cpu_ioreq_config(XenIOState *state, ioreq_t *req)
 
             if (req->dir == IOREQ_READ) {
                 tmp = pci_host_config_read_common(
-                    xendev->pci_dev, reg, PCI_CONFIG_SPACE_SIZE,
+                    xendev->pci_dev, reg, limit,
                     req->size);
                 trace_cpu_ioreq_config_read(req, xendev->sbdf, reg,
                                             req->size, tmp);
@@ -441,7 +444,7 @@ static void cpu_ioreq_config(XenIOState *state, ioreq_t *req)
                 trace_cpu_ioreq_config_write(req, xendev->sbdf, reg,
                                              req->size, tmp);
                 pci_host_config_write_common(
-                    xendev->pci_dev, reg, PCI_CONFIG_SPACE_SIZE,
+                    xendev->pci_dev, reg, limit,
                     tmp, req->size);
             }
         }
-- 
2.51.0



--
Thierry Escande | Vates XCP-ng Developer

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech


