Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A32CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 14:59:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wScCm-0004Q4-62; Thu, 28 May 2026 10:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sheldon.qi@canonical.com>)
 id 1wScCi-0004PU-ML
 for qemu-devel@nongnu.org; Thu, 28 May 2026 10:59:25 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sheldon.qi@canonical.com>)
 id 1wScCf-0008Rc-TN
 for qemu-devel@nongnu.org; Thu, 28 May 2026 10:59:24 -0400
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 982F33F856
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 14:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779980359;
 bh=H3Jwh9rxr7zNE5edeNtA7Do/LMaAm1i7kL4SZuyKaI8=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=PIU3FV4cTLIzgBcG34DErruYiMfBl/D/HjNgD11WqPyY4RDS5kbinN3ES3mCCGtm3
 jVf7xT6ejm4838n8ICkgvGXSmSo4rENrqjom9xpJyj8ExtniQ6PKDICS1RGZSxSq1I
 8pxBNUCWOS6DDTtk6D1jZsO38ec9Dx5s/yVgtG6rIwAHPmuKkyX7EjzP0aur/fFJSr
 lKuvyDK/4ieneCksrGQD+TpdXU3vBD3t2V91N0wNsgRH13jiYTGA0Ep3OVx8zgwVqm
 56UUjYvcADG11jFbv7r2Sp47fsLeVfETnYjTeb9LCHxbstqFELO4YiQaEUleJN9t3X
 qUHfohg+fcZVVfmwUhxuokfcLWHLQfi3ONQneQ4nWStmb0JeD8zcf+eG1+qsJ9G7IA
 GypGM1vMlnF2saRbic30usT/hB/VVrSd0DXU9CJLx7U2xUogQ6Rd8FxLhsCztY3Piz
 5E3fQZdwL1kud8nfylyziMSB6IKe9OT4I9/l3QnEUfh5LFw4vzbzBGy3YhKnOs3Dya
 BISrh2BNsxwmMcvgqDKLw3JmKfrSXfCaIZRg07gQrqfS4u7x2wDt5ADOGloS91Ak4M
 U9KFAWO/uetN+scnoVsVBwSw1M/SSfTRI5ZMmqqL6PF+4c9nLTx1Z9vPoWrmh1oZov
 Xl+aJZ+zm5Nbk7sMnVZzlcWM=
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-835423c69ffso6837468b3a.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 07:59:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779980358; x=1780585158;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H3Jwh9rxr7zNE5edeNtA7Do/LMaAm1i7kL4SZuyKaI8=;
 b=O6CydI/qn4RNagz1WsYs37irFUrYi56pnsMybxSpksy2P8gWAmBckqyopFngln+lyQ
 r7/l9V2JF93NJTdUrYfNYQS3qRth+ZhHnzYW9mdirkesDjCsNoolBc2gDWpsWxl0YLQf
 q0PmW1qSZs4vpweKpVMEWEKfAbRYLox3du5qJ/3az/4dbswvGjHHHQIZt0zT514F8Zsx
 vqELFw3/enGBdbEOL7i48ICS3j3Firn5Y1ixioiUdC4+hdbQrfF7kyS5Gkim8MzAbWVB
 O0zRFXqDiTdpFeVY9/ifn6q3pTKH9tMXzXu77gdbKiHpW1I4FpX+vFGP082bdmtjeZfa
 tnZQ==
X-Gm-Message-State: AOJu0Yw/hnfC8VEKbm9Fp7niScJvVhXiCB4S0SBx0TaPkUi87okkquUc
 wE4cTNHDCdkC9m4gRHXUJKhecMMzbcnecmyYk9fTpsQV2bV4kOrjQMOQr+U+Nd1+rqVL618b0zQ
 85icDuKtN7FmPyrRAx2VdeKmyVFYwo0qSnNfFq73GNc5YnjSJTWe2FzsueymFaZOJU7fV33ckwJ
 oxYLQyWoA=
X-Gm-Gg: Acq92OHKsK/msR7gFld8+FvqVFzRpRzgu5iWWKp1NJ8EVab0HUxBtmRvjQSxa05HIzO
 6rT1sKArELHR6L47uvLeByo68IIoiiXPwbgcTb7zGumZiLT1BCoLV78MyF8m6p2HgUkqs7/qXdO
 kIOSXCwPwh2d5wUALZakxdBof6mrCYqAJq4NrO7nbOcUjKhL5sAoWU/YBQ81aNz8CnalIyHBUV9
 DRrktuPpo7ZGu6IVK6lX8mp2z1RK36KH5tlBUc7Hf6NplNQ0kHMD4A5eV8GB2qNwepDwKnSYt/6
 uhvOAg+Shpri2GMB8T8krLVpujBfi9gc5MVUz/4NH+4UmoamuyjD2N8rKEoGHUNZIoJJCeJu89B
 f7xKIrWVfGZasY1MSH5TCzxSgBlusi2LrNQqOfAd3z8E/HoOd964r
X-Received: by 2002:a05:6a00:2d8c:b0:82f:29fe:7239 with SMTP id
 d2e1a72fcca58-8415f5bf78dmr25622302b3a.50.1779980358059; 
 Thu, 28 May 2026 07:59:18 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d8c:b0:82f:29fe:7239 with SMTP id
 d2e1a72fcca58-8415f5bf78dmr25622272b3a.50.1779980357624; 
 Thu, 28 May 2026 07:59:17 -0700 (PDT)
Received: from localhost.localdomain ([103.170.233.214])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-841d730b6c0sm4992433b3a.61.2026.05.28.07.59.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 07:59:16 -0700 (PDT)
From: sheldon.qi@canonical.com
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 Sheldon Qi <sheldon.qi@canonical.com>
Subject: [PATCH] block/curl: fix Win32 socket handling in curl_sock_cb
Date: Thu, 28 May 2026 22:59:10 +0800
Message-ID: <20260528145910.157319-1-sheldon.qi@canonical.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=sheldon.qi@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Sheldon Qi <sheldon.qi@canonical.com>

On Windows libcurl passes raw SOCKET values (UINT_PTR, 64-bit on x64)
that don't fit in int, so GINT_TO_POINTER() truncates the upper bits.
Wrap them in CRT fds via _open_osfhandle / _get_osfhandle so that
aio_set_fd_handler and curl_multi_socket_action receive valid CRT fds.
This matches the pattern already used by io/channel-watch.c,
ui/spice-core.c, monitor/fds.c, and util/aio-win32.c.

Close the CRT fd wrapper in curl_drop_socket and on CURL_POLL_REMOVE
so libcurl retains ownership of the underlying SOCKET.

Signed-off-by: Sheldon Qi <sheldon.qi@canonical.com>
---
 block/curl.c | 44 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/block/curl.c b/block/curl.c
index 684c677ef7..0884d96fe6 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -110,7 +110,8 @@ typedef struct BDRVCURLState {
     QEMUTimer timer;
     uint64_t len;
     CURLState states[CURL_NUM_STATES];
-    GHashTable *sockets; /* GINT_TO_POINTER(fd) -> socket */
+    /* GSIZE_TO_POINTER(raw_sock) on Win32, GINT_TO_POINTER(fd) elsewhere. */
+    GHashTable *sockets;
     char *url;
     size_t readahead_size;
     bool sslverify;
@@ -136,6 +137,10 @@ static gboolean curl_drop_socket(void *key, void *value, void *opaque)
 
     aio_set_fd_handler(s->aio_context, socket->fd,
                        NULL, NULL, NULL, NULL, NULL);
+#ifdef _WIN32
+    /* Close CRT fd wrapper; libcurl owns the underlying SOCKET.  */
+    qemu_close_socket_osfhandle(socket->fd);
+#endif
     return true;
 }
 
@@ -167,13 +172,29 @@ static int curl_sock_cb(CURL *curl, curl_socket_t fd, int action,
     BDRVCURLState *s = userp;
     CURLSocket *socket;
 
+#ifdef _WIN32
+    /*
+     * libcurl passes raw SOCKET (UINT_PTR, 64-bit on x64) which doesn't
+     * fit in GINT_TO_POINTER; wrap in a CRT fd and use GSIZE_TO_POINTER
+     * for the hash key.
+     */
+    socket = g_hash_table_lookup(s->sockets, GSIZE_TO_POINTER((gsize)fd));
+#else
     socket = g_hash_table_lookup(s->sockets, GINT_TO_POINTER(fd));
+#endif
     if (!socket) {
         socket = g_new0(CURLSocket, 1);
-        socket->fd = fd;
         socket->s = s;
+#ifdef _WIN32
+        socket->fd = _open_osfhandle(fd, _O_BINARY);
+        g_hash_table_insert(s->sockets, GSIZE_TO_POINTER((gsize)fd), socket);
+#else
+        socket->fd = fd;
         g_hash_table_insert(s->sockets, GINT_TO_POINTER(fd), socket);
+#endif
     }
+    /* Switch to the CRT fd so the rest of the function stays unchanged. */
+    fd = (curl_socket_t)(intptr_t)socket->fd;
 
     trace_curl_sock_cb(action, (int)fd);
     switch (action) {
@@ -197,7 +218,17 @@ static int curl_sock_cb(CURL *curl, curl_socket_t fd, int action,
     }
 
     if (action == CURL_POLL_REMOVE) {
+#ifdef _WIN32
+        {
+            /* _get_osfhandle recovers the raw SOCKET for the hash key. */
+            curl_socket_t raw_sock = _get_osfhandle(socket->fd);
+            qemu_close_socket_osfhandle(socket->fd);
+            g_hash_table_remove(s->sockets,
+                                GSIZE_TO_POINTER((gsize)raw_sock));
+        }
+#else
         g_hash_table_remove(s->sockets, GINT_TO_POINTER(fd));
+#endif
     }
 
     return 0;
@@ -409,13 +440,20 @@ static void curl_multi_do_locked(CURLSocket *socket)
     BDRVCURLState *s = socket->s;
     int running;
     int r;
+    curl_socket_t sockfd;
+#ifdef _WIN32
+    /* socket->fd is a CRT fd; _get_osfhandle gets the raw SOCKET.  */
+    sockfd = _get_osfhandle(socket->fd);
+#else
+    sockfd = socket->fd;
+#endif
 
     if (!s->multi) {
         return;
     }
 
     do {
-        r = curl_multi_socket_action(s->multi, socket->fd, 0, &running);
+        r = curl_multi_socket_action(s->multi, sockfd, 0, &running);
     } while (r == CURLM_CALL_MULTI_PERFORM);
 }
 
-- 
2.47.3


