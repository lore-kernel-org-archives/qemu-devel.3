Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF8EC369C9
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Apr 2025 23:13:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u6HML-00074l-Ke; Sat, 19 Apr 2025 19:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>) id 1u6HMI-00074O-RH
 for qemu-devel@nongnu.org; Sat, 19 Apr 2025 19:12:26 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>) id 1u6HMG-0003vO-A4
 for qemu-devel@nongnu.org; Sat, 19 Apr 2025 19:12:26 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cfebc343dso23789755e9.2
 for <qemu-devel@nongnu.org>; Sat, 19 Apr 2025 16:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745104342; x=1745709142; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=za4K10VjV5EWFEVGoCsoJYm8xHK3+v476jnALxEm0mM=;
 b=YP/55+UVGxeSLQSZdL1lCe0qe8wulb0smIlPwFc7bsZvJnjgEnYvPBzSPs/TsQzW5i
 X7sX9e+QUI77IqVAJhZDDpvhcoL2kaYIGpNiNSrXtM4nZAiL4nsTL43qJ8NPuA9NOO/Y
 hkc7BDSgCMkrngs2zZGoNsaDM/JAS7U9n6v2A0qqe0ixay5dxVfhbRPizZPl1Xsp++Ep
 KpRCJEXdo0QS0J7hsZnAwU7lZESqP53THzwAk6ymWaoHS1bZnRlnb/p0kejjqKYO5YHh
 SbboVZJIcplhoqnkXuRMdV0CiAbGc2CbGgjVr0qxho9gINRm4ALXVoPStU/1FQzknKeO
 g/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745104342; x=1745709142;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=za4K10VjV5EWFEVGoCsoJYm8xHK3+v476jnALxEm0mM=;
 b=NXKFds9eYdDG3Ex1n/R4coUJ6OyArFJ0VgrhN+XKpnfNm/Wu7TT9vvOxZ7ckoV7wVE
 Nq+/YcZc+1KgWlAFg95RVs4MBjvdHo04fBQMBUuMeSKlxGNErI2iOVY98wNDd4eQ0EoC
 nRMpJDmm/NGEGe1ztSOJsEgvovKiGc5ldZe3zdISFb5B2FiTzL8s9yT9EbbcRhmwOlbV
 IFetXPAr1IT7YTp66bOV+YypnkWJQx2sepIDYcT69ZqWZgcrg/0dzdBxMITdPf3L6ick
 OB/Vsi3+HG0F3qgBgdWnLO3K6WgXQLWJauPk6pic7Bmd8XgUZahj4HvHG1F94HcErOEI
 cuMg==
X-Gm-Message-State: AOJu0YwBY+8Glt4mmeVfmyInOHIkVZ6gP6SWJ7ROglVLiQxKHb3N8DW+
 CX4O0qHPMSo+T8QXaAt0LTYSuNRubCiQa26NMCVf8ZIUcDasKw5sOBcc2Q==
X-Gm-Gg: ASbGncuOFCx45Sn+JWTDT/Olvt9MhZxNICn8kN56zBP7mGKFhCHqMKOMvPZEIypztNt
 VJJTaUydfDOxleDtSZmpQxtClljrBphtNmZHI19/+FvSkl9nivaPdmg7kDk9+p89K/H8I5ZBvXU
 49PtoDMhGJ7122Iyn2my+X/GuzdXZI1BUdeT+p3RXCseU/LJ8TUN2YBIrIvuGyB37x5jNN4xwSM
 aZUacRGqBWKgfOzvGKep+9cnzwMtoZudPPQ5aWyFOFteiIcaS8pPoXKVoooUZ+mXLTMKjNjtLlV
 UsAbeIoCZU776FJ6o5rSxTr6k90Mp6mxiKTRRiJeN7cAQswtUBfjZ91Quc4DBOM9W1V8ptty2u+
 wBpJCFX7cRFGwIQRwsHpe/pthGhrT
X-Google-Smtp-Source: AGHT+IEjbm+QsQlyncUfuuZfVirRwcoKdaaanf9grX9glQ1dg9aqZZoybymNx8Zw1MxN/p+h/3fTtA==
X-Received: by 2002:a05:600c:34c1:b0:43d:fa58:81d3 with SMTP id
 5b1f17b1804b1-4406ac227fbmr58154085e9.32.1745104341469; 
 Sat, 19 Apr 2025 16:12:21 -0700 (PDT)
Received: from localhost.localdomain (46-116-102-127.bb.netvision.net.il.
 [46.116.102.127]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d6db1b3sm78264305e9.29.2025.04.19.16.12.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 19 Apr 2025 16:12:20 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Richard Jones" <rjones@redhat.com>, "Eric Blake" <eblake@redhat.com>,
 Nir Soffer <nirsof@gmail.com>
Subject: [PATCH v2] io: Increase unix socket buffers size on macOS
Date: Sun, 20 Apr 2025 02:12:18 +0300
Message-Id: <20250419231218.67636-1-nirsof@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=nirsof@gmail.com; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On macOS we need to increase unix socket buffers size on the client and
server to get good performance. We set the socket buffers on macOS after
connecting or accepting a client connection.

Testing with qemu-nbd shows that reading an image with qemu-img convert
from qemu-nbd is *11.4 times faster* and qemu-img cpu usage is *8.3 times
lower*.

| qemu-img | qemu-nbd | time   | user   | system |
|----------|----------|--------|--------|--------|
| before   | before   | 12.957 |  2.643 |  5.777 |
| after    | before   | 12.803 |  2.632 |  5.742 |
| before   | after    |  1.139 |  0.074 |  0.905 |
| after    | after    |  1.179 |  0.077 |  0.931 |

For testing buffers size I built qemu-nbd and qemu-img with send buffer
size from 64k to 2m. In this test 256k send buffer and 1m receive buffer
are optimal.

| send buffer | recv buffer | time   | user   | system |
|-------------|-------------|--------|--------|--------|
|         64k |        256k |  2.233 |  0.290 |  1.408 |
|        128k |        512k |  1.189 |  0.103 |  0.841 |
|        256k |       1024k |  1.121 |  0.085 |  0.813 |
|        512k |       2048k |  1.172 |  0.081 |  0.953 |
|       1024k |       4096k |  1.160 |  0.072 |  0.907 |
|       2048k |       8192k |  1.309 |  0.056 |  0.960 |

Using null-co driver is useful to focus on the read part, but in the
real world we do something with the read data. I tested real world usage
with nbdcopy and blksum.

I tested computing a hash of the image using nbdcopy, using 4 NBD
connections and 256k request size. In this test 1m send buffer size and
4m receive buffer size are optimal.

| send buffer | recv buffer | time   | user   | system |
|-------------|-------------|--------|--------|--------|
|         64k |        256k |  2.832 |  4.866 |  2.550 |
|        128k |        512k |  2.429 |  4.762 |  2.037 |
|        256k |       1024k |  2.158 |  4.724 |  1.813 |
|        512k |       2048k |  1.777 |  4.632 |  1.790 |
|       1024k |       4096k |  1.657 |  4.466 |  1.812 |
|       2048k |       8192k |  1.782 |  4.570 |  1.912 |

I tested creating a hash of the image with blksum, using one NBD
connection and 256k read size. In this test 2m send buffer and 8m
receive buffer are optimal.

| send buffer | recv buffer | time   | user   | system |
|-------------|-------------|--------|--------|--------|
|         64k |        256k |  4.233 |  5.242 |  2.632 |
|        128k |        512k |  3.329 |  4.915 |  2.015 |
|        256k |       1024k |  2.071 |  4.647 |  1.474 |
|        512k |       2048k |  1.980 |  4.554 |  1.432 |
|       1024k |       4096k |  2.058 |  4.553 |  1.497 |
|       2048k |       8192k |  1.972 |  4.539 |  1.497 |

In the real world tests larger buffers are optimal, so I picked send
buffer of 1m and receive buffer of 4m.

This will improve other usage of unix domain sockets on macOS. I tested
only reading from qemu-nbd.

The same change for libnbd:
https://gitlab.com/nbdkit/libnbd/-/merge_requests/21

Signed-off-by: Nir Soffer <nirsof@gmail.com>
---
 io/channel-socket.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

Changes since v1:
- Add UNIX_SOCKET_*_BUFFER_SIZE macros (Philippe)
- Handle both server and client sockets
- Add qio_channel_socket_set_buffers() helper to cleaner code
- Add tests results for qemu-img convert
- Add tests results for different buffer sizes
- Link to same change in libnbd

v1 was here:
https://lists.gnu.org/archive/html/qemu-devel/2025-04/msg03081.html

diff --git a/io/channel-socket.c b/io/channel-socket.c
index 608bcf066e..635c5c973d 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -21,6 +21,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-visit-sockets.h"
 #include "qemu/module.h"
+#include "qemu/units.h"
 #include "io/channel-socket.h"
 #include "io/channel-util.h"
 #include "io/channel-watch.h"
@@ -37,6 +38,33 @@
 
 #define SOCKET_MAX_FDS 16
 
+/*
+ * Apple recommends sizing the receive buffer at 4 times the size of the send
+ * buffer. Testing shows that 1m send buffer and 4 MiB receive buffer gives
+ * best throuput and lowest cpu usage.
+ */
+#ifdef __APPLE__
+#define UNIX_SOCKET_SEND_BUFFER_SIZE (1 * MiB)
+#define UNIX_SOCKET_RECV_BUFFER_SIZE (4 * UNIX_SOCKET_SEND_BUFFER_SIZE)
+#endif /* __APPLE__ */
+
+static void qio_channel_socket_set_buffers(QIOChannelSocket *ioc)
+{
+#ifdef __APPLE__
+    if (ioc->localAddr.ss_family == AF_UNIX) {
+        int value;
+
+        /* This is a performance optimization; don't fail on errors. */
+
+        value = UNIX_SOCKET_SEND_BUFFER_SIZE;
+        setsockopt(ioc->fd, SOL_SOCKET, SO_SNDBUF, &value, sizeof(value));
+
+        value = UNIX_SOCKET_RECV_BUFFER_SIZE;
+        setsockopt(ioc->fd, SOL_SOCKET, SO_RCVBUF, &value, sizeof(value));
+    }
+#endif /* __APPLE__ */
+}
+
 SocketAddress *
 qio_channel_socket_get_local_address(QIOChannelSocket *ioc,
                                      Error **errp)
@@ -174,6 +202,8 @@ int qio_channel_socket_connect_sync(QIOChannelSocket *ioc,
     }
 #endif
 
+    qio_channel_socket_set_buffers(ioc);
+
     qio_channel_set_feature(QIO_CHANNEL(ioc),
                             QIO_CHANNEL_FEATURE_READ_MSG_PEEK);
 
@@ -410,6 +440,8 @@ qio_channel_socket_accept(QIOChannelSocket *ioc,
     }
 #endif /* WIN32 */
 
+    qio_channel_socket_set_buffers(cioc);
+
     qio_channel_set_feature(QIO_CHANNEL(cioc),
                             QIO_CHANNEL_FEATURE_READ_MSG_PEEK);
 
-- 
2.39.5 (Apple Git-154)


