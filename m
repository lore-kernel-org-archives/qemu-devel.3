Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D06C02188
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 17:04:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYpl9-00058K-Oz; Fri, 17 Jan 2025 12:03:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tYpl8-000566-KW
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 12:03:50 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tYpl6-0003KE-Vd
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 12:03:50 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21628b3fe7dso45214585ad.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 09:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737133427; x=1737738227; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wvepc9/egIz33GAVfLK/6PWrQWvK+mZKZDbc3onZwIU=;
 b=ksnNflHtW3c3+KVNjEvlBIADrZqQMmc1K9PXyfKG/CLVsXprR9vRukLzI/RhoFht6L
 q8BUhPMTGGxaAPyX89ov1bNh3LIoaLkZhnQzBW/4eKxzKMcHfKcorBswMJKCI4YJHLDz
 a5wwt8SeME+kdAu6FnTVFKVlFgj1mm74uEOT7ScOhiFo+uRxumH/XQb2sp2R4KovLKDi
 TB2Z8xkWr+QHCO28brnAOLGYjBV7xcY1jdlLTk6aw1Owq0czCmNbqeOjLZ0aG7iZ32V7
 weoB66OInqIYMx6sT5f1JT4MDAAcH/SZpSHHP+BcYoDE57HHe7UYgLa6BSGTO0JtNU+h
 CIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737133427; x=1737738227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wvepc9/egIz33GAVfLK/6PWrQWvK+mZKZDbc3onZwIU=;
 b=xTglLUyTv8v3SDS6dp5hrEidnYlPCP/YichqDt/E0Un+zYihHjHTtVzGJfkgP+8Bv7
 INf2jENzYxGEQKqVbnucPf9TIHvY5wkpfVGCChDErTpRNxV+xFa4DepYoeMY2apotVk+
 WycybTbJNl8HMiugy+XSvN1XYrXq/PzlYGu46vYWTuf9C63wNg7E1qZJcUwgiS6xpfkL
 lR7Ub3vdZckPD644dqZ+UpEUrhHN0NvIs6TCjIByvy8JJdFKriq1J+UDz4mo7X4t0Vsf
 oKYEaZk2pyZzkDlOM/V8QVXyFgvM5ACLVc1qL6oVk6oqmgwXMRL+P9WL8J//kH73K67A
 36AA==
X-Gm-Message-State: AOJu0Yz+4dpFEsYpyQzl+N3cc9zjpyN/UvBfp47vyRRau+ApBxFv05Qu
 10cUx3JV+H5FqUo555nVRPOOx3M+gMyrCdqs1ISD0/KTpm1Lx7//QnKCLg==
X-Gm-Gg: ASbGncuTbRFqxmBPt42fZEReXEdXj0IaBhNArkmgydjzP/VLl94A+4m+1RSHxeFvyDP
 sT0KwvXu5jKaWRfZVC1pP0wGxUD+hbEWIZeKXulXmz0DOiWweyT8YKO3aO10JbiukcM0kVDIOyy
 hKaHOqJm0liv/hNHZm8WMJLJrk5Y4tRV8MvItnKFT+mw+AvzBsSq0FRi95B94EyiZcGBHMxz5Oi
 HrYdGwsVJZIOrgdCRNzanZgjpAXSVGEaR3G+ovU1EYyGlFhpB1pu0X9wBpiiY7PM1YqFwlpRkew
 CQPomuEWWKQkbiE=
X-Google-Smtp-Source: AGHT+IETECs3xoArv5jUUdmKpuhZ/gJ8oTufL0EQYYewFuBUB74pR0NI00BfMy3ycWxcF9EomG6vQQ==
X-Received: by 2002:a17:902:eccd:b0:216:410d:4c67 with SMTP id
 d9443c01a7336-21c355c8efbmr54305535ad.41.1737133426700; 
 Fri, 17 Jan 2025 09:03:46 -0800 (PST)
Received: from wheely.local0.net (124-169-212-233.tpgi.com.au.
 [124.169.212.233]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2cea0b91sm18249435ad.49.2025.01.17.09.03.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 09:03:46 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 7/9] qtest/e1000e|igb: Test interrupt throttling in
 multiple_transfers test
Date: Sat, 18 Jan 2025 03:03:03 +1000
Message-ID: <20250117170306.403075-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250117170306.403075-1-npiggin@gmail.com>
References: <20250117170306.403075-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x636.google.com
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
in the multiple_transfers test, to improve coverage.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/e1000e-test.c | 4 ++--
 tests/qtest/igb-test.c    | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/e1000e-test.c b/tests/qtest/e1000e-test.c
index 9ab81ecff5b..5e391095f32 100644
--- a/tests/qtest/e1000e-test.c
+++ b/tests/qtest/e1000e-test.c
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
index 1bbb4bea4c1..0a9c5162019 100644
--- a/tests/qtest/igb-test.c
+++ b/tests/qtest/igb-test.c
@@ -198,6 +198,10 @@ static void test_igb_multiple_transfers(void *obj, void *data,
         return;
     }
 
+    /* Use EITR for one irq and disable it for the other, for testing */
+    e1000e_macreg_write(d, E1000_EITR(E1000E_RX0_MSG_ID), 0);
+    e1000e_macreg_write(d, E1000_EITR(E1000E_TX0_MSG_ID), 125 << 2);
+
     for (i = 0; i < iterations; i++) {
         igb_send_verify(d, data, alloc);
         igb_receive_verify(d, data, alloc);
-- 
2.45.2


