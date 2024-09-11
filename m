Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB20FEE499F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:33:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMJx-0003EL-4Q; Wed, 11 Sep 2024 08:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMJf-0000Dm-OV
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:19:24 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMJd-0007fx-1A
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:19:23 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42cba6cdf32so25161105e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726057153; x=1726661953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SLUlDHu7sP6q3ROW5zLQZ225CC2Qf7fSmLeuaJWJv1I=;
 b=JGsarDCs2Ig7A360tP6lVodTIM1E/YShg1L4NYE1Jr9aYTeswsMGGgR1o6ACUk+38f
 Z9C9dL/FCQsvxUXIFoMJQYEJUE9pnhYJXm9FpEwR5OcqDr+woyVgYwUahMVoUqYEsapK
 wFCzuXhtLLYqIa2Fggt3O0QGkrXJ64o9GUyJsGrpeVikBouJ+grGxddAyAdDFfJqTrb2
 9fmUJltcLZ00yupcrhh1oCN9hOx/JR5S7+hiTRO6YUP0EaiZREOuMopUUVlgs7jRQ7o0
 /743ZkUGeH+fT+I5c43RfFuA6GenEAAOmNa0Ed/F6LC4YHzPBRKwoJonEnxWoXfl4/V5
 Uptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726057153; x=1726661953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SLUlDHu7sP6q3ROW5zLQZ225CC2Qf7fSmLeuaJWJv1I=;
 b=FNp0rUcK2tBYXOTXM3FAukCu7uOnLGFb2J5mRDRj3gHKr5tjIbJEgGoJFaPcXR4z9Y
 OYgFDtElJP9O78NKRwsSC3l4bZT7ygQ1VRPVDkx/GqBju0oWkenFXQtcBMITYkMii+8h
 KHHbBoKkCQz6S2s/HoJ4V1YQB4YQ2EZ5JbKU88W/VG1+KaNq+PjeF+0wF4HTbxSe/pDb
 +j1w6Xa89+jqeO2EWDNDPuqfpeqBlwDcLYqjBEFu5eY5tEiXJMJ1XEiVrXEjtcw8qZpS
 HftNP8ZpCBx1k3+uL7AXPz26Dw/XBjHZhUOS6cyGsZaM+PMI++P34oaSPE4xxDwW+Z9i
 wfmA==
X-Gm-Message-State: AOJu0YzPz1Nu5McZ5q31bvzhvNINFpJXUpyJB5Xvjr2ZXN9QQCYfN12J
 9RvIHuN754dMHcT0EEq0J3RlDSY3pavgwDi52p8LlnXUJchyqNZOz+iwGTlUmQ5vXwfxk8O5Bzo
 D
X-Google-Smtp-Source: AGHT+IGayYza9Yr+2xwGB/apX/kfx9L6OO3gTH+ZJWn5u0uW81i/aiWUaGF1Q4jzljQUOpnOvQ/IDA==
X-Received: by 2002:adf:f4cc:0:b0:371:86bc:6c05 with SMTP id
 ffacd0b85a97d-378895c31ddmr10254028f8f.10.1726057153296; 
 Wed, 11 Sep 2024 05:19:13 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42cb3098dbdsm120964895e9.33.2024.09.11.05.19.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 05:19:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 41/56] tests/unit: Strengthen FIFO8 tests
Date: Wed, 11 Sep 2024 14:14:06 +0200
Message-ID: <20240911121422.52585-42-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121422.52585-1-philmd@linaro.org>
References: <20240911121422.52585-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Replace reused bytes { 0x1, 0x2, 0x3, 0x4 } by { 0x9, 0xa, 0xb, 0xc }
to be sure a different value is overwritten.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20240906132909.78886-2-philmd@linaro.org>
---
 tests/unit/test-fifo.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/unit/test-fifo.c b/tests/unit/test-fifo.c
index 1e54cde871..9b3a4940d0 100644
--- a/tests/unit/test-fifo.c
+++ b/tests/unit/test-fifo.c
@@ -22,7 +22,7 @@ static void test_fifo8_pop_bufptr_wrap(void)
 {
     Fifo8 fifo;
     uint8_t data_in1[] = { 0x1, 0x2, 0x3, 0x4 };
-    uint8_t data_in2[] = { 0x5, 0x6, 0x7, 0x8, 0x1, 0x2 };
+    uint8_t data_in2[] = { 0x5, 0x6, 0x7, 0x8, 0x9, 0xa };
     const uint8_t *buf;
     uint32_t count;
 
@@ -65,7 +65,7 @@ static void test_fifo8_peek_bufptr_wrap(void)
 {
     Fifo8 fifo;
     uint8_t data_in1[] = { 0x1, 0x2, 0x3, 0x4 };
-    uint8_t data_in2[] = { 0x5, 0x6, 0x7, 0x8, 0x1, 0x2 };
+    uint8_t data_in2[] = { 0x5, 0x6, 0x7, 0x8, 0x9, 0xa };
     const uint8_t *buf;
     uint32_t count;
 
@@ -112,7 +112,7 @@ static void test_fifo8_pop_buf_wrap(void)
 {
     Fifo8 fifo;
     uint8_t data_in1[] = { 0x1, 0x2, 0x3, 0x4 };
-    uint8_t data_in2[] = { 0x5, 0x6, 0x7, 0x8, 0x1, 0x2, 0x3, 0x4 };
+    uint8_t data_in2[] = { 0x5, 0x6, 0x7, 0x8, 0x9, 0xa, 0xb, 0xc };
     uint8_t data_out[4];
     int count;
 
@@ -126,8 +126,8 @@ static void test_fifo8_pop_buf_wrap(void)
     g_assert(count == 4);
     count = fifo8_pop_buf(&fifo, data_out, 4);
     g_assert(count == 4);
-    g_assert(data_out[0] == 0x1 && data_out[1] == 0x2 &&
-             data_out[2] == 0x3 && data_out[3] == 0x4);
+    g_assert(data_out[0] == 0x9 && data_out[1] == 0xa &&
+             data_out[2] == 0xb && data_out[3] == 0xc);
 
     g_assert(fifo8_num_used(&fifo) == 0);
     fifo8_destroy(&fifo);
@@ -157,7 +157,7 @@ static void test_fifo8_peek_buf_wrap(void)
 {
     Fifo8 fifo;
     uint8_t data_in1[] = { 0x1, 0x2, 0x3, 0x4 };
-    uint8_t data_in2[] = { 0x5, 0x6, 0x7, 0x8, 0x1, 0x2, 0x3, 0x4 };
+    uint8_t data_in2[] = { 0x5, 0x6, 0x7, 0x8, 0x9, 0xa, 0xb, 0xc };
     uint8_t data_out[4];
     int count;
 
-- 
2.45.2


