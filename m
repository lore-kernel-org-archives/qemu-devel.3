Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E849C61DE2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 10:03:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0yqM-0003cM-KX; Mon, 31 Aug 2026 06:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x0yq6-0003ZV-G8
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 06:02:07 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x0yq4-0001j0-UK
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 06:02:06 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-482e4998d28so2249666f8f.2
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 03:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1788170523; x=1788775323; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5l+A4VTVItQEGlaBGwJQQDrMFIhfMZArZo9il9USUm4=;
 b=qHiytBV9XtsJKBt0OQzrFlnydW7/SI4lM6fvYVbwUnteB2hu5onPh3tc3wGKpFRhc1
 tkwHKVNsZW0NmVScP/PBJk8bSlM0UzpK44Gh+swaH/YjGLjK+eZOMqq3gWbtb5Q4dfsC
 23DnoIbzIx+XZt5lfT3w18X2Rf4paeIhyYtWQJ0kCQRNZwQcO9ZcE5JB145pkiSDws3z
 hlOoa+by0W7APxFIZ4fp9UQPxJpI+O1RdKMVfPnNNfTUpj0B/0xunOfGZvWg8TghB4Pw
 RYbIRRk1gf4xqBDNWk1Km1xeBLPqpApY7Mu/Z4ZBQs1a4lfvqMAfQSZhdZBuWUbYGR0P
 mbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788170523; x=1788775323;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5l+A4VTVItQEGlaBGwJQQDrMFIhfMZArZo9il9USUm4=;
 b=IVsTP5cDPTVx7/d7KgO5Am79aqGgenGUvQ9x4XDDAhBwb8OCzWYSPDgaodl+6leAf6
 ECF5FodaK9uMY9uAsEJQ6ruE4pm/oXXu4dNb0KUwcjPREn1HxRcHb0pa584bhwnsUnwD
 QXgACIEcN68phculrz3vROaNMFqW9PmPyQGZm7CoSZ84hQ9zFMmJYy9JtvHmv36+Osse
 I067VyHlDbS/rKVUTH78rF+uF6E7VJy/7qYHewJKwWh4EYbzQTl8nkVfL7/d3EkyYaH9
 2hdnL9lav4kcbRS6X9+LFDPkGah8oo7EtVz3eUQbEF8gbHX00oLs3tMKe6f023vZ6C1i
 xWaA==
X-Gm-Message-State: AFuF++mp/zr8SNgRZIJkdONeZrGgTXzGtC8gzck8a7hi0pcBnan8xwbV
 XvbBeMhywc0BCR1EB32TrQhqEv+vLpe72fsLH0YTg4zwLywcCZyHwT07OLQjf0VXRjyksvwOxL8
 ONCim
X-Gm-Gg: AYBFou1pxXAe43GjzB3SKGpnTLWtMX3Zx2ZycMpGjpMgPN5bJ4PIddjxm8yLOZAVVM7
 FVrEZNm9pF/AoqtVNOUO33aIg99zOcnyEY63iP8Sv7DosKMGlA9VUS0nX+SgFHDDzeYopcN+HFR
 OgY/yl16mONjIMpn2pwnSEn091CJwIfKqcOJuJY3su3izhMcRxeCzizqa2uGoYY5+wq3th8W+4K
 NIxCL+WOqFnvw+a4UznIS0iByioSbKbidw8/BP18ZjNVJaPKDm5G3MHMqdddCOGBKtpPQodJGop
 QRKo92yy6tEUmSoz0sL53WXKNme3EoJLHrnNHoy7lU2TyaqQUTNmfenQYNpf9YQH9k6xftiQdUh
 qZirygFKEe4azXc7KgFmlfGNO88GAWF5PBjTm30TwiDSep7uTusj/VRJysI2skRPJJlC8+hMA5j
 jayxvP1Dbz7jKmG4BcdRznX1VEpHRLR4uGB385yOC6QgGmyo7kEACtY3JV
X-Received: by 2002:a5d:59c6:0:b0:484:3d1b:7884 with SMTP id
 ffacd0b85a97d-4843f442224mr2540352f8f.17.1788170516299; 
 Mon, 31 Aug 2026 03:01:56 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:3bc1:c53b:30b:203e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb33070sm22362383f8f.36.2026.08.31.03.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 03:01:55 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, qemu-stable@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 2/6] io/channel-websock: send an HTTP 400 when the greeting
 has no space
Date: Mon, 31 Aug 2026 12:01:47 +0200
Message-ID: <20260831100151.914178-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831100151.914178-1-den@openvz.org>
References: <20260831100151.914178-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=den@openvz.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Denis V. Lunev <den@openvz.org>

qio_channel_websock_extract_headers() returns 0 without queueing a
response when the request line contains no space, unlike every sibling
check which jumps to bad_request. encoutput stays empty, yet
qio_channel_websock_handshake_read() still reports success and the
caller arms a G_IO_OUT watch to flush nothing.

Flushing that empty buffer is where QEMU crashes. Any client can
trigger it before authentication on a VNC websocket port:

  printf 'stats\r\nx\r\n\r\n' | nc $host $port

Fixes: 07e95cd529af ("io: fully parse & validate HTTP headers for websocket protocol handshake")
Cc: qemu-stable@nongnu.org
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 io/channel-websock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index 1929abf56a..66c91ed2a2 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -230,7 +230,7 @@ qio_channel_websock_extract_headers(QIOChannelWebsock *ioc,
     tmp = strchr(buffer, ' ');
     if (!tmp) {
         error_setg(errp, "Missing HTTP path delimiter");
-        return 0;
+        goto bad_request;
     }
     *tmp = '\0';
 
-- 
2.53.0


