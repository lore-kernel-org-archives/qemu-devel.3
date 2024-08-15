Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17830C3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 14:50:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sebnG-00045H-2W; Thu, 15 Aug 2024 10:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sebn6-0003ec-9Y
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:49:29 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sebn4-0000EM-Di
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:49:28 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a7a9cf7d3f3so135897666b.1
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 07:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723733365; x=1724338165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UBR0r40jCRTspwNEStddr6vUXgECDiH3mfiz9pfztnM=;
 b=jB40umleR5f85DzfTxAFI25FwzUWKKumtNscJGHmOzBKWvg3NGwOu2ThoVAZ+K6YuN
 xmiarQZreEKyIrhcpKCefet7ImLkv2gS8HMXLHFUOnnoc/HGRU7Zpc9hmYYQsI8M0saK
 8tr/zdo+43yRbgqyxTb8XlPIXAQswEsuWedZBGrancwRhBj6rUT8dIjMCnGwxEBO/RiY
 ye/VuG4w2OGoV9pRFaZjJQh2e7OYGXUx/6IUdY7VyE5TM5foQfYvfVSJjDg+wvQR8Yze
 PxmidGNdgOBH0OhqgHcoaNPlBeniPz0dw/HhLU5yHTc24aduZOCnGvJj8tW3sxbKa/eX
 cJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723733365; x=1724338165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UBR0r40jCRTspwNEStddr6vUXgECDiH3mfiz9pfztnM=;
 b=a/l1aRuYCWnvetPUkENEfwy9NuC98ivzaDdZR5JjGopZqo/MLw56FnEuLZVatp1nMr
 8HsijR0W4jAJD5eaQSEMjyQ1Zmoi4MJCRROoKdiTFZAwSqD+dvMF7Aapu0ynJMl/VCgK
 +l2jXAUFuxMrNosbEr9ywjaucWckwgeCS6wxHG+0aZpuTEgzwP5waNqUkgTTgXC9Gjvi
 1bEXYhhdzbwwa+b/k0mc3kMA2xMB3bxUC5+74o0uUrp4d3zzN5/a0vKqmD5x8SxfUEE/
 8swIca1ILONpQCXdufL+P83B+yUWvS5gccddU/hcCGGGHQ3DkaTxNThHGJ6E1WPzj32L
 xEgw==
X-Gm-Message-State: AOJu0YzRmCYUhMTwN+uqTZTinP9VLB3+dJKYoHDA5UjGUR7WIsoBOAJC
 gG9ta5/scPgd5ODjwsBUsREcnXkQXbVVIxU6SP1FQE27Ug3bvdzuxTCiwb72OgQ=
X-Google-Smtp-Source: AGHT+IGzCWa4rpICawVcDkjOLELPmUCXjQufyc710s0ueQV7SxhwHssgVB3t737Jjd4JFVVIstVo8Q==
X-Received: by 2002:a17:907:f19e:b0:a7a:9d1e:3b25 with SMTP id
 a640c23a62f3a-a8366d758abmr414830966b.30.1723733364459; 
 Thu, 15 Aug 2024 07:49:24 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83838cf05dsm112111966b.53.2024.08.15.07.49.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 07:49:20 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 39D2C6007F;
 Thu, 15 Aug 2024 15:49:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 16/21] virtio-net: Use replay_schedule_bh_event for bhs that
 affect machine state
Date: Thu, 15 Aug 2024 15:49:06 +0100
Message-Id: <20240815144911.1931487-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240815144911.1931487-1-alex.bennee@linaro.org>
References: <20240815144911.1931487-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Nicholas Piggin <npiggin@gmail.com>

The regular qemu_bh_schedule() calls result in non-deterministic
execution of the bh in record-replay mode, which causes replay failure.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20240813050638.446172-9-npiggin@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240813202329.1237572-17-alex.bennee@linaro.org>

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 08aa0b65e3..10ebaae5e2 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -40,6 +40,7 @@
 #include "migration/misc.h"
 #include "standard-headers/linux/ethtool.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/replay.h"
 #include "trace.h"
 #include "monitor/qdev.h"
 #include "monitor/monitor.h"
@@ -417,7 +418,7 @@ static void virtio_net_set_status(struct VirtIODevice *vdev, uint8_t status)
                 timer_mod(q->tx_timer,
                                qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_timeout);
             } else {
-                qemu_bh_schedule(q->tx_bh);
+                replay_bh_schedule_event(q->tx_bh);
             }
         } else {
             if (q->tx_timer) {
@@ -2672,7 +2673,7 @@ static void virtio_net_tx_complete(NetClientState *nc, ssize_t len)
          */
         virtio_queue_set_notification(q->tx_vq, 0);
         if (q->tx_bh) {
-            qemu_bh_schedule(q->tx_bh);
+            replay_bh_schedule_event(q->tx_bh);
         } else {
             timer_mod(q->tx_timer,
                       qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_timeout);
@@ -2838,7 +2839,7 @@ static void virtio_net_handle_tx_bh(VirtIODevice *vdev, VirtQueue *vq)
         return;
     }
     virtio_queue_set_notification(vq, 0);
-    qemu_bh_schedule(q->tx_bh);
+    replay_bh_schedule_event(q->tx_bh);
 }
 
 static void virtio_net_tx_timer(void *opaque)
@@ -2921,7 +2922,7 @@ static void virtio_net_tx_bh(void *opaque)
     /* If we flush a full burst of packets, assume there are
      * more coming and immediately reschedule */
     if (ret >= n->tx_burst) {
-        qemu_bh_schedule(q->tx_bh);
+        replay_bh_schedule_event(q->tx_bh);
         q->tx_waiting = 1;
         return;
     }
@@ -2935,7 +2936,7 @@ static void virtio_net_tx_bh(void *opaque)
         return;
     } else if (ret > 0) {
         virtio_queue_set_notification(q->tx_vq, 0);
-        qemu_bh_schedule(q->tx_bh);
+        replay_bh_schedule_event(q->tx_bh);
         q->tx_waiting = 1;
     }
 }
-- 
2.39.2


