Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D561C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 10:45:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh5o7-0006OI-Cu; Mon, 04 Mar 2024 05:44:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rh5o1-0006Mx-Ux
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 05:44:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rh5ny-00048V-Bd
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 05:44:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709549061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rhR7+x86Od4O3g4vLC5WnQ5uQbaEtOIZwizKLMyBpUk=;
 b=Wm16vvmSSBGqbmiqoG4xve4tK/luiXQQ441CR1ziE1/wXMqRdsuOllqEuvCaUyo556Y46M
 om12yGdxXgTdb1SNdINnxfRydQiQxQEwyHLq0vkv52f3AEEfUG6qZKXlSuPwPng7rgRrix
 D1Y7i30eOTZqqm2Olscu/kRtuOpyBLk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-9AJSpp5HNpWNzQ8vGy_v-Q-1; Mon, 04 Mar 2024 05:44:18 -0500
X-MC-Unique: 9AJSpp5HNpWNzQ8vGy_v-Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB45384AE40;
 Mon,  4 Mar 2024 10:44:17 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CAF321C060B1;
 Mon,  4 Mar 2024 10:44:15 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
	qemu-devel@nongnu.org
Cc: Fan Ni <fan.ni@samsung.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-trivial@nongnu.org
Subject: [PATCH 3/3] hw/mem/cxl_type3: Fix problem with g_steal_pointer()
Date: Mon,  4 Mar 2024 11:44:06 +0100
Message-ID: <20240304104406.59855-4-thuth@redhat.com>
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
triggers errors in the ct3_build_cdat_entries_for_mr() function which
uses the g_steal_pointer() for type-casting from one pointer type to
the other (which also looks quite weird since the local pointers have
all been declared with g_autofree though they are never freed here).
Fix it by using a proper typecast instead. For making this possible, we
have to remove the QEMU_PACKED attribute from some structs since GCC
otherwise complains that the source and destination pointer might
have different alignment restrictions. Removing the QEMU_PACKED should
be fine here since the structs are already naturally aligned. Anyway,
add some QEMU_BUILD_BUG_ON() statements to make sure that we've got
the right sizes (without padding in the structs).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/cxl/cxl_cdat.h |  9 ++++++---
 hw/mem/cxl_type3.c        | 24 ++++++++++++------------
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/include/hw/cxl/cxl_cdat.h b/include/hw/cxl/cxl_cdat.h
index b44cefaad6..17a09066dc 100644
--- a/include/hw/cxl/cxl_cdat.h
+++ b/include/hw/cxl/cxl_cdat.h
@@ -82,7 +82,8 @@ typedef struct CDATDsmas {
     uint16_t reserved;
     uint64_t DPA_base;
     uint64_t DPA_length;
-} QEMU_PACKED CDATDsmas;
+} CDATDsmas;
+QEMU_BUILD_BUG_ON(sizeof(CDATDsmas) != 24);
 
 /* Device Scoped Latency and Bandwidth Information Structure - CDAT Table 5 */
 typedef struct CDATDslbis {
@@ -95,7 +96,8 @@ typedef struct CDATDslbis {
     uint64_t entry_base_unit;
     uint16_t entry[3];
     uint16_t reserved2;
-} QEMU_PACKED CDATDslbis;
+} CDATDslbis;
+QEMU_BUILD_BUG_ON(sizeof(CDATDslbis) != 24);
 
 /* Device Scoped Memory Side Cache Information Structure - CDAT Table 6 */
 typedef struct CDATDsmscis {
@@ -122,7 +124,8 @@ typedef struct CDATDsemts {
     uint16_t reserved;
     uint64_t DPA_offset;
     uint64_t DPA_length;
-} QEMU_PACKED CDATDsemts;
+} CDATDsemts;
+QEMU_BUILD_BUG_ON(sizeof(CDATDsemts) != 24);
 
 /* Switch Scoped Latency and Bandwidth Information Structure - CDAT Table 9 */
 typedef struct CDATSslbisHeader {
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index e8801805b9..b679dfae1c 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -46,12 +46,12 @@ static void ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
                                           int dsmad_handle, MemoryRegion *mr,
                                           bool is_pmem, uint64_t dpa_base)
 {
-    g_autofree CDATDsmas *dsmas = NULL;
-    g_autofree CDATDslbis *dslbis0 = NULL;
-    g_autofree CDATDslbis *dslbis1 = NULL;
-    g_autofree CDATDslbis *dslbis2 = NULL;
-    g_autofree CDATDslbis *dslbis3 = NULL;
-    g_autofree CDATDsemts *dsemts = NULL;
+    CDATDsmas *dsmas;
+    CDATDslbis *dslbis0;
+    CDATDslbis *dslbis1;
+    CDATDslbis *dslbis2;
+    CDATDslbis *dslbis3;
+    CDATDsemts *dsemts;
 
     dsmas = g_malloc(sizeof(*dsmas));
     *dsmas = (CDATDsmas) {
@@ -135,12 +135,12 @@ static void ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
     };
 
     /* Header always at start of structure */
-    cdat_table[CT3_CDAT_DSMAS] = g_steal_pointer(&dsmas);
-    cdat_table[CT3_CDAT_DSLBIS0] = g_steal_pointer(&dslbis0);
-    cdat_table[CT3_CDAT_DSLBIS1] = g_steal_pointer(&dslbis1);
-    cdat_table[CT3_CDAT_DSLBIS2] = g_steal_pointer(&dslbis2);
-    cdat_table[CT3_CDAT_DSLBIS3] = g_steal_pointer(&dslbis3);
-    cdat_table[CT3_CDAT_DSEMTS] = g_steal_pointer(&dsemts);
+    cdat_table[CT3_CDAT_DSMAS] = (CDATSubHeader *)dsmas;
+    cdat_table[CT3_CDAT_DSLBIS0] = (CDATSubHeader *)dslbis0;
+    cdat_table[CT3_CDAT_DSLBIS1] = (CDATSubHeader *)dslbis1;
+    cdat_table[CT3_CDAT_DSLBIS2] = (CDATSubHeader *)dslbis2;
+    cdat_table[CT3_CDAT_DSLBIS3] = (CDATSubHeader *)dslbis3;
+    cdat_table[CT3_CDAT_DSEMTS] = (CDATSubHeader *)dsemts;
 }
 
 static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
-- 
2.44.0


