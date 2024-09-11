Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F65EE499D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:32:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMJn-0001Sa-1q; Wed, 11 Sep 2024 08:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMJT-0007qi-L3
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:19:19 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMJJ-0007fE-5x
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:19:04 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42cbc38a997so5321515e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726057136; x=1726661936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mgs85hYE5pQ1rTzb1gN28GODv96Cx44RxJ0nIlGBXhQ=;
 b=jRjJdcl6VQhERftUkP6oosD9246TwxMUzEm35c8kVoTpl00MtzW/7XwBb0by6OR5Z+
 rUXNl6LZRyVEA1daDwV90qk6KbYxgAZT4f2E+bGYSQub4k/XZs+olTbgiPc+aoy4iV+c
 BHPIyZs4p38iiKTLCFkV6HfLbSsNxmJCI6EcjJmq9XmK+grcvshp2XYRnhqpUrrIoZrS
 ZWK2JKlfuGGy1VkgI1OmN8xktcgFq0Vi6g5lpPPBi5/BkyHibVfbkvnp4dBzZCD/lSeO
 nZXY9+jjXAONG7O3/n+LCffIJloq7fm9ACCzXR90kK5bdaDiFRuz35+d78O/v32t2twS
 yx/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726057136; x=1726661936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mgs85hYE5pQ1rTzb1gN28GODv96Cx44RxJ0nIlGBXhQ=;
 b=xVCvAYe1zkZ0HKX4O7ms0MsZp5ywMeH4cTlBsAzQXf+H+nGu8NgGS2y+b/13VV2Gm9
 61+3I1qTGel/ZZNKaevzMZQkeDsvOfgi2uofGBR2DzD8ycfXs+fNI1/EnUJZCJxpcQ2l
 yNlF4Ff/o6R9iednRn4PuTfEOgN5F4XbNTwAHzQVGTa2DewylC2rQfpwB8vptZg1HU5G
 VImddW6p73Un/JumqFj2m7iiCLE/X2RTXCQ5RNEkLc0Qm0UiZFTM4Yp262jrPd6SRhO8
 ba6SjbyJ10jRi5Kgm6D5s7WH9bd3MAdUEb0gy1xSJtMkMdU96I/Rkihm58gIqHH7rrSS
 nm4g==
X-Gm-Message-State: AOJu0Yxm/SIhzfEk2eZUIzlQTGoLZwi0m853vQvDPTI7fPen+GIvAYFH
 +w+gN0CZZnFAiyR5rK7xGihJA2E9497hbKEmYXFGViTUJG2X/sHF4W7AH0ni6attdZzAaCMsxY5
 W
X-Google-Smtp-Source: AGHT+IG3WCIMSjyZZ86LYoYvmg2LmNwHIIz2z+kdOalmu4HlDMR4uiS7rpcVxwirX3KA+TzSEFdcxg==
X-Received: by 2002:a05:600c:45d1:b0:42c:ba81:117c with SMTP id
 5b1f17b1804b1-42cbddd6575mr39497775e9.6.1726057136030; 
 Wed, 11 Sep 2024 05:18:56 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956d372dsm11443448f8f.73.2024.09.11.05.18.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 05:18:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Octavian Purdila <tavip@google.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 38/56] fifo8: add fifo8_peek_buf() function
Date: Wed, 11 Sep 2024 14:14:03 +0200
Message-ID: <20240911121422.52585-39-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121422.52585-1-philmd@linaro.org>
References: <20240911121422.52585-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This is a wrapper function around fifo8_peekpop_buf() that allows the
caller to peek into the FIFO, including handling the case where there
is a wraparound of the internal FIFO buffer.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Octavian Purdila <tavip@google.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240828122258.928947-8-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/fifo8.h | 14 ++++++++++++++
 util/fifo8.c         |  5 +++++
 2 files changed, 19 insertions(+)

diff --git a/include/qemu/fifo8.h b/include/qemu/fifo8.h
index d1d06754d8..d09984b146 100644
--- a/include/qemu/fifo8.h
+++ b/include/qemu/fifo8.h
@@ -76,6 +76,20 @@ uint8_t fifo8_pop(Fifo8 *fifo);
  */
 uint32_t fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen);
 
+/**
+ * fifo8_peek_buf:
+ * @fifo: FIFO to read from
+ * @dest: the buffer to write the data into (can be NULL)
+ * @destlen: size of @dest and maximum number of bytes to peek
+ *
+ * Peek a number of elements from the FIFO up to a maximum of @destlen.
+ * The peeked data is copied into the @dest buffer.
+ * Care is taken when the data wraps around in the ring buffer.
+ *
+ * Returns: number of bytes peeked.
+ */
+uint32_t fifo8_peek_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen);
+
 /**
  * fifo8_pop_bufptr:
  * @fifo: FIFO to pop from
diff --git a/util/fifo8.c b/util/fifo8.c
index 1031ffbe7e..a8f5cea158 100644
--- a/util/fifo8.c
+++ b/util/fifo8.c
@@ -140,6 +140,11 @@ uint32_t fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen)
     return fifo8_peekpop_buf(fifo, dest, destlen, true);
 }
 
+uint32_t fifo8_peek_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen)
+{
+    return fifo8_peekpop_buf(fifo, dest, destlen, false);
+}
+
 void fifo8_drop(Fifo8 *fifo, uint32_t len)
 {
     len -= fifo8_pop_buf(fifo, NULL, len);
-- 
2.45.2


