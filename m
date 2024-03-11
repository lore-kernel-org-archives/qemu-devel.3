Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D7AC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 17:42:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjjeU-0002Yq-V1; Mon, 11 Mar 2024 13:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rjjeS-0002YM-94
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:41:28 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rjjeQ-0007Mu-L4
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:41:27 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6e5eaf5bb3eso3591782b3a.3
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 10:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710178885; x=1710783685; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KIe47Fwcl7aGXVqbunL4ff4uzd0bDZVnqiv3Rpt/7b0=;
 b=Z7t4jNwj2Oc6Yy8ZoVPOLs/CEoxUWo5sTRPpn5AzlamyhU3/mmvAgkgqTJFcuKUNHb
 bA35yWGzJN2AauFJcfz9cTTgyBwAs7xu/aZt59wy1DQCMwHr4e44AOac70Ioqhb6yNgG
 a1W2oLF59G5K5o+9k32M1cxQlGkmbke8JM2tKpJHDECSFWAbBXi4cEMoc+q5JSFqG2j/
 XGW9J3YAvRs9hImsUmKUuVyDRDWH106YSM+sqtw3nJtwiwjSiDtOl8JlDcNaBAX5eM96
 68MF7lNIkc5hT9QV0YneHrc3CwIqE1o33A/5701bw2DcCGvdvm+15phbtG8KBPG9Wlf7
 AXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710178885; x=1710783685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KIe47Fwcl7aGXVqbunL4ff4uzd0bDZVnqiv3Rpt/7b0=;
 b=mvast2e7ZE6f94hkkAcma23S/2GTSgYRsugr1yAr0ouqUsWpbSLzzEp7DrpPeT286A
 7PCEM0fjLb4CJN+0kboLviTHITTEYUXmLbFklxKkrkwvwyqVYSOi8WbYJ0UwRYxaxnx0
 i/EXAS5WD/pMROLDA4bsQfwGAYokIyo93sY1aBbBUK6gDYe3dXwtMD1VLju390I2cezo
 J/MjzLyFTfY8ugN6eKIPueX+bytX8BXjSGjoY4TFICwLjP7G5HWjuslfKc9fPhQmolYJ
 wOo6UPU/HXZ1x5hr43aJf/2LOiEixW5ZgpbnVgFYrMhgxSBmIgvf9S7mS3Qi+GOgfqpG
 ERvQ==
X-Gm-Message-State: AOJu0YzBi6WCkmDCLg6JqTLRo3x0eZQdnsgDdudyr5Tto+pST27XbKr1
 3ec53tfyUfHx0PvWPj9uKhwZtd0GsZwsljRvbgpbzDsymFduXPkFDXc022B5KG8=
X-Google-Smtp-Source: AGHT+IExsNqBUHeYWdkUF2ovNXfQoxprvKRcNuCTUrpYd+Yq1nhoNrmlK1iW2Y3V/V6S52GYJHabqw==
X-Received: by 2002:a05:6a20:3947:b0:1a1:682d:cc4a with SMTP id
 r7-20020a056a20394700b001a1682dcc4amr5429779pzg.43.1710178885213; 
 Mon, 11 Mar 2024 10:41:25 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 a18-20020a62d412000000b006e67b4d7b74sm4593187pfh.197.2024.03.11.10.41.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 10:41:25 -0700 (PDT)
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
Subject: [PATCH v4 09/24] virtio-net: Use replay_schedule_bh_event for bhs
 that affect machine state
Date: Tue, 12 Mar 2024 03:40:11 +1000
Message-ID: <20240311174026.2177152-10-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240311174026.2177152-1-npiggin@gmail.com>
References: <20240311174026.2177152-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42e.google.com
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/net/virtio-net.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index a3c711b56d..ad12d80677 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -40,6 +40,7 @@
 #include "migration/misc.h"
 #include "standard-headers/linux/ethtool.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/replay.h"
 #include "trace.h"
 #include "monitor/qdev.h"
 #include "hw/pci/pci_device.h"
@@ -415,7 +416,7 @@ static void virtio_net_set_status(struct VirtIODevice *vdev, uint8_t status)
                 timer_mod(q->tx_timer,
                                qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_timeout);
             } else {
-                qemu_bh_schedule(q->tx_bh);
+                replay_bh_schedule_event(q->tx_bh);
             }
         } else {
             if (q->tx_timer) {
@@ -2668,7 +2669,7 @@ static void virtio_net_tx_complete(NetClientState *nc, ssize_t len)
          */
         virtio_queue_set_notification(q->tx_vq, 0);
         if (q->tx_bh) {
-            qemu_bh_schedule(q->tx_bh);
+            replay_bh_schedule_event(q->tx_bh);
         } else {
             timer_mod(q->tx_timer,
                       qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_timeout);
@@ -2823,7 +2824,7 @@ static void virtio_net_handle_tx_bh(VirtIODevice *vdev, VirtQueue *vq)
         return;
     }
     virtio_queue_set_notification(vq, 0);
-    qemu_bh_schedule(q->tx_bh);
+    replay_bh_schedule_event(q->tx_bh);
 }
 
 static void virtio_net_tx_timer(void *opaque)
@@ -2906,7 +2907,7 @@ static void virtio_net_tx_bh(void *opaque)
     /* If we flush a full burst of packets, assume there are
      * more coming and immediately reschedule */
     if (ret >= n->tx_burst) {
-        qemu_bh_schedule(q->tx_bh);
+        replay_bh_schedule_event(q->tx_bh);
         q->tx_waiting = 1;
         return;
     }
@@ -2920,7 +2921,7 @@ static void virtio_net_tx_bh(void *opaque)
         return;
     } else if (ret > 0) {
         virtio_queue_set_notification(q->tx_vq, 0);
-        qemu_bh_schedule(q->tx_bh);
+        replay_bh_schedule_event(q->tx_bh);
         q->tx_waiting = 1;
     }
 }
-- 
2.42.0


