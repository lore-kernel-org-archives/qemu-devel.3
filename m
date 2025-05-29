Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 431C4C54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 05:47:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKW6K-000367-6s; Thu, 29 May 2025 01:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKW64-00032Q-QK
 for qemu-devel@nongnu.org; Thu, 29 May 2025 01:46:36 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKW63-0003DP-7n
 for qemu-devel@nongnu.org; Thu, 29 May 2025 01:46:32 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-234e48b736aso6837935ad.3
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 22:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748497590; x=1749102390;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qqii+YjN2Cl6J4vYDZM5guaZ91Y62BmZ1UnSf5EAOao=;
 b=v3KgyQgSLssZYzsrlFVdnDHUSLfGa+rkaBIg+w/H/nBzMP2397eJiZRdzzzYyCS9Ko
 QnfEr8e2i85NQtAtHWZys7HXh9qVo1wdUHM/1aPL0VsuqOcZxqgJJfT0t4UJmWoU9GIy
 3mOUVcvm8np+fq94eIVELrrrLDOnb2tcLs2mbL3eiBxDwExMkp8SwCuBl9OMweCtYlw9
 UUqsj34EuDn3rmuyQD9uTl3xRqFwLezRmnCzn+ArRsJ4pGMOo6vKJN3mgqLlySwO9+Hn
 gewzO/cBhk9OG4IlEs9Y8oPHZpkOLHqTDeLn18XxNJffSVG2qXcPXEbzSS6qD4n3fROt
 HRpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748497590; x=1749102390;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qqii+YjN2Cl6J4vYDZM5guaZ91Y62BmZ1UnSf5EAOao=;
 b=F/jNY2mNAhlksQ5aC1zp75Mfv5HpSmeQlpp0VgWWkTuqWBYJO/UIMgNs32VzJCCd9P
 rCYlcfYdQWIMIcU5GHCIFS/h6hNlBG0mApGzlsNHQIFJMKaFEbgDIPELkuaEllnh9mWy
 fQzsknYfIe0y2RRyte2sg1/f1bD+q3yrtRwseZl3EWFDEAtQGPITkmwh5UpwE5IcshFO
 C5tDOJP9g0n+H7BwNeD4x1JBYvrlbGxT4s+OMjJOwXTwIvvBuJbbvifDOnZOcj5j7C8q
 TJ6VBegrQKvi/CdEFjecM4cOdRFuhygMEUg2v2rpiw8j9yBZOCwl2I1mcP64MdX5HqrA
 nOuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWk4Iny9LnfhmoQePdEb1JQ28295lFwRw9j6N0QuCaZ9I5zmYiXBAqJ4ABmyO+nwVICAhhlkjq604c7@nongnu.org
X-Gm-Message-State: AOJu0YytmYvWi3ETuGNlj4/PcDN7uCevJ8x9Chudnqbc+hTeSBlEROMK
 5c/Tyz1qaq+CFc8l7RHWjSb0okrA7UD8yRnwNxrUMFr4stvKtoIB5tm1LygVcX6hwMU=
X-Gm-Gg: ASbGncvxBqFGM9cWyALESrJAouafkMYAZKaN+297ybFy9bDPsqUFlrjA4NlLW82u4SS
 G6wAdfpJROH1Jfy2R6HxmdGWETdpDFn2WKLOCStCcHdFuV7UrRfD9+9FRTN6Ro7fVM4s5NljDht
 iF/7veKRLnsW6hb+1eah/fw725XEWtdcCA4wLlNLVprLAPCbeTavsi7th0LY27qLSct0AKuv6lW
 MZzx7Aed0RMJoREqHPsEZZEPzaJUSW1b3HwgKoYUmscsIG5JsgGjvtQzo7JoIa9rIJv8dMXk4VP
 zVy9cSUTVq5kKRE/yX6lEDDoJud9xxqui8kiXr4bkkOhVANiCWCzfOPr3eXi3FU=
X-Google-Smtp-Source: AGHT+IElIO1iKrYjzsW2mTypaj7HvcccM9R6tmZ96Dkxj2q+y/oUboQUNldMzILEQOeouFTqlZhx5A==
X-Received: by 2002:a17:903:1a04:b0:234:8f5d:e3b6 with SMTP id
 d9443c01a7336-23507fd74f1mr10971865ad.3.1748497589798; 
 Wed, 28 May 2025 22:46:29 -0700 (PDT)
Received: from localhost ([157.82.128.1]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-23506d16e04sm4957575ad.212.2025.05.28.22.46.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 May 2025 22:46:29 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 29 May 2025 14:45:59 +0900
Subject: [PATCH v5 10/13] hw/display/apple-gfx: Replace QemuSemaphore with
 QemuEvent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250529-event-v5-10-53b285203794@daynix.com>
References: <20250529-event-v5-0-53b285203794@daynix.com>
In-Reply-To: <20250529-event-v5-0-53b285203794@daynix.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x634.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


