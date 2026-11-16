Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4D5606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=STo0aOja
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3Cb-0008OL-Md; Mon, 16 Nov 2026 15:21:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3C9-00081u-CX; Mon, 16 Nov 2026 15:20:54 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3C6-0001u3-EA; Mon, 16 Nov 2026 15:20:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860369; bh=3tU91j33CUvttXveOQdy0qKMez1lulvpiSI1S5FOKOg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=STo0aOja+v/qE8zkVI57rXX+cN/egSarZuLhdCQmXXeUIZ+2xEHee/AFkvI8oYdxH
 BtTtiISxBPTltR+2NIe3CQlWJllSQ99G5ExlO8qGQkZ43UA7HcNtzIQGczxK/S/q8u
 K4ua/heYrUMFCrKhwW4OkFcrl49XrpXonP1k0+U5ax/CdQjz+jND64kre0TIm7iSLl
 Be4QC603Uym/bLfIl7dV8SNY5H2bSItFepIeO9FL+Nrte3QzybWYUaD2PGasxgUhM5
 h12QDLlnDfXkLbC3sPYC6aDvhQ9JktK9I1Qv5cY+4k+VWi7bvNKNKISaB2OqQZarMF
 KAaxigHZq4p0Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C3F7F1E7149;
 Mon, 16 Nov 2026 23:19:29 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C14AA45FB7F;
 Mon, 16 Nov 2026 23:19:29 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 755C8B8DF4; Mon, 16 Nov 2026 23:19:29 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Farhan Ali <alifm@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 19/59] s390x/pci: Free FMB timer on zPCI device unplug
Date: Mon, 16 Nov 2026 23:18:23 +0300
Message-ID: <20261116201922.534306-19-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Farhan Ali <alifm@linux.ibm.com>

On an SCLP deconfigure we don't clean up the FMB timer. If there is a
pending unplug request then we can destroy the S390PCIBusDevice object
without correctly cleaning up the timer. So fmb_update() will then run on
freed memory. Clean up the FMB timer before we destroy the S390PCIBusDevice
object to prevent this use after free.

When FMB was introduced with commit 6e92c70c37 ("s390x/pci: add common
function measurement block") we originally cleaned up the FMB timer in
s390_pcihost_unplug(). This behavior was changed in the re-work done with
commit e0998fe89104 ("s390x/pci: Introduce unplug requests and split unplug
handler").

Fixes: e0998fe89104 ("s390x/pci: Introduce unplug requests and split unplug handler")
Cc: qemu-stable@nongnu.org
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20261028224611.240515-1-alifm@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
(cherry picked from commit e91d320a5bbce93b95d3b9ce3acff18977d05981)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index f684f3f7e01..4cc81ab1a71 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1241,6 +1241,7 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_S390_PCI_DEVICE)) {
         pbdev = S390_PCI_DEVICE(dev);
         pbdev->fid = 0;
+        fmb_timer_free(pbdev);
         QTAILQ_REMOVE(&s->zpci_devs, pbdev, link);
         g_hash_table_remove(s->zpci_table, &pbdev->idx);
         if (pbdev->iommu->dma_limit) {
-- 
2.47.3


