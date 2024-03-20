Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C34C6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 06:51:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmpm0-0002JQ-Tw; Wed, 20 Mar 2024 02:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rmplz-0002HY-1T
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 02:50:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rmplx-0001X3-Gw
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 02:50:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710917400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lVTZKiKFhelwGsQo2+M0pXPKEtWBAHgU3lcxi8iyvF0=;
 b=f8BbuaovM31PSDDdyhalPNqXYOTZuZQSkBlE/bWmuPHc25BgWaFY+ehqijitVNc8zqwPVx
 sAOd1AqU23kEw0TxehQQVaFY3Gok4g9WRKXOJ8iPUka/0v5+A3LwSzFbRtyKd58hl9T+v2
 01z9a3Qprh+K5v9Hoxzj62m/QgJPRFw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-U_mj-5d3Pd6mmPNthnXezw-1; Wed, 20 Mar 2024 02:49:55 -0400
X-MC-Unique: U_mj-5d3Pd6mmPNthnXezw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1E994185A789;
 Wed, 20 Mar 2024 06:49:55 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DB3FA1C060A4;
 Wed, 20 Mar 2024 06:49:52 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-9.1 v5 10/14] migration: Introduce ram_bitmaps_destroy()
Date: Wed, 20 Mar 2024 07:49:06 +0100
Message-ID: <20240320064911.545001-11-clg@redhat.com>
In-Reply-To: <20240320064911.545001-1-clg@redhat.com>
References: <20240320064911.545001-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

We will use it in ram_init_bitmaps() to clear the allocated bitmaps when
support for error reporting is added to memory_global_dirty_log_start().

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 migration/ram.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 4cd4f0158c8675e1515ef8476c64d1203eed4458..f0bd71438a4f7212118593b51648b645737933d4 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2438,10 +2438,23 @@ static void xbzrle_cleanup(void)
     XBZRLE_cache_unlock();
 }
 
+static void ram_bitmaps_destroy(void)
+{
+    RAMBlock *block;
+
+    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
+        g_free(block->clear_bmap);
+        block->clear_bmap = NULL;
+        g_free(block->bmap);
+        block->bmap = NULL;
+        g_free(block->file_bmap);
+        block->file_bmap = NULL;
+    }
+}
+
 static void ram_save_cleanup(void *opaque)
 {
     RAMState **rsp = opaque;
-    RAMBlock *block;
 
     /* We don't use dirty log with background snapshots */
     if (!migrate_background_snapshot()) {
@@ -2458,12 +2471,7 @@ static void ram_save_cleanup(void *opaque)
         }
     }
 
-    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
-        g_free(block->clear_bmap);
-        block->clear_bmap = NULL;
-        g_free(block->bmap);
-        block->bmap = NULL;
-    }
+    ram_bitmaps_destroy();
 
     xbzrle_cleanup();
     compress_threads_save_cleanup();
-- 
2.44.0


