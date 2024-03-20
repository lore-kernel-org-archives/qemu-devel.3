Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D6D1C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 06:51:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmpmL-0002Ug-5D; Wed, 20 Mar 2024 02:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rmpm4-0002Jp-Rc
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 02:50:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rmpm3-0001ke-Am
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 02:50:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710917406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3dK0oZTvcqn0RlRQ+2sj7u85Oit8BnOYCOjlvqO3HYw=;
 b=HJXf3VNJZ7dEDGlFXfCyK0VSo/rHxgfKu8ALNVHpcK273EuavkzjOi6aL0y6yNoNkumD/T
 YVP0kXXG/onTT2cLiGwF3sfIwZ2a66A8UrHEDAKA0lNp19NNNos+Ipv4CwSa31LEsHk8Qz
 VTGrm8efynpBB0tD9XntDAZmA0+OzoE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-_L05SnoBM_ecmTfv0jphcg-1; Wed, 20 Mar 2024 02:50:04 -0400
X-MC-Unique: _L05SnoBM_ecmTfv0jphcg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F1C4A101A596;
 Wed, 20 Mar 2024 06:50:03 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 05B851C060CE;
 Wed, 20 Mar 2024 06:50:01 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-9.1 v5 13/14] migration: Add Error** argument to
 xbzrle_init()
Date: Wed, 20 Mar 2024 07:49:09 +0100
Message-ID: <20240320064911.545001-14-clg@redhat.com>
In-Reply-To: <20240320064911.545001-1-clg@redhat.com>
References: <20240320064911.545001-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Since the return value (-ENOMEM) is not exploited, follow the
recommendations of qapi/error.h and change it to a bool

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 migration/ram.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 26ce11a3379056d38062c1fb63166c6e3155bd8c..70797ef5d80c6ccf61fee987bbe3969041664c69 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2727,44 +2727,41 @@ int ram_discard_range(const char *rbname, uint64_t start, size_t length)
  * For every allocation, we will try not to crash the VM if the
  * allocation failed.
  */
-static int xbzrle_init(void)
+static bool xbzrle_init(Error **errp)
 {
-    Error *local_err = NULL;
-
     if (!migrate_xbzrle()) {
-        return 0;
+        return true;
     }
 
     XBZRLE_cache_lock();
 
     XBZRLE.zero_target_page = g_try_malloc0(TARGET_PAGE_SIZE);
     if (!XBZRLE.zero_target_page) {
-        error_report("%s: Error allocating zero page", __func__);
+        error_setg(errp, "%s: Error allocating zero page", __func__);
         goto err_out;
     }
 
     XBZRLE.cache = cache_init(migrate_xbzrle_cache_size(),
-                              TARGET_PAGE_SIZE, &local_err);
+                              TARGET_PAGE_SIZE, errp);
     if (!XBZRLE.cache) {
-        error_report_err(local_err);
         goto free_zero_page;
     }
 
     XBZRLE.encoded_buf = g_try_malloc0(TARGET_PAGE_SIZE);
     if (!XBZRLE.encoded_buf) {
-        error_report("%s: Error allocating encoded_buf", __func__);
+        error_setg(errp, "%s: Error allocating encoded_buf", __func__);
         goto free_cache;
     }
 
     XBZRLE.current_buf = g_try_malloc(TARGET_PAGE_SIZE);
     if (!XBZRLE.current_buf) {
-        error_report("%s: Error allocating current_buf", __func__);
+        error_setg(errp, "%s: Error allocating current_buf", __func__);
         goto free_encoded_buf;
     }
 
     /* We are all good */
     XBZRLE_cache_unlock();
-    return 0;
+    return true;
 
 free_encoded_buf:
     g_free(XBZRLE.encoded_buf);
@@ -2777,7 +2774,7 @@ free_zero_page:
     XBZRLE.zero_target_page = NULL;
 err_out:
     XBZRLE_cache_unlock();
-    return -ENOMEM;
+    return false;
 }
 
 static bool ram_state_init(RAMState **rsp, Error **errp)
@@ -2904,7 +2901,8 @@ static int ram_init_all(RAMState **rsp)
         return -1;
     }
 
-    if (xbzrle_init()) {
+    if (!xbzrle_init(&local_err)) {
+        error_report_err(local_err);
         ram_state_cleanup(rsp);
         return -1;
     }
-- 
2.44.0


