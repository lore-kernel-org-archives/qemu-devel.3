Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B87CCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:53:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJJ3-0003bW-Cs; Tue, 21 Oct 2025 16:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJIk-0002nR-9s
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:49:54 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJId-0001H4-2o
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:49:48 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-471075c0a18so63496555e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761079780; x=1761684580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=awGc4SjfjjundyymO8QAn2CEIgpzduKbpzVRnBT5Jpc=;
 b=BK1Ieh48C/8lZzKB70IxL45gOQ1sJJ7noGdz+L7JDCv9MYCDzPH9Ifkyo07cmQPCq1
 mmFS379JVO040ZmIQApp4d98AatyFIPV0ii5izjiOYpP8LOHrDrWkIPgFK3SqMQR4ZeF
 woIwA3TiF4b5CY24dOF1U4cH3IAQv1VqcQiF10Q5+7vs7GZzp43eb9ZKrb1UyM+o6aUv
 mBOw8k78IZZ8eElgqCa76BRvqQ75+3o7RjR/WsXJ1ZzhuH4uckkdOIMYrtOHZMQOHBfZ
 13pdJSpbZ0klx4+ozaCjlSbp7oWB8pG2mlDp5OoO2peudNHxHaIeV2RjPeTHVaBrjwoD
 a3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761079780; x=1761684580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=awGc4SjfjjundyymO8QAn2CEIgpzduKbpzVRnBT5Jpc=;
 b=ZdxaTRI+8q2bu1s6na3gBOIewo102KhzKa6TAFBKsDM2jWdm7lG37hW5hSpg73wqfd
 cxfi526fXa/BkFf9+pNoX4YbQAnqZjBCI//QzRoA5DkecmXlwcnVSyeiwGK02BBPOO+m
 Hv8+Gr0du1jQCYRpb3UHItL9DKKqNZA8jEMdptkhLGpTQnLVC3Va+XmVzhyJQ9nTS98x
 7697Buw77OiamJZfJ+KS/iTzYdHm1bhSMQYPFzvFx8HFt1xxU1upbHYrCVvOCrkdYibQ
 YlQQqz1wQucaXU07AD14QCylxSE8MYmeo8xJMaZ24FGSJlUiJ4IKjhvYbSkcAHIKLzVq
 MlDQ==
X-Gm-Message-State: AOJu0YzE2q6P9vqZsPr9ybT+UjkaCR9BK3NBeKIvfYiCAqkUc+h6p5qm
 5aPlnkZKtHg/vep9W9i1tiT8ykwiCdxzDiI2T8kVQuJmHDuo6INUfwXAnn+JlH4tIzr23KWUUoF
 WyDHuxB4=
X-Gm-Gg: ASbGncuOmhqkx20np5wGASWHmih5XS7Jm8dwONUHsX7BF4LtHspjDmA0CgLwmaZ1OU7
 bKicKvgWLv5Nrm/1n87iJmuBZ1LBMOAVoqPJ0j0IiXot0YX4UmQDg/NFHUcu9bcZZMaTDXsk75K
 QPUEWzKrAXe0ndWkkJR5M/rPlAeCMHPXdqA5iYbjRYBodZdeHOurgdjgdkifg1iKSBJRwvl61IB
 Z6bA9zaGLbr/oo3N17J2qM78xOjcKfuAsZWdoCH869S54Sn4VqIf1J1OJil5pumfVTw+5snl97D
 0q0hhR5N9MJ+y6qHOMum7mksnPUdIMTZnyVVA+TYekWI6PeFxWLcAOW1P4ir0VsQTK3GeQp5oSf
 haIwtnOjKjh9x7cQVlXPq488ek3Gwc//Gw5NkHD8GkfYoRpo/fIuN8g+4W5eYgSzvd9Pld7CkDc
 PngwL7fom88/m5r+FstkMkGx6bD8I1JJFlfy8jG3TSITLcF8IImvARfwPNkSJz
X-Google-Smtp-Source: AGHT+IEqDr8xACZIzSnF8FRqHqSbklKv46b+byrnXwYGgnqFOvf+Irk/7q9D26wFVVhEf+9DBQ9iMg==
X-Received: by 2002:a05:600c:8519:b0:46e:42aa:75b5 with SMTP id
 5b1f17b1804b1-471178706a7mr129171065e9.4.1761079780262; 
 Tue, 21 Oct 2025 13:49:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c4342373sm11132305e9.12.2025.10.21.13.49.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 13:49:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/45] hw/audio: improve error reports
Date: Tue, 21 Oct 2025 22:46:48 +0200
Message-ID: <20251021204700.56072-35-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021204700.56072-1-philmd@linaro.org>
References: <20251021204700.56072-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The -audiodev argument is 'model=..', use same terminology.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251021090317.425409-2-marcandre.lureau@redhat.com>
[PMD: Fixed checkpatch.pl issues]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/audio/soundhw.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/hw/audio/soundhw.c b/hw/audio/soundhw.c
index d18fd9fa051..2a41e108c02 100644
--- a/hw/audio/soundhw.c
+++ b/hw/audio/soundhw.c
@@ -70,13 +70,13 @@ void show_valid_soundhw(void)
     struct soundhw *c;
 
     if (soundhw_count) {
-         printf("Valid sound card names (comma separated):\n");
-         for (c = soundhw; c->name; ++c) {
-             printf ("%-11s %s\n", c->name, c->descr);
-         }
+        printf("Valid audio device model names:\n");
+        for (c = soundhw; c->name; ++c) {
+            printf("%-11s %s\n", c->name, c->descr);
+        }
     } else {
-         printf("Machine has no user-selectable audio hardware "
-                "(it may or may not have always-present audio hardware).\n");
+        printf("Machine has no user-selectable audio hardware "
+               "(it may or may not have always-present audio hardware).\n");
     }
 }
 
@@ -88,7 +88,7 @@ void select_soundhw(const char *name, const char *audiodev)
     struct soundhw *c;
 
     if (selected) {
-        error_report("only one -soundhw option is allowed");
+        error_report("only one -audio option is allowed");
         exit(1);
     }
 
@@ -101,7 +101,7 @@ void select_soundhw(const char *name, const char *audiodev)
     }
 
     if (!c->name) {
-        error_report("Unknown sound card name `%s'", name);
+        error_report("Unknown audio device model `%s'", name);
         show_valid_soundhw();
         exit(1);
     }
@@ -140,4 +140,3 @@ void soundhw_init(void)
         c->init_pci(pci_bus, audiodev_id);
     }
 }
-
-- 
2.51.0


