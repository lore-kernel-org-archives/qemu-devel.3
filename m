Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6880DC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 03:20:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZiq5-00055V-1r; Thu, 01 Aug 2024 23:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sZiq2-0004wD-Iv
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 23:20:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sZiq0-0000FA-Kw
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 23:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722568815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kH91dpfOq90fqHB6xmeludhTenxbeE0OM39M3ee/QGM=;
 b=gn6gRgRRrl/fRtX1Bj8MU5D9wHpuPPNHNNWyLMW1JLqBxLC5gL82Xl/W89j6Wovtb+jEqM
 5tcGsjDOYmBmUNcxL1Z/TtwdVW6NyK0azAdGz2oaPuT30rAGHitMmoqDLfptcME0e7p0+W
 NT2s/QMeqMNrolymej/0VsIFzXDyo7M=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-jbSE6dOEP72hKY1bPCfdVA-1; Thu,
 01 Aug 2024 23:20:11 -0400
X-MC-Unique: jbSE6dOEP72hKY1bPCfdVA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 021F61955D4B
 for <qemu-devel@nongnu.org>; Fri,  2 Aug 2024 03:20:10 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.229])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6B336300018D; Fri,  2 Aug 2024 03:20:06 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 7/8] net: update netdev stream man page with the reconnect
 parameter
Date: Fri,  2 Aug 2024 11:19:28 +0800
Message-ID: <20240802031929.44060-8-jasowang@redhat.com>
In-Reply-To: <20240802031929.44060-1-jasowang@redhat.com>
References: <20240802031929.44060-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
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

From: Laurent Vivier <lvivier@redhat.com>

"-netdev stream" supports a reconnect parameter that attempts to
reconnect automatically the socket if it is disconnected. The code
has been added but the man page has not been updated.

Fixes: 148fbf0d58a6 ("net: stream: add a new option to automatically reconnect"
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 qemu-options.hx | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 23a53a7190..cee0da2014 100644
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
2.42.0


