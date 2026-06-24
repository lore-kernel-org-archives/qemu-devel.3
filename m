Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96312CDE003
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:51:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcNtP-0006J4-A9; Wed, 24 Jun 2026 09:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNtN-0006BU-1p; Wed, 24 Jun 2026 09:43:49 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNtL-00025k-CN; Wed, 24 Jun 2026 09:43:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782308007; bh=13Qb9Nx8cR17potvT3cEjjnap4gymQSQ/97ixQ0MK/M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=CxFDJDANKgUZ159bR7sjWGeixXrVB+vE3Xr5/ajKw9mRGDDBPHpkyYYD79CYEAHrE
 IRSbJnO+sRATA7SWk2NSTh21okqB1N46peJFc5K/0GwrJGuzkHpz8FTpNgNkL/+IRR
 oq2VnTE3ec0PucfciqeYQeZBWdgzbg8ECG79cLUE+mG3B6rxql456zaayZe6wzZA74
 fE+BJ8npmiiM2dV9Ulm0C32IgC4mPlfs4bh5jx/Fpo37q9i2CRmsXQT0+4x+q3Kr+V
 D2tqK9pHo6EwWBTv54Tn0h52L3slgE5+3oaiKzd6+mDk17nyG2slRLLRqgYQFiC5b+
 qD/pdWbLhOW5A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B679D1BAA1C;
 Wed, 24 Jun 2026 16:33:27 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1D0823DEA6B;
 Wed, 24 Jun 2026 16:33:33 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Aditya Gupta <adityag@linux.ibm.com>,
 Zexiang Zhang <chan9yan9@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 106/107] hw/pci: Replace assert with bounds check and
 return
Date: Wed, 24 Jun 2026 16:31:51 +0300
Message-ID: <20260624133301.403266-106-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
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
index 91e3885c7f..2a7fdfa563 100644
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


