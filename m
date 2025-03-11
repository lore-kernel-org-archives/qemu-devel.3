Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78759C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 16:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts250-0006vf-RY; Tue, 11 Mar 2025 12:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ts228-00040D-PV
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 12:00:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ts223-0005hG-KJ
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 12:00:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741708838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AhHL2Fdt+g9QlS9SfWAj9l1MOwzrzbrrezwChzAgHIQ=;
 b=d7Oin3Z1R6bSn5qxiJC7FaREe728MSan9wWIkL5vnY0PnL3ESkzhmiqVu+NnEUQNh100T3
 Gif1ebh9woqxSYcjODQdYsenUbrMkg89qlfXn/LlSEo+IW+EAtEPnHvUE2x/FTkYXlKh1d
 GsBmfr2Lto/etxFKSyUhyb92ETs4Pec=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-0c4lZ8eENoemJB67w3EoWw-1; Tue,
 11 Mar 2025 12:00:35 -0400
X-MC-Unique: 0c4lZ8eENoemJB67w3EoWw-1
X-Mimecast-MFC-AGG-ID: 0c4lZ8eENoemJB67w3EoWw_1741708834
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6071A19560A2; Tue, 11 Mar 2025 16:00:34 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.33.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C1ED71800373; Tue, 11 Mar 2025 16:00:32 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 04/22] block/io: Ignore FUA with cache.no-flush=on
Date: Tue, 11 Mar 2025 17:00:03 +0100
Message-ID: <20250311160021.349761-5-kwolf@redhat.com>
In-Reply-To: <20250311160021.349761-1-kwolf@redhat.com>
References: <20250311160021.349761-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

For block drivers that don't advertise FUA support, we already call
bdrv_co_flush(), which considers BDRV_O_NO_FLUSH. However, drivers that
do support FUA still see the FUA flag with BDRV_O_NO_FLUSH and get the
associated performance penalty that cache.no-flush=on was supposed to
avoid.

Clear FUA for write requests if BDRV_O_NO_FLUSH is set.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20250307221634.71951-3-kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/io.c b/block/io.c
index d369b994df..1ba8d1aeea 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1058,6 +1058,10 @@ bdrv_driver_pwritev(BlockDriverState *bs, int64_t offset, int64_t bytes,
         return -ENOMEDIUM;
     }
 
+    if (bs->open_flags & BDRV_O_NO_FLUSH) {
+        flags &= ~BDRV_REQ_FUA;
+    }
+
     if ((flags & BDRV_REQ_FUA) &&
         (~bs->supported_write_flags & BDRV_REQ_FUA)) {
         flags &= ~BDRV_REQ_FUA;
-- 
2.48.1


