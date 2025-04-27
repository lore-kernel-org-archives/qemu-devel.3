Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 926D6C369D1
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Apr 2025 16:51:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u95DL-00010X-1C; Sun, 27 Apr 2025 12:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>) id 1u95DJ-0000zN-NL
 for qemu-devel@nongnu.org; Sun, 27 Apr 2025 12:50:45 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>) id 1u95DE-0005pj-RC
 for qemu-devel@nongnu.org; Sun, 27 Apr 2025 12:50:45 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cf680d351so28769555e9.0
 for <qemu-devel@nongnu.org>; Sun, 27 Apr 2025 09:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745772636; x=1746377436; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7BQ16vIw1EHB1x27l7KHahTZhvMciox87CMxJC1bBgM=;
 b=ltuhItOGsvxUJ6yOwPrUYdTaTlhKEV9IBc6EYr1bEAghnjIrKDYs+H7SmygndyVURJ
 AHj9Jgo2EdfX5PzMtQM5vC6Ef5VCi+nTEaAKS/UOl2l93jBMlJ2dpnbZYQgUP92tco/N
 L7StHpwZFHh7e9WdBR6IT7ecB/qUDlzwJNGz5eqZQ1Qt7NpDwxI31h04K1gXnGGvyCPI
 ty92J3oW2WGNFx5Cx4YpS2+9rpmjv87UR6XCO02y/Bj1ntS/Rs/NH6LX52jA3cjQ2hO1
 EMBxOuOhZj56AvJn8bHw7hg9d/R74/b6gWip+Fy0EL5ea1JEq2k8z+zN912wjqAhXytj
 ajmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745772636; x=1746377436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7BQ16vIw1EHB1x27l7KHahTZhvMciox87CMxJC1bBgM=;
 b=nRpKG2jQeT4cs4jWA1B6votZ6M6M2YMPIITYXZ3wJ1y4vKIxgU3TvcV/6I8VRiwIqz
 yaGw3YvU3lYD8jiQ+AMJ/6wRBMC8pE9kxeuoi4pblIQoXRFtTMDTwZ7EPjOI2sNqr6I3
 XLg7TfrWQwwNO7v5X+rZFXSnHbJb0JmDrmRdMZqpXPQCmgmSjrRiGzQ/W3VskLVYv0VC
 qsNrJL/V2bHz+KVqnTBd1rg3RSUZ4A3x9KAsmp256q/JqW+LFR2m1HMbH1cRe5cZEwTs
 YNTvNui9MCNf3YYjpULojfWhxdB2wut+hpVxHTznxMH8fy+ADP1JW5NkV5lJ+qbRasWK
 9LgA==
X-Gm-Message-State: AOJu0Yw2CovvvnKIsFpuu0xx4H6xto432jSruOG6mmJKfovieBep68Uy
 duhlSytHIKI8TqlDQ43b9J6itSjzC0/98QK/th/j0fMH3hY85Bu29wFrWw==
X-Gm-Gg: ASbGncuDHz/YEeH8OhnKXO0O6Qj033rkiPRL56rfJnq/hHG0h2isZzyO4mdX7MmNat2
 hb6cNCZtMFi/XZj7fesN1DfzPKcccRAzsRUf+brL7wPFJy7+w5b18J2Ty+w12OZi29jxg73FirM
 2R/HcHIH0fVKLfUsSd2wFPgkzuDggqiBbxwQKs7grTcPy14cvbZ2kRwbg5itEx+K9CbI7CD9mbl
 UY81obDZ7jmbRzcVHpvnZdoGjOhnfDAhPAFmUOH9gN4svzp8CZ9to0iB7Z5OmtYjhoZrLVchsRg
 taLyE2tPNKuXX0XDuO5JevkrYdxRmSDP7qODBEdQYxdDQXPv2k1bmBjGXw8ASgoYmTDZjOAwQ0n
 l+Gb13ZLmG7LQe5eoTjAyGmN0GdD9
X-Google-Smtp-Source: AGHT+IFFwoldIJQiHfNwBoilsP7suJ9qF/0En0sn6t67KOayrXDWvCYI2MH+cLNJBClEn38jmmp9Fw==
X-Received: by 2002:a05:600c:6c95:b0:43c:f680:5c2e with SMTP id
 5b1f17b1804b1-4409c512c5amr111714175e9.13.1745772636242; 
 Sun, 27 Apr 2025 09:50:36 -0700 (PDT)
Received: from localhost.localdomain (46-116-102-127.bb.netvision.net.il.
 [46.116.102.127]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073c8cd7fsm8783139f8f.1.2025.04.27.09.50.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 27 Apr 2025 09:50:35 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Richard Jones" <rjones@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Eric Blake" <eblake@redhat.com>, Nir Soffer <nirsof@gmail.com>
Subject: [PATCH v3 2/2] io: Increase unix socket buffers on Linux
Date: Sun, 27 Apr 2025 19:50:29 +0300
Message-Id: <20250427165029.9072-3-nirsof@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250427165029.9072-1-nirsof@gmail.com>
References: <20250427165029.9072-1-nirsof@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=nirsof@gmail.com; helo=mail-wm1-x333.google.com
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
---
 io/channel-socket.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/io/channel-socket.c b/io/channel-socket.c
index 06901ab694..f2974fab74 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -39,12 +39,13 @@
 #define SOCKET_MAX_FDS 16
 
 /*
- * Testing shows that 2m send buffer gives best throuput and lowest cpu usage.
- * Changing the receive buffer size has no effect on performance.
+ * Testing shows that 2m send buffer is optimal. Changing the receive buffer
+ * size has no effect on performance.
+ * On Linux we need to increase net.core.wmem_max to make this effective.
  */
-#ifdef __APPLE__
+#if defined(__APPLE__) || defined(__linux__)
 #define UNIX_STREAM_SOCKET_SEND_BUFFER_SIZE (2 * MiB)
-#endif /* __APPLE__ */
+#endif
 
 static void qio_channel_socket_set_buffers(QIOChannelSocket *ioc)
 {
-- 
2.39.5 (Apple Git-154)


