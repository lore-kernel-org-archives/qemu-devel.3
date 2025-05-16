Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749D4C54756
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 15:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFxRY-0008RH-CL; Fri, 16 May 2025 11:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uFxRW-0008Qm-ON
 for qemu-devel@nongnu.org; Fri, 16 May 2025 11:57:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uFxRV-0002cn-9M
 for qemu-devel@nongnu.org; Fri, 16 May 2025 11:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747411068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zx/5finWrW3BE7soKnFMX10p0Eu9Wv9Ivwwng/VowTQ=;
 b=UY3VhwqbP1dcLODC9j2L2prciMs1kG9hp+gZWSj7jeCT+XFsh9hs1zNKaPWMI2iXfi3iNt
 HrgJiDhB5D2VrxaCEaiqP3T9eoJ//mp0PNnMiFYvLgsQb4mtBZiZnVicoAi8I2rvmu1iKn
 44wBmNcTf/bwZvJWjFDiX1U3oJswCqQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-SCBtfdGeNWmL4vl8qqWkFw-1; Fri,
 16 May 2025 11:57:45 -0400
X-MC-Unique: SCBtfdGeNWmL4vl8qqWkFw-1
X-Mimecast-MFC-AGG-ID: SCBtfdGeNWmL4vl8qqWkFw_1747411064
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 07AC619560A5; Fri, 16 May 2025 15:57:40 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.2.64])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6722018003FC; Fri, 16 May 2025 15:57:38 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, vsementsov@yandex-team.ru,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 2/7] util/qemu-sockets: Refactor setting client sockopts
 into a separate function
Date: Fri, 16 May 2025 17:56:54 +0200
Message-ID: <20250516155710.2246148-3-jmarcin@redhat.com>
In-Reply-To: <20250516155710.2246148-1-jmarcin@redhat.com>
References: <20250516155710.2246148-1-jmarcin@redhat.com>
MIME-Version: 1.0
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

This is done in preparation for enabling the SO_KEEPALIVE support for
server sockets and adding settings for more TCP keep-alive socket
options.

Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
---
 util/qemu-sockets.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 77477c1cd5..4a878e0527 100644
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
@@ -475,16 +491,9 @@ int inet_connect_saddr(InetSocketAddress *saddr, Error **errp)
         return sock;
     }
 
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
+    if (inet_set_sockopts(sock, saddr, errp) < 0) {
+        close(sock);
+        return -1;
     }
 
     return sock;
-- 
2.49.0


