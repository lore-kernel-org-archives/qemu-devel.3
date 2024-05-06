Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56174C25B4F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 19:07:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s43fr-00030w-Oc; Mon, 06 May 2024 15:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1s43fY-0002kK-RE
 for qemu-devel@nongnu.org; Mon, 06 May 2024 15:06:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1s43fX-0000B0-0T
 for qemu-devel@nongnu.org; Mon, 06 May 2024 15:06:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715022394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kKRKhnvbK/7eXO0y9aksHFlEplESZ1pbg0cA8AApavM=;
 b=gm+UIX0iE4S9NgyODEDBDDSVinPy9FzG2ckj4hpqPQmF57V0xcXRG3rQz8NZp053cEbzZp
 tm7xDygQW4uOpWwKc9ssZyIuthT4YlhIJSuGdVh+4y4BgXx7uHUjrU0ONBzIh+eTeaY7Ph
 0EQR2UP6zz1QTMd6xrY9+vzKyATiFU8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-352-u43OzzATN0art_CcYz9XTg-1; Mon,
 06 May 2024 15:06:28 -0400
X-MC-Unique: u43OzzATN0art_CcYz9XTg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 36BBE380008B;
 Mon,  6 May 2024 19:06:28 +0000 (UTC)
Received: from localhost (unknown [10.39.192.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BCBA91C060D1;
 Mon,  6 May 2024 19:06:26 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>
Subject: [PATCH 1/2] Revert "monitor: use aio_co_reschedule_self()"
Date: Mon,  6 May 2024 15:06:21 -0400
Message-ID: <20240506190622.56095-2-stefanha@redhat.com>
In-Reply-To: <20240506190622.56095-1-stefanha@redhat.com>
References: <20240506190622.56095-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Commit 1f25c172f837 ("monitor: use aio_co_reschedule_self()") was a code
cleanup that uses aio_co_reschedule_self() instead of open coding
coroutine rescheduling.

Bug RHEL-34618 was reported and Kevin Wolf <kwolf@redhat.com> identified
the root cause. I missed that aio_co_reschedule_self() ->
qemu_get_current_aio_context() only knows about
qemu_aio_context/IOThread AioContexts and not about iohandler_ctx. It
does not function correctly when going back from the iohandler_ctx to
qemu_aio_context.

Go back to open coding the AioContext transitions to avoid this bug.

This reverts commit 1f25c172f83704e350c0829438d832384084a74d.

Buglink: https://issues.redhat.com/browse/RHEL-34618
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 qapi/qmp-dispatch.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index f3488afeef..176b549473 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -212,7 +212,8 @@ QDict *coroutine_mixed_fn qmp_dispatch(const QmpCommandList *cmds, QObject *requ
              * executing the command handler so that it can make progress if it
              * involves an AIO_WAIT_WHILE().
              */
-            aio_co_reschedule_self(qemu_get_aio_context());
+            aio_co_schedule(qemu_get_aio_context(), qemu_coroutine_self());
+            qemu_coroutine_yield();
         }
 
         monitor_set_cur(qemu_coroutine_self(), cur_mon);
@@ -226,7 +227,9 @@ QDict *coroutine_mixed_fn qmp_dispatch(const QmpCommandList *cmds, QObject *requ
              * Move back to iohandler_ctx so that nested event loops for
              * qemu_aio_context don't start new monitor commands.
              */
-            aio_co_reschedule_self(iohandler_get_aio_context());
+            aio_co_schedule(iohandler_get_aio_context(),
+                            qemu_coroutine_self());
+            qemu_coroutine_yield();
         }
     } else {
        /*
-- 
2.45.0


