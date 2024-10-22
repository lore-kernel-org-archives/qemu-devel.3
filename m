Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20214D2C56A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 15:25:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3GkO-0007h5-P1; Tue, 22 Oct 2024 11:24:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t3GkN-0007fe-2z
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 11:24:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t3GkL-0004yb-E4
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 11:24:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729610672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9C5ciISird3Pqd1kxcsy5MD0cbnXg6lyR4YKJgacZEE=;
 b=JHk+egCqnQtO8HqGm+O6UFD3VoILaqt43a6KTYynUHnwXGqI8SY2+VQQ0qWbUxvZsqLFHE
 lQlP0uChMNU0MEgcUcjjYUeQFpJDLVoHvT8EJlOz8W7bvfxgMDq5X1OhbZVVwGrW/zvabW
 daV7R9TdzVIuSBvAqoK1riFl+uEhJvo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-328-L5-o78xVMsiz7ywCnEof6A-1; Tue,
 22 Oct 2024 11:24:29 -0400
X-MC-Unique: L5-o78xVMsiz7ywCnEof6A-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A9E51955BC5; Tue, 22 Oct 2024 15:24:28 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.59])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8235419560B2; Tue, 22 Oct 2024 15:24:25 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 03/14] util: don't set SO_REUSEADDR on client sockets
Date: Tue, 22 Oct 2024 16:24:04 +0100
Message-ID: <20241022152415.1632556-4-berrange@redhat.com>
In-Reply-To: <20241022152415.1632556-1-berrange@redhat.com>
References: <20241022152415.1632556-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
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

Setting the SO_REUSEADDR property on a socket allows binding to a port
number that is in the TIMED_WAIT state. This is usually done on listener
sockets, to enable a server to restart itself without having to wait for
the completion of TIMED_WAIT on the port.

It is also possible, but highly unusual, to set it on client sockets. It
is rare to explicitly bind() a client socket, since it is almost always
fine to allow the kernel to auto-bind a client socket to a random free
port. Most systems will have many 10's of 1000's of free ports that
client sockets will be bound to.

eg on Linux

  $ sysctl -a | grep local_port
  net.ipv4.ip_local_port_range = 32768	60999

eg on OpenBSD

  $ sysctl -a | grep net.inet.ip.port
  net.inet.ip.portfirst=1024
  net.inet.ip.portlast=49151
  net.inet.ip.porthifirst=49152
  net.inet.ip.porthilast=65535

A connected socket must have a unique set of value for

 (protocol, localip, localport, remoteip, remoteport)

otherwise it is liable to get EADDRINUSE.

A client connection should trivially avoid EADDRINUSE if letting the
kernel auto-assign the 'localport' value, which QEMU always does.

When QEMU sets SO_REUSEADDR on a client socket on OpenBSD, however, it
upsets this situation.

The OpenBSD kernel appears to happily pick a 'localport' that is in the
TIMED_WAIT state, even if there are many other available local ports
available for use that are not in the TIMED_WAIT state.

A test program that just loops opening client sockets will start seeing
EADDRINUSE on OpenBSD when as few as 2000 ports are in TIMED_WAIT,
despite 10's of 1000's ports still being unused. This contrasts with
Linux which appears to avoid picking local ports in TIMED_WAIT state.

This problem on OpenBSD exhibits itself periodically with the migration
test failing with a message like[1]:

  qemu-system-ppc64: Failed to connect to '127.0.0.1:24109': Address already in use

While I have not been able to reproduce the OpenBSD failure in my own
testing, given the scope of what QEMU tests do, it is entirely possible
that there could be a lot of ports in TIMED_WAIT state when the
migration test runs.

Removing SO_REUSEADDR from the client sockets should not affect normal
QEMU usage, and should improve reliability on OpenBSD.

This use of SO_REUSEADDR on client sockets is highly unusual, and
appears to have been present since the very start of the QEMU socket
helpers in 2008. The orignal commit has no comment about the use of
SO_REUSEADDR on the client, so is most likely just an 16 year old
copy+paste bug.

[1] https://lists.nongnu.org/archive/html/qemu-devel/2024-10/msg03427.html
    https://lists.nongnu.org/archive/html/qemu-devel/2024-02/msg01572.html

Fixes: d247d25f18764402899b37c381bb696a79000b4e
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 util/qemu-sockets.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index c1b162b056..77477c1cd5 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -367,7 +367,6 @@ static int inet_connect_addr(const InetSocketAddress *saddr,
                          addr->ai_family);
         return -1;
     }
-    socket_set_fast_reuse(sock);
 
     /* connect to peer */
     do {
-- 
2.46.0


