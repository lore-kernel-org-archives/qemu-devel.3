Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F89C3ABC3
	for <qemu-devel@archiver.kernel.org>; Sat, 10 May 2025 08:53:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDfwp-0006ek-1D; Sat, 10 May 2025 04:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDfwn-0006Y6-6c
 for qemu-devel@nongnu.org; Sat, 10 May 2025 04:52:41 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDfwl-0005f1-Kb
 for qemu-devel@nongnu.org; Sat, 10 May 2025 04:52:40 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-30a93117e1bso3867891a91.1
 for <qemu-devel@nongnu.org>; Sat, 10 May 2025 01:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1746867157; x=1747471957;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lXkLBQVBnrrMrhsmOOZFkEPfxHy4LeQpaKTeFVKaZdI=;
 b=ticPVoY376LOlRuhUSgiWBW7qw8GVMweJ9g9aPPNYYM7MXEcuIVLPFDJ2+QGTsULX4
 HFho6LGDrQHHNCrUTTHCjo5Y7CPyCjosXsUBtNKRmC933WvjQDeL8G4RkwyDAyUuc997
 Ab1A4yU3pYTvtpM9PLvVP+EUltXc/HMAxtr6sV20eOnVEdsOGfJkTwykYlkCzPMS5yMP
 RGSQiT2FR8oM8OlWD6lOSATPcSiumAMVtixIzMfasXAGSixV9yxBOED4yprvynPQRBFA
 //Q6wKM18blA+Q11oPHAgPLadrO9b6fYOJ8yjtEqozbUlgTApJ3UOkT2/KuK7QwvlP24
 BEcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746867157; x=1747471957;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lXkLBQVBnrrMrhsmOOZFkEPfxHy4LeQpaKTeFVKaZdI=;
 b=naM6yFlccg1ZalIeVmTT+47IvMjF5SEP+oay3L5gd1r7Ddua8w/0wDEd7h08PmrzO8
 Rvm81MCGRr+X/vaZ5LgUH95ew4ZsmwEy4BuyiVYkyIjbVZuuyfSYOIKSR9dIZCgaOMBV
 YUFblZXTrlGgJIxANzDW/cPEuI6xy+WHRUm6zfBrlEFEyVpF/zHZgM0ARk1IhrLeE5Jo
 Xt4pyICxa/YWU5vtblmI6x1ARzrLPps5YKanI5RwQr8Xx2YT22o365Rx1aW60434sMzM
 6jvm3stquT7HDYk+CbKWff6EtGHexlKkQUE0/CTBYkfxpQYq6nQ3/D872OhiwTf63jBH
 KRKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVySHPZsrAeDeVan6MHZqgs2lIpeZmZ1d9aExkyb0BviRFqG7jtDYrwW/chKFSb4T9/NWG2yqJzswcT@nongnu.org
X-Gm-Message-State: AOJu0YxbdBLqwYdaljhHZk1+/rvXI61Cv0YiWdlkwvMimMyHwN87YpRC
 ThnZ6nh11qQyshECdM/Z6eKupg/tlFpwgOEhXMu/dWOKVOnGOdyDPlVB5doXC/qElaLZBaPcVtP
 z
X-Gm-Gg: ASbGnctyDFM4OeEcs43QGYuNtXU5w9qrosN+2fITNXGG3Mrg6PEn8cZK7Ld3c9XY8Me
 pOUB0y1Gg7VGKvKjCM4I3hZWYqXQQDfEHbU7iVhLdKXE2LFtqxJPV+3J5gLqUCec0SNjOPiTBuV
 bPxYPLH4DjblxQ3dVnrydaCOTja9kn02z2Au6Jar6/+280OWuqe9XuK4t/bG0j9OiD56HbU07bd
 EomFuU3UvLQgUJfSX6CRvUz34IkuhYZilXJ9thKT6CtenRqcYccaN+A9V9JJFFh/AqZOlKV18y7
 YvFnEW21LvqiDXA1qJPzLwVoT6Jkp4J2/v7pZETWpOZ5kLMRXabTSH6vdLUHNvNHmw==
X-Google-Smtp-Source: AGHT+IGJ41MVMl2VJ2uEuFhL1P88DKiMW4bgpo+rTU9GwMtKD2ebgxOFqi0Ug1AlFDoF+GQCcqP63g==
X-Received: by 2002:a17:90b:1a8d:b0:2ee:c91a:acf7 with SMTP id
 98e67ed59e1d1-30c3ca0415emr9784838a91.4.1746867157683; 
 Sat, 10 May 2025 01:52:37 -0700 (PDT)
Received: from localhost ([157.82.203.223])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-30c39de72d9sm3096441a91.21.2025.05.10.01.52.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 May 2025 01:52:37 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 10 May 2025 17:51:54 +0900
Subject: [PATCH v2 9/9] hw/display/apple-gfx: Replace QemuSemaphore with
 QemuEvent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250510-event-v2-9-7953177ce1b8@daynix.com>
References: <20250510-event-v2-0-7953177ce1b8@daynix.com>
In-Reply-To: <20250510-event-v2-0-7953177ce1b8@daynix.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102d.google.com
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


