Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD3E3C3ABA2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 08:57:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sq7VX-0001j4-V0; Mon, 16 Sep 2024 04:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sq7V8-0000XT-Ar
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 04:54:31 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sq7Uq-0005E2-Rk
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 04:54:30 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5367ae52a01so3294291e87.3
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2024 01:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726476851; x=1727081651; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mlT6xKCM1MHGEdfr2CcDhKWOabJzOeHlvX+jZ2i+MVk=;
 b=xMK+nSwB9XzwUW5iheJut5EN9Q0Pl/TC6LbBgQyO/rU7/1sDEIEgy0Q1SD0glREyJl
 0n8UXrLOpJow8U+i/Fu+B1ou+F6NAbPJHNm/yHvxAuXV/XR4ueRwLOnilq2eHp7EyYo/
 ryrGSk/dwrsxNEiOhwHVFGrr4gYr4Iv8YIU+yXPYaI1rIs1Izdrf5+keATzWXUSV0MDs
 946a7p/nGT/XOwwZu6S8oZAqt1d03DrlGIZluSf0gZro2Q/NEAREN0OxNreh8T9QAgdb
 JA645aiBPY1HSivVSBDfqvqFZIY3A2pThC3n0cNYt91tM8ZnwNuBQdUhqEjXyJ2PfPMh
 w8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726476851; x=1727081651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mlT6xKCM1MHGEdfr2CcDhKWOabJzOeHlvX+jZ2i+MVk=;
 b=ToI1VaKyiTIWLjMp6UBqT9blqM9VTPYHpXv+X4u1VK2XFWjvz0JKbnjoy5A67HCijL
 5mdinZd6LR1x2/WaqHwMDyzMoYVbtC83l6hICbtmjlzzfsOYgcmC9dNzGDs+ULDG6bmz
 enpuAJ2dJpl7nMRer3Ab3KKWc2IMOO4Zr3g8XZq22bqcSw9HPXmySLk6aVDXIJxLdBVi
 +oG8y0mvqcRmKX63AlpgIyhpouaYjt3sqPCm2b3JqRCr8raI5wUWI7GuceWeKPwMUOp/
 GdwDmL5VjvHgopQPwNwqOU3KQBtGjmCnk7oahndFrnhRY12d5A8fW0Z0dCCLxOvdRVSp
 WDEQ==
X-Gm-Message-State: AOJu0YyOkkXdvMthw0G+HT0Ix7qo3WaQ/5dW8HOshU8K0QVkhWoMRDXn
 wfI9LObnghfKY71Tx+dQuB5Qo2jnJV82z/qzAIpnRUEP9ULn6u8QTV+Tsxq0j8I=
X-Google-Smtp-Source: AGHT+IGHj2nwGb6uYQqusZSHRh4xCFnMqnszUIn0COKRzOPHViC17d1ZY9Dr4GyEBiWapaBgAg6Bhg==
X-Received: by 2002:a05:6512:3a8c:b0:52e:987f:cfc6 with SMTP id
 2adb3069b0e04-5367ff32c42mr4417081e87.51.1726476849860; 
 Mon, 16 Sep 2024 01:54:09 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42da242138bsm70655045e9.35.2024.09.16.01.54.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 01:54:04 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 444DC5FC60;
 Mon, 16 Sep 2024 09:54:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Eduardo Habkost <eduardo@habkost.net>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Nicholas Piggin <npiggin@gmail.com>,
 David Hildenbrand <david@redhat.com>, devel@lists.libvirt.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 10/18] tests/tcg: clean up output of memory system test
Date: Mon, 16 Sep 2024 09:53:52 +0100
Message-Id: <20240916085400.1046925-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240916085400.1046925-1-alex.bennee@linaro.org>
References: <20240916085400.1046925-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x132.google.com
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
2.39.5


