Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00582C54798
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 16:00:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riz5O-0007RS-Kn; Sat, 09 Mar 2024 10:58:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1riz5E-0007Lq-MV; Sat, 09 Mar 2024 10:58:01 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1riz5C-0004Iu-JR; Sat, 09 Mar 2024 10:58:00 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8682F54531;
 Sat,  9 Mar 2024 18:58:38 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 08292944C3;
 Sat,  9 Mar 2024 18:57:41 +0300 (MSK)
Received: (nullmailer pid 1694671 invoked by uid 1000);
 Sat, 09 Mar 2024 15:57:29 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 09/11] hw/pci-bridge/cxl_upstream: Fix problem with
 g_steal_pointer()
Date: Sat,  9 Mar 2024 18:57:27 +0300
Message-Id: <20240309155729.1694607-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240309155729.1694607-1-mjt@tls.msk.ru>
References: <20240309155729.1694607-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

When setting GLIB_VERSION_MAX_ALLOWED to GLIB_VERSION_2_58 or higher,
glib adds type safety checks to the g_steal_pointer() macro. This
triggers errors in the build_cdat_table() function which uses the
g_steal_pointer() for type-casting from one pointer type to the other
(which also looks quite weird since the local pointers have all been
declared with g_autofree though they are never freed here). Let's fix
it by using a proper typecast instead. For making this possible, we
have to remove the QEMU_PACKED attribute from some structs since GCC
otherwise complains that the source and destination pointer might
have different alignment restrictions. Removing the QEMU_PACKED should
be fine here since the structs are already naturally aligned. Anyway,
add some QEMU_BUILD_BUG_ON() statements to make sure that we've got
the right sizes (without padding in the structs).

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/pci-bridge/cxl_upstream.c | 8 ++++----
 include/hw/cxl/cxl_cdat.h    | 8 +++++---
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index e87eb40177..537f9affb8 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -192,8 +192,8 @@ enum {
 
 static int build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
 {
-    g_autofree CDATSslbis *sslbis_latency = NULL;
-    g_autofree CDATSslbis *sslbis_bandwidth = NULL;
+    CDATSslbis *sslbis_latency;
+    CDATSslbis *sslbis_bandwidth;
     CXLUpstreamPort *us = CXL_USP(priv);
     PCIBus *bus = &PCI_BRIDGE(us)->sec_bus;
     int devfn, sslbis_size, i;
@@ -270,8 +270,8 @@ static int build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
     *cdat_table = g_new0(CDATSubHeader *, CXL_USP_CDAT_NUM_ENTRIES);
 
     /* Header always at start of structure */
-    (*cdat_table)[CXL_USP_CDAT_SSLBIS_LAT] = g_steal_pointer(&sslbis_latency);
-    (*cdat_table)[CXL_USP_CDAT_SSLBIS_BW] = g_steal_pointer(&sslbis_bandwidth);
+    (*cdat_table)[CXL_USP_CDAT_SSLBIS_LAT] = (CDATSubHeader *)sslbis_latency;
+    (*cdat_table)[CXL_USP_CDAT_SSLBIS_BW] = (CDATSubHeader *)sslbis_bandwidth;
 
     return CXL_USP_CDAT_NUM_ENTRIES;
 }
diff --git a/include/hw/cxl/cxl_cdat.h b/include/hw/cxl/cxl_cdat.h
index 8e3d094608..b44cefaad6 100644
--- a/include/hw/cxl/cxl_cdat.h
+++ b/include/hw/cxl/cxl_cdat.h
@@ -130,7 +130,8 @@ typedef struct CDATSslbisHeader {
     uint8_t data_type;
     uint8_t reserved[3];
     uint64_t entry_base_unit;
-} QEMU_PACKED CDATSslbisHeader;
+} CDATSslbisHeader;
+QEMU_BUILD_BUG_ON(sizeof(CDATSslbisHeader) != 16);
 
 #define CDAT_PORT_ID_USP 0x100
 /* Switch Scoped Latency and Bandwidth Entry - CDAT Table 10 */
@@ -139,12 +140,13 @@ typedef struct CDATSslbe {
     uint16_t port_y_id;
     uint16_t latency_bandwidth;
     uint16_t reserved;
-} QEMU_PACKED CDATSslbe;
+} CDATSslbe;
+QEMU_BUILD_BUG_ON(sizeof(CDATSslbe) != 8);
 
 typedef struct CDATSslbis {
     CDATSslbisHeader sslbis_header;
     CDATSslbe sslbe[];
-} QEMU_PACKED CDATSslbis;
+} CDATSslbis;
 
 typedef struct CDATEntry {
     void *base;
-- 
2.39.2


