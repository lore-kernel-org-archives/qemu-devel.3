Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D2FC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 12:50:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPLtc-0004VV-Hk; Thu, 04 Jul 2024 08:49:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1sPLtQ-0004CK-EW
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 08:48:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1sPLtM-0006OK-DL
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 08:48:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720097330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QiPH4cU9/QV7duZggbkflxxRqgm65xLkTAkWIk/OAhg=;
 b=S5L+6xlc6bKWeyW4L3VfzXjL4dZNNm9O09brrxS01I74WzPNZwPzcUtnyW2aC40HhsrNrl
 AnTyoCy2wpuNEarzrj+l/6puT1l3pl3mZqn5ANzvvqS6897kQSo+Xee189Xvu8REBb9QVD
 jot81xl9U3hYQ22WKNd9jhzImNSJHIA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-VfVt7negMs6Wvq6hC_NhKw-1; Thu,
 04 Jul 2024 08:48:47 -0400
X-MC-Unique: VfVt7negMs6Wvq6hC_NhKw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4A2819560B9; Thu,  4 Jul 2024 12:48:46 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.39.192.194])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6E2B11955F65; Thu,  4 Jul 2024 12:48:45 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v2 4/4] net: update netdev stream man page with the reconnect
 parameter
Date: Thu,  4 Jul 2024 14:48:34 +0200
Message-ID: <20240704124834.81958-5-lvivier@redhat.com>
In-Reply-To: <20240704124834.81958-1-lvivier@redhat.com>
References: <20240704124834.81958-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

"-netdev stream" supports a reconnect parameter that attempts to
reconnect automatically the socket if it is disconnected. The code
has been added but the man page has not been updated.

Fixes: 148fbf0d58a6 ("net: stream: add a new option to automatically reconnect"
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 qemu-options.hx | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 1bbf629b9959..c78f69851bf3 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3353,7 +3353,7 @@ SRST
                          -device e1000,netdev=n1,mac=52:54:00:12:34:56 \\
                          -netdev socket,id=n1,mcast=239.192.168.1:1102,localaddr=1.2.3.4
 
-``-netdev stream,id=str[,server=on|off],addr.type=inet,addr.host=host,addr.port=port[,to=maxport][,numeric=on|off][,keep-alive=on|off][,mptcp=on|off][,addr.ipv4=on|off][,addr.ipv6=on|off]``
+``-netdev stream,id=str[,server=on|off],addr.type=inet,addr.host=host,addr.port=port[,to=maxport][,numeric=on|off][,keep-alive=on|off][,mptcp=on|off][,addr.ipv4=on|off][,addr.ipv6=on|off][,reconnect=seconds]``
     Configure a network backend to connect to another QEMU virtual machine or a proxy using a TCP/IP socket.
 
     ``server=on|off``
@@ -3380,6 +3380,10 @@ SRST
     ``ipv6=on|off``
         whether to accept IPv6 addresses, default to try both IPv4 and IPv6
 
+    ``reconnect=seconds``
+        for a client socket, if a socket is disconnected, then attempt a reconnect after the given number of seconds.
+        Setting this to zero disables this function.  (default: 0)
+
     Example (two guests connected using a TCP/IP socket):
 
     .. parsed-literal::
@@ -3391,9 +3395,9 @@ SRST
         # second VM
         |qemu_system| linux.img \\
                       -device virtio-net,netdev=net0,mac=52:54:00:12:34:57 \\
-                      -netdev stream,id=net0,server=off,addr.type=inet,addr.host=localhost,addr.port=1234
+                      -netdev stream,id=net0,server=off,addr.type=inet,addr.host=localhost,addr.port=1234,reconnect=5
 
-``-netdev stream,id=str[,server=on|off],addr.type=unix,addr.path=path[,abstract=on|off][,tight=on|off]``
+``-netdev stream,id=str[,server=on|off],addr.type=unix,addr.path=path[,abstract=on|off][,tight=on|off][,reconnect=seconds]``
     Configure a network backend to connect to another QEMU virtual machine or a proxy using a stream oriented unix domain socket.
 
     ``server=on|off``
@@ -3408,6 +3412,10 @@ SRST
     ``tight=on|off``
         if false, pad an abstract socket address with enough null bytes to make it fill struct sockaddr_un member sun_path.
 
+    ``reconnect=seconds``
+        for a client socket, if a socket is disconnected, then attempt a reconnect after the given number of seconds.
+        Setting this to zero disables this function.  (default: 0)
+
     Example (using passt as a replacement of -netdev user):
 
     .. parsed-literal::
@@ -3431,9 +3439,9 @@ SRST
         # second VM
         |qemu_system| linux.img \\
                       -device virtio-net,netdev=net0,mac=52:54:00:12:34:57 \\
-                      -netdev stream,id=net0,server=off,addr.type=unix,addr.path=/tmp/qemu0
+                      -netdev stream,id=net0,server=off,addr.type=unix,addr.path=/tmp/qemu0,reconnect=5
 
-``-netdev stream,id=str[,server=on|off],addr.type=fd,addr.str=file-descriptor``
+``-netdev stream,id=str[,server=on|off],addr.type=fd,addr.str=file-descriptor[,reconnect=seconds]``
     Configure a network backend to connect to another QEMU virtual machine or a proxy using a stream oriented socket file descriptor.
 
     ``server=on|off``
@@ -3442,6 +3450,10 @@ SRST
     ``addr.str=file-descriptor``
         file descriptor number to use as a socket
 
+    ``reconnect=seconds``
+        for a client socket, if a socket is disconnected, then attempt a reconnect after the given number of seconds.
+        Setting this to zero disables this function.  (default: 0)
+
 ``-netdev dgram,id=str,remote.type=inet,remote.host=maddr,remote.port=port[,local.type=inet,local.host=addr]``
     Configure a network backend to connect to a multicast address.
 
-- 
2.45.2


