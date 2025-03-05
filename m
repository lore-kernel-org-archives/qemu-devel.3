Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC23C28B23
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 23:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpxoS-0007KZ-4q; Wed, 05 Mar 2025 18:06:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tpxoQ-0007Hg-9f
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 18:06:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tpxoO-0000Cq-90
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 18:06:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741215959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i9l/lI8uB4ISWuy9MK5PFCYsUvJZEkpx1O7spZoc6BU=;
 b=fbvozqHw7wzdR2qB1/d4hGdNaGXDvqJWv1GVLVh7v7kKBZnxLfKqZv6Kwxew9Uc1+b4fPq
 lwn0lqmEnhujV6J5McXcn1R0gfawjgJi7mjcc2KlhN8MeWgCY7Fqzr1IGBp0KgI+W47wP5
 gCT5/y7zEYcGrFBBhmUhkCV7QfnUC7A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-yU595C9SOA2_9z-j9OTpWA-1; Wed,
 05 Mar 2025 18:05:56 -0500
X-MC-Unique: yU595C9SOA2_9z-j9OTpWA-1
X-Mimecast-MFC-AGG-ID: yU595C9SOA2_9z-j9OTpWA_1741215955
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A717B1801A03; Wed,  5 Mar 2025 23:05:54 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.105])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 726E31955DCE; Wed,  5 Mar 2025 23:05:53 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PULL 4/4] nbd: Defer trace init until after daemonization
Date: Wed,  5 Mar 2025 17:05:24 -0600
Message-ID: <20250305230542.2225013-10-eblake@redhat.com>
In-Reply-To: <20250305230542.2225013-6-eblake@redhat.com>
References: <20250305230542.2225013-6-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

At least the simple trace backend works by spawning a helper thread,
and setting up an atexit() handler that coordinates completion with
the helper thread.  But since atexit registrations survive fork() but
helper threads do not, this means that qemu-nbd configured to use the
simple trace will deadlock waiting for a thread that no longer exists
when it has daemonized.

Better is to follow the example of vl.c: don't call any setup
functions that might spawn helper threads until we are in the final
process that will be doing the work worth tracing.

Tested by configuring with --enable-trace-backends=simple, then running
  qemu-nbd --fork --trace=nbd_\*,file=qemu-nbd.trace -f raw -r README.rst
followed by `nbdinfo nbd://localhost`, and observing that the trace
file is now created without hanging.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-ID: <20250227220625.870246-2-eblake@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 qemu-nbd.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index 05b61da51ea..ed5895861bb 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -852,10 +852,6 @@ int main(int argc, char **argv)
         export_name = "";
     }

-    if (!trace_init_backends()) {
-        exit(1);
-    }
-    trace_init_file();
     qemu_set_log(LOG_TRACE, &error_fatal);

     socket_activation = check_socket_activation();
@@ -1045,6 +1041,18 @@ int main(int argc, char **argv)
 #endif /* WIN32 */
     }

+    /*
+     * trace_init must be done after daemonization.  Why? Because at
+     * least the simple backend spins up a helper thread as well as an
+     * atexit() handler that waits on that thread, but the helper
+     * thread won't survive a fork, leading to deadlock in the child
+     * if we initialized pre-fork.
+     */
+    if (!trace_init_backends()) {
+        exit(1);
+    }
+    trace_init_file();
+
     if (opts.device != NULL && sockpath == NULL) {
         sockpath = g_malloc(128);
         snprintf(sockpath, 128, SOCKET_PATH, basename(opts.device));
-- 
2.48.1


