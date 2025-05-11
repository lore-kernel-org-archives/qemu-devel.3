Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B84C5C3ABC3
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 06:11:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDzsa-0002r3-3b; Sun, 11 May 2025 02:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDzsW-0002cQ-Fn
 for qemu-devel@nongnu.org; Sun, 11 May 2025 02:09:38 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDzsS-00040s-5T
 for qemu-devel@nongnu.org; Sun, 11 May 2025 02:09:35 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-b0b2d0b2843so2555679a12.2
 for <qemu-devel@nongnu.org>; Sat, 10 May 2025 23:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1746943770; x=1747548570;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lXkLBQVBnrrMrhsmOOZFkEPfxHy4LeQpaKTeFVKaZdI=;
 b=uA5/0uVL2tTWlSg8AkvcA2ANWgnKXQqEnMwfnGdpFlW+81raWVzJrcg1Q8O2ln/V+B
 ax0V+ayusc0ChzfsMCtqeCd/LKNMl5s0P0GSk5HlCRWHjmhFfeIa87k6EbfzVhMum4X0
 JQuCApCyvcnADfzYMMjWAXRuqlDSKN3pooalTFVT8dtpRRiUcfD3vJYP+xwvPuG0Cvas
 PCConrD7Utm2/sS+QXXfJJRKf/MnSQFhx0YwvPVjZTKhORqDKze1pH83YcWvILrcVWeT
 ABh4siwB9/5XGDJQY8dDLfYgBSTWi3oQ2QL0G68DIs6s4WnxDlTl2ldKGESSycfGvbpV
 vh0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746943770; x=1747548570;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lXkLBQVBnrrMrhsmOOZFkEPfxHy4LeQpaKTeFVKaZdI=;
 b=PSEeyobPS9VrgjUs0uixaj5TgjiQwv/XBnZAIR58nDbvaHBStDgAfiLqGkQ5Qqzknv
 cOkFIwy4CI6iw8uVa5Y8KZJ859AKuCoh0AOCDClE6zmDnN1ewWQM8p6lkrBiinqsiMbT
 V+cvC4qERviamp2XMcViFGMlKBlGNjPYwSKvwbUy4+fKwdYwV2d7JnB/yNJuk1Q6Zh9w
 T+Gyu6vP6vIOFomj51IA6KB8Es4QhrOifvml/cl/BivyQnC5jcUvG+aYbEpabl3cqaaC
 JwiDoyhwmtATGd6vqAVE/ONoPQGtQyYBItBRpUwSvxSvnPEQNBcodGHXljWcQ+m4tTUb
 aVxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUq4l4+3fgfuvPr2f3fjzVTDeygvYFxVxZj6doQRBMYmtx7NxHyxmDoeeOabNgYZkFshvyNY+ClHDdy@nongnu.org
X-Gm-Message-State: AOJu0YyJ7yXFM9xTa2Y8NXdur9mSvRussBjm8r2swW3R+3DStIptzrOs
 KQKnEETjsRfJiKE93adt8UKPkLzc4wGPALwSM8aT92EUiBU1wy2RaXPQo+1EujI=
X-Gm-Gg: ASbGncu3lobOlM8RUZGVM5cOWn2b9s9pEp/LRF+b9aymmh+kISS3Tk06iA67nI3gnFJ
 JkjwzDkNS9kPRi+DxPPVpatw1N8y6noiqhTg88h1dt/obsuz/t8oI38w0tgy0raFklbvy5DCqpv
 t5giIWkxe1Zzo7ZpFy1yFlghOc8jYxHsmwV9U0BElNxUcSQ1p7QL/dqAZth4wdICKlr7BBV8cY4
 KEi4f3S1p6G4Ntlhgep4Xp5gtfF1vh9wdcHZvLZLJc2pqPFsWW4flg40U9sO4H+D422J1Eq8/GO
 Bo8LngQ4xJZivRRSAXodE5jmdlbw+lvNEEjxgpDI7rtbJVW6W9jZtqU=
X-Google-Smtp-Source: AGHT+IH/AL0oBu44MfYJFMrxE5lgUniLBxUqRlo3+i3cimp5xsDQNb3GXroJw/cK+d/bLUuDtij+4g==
X-Received: by 2002:a17:902:e887:b0:22e:61dd:8900 with SMTP id
 d9443c01a7336-22fc8c90a71mr125081725ad.29.1746943770007; 
 Sat, 10 May 2025 23:09:30 -0700 (PDT)
Received: from localhost ([157.82.203.223])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-22fc829d668sm41246475ad.201.2025.05.10.23.09.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 May 2025 23:09:29 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 11 May 2025 15:08:27 +0900
Subject: [PATCH v3 10/10] hw/display/apple-gfx: Replace QemuSemaphore with
 QemuEvent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250511-event-v3-10-f7f69247d303@daynix.com>
References: <20250511-event-v3-0-f7f69247d303@daynix.com>
In-Reply-To: <20250511-event-v3-0-f7f69247d303@daynix.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52b.google.com
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
index 2ff1c90df71a..173fffc86ef1 100644
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


