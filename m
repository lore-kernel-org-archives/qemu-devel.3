Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A73E2C2D0CD
	for <qemu-devel@archiver.kernel.org>; Sat, 17 May 2025 20:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGNtA-0005TS-Ii; Sat, 17 May 2025 16:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1uGNt8-0005Sj-2F; Sat, 17 May 2025 16:12:06 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1uGNt6-00020l-Au; Sat, 17 May 2025 16:12:05 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a064a3e143so1604562f8f.3; 
 Sat, 17 May 2025 13:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747512722; x=1748117522; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YY9WRuvAYI/I2OQEpJcbR6dtMzBKUajhK446b7lTa94=;
 b=i2IcW32Cpxm6bBEi9Gq+da/71CjxX5BH0XcmoxjRVNxQT889c5v4NU0PCv6ZQvirOB
 0K7yt2PmDDe5b/qExCQB9gYbAuaQHFJh//30Cp979QVp7ajgw8Po3zEtsPJfahfIog9M
 QpftXUdzZjR5Y9dkwP3CxfqrtYo4FhLotpA9ZJtT3Hyn03gyzdek8gXOj4DB3mJ8Gd1n
 AMbGKjFyTWg1pEdLCU4CcA4/ZnOosTBZ+80J6BCEigoB1aHd5lPOy4fzN4JXXE4p+1qH
 Pe5X6WMc4EXxFqVdvcH5NN7C7HQ3/xfjzdoLMzE+21Io6AN6nb2auRIGkHA1RGhKEy2/
 Rk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747512722; x=1748117522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YY9WRuvAYI/I2OQEpJcbR6dtMzBKUajhK446b7lTa94=;
 b=ZlPRqjc0/S3A/N9QQNQczifO1ExMcZWfAm/tXOMWMtWJLl2RcAjv6pyiqlS6OKOuST
 JeP3DpLQy0h9rESXTMYoq3fNx0mVLIORefYt9CcKjahX9MoAHBGV79d4uAvHcVlHFJ2a
 6XI3aPUjyfhTNOSiG7uSPwQIoafJpk+9feFRU9B01mEZzjA6beO4n8BKgu2dYFMbgGGa
 S+TRUGP6qj2L+ossql+RSxD203MqpHZa9jRzR/H2nFxYfqHavBvhViw7vTV87L9wojw+
 8LhcaLJv9KACobSsnwb3arIi/X9z6CM/Pv8G+NOYZ0MmqFo4MyMs08ieXDPPLKS7/iiY
 kYog==
X-Forwarded-Encrypted: i=1;
 AJvYcCXra1WdS7KtmVNCGF6XrH1Z6vbG1m9rhvmc6r5dncD5NVqeehOCCwfjZ/nAUnhuYS5GtH9uzBqSX4DC@nongnu.org
X-Gm-Message-State: AOJu0Yx0stuFoFNZjPCK11j1n+IkCgG7CqV5B15d2BS+L/4mFrRs0+yt
 ZbwUwDs4WShl7lJzj9FUrQXjpyqJxFlizb4DOY4YH5f74Z9cm3uC1vsQh6eL7QMP+dI=
X-Gm-Gg: ASbGncsTnmCRtCNZ233l0hAEnYSwTmNF+9WWxPGp/iSyB4Awy9dRixNmS44YB+ItOr+
 ndqozhaO3NaplRxe4d4h09r9X1YagUqpeI5moH7U6nHEYUGxAjCOVA66OZsnXv8UPhv/K+NG3hr
 LvoE/TS0XnaQ5Yl4notZEinxMWoo4iSpJTFltWHFwtei8Ge1z1rv4+UKP4XCzBjBETHNpYJHW7F
 MNnfcqQ/8kSCnyVM+zkoAZVCkK0QSw+c00p24nbHy1PC08lBAOBeHKORJc5sVh9+KqLkLLV0XAA
 WJELbGsfyFJGHR709FV4yJfZ3GJtmzI6mFk2HPCwbklvJyZnFBk9TPhhYq87MD0j4ra6WilPlFP
 oQGDPkS2MfFpAlbtuhjAt/WC5nPydrLkDZw==
X-Google-Smtp-Source: AGHT+IF6FvXb5fojyaWS6qu/5ktcaug90aAr3rwYnucpTrR3sZ2pa6hQ4xmTjKxGipZt2b/3J7LmIw==
X-Received: by 2002:a05:6000:2410:b0:3a0:9f24:774d with SMTP id
 ffacd0b85a97d-3a35c853134mr7550237f8f.45.1747512722103; 
 Sat, 17 May 2025 13:12:02 -0700 (PDT)
Received: from localhost.localdomain (46-116-102-127.bb.netvision.net.il.
 [46.116.102.127]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442fd59ab21sm78714715e9.38.2025.05.17.13.12.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 17 May 2025 13:12:01 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Richard Jones" <rjones@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org, Nir Soffer <nirsof@gmail.com>
Subject: [PATCH v4 3/3] nbd: Set unix socket send buffer on Linux
Date: Sat, 17 May 2025 23:11:54 +0300
Message-Id: <20250517201154.88456-4-nirsof@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250517201154.88456-1-nirsof@gmail.com>
References: <20250517201154.88456-1-nirsof@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=nirsof@gmail.com; helo=mail-wr1-x42d.google.com
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
 nbd/common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/nbd/common.c b/nbd/common.c
index 9436e9d1d1..2a133a66c3 100644
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
2.39.5 (Apple Git-154)


