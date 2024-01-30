Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E05FC47DB3
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 00:28:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUbyG-00053K-1J; Mon, 29 Jan 2024 19:27:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rUbyE-00053A-On
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 19:27:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rUbyD-0006Va-7M
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 19:27:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706574440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=B2EP7prdCC7SlFLAceejRJ/i/ANE2wxe8xcFrpPAX3o=;
 b=SI4OIhVdmt0+DpCawYGeDZ6ZT2UrJZj/JaGwAodHvDepobImUyz4NbvFOQPPGXqVAimhx2
 h+BYNENbo9408pgMtJm57S2hpx9v0U8goNGUbNz4tFr71K8HDJYGpY4Q0gg0M53mDSvPir
 Rzomp/kmKnWmeyyY/tS9YBipCex33NE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-211-Cz0FofY7PvyPjt2hnMfuHQ-1; Mon,
 29 Jan 2024 19:27:15 -0500
X-MC-Unique: Cz0FofY7PvyPjt2hnMfuHQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E0083C0F196;
 Tue, 30 Jan 2024 00:27:15 +0000 (UTC)
Received: from localhost (unknown [10.39.192.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BA2A71C060AF;
 Tue, 30 Jan 2024 00:27:14 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 <qemu-block@nongnu.org>, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Xiang Zheng <zhengxiang9@huawei.com>
Subject: [PATCH] pflash: fix sectors vs bytes confusion in
 blk_pread_nonzeroes()
Date: Mon, 29 Jan 2024 19:27:12 -0500
Message-ID: <20240130002712.257815-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The following expression is incorrect because blk_pread_nonzeroes()
deals in units of bytes, not sectors:

  bytes = MIN(size - offset, BDRV_REQUEST_MAX_SECTORS)
                                              ^^^^^^^

BDRV_REQUEST_MAX_BYTES is the appropriate constant.

Fixes: a4b15a8b9ef2 ("pflash: Only read non-zero parts of backend image")
Cc: Xiang Zheng <zhengxiang9@huawei.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/block/block.c b/hw/block/block.c
index 9f52ee6e72..ff503002aa 100644
--- a/hw/block/block.c
+++ b/hw/block/block.c
@@ -30,7 +30,7 @@ static int blk_pread_nonzeroes(BlockBackend *blk, hwaddr size, void *buf)
     BlockDriverState *bs = blk_bs(blk);
 
     for (;;) {
-        bytes = MIN(size - offset, BDRV_REQUEST_MAX_SECTORS);
+        bytes = MIN(size - offset, BDRV_REQUEST_MAX_BYTES);
         if (bytes <= 0) {
             return 0;
         }
-- 
2.43.0


