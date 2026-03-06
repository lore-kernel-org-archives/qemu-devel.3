Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8475FCB608
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:04:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWf0-0004Nz-70; Fri, 06 Mar 2026 10:00:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWex-0004H5-Kf
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:11 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWev-0002iv-SP
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:11 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4836e3288cdso63302955e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 07:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772809208; x=1773414008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KTmpT5vuJNgghnJL1HOs4npdoQcEgc1RFWY9F7V6Wog=;
 b=GrYQATRsr1+d7+Zh4qvHkAEMkT/e6ZYovqI8efbmllP0lWVDgUA22HxYDC70+nL9yy
 DHkywgFljevc3pJrvIcKUFAhpvWRwASdol1lTWNZgtJR/bTpljDfmaNSoFxItuR0sp9m
 RS6EFoItjPuVQCQlF4uIeyjMwnsn2zVtAbVcSRlVNsKOGnPMyRYJupKHON5qI5uhVs/g
 VcZWynbLidFYhBKw9T6UQurot9D+2M85DJ9GLPt0jmF9/Ykos9HpZFdZb0XrBRrIqdjT
 kKGJdJxDv9/xfD5AMzyDOhGmVwwf/aFbhexTEF/7174kajELkyDeY+czYP2I2RUPzJjl
 k7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809208; x=1773414008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KTmpT5vuJNgghnJL1HOs4npdoQcEgc1RFWY9F7V6Wog=;
 b=STzBs+qcmIUARoilMQOY5g9bNthdbPgogcE7UMvboD+bdK/t9bfrBMbjvBqj57+70h
 l9as915nKvhs9mvpZuGEwN4PCjae/BuOCD13uxwdWTSfLE4GsEf/CvRHj75DTBPEorye
 gGQItog9S1T0RaN3ihKlW1wsO6o3K+guTDkEoM6qfFbCNr6WwOkUOnUKIAp0Di+iSK3e
 qFss3Q7Om5lGCgGYiuKYis9SqSt90N6HjKWZWJKvB9+DhCfxmo8mhxdSJAhInQu2ht29
 lj2PKRqIUCsnV1ZmsYrOxQg4tyhkWQS7svigaLYph6qG816zeqI+nTps/DKY7clMUYkt
 aPJw==
X-Gm-Message-State: AOJu0Yw1yHOtDZkL7A6phrhVI7BxrBpzGWs7iFAxujK42PHovMjPJkUI
 A1PGZF1jOPhzl8FQNO5rLXnNx461XQ6xv/DMsWsge+X5DXkTbz75ZVCeGcMInE13kBahJzj7YkE
 PcWKR
X-Gm-Gg: ATEYQzxRyYW8JaC6rwpdW3PJ/v/Uqwhh4tB1nLnH6h/e1drX/Ju4pyhBCqCtF1xv24T
 wvYMr3v6muE9efLrxZM9EHwxrI5+HMAVQ2QrrdkEkHAdzE2h6lRkZzfnQxPIQschvROuuxbWoVK
 A5CqvvCY5cijAO+Gkq6lhShAHl0qEOTYImhYwwD4wVIHCcNCv6jWXxe/fWZ0sOMG5COkHeZwjge
 4b3zxfQWkHE/pu67BVTq53xJ8WoLfD8t9EE66dakxVvOnsZwFvCJwkTzoMEsANEJA1Wt0tngp5z
 hQaXqzbtc2/EdQgUcIYMEWG5z95Pk/O1MWp/7/b2FYZkEWePKW+hdhB3MGTlxWMUJCbLsY9x5wS
 DdO9irzdeDbipHnzIYjvTZyl5pPm2mk4EJtZji8pzlKvsbaX5jwKWm28/2VfMpNWsrz531xs2+2
 F25dp95njVMyer2b03mOiiGorloPh9eIHSiI5OShTwDMzwFT/wX5LWK8sFhgez4UAu19OLFmQNT
 Myw6+E14DpRVgyPY2SJV8swRkw00AY=
X-Received: by 2002:a05:600c:4686:b0:47d:403a:277 with SMTP id
 5b1f17b1804b1-48526715257mr36935345e9.4.1772809208146; 
 Fri, 06 Mar 2026 07:00:08 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246ece8bsm28681845e9.4.2026.03.06.07.00.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 07:00:06 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/49] chardev: Consolidate yank registration
Date: Fri,  6 Mar 2026 14:59:17 +0000
Message-ID: <20260306145939.2162189-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306145939.2162189-1-peter.maydell@linaro.org>
References: <20260306145939.2162189-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

From: Fabiano Rosas <farosas@suse.de>

There's currently five places where the yank function is being
registered and they all come right before tcp_chr_new_client(). Fold
them into it.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260302092225.4088227-8-peter.maydell@linaro.org
[PMM: rebased]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 chardev/char-socket.c | 31 ++++++-------------------------
 1 file changed, 6 insertions(+), 25 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 4e82915cf1..e064b105c5 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -905,6 +905,12 @@ static int tcp_chr_new_client(Chardev *chr, QIOChannelSocket *sioc)
     s->sioc = sioc;
     object_ref(OBJECT(sioc));
 
+    if (s->registered_yank) {
+        yank_register_function(CHARDEV_YANK_INSTANCE(chr->label),
+                               char_socket_yank_iochannel,
+                               QIO_CHANNEL(sioc));
+    }
+
     if (s->do_nodelay) {
         qio_channel_set_delay(s->ioc, false);
     }
@@ -943,11 +949,6 @@ static int tcp_chr_add_client(Chardev *chr, int fd)
     }
     tcp_chr_change_state(s, TCP_CHARDEV_STATE_CONNECTING);
     tcp_chr_set_client_ioc_name(chr, sioc);
-    if (s->registered_yank) {
-        yank_register_function(CHARDEV_YANK_INSTANCE(chr->label),
-                               char_socket_yank_iochannel,
-                               QIO_CHANNEL(sioc));
-    }
     ret = tcp_chr_new_client(chr, sioc);
     object_unref(OBJECT(sioc));
     return ret;
@@ -962,11 +963,6 @@ static void tcp_chr_accept(QIONetListener *listener,
 
     tcp_chr_change_state(s, TCP_CHARDEV_STATE_CONNECTING);
     tcp_chr_set_client_ioc_name(chr, cioc);
-    if (s->registered_yank) {
-        yank_register_function(CHARDEV_YANK_INSTANCE(chr->label),
-                               char_socket_yank_iochannel,
-                               QIO_CHANNEL(cioc));
-    }
     tcp_chr_new_client(chr, cioc);
 }
 
@@ -982,11 +978,6 @@ static int tcp_chr_connect_client_sync(Chardev *chr, Error **errp)
         object_unref(OBJECT(sioc));
         return -1;
     }
-    if (s->registered_yank) {
-        yank_register_function(CHARDEV_YANK_INSTANCE(chr->label),
-                               char_socket_yank_iochannel,
-                               QIO_CHANNEL(sioc));
-    }
     tcp_chr_new_client(chr, sioc);
     object_unref(OBJECT(sioc));
     return 0;
@@ -1002,11 +993,6 @@ static void tcp_chr_accept_server_sync(Chardev *chr)
     tcp_chr_change_state(s, TCP_CHARDEV_STATE_CONNECTING);
     sioc = qio_net_listener_wait_client(s->listener);
     tcp_chr_set_client_ioc_name(chr, sioc);
-    if (s->registered_yank) {
-        yank_register_function(CHARDEV_YANK_INSTANCE(chr->label),
-                               char_socket_yank_iochannel,
-                               QIO_CHANNEL(sioc));
-    }
     tcp_chr_new_client(chr, sioc);
     object_unref(OBJECT(sioc));
 }
@@ -1180,11 +1166,6 @@ static void tcp_chr_connect_client_async(Chardev *chr)
     tcp_chr_change_state(s, TCP_CHARDEV_STATE_CONNECTING);
     sioc = qio_channel_socket_new();
     tcp_chr_set_client_ioc_name(chr, sioc);
-    if (s->registered_yank) {
-        yank_register_function(CHARDEV_YANK_INSTANCE(chr->label),
-                               char_socket_yank_iochannel,
-                               QIO_CHANNEL(sioc));
-    }
     /*
      * Normally code would use the qio_channel_socket_connect_async
      * method which uses a QIOTask + qio_task_set_error internally
-- 
2.43.0


