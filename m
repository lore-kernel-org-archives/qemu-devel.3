Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5279C54798
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 15:59:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riz5G-0007Mp-Du; Sat, 09 Mar 2024 10:58:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1riz5B-0007LT-Qy; Sat, 09 Mar 2024 10:57:57 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1riz59-0004IL-3p; Sat, 09 Mar 2024 10:57:56 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 53DB35452D;
 Sat,  9 Mar 2024 18:58:37 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 8A922944C2;
 Sat,  9 Mar 2024 18:57:40 +0300 (MSK)
Received: (nullmailer pid 1694668 invoked by uid 1000);
 Sat, 09 Mar 2024 15:57:29 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 08/11] hw/cxl/cxl-cdat: Fix type of buf in ct3_load_cdat()
Date: Sat,  9 Mar 2024 18:57:26 +0300
Message-Id: <20240309155729.1694607-9-mjt@tls.msk.ru>
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

When setting GLIB_VERSION_MAX_ALLOWED to GLIB_VERSION_2_58 or higher
(which we'll certainly do in the not too distant future), glib adds
type safety checks to the g_steal_pointer() macro. This trigger an
error in the ct3_load_cdat() function: The local char *buf variable is
assigned to uint8_t *buf in CDATObject, i.e. a pointer of a different
type. Change the local variable to the same type as buf in CDATObject
to avoid the error.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/cxl/cxl-cdat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-cdat.c b/hw/cxl/cxl-cdat.c
index 2fea975671..551545f782 100644
--- a/hw/cxl/cxl-cdat.c
+++ b/hw/cxl/cxl-cdat.c
@@ -114,7 +114,7 @@ static void ct3_build_cdat(CDATObject *cdat, Error **errp)
 static void ct3_load_cdat(CDATObject *cdat, Error **errp)
 {
     g_autofree CDATEntry *cdat_st = NULL;
-    g_autofree char *buf = NULL;
+    g_autofree uint8_t *buf = NULL;
     uint8_t sum = 0;
     int num_ent;
     int i = 0, ent = 1;
@@ -171,7 +171,7 @@ static void ct3_load_cdat(CDATObject *cdat, Error **errp)
         cdat_st[ent].base = hdr;
         cdat_st[ent].length = hdr->length;
 
-        while (buf + i < (char *)cdat_st[ent].base + cdat_st[ent].length) {
+        while (buf + i < (uint8_t *)cdat_st[ent].base + cdat_st[ent].length) {
             assert(i < file_size);
             sum += buf[i++];
         }
-- 
2.39.2


