Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88CE2C369DC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 03:17:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAguQ-0003qr-5z; Thu, 01 May 2025 23:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAguC-0003pd-TC
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:17:43 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAguA-0003PJ-HB
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:17:40 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-736c1138ae5so1704143b3a.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 20:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746155856; x=1746760656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EdEHRQIcS/KoLKBQT/QdqdalMsNW84j9PK9MoRDA6/o=;
 b=HVXMVc0ZpzYVIbUfJz/Tw4TqqINe3nLVpiNsJDEa6lR5BKHI7tKJwqHrqQnBU4gXuc
 tnLtsNykDQ9feKAQianC6VK41LA5FU4dRYZxC5wfbVX/276NxPJxaonl2N+8D/uu5l0f
 X4Fy+5647MALYmRCrg/U4pLoqdMv5uSrLb1kmeKN+WJRqeAEWWXeQaQcBZHEf2WFPYbY
 6970TrrGpak05H4wfOfvv/s6QktaC2RozyAq3pYvPYHiQrWZG3oVxGf+9X/lmH/kbt81
 KkV45gfvEIfBsjzM3g3O1Lwn8wklgYOB47vHCa/O33z3oE4EB6ly/Hlu3VnVZJB63iAc
 hbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746155856; x=1746760656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EdEHRQIcS/KoLKBQT/QdqdalMsNW84j9PK9MoRDA6/o=;
 b=FYqIDwHJoZQuvxi6iCvLUDeib+TCpeKs3EjZPLoAklBUEpT4E1v7dtrpH48zqdTX0S
 wKFrQyKB30Duo9b6QYi4l7QmQyXSO4UfTzKPU51eg2C5dJ9vaviXVILXHiTVPFHuveNg
 D7v3CvoQww4rlo+gTpBcxX7492Ezoj8ujQlHzeWti1xaTwr3tAbhU4cHA/qMRs3Vwf48
 6gPtCf6d07e2h0lnxs+yI1bM4lzndyj+GbLAiYcUWRrCy62ORyK+ey6RIbgdXTdjl0FR
 bOfkdJhrNc+68itQQFuL0jOG1udjh6ZqJ7sOsrlkTtUTHEEnz+z85IqKReFtrMr+M4FZ
 wuQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHp1eevgm6ylGFeQ3KjF1RCJBq3zFllAkPcdg4k0dxKrydydq6bLsu+nCsOdlU6PJ7/74QEyvNlzZg@nongnu.org
X-Gm-Message-State: AOJu0YxiWX5yowXrPYOys/ieYMBWyY7FUGMZpRHAmy94Ec7na1+/T2dr
 UelZqk3CdQsACGWaY+6CjiWQb2KFfwO1GydcxGjQ6MwwSbJdlwNP
X-Gm-Gg: ASbGncstePIimiaZ7dbTI6IT8cBkMFZ9BS6i7doYcW/mBiCvxtZcZoBK2gSWbCKAjWf
 tqAUHy4AclUe+0WPWPwKfzCL8Hdt22rYlgzfTiIxJbFVKC8FxAkESE35RAN+g0H252Jbu5kYXxD
 9bs50Fm8XcNSltKc2HiVM3QJdf65yWTxlVihielmaiaRuZ/5FFMnKHUdPJKdHV4G9OKx58kwuUm
 I2TvbPKeX0F5g3NUMBUsIk3oAJVjlbiL8EDcBU/vv0toeDHTbMGDzHMTT33FPy0dYbH6OGalXfi
 sR+pN2H3UGw/6Qk4Obb0ZvQAtdrYBgIhjs28ZwTkjTxO
X-Google-Smtp-Source: AGHT+IGPFXZ+aVyCfmzu9mQk0VHNfFOH4Cfft520U5+JSR7ZVpuP9LBXgiHesA31kCA72x9bkaLK4Q==
X-Received: by 2002:a05:6a00:1d0a:b0:740:41eb:5850 with SMTP id
 d2e1a72fcca58-74058903c55mr1774936b3a.4.1746155856185; 
 Thu, 01 May 2025 20:17:36 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058ded48fsm467883b3a.83.2025.05.01.20.17.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 20:17:35 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v3 04/12] qtest/e1000e|igb: assert irqs are clear before
 triggering an irq
Date: Fri,  2 May 2025 13:16:56 +1000
Message-ID: <20250502031705.100768-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502031705.100768-1-npiggin@gmail.com>
References: <20250502031705.100768-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
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


