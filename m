Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E342CC48291
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 07:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWtiA-0003Kw-Js; Mon, 05 Feb 2024 02:48:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rWthN-00033C-Qa
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 02:47:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rWthF-00063M-Ge
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 02:47:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707119236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/+Sr868r/4iV4NDQju9I19/S1X0MEXrwFr0PgrOCdX8=;
 b=aOQ2gB8VgS3UIjwuitdy0ENFnQb/y7d/2gXGs4oj5Wj4KOmjduLY3BCReXiMP4+E7zK+kH
 WfyVqr0iLlQmR9DROQJDSjPyVG4NqLjQ5A8HJBj40eS3X94f/TiykdyKhxlt3isj2XB4NQ
 OCDSC0oBrrCdXesD0L7fKv7No6ya7LY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401-p4hB8VYMPfiUKQJos57lng-1; Mon,
 05 Feb 2024 02:47:13 -0500
X-MC-Unique: p4hB8VYMPfiUKQJos57lng-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5530F1C5446A;
 Mon,  5 Feb 2024 07:47:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 136AF152F;
 Mon,  5 Feb 2024 07:47:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6AC3C21E5A47; Mon,  5 Feb 2024 08:47:09 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: arei.gonglei@huawei.com, armbru@redhat.com, berrange@redhat.com,
 eblake@redhat.com, eduardo@habkost.net, fan.ni@samsung.com,
 farosas@suse.de, hreitz@redhat.com, jasowang@redhat.com, jiri@resnulli.us,
 jonathan.cameron@huawei.com, kkostiuk@redhat.com, kraxel@redhat.com,
 kwolf@redhat.com, lukasstraub2@web.de, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, peterx@redhat.com,
 philmd@linaro.org, pizhenwei@bytedance.com, qemu-block@nongnu.org,
 stefanb@linux.ibm.com, wangyanan55@huawei.com
Subject: [PATCH 13/15] qapi: Improve documentation of file descriptor socket
 addresses
Date: Mon,  5 Feb 2024 08:47:07 +0100
Message-ID: <20240205074709.3613229-14-armbru@redhat.com>
In-Reply-To: <20240205074709.3613229-1-armbru@redhat.com>
References: <20240205074709.3613229-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.361,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


