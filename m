Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE6D6C61DE2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 10:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0yqL-0003c3-Vd; Mon, 31 Aug 2026 06:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x0yq2-0003Yx-WC
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 06:02:05 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x0yq1-0001iI-BB
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 06:02:02 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c1677c91969so305064666b.1
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 03:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1788170519; x=1788775319; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GHAHiovpLjpMgWslVL+XHpRGl2nzxx+x3noQBuDkJ5M=;
 b=bRmQ/aI8ze03/oV9NaD81pLniklLOIhJXZS8QqHmQNHjJPpG8nU2FzdIBdZ4GvPKoL
 6b/BZUAmDZeEKVcM9G97WoMB1HzelXNVXhgDBf0ePEggdp/+95cZjLsYXbm7nRfTAI57
 YEpj50f5DwADxYGtauSWPMuo29hNMl5zb+dgMxBfF3qCFqEjk53ZB/2WSeEavYdIZJpW
 FjNayCYlJ/4pqfXAl81Gd9v6JzHsRO4XbzfJ3F3GxqnCn+h2Bkx5rg6ph4O/mnnkeVEN
 0sUJ7EOVvJZvSszAarw9k53PrtDcHGtw7j64FbQ8/TNrvGF5RPkovRolyW9EpVoA5piW
 aCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788170519; x=1788775319;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GHAHiovpLjpMgWslVL+XHpRGl2nzxx+x3noQBuDkJ5M=;
 b=dI/Mm8LQqOefliOXHY8wKKUl3+YkraVa3Z1di19NJBZWRZ2U3dgaZe1Ao2ktfVg3vO
 Wx7jGpb4bKj5LXNC+0JNV7/5ZIHlU8SoKdbc/odbeLLtrhga45r9WFjcqHechTSAhEKK
 c8sYdQXHe2lhbbi5PKWR4t3nWwAwM/TrKM6yXWSvPv0RG8MVGZVORNjAiZJVpCTS2Kma
 Rt29Ixc1pmWotQ1ujiUhaowmCyJ6l+fO9E7DlSi77msPJjOFRWmttgHRvQBM0tVls6co
 g2E66qrDvt5FjtyKp4FqfPOzoXOkygwE8GjW7wMV9hy9Hza4Lzgc00GPB2nKCVlCypme
 u/Pw==
X-Gm-Message-State: AFuF++nkQ92WYrPqCFReKk7cbq63f8VyZ83JWeKsci6v1hxkNoth+7yC
 ufYZwLPbLZCfK6WgaaKfKXCKoEEepJ3+VeVRq/YH39lFETF97xB9AqOGVJwPZ/vYIax31zArxKQ
 qEm+A
X-Gm-Gg: AR+sD138zDrkRiQ3OsVRMEXaIyAwgZNnVpCDYJlNPGivR38x+a382iVKqb5J+GKQffz
 +08qOAutobN8AfOPjup0Ol80p0e72zNDx9FTIPPrckIbOTWK2mivCNR8kTJ3QXUml3UyQZvCIEL
 +Temx9TUK75DkcpwoMybUidLxb957R3C5TnsFCbOfKJVPaizpBbdMk3QDUgkWLjrGuErZ9U+Ls7
 kYomq8uaJrv13NiDXKYTmTptmP9wL3aKzctavJIgPYFExPLWHM199uX3VhFAyAMd+8Lbh2BFe5O
 8GMAHqQDNGqxx5D33AzoBivJNBkbjXqpGEX+uOEpty6JUVrwKdfZmbjEeDtzdr+Gs1Qc5lo7Ouk
 h/fxHYUCeUtK0nk1cNiBRxb9piEMVDBSzcX/7rcGvelR2RCWpNt9cQp6FoVggYgYtubXR4+eVnl
 pnFoO5pwDacCs7S4X87uarN8OV4z4oChLsFTHlmh1DdENQG7yGTOOr+Pzg
X-Received: by 2002:a17:906:7306:b0:c1f:1520:4de5 with SMTP id
 a640c23a62f3a-c2556be194dmr1620758766b.1.1788170519514; 
 Mon, 31 Aug 2026 03:01:59 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:3bc1:c53b:30b:203e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb33070sm22362383f8f.36.2026.08.31.03.01.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 03:01:59 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, qemu-stable@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 5/6] io/channel-websock: do not lose QIO_CHANNEL_ERR_BLOCK
 while reading
Date: Mon, 31 Aug 2026 12:01:50 +0200
Message-ID: <20260831100151.914178-6-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831100151.914178-1-den@openvz.org>
References: <20260831100151.914178-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=den@openvz.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

qio_channel_websock_handshake_read() folds every negative return from
qio_channel_read() into -1. QIO_CHANNEL_ERR_BLOCK leaves errp unset, so
qio_channel_websock_handshake_io() then hands a NULL Error to
error_get_pretty() and QEMU dies.

The master channel is non-blocking and, for a wss:// client, is a TLS
channel. A G_IO_IN wakeup carrying only part of a TLS record makes
gnutls report EAGAIN, which is all it takes to reach this before the
client has authenticated.

ERR_BLOCK here means the headers are not complete yet, which is what a
0 return already tells the caller. Report it that way and keep waiting.
The watch is level triggered, so an incomplete record sitting in the
socket spins the main loop until the rest of it arrives. That is
bounded by the round trip and is what every reader layered over TLS
already does.

Fixes: 2d1d0e70cf3e ("io: add QIOChannelWebsock class")
Cc: qemu-stable@nongnu.org
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 io/channel-websock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index 8f27b1f12b..461abcae48 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -492,6 +492,9 @@ static int qio_channel_websock_handshake_read(QIOChannelWebsock *ioc,
     buffer_reserve(&ioc->encinput, want);
     ret = qio_channel_read(ioc->master,
                            (char *)buffer_end(&ioc->encinput), want, errp);
+    if (ret == QIO_CHANNEL_ERR_BLOCK) {
+        return 0;
+    }
     if (ret < 0) {
         return -1;
     }
-- 
2.53.0


