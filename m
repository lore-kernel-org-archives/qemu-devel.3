Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62249C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 13:55:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp7GW-0004Cv-2q; Tue, 26 Mar 2024 09:55:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rp7GU-0004BW-G9
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:54:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rp7GT-0001Pp-01
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:54:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711461296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iiFRDqyPBuCxQcW8SpSU8hf+uTFJyzli3rpm/de5tJE=;
 b=DP25vuDJiL02j91oFthLeLZbNgpoWq3i/2vtGcbb0fB+FqbgSQxJDOG3xoy7Q6WndfDgRv
 7LAlsjxZSHwWUQxMenJ0TCRsWtl4761fY4E47eTVBKVY8lGQJ9WkC1tj572wCd8OrBFFJ4
 WVP+mgZSeXUI8iCHQTNRCDGtva3V78A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-KXZaZdYPNEOFMyNGUI__xg-1; Tue, 26 Mar 2024 09:54:52 -0400
X-MC-Unique: KXZaZdYPNEOFMyNGUI__xg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6529D8007A2;
 Tue, 26 Mar 2024 13:54:52 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B063E1121312;
 Tue, 26 Mar 2024 13:54:51 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 5/6] block-backend: fix edge case in bdrv_next_cleanup() where
 BDS associated to BB changes
Date: Tue, 26 Mar 2024 14:54:39 +0100
Message-ID: <20240326135440.421609-6-kwolf@redhat.com>
In-Reply-To: <20240326135440.421609-1-kwolf@redhat.com>
References: <20240326135440.421609-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Fiona Ebner <f.ebner@proxmox.com>

Same rationale as for commit "block-backend: fix edge case in
bdrv_next() where BDS associated to BB changes". The block graph might
change between the bdrv_next() call and the bdrv_next_cleanup() call,
so it could be that the associated BDS is not the same that was
referenced previously anymore. Instead, rely on bdrv_next() to set
it->bs to the BDS it referenced and unreference that one in any case.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20240322095009.346989-4-f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/block-backend.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 28af1eb17a..db6f9b92a3 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -663,13 +663,10 @@ void bdrv_next_cleanup(BdrvNextIterator *it)
     /* Must be called from the main loop */
     assert(qemu_get_current_aio_context() == qemu_get_aio_context());
 
-    if (it->phase == BDRV_NEXT_BACKEND_ROOTS) {
-        if (it->blk) {
-            bdrv_unref(blk_bs(it->blk));
-            blk_unref(it->blk);
-        }
-    } else {
-        bdrv_unref(it->bs);
+    bdrv_unref(it->bs);
+
+    if (it->phase == BDRV_NEXT_BACKEND_ROOTS && it->blk) {
+        blk_unref(it->blk);
     }
 
     bdrv_next_reset(it);
-- 
2.44.0


