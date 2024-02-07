Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ADA3C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 21:58:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXpu1-0006yy-Az; Wed, 07 Feb 2024 16:56:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rXpty-0006vt-Ex
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 16:56:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rXptw-0007bB-56
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 16:56:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707342975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eX14L0szIJbf5c1V1hIwg1QL4t2eiWi0Bn+lvuojEGM=;
 b=aUyL4yo4g0T0m1EQ6fzNBzUfkd+fUT/aApHUtUHPpblEw94A6gfgDa0y2ALe3GIJxOsTec
 TKHMvsRKEwcdBT3urlCS5kVqCwAUM7BGoc66tmkKcczl2Dk97k7foIRFh9N43DnsAU1o18
 3ITOhi+6W+RnGeXwOSH6WfJsDv9QfiA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-ApyfVsc3NrOAQU8qmjxpyA-1; Wed, 07 Feb 2024 16:56:14 -0500
X-MC-Unique: ApyfVsc3NrOAQU8qmjxpyA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AF8B1101FA2A;
 Wed,  7 Feb 2024 21:56:13 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.192.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 22BE8492BC6;
 Wed,  7 Feb 2024 21:56:13 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 05/16] monitor: use aio_co_reschedule_self()
Date: Wed,  7 Feb 2024 22:55:55 +0100
Message-ID: <20240207215606.206038-6-kwolf@redhat.com>
In-Reply-To: <20240207215606.206038-1-kwolf@redhat.com>
References: <20240207215606.206038-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The aio_co_reschedule_self() API is designed to avoid the race
condition between scheduling the coroutine in another AioContext and
yielding.

The QMP dispatch code uses the open-coded version that appears
susceptible to the race condition at first glance:

  aio_co_schedule(qemu_get_aio_context(), qemu_coroutine_self());
  qemu_coroutine_yield();

The code is actually safe because the iohandler and qemu_aio_context
AioContext run under the Big QEMU Lock. Nevertheless, set a good example
and use aio_co_reschedule_self() so it's obvious that there is no race.

Suggested-by: Hanna Reitz <hreitz@redhat.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20240206190610.107963-6-stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/qmp-dispatch.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 176b549473..f3488afeef 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -212,8 +212,7 @@ QDict *coroutine_mixed_fn qmp_dispatch(const QmpCommandList *cmds, QObject *requ
              * executing the command handler so that it can make progress if it
              * involves an AIO_WAIT_WHILE().
              */
-            aio_co_schedule(qemu_get_aio_context(), qemu_coroutine_self());
-            qemu_coroutine_yield();
+            aio_co_reschedule_self(qemu_get_aio_context());
         }
 
         monitor_set_cur(qemu_coroutine_self(), cur_mon);
@@ -227,9 +226,7 @@ QDict *coroutine_mixed_fn qmp_dispatch(const QmpCommandList *cmds, QObject *requ
              * Move back to iohandler_ctx so that nested event loops for
              * qemu_aio_context don't start new monitor commands.
              */
-            aio_co_schedule(iohandler_get_aio_context(),
-                            qemu_coroutine_self());
-            qemu_coroutine_yield();
+            aio_co_reschedule_self(iohandler_get_aio_context());
         }
     } else {
        /*
-- 
2.43.0


