Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF54BEE499D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:21:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMJl-0001Dm-SQ; Wed, 11 Sep 2024 08:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMJ6-0006Hw-9x
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:18:57 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMJ4-0007eY-Is
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:18:48 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42cba0dc922so24682345e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726057124; x=1726661924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NTCRQ2hPR5eh42ZfIm8LY44Myf8vzzYhRLsWqDIkSHk=;
 b=aOr+GR1Sy+ekLHA8ms/06moYskJzvD5hOdFTWN7GiTAy+2SJQel1Xk3hs53fZ+aBhV
 WE9Z4rOp4aLJq6p8FUowWbrPs3mKY5HKtiSS6rbnqqKFSN6YhFYD/sQX/pYPTEqAWj87
 EiO/BgU2tibf41OuTJK9jfgnUb1w98S2Eu9tfUm/eM4MI77CG0Cd8+ZCUIvzz+W5Z4gP
 aNX21LcKfy/b2mOJMlIccaX4xWw7669pyULX4Wt4N/JooImFujBDMjnSpnXwOTA8G7pF
 QjmpBZmlV0INP8O0vTqQ6yrAUsx6BbGrsKD7jJyJMnfeKQkb9GwhizR6G/qQi1m0HYCn
 frCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726057124; x=1726661924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NTCRQ2hPR5eh42ZfIm8LY44Myf8vzzYhRLsWqDIkSHk=;
 b=ZpnqmZpB3PharxALYGYLlNTuSpiTI8x7jaCslAXNmX/mGmTmXCWjNkhjrDk4497VDY
 iG0H6YgEHxtKNTOykfFPv63ZIRseo2qlZvJM8If+r/+URCdmniIfj/LjuoZvyuNJ+OcQ
 UZU8blF6hVEJgyvk5NXGwmdKdVNWtVnsIcShJftnoRvA2JosI7oyfsrZDesNmh24LET0
 R7TGVPC3yK3erN82iF4EQWprCMOL3hG7Ds0oeFzg3JfvooNvjHbAuDVwtRLVcDZ6dAZv
 MMvOYp05nkGXVODZn/5/f6/6FjWvPADuOhYjZwl1QtO81e/1d3pffTPJhcBYAK4lYUES
 qPFw==
X-Gm-Message-State: AOJu0YxTkpMwtzyxbzPt+fWpJjjfLmlPTJ1409iUXLOpoDUKcNbAILEx
 FUJfDIqkePTg3silyq8kCi6SvuX0+tA6d0RBh88/xfhZ7iiJGEZOV4vi1VTQK/4kjkGvKKsnGEu
 J
X-Google-Smtp-Source: AGHT+IGdFn1WoTY5TcquwwCqTiUikX0GKgCCvhxIJEC7O/1TooDO6GSGCxzgNgYHHwZcWUe2maAVVg==
X-Received: by 2002:adf:f489:0:b0:374:baf1:41bb with SMTP id
 ffacd0b85a97d-37892685979mr7400650f8f.3.1726057124310; 
 Wed, 11 Sep 2024 05:18:44 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeb815f4sm142568945e9.30.2024.09.11.05.18.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 05:18:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Octavian Purdila <tavip@google.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 36/56] fifo8: rename fifo8_pop_buf() to fifo8_peekpop_buf()
Date: Wed, 11 Sep 2024 14:14:01 +0200
Message-ID: <20240911121422.52585-37-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121422.52585-1-philmd@linaro.org>
References: <20240911121422.52585-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

The fifo8_pop_buf() function will soon also be used for peek
operations, so rename the function accordingly. Create a new
fifo8_pop_buf() wrapper function that can be used by existing
callers.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Octavian Purdila <tavip@google.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240828122258.928947-6-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 util/fifo8.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/util/fifo8.c b/util/fifo8.c
index efe0117b1f..5453cbc1b0 100644
--- a/util/fifo8.c
+++ b/util/fifo8.c
@@ -105,7 +105,8 @@ const uint8_t *fifo8_pop_bufptr(Fifo8 *fifo, uint32_t max, uint32_t *numptr)
     return fifo8_peekpop_bufptr(fifo, max, 0, numptr, true);
 }
 
-uint32_t fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen)
+static uint32_t fifo8_peekpop_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen,
+                                  bool do_pop)
 {
     const uint8_t *buf;
     uint32_t n1, n2 = 0;
@@ -134,6 +135,11 @@ uint32_t fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen)
     return n1 + n2;
 }
 
+uint32_t fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen)
+{
+    return fifo8_peekpop_buf(fifo, dest, destlen, true);
+}
+
 void fifo8_drop(Fifo8 *fifo, uint32_t len)
 {
     len -= fifo8_pop_buf(fifo, NULL, len);
-- 
2.45.2


