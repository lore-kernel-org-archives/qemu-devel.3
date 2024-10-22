Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68419D2C56E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 15:27:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Gkg-0007ww-FL; Tue, 22 Oct 2024 11:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t3Gke-0007wa-OF
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 11:24:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t3Gkd-000515-Cz
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 11:24:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729610690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oGXtD59Wdl4rms+4dg7aanApiesZPcqhLbJOgYZq2lc=;
 b=VO98N8vD4Yg+RoBs/CJDjYH+T6I3OixCTJ9jifDognDa9s55kmXKg34jw4S2KsRQEi70K8
 fwpDQthXwkQkULy6dIXD6bzmO6z8wZIRzKljVQn2/LMyh78xqlpMTha0vi94+Z1eK+cdl7
 1tK4JuhOT5nCts/yMn7vdyrorLbqjVg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-Nb49rNgQNbudWibbO21aTQ-1; Tue,
 22 Oct 2024 11:24:46 -0400
X-MC-Unique: Nb49rNgQNbudWibbO21aTQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 698011977323; Tue, 22 Oct 2024 15:24:45 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.59])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3EDED1956046; Tue, 22 Oct 2024 15:24:43 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 09/14] ui/vnc: don't raise error formatting socket address for
 non-inet
Date: Tue, 22 Oct 2024 16:24:10 +0100
Message-ID: <20241022152415.1632556-10-berrange@redhat.com>
In-Reply-To: <20241022152415.1632556-1-berrange@redhat.com>
References: <20241022152415.1632556-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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


