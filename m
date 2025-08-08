Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A87C87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 08:11:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukI9X-00078a-Pl; Fri, 08 Aug 2025 04:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ukI9T-00073X-TK
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 04:08:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ukI9P-0006TE-SG
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 04:08:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754640511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YWqpCLBK+hhQauHT2lf7oa/LCZhcGpTlEip3nitM2Wg=;
 b=MI9TlIAvX5oM8lWSl4R/GN4s2TXnzTRxEvOq7p+0dQ+T50bs3AgNUbvHMFJ+glBi869My3
 C+GXKJQ082u0NQfavYazPewPS9vJ+HcelUBfw+cjdoOkXq573tcUnzru2UO9Xdyi0UWVJC
 cH1xdoT4QhhdPDWBUFAQgxr1xdx8/l8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-ZUinX9_8NTSxeTIU_UDvBA-1; Fri,
 08 Aug 2025 04:08:27 -0400
X-MC-Unique: ZUinX9_8NTSxeTIU_UDvBA-1
X-Mimecast-MFC-AGG-ID: ZUinX9_8NTSxeTIU_UDvBA_1754640506
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AD04C1800289; Fri,  8 Aug 2025 08:08:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 151BC19560B0; Fri,  8 Aug 2025 08:08:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4F8A321E6935; Fri, 08 Aug 2025 10:08:23 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp, marcandre.lureau@redhat.com,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 03/12] hw/cxl: Convert cxl_fmws_link() to Error
Date: Fri,  8 Aug 2025 10:08:14 +0200
Message-ID: <20250808080823.2638861-4-armbru@redhat.com>
In-Reply-To: <20250808080823.2638861-1-armbru@redhat.com>
References: <20250808080823.2638861-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Functions that use an Error **errp parameter to return errors should
not also report them to the user, because reporting is the caller's
job.  When the caller does, the error is reported twice.  When it
doesn't (because it recovered from the error), there is no error to
report, i.e. the report is bogus.

cxl_fmws_link_targets() violates this principle: it calls
error_setg(&error_fatal, ...) via cxl_fmws_link().  Goes back to
commit 584f722eb3ab (hw/cxl: Make the CXL fixed memory windows
devices.)  Currently harmless, because cxl_fmws_link_targets()'s
callers always pass &error_fatal.  Clean this up by converting
cxl_fmws_link() to Error.

Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/cxl/cxl-host.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index 5c2ce25a19..0d891c651d 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -72,6 +72,7 @@ static void cxl_fixed_memory_window_config(CXLFixedMemoryWindowOptions *object,
 
 static int cxl_fmws_link(Object *obj, void *opaque)
 {
+    Error **errp = opaque;
     struct CXLFixedWindow *fw;
     int i;
 
@@ -87,9 +88,9 @@ static int cxl_fmws_link(Object *obj, void *opaque)
         o = object_resolve_path_type(fw->targets[i], TYPE_PXB_CXL_DEV,
                                      &ambig);
         if (!o) {
-            error_setg(&error_fatal, "Could not resolve CXLFM target %s",
+            error_setg(errp, "Could not resolve CXLFM target %s",
                        fw->targets[i]);
-            return 1;
+            return -1;
         }
         fw->target_hbs[i] = PXB_CXL_DEV(o);
     }
@@ -99,7 +100,7 @@ static int cxl_fmws_link(Object *obj, void *opaque)
 void cxl_fmws_link_targets(Error **errp)
 {
     /* Order doesn't matter for this, so no need to build list */
-    object_child_foreach_recursive(object_get_root(), cxl_fmws_link, NULL);
+    object_child_foreach_recursive(object_get_root(), cxl_fmws_link, errp);
 }
 
 static bool cxl_hdm_find_target(uint32_t *cache_mem, hwaddr addr,
-- 
2.49.0


