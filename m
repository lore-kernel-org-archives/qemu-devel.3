Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6195CD2C56A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 15:26:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3GkK-0007Ze-Sw; Tue, 22 Oct 2024 11:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t3GkJ-0007Vp-Pn
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 11:24:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t3GkI-0004xv-0X
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 11:24:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729610669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OTQ6oHWtR4o7XzRFPiGtn1wRQxJXoWFgPGHC0CJImaQ=;
 b=Tc9xo9MvmVks/RtyNPwe0kZM41OKLOtEG+Ai8j5cTK91zbhSFaohoQmJs/5Yuy/vRrMUl1
 VUnemcrr+JbP7Hqez6anddVWEv2z0C7B/1RjwDwHxj/UQku1ZMk89n43Kgq1s3c3g9o+im
 k7l/K89AaStUcWoomBchJ+XFtCN9Z9Q=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-382-NFQG_pXTPy2svcrGqJ4_8A-1; Tue,
 22 Oct 2024 11:24:26 -0400
X-MC-Unique: NFQG_pXTPy2svcrGqJ4_8A-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 208A91955D4C; Tue, 22 Oct 2024 15:24:25 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.59])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 75B2319560B2; Tue, 22 Oct 2024 15:24:22 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PULL 02/14] sockets: Remove deadcode
Date: Tue, 22 Oct 2024 16:24:03 +0100
Message-ID: <20241022152415.1632556-3-berrange@redhat.com>
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

socket_remote_address hasn't been used since it was added in
  17c55decec ("sockets: add helpers for creating SocketAddress from a socket")

inet_connect hasn't been used since 2017's
  8ecc2f9eab ("sheepdog: Use SocketAddress and socket_connect()")

Remove them.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qemu/sockets.h | 16 ----------------
 util/qemu-sockets.c    | 35 -----------------------------------
 2 files changed, 51 deletions(-)

diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
index d935fd80da..c562690d89 100644
--- a/include/qemu/sockets.h
+++ b/include/qemu/sockets.h
@@ -61,7 +61,6 @@ int socket_set_fast_reuse(int fd);
 int inet_ai_family_from_address(InetSocketAddress *addr,
                                 Error **errp);
 int inet_parse(InetSocketAddress *addr, const char *str, Error **errp);
-int inet_connect(const char *str, Error **errp);
 int inet_connect_saddr(InetSocketAddress *saddr, Error **errp);
 
 NetworkAddressFamily inet_netfamily(int family);
@@ -117,21 +116,6 @@ socket_sockaddr_to_address(struct sockaddr_storage *sa,
  */
 SocketAddress *socket_local_address(int fd, Error **errp);
 
-/**
- * socket_remote_address:
- * @fd: the socket file handle
- * @errp: pointer to uninitialized error object
- *
- * Get the string representation of the remote socket
- * address. A pointer to the allocated address information
- * struct will be returned, which the caller is required to
- * release with a call qapi_free_SocketAddress() when no
- * longer required.
- *
- * Returns: the socket address struct, or NULL on error
- */
-SocketAddress *socket_remote_address(int fd, Error **errp);
-
 /**
  * socket_address_flatten:
  * @addr: the socket address to flatten
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 60c44b2b56..c1b162b056 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -707,26 +707,6 @@ int inet_parse(InetSocketAddress *addr, const char *str, Error **errp)
 }
 
 
-/**
- * Create a blocking socket and connect it to an address.
- *
- * @str: address string
- * @errp: set in case of an error
- *
- * Returns -1 in case of error, file descriptor on success
- **/
-int inet_connect(const char *str, Error **errp)
-{
-    int sock = -1;
-    InetSocketAddress *addr = g_new(InetSocketAddress, 1);
-
-    if (!inet_parse(addr, str, errp)) {
-        sock = inet_connect_saddr(addr, errp);
-    }
-    qapi_free_InetSocketAddress(addr);
-    return sock;
-}
-
 #ifdef CONFIG_AF_VSOCK
 static bool vsock_parse_vaddr_to_sockaddr(const VsockSocketAddress *vaddr,
                                           struct sockaddr_vm *svm,
@@ -1421,21 +1401,6 @@ SocketAddress *socket_local_address(int fd, Error **errp)
 }
 
 
-SocketAddress *socket_remote_address(int fd, Error **errp)
-{
-    struct sockaddr_storage ss;
-    socklen_t sslen = sizeof(ss);
-
-    if (getpeername(fd, (struct sockaddr *)&ss, &sslen) < 0) {
-        error_setg_errno(errp, errno, "%s",
-                         "Unable to query remote socket address");
-        return NULL;
-    }
-
-    return socket_sockaddr_to_address(&ss, sslen, errp);
-}
-
-
 SocketAddress *socket_address_flatten(SocketAddressLegacy *addr_legacy)
 {
     SocketAddress *addr;
-- 
2.46.0


