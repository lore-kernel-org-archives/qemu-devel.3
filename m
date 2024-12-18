Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E76E77183
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 07:44:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNoiH-0007nr-KG; Wed, 18 Dec 2024 02:43:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tNoi0-0007lP-CL
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 02:43:05 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tNohy-0006js-PR
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 02:43:04 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-72764c995e5so3775677b3a.2
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 23:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734507781; x=1735112581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZIRfQ0hXwoFmbBWphEiN9u3hsNhMmmCqqRQ4tN1OE6M=;
 b=fpk5Gy4S5HjzdeXbCOV4kgZdIc8sQ+Gawpkeh710Hi4Ov/iADtHWXrUvZm2Jz8PZiM
 JqPCIvLdx1dr+YAt5Y00TIMvWkbHh+jP/Hwa08ZQKe9VQQhRHNTa9rKfXQxOHO2HZ/i1
 6SqRY0dKcpjlSQPv8EfkmrY010delkec5b5BZmQY0Q+3kSNfxtBfqXY9VDuaxzxlrmhh
 fS+vyb0HLC4dsIZ8IDGuBdipJxbzjsTlDQ68hbjhJWtZxCiXx7FPOvZE4wvTtvuM+ziN
 zgF3EaORWaSITMW/Rw1R/szz+R3lciCBHmOoVOLmNmpXysTioUllk1AQPjIDUP9CAEMI
 4I1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734507781; x=1735112581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZIRfQ0hXwoFmbBWphEiN9u3hsNhMmmCqqRQ4tN1OE6M=;
 b=U9omYGiu/jpKUb++P/fNCF5JPsLajrG7wJVzkTxSzKtfaN7Kor4J20D007BsL1WFZp
 Qnar1+eyI10tqcDxq4h1G12xpgznJ1yHz2Ngc1bX9kT85ll2n7s73hrBL90N4lyileRM
 laqdxwYtXpJsazWniM2RXwELkRKu4uyW8awOjEAmlhqgrr16ZAXZ+VWZQZ9x7z3q24Ig
 LvfAJL4vdQNErCmnayqtU/6i8bD1RJflBTMV6zEgpKaBnevTp5X6Hmg5iR25nF1vvZF8
 lbizBBA0SdxJ9NKmb0zvcQywNTMhfZn+KQ5U8Winy4LotrdAGNPVRnV7aSW/bJXZHGgm
 v5qw==
X-Gm-Message-State: AOJu0YwuTbYnCzWKx7bh0ZUGJ4Yy4xK42tYCOHnbPHDcqtJzIPe/5fn8
 PUsVa6RzoBfFycfxlCkHENQcSQdQddfAAvYo9GyYO90ggRXuwMFjL/x/pQ==
X-Gm-Gg: ASbGncs8Il7lnBlL8HnMyw0r605mdFjHFqp5/cIdry0+ecCxHw43+dfBvgYa19GrYjl
 z/owz5wX2PWaaSgywu3FpbLEGDQI/dmqhH4c8raqlXC+4qltjWD2glpr45Il+c1u+bKczTj77V1
 LpK6K39LIp8DRXQ0b9Bx3FeuQ/h1EEP7pglFIv0UANWoKbCuQrZ4GTq7vch0tBQVLtzjSenFNa8
 sCT+7/HlPaJufAnXhGlTlEHKtGoWhIR9HUGMahUUXE9ocvPjH6AvF+QsIUpuYd8VkcmS+6LPR2I
 KaeoUUcn/A==
X-Google-Smtp-Source: AGHT+IEhCK/CLlWw64i+ZtrpZ4r2ECdKiHRvxOX50YDvusdew0Oi8XT2RH/2Od9LMbBlw1xGNogjcQ==
X-Received: by 2002:a05:6a00:4087:b0:72a:8461:d179 with SMTP id
 d2e1a72fcca58-72a8d12803emr3088434b3a.1.1734507780555; 
 Tue, 17 Dec 2024 23:43:00 -0800 (PST)
Received: from wheely.local0.net (14-200-18-130.tpgi.com.au. [14.200.18.130])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72918af0caesm7900933b3a.86.2024.12.17.23.42.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 23:43:00 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4/5] qtest/e1000e|igb: Clear interrupt-cause bits after irq
Date: Wed, 18 Dec 2024 17:42:30 +1000
Message-ID: <20241218074232.1784427-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241218074232.1784427-1-npiggin@gmail.com>
References: <20241218074232.1784427-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42a.google.com
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

The e1000e and igb tests do not clear the ICR/EICR cause bits (or
set auto-clear) on seeing queue interrupts, which inhibits the
triggering of a new interrupt.

Fix this by clearing the cause bits, and verify that the expected
cause bit was set.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/e1000e-test.c | 8 ++++++--
 tests/qtest/igb-test.c    | 8 ++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

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
-- 
2.45.2


