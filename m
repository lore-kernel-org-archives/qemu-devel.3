Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6CD2C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 16:37:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuwQ1-0003LH-Uf; Wed, 19 Mar 2025 12:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1tuwPz-0003Ky-8l
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:37:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1tuwPw-00074a-Qf
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:37:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742402239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9cCbOJ8mvz3Zj848JTWlOw0zJAERCb8PEn3DO0/UAqo=;
 b=bm6HaqBIULAca0jwX1DmfLXHYsHtiKENwvfwT+y4uZRR1ufPtNjSiw4Ot78va4cc1EQjCp
 b/e1f+r06SKm7QYygNHYcx+pyfEB5wOe+EPsNyLpcUhBELw6EOrVdqk1kWmtFZMK2yLId4
 vvhgBMfVmC4YXY0O3H20s4ti8j+Wdu0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-356-P_Ki8wTLOrOX1SlcBHGQQg-1; Wed,
 19 Mar 2025 12:37:15 -0400
X-MC-Unique: P_Ki8wTLOrOX1SlcBHGQQg-1
X-Mimecast-MFC-AGG-ID: P_Ki8wTLOrOX1SlcBHGQQg_1742402235
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A93271809CA6; Wed, 19 Mar 2025 16:37:14 +0000 (UTC)
Received: from rh-jmarcin.redhat.com (unknown [10.45.225.145])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 95EDD1955BEE; Wed, 19 Mar 2025 16:37:12 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, vsementsov@yandex-team.ru,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 1/2] util/qemu-sockets: Add support for keep-alive flag to
 passive sockets
Date: Wed, 19 Mar 2025 17:36:19 +0100
Message-ID: <20250319163638.456417-2-jmarcin@redhat.com>
In-Reply-To: <20250319163638.456417-1-jmarcin@redhat.com>
References: <20250319163638.456417-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Commit aec21d3175 (qapi: Add InetSocketAddress member keep-alive)
introduces the keep-alive flag, which enables the SO_KEEPALIVE socket
option, but only on client-side sockets. However, this option is also
useful for server-side sockets, so they can check if a client is still
reachable or drop the connection otherwise.

This patch enables the SO_KEEPALIVE socket option on passive server-side
sockets if the keep-alive flag is enabled. This socket option is then
inherited by active server-side sockets communicating with connected
clients.

This patch also fixes an issue in 'qio_dns_resolver_lookup_sync_inet()'
where the keep-alive flag is not copied together with other attributes.

Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
---
 io/dns-resolver.c   |  2 ++
 qapi/sockets.json   |  4 ++--
 util/qemu-sockets.c | 52 +++++++++++++++++++++++++--------------------
 3 files changed, 33 insertions(+), 25 deletions(-)

diff --git a/io/dns-resolver.c b/io/dns-resolver.c
index 53b0e8407a..ee7403b65b 100644
--- a/io/dns-resolver.c
+++ b/io/dns-resolver.c
@@ -126,6 +126,8 @@ static int qio_dns_resolver_lookup_sync_inet(QIODNSResolver *resolver,
             .has_mptcp = iaddr->has_mptcp,
             .mptcp = iaddr->mptcp,
 #endif
+            .has_keep_alive = iaddr->has_keep_alive,
+            .keep_alive = iaddr->keep_alive,
         };
 
         (*addrs)[i] = newaddr;
diff --git a/qapi/sockets.json b/qapi/sockets.json
index 6a95023315..eb50f64e3a 100644
--- a/qapi/sockets.json
+++ b/qapi/sockets.json
@@ -56,8 +56,8 @@
 # @ipv6: whether to accept IPv6 addresses, default try both IPv4 and
 #     IPv6
 #
-# @keep-alive: enable keep-alive when connecting to this socket.  Not
-#     supported for passive sockets.  (Since 4.2)
+# @keep-alive: enable keep-alive when connecting to/listening on this socket.
+#     (Since 4.2, not supported for listening sockets until 10.0)
 #
 # @mptcp: enable multi-path TCP.  (Since 6.1)
 #
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 77477c1cd5..99357a4435 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -205,6 +205,22 @@ static int try_bind(int socket, InetSocketAddress *saddr, struct addrinfo *e)
 #endif
 }
 
+static int inet_set_sockopts(int sock, InetSocketAddress *saddr, Error **errp)
+{
+    if (saddr->keep_alive) {
+        int keep_alive = 1;
+        int ret = setsockopt(sock, SOL_SOCKET, SO_KEEPALIVE,
+                             &keep_alive, sizeof(keep_alive));
+
+        if (ret < 0) {
+            error_setg_errno(errp, errno,
+                             "Unable to set keep-alive option on socket");
+            return -1;
+        }
+    }
+    return 0;
+}
+
 static int inet_listen_saddr(InetSocketAddress *saddr,
                              int port_offset,
                              int num,
@@ -220,12 +236,6 @@ static int inet_listen_saddr(InetSocketAddress *saddr,
     int saved_errno = 0;
     bool socket_created = false;
 
-    if (saddr->keep_alive) {
-        error_setg(errp, "keep-alive option is not supported for passive "
-                   "sockets");
-        return -1;
-    }
-
     memset(&ai,0, sizeof(ai));
     ai.ai_flags = AI_PASSIVE;
     if (saddr->has_numeric && saddr->numeric) {
@@ -313,13 +323,18 @@ static int inet_listen_saddr(InetSocketAddress *saddr,
                     goto listen_failed;
                 }
             } else {
-                if (!listen(slisten, num)) {
+                if (listen(slisten, num)) {
+                    if (errno != EADDRINUSE) {
+                        error_setg_errno(errp, errno,
+                                         "Failed to listen on socket");
+                        goto listen_failed;
+                    }
+                } else {
+                    if (inet_set_sockopts(slisten, saddr, errp)) {
+                        goto listen_failed;
+                    }
                     goto listen_ok;
                 }
-                if (errno != EADDRINUSE) {
-                    error_setg_errno(errp, errno, "Failed to listen on socket");
-                    goto listen_failed;
-                }
             }
             /* Someone else managed to bind to the same port and beat us
              * to listen on it! Socket semantics does not allow us to
@@ -474,19 +489,10 @@ int inet_connect_saddr(InetSocketAddress *saddr, Error **errp)
         error_propagate(errp, local_err);
         return sock;
     }
-
-    if (saddr->keep_alive) {
-        int val = 1;
-        int ret = setsockopt(sock, SOL_SOCKET, SO_KEEPALIVE,
-                             &val, sizeof(val));
-
-        if (ret < 0) {
-            error_setg_errno(errp, errno, "Unable to set KEEPALIVE");
-            close(sock);
-            return -1;
-        }
+    if (inet_set_sockopts(sock, saddr, errp)) {
+        close(sock);
+        return -1;
     }
-
     return sock;
 }
 
-- 
2.48.1


