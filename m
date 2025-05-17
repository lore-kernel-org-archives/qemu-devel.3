Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE3FC2D0CD
	for <qemu-devel@archiver.kernel.org>; Sat, 17 May 2025 20:12:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGNt9-0005Sm-VZ; Sat, 17 May 2025 16:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1uGNt6-0005S1-Ql; Sat, 17 May 2025 16:12:05 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1uGNt4-00020P-SI; Sat, 17 May 2025 16:12:04 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-442ec3ce724so25234305e9.0; 
 Sat, 17 May 2025 13:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747512721; x=1748117521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Fsc2GCK3vxhvJVRGNGESOqw+ualHxA6ub7eW9EYjAw=;
 b=I3sJNpJ0jRlbswTU1M8HFbOOZQXCdFeK2dlvbdBcxpi1nJ87dQKlXdvq0o/HffUxA1
 x+RyzUY218P3snlpMQuoQJ8fdq+GeJb4gNUa24GFCM6F7ErFu4vosLAg+qDPY2Sh5WRA
 mopurAieP+1zKenPKaA2xeyGTplCQEcOXvO9bNVZo6AVFPQAzqZ8c6z1Es6MDERIVUtA
 /jFJoavmMDDzP5kGTpCXH10f8vqqDvF4LDJmsymX5c3whOEqqBMb0WYHPmuQA80dCLcV
 4yUY91hD5/qvpe49hsFIcDGpibqfQrE9CudjHkhZYeTglS4S+rOsPjp23yXS+a/TZizF
 TR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747512721; x=1748117521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Fsc2GCK3vxhvJVRGNGESOqw+ualHxA6ub7eW9EYjAw=;
 b=hJ0vVoHiRr5CEPOsuwFdpr248ORKrsrvGyB4PasiQ2fDf8ZgZxJR6zVBEK7IkvqdTB
 JzjEcurA8KSXN4/m2ZX2pcxedM7pgKGD7fnEvFPIo48IADlUYl5Ml+ZH5rtoZ1RoesWk
 7sViAEJqH893DPjkCeSmnrE9BPJArZUW4Ht8Canj5FvAIkxg4mDwdbrH9zXh4VF95Vvz
 QWUmuy0BNsFXpqIWwYDDHW7Y5Bt2HVjHRAYeyouGr5EqmQlBbw/xq+oszSJDeHAi1blD
 vOGP1T0vu/o8A9G2l0DlHqgc99ZXzduCnYK1xaTeE7dhqkO+rrxNuoHLauYrTguViLf+
 fFsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJ/T32rORCOq5vNuw1T20dWk8ZUx6+0p+/SDmC0gWBHYG7/CmqFFdyUB8ETzoCc+A6yJlvArk4d8S5@nongnu.org
X-Gm-Message-State: AOJu0YztgYNPLMSJzgUNM8S7bGBQr3pDjcoC0MvGEVzfST+2GH6bNL7a
 TqaXBChqKR3KoFrs9qg7e63Zi4gupWgzk9tYvQpR3CMuG522D43sOxkk75EPEPfZapk=
X-Gm-Gg: ASbGncsXqyDe4w3C/mKS0xEwzdij4K2sw2iDFAFW4XNQewTfb/xRPHtDkRDFRcbv+Cz
 eL38FDveusf6deJ0TWz62I+ln4rWm6C57+3fRCYigLJLnvSanWpTrR79sC8ETBWfMNpUw+rFMLO
 hsHwPans8x38pDC9fI6EH6eHAE3duRA5lq0Qao2aF+13zumHuYwYQwChrqCFxOtBIdZcCol1Av1
 pMfuvNPdA9MiT3dJ5fUtEE6ancgCbQcOb09nnVibrGQzyskIanxnZT2lYF1V+bq/fVqkAitkhpo
 s7K3Ol49TCppgiw+kXSj5IWYsMRdRo2nBS+QnouAL00ES9G1Frk6Lg8JHHSn2Y3e6rE4CXgUjWF
 Kk7nkCNcfQsdCtNja6/d+Og+1ltLRyZknvg==
X-Google-Smtp-Source: AGHT+IG5tCXPmaWFtO8t3nA2YfkdgmECuMVvelpAd0pRF7FA2l9MVreKXjUHntEGjqHls84Hz2vyjQ==
X-Received: by 2002:a05:600c:3f06:b0:43b:ca39:6c75 with SMTP id
 5b1f17b1804b1-442fd63c7aemr91824615e9.16.1747512720615; 
 Sat, 17 May 2025 13:12:00 -0700 (PDT)
Received: from localhost.localdomain (46-116-102-127.bb.netvision.net.il.
 [46.116.102.127]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442fd59ab21sm78714715e9.38.2025.05.17.13.11.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 17 May 2025 13:11:59 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Richard Jones" <rjones@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org, Nir Soffer <nirsof@gmail.com>
Subject: [PATCH v4 2/3] nbd: Set unix socket send buffer on macOS
Date: Sat, 17 May 2025 23:11:53 +0300
Message-Id: <20250517201154.88456-3-nirsof@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250517201154.88456-1-nirsof@gmail.com>
References: <20250517201154.88456-1-nirsof@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=nirsof@gmail.com; helo=mail-wm1-x32b.google.com
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
server to get good performance. We set socket buffers on macOS after
connecting or accepting a client connection.

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

    NULL="json:{'driver': 'raw', 'file': {'driver': 'null-co', 'size': '10g', 'read-pattern': 255}}"

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
 nbd/client-connection.c |  3 +++
 nbd/common.c            | 25 +++++++++++++++++++++++++
 nbd/nbd-internal.h      |  5 +++++
 nbd/server.c            |  2 ++
 4 files changed, 35 insertions(+)

diff --git a/nbd/client-connection.c b/nbd/client-connection.c
index b11e266807..79ea97e4cc 100644
--- a/nbd/client-connection.c
+++ b/nbd/client-connection.c
@@ -31,6 +31,8 @@
 #include "qapi/clone-visitor.h"
 #include "qemu/coroutine.h"
 
+#include "nbd/nbd-internal.h"
+
 struct NBDClientConnection {
     /* Initialization constants, never change */
     SocketAddress *saddr; /* address to connect to */
@@ -140,6 +142,7 @@ static int nbd_connect(QIOChannelSocket *sioc, SocketAddress *addr,
         return ret;
     }
 
+    nbd_set_socket_send_buffer(sioc);
     qio_channel_set_delay(QIO_CHANNEL(sioc), false);
 
     if (!info) {
diff --git a/nbd/common.c b/nbd/common.c
index 589a748cfe..9436e9d1d1 100644
--- a/nbd/common.c
+++ b/nbd/common.c
@@ -18,6 +18,9 @@
 
 #include "qemu/osdep.h"
 #include "trace.h"
+#include "io/channel-socket.h"
+#include "qapi/error.h"
+#include "qemu/units.h"
 #include "nbd-internal.h"
 
 /* Discard length bytes from channel.  Return -errno on failure and 0 on
@@ -264,3 +267,25 @@ const char *nbd_mode_lookup(NBDMode mode)
         return "<unknown>";
     }
 }
+
+/*
+ * Testing shows that 2m send buffer is optimal. Changing the receive buffer
+ * size has no effect on performance.
+ */
+#if defined(__APPLE__)
+#define UNIX_STREAM_SOCKET_SEND_BUFFER_SIZE (2 * MiB)
+#endif
+
+void nbd_set_socket_send_buffer(QIOChannelSocket *sioc)
+{
+#ifdef UNIX_STREAM_SOCKET_SEND_BUFFER_SIZE
+    if (sioc->localAddr.ss_family == AF_UNIX) {
+        size_t size = UNIX_STREAM_SOCKET_SEND_BUFFER_SIZE;
+        Error *errp = NULL;
+
+        if (qio_channel_socket_set_send_buffer(sioc, size, &errp) < 0) {
+            warn_report_err(errp);
+        }
+    }
+#endif /* UNIX_STREAM_SOCKET_SEND_BUFFER_SIZE */
+}
diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
index 715d92d6ef..6bafeef5dd 100644
--- a/nbd/nbd-internal.h
+++ b/nbd/nbd-internal.h
@@ -74,4 +74,9 @@ static inline int nbd_write(QIOChannel *ioc, const void *buffer, size_t size,
 
 int nbd_drop(QIOChannel *ioc, size_t size, Error **errp);
 
+/* nbd_set_socket_send_buffer
+ * Set the socket send buffer size for optimal performance.
+ */
+void nbd_set_socket_send_buffer(QIOChannelSocket *sioc);
+
 #endif
diff --git a/nbd/server.c b/nbd/server.c
index 2076fb2666..d242be9811 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -3291,6 +3291,8 @@ void nbd_client_new(QIOChannelSocket *sioc,
     client->close_fn = close_fn;
     client->owner = owner;
 
+    nbd_set_socket_send_buffer(sioc);
+
     co = qemu_coroutine_create(nbd_co_client_start, client);
     qemu_coroutine_enter(co);
 }
-- 
2.39.5 (Apple Git-154)


