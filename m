Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E90D116F3
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 09:37:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQjIV-0001Tz-07; Wed, 03 Dec 2025 04:37:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vQjIF-0000wR-3O; Wed, 03 Dec 2025 04:37:04 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vQjID-00078l-5r; Wed, 03 Dec 2025 04:37:02 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4251C1708BA;
 Wed, 03 Dec 2025 12:35:55 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2EF8832B5B1;
 Wed, 03 Dec 2025 12:36:13 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.3 91/96] hw/pci: Make msix_init take a uint32_t for
 nentries
Date: Wed,  3 Dec 2025 12:35:24 +0300
Message-ID: <20251203093612.2370716-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.3-20251203111246@cover.tls.msk.ru>
References: <qemu-stable-10.1.3-20251203111246@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

msix_init() and msix_init_exclusive_bar() take an "unsigned short"
argument for the number of MSI-X vectors to try to use.  This is big
enough for the maximum permitted number of vectors, which is 2048.
Unfortunately, we have several devices (most notably virtio) which
allow the user to specify the desired number of vectors, and which
use uint32_t properties for this.  If the user sets the property to a
value that is too big for a uint16_t, the value will be truncated
when it is passed to msix_init(), and msix_init() may then return
success if the truncated value is a valid one.

The resulting mismatch between the number of vectors the msix code
thinks the device has and the number of vectors the device itself
thinks it has can cause assertions, such as the one in issue 2631,
where "-device virtio-mouse-pci,vectors=19923041" is interpreted by
msix as "97 vectors" and by the virtio-pci layer as "19923041
vectors"; a guest attempt to access vector 97 thus passes the
virtio-pci bounds checking and hits an essertion in
msix_vector_use().

Avoid this by making msix_init() and its wrapper function
msix_init_exclusive_bar() take the number of vectors as a uint32_t.
The erroneous command line will now produce the warning

 qemu-system-i386: -device virtio-mouse-pci,vectors=19923041:
   warning: unable to init msix vectors to 19923041

and proceed without crashing.  (The virtio device warns and falls
back to not using MSIX, rather than complaining that the option is
not a valid value this is the same as the existing behaviour for
values that are beyond the MSI-X maximum possible value but fit into
a 16-bit integer, like 2049.)

To ensure this doesn't result in potential overflows in calculation
of the BAR size in msix_init_exclusive_bar(), we duplicate the
nentries error-check from msix_init() at the top of
msix_init_exclusive_bar(), so we know nentries is sane before we
start using it.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2631
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251107131044.1321637-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit ef44cc0a762438ebc84c4997a5ce29c6f00622c3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index 8c7f6709e2..b35476d057 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -318,7 +318,7 @@ static void msix_mask_all(struct PCIDevice *dev, unsigned nentries)
  * also means a programming error, except device assignment, which can check
  * if a real HW is broken.
  */
-int msix_init(struct PCIDevice *dev, unsigned short nentries,
+int msix_init(struct PCIDevice *dev, uint32_t nentries,
               MemoryRegion *table_bar, uint8_t table_bar_nr,
               unsigned table_offset, MemoryRegion *pba_bar,
               uint8_t pba_bar_nr, unsigned pba_offset, uint8_t cap_pos,
@@ -392,7 +392,7 @@ int msix_init(struct PCIDevice *dev, unsigned short nentries,
     return 0;
 }
 
-int msix_init_exclusive_bar(PCIDevice *dev, unsigned short nentries,
+int msix_init_exclusive_bar(PCIDevice *dev, uint32_t nentries,
                             uint8_t bar_nr, Error **errp)
 {
     int ret;
@@ -401,6 +401,12 @@ int msix_init_exclusive_bar(PCIDevice *dev, unsigned short nentries,
     uint32_t bar_pba_offset = bar_size / 2;
     uint32_t bar_pba_size = QEMU_ALIGN_UP(nentries, 64) / 8;
 
+    /* Sanity-check nentries before we use it in BAR size calculations */
+    if (nentries < 1 || nentries > PCI_MSIX_FLAGS_QSIZE + 1) {
+        error_setg(errp, "The number of MSI-X vectors is invalid");
+        return -EINVAL;
+    }
+
     /*
      * Migration compatibility dictates that this remains a 4k
      * BAR with the vector table in the lower half and PBA in
diff --git a/include/hw/pci/msix.h b/include/hw/pci/msix.h
index 11ef9454c1..551a2bcfe7 100644
--- a/include/hw/pci/msix.h
+++ b/include/hw/pci/msix.h
@@ -7,12 +7,12 @@
 
 void msix_set_message(PCIDevice *dev, int vector, MSIMessage msg);
 MSIMessage msix_get_message(PCIDevice *dev, unsigned int vector);
-int msix_init(PCIDevice *dev, unsigned short nentries,
+int msix_init(PCIDevice *dev, uint32_t nentries,
               MemoryRegion *table_bar, uint8_t table_bar_nr,
               unsigned table_offset, MemoryRegion *pba_bar,
               uint8_t pba_bar_nr, unsigned pba_offset, uint8_t cap_pos,
               Error **errp);
-int msix_init_exclusive_bar(PCIDevice *dev, unsigned short nentries,
+int msix_init_exclusive_bar(PCIDevice *dev, uint32_t nentries,
                             uint8_t bar_nr, Error **errp);
 
 void msix_write_config(PCIDevice *dev, uint32_t address, uint32_t val, int len);
-- 
2.47.3


