Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1410C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 03:21:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZipt-0004DQ-83; Thu, 01 Aug 2024 23:20:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sZipq-000423-61
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 23:20:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sZipo-00009Y-B3
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 23:20:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722568803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aK96+5ULR6GSNMwOgGIzwBEppzhtkiyT1tBMWklxk+A=;
 b=OgOSdGHm4FEQ15fwLU1vVc53HB47Ju7GIg/jqjMxIrm7NVPEI/97DVs7GH1mTLwenMTMqh
 qG6uZ2g1pFdZIVaLtL29kFtINuhqq5DDf3KeTHArZvBNBM6zfws4vfmyMJ8VUILWmQFGze
 e/3tINTCSzA8b9fkzWaV/2BTA15rhjw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-178-x1A6Z_j8MSGMzFVlKUy6eg-1; Thu,
 01 Aug 2024 23:20:02 -0400
X-MC-Unique: x1A6Z_j8MSGMzFVlKUy6eg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C0C51955D48
 for <qemu-devel@nongnu.org>; Fri,  2 Aug 2024 03:20:01 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.229])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 890733000198; Fri,  2 Aug 2024 03:19:57 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 5/8] net: update netdev stream man page with unix socket
Date: Fri,  2 Aug 2024 11:19:26 +0800
Message-ID: <20240802031929.44060-6-jasowang@redhat.com>
In-Reply-To: <20240802031929.44060-1-jasowang@redhat.com>
References: <20240802031929.44060-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add the description of "-netdev stream" with a unix domain socket.
The code has been added but the man page has not been updated.

Include an example how to use "-netdev stream" and "passt" in place
of "-netdev user".
("passt" is a non privileged translation proxy between layer-2, like
"-netdev stream", and layer-4 on host, like TCP, UDP, ICMP/ICMPv6 echo)

Fixes: 13c6be96618c ("net: stream: add unix socket")
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 qemu-options.hx | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index 52143cfb8f..2614eea4d7 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3393,6 +3393,46 @@ SRST
                       -device virtio-net,netdev=net0,mac=52:54:00:12:34:57 \\
                       -netdev stream,id=net0,server=off,addr.type=inet,addr.host=localhost,addr.port=1234
 
+``-netdev stream,id=str[,server=on|off],addr.type=unix,addr.path=path[,abstract=on|off][,tight=on|off]``
+    Configure a network backend to connect to another QEMU virtual machine or a proxy using a stream oriented unix domain socket.
+
+    ``server=on|off``
+        if ``on`` create a server socket
+
+    ``addr.path=path``
+        filesystem path to use
+
+    ``abstract=on|off``
+        if ``on``, this is a Linux abstract socket address.
+
+    ``tight=on|off``
+        if false, pad an abstract socket address with enough null bytes to make it fill struct sockaddr_un member sun_path.
+
+    Example (using passt as a replacement of -netdev user):
+
+    .. parsed-literal::
+
+        # start passt server as a non privileged user
+        passt
+        UNIX domain socket bound at /tmp/passt_1.socket
+        # start QEMU to connect to passt
+        |qemu_system| linux.img \\
+                      -device virtio-net,netdev=net0 \\
+                      -netdev stream,id=net0,server=off,addr.type=unix,addr.path=/tmp/passt_1.socket
+
+    Example (two guests connected using a stream oriented unix domain socket):
+
+    .. parsed-literal::
+
+        # first VM
+        |qemu_system| linux.img \\
+                      -device virtio-net,netdev=net0,mac=52:54:00:12:34:56 \\
+                      netdev stream,id=net0,server=on,addr.type=unix,addr.path=/tmp/qemu0
+        # second VM
+        |qemu_system| linux.img \\
+                      -device virtio-net,netdev=net0,mac=52:54:00:12:34:57 \\
+                      -netdev stream,id=net0,server=off,addr.type=unix,addr.path=/tmp/qemu0
+
 ``-netdev stream,id=str[,server=on|off],addr.type=fd,addr.str=file-descriptor``
     Configure a network backend to connect to another QEMU virtual machine or a proxy using a stream oriented socket file descriptor.
 
-- 
2.42.0


