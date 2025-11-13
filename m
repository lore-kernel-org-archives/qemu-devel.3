Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51BBCCD98FC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 22:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJgEa-0006uG-6I; Thu, 13 Nov 2025 17:56:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vJgEO-0006os-9O
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 17:55:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vJgEM-0000n0-Rb
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 17:55:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763074554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k8CkEpfl8NsRXR4tnIiCDb4pdCCDq7f+XLUgJBFp7aw=;
 b=S/3WQz8KbHSL+lN2l0yEzkmawP8IbQ3LvuCxK3cEYsEIAOx82fMkAFYxawx/W3x3bnfiYd
 f8URo09kPI+Gmfwt8fp5Ql3giIen9MNmcoHt+GRYG5U9Eo3egfeNKVDfv44sejSfLo+ho2
 nfY9y87HUQ/42bXswH7RbKgxCOfNaOk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-fmu_nLe6Po68VhZTPIOSag-1; Thu,
 13 Nov 2025 17:55:51 -0500
X-MC-Unique: fmu_nLe6Po68VhZTPIOSag-1
X-Mimecast-MFC-AGG-ID: fmu_nLe6Po68VhZTPIOSag_1763074551
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B2A518D95C7; Thu, 13 Nov 2025 22:55:50 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.22])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 27D9C1955F1B; Thu, 13 Nov 2025 22:55:49 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PULL 12/15] nbd: Avoid deadlock in client connecting to same-process
 server
Date: Thu, 13 Nov 2025 16:55:08 -0600
Message-ID: <20251113225531.1077484-29-eblake@redhat.com>
In-Reply-To: <20251113225531.1077484-17-eblake@redhat.com>
References: <20251113225531.1077484-17-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

See the previous patch for a longer description of the deadlock.  Now
that QIONetListener supports waiting for clients in the main loop
AioContext, NBD can use that to ensure that the server can make
progress even when a client is intentionally starving the GMainContext
from any activity not tied to an AioContext.

Note that command-line arguments and QMP commands like
nbd-server-start or nbd-server-stop that manipulate whether the NBD
server exists are serviced in the main loop; and therefore, this patch
does not fall foul of the restrictions in the previous patch about the
inherent unsafe race possible if a QIONetListener can have its async
callback modified by a different thread than the one servicing polls.

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/3169
Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20251113011625.878876-27-eblake@redhat.com>
---
 blockdev-nbd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 1e3e634b87d..696474aea93 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -94,10 +94,10 @@ static void nbd_update_server_watch(NBDServerData *s)
 {
     if (s->listener) {
         if (!s->max_connections || s->connections < s->max_connections) {
-            qio_net_listener_set_client_func(s->listener, nbd_accept, NULL,
+            qio_net_listener_set_client_aio_func(s->listener, nbd_accept, NULL,
                                              NULL);
         } else {
-            qio_net_listener_set_client_func(s->listener, NULL, NULL, NULL);
+            qio_net_listener_set_client_aio_func(s->listener, NULL, NULL, NULL);
         }
     }
 }
-- 
2.51.1


