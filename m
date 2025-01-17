Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C48CC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 17:04:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYpkw-0004k8-Ow; Fri, 17 Jan 2025 12:03:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tYpkr-0004XT-EJ
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 12:03:34 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tYpko-0003Fe-JS
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 12:03:33 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21c2f1b610dso30945555ad.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 09:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737133409; x=1737738209; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iTYtMpRlddcMLzCiy8tal9AqkOidT50BtGeDgIAsUJQ=;
 b=ec3qPXn3+PeNrD+sOhufjJ6iRkA+qNMKeRHAF3gOjerPxdbkpXwWBItqqeULnxLHWA
 gFKbb+wHV4gp9up0w/xVWDOwsgJZtgknnomca1zf9Docl/fWr63UP+LzGQlQq770hv9+
 HcAjvXN3Xqo58PfL3b8zYSIfmDbaGpjIuNvmIYvVcgzDE+mU6ts97v1jTns7iVBd0Q1h
 r/OMgww3QTT8ZlNK/2m8NKYvwCErGBf8mkgd1xGXOCxBMzGRgmmVkCalUS7KwR+BCNOz
 jPEYHs1yD+XhgW9zEFGKowmESS5jqL0pYGXQSF0bJkOIs5GQbQowK78I9k3kglvu2njw
 HgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737133409; x=1737738209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iTYtMpRlddcMLzCiy8tal9AqkOidT50BtGeDgIAsUJQ=;
 b=mpNCMtJeyo4rmFK3MGXJuNJiXxiTR4XF/t/H7neRe7bVqXRTBKf7ExCGsnXyIeCLZy
 eB6qHPYgwc1eC2CNGOaw/J538zgXr34a+kJxrNJ9YprG1xgEc0VnQQ8pkotcXDp7bIeq
 Icsx8F8OdJG+LTtQbptiENcUqg5yyi8DRl/jZ0+2GwRuwxzUNf2mymmzfOf6YlQOrXNf
 BnHTq8WIrdE7T+qgTt3o+/PStmjwLJUvR6stXdeBXksgOV1KYcuzn7d+pDplAtL/lqIh
 g5MzRIYWcVLtlU4hYSZM9BHJmU1+/m64Yb/rXFYAkuHPci0KSTmKn9/GoxjZVcu3NgtW
 Rxng==
X-Gm-Message-State: AOJu0YzZZ+Fm+hPMSwIjqfDnxScDmeoxLwhUp38jbjGr9EOVKZOA8wIy
 qDPTd2de8L7C/k17YJyjx5KppJWK52Lq8gMVeWNRR0Fkph6mzStzEyMA6A==
X-Gm-Gg: ASbGncvaowf1MkI0YJfKgVIppDy/a/xrjOm4MaYI7jm6fO9Q2Rga9Jn97JzjrJJLYNs
 DVbBvmPDfL/RzOtqlHAJhWta+raRlbGIXQAMBueAAOjqiGX6ouLSTa4lOBZLyvZti6xSUFzRjx+
 IU6BN/LH+oWFxpJ7Dsi5/EbIJXq7BHb2gsN0TCYKFyKCFfUFOtERpaTG2JfNDP0PMSOhDyR5iKQ
 LsLSTaC8K+TJatShgNylmywjw7OY+iPfu4gSC4VRwLTPXteZG+pLSeZRqkstSl1sjzxrNVvcyu0
 2TvWOwZxqhjd0T0=
X-Google-Smtp-Source: AGHT+IE08DC5Gr95OqmQ4QAdefD4mprkP5er8DxItX8tz95Oj1/JMAC0ib4rsFJDBVIuWduVzfwJvg==
X-Received: by 2002:a17:903:2290:b0:216:5e6e:68cb with SMTP id
 d9443c01a7336-21c3540d18cmr48642755ad.16.1737133408674; 
 Fri, 17 Jan 2025 09:03:28 -0800 (PST)
Received: from wheely.local0.net (124-169-212-233.tpgi.com.au.
 [124.169.212.233]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2cea0b91sm18249435ad.49.2025.01.17.09.03.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 09:03:28 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 3/9] qtest/e1000e|igb: assert irqs are clear before triggering
 an irq
Date: Sat, 18 Jan 2025 03:02:59 +1000
Message-ID: <20250117170306.403075-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250117170306.403075-1-npiggin@gmail.com>
References: <20250117170306.403075-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x635.google.com
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

Assert there is no existing irq raised that would lead to a false
positive interrupt test.

e1000e has to disable interrupt throttling for this test, because
it can cause delayed superfluous interrupts which trip the assertions.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/libqos/e1000e.h |  1 +
 tests/qtest/e1000e-test.c   | 10 ++++++++++
 tests/qtest/igb-test.c      |  6 ++++++
 tests/qtest/libqos/e1000e.c |  9 ++++++++-
 4 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/libqos/e1000e.h b/tests/qtest/libqos/e1000e.h
index 30643c80949..7154aec0339 100644
--- a/tests/qtest/libqos/e1000e.h
+++ b/tests/qtest/libqos/e1000e.h
@@ -54,6 +54,7 @@ static inline uint32_t e1000e_macreg_read(QE1000E *d, uint32_t reg)
     return qpci_io_readl(&d_pci->pci_dev, d_pci->mac_regs, reg);
 }
 
+bool e1000e_seen_isr(QE1000E *d, uint16_t msg_id);
 void e1000e_wait_isr(QE1000E *d, uint16_t msg_id);
 void e1000e_tx_ring_push(QE1000E *d, void *descr);
 void e1000e_rx_ring_push(QE1000E *d, void *descr);
diff --git a/tests/qtest/e1000e-test.c b/tests/qtest/e1000e-test.c
index 746d26cfb67..9ab81ecff5b 100644
--- a/tests/qtest/e1000e-test.c
+++ b/tests/qtest/e1000e-test.c
@@ -61,6 +61,9 @@ static void e1000e_send_verify(QE1000E *d, int *test_sockets, QGuestAllocator *a
                                    E1000_TXD_DTYP_D   |
                                    sizeof(buffer));
 
+    /* Ensure the interrupt has not been taken already */
+    g_assert(!e1000e_seen_isr(d, E1000E_TX0_MSG_ID));
+
     /* Put descriptor to the ring */
     e1000e_tx_ring_push(d, &descr);
 
@@ -105,6 +108,9 @@ static void e1000e_receive_verify(QE1000E *d, int *test_sockets, QGuestAllocator
     char buffer[64];
     int ret;
 
+    /* Ensure the interrupt has not been taken already */
+    g_assert(!e1000e_seen_isr(d, E1000E_RX0_MSG_ID));
+
     /* Send a dummy packet to device's socket*/
     ret = iov_send(test_sockets[0], iov, 2, 0, sizeof(len) + sizeof(packet));
     g_assert_cmpint(ret, == , sizeof(packet) + sizeof(len));
@@ -188,6 +194,10 @@ static void test_e1000e_multiple_transfers(void *obj, void *data,
         return;
     }
 
+    /* Clear EITR because buggy QEMU throttle timer causes superfluous irqs */
+    e1000e_macreg_write(d, E1000_EITR + E1000E_RX0_MSG_ID * 4, 0);
+    e1000e_macreg_write(d, E1000_EITR + E1000E_TX0_MSG_ID * 4, 0);
+
     for (i = 0; i < iterations; i++) {
         e1000e_send_verify(d, data, alloc);
         e1000e_receive_verify(d, data, alloc);
diff --git a/tests/qtest/igb-test.c b/tests/qtest/igb-test.c
index cf8b4131cf2..1bbb4bea4c1 100644
--- a/tests/qtest/igb-test.c
+++ b/tests/qtest/igb-test.c
@@ -64,6 +64,9 @@ static void igb_send_verify(QE1000E *d, int *test_sockets, QGuestAllocator *allo
                                           E1000_TXD_DTYP_D   |
                                           sizeof(buffer));
 
+    /* Ensure the interrupt has not been taken already */
+    g_assert(!e1000e_seen_isr(d, E1000E_TX0_MSG_ID));
+
     /* Put descriptor to the ring */
     e1000e_tx_ring_push(d, &descr);
 
@@ -119,6 +122,9 @@ static void igb_receive_verify(QE1000E *d, int *test_sockets, QGuestAllocator *a
     memset(&descr, 0, sizeof(descr));
     descr.read.pkt_addr = cpu_to_le64(data);
 
+    /* Ensure the interrupt has not been taken already */
+    g_assert(!e1000e_seen_isr(d, E1000E_RX0_MSG_ID));
+
     /* Put descriptor to the ring */
     e1000e_rx_ring_push(d, &descr);
 
diff --git a/tests/qtest/libqos/e1000e.c b/tests/qtest/libqos/e1000e.c
index 925654c7fd4..4e4c387b0bf 100644
--- a/tests/qtest/libqos/e1000e.c
+++ b/tests/qtest/libqos/e1000e.c
@@ -77,13 +77,20 @@ static void e1000e_foreach_callback(QPCIDevice *dev, int devfn, void *data)
     g_free(dev);
 }
 
+bool e1000e_seen_isr(QE1000E *d, uint16_t msg_id)
+{
+    QE1000E_PCI *d_pci = container_of(d, QE1000E_PCI, e1000e);
+
+    return qpci_msix_pending(&d_pci->pci_dev, msg_id);
+}
+
 void e1000e_wait_isr(QE1000E *d, uint16_t msg_id)
 {
     QE1000E_PCI *d_pci = container_of(d, QE1000E_PCI, e1000e);
     guint64 end_time = g_get_monotonic_time() + 5 * G_TIME_SPAN_SECOND;
 
     do {
-        if (qpci_msix_pending(&d_pci->pci_dev, msg_id)) {
+        if (e1000e_seen_isr(d, msg_id)) {
             return;
         }
         qtest_clock_step(d_pci->pci_dev.bus->qts, 10000);
-- 
2.45.2


