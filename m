Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A344C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 12:50:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPLtd-0004Vz-JF; Thu, 04 Jul 2024 08:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1sPLtN-0004BT-JS
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 08:48:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1sPLtH-0006Ng-Tp
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 08:48:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720097327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b14Iq179KB9r4vFMn7lJuT4Zw90NLVWbiSbt+SfClCw=;
 b=OQyEkmVqGUvN+DU7NOM/pc3Ga/OgXHBi8jsJuzFjpMA5VGXWWG1IX5TR+t3xW3FSIlgExr
 5T0ItiWuxHkWzt0POxcSfXp2c3ZF5dP4BtGmJsbug1YgYo8X7hCzlbTtwI0XeBJoJGTedR
 t17DxmhPet0SPCs/j2rKIU46GWWkXXw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-it3F5MypMjamiy68QoWcgQ-1; Thu,
 04 Jul 2024 08:48:44 -0400
X-MC-Unique: it3F5MypMjamiy68QoWcgQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D0821955F0D; Thu,  4 Jul 2024 12:48:43 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.39.192.194])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A5AEE1956046; Thu,  4 Jul 2024 12:48:41 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v2 2/4] net: update netdev stream man page with unix socket
Date: Thu,  4 Jul 2024 14:48:32 +0200
Message-ID: <20240704124834.81958-3-lvivier@redhat.com>
In-Reply-To: <20240704124834.81958-1-lvivier@redhat.com>
References: <20240704124834.81958-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Add the description of "-netdev stream" with a unix domain socket.
The code has been added but the man page has not been updated.

Include an example how to use "-netdev stream" and "passt" in place
of "-netdev user".
("passt" is a non privileged translation proxy between layer-2, like
"-netdev stream", and layer-4 on host, like TCP, UDP, ICMP/ICMPv6 echo)

Fixes: 13c6be96618c ("net: stream: add unix socket")
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 qemu-options.hx | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index 2a099731ea0a..ef476b593cd1 100644
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
2.45.2


