Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95556C369D8
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Apr 2025 16:51:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u95DJ-0000zK-Ky; Sun, 27 Apr 2025 12:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>) id 1u95DI-0000z4-8u
 for qemu-devel@nongnu.org; Sun, 27 Apr 2025 12:50:44 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>) id 1u95DB-0005pT-AB
 for qemu-devel@nongnu.org; Sun, 27 Apr 2025 12:50:39 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a07a7b4ac7so733716f8f.2
 for <qemu-devel@nongnu.org>; Sun, 27 Apr 2025 09:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745772635; x=1746377435; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s1t7O7lKEtcAOseDx12/Rm6S4l1mtQh+wRnuTPzrVdA=;
 b=a1/4qPodf8yd7GpAyFmsWgUi+X/C/kjOvFWAJ/XgBdC6UZnmLgOl21BvUhLmlNO3vp
 2D4Ysbcoyq/SAKmzhpBlr8N/cpzpyhsbo6KlPno9b9h/Whpk62S7EpaAR2j94cOBGzAx
 7fiPd+WUNrarf38PNAho2m5eXqyQlrQiTvROC7RSOhjQpCtymSowUdTqJ2/YLuiOwVs2
 OL8YtHbqGinylsnUwMw/TlZJDrQkqPEHcU8i7/ms8KScKfG084w+ZZo+z9qcAk2YGOJJ
 T8OeICSSBU8rbVO/RZLmjrXziJmn8wG8K4MqHrRYTrHl+G3ZFGBf0r6TxShvc6soGLzl
 viEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745772635; x=1746377435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s1t7O7lKEtcAOseDx12/Rm6S4l1mtQh+wRnuTPzrVdA=;
 b=kr/jqM/KWz2E1rRgm9yihb4wqlKC+8qFTkjBtaMlgRrnwWLlZ+6xxduqhbGKoSGIBh
 +WW+l1kbCxJJmBui2UOfv6lm5p5cSqVJ7JIiIdElOnSAhZhiN1PfVwYkecPNG2EkVKlX
 3BoVL4V7aIH2TAr+u7Ksb/VUFHpA/4gYCmMukTZkU9RyLxKybvwR+mG7Zm176fRoO2yZ
 u6LRoqKjd5qjbwFV228LbuSW2hal6G8AopGLU736R3VOppVRyT9jfZ4RnYSE2eILmXHQ
 jeCCnCIZwf5NADSVOx15XI73iLDnmeXVZfx/1qR0mvslTcHQ4tNahs3eoQUVRrj2t/Vf
 wSZg==
X-Gm-Message-State: AOJu0Yxd+0TzGAYezZrZm4Z798kP5zi0NgzZL8/uNtDDNHD0l70wSxgn
 GChfxCPCbVg+apE6m3E6rZK7m701WPO47pwlGrF96JjKLaXlcCStc/po1w==
X-Gm-Gg: ASbGnctmrn1MF8T3hOfxUvX3+rhJ3vauQTSMh+cJ4xF2owSkyoT734qkqTdR2PS2w97
 49oUdbYNaNCS5CdUOocLQc1q5RhcwtkwifiPdYrsEWvDCgSa0Knms7jaKwyPwKc/FqjnwKwx2JP
 T/F3c6xE0y2c9c6Mc5vimkIueVDQCDzg/svDPidT5hYcLeVcqMrI8ucAkArnNdxZ8dnFiDD90m2
 o1UlnZBA4+0xNKn0UHC2gbffHr9goG9N3X6fODCovwcf+wtxQ8yZHmKBTVnhveHFVTmrXeKCtYk
 35yjL9qa+PBDDnfulgPphpQCc67lly4neKPQ7cJ46ospoi1R7sq+HpluRPsDSkV5jI42KkidOP4
 yaMLcDDx0H4+syc1OnJm6FMFvSVPE
X-Google-Smtp-Source: AGHT+IFYFc93qIQO2rsMtlUEDAaPXnznx1ydvvWPA4g+rsIZ/q5GlgQs9abU4lDp1+fY2OlSNjKjvg==
X-Received: by 2002:a5d:5f4d:0:b0:38f:503a:d93f with SMTP id
 ffacd0b85a97d-3a074f15168mr6849577f8f.40.1745772635022; 
 Sun, 27 Apr 2025 09:50:35 -0700 (PDT)
Received: from localhost.localdomain (46-116-102-127.bb.netvision.net.il.
 [46.116.102.127]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073c8cd7fsm8783139f8f.1.2025.04.27.09.50.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 27 Apr 2025 09:50:34 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Richard Jones" <rjones@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Eric Blake" <eblake@redhat.com>, Nir Soffer <nirsof@gmail.com>
Subject: [PATCH v3 1/2] io: Increase unix socket buffers size on macOS
Date: Sun, 27 Apr 2025 19:50:28 +0300
Message-Id: <20250427165029.9072-2-nirsof@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250427165029.9072-1-nirsof@gmail.com>
References: <20250427165029.9072-1-nirsof@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=nirsof@gmail.com; helo=mail-wr1-x433.google.com
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

On macOS we need to increase unix stream socket buffers size on the
client and server to get good performance. We set socket buffers on
macOS after connecting or accepting a client connection.  For unix
datagram socket we need different configuration that can be done later.

Testing shows that setting socket receive buffer size (SO_RCVBUF) has no
effect on performance, so we set only the send buffer size (SO_SNDBUF).
It seems to work like Linux but not documented.

Testing shows that optimal buffer size is 512k to 4 MiB, depending on
the test case. The difference is very small, so I chose 2 MiB.

I tested reading from qemu-nbd and writing to qemu-nbd with qemu-img and
computing a blkhash with nbdcopy and blksum.

To focus on NBD communication and get less noisy results, I tested
reading and writing to null-co driver. I added a read-pattern option to
the null-co driver to return data full of 0xff:

    NULL="json:{'driver': 'raw', 'file': {'driver': 'null-co', 'size': '10g', 'read-pattern': -1}}"

For testing buffer size I added an environment variable for setting the
socket buffer size.

Read from qemu-nbd via qemu-img convert. In this test buffer size of 2m
is optimal (12.6 times faster).

    qemu-nbd -r -t -e 0 -f raw -k /tmp/nbd.sock "$NULL" &
    qemu-img convert -f raw -O raw -W -n "nbd+unix:///?socket=/tmp/nbd.sock" "$NULL"

| buffer size | time    | user    | system  |
|-------------|---------|---------|---------|
|     default |  13.361 |   2.653 |   5.702 |
|       65536 |   2.283 |   0.204 |   1.318 |
|      131072 |   1.673 |   0.062 |   1.008 |
|      262144 |   1.592 |   0.053 |   0.952 |
|      524288 |   1.496 |   0.049 |   0.887 |
|     1048576 |   1.234 |   0.047 |   0.738 |
|     2097152 |   1.060 |   0.080 |   0.602 |
|     4194304 |   1.061 |   0.076 |   0.604 |

Write to qemu-nbd with qemu-img convert. In this test buffer size of 2m
is optimal (9.2 times faster).

    qemu-nbd -t -e 0 -f raw -k /tmp/nbd.sock "$NULL" &
    qemu-img convert -f raw -O raw -W -n "$NULL" "nbd+unix:///?socket=/tmp/nbd.sock"

| buffer size | time    | user    | system  |
|-------------|---------|---------|---------|
|     default |   8.063 |   2.522 |   4.184 |
|       65536 |   1.472 |   0.430 |   0.867 |
|      131072 |   1.071 |   0.297 |   0.654 |
|      262144 |   1.012 |   0.239 |   0.587 |
|      524288 |   0.970 |   0.201 |   0.514 |
|     1048576 |   0.895 |   0.184 |   0.454 |
|     2097152 |   0.877 |   0.174 |   0.440 |
|     4194304 |   0.944 |   0.231 |   0.535 |

Compute a blkhash with nbdcopy, using 4 NBD connections and 256k request
size. In this test buffer size of 4m is optimal (5.1 times faster).

    qemu-nbd -r -t -e 0 -f raw -k /tmp/nbd.sock "$NULL" &
    nbdcopy --blkhash "nbd+unix:///?socket=/tmp/nbd.sock" null:

| buffer size | time    | user    | system  |
|-------------|---------|---------|---------|
|     default |   8.624 |   5.727 |   6.507 |
|       65536 |   2.563 |   4.760 |   2.498 |
|      131072 |   1.903 |   4.559 |   2.093 |
|      262144 |   1.759 |   4.513 |   1.935 |
|      524288 |   1.729 |   4.489 |   1.924 |
|     1048576 |   1.696 |   4.479 |   1.884 |
|     2097152 |   1.710 |   4.480 |   1.763 |
|     4194304 |   1.687 |   4.479 |   1.712 |

Compute a blkhash with blksum, using 1 NBD connection and 256k read
size. In this test buffer size of 512k is optimal (10.3 times faster).

    qemu-nbd -r -t -e 0 -f raw -k /tmp/nbd.sock "$NULL" &
    blksum "nbd+unix:///?socket=/tmp/nbd.sock"

| buffer size | time    | user    | system  |
|-------------|---------|---------|---------|
|     default |  13.085 |   5.664 |   6.461 |
|       65536 |   3.299 |   5.106 |   2.515 |
|      131072 |   2.396 |   4.989 |   2.069 |
|      262144 |   1.607 |   4.724 |   1.555 |
|      524288 |   1.271 |   4.528 |   1.224 |
|     1048576 |   1.294 |   4.565 |   1.333 |
|     2097152 |   1.299 |   4.569 |   1.344 |
|     4194304 |   1.291 |   4.559 |   1.327 |

Signed-off-by: Nir Soffer <nirsof@gmail.com>
---
 io/channel-socket.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/io/channel-socket.c b/io/channel-socket.c
index 608bcf066e..06901ab694 100644
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
+ * Testing shows that 2m send buffer gives best throuput and lowest cpu usage.
+ * Changing the receive buffer size has no effect on performance.
+ */
+#ifdef __APPLE__
+#define UNIX_STREAM_SOCKET_SEND_BUFFER_SIZE (2 * MiB)
+#endif /* __APPLE__ */
+
+static void qio_channel_socket_set_buffers(QIOChannelSocket *ioc)
+{
+    if (ioc->localAddr.ss_family == AF_UNIX) {
+        int type;
+        socklen_t type_len = sizeof(type);
+
+        if (getsockopt(ioc->fd, SOL_SOCKET, SO_TYPE, &type, &type_len) == -1) {
+            return;
+        }
+
+#ifdef UNIX_STREAM_SOCKET_SEND_BUFFER_SIZE
+        if (type == SOCK_STREAM) {
+            const int value = UNIX_STREAM_SOCKET_SEND_BUFFER_SIZE;
+            setsockopt(ioc->fd, SOL_SOCKET, SO_SNDBUF, &value, sizeof(value));
+        }
+#endif /* UNIX_STREAM_SOCKET_SEND_BUFFER_SIZE */
+    }
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


