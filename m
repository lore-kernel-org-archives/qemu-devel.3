Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF6BFC02188
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2025 16:41:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZBsy-0003x0-Jt; Sat, 18 Jan 2025 11:41:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tZBss-0003wM-6d
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 11:41:18 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tZBsq-0007oM-Ps
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 11:41:17 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aa6a92f863cso579483466b.1
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 08:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737218475; x=1737823275; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIPWAoeGDqsyBcSrsU1gBMWUp3dbZoF1r347tTfkcPM=;
 b=SfXs+hI3hq63fGpDcoX8p2oFDRktJBNPe/+mqxDdfbQHk2vpw/8rUY2xh8JVsphOJi
 7iWCDJib/HekgIMLD+A+HJErNsORocNiWDtVpLetDX9Sua5pdq4m+kYzFrTOw2amdKV0
 n0T3pSIearOCEbbv9NVggWrbeQdkqENSh8IEHDVQ/j6l6+zx6d93QGpFiBUdRBGg/7ex
 qoc/0ZeijcL79th0fZSDytS/W6IFjSuS3EIXfiS1KPQxVHdJoEqpq8sk/SB/uBXOTRun
 mqvEUWOcP7uV8Q/LBzbFyXkLAO6XMwZTDOlIHb3ugCsm85pc2w+jkZoQQAJf4v8xnU8i
 fZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737218475; x=1737823275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nIPWAoeGDqsyBcSrsU1gBMWUp3dbZoF1r347tTfkcPM=;
 b=NwX0kRvqGLp5PByuVLDm8URfDud9kxU+9UdJDoKBlIxz2y2pvEo0L3/CPW1u4c2qnK
 bJ9+iOliuR9V13RStGocZPRUS1BpW59W8la8fmCRq63hI3UZ7HYhIw/g/R6K3/Tqwa8Q
 viASkrSiNxBUzNDg0iPVUeAdtIisIIjALl1JQV3yudBQn1MjZbFC1t9vC9Fv/GRrxhoO
 OESGfRqb4EbcpqUdR0zZD3R9yygwnKHlLIdd0mFiRd9Y/86pTes9m7DynPyhZsjJdIpE
 DOIpfQXzq/HrLw9Ts8PmiEZpVrt5g0vk80LZSgkJdEcebO7TWBuz5k9uMyb/WRGwwmlM
 QZbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdIrlXsC9eNGK66B8vd70QVY8EYR5hFxjAjlIo+gMjiN6qFBT+niVNf0/Cm6yKwf1KaLCfqf2/wPrk@nongnu.org
X-Gm-Message-State: AOJu0YzwVvL6qg4xZ5hIZn/7zD6f/tFhKdGaq+voltFrDopYOrDXVHPJ
 Rq1Co3FmggxVcFy2gR+RaDwd5Ooa5OotobjoO8izA7h73n5AjeyLK66HMg==
X-Gm-Gg: ASbGncvwVqSpIgcDay8h9C2v98n1huwyvrT7GBLtHqaT6uOw8kVAFbrcNac9iiSoyAp
 VXI3uBHOznr9g7TCsqR5LkXmSnPwq91o+GWQrCxa2t1/HLCI0VbOC6IgyY1fDk2SYTlhFanXFMq
 p/XHYjsPO6neJEAaRghK1OCaovq8q7NanBy7AYQv8SyNsOaRMFeqJqX3rjAV2QQYzeKFhfyaZT4
 zQnqpGuv9kCEutsQk+W5G/L68Uc8iEIFy/bADZEneJkJS81IlchSBmEs2223NJhFfkhX/1aQGLx
 sOc=
X-Google-Smtp-Source: AGHT+IFaE9AcVkpMcTW1FPwREWX7vqAnBzVZRki39Gifmf5UR8j72jn/2xoMHQKg+dO53+HjFSNUsw==
X-Received: by 2002:a17:907:948a:b0:aae:8843:9029 with SMTP id
 a640c23a62f3a-ab38b4aa395mr623622666b.48.1737218474693; 
 Sat, 18 Jan 2025 08:41:14 -0800 (PST)
Received: from think.fritz.box ([2a02:8109:8384:1400:d15a:20d8:4bbe:9a4c])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384f8624fsm358331266b.150.2025.01.18.08.41.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 08:41:14 -0800 (PST)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v7 1/4] chardev/char-pty: send CHR_EVENT_CLOSED on disconnect
Date: Sat, 18 Jan 2025 17:40:49 +0100
Message-ID: <20250118164056.830721-2-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250118164056.830721-1-r.peniaev@gmail.com>
References: <20250118164056.830721-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=r.peniaev@gmail.com; helo=mail-ej1-x629.google.com
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

Change makes code symmetric to the code, which handles
the "connected" state, i.e. send CHR_EVENT_CLOSED when
state changes from "connected" to "disconnected".

This behavior is similar to char-socket, for example.

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
---
 chardev/char-pty.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index cbb21b76ae8d..10a6ee94d55c 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -181,6 +181,9 @@ static void pty_chr_state(Chardev *chr, int connected)
 
     if (!connected) {
         remove_fd_in_watch(chr);
+        if (s->connected) {
+            qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
+        }
         s->connected = 0;
         /* (re-)connect poll interval for idle guests: once per second.
          * We check more frequently in case the guests sends data to
@@ -215,7 +217,6 @@ static void char_pty_finalize(Object *obj)
     pty_chr_state(chr, 0);
     object_unref(OBJECT(s->ioc));
     pty_chr_timer_cancel(s);
-    qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
 }
 
 #if defined HAVE_PTY_H
-- 
2.43.0


