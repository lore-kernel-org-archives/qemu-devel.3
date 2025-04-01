Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75CD7C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 14:32:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzcdv-0006nY-PN; Tue, 01 Apr 2025 10:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tzcdu-0006mG-Ba
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 10:31:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tzcds-0005w1-N6
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 10:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743517863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6CAouPoxIin2lsECIDIbkUGDCD+ZxPN1iRQDMmNKmNk=;
 b=Ei6feG4nGMO4rbUr0a7Kk3/I4o6p7hyCm5ztkE82h6VnBBhgs9w5wDVNC6BwdBvYNfkLVR
 P8N8pvoMCrG6pxAx4E+y7J2Stlt+EmgZmBftT1y0LA1xfEgNrCEhvxzDEQATEQ6TxRC9pj
 BGDfesxqGmipHnw9fXTeSWK51L9MaL8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-_9WJQ_xJO1OmcHme8BdZpQ-1; Tue,
 01 Apr 2025 10:30:59 -0400
X-MC-Unique: _9WJQ_xJO1OmcHme8BdZpQ-1
X-Mimecast-MFC-AGG-ID: _9WJQ_xJO1OmcHme8BdZpQ_1743517858
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A52EE180AF4C; Tue,  1 Apr 2025 14:30:58 +0000 (UTC)
Received: from localhost (unknown [10.2.16.38])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E50601801747; Tue,  1 Apr 2025 14:30:57 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Aarushi Mehta <mehta.aaru20@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, surajshirvankar@gmail.com,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: [PATCH 1/3] aio-posix: treat io_uring setup failure as fatal
Date: Tue,  1 Apr 2025 10:27:19 -0400
Message-ID: <20250401142721.280287-2-stefanha@redhat.com>
In-Reply-To: <20250401142721.280287-1-stefanha@redhat.com>
References: <20250401142721.280287-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

In the early days of io_uring it was possible for io_uring_setup(2) to
fail due to exhausting RLIMIT_MEMLOCK. QEMU's solution was to fall back
to epoll(7) or ppoll(2) when io_uring could not be used in an
AioContext.

Nowadays io_uring memory is accounted differently so io_uring_setup(2)
won't fail. Treat failure as a fatal error. Keep it simple: io_uring is
available if and only if CONFIG_LINUX_IO_URING is defined.

Upcoming features that rely on io_uring won't need to handle the case
where a subset of AioContexts lacks io_uring. This will simplify the
aio_add_sqe() API introduced in the next commit.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 util/fdmon-io_uring.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
index 2092d08d24..18b33a0370 100644
--- a/util/fdmon-io_uring.c
+++ b/util/fdmon-io_uring.c
@@ -45,6 +45,7 @@
 
 #include "qemu/osdep.h"
 #include <poll.h>
+#include "qemu/error-report.h"
 #include "qemu/rcu_queue.h"
 #include "aio-posix.h"
 
@@ -369,7 +370,8 @@ bool fdmon_io_uring_setup(AioContext *ctx)
 
     ret = io_uring_queue_init(FDMON_IO_URING_ENTRIES, &ctx->fdmon_io_uring, 0);
     if (ret != 0) {
-        return false;
+        error_report("failed to initialize io_uring: %s", strerror(-ret));
+        exit(EXIT_FAILURE);
     }
 
     QSLIST_INIT(&ctx->submit_list);
-- 
2.49.0


