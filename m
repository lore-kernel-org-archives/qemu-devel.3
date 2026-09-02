Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA586C624DB
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 17:01:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1oK5-0004Qj-56; Wed, 02 Sep 2026 13:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x1oJx-0004Px-LX
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 13:00:21 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x1oJt-0004N4-Mo
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 13:00:21 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-498028b3d5eso13487965e9.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 10:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788368415; x=1788973215; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VxjCDADMFtbU025cbNtGeiXEjtB4LHc2bYXLYp0e3hw=;
 b=Z8lFUfD4Pvuzn/qTxaZ0dmmw9qsxBphuL8UQgQ2S7eN6ymVxV/oWRqdZNKwPr9FsaL
 EpeXU8cb6GVbKQnWKa4CpmMFYZEmP9nk7/I2e9GlACcdh4bKiX+z+7LHcbbhEG3WGYpE
 nKdBAaDEyJgN2lW7sE/TI7l6lofiwG4NuUosfcM7BGNe1gA2sLaO0d4xfrd2XZ4OjvFt
 LZoF6plY9rBmKhfM6ykCMkloggk2Cm/EpSZkdkv/uK0MZ+420Oa82SOyeP2+ubsAP1zc
 gEwVyrPZVapomnxMZoppsoDDrDD3CVYP9iZZkw/634K4k6UifV8vK+bvMre3j/KtKqaQ
 Fdrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788368415; x=1788973215;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VxjCDADMFtbU025cbNtGeiXEjtB4LHc2bYXLYp0e3hw=;
 b=cFMfCN5nASj0tbCqmuY3JobceQ4UnIF9Tv/LCpap7pvJ8W3RsvfAQfCoxr1Hx1FXLx
 wSOaRGTFQ2xF0pagdzhHS1tKbTVsx1aIqKP6TN7V22x2boYwKFo7g4mEPPXuSTz8btUc
 te8IzqM2TwwLqZ72dASClXadl0QAvb8MTfP1ZLyfLbwENU4WA5EI1k0Jy+my7HfM0Hn8
 R9TQWl8nvFe/o/W7/r47aB3LVGIRROIzZKnOxSXOS5cnXlJQXlsgk3ZbBdhhur8ZS9np
 4fVkX1OjiPZpbuFmovlmegKrT8v4zSxgSQ5myc+7kElLdjVZYUXGDVcPu5pnF+zhrKp4
 SCIg==
X-Gm-Message-State: AFuF++mIB9T+tHK/Or0Kwa1SPFzBACqHa0AdSyntn6TWSCJcSueuk6Iz
 zvgxpe0U72JzHo8PXz4mfjMmWBjlO7phfBQF76IRM7ZSg9oRJZTxDR/QDZnjQConQfM=
X-Gm-Gg: AR+sD139qOBfubdEmFMsvwgeKNfnM1nHFp9eXNY5iykOyUT84rlguPedgChES882qVo
 0vzfYoGZnX7C8PmnroS2KOhgSWi6WWYVs86oc0foIJKGlZXVaRuRYMPaPXkk2W6+LJaY6FzyCT1
 T518isj7wuG7rNSVzQwbRxNJCfKC5UEME8d9800fGuVMA0tcaxgIUNLVKJHL07QR6fdr5UkK6tR
 59++MNPbOB+2GmsHkAK+hOtktU1vd/jG22vrwJzU1Qfz3XdpYmSxKGrtBBJNeD9s7ZMbVmOUiOr
 7eIUW3o+eDs2nP1yofUFYPqksB5a3l5pH2ufgIDeYDNxHGK/oQOtpPNRn1QLfHm1k96po6bcivw
 Q3yB2JwPLhfkrT2jwSEtVtnHncdikECOYS92Fa5L1+CBWWDs17sGjIwAnLUE81A8kosmmx1za0a
 dkhIF3/64xkCZTcYVsXSgDNRpxWJA4wyMcp5SPNbf0Oif1UTvGxG4zsEheO3YX
X-Received: by 2002:a05:600c:1da1:b0:499:9eb8:a1d7 with SMTP id
 5b1f17b1804b1-49ce5842935mr139277165e9.9.1788368415039; 
 Wed, 02 Sep 2026 10:00:15 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce55259ecsm47071755e9.2.2026.09.02.10.00.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 10:00:13 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4BCCD5F85F;
 Wed, 02 Sep 2026 18:00:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Samuel Tardieu <sam@rfc1149.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org (open list:STM32L4x5 SoC Family)
Subject: [PATCH] hw/char/stm32l4x5_usart: Accept character input upon RDR read
Date: Wed,  2 Sep 2026 17:59:55 +0100
Message-ID: <20260902165956.582901-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Looking through existing serial devices this seems to be a common
pattern so it makes sense to me this is the right fix and matches the
API description.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4389
Reported-by: Jan Brittenson (@bson)
Suggested-by: Jan Brittenson (@bson)
AI-used-for: fetch issue, apply proposed patch, verify build and qtests
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
NOTE
  - testing with the AGENTS.md patches - I asked the agent to:
  "grab the details for 4389 and apply the fix to the local tree"
  which it did. However it did remind me at the end:

  *(Reminder per QEMU policy: this is a draft for you to review, adjust, and commit. Remember to check whether `Resolves:` and `Reported-by:` headers match your preferred attribution.)*

  ```text
  hw/char/stm32l4x5_usart: Accept character input upon RDR read

  When the guest reads from the USART Receive Data Register (RDR), the
  RXNE flag is cleared to allow receiving subsequent characters. However,
  without notifying the chardev backend via qemu_chr_fe_accept_input(),
  backends such as socket-based chardevs in polling mode may stall and
  only deliver characters once per second upon poll timeouts.

  Call qemu_chr_fe_accept_input() after clearing RXNE in
  stm32l4x5_usart_base_read().

  Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4389
  Reported-by: bson
  Suggested-by: bson
  AI-used-for: fetch issue, apply proposed patch, verify build and qtests
  Signed-off-by: Your Name <your.email@domain.com>
  ```
---
 hw/char/stm32l4x5_usart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/char/stm32l4x5_usart.c b/hw/char/stm32l4x5_usart.c
index dd1b0991956..0b02dde1f8c 100644
--- a/hw/char/stm32l4x5_usart.c
+++ b/hw/char/stm32l4x5_usart.c
@@ -441,6 +441,7 @@ static uint64_t stm32l4x5_usart_base_read(void *opaque, hwaddr addr,
         /* Reset RXNE flag */
         s->isr &= ~R_ISR_RXNE_MASK;
         stm32l4x5_update_irq(s);
+        qemu_chr_fe_accept_input(&s->chr);
         break;
     case A_TDR:
         retvalue = FIELD_EX32(s->tdr, TDR, TDR);
-- 
2.47.3


