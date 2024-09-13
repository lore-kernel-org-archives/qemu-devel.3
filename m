Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E79C9FC616B
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 17:29:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spA4q-0006ud-Ey; Fri, 13 Sep 2024 13:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1spA4g-0006CO-AI
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 13:27:14 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1spA4Y-0005vL-US
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 13:27:13 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c4146c7d5dso1401064a12.3
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 10:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726248425; x=1726853225; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qJmFYzrzBJkStmV1LFnozcM8CHfOVSOnWWdPSAqY7Qc=;
 b=Qw+Vtzd6IVAGId4iOttExRLVzUDJ7++KJPl2YS6RliwFJTJjVCrZ0bQk5yUWmOJgvb
 5p36vx9A/W/wzy/S31W5bzvdqD0cjPOYfzyDS29E6KH4xFSa97x5LLfnaxGoRRmYef/R
 /2yRKDjIv8jGP0T2uKIO338yRGGBGrzINXWewmvHII+WfCrPYgQgLCIeFYg8xUeBL8dY
 n+y/Mfrt7Rhld3BvxLVcanwTboMp7tlMxs3XaKoJvtvQVTOhSrmLskjyj2ZEtf59ANY0
 5J7p6/dS2TSMmbhBM9gAKh4z8fV+ZxQtx8tcJPTEFW6tQchHBRh/dVhy9qr1nTzo529F
 oASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726248425; x=1726853225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qJmFYzrzBJkStmV1LFnozcM8CHfOVSOnWWdPSAqY7Qc=;
 b=dwTqNJPa6o/qlRwLkP3fW0idqsCj8Y2yxeT1sHKG1xsc1ZF/vmUC6OropWzUmltKx0
 2AptrQpHCn16zIN0n73noOd/BDEajN7lfH0QbsQVTjUGrxHvLOhe/Ft0K6EVnD5Yw+oq
 rDFWyPE9hSVJXB8EN9A+LVoNJWI1fXocaesN5D7+5/HHaufIjxI5wfhF3dWYIzqVbcO7
 r3BGXCRQLIkrQmUoICLSHZAQSKlcS/BrsKFJmscw4jiv/V7/vxdriAZASgJLVODvAcH7
 UA5SsRH8hRWurhkhJ2zoN9j8J8uwLTYnWSUnbf2r8mbbov5anGdXtQ4bEQa/7JHQjDF2
 xqUQ==
X-Gm-Message-State: AOJu0YzCwU5r6ZY9LH/6LCSm4vZFXOO+UnBsMf7mGJfcR1WjSaDXTzZ3
 gXz0bbGqYwPynCUKmYn/vj9bdtzt8uXy+Je56w/OO5KZAF8451yR7uptCLaUtM0=
X-Google-Smtp-Source: AGHT+IGLPRhNNI0bt9w/iMQTNqGBgqLgWbjN5/Xn+K77TqL0T/kuT3mFR36/UF1Kpyrbp7EH+enDZw==
X-Received: by 2002:a17:907:25ca:b0:a90:348f:fad7 with SMTP id
 a640c23a62f3a-a9047d3dd87mr313071766b.38.1726248424761; 
 Fri, 13 Sep 2024 10:27:04 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25830efdsm891313366b.41.2024.09.13.10.26.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 10:27:00 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1D6275FA2D;
 Fri, 13 Sep 2024 18:26:57 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, devel@lists.libvirt.org,
 Thomas Huth <thuth@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-ppc@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-s390x@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH 10/17] tests/tcg: clean up output of memory system test
Date: Fri, 13 Sep 2024 18:26:48 +0100
Message-Id: <20240913172655.173873-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240913172655.173873-1-alex.bennee@linaro.org>
References: <20240913172655.173873-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Message-Id: <20240910140733.4007719-20-alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/multiarch/system/memory.c | 47 ++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 18 deletions(-)

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
2.39.2


