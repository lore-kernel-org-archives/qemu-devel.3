Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97CABC61CE8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 12:43:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNWKH-0004Py-1V; Fri, 06 Jun 2025 08:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWJD-0003dk-WB
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:36:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWJA-00060T-IL
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749213385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nqN2/3dN5WRDFyaAoAC2T45y6AZxZzkgkMVTfl+kruc=;
 b=GM9htjXkTdRK45eAXeh1T+1cbBJfBt7jNucIy7X1kGfOD2lZE/eLJspt/GBIWewqxR4u8O
 2hDiUaWz6XAquy6ZSpX+vkPljD2MX7GS+4uTATaOfV++VBoJCxYpM7oHk6P32Xq8lQYkPn
 tGZ2lIVNb46XCD+gjt/6mR1r9yZdUZk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-39zIrIMrNly-ZpX0YgeLZQ-1; Fri, 06 Jun 2025 08:36:24 -0400
X-MC-Unique: 39zIrIMrNly-ZpX0YgeLZQ-1
X-Mimecast-MFC-AGG-ID: 39zIrIMrNly-ZpX0YgeLZQ_1749213383
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a3696a0d3aso857858f8f.2
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 05:36:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749213382; x=1749818182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nqN2/3dN5WRDFyaAoAC2T45y6AZxZzkgkMVTfl+kruc=;
 b=hhMPrTZ7Su1bm0x3IbXyYfqjSbFL+p7JSL1W+BpCbq8HVkpQDKq/4A69/tq9GbbYMe
 pXDMa9vpOGGLl4w2Et53RAGBBEBhEdTE9eSVJoeQR35Cv9xUVeJBwEqq6gsfTvozATGj
 YSH3Te/1N0W71wlBqY5tX0RqHlFl0DD9EzgIGK8C5XpMQEhHa9BI2y+DqMullS1vC0gT
 7ClK+nPcIij7xKeDY0DnL7/0sy/YyAqjze25NcgWFbDR5A1awpirXyXdLteZIKO6QTOr
 /c1Bjti7URjEcF9womz1JJyPlp6s8Q7Y6VPencf6BF5mlfkQbi36CW0uAQIau4fWyuSI
 1BKg==
X-Gm-Message-State: AOJu0Yz8WJCATocfq6w9VtjlU6vMNZ+91pOMzZU0L9KVbLDkDxaQ+Z59
 h4EKZl7NUMOsUpgS8GKXawFe1sY7ASkp2jzWNIiOcyoVb8h9Ou1D0KnJdJRfHSX0Cb7KcegKMKm
 UCaw5VWMAM6A7YH4xR6zAWMTVAt5vnrV6/v6VMse85QdB+8yX2XqykCPrhQV4aKqD06h0RILJwl
 4h9ClQGM+k4Vg7Ech3RyyljJNYzCx2xmmi/rih43ge
X-Gm-Gg: ASbGncuJLCjPiMBKse8xHKFAACxKGaLPLeZuEqVmBuzVD0TRJo2raPhajvR20yjYxC9
 F3u9AWfw2uvuXbIuf9AgoBhXkK4YtZCIkylnxhLIjC5hlLPeZmXuQr0l+tHvCZcCoUgkYI3wd0w
 A/oDIfprppGtrGWDdZt2XwcIRiDYMigDwqfa0wnHlqLfbI591qoHLXxxKwcbxc2e1m/015pEWah
 klmZDSoT7bWaoO7Ux39dz/ehtn8aQmgLBaGfoYNAEPknAkyG3VYbAcPJZApC0Fe5y7UcNGGwa1c
 fQMjKgv1AeG2EQ==
X-Received: by 2002:a05:6000:2082:b0:3a4:e8bc:594 with SMTP id
 ffacd0b85a97d-3a5319b9ab5mr2634788f8f.8.1749213382181; 
 Fri, 06 Jun 2025 05:36:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxpUYtLAXmS4ySsjqrnbDvzJlU5UuctilfsfEbmAQwZ3I83ofxTllRY+Am+3jBs2eAsSK++A==
X-Received: by 2002:a05:6000:2082:b0:3a4:e8bc:594 with SMTP id
 ffacd0b85a97d-3a5319b9ab5mr2634767f8f.8.1749213381702; 
 Fri, 06 Jun 2025 05:36:21 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-452730c7756sm19981615e9.33.2025.06.06.05.36.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 05:36:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 27/31] hw/display/apple-gfx: Replace QemuSemaphore with
 QemuEvent
Date: Fri,  6 Jun 2025 14:34:41 +0200
Message-ID: <20250606123447.538131-28-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606123447.538131-1-pbonzini@redhat.com>
References: <20250606123447.538131-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

sem in AppleGFXReadMemoryJob is an one-shot event so it can be converted
into QemuEvent, which is more specialized for such a use case.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20250529-event-v5-10-53b285203794@daynix.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/display/apple-gfx.m | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
index 8dde1f138dc..174d56ae05b 100644
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


