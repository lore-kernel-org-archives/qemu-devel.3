Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF8CC54FC6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 05:32:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJQPn-0007Gr-8K; Mon, 26 May 2025 01:30:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uJQPe-0007AO-18
 for qemu-devel@nongnu.org; Mon, 26 May 2025 01:30:15 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uJQPa-00021s-0k
 for qemu-devel@nongnu.org; Mon, 26 May 2025 01:30:13 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2346765d5b0so4067315ad.2
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 22:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748237407; x=1748842207;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZYkQmyhIuCHC0Np+Abs5u1kXwWUosVTvjnG7zE5d+24=;
 b=LA7a44MYtt3/bPzbIBBqtC3CzedhOcQiDrnbe9uNG1/WJ9MheCzgFSq/hifqOlkPpA
 TnISPKxVcbIJcOCra5U04jM4n2w0yOG6Dq9BOxVnY9BtxorCjeB0dnoMVl7s5VkFRMUz
 eq6dxxU20IZN4/McOsaVwj4ngPLk8ouHrM1dhmKIhXN5Nt958h7sP1qT7blwR6TP3OdY
 y0XFEBkWvTNN5s8qHZ6PVX3sVOVVDGkPV8IPmJAiOjQhJNYc+mmyitrkC+iePJKO6uA7
 b9NwJgqlTabIiYQ/CcG1lioG5x6I3gED2P6aS6XRXpoyu6l6FdqBL/CgFFs0/6l8npfS
 ufTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748237407; x=1748842207;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZYkQmyhIuCHC0Np+Abs5u1kXwWUosVTvjnG7zE5d+24=;
 b=Xy+zu/jV//12KMHcsray//50EodHceLhyOT9ZdllDYpjWcHG7swbMMFHD2VJf6z+Ir
 Wz53qFXtRFQTn+icIptws3pcMeO1tgyKKO4j5xbsPvQcOGNUM7lVyBUks5kFqUZ5DBQ1
 TXu8cCH0JwBvxmUJi/+W7ILswOakvEBAD2h0QZmGKvnlPHQVvEw5TW/qWblvgiuwJiP6
 GxP8Zrh6OqE6qHvROKYPvOBifo3UDVdzSYP8oD3138L7vKCRyhlzaI4sEYYd+QWzBroQ
 TzkFfeTOw6oigNjLxhSfrkdYMpnRx/GN2LwcPL0dsiit8t5VfWAYLubSXyVvdN9ICIe8
 YNvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWThdi/5g9EdA7UNyWGdFp1Q4DZnDhaLdMtIO6tWdWDV6EGX2cUYjL5kEPndvJJ52ozkG+6y59XVN6w@nongnu.org
X-Gm-Message-State: AOJu0YyVHGWvwU506UxC3wHab0ZfjlN+ReH/QXQikq+ZjeMmQ+s3+5Eo
 69+L7pawXNQoXft5eF+iYZzafLLkg7Bt+uZ0JitRTNRT1GGUSXaIIjZ9OLFqH2kYG4PNoJLRLd/
 ww4vo
X-Gm-Gg: ASbGncvuNOGyB22q0BwVOfP/Iiyvqc7tnhmArnAeRWS8kZYOtC0EgTt7fc7haW4sDZa
 XVUcMT4Ru4oZF9Ss/NT8S/g83vlOvCmOiNxffkJMoZYcKlcX4GCYPLtRMGsuC280E0fxsiT89MI
 o9Oi24O6i6lryT/qtsfQ1Pb4IDuLQ8JVA1ItviYvogj97MUdWi42m+rS/wF80A6WYmzjBikhkU/
 FDudwHrrEPL7NebvTMxl2ii+ou8UQjEt3EtTH7Yp3rHXKtIlWTyml3RmmdVB2WxsCIHfcIUVPnZ
 sW8LfYYaxBQZyw/z+UFBOV9gX3lNbvBLIn8k+RBBrLg/9/ziPuHqaIpN/YMKPOA=
X-Google-Smtp-Source: AGHT+IH1thV4tHLooqSK1qFnlEmeAuBlEHlijRiTgWl0W8c8q/ocx1mqT73FChp6hTXhbvrbKUwZuQ==
X-Received: by 2002:a17:903:228c:b0:22d:b305:e097 with SMTP id
 d9443c01a7336-23414fd3e53mr107642665ad.50.1748237407282; 
 Sun, 25 May 2025 22:30:07 -0700 (PDT)
Received: from localhost ([157.82.128.1]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-233fd7d561csm43057825ad.101.2025.05.25.22.30.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 May 2025 22:30:07 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 26 May 2025 14:29:21 +0900
Subject: [PATCH v4 11/11] hw/display/apple-gfx: Replace QemuSemaphore with
 QemuEvent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250526-event-v4-11-5b784cc8e1de@daynix.com>
References: <20250526-event-v4-0-5b784cc8e1de@daynix.com>
In-Reply-To: <20250526-event-v4-0-5b784cc8e1de@daynix.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org, 
 devel@daynix.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

sem in AppleGFXReadMemoryJob is an one-shot event so it can be converted
into QemuEvent, which is more specialized for such a use case.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/display/apple-gfx.m | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
index 8dde1f138dce..174d56ae05bc 100644
--- a/hw/display/apple-gfx.m
+++ b/hw/display/apple-gfx.m
@@ -454,7 +454,7 @@ static void set_cursor_glyph(void *opaque)
 /* ------ DMA (device reading system memory) ------ */
 
 typedef struct AppleGFXReadMemoryJob {
-    QemuSemaphore sem;
+    QemuEvent event;
     hwaddr physical_address;
     uint64_t length;
     void *dst;
@@ -470,7 +470,7 @@ static void apple_gfx_do_read_memory(void *opaque)
                         job->dst, job->length, MEMTXATTRS_UNSPECIFIED);
     job->success = (r == MEMTX_OK);
 
-    qemu_sem_post(&job->sem);
+    qemu_event_set(&job->event);
 }
 
 static bool apple_gfx_read_memory(AppleGFXState *s, hwaddr physical_address,
@@ -483,11 +483,11 @@ static bool apple_gfx_read_memory(AppleGFXState *s, hwaddr physical_address,
     trace_apple_gfx_read_memory(physical_address, length, dst);
 
     /* Performing DMA requires BQL, so do it in a BH. */
-    qemu_sem_init(&job.sem, 0);
+    qemu_event_init(&job.event, 0);
     aio_bh_schedule_oneshot(qemu_get_aio_context(),
                             apple_gfx_do_read_memory, &job);
-    qemu_sem_wait(&job.sem);
-    qemu_sem_destroy(&job.sem);
+    qemu_event_wait(&job.event);
+    qemu_event_destroy(&job.event);
     return job.success;
 }
 

-- 
2.49.0


