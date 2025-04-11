Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF9AC36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 04:33:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u363u-0004qh-W3; Fri, 11 Apr 2025 00:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u363t-0004qO-4l
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 00:32:17 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u363r-0007cE-LG
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 00:32:16 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2264aefc45dso22669095ad.0
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 21:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744345934; x=1744950734; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mcgWH2x0gAyjXMufV1B2NOlfCFMvX5UXpeLLJX0H558=;
 b=OJgh/AbCjYG+1umPSDll0VldZN9yoH8SnANkxyQhGughfBDbL5aCGBHRy0xLMYoekj
 9vPW6+4oqkXYS9/yh4tZV8M6qj1S2GAbTVTx0TaRSRzPqQuAjQs2cW6jxyWtEIqhLoC3
 zcGU6tlZ1FdLjt/Lw8DQvXw6H+9Fxl28SdcCZnI1nVGw9pPgCszo373YxyGqgTajnEln
 WJICMJKXwHWptPetbXFFMxgYCP681ZNWJ7M7amu21WTtS02Q4u1awLjO/tJh/zzREdbe
 rGRr+Eul95JOAQdWwgdu7s1jJeWj9ssl210dZF8U+DtoN0ExGVfkSEpgWiT+jm/mKrOF
 XErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744345934; x=1744950734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mcgWH2x0gAyjXMufV1B2NOlfCFMvX5UXpeLLJX0H558=;
 b=dT2HEekLK1seOz1sb45cRCMzZUMCAsTGXj964tkLOh9x8HxMmKQP4dAG+EImZFyYA0
 zODpVaBquwI3Q141C8IPWA8F1C09LFniWI1eDMULs4+PlagQb47qAS0Y5eaFTIjOouGz
 ZpRWujw0csmX/iaDhj0wXvDvU2XOQqE6AEUVxiUTr5Qbo712AreLswx9eJ5/FjaixIUy
 0Xk0Z4bPMVYpbOhtVc8nxPzhFvHPAwa5T46wWvDaBwK6BYcX4J0U/Jh6ZMCmWXWUqwPy
 RfJSXJBBFnep4gQ9OfqZMFWq/Y3T177H0nrdH50Y1YlubQhT4Bf+P7s/7ZAIrw3V7bfH
 M0GA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSRmRxJw2h9mwjiaf6qMjl9xqz1sohMzvsdoFF1itOQaW3GRTcAn8aGxTqbvAkexZjR0Y8EH3fy1ib@nongnu.org
X-Gm-Message-State: AOJu0Yx2Lu3krg0vCocUX/IL93/ngEdTDrJmCbzeczHXHzOIzmUD+/nI
 Zsv1z55MvhP/5YxnKF9gT0jFFNRYB1ckWPUW55zlB0JIue1jlAnd
X-Gm-Gg: ASbGnct8aWOcxzyVA9yOzLAGZksNnU+YooX+JoJyCgZKV2w8IX7kSDv+mrNcRr/nHoB
 0d33DAYepqR+3/R1PJKWCD6J9Ah7f/Ekm8SA+CcsKUdZezdPWNyYqoZwZ3R19SYhWnqfheDTfMT
 soXAk4p2+co0l7/oh9/tszBLzRiTx1775su8FdhkrywiyZCQS7ZsXFDEn4jYxvnEP3JVFYJtDHJ
 VBONAGukUe6kiDUi48qKmgFnT6WjLGCEPkcbsz6+96udDu3UL74BNAk9sUw6OFqw7tI9WxrlXQ4
 PdYvNjST7tLCnV6FT6BXfmY9ueoCg0FIJf/1MbA2RldT+PCLpnXca8M=
X-Google-Smtp-Source: AGHT+IHq/k0DRaOYU1Gs2Ofnj69VHaktdTpevJkZUvSXAlauomL2AgIkD9W05Tu9oe/R09tiecI9rg==
X-Received: by 2002:a17:903:1c7:b0:220:e5be:29c7 with SMTP id
 d9443c01a7336-22bea4f180fmr22059705ad.39.1744345933977; 
 Thu, 10 Apr 2025 21:32:13 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7b64906sm39361625ad.48.2025.04.10.21.32.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 21:32:13 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 8/8] qtest/e1000e|igb: Test interrupt throttling in
 multiple_transfers test
Date: Fri, 11 Apr 2025 14:31:28 +1000
Message-ID: <20250411043128.201289-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250411043128.201289-1-npiggin@gmail.com>
References: <20250411043128.201289-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
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

Enable interrupt throtling on one of the two queue interrupts used
in the multiple_transfers test, to improve coverage. The number of
interrupts for the e1000e test is reduced because it has a long minimum
throttling delay so without reducing iterations throttling adds about
40s to the test runtime.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/e1000e-test.c | 6 +++---
 tests/qtest/igb-test.c    | 4 ++++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/e1000e-test.c b/tests/qtest/e1000e-test.c
index a538c72cc84..645b31127f0 100644
--- a/tests/qtest/e1000e-test.c
+++ b/tests/qtest/e1000e-test.c
@@ -181,7 +181,7 @@ static void test_e1000e_rx(void *obj, void *data, QGuestAllocator * alloc)
 static void test_e1000e_multiple_transfers(void *obj, void *data,
                                            QGuestAllocator *alloc)
 {
-    static const long iterations = 4 * 1024;
+    static const long iterations = 1 * 1024;
     long i;
 
     QE1000E_PCI *e1000e = obj;
@@ -194,8 +194,8 @@ static void test_e1000e_multiple_transfers(void *obj, void *data,
         return;
     }
 
-    /* Clear EITR because buggy QEMU throttle timer causes superfluous irqs */
-    e1000e_macreg_write(d, E1000_EITR + E1000E_RX0_MSG_ID * 4, 0);
+    /* Use EITR for one irq and disable it for the other, for testing */
+    e1000e_macreg_write(d, E1000_EITR + E1000E_RX0_MSG_ID * 4, 500);
     e1000e_macreg_write(d, E1000_EITR + E1000E_TX0_MSG_ID * 4, 0);
 
     for (i = 0; i < iterations; i++) {
diff --git a/tests/qtest/igb-test.c b/tests/qtest/igb-test.c
index 12cdd8b498a..c1877a77be4 100644
--- a/tests/qtest/igb-test.c
+++ b/tests/qtest/igb-test.c
@@ -198,6 +198,10 @@ static void test_igb_multiple_transfers(void *obj, void *data,
         return;
     }
 
+    /* Use EITR for one irq and disable it for the other, for testing */
+    e1000e_macreg_write(d, E1000_EITR(E1000E_RX0_MSG_ID), 0);
+    e1000e_macreg_write(d, E1000_EITR(E1000E_TX0_MSG_ID), 10 << 2); /* 10us */
+
     for (i = 0; i < iterations; i++) {
         igb_send_verify(d, data, alloc);
         igb_receive_verify(d, data, alloc);
-- 
2.47.1


