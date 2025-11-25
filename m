Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DDFD0E6F5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 16:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNvkn-0007oE-Pe; Tue, 25 Nov 2025 11:19:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vNvj5-0006j1-6z
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 11:17:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vNvj2-00056a-Iv
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 11:17:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764087428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P+vw1qAFjBBxlHJT7pgmA4NHosOs7cQ65PoTw3CPa2g=;
 b=fv04Gf60e/Ai2WyXaQ2w1fRyglLfMZC0LC7pX7aQ5vg+jeQSpH2d6jhHQsSiNBEjbRIVzC
 v+RI0lly4iKD4ylpG91wfy1uyTTF2nZlRr5PgcAX8d5Q2NIN7Wu5hLAdI0VsNiAbNyoE8U
 sHhA6mlHOraMz6SuCXx/3mKWN9P/yGo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-10-33Oz31LRPvOiQmmx8XAmug-1; Tue,
 25 Nov 2025 11:17:04 -0500
X-MC-Unique: 33Oz31LRPvOiQmmx8XAmug-1
X-Mimecast-MFC-AGG-ID: 33Oz31LRPvOiQmmx8XAmug_1764087423
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5958E180122F; Tue, 25 Nov 2025 16:17:03 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.45.226.49])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D79B71800451; Tue, 25 Nov 2025 16:17:01 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 2/4] file-posix: populate pwrite_zeroes_alignment
Date: Tue, 25 Nov 2025 17:16:46 +0100
Message-ID: <20251125161648.259321-3-kwolf@redhat.com>
In-Reply-To: <20251125161648.259321-1-kwolf@redhat.com>
References: <20251125161648.259321-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Linux block devices require write zeroes alignment whereas files do not.

It may come as a surprise that block devices opened in buffered I/O mode
require the alignment for write zeroes requests although normal
read/write requests do not.

Therefore it is necessary to populate the pwrite_zeroes_alignment field.

Cc: qemu-stable@nongnu.org
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20251007141700.71891-2-stefanha@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index 12d12970fa..c9e367a222 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1611,6 +1611,22 @@ static void raw_refresh_limits(BlockDriverState *bs, Error **errp)
 
             bs->bl.pdiscard_alignment = dalign;
         }
+
+#ifdef __linux__
+        /*
+         * Linux requires logical block size alignment for write zeroes even
+         * when normal reads/writes do not require alignment.
+         */
+        if (!s->needs_alignment) {
+            ret = probe_logical_blocksize(s->fd,
+                                          &bs->bl.pwrite_zeroes_alignment);
+            if (ret < 0) {
+                error_setg_errno(errp, -ret,
+                                 "Failed to probe logical block size");
+                return;
+            }
+        }
+#endif /* __linux__ */
     }
 
     raw_refresh_zoned_limits(bs, &st, errp);
-- 
2.51.1


