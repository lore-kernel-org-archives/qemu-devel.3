Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0696C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 15:02:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY4tu-0004Ha-Tu; Wed, 15 Jan 2025 10:01:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tY4tt-0004HL-TD; Wed, 15 Jan 2025 10:01:45 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tY4ts-0002vs-8v; Wed, 15 Jan 2025 10:01:45 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2161eb94cceso85107665ad.2; 
 Wed, 15 Jan 2025 07:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736953302; x=1737558102; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fHQKJ7ZE130ntDkhQLA0rjO4bmRpsWSpyiW+ZgLoauA=;
 b=Q5XjKDG5fR4f6InVeHcfrUqUEH7nTkZ9U/6yjwTdU9sEOUl8hPGKXyImsq03Vqk02r
 N/J0+iqm+fuAzJMxgkqUfquaYyzgAVn3sxOeSKZYQOoBKzzPpu8aITG6VBDr53wS6L0z
 kR5MOoQrUaY4AYFsKybPqoiyh2N6Vi8onWz0UguUSTGRcemwtFcBIhFMeMIQv1Xahzd9
 uj3EYsX4eh4lnuBiEIyfLfKd6eT8i6qOS6A6c944d4vMJsiPjI77rlK2osnWQoW1l6w6
 ohHzq1Llouzb2w/SiUu6fOoGIdnNYpwXJi5o/Ymx+n6jL3tYKH1NH9LYLGyvtXXWw3kQ
 KRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736953302; x=1737558102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fHQKJ7ZE130ntDkhQLA0rjO4bmRpsWSpyiW+ZgLoauA=;
 b=NJp3/gRE2M/9Xm5D13BT9GorfaVgqLa011rL4Sc7bTu1kcrXJcKRfRkO15oNdIjT70
 MSIYJ7YlpwLtetvNdYxTXSnXEQO9HgVU+kFo35adRq/ItGO1ejkW7dICrnEoHgf31ZeY
 54eJeGgSljYOv1s2oc4esJrMNhRNEROU4nuwwn7PDaLziafvcCm0ZQ19Cvsmzk78RWPw
 sDtYBCYoGuSCeIP55SHZu4dbhd5XYPrGsHQ98WuR6AXVM8M75YK1eLYLnmExnIeeHv8g
 VrJn0CoENujHlNoGM9lS8SXkJelfdusx+HCRtIgZ1MnkUhKPyhQ81B56hSiszMnCWj66
 w7ZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsR4VFOuaDmzQD6kKZhA89Ud9hCQHnsepPIgdiKQ1COD8mVJ3MVgSkUrTBe/c/gOP8T5tbqVcNfYvf@nongnu.org
X-Gm-Message-State: AOJu0YzNSoizs9kvHDELT2A/dJHPnz9QOYp5vdrjatESJevO82QIy1Q3
 nakGo2k81IwZIhaZzIMhEk15m2FmJ+rVM9LRyFASbqa+WSbgphevj5mxww==
X-Gm-Gg: ASbGncupyNvzj+z6BJKGHvHyzebTI+3UaVML/LCLLO4mJbs5IiLlteCkdwupdWl4y1v
 gh7kWi9YrWA6r8q90UpJaah+IGDl+OIBHd87gqpvBjudENB31RZkrRM4Vfjmoc98I+uvR4DJnB1
 jMIPae2y5RKOc6GBom7NuhKFlQRQEDd4v7/tQ1V3AXa1BsZZP0HtK4v6j8Zu+m7uGYfOZj4p11V
 wROGcYpSqlJGZIhv2w2yBzIdKyaeX0nFEgU6kVjdHfQ0bdwbLtpLGH97Gn/+w==
X-Google-Smtp-Source: AGHT+IFmMBSqe4D11QliWOWJ2+3etQjHH7dg1nxLr08YI6XxrOK4Si5S2mC2TeNY66nfqzOez2G0Jw==
X-Received: by 2002:a05:6a00:928c:b0:727:3935:dc83 with SMTP id
 d2e1a72fcca58-72d21fb1e07mr38988916b3a.10.1736953302097; 
 Wed, 15 Jan 2025 07:01:42 -0800 (PST)
Received: from wheely.local0.net ([118.210.104.29])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72d40658a7esm9519592b3a.106.2025.01.15.07.01.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 07:01:41 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, qemu-block@nongnu.org
Subject: [PATCH v2 4/5] qtest/e1000e|igb: Clear interrupt-cause bits after irq
Date: Thu, 16 Jan 2025 01:01:10 +1000
Message-ID: <20250115150112.346497-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250115150112.346497-1-npiggin@gmail.com>
References: <20250115150112.346497-1-npiggin@gmail.com>
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
 tests/qtest/e1000e-test.c | 4 ++++
 tests/qtest/igb-test.c    | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/tests/qtest/e1000e-test.c b/tests/qtest/e1000e-test.c
index de9738fdb74..35548d1c20b 100644
--- a/tests/qtest/e1000e-test.c
+++ b/tests/qtest/e1000e-test.c
@@ -66,6 +66,8 @@ static void e1000e_send_verify(QE1000E *d, int *test_sockets, QGuestAllocator *a
 
     /* Wait for TX WB interrupt */
     e1000e_wait_isr(d, E1000E_TX0_MSG_ID);
+    /* Read ICR to make it ready for next interrupt, assert TXQ0 cause */
+    g_assert(e1000e_macreg_read(d, E1000_ICR) & E1000_ICR_TXQ0);
 
     /* Check DD bit */
     g_assert_cmphex(le32_to_cpu(descr.upper.data) & E1000_TXD_STAT_DD, ==,
@@ -117,6 +119,8 @@ static void e1000e_receive_verify(QE1000E *d, int *test_sockets, QGuestAllocator
 
     /* Wait for TX WB interrupt */
     e1000e_wait_isr(d, E1000E_RX0_MSG_ID);
+    /* Read ICR to make it ready for next interrupt, assert RXQ0 cause */
+    g_assert(e1000e_macreg_read(d, E1000_ICR) & E1000_ICR_RXQ0);
 
     /* Check DD bit */
     g_assert_cmphex(le32_to_cpu(descr.wb.upper.status_error) &
diff --git a/tests/qtest/igb-test.c b/tests/qtest/igb-test.c
index 3d397ea6973..fb77c5e507a 100644
--- a/tests/qtest/igb-test.c
+++ b/tests/qtest/igb-test.c
@@ -69,6 +69,8 @@ static void igb_send_verify(QE1000E *d, int *test_sockets, QGuestAllocator *allo
 
     /* Wait for TX WB interrupt */
     e1000e_wait_isr(d, E1000E_TX0_MSG_ID);
+    /* Read EICR which clears it ready for next interrupt, assert TXQ0 cause */
+    g_assert(e1000e_macreg_read(d, E1000_EICR) & (1 << E1000E_TX0_MSG_ID));
 
     /* Check DD bit */
     g_assert_cmphex(le32_to_cpu(descr.wb.status) & E1000_TXD_STAT_DD, ==,
@@ -120,6 +122,8 @@ static void igb_receive_verify(QE1000E *d, int *test_sockets, QGuestAllocator *a
 
     /* Wait for TX WB interrupt */
     e1000e_wait_isr(d, E1000E_RX0_MSG_ID);
+    /* Read EICR which clears it ready for next interrupt, assert RXQ0 cause */
+    g_assert(e1000e_macreg_read(d, E1000_EICR) & (1 << E1000E_RX0_MSG_ID));
 
     /* Check DD bit */
     g_assert_cmphex(le32_to_cpu(descr.wb.upper.status_error) &
-- 
2.45.2


