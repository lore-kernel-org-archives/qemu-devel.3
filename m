Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D99EE49A0
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:32:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMJr-00026P-Ir; Wed, 11 Sep 2024 08:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMJc-0008Sp-Pv
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:19:22 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMJN-0007fP-E2
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:19:12 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42cc43454d5so14071795e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726057142; x=1726661942; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rvh1RZxcP1nInMdaaa2bCvNT6U7BxgYnTGGeSM1aBGg=;
 b=WNPodAmIQ5yvfz/ps6N0wgaBW7mCRlsrHsZZCrFqVjSZYmBr3W1KHA6/BUSvSrpWkV
 d2n5lq1i/ReqRiTrUUNiVotW1jdPoU7NrNacslX+wTWLaEoUuHPKzBPqFvEVZiNQRYuY
 R05Z1M4c2roiHgwxnc64dlrrP9gxfcIuN+jPIyok5ezoibWX8fZMAv39llIkskDWH+WD
 QKL19pT3/X/kIUuo2tv9f0StxnbCMyIH5ezg/f5+VGgV7NXJ+deacO6qpjXaXAq/VgKR
 bPEAxb+UqImrgQdfTL6YLzXEMlf4heiU2Ii+R8Us9HJPFUAi2K74j8SwGin9fmjlE2lO
 SkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726057142; x=1726661942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rvh1RZxcP1nInMdaaa2bCvNT6U7BxgYnTGGeSM1aBGg=;
 b=Nnaczw8r1/IF0eXVuXgA4ypQmqbbrQsAHZe2mxK6bTnccjBCk0GDov+JVzTtd5s4uC
 gOGD4I/gO5ateAskEAGoFnWCrNwaoypTncxj533ZI6sIdU0XZqsjGAATfFP3DzpRjvrn
 JxfDOAGOJOIMbSLXa5zSFTFDr4bQBJoaQ89zhe1mmPXeIHkyGvQfdaOk/B8XGvYPC5EY
 Pazz++w64SyQwCrZ9WB8ZPlqX3urGNfvJ1SeRYV/tDkzuaBA2GAVPZs7VT09WBYEpZ3z
 OKO6sgf5wL2T62PvEwZYxnkPR9mqvqz30idomjzalEijOTmMMjj6TlzjNg69UGrYRct2
 RFUg==
X-Gm-Message-State: AOJu0YzFjvc+W5DUNN21R1BIURs893hLhu2pvmAJfUP74m+fEtzKn1EZ
 NibpioUjf7qLy9KOFTnkKrzZcbdk7vLyNjJzRvN3ohLvJUFlr703tBQUhH6MPLTzoeNChu4cORF
 H
X-Google-Smtp-Source: AGHT+IEEqh1WoVk+XR1EWp/krOnJXA+st6hlev26WURvT5HVRX8LnBjlxLc1ymQ1BEh+0469mIsnvw==
X-Received: by 2002:a7b:c4d6:0:b0:42c:ad30:678 with SMTP id
 5b1f17b1804b1-42cae76d028mr98544355e9.28.1726057141747; 
 Wed, 11 Sep 2024 05:19:01 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeb45c81sm142098365e9.28.2024.09.11.05.19.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 05:19:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <alistair.francis@wdc.com>,
 Octavian Purdila <tavip@google.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 39/56] fifo8: introduce fifo8_peek() function
Date: Wed, 11 Sep 2024 14:14:04 +0200
Message-ID: <20240911121422.52585-40-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121422.52585-1-philmd@linaro.org>
References: <20240911121422.52585-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

This allows uses to peek the byte at the current head of the FIFO.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Octavian Purdila <tavip@google.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240828122258.928947-9-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/fifo8.h | 11 +++++++++++
 util/fifo8.c         |  6 ++++++
 2 files changed, 17 insertions(+)

diff --git a/include/qemu/fifo8.h b/include/qemu/fifo8.h
index d09984b146..4f768d4ee3 100644
--- a/include/qemu/fifo8.h
+++ b/include/qemu/fifo8.h
@@ -62,6 +62,17 @@ void fifo8_push_all(Fifo8 *fifo, const uint8_t *data, uint32_t num);
  */
 uint8_t fifo8_pop(Fifo8 *fifo);
 
+/**
+ * fifo8_peek:
+ * @fifo: fifo to peek from
+ *
+ * Peek the data byte at the current head of the FIFO. Clients are responsible
+ * for checking for emptyness using fifo8_is_empty().
+ *
+ * Returns: The peeked data byte.
+ */
+uint8_t fifo8_peek(Fifo8 *fifo);
+
 /**
  * fifo8_pop_buf:
  * @fifo: FIFO to pop from
diff --git a/util/fifo8.c b/util/fifo8.c
index a8f5cea158..a26da66ad2 100644
--- a/util/fifo8.c
+++ b/util/fifo8.c
@@ -71,6 +71,12 @@ uint8_t fifo8_pop(Fifo8 *fifo)
     return ret;
 }
 
+uint8_t fifo8_peek(Fifo8 *fifo)
+{
+    assert(fifo->num > 0);
+    return fifo->data[fifo->head];
+}
+
 static const uint8_t *fifo8_peekpop_bufptr(Fifo8 *fifo, uint32_t max,
                                            uint32_t skip, uint32_t *numptr,
                                            bool do_pop)
-- 
2.45.2


