Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFAB6CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 05:15:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcFsy-0006I2-Rp; Wed, 24 Jun 2026 01:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcFsj-0005Uo-Ln; Wed, 24 Jun 2026 01:10:42 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcFsh-0006FB-AG; Wed, 24 Jun 2026 01:10:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782277633; bh=EZxTBcW+Nv+J+qL6TFpeLuirw8GBD5VwhTyxmqUOqmc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=bwyKWsepu6vUhGn+wqlaiRAjkyeOKx1tXvLAOUJEUL50mBFUzEHm57Ful3LtmYr2V
 RHuljhBKBy6bIS43AyjyIOFAGqPzaTcbfbztjfEe8/IlDdvSojhYMeYMFZmDGaG9zM
 UPLfbZVYqA0yLfnZHcSvFQVx0DkrMkMSBWFmWAHtJaLbnjbcks3VRJy44BQmli4Llr
 ul4J8CWH8RVzm2C4YPI3e5vFgXCA2lw3Np47OZIL1i9EkzB93NKg5nMTJCZpqXKNI8
 NEsaYd+DyPRe3NLs9Z559fdn6PPBPicxRWpqqAbcr5Tqu6VWqRot7MoiUEHTQmcU6V
 0LvE1E2Zvq9dg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5ED3A1BA67C;
 Wed, 24 Jun 2026 08:07:13 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 479C93DDB19;
 Wed, 24 Jun 2026 08:07:18 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Aditya Gupta <adityag@linux.ibm.com>,
 Zexiang Zhang <chan9yan9@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.4 94/95] hw/pci: Replace assert with bounds check and
 return
Date: Wed, 24 Jun 2026 08:05:29 +0300
Message-ID: <20260624050541.395079-33-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.4-20260624080454@cover.tls.msk.ru>
References: <qemu-stable-10.2.4-20260624080454@cover.tls.msk.ru>
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Aditya Gupta <adityag@linux.ibm.com>

As reported in https://gitlab.com/qemu-project/qemu/-/work_items/3334,
callers of 'pci_host_config_{read,write}_common' can pass length as 8,
causing an assert failure

The original issue with pnv_phb3 triggering the assert was fixed in a
previous commit

Instead of asserting on invalid length, check if the length is valid
(<=4), otherwise return (with the failure error code in read)

Reported-by: Zexiang Zhang <chan9yan9@gmail.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260326190438.734239-3-adityag@linux.ibm.com>
(cherry picked from commit c7209c56718107fefd5deae140a450954d31ff2b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
index 7179d99178..9a0f80da53 100644
--- a/hw/pci/pci_host.c
+++ b/hw/pci/pci_host.c
@@ -81,7 +81,12 @@ void pci_host_config_write_common(PCIDevice *pci_dev, uint32_t addr,
         return;
     }
 
-    assert(len <= 4);
+    if (len > 4) {
+        PCI_DPRINTF("%s: invalid length access: addr " HWADDR_FMT_plx " \
+            len %d val %"PRIx32"\n", __func__, addr, len, val);
+        return;
+    }
+
     /* non-zero functions are only exposed when function 0 is present,
      * allowing direct removal of unexposed functions.
      */
@@ -106,7 +111,12 @@ uint32_t pci_host_config_read_common(PCIDevice *pci_dev, uint32_t addr,
         return ~0x0;
     }
 
-    assert(len <= 4);
+    if (len > 4) {
+        PCI_DPRINTF("%s: invalid length access: addr " HWADDR_FMT_plx " \
+            len %d val %"PRIx32"\n", __func__, addr, len, val);
+        return ~0x0;
+    }
+
     /* non-zero functions are only exposed when function 0 is present,
      * allowing direct removal of unexposed functions.
      */
-- 
2.47.3


