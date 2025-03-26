Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC8EC36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 18:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txVZl-00020A-7e; Wed, 26 Mar 2025 14:34:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1txVZi-0001z1-VG
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 14:34:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1txVZe-0003VL-73
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 14:34:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743014036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q9h1zX98YS130jYQiPMScS8WZnfv2PtTKZLY6/1Rdik=;
 b=NGbGz4THjac1bGR8pIik0uJ07JdL5WSTmpjr2wNieMDiWl1kc6nqO3L9Cv/IJDWVYnQlTm
 wXOFl+3hGM5IUfjaYszSMyPQmOauChet44+X/yp3mQ+Kx3+VE6GIfP6a0wMSXfNNdpC/64
 iR2uWl0RWU/346CE9EhzJdxyMZf8P40=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-307-gi90J0f2O0KvtyQCQbFA-g-1; Wed,
 26 Mar 2025 14:33:51 -0400
X-MC-Unique: gi90J0f2O0KvtyQCQbFA-g-1
X-Mimecast-MFC-AGG-ID: gi90J0f2O0KvtyQCQbFA-g_1743014030
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 08A311800260; Wed, 26 Mar 2025 18:33:50 +0000 (UTC)
Received: from localhost (unknown [10.2.16.113])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 08CDC1801751; Wed, 26 Mar 2025 18:33:47 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: [PATCH 2/4] tests/unit: skip test-nested-aio-poll with io_uring
Date: Wed, 26 Mar 2025 14:33:38 -0400
Message-ID: <20250326183340.1010531-3-stefanha@redhat.com>
In-Reply-To: <20250326183340.1010531-1-stefanha@redhat.com>
References: <20250326183340.1010531-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

test-nested-aio-poll relies on internal details of how fdmon-poll.c
handles AioContext polling. Skip it when other fdmon implementations are
in use.

Note that this test is only built on POSIX systems so it is safe to
include "util/aio-posix.h".

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/unit/test-nested-aio-poll.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/unit/test-nested-aio-poll.c b/tests/unit/test-nested-aio-poll.c
index d8fd92c43b..45484e745b 100644
--- a/tests/unit/test-nested-aio-poll.c
+++ b/tests/unit/test-nested-aio-poll.c
@@ -15,6 +15,7 @@
 #include "qemu/osdep.h"
 #include "block/aio.h"
 #include "qapi/error.h"
+#include "util/aio-posix.h"
 
 typedef struct {
     AioContext *ctx;
@@ -71,6 +72,12 @@ static void test(void)
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
-- 
2.49.0


