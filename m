Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A349D148B5
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 07:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdk6T-0006pH-S1; Thu, 08 Jan 2026 02:06:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdk6O-0006jk-MV
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 02:06:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdk6M-0006bF-Mz
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 02:06:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767855993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y4a0cYuav1Vio+9dWkD0CtDvJQ580nj+0sRoB4k30nI=;
 b=AQUB2ZyHc5Xuzhg3hLfNvCo2Q6ZpkOgpyWD8vxxZiBV6glrvC0OgCiBHYtwOCuB02gRYBb
 tbbVE+vqxxpDcBudq7M86pE0F4PAE7mH2/npRcfbVLh+Nho9t6j7KR+qHFEts3FXL47+xY
 /lOP2Nw+TZ2XykcuvucguEGMtSVZiag=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-MDFkAb8xO22CTG87E0UIKw-1; Thu,
 08 Jan 2026 02:06:30 -0500
X-MC-Unique: MDFkAb8xO22CTG87E0UIKw-1
X-Mimecast-MFC-AGG-ID: MDFkAb8xO22CTG87E0UIKw_1767855989
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E01419560B2; Thu,  8 Jan 2026 07:06:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E89130002D1; Thu,  8 Jan 2026 07:06:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ED37821E61A8; Thu, 08 Jan 2026 08:06:25 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Xu <peterx@redhat.com>, Luc Michel <luc.michel@amd.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL v2 02/17] hw/nvram/xlnx-bbram: More idiomatic and simpler error
 reporting
Date: Thu,  8 Jan 2026 08:06:10 +0100
Message-ID: <20260108070625.1586474-3-armbru@redhat.com>
In-Reply-To: <20260108070625.1586474-1-armbru@redhat.com>
References: <20260108070625.1586474-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

bbram_bdrv_error() interpolates a "detail" string into a template with
error_setg_errno(), then reports the result with error_report().
Produces error messages with an unwanted '.':

    BLK-NAME: BBRAM backstore DETAIL failed.: STERROR

Replace both calls of bbram_bdrv_error() by straightforward
error_report(), and drop the function.  This is less code, easier to
read, and the error message is more greppable.

Also delete the unwanted '.'.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20251119130855.105479-3-armbru@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/nvram/xlnx-bbram.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/hw/nvram/xlnx-bbram.c b/hw/nvram/xlnx-bbram.c
index 60ede7e40f..edfb592a5e 100644
--- a/hw/nvram/xlnx-bbram.c
+++ b/hw/nvram/xlnx-bbram.c
@@ -88,18 +88,6 @@ static bool bbram_pgm_enabled(XlnxBBRam *s)
     return ARRAY_FIELD_EX32(s->regs, BBRAM_STATUS, PGM_MODE) != 0;
 }
 
-static void bbram_bdrv_error(XlnxBBRam *s, int rc, gchar *detail)
-{
-    Error *errp = NULL;
-
-    error_setg_errno(&errp, -rc, "%s: BBRAM backstore %s failed.",
-                     blk_name(s->blk), detail);
-    error_report("%s", error_get_pretty(errp));
-    error_free(errp);
-
-    g_free(detail);
-}
-
 static void bbram_bdrv_read(XlnxBBRam *s, Error **errp)
 {
     uint32_t *ram = &s->regs[R_BBRAM_0];
@@ -162,7 +150,8 @@ static void bbram_bdrv_sync(XlnxBBRam *s, uint64_t hwaddr)
     offset = hwaddr - A_BBRAM_0;
     rc = blk_pwrite(s->blk, offset, 4, &le32, 0);
     if (rc < 0) {
-        bbram_bdrv_error(s, rc, g_strdup_printf("write to offset %u", offset));
+        error_report("%s: BBRAM backstore write to offset %u failed: %s",
+                     blk_name(s->blk), offset, strerror(-rc));
     }
 }
 
@@ -178,7 +167,8 @@ static void bbram_bdrv_zero(XlnxBBRam *s)
 
     rc = blk_make_zero(s->blk, 0);
     if (rc < 0) {
-        bbram_bdrv_error(s, rc, g_strdup("zeroizing"));
+        error_report("%s: BBRAM backstore zeroizing failed: %s",
+                     blk_name(s->blk), strerror(-rc));
     }
 
     /* Restore bbram8 if it is non-zero */
-- 
2.52.0


