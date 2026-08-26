Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA130C61DBE
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 19:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzJVi-0001eG-Px; Wed, 26 Aug 2026 15:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wzJVg-0001Sx-Tw
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 15:42:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wzJVf-0006Mg-5R
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 15:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787773326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QP7QUbGEfuohezFKRNTIokfJyo/v9qvglGiwlHcfMr4=;
 b=QSo7bzIjnwR9qy/7BTx9VpCajzOBfAJPNVJ5FWPWxiPMlPzFJH9xYGeuBlrMIvMSGOZQxA
 wVTLAKq0y9yV1JCn/np8vG7jVCrx5un2yv92KcczimGSywvFp2hUmPG6L9EqQHKt+DvqCb
 g/e8vJ+m+IkTMiSm67ehMPD7aLHbM/c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-463-XG7GCazON9KfnsA_-NtzLQ-1; Wed,
 26 Aug 2026 15:42:02 -0400
X-MC-Unique: XG7GCazON9KfnsA_-NtzLQ-1
X-Mimecast-MFC-AGG-ID: XG7GCazON9KfnsA_-NtzLQ_1787773319
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4FB03184BAAB; Wed, 26 Aug 2026 19:41:59 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.99])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 395DA1800577; Wed, 26 Aug 2026 19:41:51 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, linux-cxl@vger.kernel.org,
 Markus Armbruster <armbru@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, qemu-trivial@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Jiri Pirko <jiri@resnulli.us>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, linux-edac@vger.kernel.org,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowangio@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Lukas Straub <lukasstraub2@web.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 21/43] qapi: convert trivial intro sections for sockets.json
Date: Wed, 26 Aug 2026 15:38:18 -0400
Message-ID: <20260826193840.2152000-22-jsnow@redhat.com>
In-Reply-To: <20260826193840.2152000-1-jsnow@redhat.com>
References: <20260826193840.2152000-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/sockets.json | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/qapi/sockets.json b/qapi/sockets.json
index 473be2ac58a..210d07b5ef2 100644
--- a/qapi/sockets.json
+++ b/qapi/sockets.json
@@ -9,8 +9,7 @@
 
 ##
 # @NetworkAddressFamily:
-#
-# The network address family
+#     The network address family
 #
 # @ipv4: IPV4 family
 #
@@ -41,9 +40,8 @@
 
 ##
 # @InetSocketAddress:
-#
-# Captures a socket address or address range in the Internet
-# namespace.
+#     Captures a socket address or address range in the Internet
+#     namespace.
 #
 # @numeric: true if the host/port are guaranteed to be numeric, false
 #     if name resolution should be attempted.  Defaults to false.
@@ -98,8 +96,8 @@
 
 ##
 # @UnixSocketAddress:
-#
-# Captures a socket address in the local ("Unix socket") namespace.
+#     Captures a socket address in the local ("Unix socket")
+#     namespace.
 #
 # @path: filesystem path to use
 #
@@ -121,8 +119,7 @@
 
 ##
 # @VsockSocketAddress:
-#
-# Captures a socket address in the vsock namespace.
+#     Captures a socket address in the vsock namespace.
 #
 # @cid: unique host identifier
 #
@@ -140,8 +137,7 @@
 
 ##
 # @FdSocketAddress:
-#
-# A file descriptor name or number.
+#     A file descriptor name or number.
 #
 # @str: decimal is for file descriptor number, otherwise it's a file
 #     descriptor name.  Named file descriptors are permitted in
@@ -197,9 +193,8 @@
 
 ##
 # @SocketAddressLegacy:
-#
-# Captures the address of a socket, which could also be a named file
-# descriptor
+#     Captures the address of a socket, which could also be a named
+#     file descriptor
 #
 # @type: Transport type
 #
@@ -219,8 +214,7 @@
 
 ##
 # @SocketAddressType:
-#
-# Available `SocketAddress` types
+#     Available `SocketAddress` types
 #
 # @inet: Internet address
 #
@@ -237,9 +231,8 @@
 
 ##
 # @SocketAddress:
-#
-# Captures the address of a socket, which could also be a socket file
-# descriptor
+#     Captures the address of a socket, which could also be a socket
+#     file descriptor
 #
 # @type: Transport type
 #
-- 
2.55.0


