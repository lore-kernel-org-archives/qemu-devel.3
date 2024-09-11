Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5D7EE499D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:24:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMJp-0001h3-29; Wed, 11 Sep 2024 08:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMJf-0000Dq-Oy
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:19:24 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMJd-0007gE-8Q
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:19:23 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42ca6ba750eso5394305e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726057159; x=1726661959; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YsoQJoP7HmKgt2M2ZTQxKON+GExTKhnzENy6HfM9+7k=;
 b=a85EKDBioGpY7s9xLH7UMgmpPZVweXLkJzv8kH8pS1kMKKxYTfen2QC96SsQ4hjTku
 m+lkZNF7xrbfr42bgfNtPYw/c8BFOQ8yb/4ujjNPjf30h4FT1Nufysqey4zvqDXUAL3Y
 y2sZyw3MeIqExaVl/Tl9jGgT7rECgEDztdRzL0N1ZkicwqtM6XVjKJmKkMoa93RRlwhe
 W4eGUtzGVTzhUoW1aZFti7jN5dlUL7loszeNsn+FyGQMTfj3ZH6gTWYhWT09ofJ5bxnZ
 BYASugFPmuCZyIISqJ3L5suazx8VEyWyPdjIptKpboo3EAnLx8g/jWxigH0cCf9bgnC3
 Ofqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726057159; x=1726661959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YsoQJoP7HmKgt2M2ZTQxKON+GExTKhnzENy6HfM9+7k=;
 b=EnTj+S/gelCML0C1iPjiBkYkbYZ5TNzzLS5Jj8VMi/wH8+R6wNgdUBMhbOZSMpKGcS
 IPn2jbUtVUPCOCnr9yu+Aeb9f2DNRhU8uq39ORueW+vBCoy1zc7LDkT5/O7urif95evr
 RFE1lh0WjTT+5VprFkRjg+0Z7wMkO1dwj0iE9umWAZUUJOoWzxXFiV2QGlOdXQqBX8bE
 vRpEGzpvGOUkmhpYVxRRY4gNPdwb1OtiZafgAI3OxxMRljoygU5SEEd5+mr7gxfjic2r
 MNilIgVbeG1q6/GDWZnPA1nhsRdzK6NHG2XiS9iO34ddD19TDbbceskCjmUfnFt3tdMP
 ZM9Q==
X-Gm-Message-State: AOJu0YzRdkCNYIrNAnVn+xCJecLVSaXmnbn5UMSlz+ul2N2lw7T3uYZJ
 29UcjXnk5EX4tGf/0ciOQoPboOEgwpXon3hz7ThZOUJAA+t3O800rUOeMxmlGhbQYsr56PTcLaw
 9
X-Google-Smtp-Source: AGHT+IG8Ik8ibMQUJkM08XLOwWzlvOCh+m4azWKnGNf4b0csUy3Y4lqbwwDNtNUbajHvYtgUDqbDvw==
X-Received: by 2002:a05:600c:1ca7:b0:42c:baf1:4c7 with SMTP id
 5b1f17b1804b1-42cbddb8169mr38288905e9.4.1726057158817; 
 Wed, 11 Sep 2024 05:19:18 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956d3765sm11464692f8f.74.2024.09.11.05.19.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 05:19:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 42/56] tests/unit: Expand test_fifo8_peek_buf_wrap() coverage
Date: Wed, 11 Sep 2024 14:14:07 +0200
Message-ID: <20240911121422.52585-43-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121422.52585-1-philmd@linaro.org>
References: <20240911121422.52585-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Test fifo8_peek_buf() can fill a buffer with wrapped data.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20240906132909.78886-3-philmd@linaro.org>
---
 tests/unit/test-fifo.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tests/unit/test-fifo.c b/tests/unit/test-fifo.c
index 9b3a4940d0..fada526b6c 100644
--- a/tests/unit/test-fifo.c
+++ b/tests/unit/test-fifo.c
@@ -158,7 +158,7 @@ static void test_fifo8_peek_buf_wrap(void)
     Fifo8 fifo;
     uint8_t data_in1[] = { 0x1, 0x2, 0x3, 0x4 };
     uint8_t data_in2[] = { 0x5, 0x6, 0x7, 0x8, 0x9, 0xa, 0xb, 0xc };
-    uint8_t data_out[4];
+    uint8_t data_out[8];
     int count;
 
     fifo8_create(&fifo, 8);
@@ -174,6 +174,13 @@ static void test_fifo8_peek_buf_wrap(void)
     g_assert(data_out[0] == 0x5 && data_out[1] == 0x6 &&
              data_out[2] == 0x7 && data_out[3] == 0x8);
 
+    count = fifo8_peek_buf(&fifo, data_out, 8);
+    g_assert(count == 8);
+    g_assert(data_out[0] == 0x5 && data_out[1] == 0x6 &&
+             data_out[2] == 0x7 && data_out[3] == 0x8);
+    g_assert(data_out[4] == 0x9 && data_out[5] == 0xa &&
+             data_out[6] == 0xb && data_out[7] == 0xc);
+
     g_assert(fifo8_num_used(&fifo) == 8);
     fifo8_destroy(&fifo);
 }
-- 
2.45.2


