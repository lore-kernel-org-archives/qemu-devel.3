Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A3D4EFD206
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 08:15:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvA21-0000R4-SM; Wed, 25 Feb 2026 03:14:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vvA20-0000MK-51
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 03:14:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vvA1y-0001nL-Tk
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 03:14:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772007242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=71PvqljC8jrcUr+AnYkZa4bsSGBsKYrIu/Noafc+YSg=;
 b=GZzdh6LB5igU5chUEJrjbZAgqB0uWF2Sll6pUtXzrCP+644yc5YyVgTSzf8K4QWeEshYGe
 EgtuRVW5vO507cnV3+s/GHBbKwtxXgbbXKIL0BHJyrJex5jRbBXmVZ7tYQ+lJPpMqqlDhJ
 eyIW5eaQqE42TmZdcxdrcoLeu0RA6kI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-_uU6tOYGOs-7poSEx_II9A-1; Wed,
 25 Feb 2026 03:13:58 -0500
X-MC-Unique: _uU6tOYGOs-7poSEx_II9A-1
X-Mimecast-MFC-AGG-ID: _uU6tOYGOs-7poSEx_II9A_1772007237
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 60A071800349; Wed, 25 Feb 2026 08:13:57 +0000 (UTC)
Received: from localhost (unknown [10.2.16.120])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6FDBC3003D88; Wed, 25 Feb 2026 08:13:56 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 4/4] aio-posix: enable IORING_SETUP_NO_SQARRAY
Date: Wed, 25 Feb 2026 16:13:36 +0800
Message-ID: <20260225081336.1639325-5-stefanha@redhat.com>
In-Reply-To: <20260225081336.1639325-1-stefanha@redhat.com>
References: <20260225081336.1639325-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This simplifies SQ ring processing and saves CPU cycles. A big
improvement is not expected, but it doesn't hurt to enable this flag.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 util/fdmon-io_uring.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
index 2e2c0e6785..99c4932937 100644
--- a/util/fdmon-io_uring.c
+++ b/util/fdmon-io_uring.c
@@ -469,6 +469,9 @@ bool fdmon_io_uring_setup(AioContext *ctx, Error **errp)
 #endif
 #ifdef IORING_SETUP_TASKRUN_FLAG
         IORING_SETUP_TASKRUN_FLAG |
+#endif
+#ifdef IORING_SETUP_NO_SQARRAY
+        IORING_SETUP_NO_SQARRAY |
 #endif
         0;
     int ret;
-- 
2.53.0


