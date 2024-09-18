Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2EA8CDD560
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 23:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr44I-0004Qo-Gj; Wed, 18 Sep 2024 19:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1sr44F-0004PN-WC
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 19:26:40 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1sr44D-00076Z-0i
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 19:26:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=/AzXOTog6JSFPIQeZ6YWfUHgDT42rlTKecRlLONwMdw=; b=N9K0E9WSMpI5JTwf
 OSVc7RytBGP7foei4l4Cv2s09awECD6o8WrPSn1F55fX+v3qw4SJr4HF2NA4GYYGZE7RV3MKSwKVu
 HSVoAQoKTPZqEN5RWYSS9gaRJ59/py9MNpQmu+zy/IYp5EfoHYq8X8d8xMWgKtvz+oItBsikhsCUo
 asRRSq1SSJND5ZvjjBHH7ljUfXe7N62MA23VLJ0OFm3Iw8st6Je/AKk5pkmmZ1hXBvYKYluytXzwU
 AsFbxkrUOL5Zc9or54G0wjvH1XaM+bFFTUPmIgArFJFlvb8hc4T9TVqt2zoBCtxWfjA5UY7Uu2Jd0
 GpGzn63Ou3uugMrCgA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <dave@treblig.org>) id 1sr44A-006LyH-1S;
 Wed, 18 Sep 2024 23:26:34 +0000
From: dave@treblig.org
To: berrange@redhat.com,
	qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH] sockets: Remove deadcode
Date: Thu, 19 Sep 2024 00:26:33 +0100
Message-ID: <20240918232633.463861-1-dave@treblig.org>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dave@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


