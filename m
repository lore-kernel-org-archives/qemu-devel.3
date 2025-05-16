Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 020E6C54754
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 15:58:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFxRZ-0008RJ-3y; Fri, 16 May 2025 11:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uFxRX-0008Qu-EE
 for qemu-devel@nongnu.org; Fri, 16 May 2025 11:57:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uFxRV-0002cr-P6
 for qemu-devel@nongnu.org; Fri, 16 May 2025 11:57:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747411069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=py+TZoPFweDXa675c5l/OIWhVyVWlz3r43R1tVyvdH0=;
 b=AVajkAQ8l/1MlILyTXIvxZRkw1D3jmtiOOVOr5Md9MTQDg+1YnZ80XldZhZyaCCb1swlHl
 Hfz6ASE9rwqTki6DlQriXs0srwoj/La+W8NwnynyaJrUIgX+m6dCFZTqAmqgEvpZI8YNpB
 D7SVugFEXjAYYqQcO7dgOVw9gv4//SM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-318-YOvTP7OTM0SaAr4U16CjxA-1; Fri,
 16 May 2025 11:57:47 -0400
X-MC-Unique: YOvTP7OTM0SaAr4U16CjxA-1
X-Mimecast-MFC-AGG-ID: YOvTP7OTM0SaAr4U16CjxA_1747411066
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 48CD01956096; Fri, 16 May 2025 15:57:46 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.2.64])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AB6CE180045B; Fri, 16 May 2025 15:57:44 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, vsementsov@yandex-team.ru,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 3/7] util/qemu-sockets: Refactor success and failure paths
 in inet_listen_saddr()
Date: Fri, 16 May 2025 17:56:55 +0200
Message-ID: <20250516155710.2246148-4-jmarcin@redhat.com>
In-Reply-To: <20250516155710.2246148-1-jmarcin@redhat.com>
References: <20250516155710.2246148-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Juraj Marcin <jmarcin@redhat.com>

To get a listening socket, we need to first create a socket, try binding
it to a certain port, and lastly starting listening to it. Each of these
operations can fail due to various reasons, one of them being that the
requested address/port is already in use. In such case, the function
tries the same process with a new port number.

This patch refactors the port number loop, so the success path is no
longer buried inside the 'if' statements in the middle of the loop. Now,
the success path is not nested and ends at the end of the iteration
after successful socket creation, binding, and listening. In case any of
the operations fails, it either continues to the next iteration (and the
next port) or jumps out of the loop to handle the error and exits the
function.

Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 util/qemu-sockets.c | 51 ++++++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 4a878e0527..329fdbfd97 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -303,11 +303,20 @@ static int inet_listen_saddr(InetSocketAddress *saddr,
         port_min = inet_getport(e);
         port_max = saddr->has_to ? saddr->to + port_offset : port_min;
         for (p = port_min; p <= port_max; p++) {
+            if (slisten >= 0) {
+                /*
+                 * We have a socket we tried with the previous port. It cannot
+                 * be rebound, we need to close it and create a new one.
+                 */
+                close(slisten);
+                slisten = -1;
+            }
             inet_setport(e, p);
 
             slisten = create_fast_reuse_socket(e);
             if (slisten < 0) {
-                /* First time we expect we might fail to create the socket
+                /*
+                 * First time we expect we might fail to create the socket
                  * eg if 'e' has AF_INET6 but ipv6 kmod is not loaded.
                  * Later iterations should always succeed if first iteration
                  * worked though, so treat that as fatal.
@@ -317,40 +326,38 @@ static int inet_listen_saddr(InetSocketAddress *saddr,
                 } else {
                     error_setg_errno(errp, errno,
                                      "Failed to recreate failed listening socket");
-                    goto listen_failed;
+                    goto fail;
                 }
             }
             socket_created = true;
 
             rc = try_bind(slisten, saddr, e);
             if (rc < 0) {
-                if (errno != EADDRINUSE) {
-                    error_setg_errno(errp, errno, "Failed to bind socket");
-                    goto listen_failed;
+                if (errno == EADDRINUSE) {
+                    /* This port is already used, try the next one */
+                    continue;
                 }
-            } else {
-                if (!listen(slisten, num)) {
-                    goto listen_ok;
-                }
-                if (errno != EADDRINUSE) {
-                    error_setg_errno(errp, errno, "Failed to listen on socket");
-                    goto listen_failed;
+                error_setg_errno(errp, errno, "Failed to bind socket");
+                goto fail;
+            }
+            if (listen(slisten, num)) {
+                if (errno == EADDRINUSE) {
+                    /* This port is already used, try the next one */
+                    continue;
                 }
+                error_setg_errno(errp, errno, "Failed to listen on socket");
+                goto fail;
             }
-            /* Someone else managed to bind to the same port and beat us
-             * to listen on it! Socket semantics does not allow us to
-             * recover from this situation, so we need to recreate the
-             * socket to allow bind attempts for subsequent ports:
-             */
-            close(slisten);
-            slisten = -1;
+            /* We have a listening socket */
+            freeaddrinfo(res);
+            return slisten;
         }
     }
     error_setg_errno(errp, errno,
                      socket_created ?
                      "Failed to find an available port" :
                      "Failed to create a socket");
-listen_failed:
+fail:
     saved_errno = errno;
     if (slisten >= 0) {
         close(slisten);
@@ -358,10 +365,6 @@ listen_failed:
     freeaddrinfo(res);
     errno = saved_errno;
     return -1;
-
-listen_ok:
-    freeaddrinfo(res);
-    return slisten;
 }
 
 #ifdef _WIN32
-- 
2.49.0


