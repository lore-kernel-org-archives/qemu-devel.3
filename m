Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D3FBC49EA1
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 03:21:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZipy-0004ZA-0M; Thu, 01 Aug 2024 23:20:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sZipv-0004QL-RF
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 23:20:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sZipu-0000E5-5z
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 23:20:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722568809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nBs8OkMFEZs07p/oPIadTvaQSehAUqrlPLPwQHfg1nI=;
 b=F8FNBELLOQeJZsijwf89/n26hFzpjOWfp//fQ6PO7wUXWBjEKNeHiz7StLLw5WxynM8T5C
 4nx76wLxd0C2ZaJEd7ap7/vXkQu0rUha1ITM6BERNKCWyNDWxwzdUiS76oMP7OBcvbv9xE
 8n9413OG3M+AKd3C8Mac/zpHjDadhLw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-279-egbLY2t0MRe-gg2drYDrMQ-1; Thu,
 01 Aug 2024 23:20:08 -0400
X-MC-Unique: egbLY2t0MRe-gg2drYDrMQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 94FC41955D54
 for <qemu-devel@nongnu.org>; Fri,  2 Aug 2024 03:20:05 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.229])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 022A8300018D; Fri,  2 Aug 2024 03:20:01 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 6/8] net: update netdev dgram man page with unix socket
Date: Fri,  2 Aug 2024 11:19:27 +0800
Message-ID: <20240802031929.44060-7-jasowang@redhat.com>
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

Add the description of "-netdev dgram" with a unix domain socket.
The code has been added but the man page has not been updated.

Fixes: 784e7a253104 ("net: dgram: add unix socket")
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 qemu-options.hx | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index 2614eea4d7..23a53a7190 100644
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
2.42.0


