Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7317CC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 17:05:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYpl1-0004rN-FN; Fri, 17 Jan 2025 12:03:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tYpkl-0004R0-Bg
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 12:03:27 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tYpkh-0003DU-LE
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 12:03:26 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-216634dd574so29771335ad.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 09:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737133400; x=1737738200; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PpIEU1dOi/a4O4DhFZYj1dyEXnbcVqrH4ogz9Ozo/u0=;
 b=UukvtylNbRB+I5Gsq9hNJScGnwzO1YtU+wAqcg/BC2BnYmI8XgwKI18rOiAVSNliMt
 gKX6einLw49JxwIstvll2kCI7uH0P8p1msvHHF2Q6z1yQnuhO4ZEeD1k3AZ1qEP7LSas
 L0sjeSQmlH/cHhhrfmUb+7HXPXXIn+BiGe1tcoRoMY/wvmb/e/LkaCZ7OBXLZEbh2HRH
 oex6jc1h6QugCguhI2uGu0H0H4ekqkvBrdimf5w9NAVhk4+SkZzZng6qB8hRxq3yehEk
 7HWgud3UcwRWiXkFcfAoiwfrd8xfaJ7QVRgYTRuMngFUOLQUy9FhG3Z0i1DAIkLGQk3t
 mcqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737133400; x=1737738200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PpIEU1dOi/a4O4DhFZYj1dyEXnbcVqrH4ogz9Ozo/u0=;
 b=aSqrxLgfbttsPdGkouAuZcn/vFboEtpQ9JvBFDCmQUm2v5eRauJ/4tV6TOUCJjS8nn
 3Zx2B6XyIn2Qe2hY8Q2sR9+80KbaBzm3gdM0QsgV9KHlG3pirIBJS43XBClsm6vFPwXJ
 lpmY1Hq9KrbCI7kj/Tc2wK90+ZtcRwbjjjs/quefCnnkDD9sJXSCm9jYSnT4HvgiWfFh
 fFTtROMtmOVR+fSOFJ6vYOBVVnm8cHFcJC1DyEAj70rpRh+fZqhEb+MZrRF3ndQTNefG
 NutCbEC9XnSOKyfePX3jTaQIUeP8cu3YM3+IZbzbJIun0F6NkDsTlXq/HO8UM37yH7uH
 XfAg==
X-Gm-Message-State: AOJu0YzeLzsXIglhPV/oXX7dud8YK4vLJxf5pEqC3JtyQbQdpbNpoNDh
 DoHtBXFvNB7Yqlyl0UoLOt1o5YpWTBgGWAIkjFFJnKyLSfCUd/u6RSj7ug==
X-Gm-Gg: ASbGncvBBPzCdnYRV9MOS0Lerh5s8UPvFu7tRAjmekQXuDO3HlfDhjYut15Wz8xKBGQ
 fg01U2Lc+1wKRplrLjGyIIXHvwVD/Ml7MbaFgByqQWSDuPGG165034Gt6/HZ5RhK6OVclfMpj2E
 ARxHC64DSi3BSVeuXHugGubf8n+SqoPq+au77N7qSSS5JA/bchWolfe+jjGKWU9FnwayWW7MBlX
 JW7L9WY0b2k30vrppJVI5yvKBlgJH2HAH+7sx7jvTN/QOyfzGGRHf0EF11W0elE/g5zDd/U+KSI
 pvS1QMzPnwWr2nI=
X-Google-Smtp-Source: AGHT+IEOidCiM0a/OQcmmFLqWoxek4Unm7SSmWRC+5Qg1/zCOOimNHgCpZmHGkULGYpfaYJrRVZoIg==
X-Received: by 2002:a17:902:e74b:b0:218:a4ea:a786 with SMTP id
 d9443c01a7336-21c35607c4emr51361415ad.53.1737133399672; 
 Fri, 17 Jan 2025 09:03:19 -0800 (PST)
Received: from wheely.local0.net (124-169-212-233.tpgi.com.au.
 [124.169.212.233]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2cea0b91sm18249435ad.49.2025.01.17.09.03.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 09:03:19 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 1/9] qtest/e1000e|igb: Clear interrupt-cause and msix pending
 bits after irq
Date: Sat, 18 Jan 2025 03:02:57 +1000
Message-ID: <20250117170306.403075-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250117170306.403075-1-npiggin@gmail.com>
References: <20250117170306.403075-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62d.google.com
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
2.45.2


