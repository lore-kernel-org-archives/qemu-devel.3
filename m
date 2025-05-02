Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5203C369DC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 03:19:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAgva-0005WE-P7; Thu, 01 May 2025 23:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAgut-0004dc-TV
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:18:27 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAguo-0004Gc-IF
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:18:23 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7403f3ece96so2254720b3a.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 20:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746155897; x=1746760697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mcgWH2x0gAyjXMufV1B2NOlfCFMvX5UXpeLLJX0H558=;
 b=HDICwuy+HMkcWNHr1uW73b+k0YHMVUu9+BoYLi42ARQgsrHttpvR0fBRSh2FlOOAgS
 55aXlp9mjypfKHb3sFbaCFq6Eint1ackzRGxKyi9rRns5vLp1efcea8mUJa2czIScDAs
 fiLS+H4sau8cLoq7rxvmmj9b0c5q0BQ5Ix5dO64RI2IU1fPpW7WSPFJ73bNC/w29wlZX
 yYzaU+K0Xvpgt4chW9IGXhfRuvMHWLNMMghmyqyMh1f0W4GmHd7AM7hTNCbeLF5v2mLi
 8fNO/UKMcq0PUEwkyvScgLEbPtejJCNUPa/1PMsArb40HokcrPK2rtUDDOR5jP4cchYJ
 /XRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746155897; x=1746760697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mcgWH2x0gAyjXMufV1B2NOlfCFMvX5UXpeLLJX0H558=;
 b=iyDcTbgC9uSbLdiW9u5CkiMypd/0CPYGNvh4FYd8VQwPnlShB/rUqqJQ+PKUa6VEyK
 mmLiE2eA7w7JW8x0IkrLcDTSIpPqv875MdBzFlfFL+nTF1cbGxB3OE/NjXzUDaUsM+lE
 wOWcXJq1IKtIlMvSMlvn8QWXScvW5uqi7otWnWgwfzyV1Xh/UkC/KOa/6o+79T4WgxYD
 W/8YJGkZ8wCnCKCXEBtVojfFBbNbcSkTZeplOXQoU9hXLMgY1l1eUF+uncKdyhyJKm2L
 6iGeoFWP4D6X75tFY+TYe4EZNUNTiRRQkJtnZu2CE6CDm8clsVebLvgau5lSek5yzEU2
 Xn0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhSN3Wz0qUgquOZQuFQuNHi7VhS6B8SgEUJ1t0AAORHDq0xlWnEaW8gKHc6U+jHS1/Evwv4YoRNaIA@nongnu.org
X-Gm-Message-State: AOJu0Yw8PqK0FRb/FKL9nGQZqrfrj9fx8npnmaQ5E/ZdYB4wOnpMpoPL
 UkYGTNF+us26QCPEg6fi3q2Dl35DvoXplorg/GFnmqMVITa9lpAT
X-Gm-Gg: ASbGncuF1X5QrJuMr8dXIn/fIvGyFNGPmBOZk1Q0uQa9/jn7NTRs2jIBPUOtWunn4t9
 5UlrIZnEFprGZpFFyk0+CSm3l7aoJ1AngYQU83oAlQCNCfGJRhi0TIPI/zOnnu2NHqRUWQAtA3P
 dZHcNVZ1Zd5gS5mv19DJGgIvAol7Iow+Gt8xMlHDKvgi3+d/c+NfseGtPSFLGgPga6FMef46Q8C
 wHGJzWK6tdtVot4qSWNaJGxAOhmUuBGqJoF1CGdSiu4o+aIOkmFxVAETHGcG0Ap1q2snC1asZi3
 38Uo5gpZHgGmbFFazcWlRmf7N+IcnYjYP8jASlK4I8xD
X-Google-Smtp-Source: AGHT+IHyIQQtZXpq1SpDCms0tMJEDCkUMuT4WHVgLAALpSPQIW+YceC+48iuYcrIQNO3pJ2hkD5whg==
X-Received: by 2002:a05:6a00:8f0a:b0:736:a973:748 with SMTP id
 d2e1a72fcca58-74058b28595mr1986991b3a.22.1746155897257; 
 Thu, 01 May 2025 20:18:17 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058ded48fsm467883b3a.83.2025.05.01.20.18.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 20:18:16 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 12/12] qtest/e1000e|igb: Test interrupt throttling in
 multiple_transfers test
Date: Fri,  2 May 2025 13:17:04 +1000
Message-ID: <20250502031705.100768-13-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502031705.100768-1-npiggin@gmail.com>
References: <20250502031705.100768-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
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


