Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F4EC61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 10:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0yqL-0003bu-V2; Mon, 31 Aug 2026 06:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x0yq0-0003W8-KE
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 06:02:00 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x0ypz-0001ht-2P
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 06:02:00 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-47de0093c42so2923668f8f.3
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 03:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1788170517; x=1788775317; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OOj3UJv01tlBH9pWB45VmW3UUOGqsvmi2BentS7bMfE=;
 b=eNx7SG70RnDUsql/c772eORa5BvCacYiA5Iz2IuNAhVrciqEw0zNeiHotrFsB3q1dI
 sN92pUfKN3ViWN0hg6ckSnyVU/ZT/WeU2SYxq1lltBQv+BeXg99QDzpviJzmIEAKuSMf
 0bWKxS/Tyjh+Om8p/gElV8bfcpEB+ByjV47o25P/Llu+01rcAJVQe/P2VOAXyviYzNrG
 WFrX8a+YRG0DF2Y0fJtFMrUdh4UjAAQrD+/4QF5rau3EswbUjmR0908FFwrLC2zfdKDW
 l/X5INt1u6OAAwD5mQ/r44BduRIC9K/1o9w6EnWiMfxqkcaKix8zqQA3n6BRDZdO1hvU
 Ax4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788170517; x=1788775317;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OOj3UJv01tlBH9pWB45VmW3UUOGqsvmi2BentS7bMfE=;
 b=mRIKPw1wzbbf6Ck8aEmylXZZfVIBDCEC7lezdmllwIDcJ2i2b6J+rIhJb5k+RBh5MC
 JtgK+sF/uNGg6NMkYQhJyULH3ycCHCyCNjWob0rk3AhEF0aJqg4N6hBHqt7D/8TOAa2T
 O8GtbS8aZi77Bb8b62TeeDHscvNiNJwe6GBBMY2KeJThKUBn1akDFUNacSFJ55JJ5Dnf
 Wq4Ux3uo6IXeD9xSqi9QB/MV7Tcf2DPrfb1IlUNZb7haX46opwRM4GuCSozecDPibBT4
 faJuuKMC+wNUybrNaKMB8rIU5TFwskc5DrT36lVq6RYdTWF9bxC2/paUcUzTuUejehML
 VdXw==
X-Gm-Message-State: AFuF++l3gYcRfnw8QZgXvTDaLw9wVRkDSbzCng5YNXleIkgGvhibZ6R4
 l3cy9uyJqfJxDzWm7XtKVtrv4G4FMTNby5razfH36ERkacoPX0+A1DLX0VJ250G1GxGhai6KfIo
 HUAb0
X-Gm-Gg: AYBFou3FJ7BAOWuUjyJvRnDQLeXcv9TY8HykGvcqfruHFxu1v+7QZV814MhhVFbiAyq
 PTCjdHKviQjP4/lxV8Bs9kp/CPFUgNS4XDHAoqOHOI7xnFGl8aAeEPlpOxKy6W/R36Wy6zFOAFw
 2+Hneqrr4HNpUQkHWF1HucCgljS3D0an8JK8UU1OPoLDyOmlXFcM0JSa3hZDG5iVR+hsjKYp4Xu
 wH2XdNxWfX/U+ztOEFwuRal3Q5XEFse8MT/Pn/+UPdZAVxMuIJoFmLWuhNIEgnK9yXt/z7ZjfAF
 Kd/ahr9ewxdWFBPGfPwMQW659X1vlXYldBPJ/d0SJQ2Rrk8Cpcg1qhKB4+ZHLUD2rqKvCYVHf9v
 4IdqK5SeXWM8XqfnOo0nGp6PyEiA6Lghp1LWzB+OGI7dhw7mcrLNwkyVabWjLRUwghLk7HIh5eu
 FHFigrxnhh6iaUsgl/S5C1irGKJbwVJvsDc6rHH6ZL+NZTFo673X/eAsEp
X-Received: by 2002:a05:6000:4715:b0:47f:c648:e265 with SMTP id
 ffacd0b85a97d-482f79bf064mr43460229f8f.17.1788170517324; 
 Mon, 31 Aug 2026 03:01:57 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:3bc1:c53b:30b:203e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb33070sm22362383f8f.36.2026.08.31.03.01.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 03:01:56 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, qemu-stable@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 3/6] io/channel-websock: handle a blocked write during the
 handshake
Date: Mon, 31 Aug 2026 12:01:48 +0200
Message-ID: <20260831100151.914178-4-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831100151.914178-1-den@openvz.org>
References: <20260831100151.914178-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=den@openvz.org; helo=mail-wr1-x430.google.com
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

qio_channel_websock_handshake_send() treats every negative return from
qio_channel_write() as fatal and passes err to error_get_pretty().
QIO_CHANNEL_ERR_BLOCK is negative but leaves err NULL, so a socket
which cannot take the response immediately crashes QEMU before the
client has authenticated.

Keep the G_IO_OUT watch armed and retry instead.

Fixes: 2d1d0e70cf3e ("io: add QIOChannelWebsock class")
Cc: qemu-stable@nongnu.org
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 io/channel-websock.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index 66c91ed2a2..8f27b1f12b 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -562,6 +562,11 @@ static gboolean qio_channel_websock_handshake_send(QIOChannel *ioc,
                             wioc->encoutput.offset,
                             &err);
 
+    if (ret == QIO_CHANNEL_ERR_BLOCK) {
+        /* Socket buffer is full, the G_IO_OUT watch stays armed */
+        return TRUE;
+    }
+
     if (ret < 0) {
         trace_qio_channel_websock_handshake_fail(ioc, error_get_pretty(err));
         qio_task_set_error(task, err);
-- 
2.53.0


