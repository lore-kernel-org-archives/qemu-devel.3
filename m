Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F40E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 08:36:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLefo-0006ko-04; Thu, 12 Dec 2024 03:35:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tLefj-0006k5-Td
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 03:35:48 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tLefg-0004j7-T6
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 03:35:47 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2ee67e9287fso290396a91.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 00:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733992543; x=1734597343; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EwbtPpm8oHZVdeojkJajdcvG/Mqc1VDLbH8Cnvl+GKI=;
 b=PSOt4Spr9IJ03yHxhSh0l0PdYqAHqwnXyngmv4CO1g9kR/7NUX2KpThXde8AZaQumZ
 5Xru3J0QyBxq/mugkKHMzDmV7dysDqpWC/yyBgqA8/Ygw7y5WrrFRVfAORWJqiDPsY/P
 4kIpIcrx2ePEfgU3yi5FqootVCzdum1+wmquPx/ohxS2l+nYCGG65y4s0S3+bLDyrIA2
 DCCuvQZpVEUCOZwfdOugNOtAbDf5W3Rbm2e/0R44lvT4x+7aTd1wC1iryOxoY1lSBgTU
 ZG06raV1lC3NEVow1VPeIRorjdHRX8QevqmaF+4vn2XFuAmlcxHwukR5bSiOFfPVVeHF
 QP/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733992543; x=1734597343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EwbtPpm8oHZVdeojkJajdcvG/Mqc1VDLbH8Cnvl+GKI=;
 b=AyqvWTLZrEYik0ExjuUVFHVKbyuFYGUV+Kll3NirMKhKTlw+tF+A/OkdAM9zb7b8Xp
 KnOpgEnrrxGvw01Dxt+TJ3naVFvxYP2y06ODlgVTRYOCZQ2O1otU6tX3MYFHzazcUxR/
 rn1GpBBVYbdDpHdp35jVAFYFqMWyItLvphDiM/ufFnOp1a58IBW4x2aeMNN2ok6nyRJq
 12rL4Jejx7XGsz7a5epi5BQEDvmcCwH7bFTsEgNrDJUjKIoVDEh9VQqE4XPqhRfyjteV
 l+ayyoyYplNj/YFZVWEG1hGcJ6mMmi0eFZL9NgcygMag9YLsdrSJGNmtmwJYjqoYcyzk
 hsBQ==
X-Gm-Message-State: AOJu0YzLt01IX914BJzwlAsM8fwb7G7z8Y1uPIPc7VjUniTCynuttVbV
 ZC3ostNG4XhWXDbnKGoQqNIUNUJDKzQ5bV+bG8Xwz9yHh31ZOPlttEX8fw==
X-Gm-Gg: ASbGncuS6Kjr6WueRtjCVhedzCfQNroF8DudbPYX7BAf6qxtow2F/DXHLMtd/HHroRu
 x5lUFAhQ8AyUdAbjhZI5bNUN7ipdMIcaBWmQX0fYR92C9XNTD0A2/TB1/HFBjB9UdWMiVFb0m4k
 vniOPEP8+Hnpzr0TQvW/fFYGh8cboLF3dQu5Ps0fVNAvDc97KteWkyQcTu0ZI1+nTAVAyXdAjJD
 jKD8wfXudIgGxyoGwh22Yb5glp0bBGhaBPidptu4RmPp/m93w1+KVToQAk=
X-Google-Smtp-Source: AGHT+IHDkoRZ73NmPWisp+r55BDCN6PStNvz73TuYLMuGj5c2H4c4ow/i/BC7KgQmavnshPn3wM6fA==
X-Received: by 2002:a17:90b:1806:b0:2ea:3f34:f18d with SMTP id
 98e67ed59e1d1-2f139293053mr4998291a91.10.1733992543081; 
 Thu, 12 Dec 2024 00:35:43 -0800 (PST)
Received: from wheely.local0.net ([1.146.48.169])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f142dae788sm714624a91.12.2024.12.12.00.35.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 00:35:42 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Subject: [PATCH 4/8] tests/qtest/e1000e|igb: Fix e1000e and igb tests to
 re-trigger interrupts
Date: Thu, 12 Dec 2024 18:34:57 +1000
Message-ID: <20241212083502.1439033-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212083502.1439033-1-npiggin@gmail.com>
References: <20241212083502.1439033-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1031.google.com
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

The e1000e and igb tests don't clear the msix pending bit after waiting
for it sit is masked so the irq doesn't get delivered. Failing to clear
the pending interrupt means all subsequent waits for interrupt after the
first do not actually wait for an interrupt genreated by the device.

Explicitly clearing the msix pending bit results in the
multiple-transfers test hanging waiting for the second interrupt. This
happens because the e1000e and igb tests do not clear (or set
auto-clear) on queue interrupts, so the cause remains ste in ICR/EICR,
which inhibits triggering of a new interrupt.

Fix both these problems. Clear the msix pending bit explicitly after
waiting for it; and clear the ICR/EICR cause bits after seeing and
interrupt (also verify we saw the correct cause bit).

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/e1000e-test.c   | 8 ++++++--
 tests/qtest/igb-test.c      | 8 ++++++--
 tests/qtest/libqos/e1000e.c | 2 +-
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/e1000e-test.c b/tests/qtest/e1000e-test.c
index de9738fdb74..a69759da70e 100644
--- a/tests/qtest/e1000e-test.c
+++ b/tests/qtest/e1000e-test.c
@@ -64,8 +64,10 @@ static void e1000e_send_verify(QE1000E *d, int *test_sockets, QGuestAllocator *a
     /* Put descriptor to the ring */
     e1000e_tx_ring_push(d, &descr);
 
-    /* Wait for TX WB interrupt */
+    /* Wait for TX WB interrupt (this clears the MSIX PBA) */
     e1000e_wait_isr(d, E1000E_TX0_MSG_ID);
+    /* Read ICR which clears it ready for next interrupt, assert TXQ0 cause */
+    g_assert(e1000e_macreg_read(d, E1000_ICR) & E1000_ICR_TXQ0);
 
     /* Check DD bit */
     g_assert_cmphex(le32_to_cpu(descr.upper.data) & E1000_TXD_STAT_DD, ==,
@@ -115,8 +117,10 @@ static void e1000e_receive_verify(QE1000E *d, int *test_sockets, QGuestAllocator
     /* Put descriptor to the ring */
     e1000e_rx_ring_push(d, &descr);
 
-    /* Wait for TX WB interrupt */
+    /* Wait for TX WB interrupt (this clears the MSIX PBA) */
     e1000e_wait_isr(d, E1000E_RX0_MSG_ID);
+    /* Read ICR which clears it ready for next interrupt, assert RXQ0 cause */
+    g_assert(e1000e_macreg_read(d, E1000_ICR) & E1000_ICR_RXQ0);
 
     /* Check DD bit */
     g_assert_cmphex(le32_to_cpu(descr.wb.upper.status_error) &
diff --git a/tests/qtest/igb-test.c b/tests/qtest/igb-test.c
index 3d397ea6973..2f22c4fb208 100644
--- a/tests/qtest/igb-test.c
+++ b/tests/qtest/igb-test.c
@@ -67,8 +67,10 @@ static void igb_send_verify(QE1000E *d, int *test_sockets, QGuestAllocator *allo
     /* Put descriptor to the ring */
     e1000e_tx_ring_push(d, &descr);
 
-    /* Wait for TX WB interrupt */
+    /* Wait for TX WB interrupt (this clears the MSIX PBA) */
     e1000e_wait_isr(d, E1000E_TX0_MSG_ID);
+    /* Read EICR which clears it ready for next interrupt, assert TXQ0 cause */
+    g_assert(e1000e_macreg_read(d, E1000_EICR) & (1 << E1000E_TX0_MSG_ID));
 
     /* Check DD bit */
     g_assert_cmphex(le32_to_cpu(descr.wb.status) & E1000_TXD_STAT_DD, ==,
@@ -118,8 +120,10 @@ static void igb_receive_verify(QE1000E *d, int *test_sockets, QGuestAllocator *a
     /* Put descriptor to the ring */
     e1000e_rx_ring_push(d, &descr);
 
-    /* Wait for TX WB interrupt */
+    /* Wait for TX WB interrupt (this clears the MSIX PBA) */
     e1000e_wait_isr(d, E1000E_RX0_MSG_ID);
+    /* Read EICR which clears it ready for next interrupt, assert RXQ0 cause */
+    g_assert(e1000e_macreg_read(d, E1000_EICR) & (1 << E1000E_RX0_MSG_ID));
 
     /* Check DD bit */
     g_assert_cmphex(le32_to_cpu(descr.wb.upper.status_error) &
diff --git a/tests/qtest/libqos/e1000e.c b/tests/qtest/libqos/e1000e.c
index 925654c7fd4..8ef6a04f43e 100644
--- a/tests/qtest/libqos/e1000e.c
+++ b/tests/qtest/libqos/e1000e.c
@@ -83,7 +83,7 @@ void e1000e_wait_isr(QE1000E *d, uint16_t msg_id)
     guint64 end_time = g_get_monotonic_time() + 5 * G_TIME_SPAN_SECOND;
 
     do {
-        if (qpci_msix_pending(&d_pci->pci_dev, msg_id)) {
+        if (qpci_msix_test_clear_pending(&d_pci->pci_dev, msg_id)) {
             return;
         }
         qtest_clock_step(d_pci->pci_dev.bus->qts, 10000);
-- 
2.45.2


