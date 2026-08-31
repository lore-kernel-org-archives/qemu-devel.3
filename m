Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E10C61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 10:02:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0yq1-0003WC-CX; Mon, 31 Aug 2026 06:02:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x0ypy-0003Vc-E5
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 06:01:59 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x0ypw-0001hc-Q9
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 06:01:58 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-4843f205a5bso181305f8f.1
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 03:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1788170515; x=1788775315; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WuBxW5Qk+qrLfNk8wOq6IIiADXNVrNAOwMYrteRNbjE=;
 b=UYLcN39F7J2xie7+1WZ8+VoFFkeJhf6h3O8sf8sFXEEyRSNaYNEDXoVknc5PGkSL3n
 KLPiinZ9GddemuIeUMVChB8cFj/aOJwnzCRpx7/YgjZcJG1FoYFGqpV00ikDzad6bFRD
 bN0nKjbyca7qK7we6iHB1QV/Cc9WhFwf2bgObWevtI29DfLaAWqZMLopnr83gSOF7fTN
 251RUsg73en7LoSva4ugbO/uX2mKVOGn3UPsHjfHK6Vdnvovk8G4RGpR0CQ/2+cbtn57
 1xTxBevcrBwP9FKjdBPdQK9qK1DrZkfyJa0wvcdyomS4jodyMprE9lW6W/rVx33JP3OR
 waeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788170515; x=1788775315;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WuBxW5Qk+qrLfNk8wOq6IIiADXNVrNAOwMYrteRNbjE=;
 b=F6hdeac2KjXKSnIyQq5oZ7aFgWWIoANpOYz+DLPHq+IsonUzX1tT56R/5dPJH6Ve8m
 gIKq6MuPqx1xCjHkBgwa02LeEidXS0Set6T72lE8R8cIu6bV4+bIzUF6qMQSjBXp59iU
 arA6QonogyTd+OAAm64ipA2YsNQbLLm4tU8S1jz3iFzbdMDYdn/EhCSK2FBrjbRPnKMn
 TYrDsi5wMJWr2pGShExBfdlwSgkggQlNDrclQRLG/rLt9vqIp8nWQIhg9mIaJAY/R1iM
 UHaEqFAREuj8pbJuGvCBbJhukrfLMdNxBmXNNRHApR1gkPVCwIBhXVm84zyfDhfCpjYv
 lU1Q==
X-Gm-Message-State: AFuF++krZNIBM5Cs0pxj1nns2jZomBfqOCirkFSSvQG043I5nDd89XwK
 JbjYrGWc4ghbPBqIyIm+CVxsOnKQBp3QZHjc9o6uIOSfs7Le3QJ6MUm6uEn4RBuuoS2FiqIMGZH
 5yPMO
X-Gm-Gg: AYBFou2Osg3bu4LVeY8e2MGHkt1VpbX6nNEQ9kXEJaAJqjavW29xtVm+JIBOKSW+1rz
 eqXx9z69zbciMAqgaOV3XtrhAkaCO0Qa/HHod+XQSR7W+PW9XipzxUjpjoTjewzyFbU0Ls+kt0x
 SA8B7DMLdWXJ2WRs/v+J5UN2Uah+zsdPc9eVAQmB8PtSSo8w7KoLa5B7awF3cOO0p91qXcqasKB
 f0aMMVXHJ4R+Ca6YRk7v8jaUrWTRwxWZ1MhunbwPTbhTPWQw10yzSBPo1vcYOQorcp6J9WC5nW7
 Vv86z6gGCRM7XBBTNBxQU+hEaOg3WQfl5Y/AqkjEKVKq8oNbJaGQ8ZwOYp6lzr33k1XaYYd9xId
 P9VKcNiuIhiU+ljMKwzec1scpNPUBylSUEoKuNuvfPSl0U94Of41z4gvFz1vr+wFLZNNQengemg
 T/DBrkbUlD3oHshcZkIXLnPJGrIoRlmChZWtrI6yF/JYdnBzzFUXh6NgAh
X-Received: by 2002:a5d:5e01:0:b0:480:c5:d635 with SMTP id
 ffacd0b85a97d-482f782a4a2mr34636140f8f.0.1788170515229; 
 Mon, 31 Aug 2026 03:01:55 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:3bc1:c53b:30b:203e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb33070sm22362383f8f.36.2026.08.31.03.01.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 03:01:54 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, qemu-stable@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 1/6] io/channel-socket: do not treat a zero length write as an
 error
Date: Mon, 31 Aug 2026 12:01:46 +0200
Message-ID: <20260831100151.914178-2-den@openvz.org>
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

qio_channel_socket_writev() checks "ret <= 0" after sendmsg(). A zero
length iovec is written successfully and returns 0, so the success
falls into the errno switch, which acts on whatever the last failing
syscall left in errno. A stale EAGAIN turns it into
QIO_CHANNEL_ERR_BLOCK with errp untouched, and a caller which treats
every negative return as fatal then passes a NULL Error to
error_get_pretty(). The websocket handshake does exactly that, so an
unauthenticated client crashes QEMU during the greeting.

Returning 0 is safe for callers which loop until everything is
written. qio_channel_writev_full_all() has no zero progress guard, but
iov_copy() yields no entries for a zero length write, so that loop is
never entered. A connected stream socket returns 0 only when there is
nothing to send.

The WIN32 implementation in the same file uses "ret < 0".

Fixes: 559607ea173a ("io: add QIOChannelSocket class")
Cc: qemu-stable@nongnu.org
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 io/channel-socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io/channel-socket.c b/io/channel-socket.c
index 12773b832c..7920cee639 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -667,7 +667,7 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
 
  retry:
     ret = sendmsg(sioc->fd, &msg, sflags);
-    if (ret <= 0) {
+    if (ret < 0) {
         switch (errno) {
         case EAGAIN:
             return QIO_CHANNEL_ERR_BLOCK;
-- 
2.53.0


