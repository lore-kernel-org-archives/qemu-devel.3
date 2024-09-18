Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A50CDD55C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 21:08:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr1tU-00058O-W6; Wed, 18 Sep 2024 17:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sr1tS-0004xL-Hi
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 17:07:22 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sr1tQ-0001d0-Qb
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 17:07:22 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a8d6ac24a3bso25856366b.1
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 14:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726693639; x=1727298439; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iLLNzDuXO6l38mWtmOPS4GSPo9r5e2DeNF89YDm6xy8=;
 b=mK4YNyQQgoZdgOSXfBNOOzCpweP/n1CNjzsgjBubO/D5VBib13+Zna6M/1GoJvaabv
 gayqH2H+YlZhh0yETAfYaLl0Mkx79GTVbDtyR/nk+qRS7S+gzZpz9KycZTw8QO8f/TK1
 LA9iAYy78sQgLprK17Q9eXTLmXxvJdMN0h2qSfac49vXJEWRhBKLMe0VWoGWWXTf7xE4
 bBPTWUizC9feYNcsP3rWUNNLpMh/o4GKr3+rWHTMidS+nvBSWnldcaStxDvGpz4b5qIa
 zZzaBhAAAKgbCI3VIzfSwnHxah2q78rJB5tGHKB7U3BKspgUGaWmGjcT7dzktdOxkdmp
 y2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726693639; x=1727298439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iLLNzDuXO6l38mWtmOPS4GSPo9r5e2DeNF89YDm6xy8=;
 b=QCdc6T33qumaQl6OS/EWIPGCodU6H2C+3hMo2zGnBTVBxKzp8XtQt01E7b4Cm8Lg1X
 6tsNY6zGzik/y5721aei+ZGzqxTGbwXX1Ye6BU4sTfEhy+Sk/0gtiegzD9CUuw79wuI2
 1+y5ed7f93CYWapet5vTihTdgqjQVCyTFVsL1ohd75QLqr24U1M9na7cmDDk8h8tqQVz
 QJwVsqPFEzELQt58Ji5rm1w5Zqpx6BFGJTb4eqg/41LIVOHmeUbWWUdRraFTwrGeHzPm
 vVHPn2YVRXh/+kTwXDAvPs1eXlRgWtf3zfzvLNRkzDJlZcspNX7LEOdDct9TXXmyIn2k
 YoLg==
X-Gm-Message-State: AOJu0Yyz14HYBZvLthC85dS2r4TMHTP8JdbD9ZO2m8jbB8AJJXYbASeQ
 5cbdiRiaCRwe1NksbiKG7qbNkkejnPqt2VuN0C8iLWPY2oMj4WbhEhw28aO4Xr4=
X-Google-Smtp-Source: AGHT+IG05uFpzjIxHINLNtbWTYHY8K7udQNhDV0atz3u24AxboKq09Pp3MVKKur2QIMNUuq4akL9gA==
X-Received: by 2002:a17:907:3f88:b0:a6f:996f:23ea with SMTP id
 a640c23a62f3a-a90c1ce8ea1mr83755966b.15.1726693639225; 
 Wed, 18 Sep 2024 14:07:19 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612b99c3sm636282566b.127.2024.09.18.14.07.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 14:07:16 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3BD1E5F947;
 Wed, 18 Sep 2024 22:07:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 10/18] tests/tcg: clean up output of memory system test
Date: Wed, 18 Sep 2024 22:07:04 +0100
Message-Id: <20240918210712.2336854-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240918210712.2336854-1-alex.bennee@linaro.org>
References: <20240918210712.2336854-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This is useful information when debugging memory issues so lets
improve by:

  - include the ptr address for u8 fills (like the others)
  - indicate the number of operations for reads and writes
  - explicitly note when we are flushing
  - move the fill printf to after the reset

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240916085400.1046925-11-alex.bennee@linaro.org>

diff --git a/tests/tcg/multiarch/system/memory.c b/tests/tcg/multiarch/system/memory.c
index 6eb2eb16f7..8f2371975d 100644
--- a/tests/tcg/multiarch/system/memory.c
+++ b/tests/tcg/multiarch/system/memory.c
@@ -63,12 +63,14 @@ static void init_test_data_u8(int unused_offset)
     int i;
     (void)(unused_offset);
 
-    ml_printf("Filling test area with u8:");
+    ml_printf("Filling test area with u8 (%p):", ptr);
+
     for (i = 0; i < TEST_SIZE; i++) {
         *ptr++ = BYTE_NEXT(count);
         pdot(i);
     }
-    ml_printf("done\n");
+
+    ml_printf("done %d @ %p\n", i, ptr);
 }
 
 /*
@@ -94,7 +96,7 @@ static void init_test_data_s8(bool neg_first)
         *ptr++ = get_byte(i, !neg_first);
         pdot(i);
     }
-    ml_printf("done\n");
+    ml_printf("done %d @ %p\n", i * 2, ptr);
 }
 
 /*
@@ -105,9 +107,18 @@ static void reset_start_data(int offset)
 {
     uint32_t *ptr = (uint32_t *) &test_data[0];
     int i;
+
+    if (!offset) {
+        return;
+    }
+
+    ml_printf("Flushing %d bytes from %p: ", offset, ptr);
+
     for (i = 0; i < offset; i++) {
         *ptr++ = 0;
     }
+
+    ml_printf("done %d @ %p\n", i, ptr);
 }
 
 static void init_test_data_u16(int offset)
@@ -117,17 +128,17 @@ static void init_test_data_u16(int offset)
     const int max = (TEST_SIZE - offset) / sizeof(word);
     int i;
 
-    ml_printf("Filling test area with u16 (offset %d, %p):", offset, ptr);
-
     reset_start_data(offset);
 
+    ml_printf("Filling test area with u16 (offset %d, %p):", offset, ptr);
+
     for (i = 0; i < max; i++) {
         uint16_t low = BYTE_NEXT(count), high = BYTE_NEXT(count);
         word = BYTE_SHIFT(high, 1) | BYTE_SHIFT(low, 0);
         *ptr++ = word;
         pdot(i);
     }
-    ml_printf("done @ %p\n", ptr);
+    ml_printf("done %d @ %p\n", i, ptr);
 }
 
 static void init_test_data_u32(int offset)
@@ -137,10 +148,10 @@ static void init_test_data_u32(int offset)
     const int max = (TEST_SIZE - offset) / sizeof(word);
     int i;
 
-    ml_printf("Filling test area with u32 (offset %d, %p):", offset, ptr);
-
     reset_start_data(offset);
 
+    ml_printf("Filling test area with u32 (offset %d, %p):", offset, ptr);
+
     for (i = 0; i < max; i++) {
         uint32_t b4 = BYTE_NEXT(count), b3 = BYTE_NEXT(count);
         uint32_t b2 = BYTE_NEXT(count), b1 = BYTE_NEXT(count);
@@ -149,7 +160,7 @@ static void init_test_data_u32(int offset)
         *ptr++ = word;
         pdot(i);
     }
-    ml_printf("done @ %p\n", ptr);
+    ml_printf("done %d @ %p\n", i, ptr);
 }
 
 static void init_test_data_u64(int offset)
@@ -159,10 +170,10 @@ static void init_test_data_u64(int offset)
     const int max = (TEST_SIZE - offset) / sizeof(word);
     int i;
 
-    ml_printf("Filling test area with u64 (offset %d, %p):", offset, ptr);
-
     reset_start_data(offset);
 
+    ml_printf("Filling test area with u64 (offset %d, %p):", offset, ptr);
+
     for (i = 0; i < max; i++) {
         uint64_t b8 = BYTE_NEXT(count), b7 = BYTE_NEXT(count);
         uint64_t b6 = BYTE_NEXT(count), b5 = BYTE_NEXT(count);
@@ -174,7 +185,7 @@ static void init_test_data_u64(int offset)
         *ptr++ = word;
         pdot(i);
     }
-    ml_printf("done @ %p\n", ptr);
+    ml_printf("done %d @ %p\n", i, ptr);
 }
 
 static bool read_test_data_u16(int offset)
@@ -198,7 +209,7 @@ static bool read_test_data_u16(int offset)
         }
 
     }
-    ml_printf("done @ %p\n", ptr);
+    ml_printf("done %d @ %p\n", i, ptr);
     return true;
 }
 
@@ -239,7 +250,7 @@ static bool read_test_data_u32(int offset)
             pdot(i);
         }
     }
-    ml_printf("done @ %p\n", ptr);
+    ml_printf("done %d @ %p\n", i, ptr);
     return true;
 }
 
@@ -293,7 +304,7 @@ static bool read_test_data_u64(int offset)
             pdot(i);
         }
     }
-    ml_printf("done @ %p\n", ptr);
+    ml_printf("done %d @ %p\n", i, ptr);
     return true;
 }
 
@@ -365,7 +376,7 @@ static bool read_test_data_s8(int offset, bool neg_first)
             return false;
         }
     }
-    ml_printf("done @ %p\n", ptr);
+    ml_printf("done %d @ %p\n", i * 2, ptr);
     return true;
 }
 
@@ -398,7 +409,7 @@ static bool read_test_data_s16(int offset, bool neg_first)
             return false;
         }
     }
-    ml_printf("done @ %p\n", ptr);
+    ml_printf("done %d @ %p\n", i, ptr);
     return true;
 }
 
@@ -431,7 +442,7 @@ static bool read_test_data_s32(int offset, bool neg_first)
             return false;
         }
     }
-    ml_printf("done @ %p\n", ptr);
+    ml_printf("done %d @ %p\n", i, ptr);
     return true;
 }
 
-- 
2.39.5


