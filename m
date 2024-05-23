Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A13C25B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 15:35:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAATY-0007sk-7G; Thu, 23 May 2024 11:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sAATJ-0007kH-N7
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:35:13 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sAATH-0002SP-9S
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:35:13 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3550224b745so337556f8f.0
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 08:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716478510; x=1717083310; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Z8e50owdFjq3l9wuKAY7n7wmjEPbhSYGUt29AzUeGso=;
 b=Svay61wSPrUbZWIn6Rw4VmIFkKqY70WZCm+9eMhb/2NYdSGMwC071Cu9cyA31t+zHn
 mmATxrGCZqGFkZj03xfqu1d1TGaPWuU50hcIy6HkeU0eFxiMpJSmwC+52gN0IDpNGbAL
 X4JX/eE+6jg0lc2Q72WgetlimMkhVJX7KR0MuvfSqrE5bl8d0snSrFb20lxdBnb/KDEb
 d50T6ixtZYBCf9OPuDtfMzbkj2YL6zu4eKEIuT0OXMQr3Vvvtsou8mOQQPuWhlYmJEgZ
 y3uJ1U24aEJZL1TLRI3G68NjnhTcilr6B1jx8AH6D3L7mzGB8WCb6lPN6I8DnYLCvQ2s
 rWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716478510; x=1717083310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z8e50owdFjq3l9wuKAY7n7wmjEPbhSYGUt29AzUeGso=;
 b=ti7Bd0EK/9xxHmrdjp2X/JpMWHhXBvq3Azg98dm5tgoQtQVZNCiDTH+uiZPzXDqqJZ
 KJ//Gifnq1Gr93/SqOI6fzTzA786qYdke62RUktL7tAKzl/7JM3KOI95I/MxD/qgHzK3
 9InEwXXwoZ9A5bdfGZcohU+CAj/VD3+sNVNjIecLMHpLfLbhxeJGQguD69i2w3SrW3cQ
 Hr1UBGOsAHyjshtfUFYQ9iTBHI2DTNMf31xBTNlApeAulM+Nkaq0+qrwPqf92AVyhEWZ
 a/U5PG6tcum/40J2Y2xVRoMpkrooYwdmbfHccmZRA9lQAZF3isCQJGy1EmZjIKGHsw9r
 fPzA==
X-Gm-Message-State: AOJu0Yz9+GS0vHfDdjGDOZRxK4F+dicAwsxraBzgham2+0j6yh4EqMce
 4sO2aGUL4n4hkg1LEEBwQjFo94mLiqDogA/RSO3/TCi7GlUz7B0ggevHmFtt8Sw1qD/46RqNP0o
 K
X-Google-Smtp-Source: AGHT+IH0/k2x0XkotIVj7JNQ6rlNdE3QiroYmLeTwnU0GdUJ2CltelA7zIXU8BQ4SIaVbQfLEZXjRg==
X-Received: by 2002:adf:f38f:0:b0:354:f4f1:a7f2 with SMTP id
 ffacd0b85a97d-354f4f1a95dmr2574634f8f.67.1716478509891; 
 Thu, 23 May 2024 08:35:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-354df9b51f7sm3888255f8f.59.2024.05.23.08.35.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:35:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/37] hw/input/tsc2005: Fix -Wchar-subscripts warning in
 tsc2005_txrx()
Date: Thu, 23 May 2024 16:34:34 +0100
Message-Id: <20240523153505.2900433-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523153505.2900433-1-peter.maydell@linaro.org>
References: <20240523153505.2900433-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Check the function index is in range and use an unsigned
variable to avoid the following warning with GCC 13.2.0:

  [666/5358] Compiling C object libcommon.fa.p/hw_input_tsc2005.c.o
  hw/input/tsc2005.c: In function 'tsc2005_timer_tick':
  hw/input/tsc2005.c:416:26: warning: array subscript has type 'char' [-Wchar-subscripts]
    416 |     s->dav |= mode_regs[s->function];
        |                         ~^~~~~~~~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240508143513.44996-1-philmd@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: fixed missing ')']
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/input/tsc2005.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/input/tsc2005.c b/hw/input/tsc2005.c
index 941f163d364..ac7f54eeafb 100644
--- a/hw/input/tsc2005.c
+++ b/hw/input/tsc2005.c
@@ -406,6 +406,9 @@ uint32_t tsc2005_txrx(void *opaque, uint32_t value, int len)
 static void tsc2005_timer_tick(void *opaque)
 {
     TSC2005State *s = opaque;
+    unsigned int function = s->function;
+
+    assert(function < ARRAY_SIZE(mode_regs));
 
     /* Timer ticked -- a set of conversions has been finished.  */
 
@@ -413,7 +416,7 @@ static void tsc2005_timer_tick(void *opaque)
         return;
 
     s->busy = false;
-    s->dav |= mode_regs[s->function];
+    s->dav |= mode_regs[function];
     s->function = -1;
     tsc2005_pin_update(s);
 }
-- 
2.34.1


