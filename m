Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF698C54ED1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 10:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI3Ca-0004Kg-0Q; Thu, 22 May 2025 06:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uI3CI-0003i2-GU
 for qemu-devel@nongnu.org; Thu, 22 May 2025 06:30:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uI3CC-0006f6-SY
 for qemu-devel@nongnu.org; Thu, 22 May 2025 06:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747909839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LT8u+Odh24aw54w1xRgnLKb526I+ZLroJYzIr5dgjt0=;
 b=gFYoIdCXpDuqzr+3jjT5kIzQrp8+JY3W4NlLB/whHNkiuSCzlYSpSuuqSe9EFYYLPrY9i8
 Zxxq76aD4bOY4Shwc+Ug50xN84CH4L8OLTSRkkm1rv5tR1a+XqVa/Xl81EfJ4Q7OlurBRe
 r4xjFwxP3D/6mq68Uvan+GFBol9+nJA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-pupDLAsnPiKQYTOEDWEBwA-1; Thu,
 22 May 2025 06:30:35 -0400
X-MC-Unique: pupDLAsnPiKQYTOEDWEBwA-1
X-Mimecast-MFC-AGG-ID: pupDLAsnPiKQYTOEDWEBwA_1747909835
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EB71F195608B; Thu, 22 May 2025 10:30:34 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.179])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AE70C1958014; Thu, 22 May 2025 10:30:31 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 18/23] util/qemu-sockets: Refactor setting client sockopts into
 a separate function
Date: Thu, 22 May 2025 11:29:18 +0100
Message-ID: <20250522102923.309452-19-berrange@redhat.com>
In-Reply-To: <20250522102923.309452-1-berrange@redhat.com>
References: <20250522102923.309452-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
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
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
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


