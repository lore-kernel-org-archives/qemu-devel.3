Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DEB7C4829B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 09:15:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZSOj-0006Kf-U3; Mon, 12 Feb 2024 04:14:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rZSOh-0006Jb-QQ
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 04:14:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rZSOf-0003cF-Ix
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 04:14:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707729280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sChcT7b2TiVLT8qxZYr+04CBbhZ3+fDCd5lDSnyMXp0=;
 b=PbXit9AiE9Bep3m/x+xrH2LB2wvTgqrKXDtoy9i3zMz3jXy6sJrqN4+yY9MB64vNbu6D+C
 fFdQUxhaY80T+ys/woq6Az9D7SPJYSvz3/f4dwb5OKKesdpz2wnLJyH69ktvtTKASaZfvO
 C7ICAE21UAbikNPcNdSlws60809jPEg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-lPca7JAuOSunEambEZgHoQ-1; Mon, 12 Feb 2024 04:14:39 -0500
X-MC-Unique: lPca7JAuOSunEambEZgHoQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3069C83B86F;
 Mon, 12 Feb 2024 09:14:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E50974158C22;
 Mon, 12 Feb 2024 09:14:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9C27A21E5A58; Mon, 12 Feb 2024 10:14:36 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 13/18] qapi: Improve documentation of file descriptor socket
 addresses
Date: Mon, 12 Feb 2024 10:14:31 +0100
Message-ID: <20240212091436.688598-14-armbru@redhat.com>
In-Reply-To: <20240212091436.688598-1-armbru@redhat.com>
References: <20240212091436.688598-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.677,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

SocketAddress branch @fd is documented in enum SocketAddressType,
unlike the other branches.  That's because the branch's type is String
from common.json.

Use a local copy of String, so we can put the documentation in the
usual place.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240205074709.3613229-14-armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qapi/sockets.json                      | 40 +++++++++++++++++---------
 include/hw/virtio/vhost-vsock-common.h |  1 +
 chardev/char-socket.c                  |  2 +-
 util/qemu-sockets.c                    |  3 +-
 4 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/qapi/sockets.json b/qapi/sockets.json
index c3b616731d..5e6af5504d 100644
--- a/qapi/sockets.json
+++ b/qapi/sockets.json
@@ -5,8 +5,6 @@
 # = Socket data types
 ##
 
-{ 'include': 'common.json' }
-
 ##
 # @NetworkAddressFamily:
 #
@@ -116,6 +114,24 @@
     'cid': 'str',
     'port': 'str' } }
 
+##
+# @FdSocketAddress:
+#
+# A file descriptor name or number.
+#
+# @str: decimal is for file descriptor number, otherwise it's a file
+#     descriptor name.  Named file descriptors are permitted in
+#     monitor commands, in combination with the 'getfd' command.
+#     Decimal file descriptors are permitted at startup or other
+#     contexts where no monitor context is active.
+#
+#
+# Since: 1.2
+##
+{ 'struct': 'FdSocketAddress',
+  'data': {
+    'str': 'str' } }
+
 ##
 # @InetSocketAddressWrapper:
 #
@@ -147,12 +163,14 @@
   'data': { 'data': 'VsockSocketAddress' } }
 
 ##
-# @StringWrapper:
+# @FdSocketAddressWrapper:
+#
+# @data: file descriptor name or number
 #
 # Since: 1.3
 ##
-{ 'struct': 'StringWrapper',
-  'data': { 'data': 'String' } }
+{ 'struct': 'FdSocketAddressWrapper',
+  'data': { 'data': 'FdSocketAddress' } }
 
 ##
 # @SocketAddressLegacy:
@@ -173,7 +191,7 @@
     'inet': 'InetSocketAddressWrapper',
     'unix': 'UnixSocketAddressWrapper',
     'vsock': 'VsockSocketAddressWrapper',
-    'fd': 'StringWrapper' } }
+    'fd': 'FdSocketAddressWrapper' } }
 
 ##
 # @SocketAddressType:
@@ -186,11 +204,7 @@
 #
 # @vsock: VMCI address
 #
-# @fd: decimal is for file descriptor number, otherwise a file
-#     descriptor name.  Named file descriptors are permitted in
-#     monitor commands, in combination with the 'getfd' command.
-#     Decimal file descriptors are permitted at startup or other
-#     contexts where no monitor context is active.
+# @fd: Socket file descriptor
 #
 # Since: 2.9
 ##
@@ -200,7 +214,7 @@
 ##
 # @SocketAddress:
 #
-# Captures the address of a socket, which could also be a named file
+# Captures the address of a socket, which could also be a socket file
 # descriptor
 #
 # @type: Transport type
@@ -213,4 +227,4 @@
   'data': { 'inet': 'InetSocketAddress',
             'unix': 'UnixSocketAddress',
             'vsock': 'VsockSocketAddress',
-            'fd': 'String' } }
+            'fd': 'FdSocketAddress' } }
diff --git a/include/hw/virtio/vhost-vsock-common.h b/include/hw/virtio/vhost-vsock-common.h
index 93c782101d..75a74e8a99 100644
--- a/include/hw/virtio/vhost-vsock-common.h
+++ b/include/hw/virtio/vhost-vsock-common.h
@@ -11,6 +11,7 @@
 #ifndef QEMU_VHOST_VSOCK_COMMON_H
 #define QEMU_VHOST_VSOCK_COMMON_H
 
+#include "qapi/qapi-types-common.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/vhost.h"
 #include "qom/object.h"
diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 73947da188..ff8f845cca 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -1504,7 +1504,7 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
         };
     } else {
         addr->type = SOCKET_ADDRESS_TYPE_FD;
-        addr->u.fd.data = g_new(String, 1);
+        addr->u.fd.data = g_new(FdSocketAddress, 1);
         addr->u.fd.data->str = g_strdup(fd);
     }
     sock->addr = addr;
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 83e84b1186..60c44b2b56 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -1464,7 +1464,8 @@ SocketAddress *socket_address_flatten(SocketAddressLegacy *addr_legacy)
         break;
     case SOCKET_ADDRESS_TYPE_FD:
         addr->type = SOCKET_ADDRESS_TYPE_FD;
-        QAPI_CLONE_MEMBERS(String, &addr->u.fd, addr_legacy->u.fd.data);
+        QAPI_CLONE_MEMBERS(FdSocketAddress, &addr->u.fd,
+                           addr_legacy->u.fd.data);
         break;
     default:
         abort();
-- 
2.43.0


