Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5022C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 05:09:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdjl3-0002HW-Kx; Tue, 13 Aug 2024 01:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1sdjkz-0001nv-1b
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 01:07:42 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1sdjkt-0007pQ-48
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 01:07:36 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-70ea2f25bfaso3621765b3a.1
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 22:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723525652; x=1724130452; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C6uQORA2XMsMSvVc8GOoWiKML0BdTYSXAQ9LyvAYzLA=;
 b=amNryKWVNdcC+iEfITD0+3ImHJ9Xje4TlA28IO52a0hn+F1HwB8Xt0wad9RLLdZnSo
 +yqGHvC+mGX56V5NCWHwTs84uqS2rnTSt6l69ihUcGzkQCVAub50opVq1ji/OgPhyJns
 LR4vqB/prEPLosOMDRWfD630r/2FNKBhGz+E9o1/XMRqYeB6GqJEDs3fGC7+DTL1CuKg
 gNDIm+8QcFI1VqwjP7DwmiafKdGzJ9Eq7oSWqoBQ8SBbOZ4M4Zdwawa89TGZyta8ZSvs
 x8vTQBw6Wjv/WVMhlowCI18Yy8tv/3jdwz1UcajZcNUNOoAGgBvxJCSqLos3pajWt3ZQ
 xxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723525652; x=1724130452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C6uQORA2XMsMSvVc8GOoWiKML0BdTYSXAQ9LyvAYzLA=;
 b=NZ0Uxv+EamT4TbyYIZoiwL7jAjLU+PPP60GL+Rv6cPCjLyZBEdlqttH/+YaYoMlX+4
 ap6ucEPqgL9gXukhbU7Loapc4zX2FDl2TVawiglOuVrwW2Tob3VjV8VU8N6gyonhBG0P
 W03UlNlgiXnRMUhmOZAEezESqYLqZ84tsbr83FCTcdY1q3XQ2vkyRU0h2+W2e51/TF16
 Bcwx9UEdqUdjavCuzVsO1LOJnPq+XU4BJnjhu77k8KwP4papqWkc9KqUEcpi8wqewqHU
 0tBqXmq+9FufZmRH1F0PJMzzxT2QBywBkeWhu1NjUoT99/xBKy7XJidIUN8rwUyy1pIK
 t2bg==
X-Gm-Message-State: AOJu0YzRy5VksV+1/ww7nAwchdOlIFk555KQW8UB6K/Zk5+8SZ++IRT+
 lCncVj+BpL/jBF4U3kuiqM3q5cDDurJeJY02xWweq24AkvDVS/tvRnqp0nU2
X-Google-Smtp-Source: AGHT+IGnhJKj9OE9BI8OgbyQRpTE0OwxjCMsoUuyjwc8A5Yil3FJapFuFZIGfXQU/KKCNyw/HWluSw==
X-Received: by 2002:a05:6a00:218d:b0:705:9a28:aa04 with SMTP id
 d2e1a72fcca58-712552034c9mr2616016b3a.23.1723525652302; 
 Mon, 12 Aug 2024 22:07:32 -0700 (PDT)
Received: from wheely.local0.net ([1.145.66.74])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710e5874ddcsm4846449b3a.28.2024.08.12.22.07.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 22:07:31 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v6 08/10] virtio-net: Use replay_schedule_bh_event for bhs
 that affect machine state
Date: Tue, 13 Aug 2024 15:06:35 +1000
Message-ID: <20240813050638.446172-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240813050638.446172-1-npiggin@gmail.com>
References: <20240813050638.446172-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The regular qemu_bh_schedule() calls result in non-deterministic
execution of the bh in record-replay mode, which causes replay failure.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/net/virtio-net.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

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
2.45.2


