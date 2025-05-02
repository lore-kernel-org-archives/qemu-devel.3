Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A408AC369DC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 03:17:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAgtz-0003nb-RS; Thu, 01 May 2025 23:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAgtw-0003nM-Tn
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:17:25 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAgtu-0003NE-PB
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:17:24 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7399a2dc13fso2410908b3a.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 20:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746155841; x=1746760641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GRZOC2tSqmQDMujWz+eg0jjAA3OFDUOED5xf58eJ/zc=;
 b=M3LVXI8NDODMJmPayzpm8Q4q8H+vGejj+RXDlBKp4Thk5cl5q61twS7FgBwKuouUxL
 s9geUpy/qHW5Atc76iN3EFgbo4YVaK8eQXvAv4HorpiU+GJNirMwcK0Va9AJXjOGVFx4
 M8XmdhfS665OfSIv2WwJ3XHJfz8wAU7j2vnEzhODjn2RlaTjpF+2dyjZ4nGHNjKmQIky
 lriLRhu2LjJBXIdice9cb58u6UljqArDcBWac/u6/7WhEIOafzPG4H3VgbWsrEJ9fHEy
 szoZkMKnEIgqrUfSC5nvyEpuGLcBYHNuLx8Gt1j4wjoyXZf8iDR4N2ADGHjuXwvTnte+
 wSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746155841; x=1746760641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GRZOC2tSqmQDMujWz+eg0jjAA3OFDUOED5xf58eJ/zc=;
 b=h6J7Ox2F6mE/Cof0zTDm/X7qgLPuQOEOhd1D+i2UokbwR0j+/xBocl8KQMHWIrrY4F
 kxbNBladagAboDbjdgcE0TQ9fOX445w/Ir0z5AvKJ6DT3v8PCIhxQw6vr8dJpIQZEVwM
 TqYJaWu+nHKea2Plp7oYrNU5lBh1n2iDhLS1sm1/vaYNhwdETnffShNdesxMMeGaTSIC
 LImLQ0+sEdx0NBmlcUpf2WMbBDDQncRvY1uqcyEZka01+BWfzCCKlsVpl4nBG8U/Zpz5
 Q16dGXt6YaFsE1H6/f4vHv9gtlDlP4XLG7zWrxDAVuyCDJXs9qW9FtixOhxNr7V7xaOJ
 2Hlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXibzLHX4rRugnhlW7txPGPw9EnMk8zA/gu6NxFSZyQiS7HfSNrKSNZPZOsy9lQo7R5MHiSKkHQjyAY@nongnu.org
X-Gm-Message-State: AOJu0YxL0pPPRDGFK2q78+z36FzcWLkaWSU9ZPcCLtSgZCUz5G6HVwc/
 rzSCFeDFFqzc2EOWOi4xGQ1ir/G0ItGC4/bmvkNSiOUJctfau/nI
X-Gm-Gg: ASbGncvnEuOqdhJpeMO3oXXMFDcCRFP8wHkwYL1mkKTqACdSALuIXjE5azKAbjG65Kt
 LfOpLVlFv9fpbYBhISMUa6AX4UXEppusM3a1U5A/0DQVDchBM4atjLrh9TAyHYPwpesLBtLuCh0
 uYqKIn6RRTcOUo4ziJ/6Ogjo7ccyKCGwTqhEffu3qAdayMnv+CaBCIqxjnrNCOPSj7Kg84OZ6Jz
 bLFSyE39g0lyoZQs4+ckRSVVRDoQ6buC+6svweqBH6c9CIiU6dD3ZN5a1ymjOaW5+yLDZQv3d+b
 xFRgPaRnxqH/DlbRctfIsbZyWOvgNC8lOJqTlKlpiRwp
X-Google-Smtp-Source: AGHT+IFRWe8seUINssS/IjzjxANGuLPyfDc2PfnmvUIHJP+vZ8d5whePr1MXR06O4adg0cHEbMcvTQ==
X-Received: by 2002:a05:6a00:300a:b0:736:5664:53f3 with SMTP id
 d2e1a72fcca58-74058af0dfdmr1649720b3a.15.1746155841073; 
 Thu, 01 May 2025 20:17:21 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058ded48fsm467883b3a.83.2025.05.01.20.17.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 20:17:20 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v3 01/12] qtest/e1000e|igb: Clear interrupt-cause and msix
 pending bits after irq
Date: Fri,  2 May 2025 13:16:53 +1000
Message-ID: <20250502031705.100768-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502031705.100768-1-npiggin@gmail.com>
References: <20250502031705.100768-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42c.google.com
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
triggering of a new interrupt. The msix pending bit which is used
to test for the interrupt is also not cleared (the vector is masked).

Fix this by clearing the ICR/EICR cause bits, and the msix pending
bit using the PBACLR device register.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/e1000e-test.c | 9 ++++++++-
 tests/qtest/igb-test.c    | 8 ++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/e1000e-test.c b/tests/qtest/e1000e-test.c
index de9738fdb74..746d26cfb67 100644
--- a/tests/qtest/e1000e-test.c
+++ b/tests/qtest/e1000e-test.c
@@ -66,6 +66,10 @@ static void e1000e_send_verify(QE1000E *d, int *test_sockets, QGuestAllocator *a
 
     /* Wait for TX WB interrupt */
     e1000e_wait_isr(d, E1000E_TX0_MSG_ID);
+    /* Read ICR to make it ready for next interrupt, assert TXQ0 cause */
+    g_assert(e1000e_macreg_read(d, E1000_ICR) & E1000_ICR_TXQ0);
+    /* Write PBACLR to clear the MSIX pending bit */
+    e1000e_macreg_write(d, E1000_PBACLR, (1 << E1000E_TX0_MSG_ID));
 
     /* Check DD bit */
     g_assert_cmphex(le32_to_cpu(descr.upper.data) & E1000_TXD_STAT_DD, ==,
@@ -117,7 +121,10 @@ static void e1000e_receive_verify(QE1000E *d, int *test_sockets, QGuestAllocator
 
     /* Wait for TX WB interrupt */
     e1000e_wait_isr(d, E1000E_RX0_MSG_ID);
-
+    /* Read ICR to make it ready for next interrupt, assert RXQ0 cause */
+    g_assert(e1000e_macreg_read(d, E1000_ICR) & E1000_ICR_RXQ0);
+    /* Write PBACLR to clear the MSIX pending bit */
+    e1000e_macreg_write(d, E1000_PBACLR, (1 << E1000E_RX0_MSG_ID));
     /* Check DD bit */
     g_assert_cmphex(le32_to_cpu(descr.wb.upper.status_error) &
         E1000_RXD_STAT_DD, ==, E1000_RXD_STAT_DD);
diff --git a/tests/qtest/igb-test.c b/tests/qtest/igb-test.c
index 3d397ea6973..cf8b4131cf2 100644
--- a/tests/qtest/igb-test.c
+++ b/tests/qtest/igb-test.c
@@ -69,6 +69,10 @@ static void igb_send_verify(QE1000E *d, int *test_sockets, QGuestAllocator *allo
 
     /* Wait for TX WB interrupt */
     e1000e_wait_isr(d, E1000E_TX0_MSG_ID);
+    /* Read EICR which clears it ready for next interrupt, assert TXQ0 cause */
+    g_assert(e1000e_macreg_read(d, E1000_EICR) & (1 << E1000E_TX0_MSG_ID));
+    /* Write PBACLR to clear the MSIX pending bit */
+    e1000e_macreg_write(d, E1000_PBACLR, (1 << E1000E_TX0_MSG_ID));
 
     /* Check DD bit */
     g_assert_cmphex(le32_to_cpu(descr.wb.status) & E1000_TXD_STAT_DD, ==,
@@ -120,6 +124,10 @@ static void igb_receive_verify(QE1000E *d, int *test_sockets, QGuestAllocator *a
 
     /* Wait for TX WB interrupt */
     e1000e_wait_isr(d, E1000E_RX0_MSG_ID);
+    /* Read EICR which clears it ready for next interrupt, assert RXQ0 cause */
+    g_assert(e1000e_macreg_read(d, E1000_EICR) & (1 << E1000E_RX0_MSG_ID));
+    /* Write PBACLR to clear the MSIX pending bit */
+    e1000e_macreg_write(d, E1000_PBACLR, (1 << E1000E_RX0_MSG_ID));
 
     /* Check DD bit */
     g_assert_cmphex(le32_to_cpu(descr.wb.upper.status_error) &
-- 
2.47.1


