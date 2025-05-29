Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49FA6C54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 22:03:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKlKp-0005Xb-33; Thu, 29 May 2025 18:02:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uKlKn-0005Wm-8t
 for qemu-devel@nongnu.org; Thu, 29 May 2025 18:02:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uKlKl-0002ZX-KF
 for qemu-devel@nongnu.org; Thu, 29 May 2025 18:02:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748556163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tkU3lGy5x3O+d/0bLwArMdgLP1ASjGcnbZa8XHDrIqs=;
 b=NdJ08+TEk4biQRmpKvdUaKLxlu1OMIt+rUGOPIcUKDdkw1In+nAvpYQqp7Z14uSPgxlkmf
 T5bdA+Jzjryrgn1I3r+mE492Eib8r9JNt4l3mfmnn9tcODeSfnr87xuDFtohWP0DE1ouMn
 FWqTMgODB2gKKiQ/ykBeLIiPOwl881g=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-331-Bg7H7zHeM0-VQm_2uJt1hA-1; Thu,
 29 May 2025 18:02:39 -0400
X-MC-Unique: Bg7H7zHeM0-VQm_2uJt1hA-1
X-Mimecast-MFC-AGG-ID: Bg7H7zHeM0-VQm_2uJt1hA_1748556158
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 46544195609E; Thu, 29 May 2025 22:02:38 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.48])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 85F6C19560AE; Thu, 29 May 2025 22:02:36 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nir Soffer <nirsof@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PULL 3/6] nbd: Set unix socket send buffer on Linux
Date: Thu, 29 May 2025 17:02:10 -0500
Message-ID: <20250529220228.1187563-11-eblake@redhat.com>
In-Reply-To: <20250529220228.1187563-8-eblake@redhat.com>
References: <20250529220228.1187563-8-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Nir Soffer <nirsof@gmail.com>

Like macOS we have similar issue on Linux. For TCP socket the send
buffer size is 2626560 bytes (~2.5 MiB) and we get good performance.
However for unix socket the default and maximum buffer size is 212992
bytes (208 KiB) and we see poor performance when using one NBD
connection, up to 4 times slower than macOS on the same machine.

Tracing shows that for every 2 MiB payload (qemu uses 2 MiB io size), we
do 1 recvmsg call with TCP socket, and 10 recvmsg calls with unix
socket.

Fixing this issue requires changing the maximum send buffer size (the
receive buffer size is ignored). This can be done using:

    $ cat /etc/sysctl.d/net-mem-max.conf
    net.core.wmem_max = 2097152

    $ sudo sysctl -p /etc/sysctl.d/net-mem-max.conf

With this we can set the socket buffer size to 2 MiB. With the defaults
the value requested by qemu is clipped to the maximum size and has no
effect.

I tested on 2 machines:
- Fedora 42 VM on MacBook Pro M2 Max
- Dell PowerEdge R640 (Intel(R) Xeon(R) Gold 6230 CPU @ 2.10GHz)

On the older Dell machine we see very little improvement, up to 1.03
higher throughput. On the M2 machine we see up to 2.67 times higher
throughput. The following results are from the M2 machine.

Reading from qemu-nbd with qemu-img convert. In this test buffer size of
4m is optimal (2.28 times faster).

| buffer size | time    | user    | system  |
|-------------|---------|---------|---------|
|     default |   4.292 |   0.243 |   1.604 |
|      524288 |   2.167 |   0.058 |   1.288 |
|     1048576 |   2.041 |   0.060 |   1.238 |
|     2097152 |   1.884 |   0.060 |   1.191 |
|     4194304 |   1.881 |   0.054 |   1.196 |

Writing to qemu-nbd with qemu-img convert. In this test buffer size of
1m is optimal (2.67 times faster).

| buffer size | time    | user    | system  |
|-------------|---------|---------|---------|
|     default |   3.113 |   0.334 |   1.094 |
|      524288 |   1.173 |   0.179 |   0.654 |
|     1048576 |   1.164 |   0.164 |   0.670 |
|     2097152 |   1.227 |   0.197 |   0.663 |
|     4194304 |   1.227 |   0.198 |   0.666 |

Computing a blkhash with nbdcopy. In this test buffer size of 512k is
optimal (1.19 times faster).

| buffer size | time    | user    | system  |
|-------------|---------|---------|---------|
|     default |   2.140 |   4.483 |   2.681 |
|      524288 |   1.794 |   4.467 |   2.572 |
|     1048576 |   1.807 |   4.447 |   2.644 |
|     2097152 |   1.822 |   4.461 |   2.698 |
|     4194304 |   1.827 |   4.465 |   2.700 |

Computing a blkhash with blksum. In this test buffer size of 4m is
optimal (2.65 times faster).

| buffer size | time    | user    | system  |
|-------------|---------|---------|---------|
|     default |   3.582 |   4.595 |   2.392 |
|      524288 |   1.499 |   4.384 |   1.482 |
|     1048576 |   1.377 |   4.381 |   1.345 |
|     2097152 |   1.388 |   4.389 |   1.354 |
|     4194304 |   1.352 |   4.395 |   1.302 |

Signed-off-by: Nir Soffer <nirsof@gmail.com>
Message-ID: <20250517201154.88456-4-nirsof@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/nbd/common.c b/nbd/common.c
index 9436e9d1d14..2a133a66c39 100644
--- a/nbd/common.c
+++ b/nbd/common.c
@@ -271,8 +271,9 @@ const char *nbd_mode_lookup(NBDMode mode)
 /*
  * Testing shows that 2m send buffer is optimal. Changing the receive buffer
  * size has no effect on performance.
+ * On Linux we need to increase net.core.wmem_max to make this effective.
  */
-#if defined(__APPLE__)
+#if defined(__APPLE__) || defined(__linux__)
 #define UNIX_STREAM_SOCKET_SEND_BUFFER_SIZE (2 * MiB)
 #endif

-- 
2.49.0


