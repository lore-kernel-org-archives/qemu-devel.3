Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE180D15DB7
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 16:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2v8p-0004MN-EW; Mon, 21 Oct 2024 12:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t2v8b-0004EM-5i
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:20:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t2v8Z-00046W-KY
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729527606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GoJ5T5zTaGkVLgCxaIyOEr8Aae1wNXSL4zr8S1ojULU=;
 b=BqCWHbsxtvLhMAeEZ90PR98aRnLdJGRoVtD4FJjuBmDJr/FbFX5NNTERMlulRRjgDo+BBj
 l49E9wg6s0sL5TohYg7FIK3aPmFAUno16rG7rbUaf0hvYASLRHMRyQuV9dj6YtI8/2Xv4F
 GxwJhrzytQE+WC6O1sg5QMqbqe8weFE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-320-r6XmpSpPPdySRxuruafjug-1; Mon,
 21 Oct 2024 12:20:05 -0400
X-MC-Unique: r6XmpSpPPdySRxuruafjug-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A4E9F1955EB3
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 16:20:04 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.27])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4F0371956056; Mon, 21 Oct 2024 16:20:03 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 2/6] ui/vnc: don't raise error formatting socket address for
 non-inet
Date: Mon, 21 Oct 2024 17:19:53 +0100
Message-ID: <20241021161957.1431919-3-berrange@redhat.com>
In-Reply-To: <20241021161957.1431919-1-berrange@redhat.com>
References: <20241021161957.1431919-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The SASL library requires the connection's local & remote IP address to
be passed in, since some mechanism may use this information. Currently
QEMU raises an error for non-inet sockets, but it is valid to pass NULL
to the SASL library. Doing so makes SASL work on UNIX sockets.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 ui/vnc-auth-sasl.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/ui/vnc-auth-sasl.c b/ui/vnc-auth-sasl.c
index 7d9ca9e8ac..edf19deb3b 100644
--- a/ui/vnc-auth-sasl.c
+++ b/ui/vnc-auth-sasl.c
@@ -524,13 +524,13 @@ static int protocol_client_auth_sasl_mechname_len(VncState *vs, uint8_t *data, s
     return 0;
 }
 
-static char *
+static int
 vnc_socket_ip_addr_string(QIOChannelSocket *ioc,
                           bool local,
+                          char **addrstr,
                           Error **errp)
 {
     SocketAddress *addr;
-    char *ret;
 
     if (local) {
         addr = qio_channel_socket_get_local_address(ioc, errp);
@@ -538,17 +538,17 @@ vnc_socket_ip_addr_string(QIOChannelSocket *ioc,
         addr = qio_channel_socket_get_remote_address(ioc, errp);
     }
     if (!addr) {
-        return NULL;
+        return -1;
     }
 
     if (addr->type != SOCKET_ADDRESS_TYPE_INET) {
-        error_setg(errp, "Not an inet socket type");
+        *addrstr = NULL;
         qapi_free_SocketAddress(addr);
-        return NULL;
+        return 0;
     }
-    ret = g_strdup_printf("%s;%s", addr->u.inet.host, addr->u.inet.port);
+    *addrstr = g_strdup_printf("%s;%s", addr->u.inet.host, addr->u.inet.port);
     qapi_free_SocketAddress(addr);
-    return ret;
+    return 0;
 }
 
 void start_auth_sasl(VncState *vs)
@@ -561,15 +561,15 @@ void start_auth_sasl(VncState *vs)
     int mechlistlen;
 
     /* Get local & remote client addresses in form  IPADDR;PORT */
-    localAddr = vnc_socket_ip_addr_string(vs->sioc, true, &local_err);
-    if (!localAddr) {
+    if (vnc_socket_ip_addr_string(vs->sioc, true,
+                                  &localAddr, &local_err) < 0) {
         trace_vnc_auth_fail(vs, vs->auth, "Cannot format local IP",
                             error_get_pretty(local_err));
         goto authabort;
     }
 
-    remoteAddr = vnc_socket_ip_addr_string(vs->sioc, false, &local_err);
-    if (!remoteAddr) {
+    if (vnc_socket_ip_addr_string(vs->sioc, false,
+                                  &remoteAddr, &local_err) < 0) {
         trace_vnc_auth_fail(vs, vs->auth, "Cannot format remote IP",
                             error_get_pretty(local_err));
         g_free(localAddr);
-- 
2.46.0


