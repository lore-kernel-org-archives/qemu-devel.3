Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D5AC5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 10:45:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh5o2-0006Mr-HO; Mon, 04 Mar 2024 05:44:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rh5nz-0006MZ-HZ
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 05:44:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rh5nx-00047X-Of
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 05:44:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709549059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bddr7713wXn9ehS0lvEtkXSMBdFoA3ddkKz6YSM36IM=;
 b=JolChdfgR94FgNq5CxcUsfPWRjTsCjrIhCKjXVcfT8ZFyPo/b6sCtarIQO2g2039ElzQLV
 aBJQogmNRLGHjJ5T3sX5bUNluYPB3mW950ASOFhJCK5nRjtSPPRHBILfsVgBIBgDpJ+dUM
 KoWgP3kCifuAtB7+sKruo1pwz9Ay5xw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-kyK9S-iVOLmQSrvJA39wNA-1; Mon,
 04 Mar 2024 05:44:15 -0500
X-MC-Unique: kyK9S-iVOLmQSrvJA39wNA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7685C1C0BA43;
 Mon,  4 Mar 2024 10:44:15 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 467AF1C060AF;
 Mon,  4 Mar 2024 10:44:13 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
	qemu-devel@nongnu.org
Cc: Fan Ni <fan.ni@samsung.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-trivial@nongnu.org
Subject: [PATCH 2/3] hw/pci-bridge/cxl_upstream: Fix problem with
 g_steal_pointer()
Date: Mon,  4 Mar 2024 11:44:05 +0100
Message-ID: <20240304104406.59855-3-thuth@redhat.com>
In-Reply-To: <20240304104406.59855-1-thuth@redhat.com>
References: <20240304104406.59855-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
---
 include/hw/cxl/cxl_cdat.h    | 8 +++++---
 hw/pci-bridge/cxl_upstream.c | 8 ++++----
 2 files changed, 9 insertions(+), 7 deletions(-)

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
-- 
2.44.0


