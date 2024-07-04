Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A00EC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 12:50:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPLtd-0004Vk-9N; Thu, 04 Jul 2024 08:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1sPLtR-0004CW-6Z
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 08:48:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1sPLtJ-0006Nj-Ua
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 08:48:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720097327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+U+uAb8unO3/V8/H5R+PzRuVxuF7mhUJxgXTQI3xkqk=;
 b=A+MCdzl4ZJ60Ut+O4yHJ2AVoupxn+Zf4xeovEGVVyRNLByJKnZogi6XQZPQNOdj0Kt4VI3
 9fkMo6fp3ogqK0yY4HQBQcYLPwjcRVHIJz+3p0IT90v7aXGuyPJXBVF8x9SVZfIJVBsUIh
 3vWn3PC5HFWOzUTCdBoTWUrMqF7Xvks=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-141-XqCSA94yPvii40c2QvMgXA-1; Thu,
 04 Jul 2024 08:48:45 -0400
X-MC-Unique: XqCSA94yPvii40c2QvMgXA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0ED88195609D; Thu,  4 Jul 2024 12:48:45 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.39.192.194])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9A6F91956046; Thu,  4 Jul 2024 12:48:43 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v2 3/4] net: update netdev dgram man page with unix socket
Date: Thu,  4 Jul 2024 14:48:33 +0200
Message-ID: <20240704124834.81958-4-lvivier@redhat.com>
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

Add the description of "-netdev dgram" with a unix domain socket.
The code has been added but the man page has not been updated.

Fixes: 784e7a253104 ("net: dgram: add unix socket")
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 qemu-options.hx | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index ef476b593cd1..1bbf629b9959 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3500,6 +3500,29 @@ SRST
                       -device virtio-net,netdev=net0,mac=52:54:00:12:34:56 \\
                       -netdev dgram,id=net0,local.type=inet,local.host=localhost,local.port=1235,remote.type=inet,remote.host=localhost,remote.port=1234
 
+``-netdev dgram,id=str,local.type=unix,local.path=path[,remote.type=unix,remote.path=path]``
+    Configure a network backend to connect to another QEMU virtual
+    machine or a proxy using a datagram oriented unix socket.
+
+    ``local.path=path``
+        filesystem path to use to bind the socket
+
+    ``remote.path=path``
+        filesystem path to use as a destination (see sendto(2))
+
+    Example (two guests connected using an UDP/UNIX socket):
+
+    .. parsed-literal::
+
+        # first VM
+        |qemu_system| linux.img \\
+                      -device virtio-net,netdev=net0,mac=52:54:00:12:34:56 \\
+                      -netdev dgram,id=net0,local.type=unix,local.path=/tmp/qemu0,remote.type=unix,remote.path=/tmp/qemu1
+        # second VM
+        |qemu_system| linux.img \\
+                      -device virtio-net,netdev=net0,mac=52:54:00:12:34:57 \\
+                      -netdev dgram,id=net0,local.type=unix,local.path=/tmp/qemu1,remote.type=unix,remote.path=/tmp/qemu0
+
 ``-netdev dgram,id=str,local.type=fd,local.str=file-descriptor``
     Configure a network backend to connect to another QEMU virtual
     machine or a proxy using a datagram oriented socket file descriptor.
-- 
2.45.2


