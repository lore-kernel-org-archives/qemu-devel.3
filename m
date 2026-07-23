Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC29FC531F5
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 14:46:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmugM-00088X-VS; Thu, 23 Jul 2026 10:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wmug1-00085V-DU
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 10:45:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wmufx-0002UN-Kn
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 10:45:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784817929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TzocXCl8tCAKz01IrjejhYq9aTZDjHm78Fmh0u4m9cM=;
 b=ioJXOEy38EbyBo1RUXZK/HdrTgAOs81cWOhv7u0lIjzJ66lgPGvoePSHvO3Xc/1TPdRNgn
 VyDVxLfN02lAkIOKw6mEpgZVY/T5DnIwb+D17S1tQsuGN1P8+OrkVHiUsYd8HHWd9y8djv
 I9z3tMhrCjFic4IPlEtmt46qetpL+nM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-482-2pF6xrGGOb-SC4nMM3EeXQ-1; Thu,
 23 Jul 2026 10:45:26 -0400
X-MC-Unique: 2pF6xrGGOb-SC4nMM3EeXQ-1
X-Mimecast-MFC-AGG-ID: 2pF6xrGGOb-SC4nMM3EeXQ_1784817925
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 957FD1805F34; Thu, 23 Jul 2026 14:45:25 +0000 (UTC)
Received: from localhost (unknown [10.2.16.100])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 004843000225; Thu, 23 Jul 2026 14:45:24 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH for-11.1 2/3] dmg: refuse to open files with no chunks
Date: Thu, 23 Jul 2026 10:45:18 -0400
Message-ID: <20260723144519.364701-3-stefanha@redhat.com>
In-Reply-To: <20260723144519.364701-1-stefanha@redhat.com>
References: <20260723144519.364701-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=stefanha@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.951,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The dmg block driver expects the disk image file to contain at least one
chunk. Refuse to open such files. This ensures that dmg block driver
state always has non-NULL s->sectors[] and related fields.

Note that the previous commit fixed the only known way to trigger a
crash. This patch is just for defense - let's avoid opening the file and
having NULL pointers in dmg block driver state.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4021
Reported-by: Tristan Madani <tristan@talencesecurity.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/dmg.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/dmg.c b/block/dmg.c
index e325127d144..6f8120e0338 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -559,6 +559,12 @@ static int dmg_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail;
     }
 
+    /* There must be at least one chunk */
+    if (s->n_chunks == 0) {
+        ret = -EINVAL;
+        goto fail;
+    }
+
     /* initialize zlib engine */
     s->compressed_chunk = qemu_try_blockalign(bs->file->bs,
                                               ds.max_compressed_size + 1);
-- 
2.55.0


