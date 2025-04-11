Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 620B3C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 04:33:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u363d-0004mV-8Y; Fri, 11 Apr 2025 00:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u363b-0004mK-QB
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 00:31:59 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u363a-0007YP-4S
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 00:31:59 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-224341bbc1dso14943485ad.3
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 21:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744345917; x=1744950717; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EdEHRQIcS/KoLKBQT/QdqdalMsNW84j9PK9MoRDA6/o=;
 b=ZQiq9eCXV8fvrxBPOltg+j7ZryW7GI7p9wAjCNxF6oMzsrwiibnw21EtJ4wS8cJfBt
 pXs1mf6r7PSiFrQUyvpVkrLxtGdTn/EmutoJ1pfwMWzD5f2G5kVL2C5fHHcmlFVoZKUX
 56b5LBAIEvmMJpMFBOa7mqQBgdjk/3uZJRaV0pqNLlfj6vD8s++dSzpAx6U0SXOHknLo
 UmahqTW6KsL/k/kWYYdsDiMpiyTgPr0o7uRum1F+thshpsVv1KilRM2Q9Lhdo+L1Isut
 EEkwguBAdhB1x6gwWxgup8l2DBFcrMi/2Wq+hX3xqEx9Wc3SUixX1fKo1tvHdtlIL28e
 L7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744345917; x=1744950717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EdEHRQIcS/KoLKBQT/QdqdalMsNW84j9PK9MoRDA6/o=;
 b=jC7ao2vQQ1d6JZN5YuYDCtxXrUabORXMBsi6BB+nHIiSH+YyinbjNZ6kTOIfGVqmFU
 0l90VudO5fmikPNnD7+EePG83L0hEs9y0RWeGQxZt6OJnvi/mB+AKDfE84GrGvvFiuy7
 QlQLyPZj2z/TTczoqyB4dqO4ZvAnsCXLEvc84o67109tpFnaA0paFIcOzB4uRoJSFNv3
 yjl4DC4Cdlft/dCm8zQg0Zlly0fp/2JLEnTrO4Hm95WuYyQXENGfH+dd/uSdcO8z2d8F
 2LqyPjedrJc3BlaQmsY6+gKKNv/o/pXAkCoWsGgUb+Tnl8EW8STotMPSaVjI3Q3mw6Jm
 nhnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVI2U0itqsMhAzM8iY/XziFK57dKBJfclDE+JCdkuyH4R/U84OfPUT/E9llYgcPi2AojsfelSPcxbq/@nongnu.org
X-Gm-Message-State: AOJu0YzWHw8MVpEDZGi3vEHYbXovLNH73aRv8W5iVpAStpOgaqE9PKgz
 Rr4Sgzq3l2r+L94YG5ucfmNvqMomzp5Fm6bwhyi05+ZPC8NMo3wP
X-Gm-Gg: ASbGncvBAGBYHsCrZYeF+5TgapTcCIib7NH8C3+vb1md8jKqFzRF7ypqXC9YhMPgwJZ
 JqPCKYySqqQTXs1gqU8YMmVEkGlaVEbk6DK6PhLKDHp2tkP292sxK3Myw2EoBfGw5Px5SDd7eng
 AkHQpzhSRhk6ugeXn5A2tyFEcSsZcJsQv5k0hj6Su5cVHREGLjK5pJgZGRaBavnLAIGs1srl0+m
 pkCCpsfIj3IMj02Rg81qRKVNF0G+YZuKx0DYXM61sHkoTk+b/Xp5VsssfmTPw6OVNaDDMRO/6Qm
 nkp0jHLms8kVVa6lEiyfVjOtMO4Zeb7T/UEgo7t2kWXD
X-Google-Smtp-Source: AGHT+IEKIQZsI6EtuTHSxMWXhSXtnZNyYkEgQ+6lwyGbrIyopf8Tawi/Nekhcd6h68RomfOad26wCA==
X-Received: by 2002:a17:902:d4c5:b0:220:c63b:d93c with SMTP id
 d9443c01a7336-22bea4fee9amr19251675ad.44.1744345916701; 
 Thu, 10 Apr 2025 21:31:56 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7b64906sm39361625ad.48.2025.04.10.21.31.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 21:31:56 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v2 4/8] qtest/e1000e|igb: assert irqs are clear before
 triggering an irq
Date: Fri, 11 Apr 2025 14:31:24 +1000
Message-ID: <20250411043128.201289-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250411043128.201289-1-npiggin@gmail.com>
References: <20250411043128.201289-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
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

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/libqos/e1000e.h |  1 +
 tests/qtest/e1000e-test.c   | 10 ++++++++++
 tests/qtest/igb-test.c      |  6 ++++++
 tests/qtest/libqos/e1000e.c |  9 ++++++++-
 4 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/libqos/e1000e.h b/tests/qtest/libqos/e1000e.h
index 30643c80949..e693670119f 100644
--- a/tests/qtest/libqos/e1000e.h
+++ b/tests/qtest/libqos/e1000e.h
@@ -54,6 +54,7 @@ static inline uint32_t e1000e_macreg_read(QE1000E *d, uint32_t reg)
     return qpci_io_readl(&d_pci->pci_dev, d_pci->mac_regs, reg);
 }
 
+bool e1000e_pending_isr(QE1000E *d, uint16_t msg_id);
 void e1000e_wait_isr(QE1000E *d, uint16_t msg_id);
 void e1000e_tx_ring_push(QE1000E *d, void *descr);
 void e1000e_rx_ring_push(QE1000E *d, void *descr);
diff --git a/tests/qtest/e1000e-test.c b/tests/qtest/e1000e-test.c
index 746d26cfb67..a538c72cc84 100644
--- a/tests/qtest/e1000e-test.c
+++ b/tests/qtest/e1000e-test.c
@@ -61,6 +61,9 @@ static void e1000e_send_verify(QE1000E *d, int *test_sockets, QGuestAllocator *a
                                    E1000_TXD_DTYP_D   |
                                    sizeof(buffer));
 
+    /* Ensure the interrupt has not been taken already */
+    g_assert(!e1000e_pending_isr(d, E1000E_TX0_MSG_ID));
+
     /* Put descriptor to the ring */
     e1000e_tx_ring_push(d, &descr);
 
@@ -105,6 +108,9 @@ static void e1000e_receive_verify(QE1000E *d, int *test_sockets, QGuestAllocator
     char buffer[64];
     int ret;
 
+    /* Ensure the interrupt has not been taken already */
+    g_assert(!e1000e_pending_isr(d, E1000E_RX0_MSG_ID));
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
index cf8b4131cf2..12cdd8b498a 100644
--- a/tests/qtest/igb-test.c
+++ b/tests/qtest/igb-test.c
@@ -64,6 +64,9 @@ static void igb_send_verify(QE1000E *d, int *test_sockets, QGuestAllocator *allo
                                           E1000_TXD_DTYP_D   |
                                           sizeof(buffer));
 
+    /* Ensure the interrupt has not been taken already */
+    g_assert(!e1000e_pending_isr(d, E1000E_TX0_MSG_ID));
+
     /* Put descriptor to the ring */
     e1000e_tx_ring_push(d, &descr);
 
@@ -119,6 +122,9 @@ static void igb_receive_verify(QE1000E *d, int *test_sockets, QGuestAllocator *a
     memset(&descr, 0, sizeof(descr));
     descr.read.pkt_addr = cpu_to_le64(data);
 
+    /* Ensure the interrupt has not been taken already */
+    g_assert(!e1000e_pending_isr(d, E1000E_RX0_MSG_ID));
+
     /* Put descriptor to the ring */
     e1000e_rx_ring_push(d, &descr);
 
diff --git a/tests/qtest/libqos/e1000e.c b/tests/qtest/libqos/e1000e.c
index 925654c7fd4..0bf70e25389 100644
--- a/tests/qtest/libqos/e1000e.c
+++ b/tests/qtest/libqos/e1000e.c
@@ -77,13 +77,20 @@ static void e1000e_foreach_callback(QPCIDevice *dev, int devfn, void *data)
     g_free(dev);
 }
 
+bool e1000e_pending_isr(QE1000E *d, uint16_t msg_id)
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
+        if (e1000e_pending_isr(d, msg_id)) {
             return;
         }
         qtest_clock_step(d_pci->pci_dev.bus->qts, 10000);
-- 
2.47.1


