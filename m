Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE46ACCFA1A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 21:34:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIvzK-0006rB-4b; Tue, 11 Nov 2025 16:33:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vIvzI-0006qG-3r
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 16:33:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vIvzG-0001pY-Ka
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 16:33:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762896793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tab4CtFFHM98XVix6uSAQ4RulcmwiYQiWx2dY6YSd5o=;
 b=XLRv8fuqCY81Dlj+5dcV3P3yAfFeqiErNxHU7l08DT4QgVsBnzhqThC+HiffnQqY+Unmsg
 lP0PWilP5V2Lm477//PPBy4jrbfeTJ+AAVAQ6iRHFrtCyWhP1DOEitWiL06vdRp5AVr/sj
 NCAq9T//iv4G23CZYYCqudUXolkhr8E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-VAKwvjztNnubdZuUiTFtdQ-1; Tue,
 11 Nov 2025 16:33:11 -0500
X-MC-Unique: VAKwvjztNnubdZuUiTFtdQ-1
X-Mimecast-MFC-AGG-ID: VAKwvjztNnubdZuUiTFtdQ_1762896790
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D2CF819560B2; Tue, 11 Nov 2025 21:33:10 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.45.225.214])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 411B530044E0; Tue, 11 Nov 2025 21:33:08 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 05/28] tests/unit: skip test-nested-aio-poll with io_uring
Date: Tue, 11 Nov 2025 22:32:15 +0100
Message-ID: <20251111213238.181992-6-kwolf@redhat.com>
In-Reply-To: <20251111213238.181992-1-kwolf@redhat.com>
References: <20251111213238.181992-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

test-nested-aio-poll relies on internal details of how fdmon-poll.c
handles AioContext polling. Skip it when other fdmon implementations are
in use.

The reason why fdmon-io_uring.c behaves differently from fdmon-poll.c is
that its fdmon_ops->need_wait() function returns true when
io_uring_enter(2) must be called (e.g. to submit pending SQEs).
AioContext polling is skipped when ->need_wait() returns true, so the
test case will never enter AioContext polling mode with
fdmon-io_uring.c.

Restrict this test to fdmon-poll.c and drop the
aio_context_use_g_source() call since it's no longer necessary.

Note that this test is only built on POSIX systems so it is safe to
include "util/aio-posix.h".

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-ID: <20251104022933.618123-6-stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/unit/test-nested-aio-poll.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tests/unit/test-nested-aio-poll.c b/tests/unit/test-nested-aio-poll.c
index d8fd92c43b..d13ecccd8c 100644
--- a/tests/unit/test-nested-aio-poll.c
+++ b/tests/unit/test-nested-aio-poll.c
@@ -15,6 +15,7 @@
 #include "qemu/osdep.h"
 #include "block/aio.h"
 #include "qapi/error.h"
+#include "util/aio-posix.h"
 
 typedef struct {
     AioContext *ctx;
@@ -71,17 +72,17 @@ static void test(void)
         .ctx = aio_context_new(&error_abort),
     };
 
+    if (td.ctx->fdmon_ops != &fdmon_poll_ops) {
+        /* This test is tied to fdmon-poll.c */
+        g_test_skip("fdmon_poll_ops not in use");
+        return;
+    }
+
     qemu_set_current_aio_context(td.ctx);
 
     /* Enable polling */
     aio_context_set_poll_params(td.ctx, 1000000, 2, 2, &error_abort);
 
-    /*
-     * The GSource is unused but this has the side-effect of changing the fdmon
-     * that AioContext uses.
-     */
-    aio_get_g_source(td.ctx);
-
     /* Make the event notifier active (set) right away */
     event_notifier_init(&td.poll_notifier, 1);
     aio_set_event_notifier(td.ctx, &td.poll_notifier,
-- 
2.51.1


