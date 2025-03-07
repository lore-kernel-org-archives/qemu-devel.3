Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A487EC28B28
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 22:17:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqg0U-0002DZ-QZ; Fri, 07 Mar 2025 17:17:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tqg05-0001v4-Bf
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:17:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tqg02-0007oz-OU
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:17:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741385818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EVbiYipccsLmBbLc7DH923fS89CDAwHcTdukc84RR4Y=;
 b=YYL/bnkGMOdUlVY6hxGVsQrhPQoALl4Det8hoH9l2mGLPugrg39UUn/VVtV5Ig2tuDSXnO
 hi4e31aOa1e7cmtiLPV/u6DN9bwBvoTvO9epUsJc3+GoxdR6Ng98XJSaGIeeeUybIgC890
 JFhytOnxGjOrJlW/Qsgb6eq+WAN53K0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-fCezoiiwPPGs7yNOFZB_Pg-1; Fri,
 07 Mar 2025 17:16:55 -0500
X-MC-Unique: fCezoiiwPPGs7yNOFZB_Pg-1
X-Mimecast-MFC-AGG-ID: fCezoiiwPPGs7yNOFZB_Pg_1741385814
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 21A2A19560BC; Fri,  7 Mar 2025 22:16:54 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.45.226.27])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B81D018009BC; Fri,  7 Mar 2025 22:16:51 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
 afaria@redhat.com, hreitz@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 2/5] block/io: Ignore FUA with cache.no-flush=on
Date: Fri,  7 Mar 2025 23:16:31 +0100
Message-ID: <20250307221634.71951-3-kwolf@redhat.com>
In-Reply-To: <20250307221634.71951-1-kwolf@redhat.com>
References: <20250307221634.71951-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

For block drivers that don't advertise FUA support, we already call
bdrv_co_flush(), which considers BDRV_O_NO_FLUSH. However, drivers that
do support FUA still see the FUA flag with BDRV_O_NO_FLUSH and get the
associated performance penalty that cache.no-flush=on was supposed to
avoid.

Clear FUA for write requests if BDRV_O_NO_FLUSH is set.

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


