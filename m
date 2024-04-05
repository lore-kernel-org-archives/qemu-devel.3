Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD983C67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 10:27:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsgl1-0005xA-KP; Fri, 05 Apr 2024 06:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsgkz-0005wS-Rs
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:13 -0400
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsgku-0004VM-M3
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:13 -0400
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-369eafe262fso10131785ab.1
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 03:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712312704; x=1712917504; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NdQqZjJgz9uVc1nB4iFIKIUfcykhgew+A5q2j0I98dY=;
 b=bAoeXL4g6rWRI5sEnmBfmxYg2XalXWL6KxA3ZpCkvatuNKJy4xZZsQ6aDD+AWdd8QB
 EuF9BYMeTi7TJgRINvX73PyXmfIx8yjsjL0527ZHCqyHigsBd4F1I5yzBjmkNXFChBNe
 IUkZQude4BsUZ/DN8tFBtTHbXFFXNXrrC/onWecrReee+g3uCgUd7kAf7qiDp4iEZvVY
 uvaSCUITXGWPvDrQkZ0nc/DD+dF0IVesKACMlmrGRStUvXDf8N2r7VmqN09nPiLKFKyF
 q7XgBKOoNJNuqFQAw1K/9/FI//nlWYwx9p/yYOTR3Vj4JfJsfr26Rj5Fj5jZP8dt4a0E
 BfCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712312704; x=1712917504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NdQqZjJgz9uVc1nB4iFIKIUfcykhgew+A5q2j0I98dY=;
 b=Y53FaqYwdABmAKVnabssI5PEADs71KrTHDy4IEuhby9PLH+Q1bIgXFTYT5dtexd/L5
 04OPr2uvFoz1DFwkzXSXCnVRu1rbV8B6tUAN5KRdvgAuieB6sWSQ9+cwQ1tHdVrtSGY/
 akyeaz2FvQAGGYFa6IKlGEs4PMWl9jP07n/zvgA6/RSXEApUCGY8Bqx3Sd2RXLJ8NsjU
 2r6B/wWfBULyXHTP4Bi3vw8zvNneO86CujPACS4KjJRK9a7eCcaWUWVznQQNLVplHoax
 DJaOZg2PZFuMEbCXuHBG2M2iHozaUm1HSKRHUse9yPj234BF4UoQd52S0PT63KZsgYjo
 AJJw==
X-Gm-Message-State: AOJu0Yz9t/NZZCwDVKLrWcMPGyKYms0FSauZ00COV7ATGuZcQus9ryGJ
 9BuCYRdze1r3nqAGw3YYSFGWp5R+ntlzQorohLJAtqAIxbrfx5q2bjlBRMbsCYxS65RxptPwmNa
 S
X-Google-Smtp-Source: AGHT+IHLvIprauC7x8CXV8h6TTZ8QMosq34+7Y1AlaS9iuwF7to4GcaVpxGSJg26zHIORpDwyA4/kw==
X-Received: by 2002:a05:6e02:1a66:b0:366:9674:7084 with SMTP id
 w6-20020a056e021a6600b0036696747084mr1053057ilv.12.1712312704361; 
 Fri, 05 Apr 2024 03:25:04 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a63f90a000000b005e438fe702dsm1104304pgi.65.2024.04.05.03.25.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 03:25:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/32] accel/tcg: Hide in_same_page outside of a
 target-specific context
Date: Fri,  5 Apr 2024 00:24:29 -1000
Message-Id: <20240405102459.462551-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405102459.462551-1-richard.henderson@linaro.org>
References: <20240405102459.462551-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::135;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x135.google.com
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

While there are other methods that could be used to replace
TARGET_PAGE_MASK, the function is not really required outside
the context of target-specific translation.

This makes the header usable by target independent code.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/translator.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index 29804de92e..185ab5c374 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -230,6 +230,7 @@ translator_ldq_swap(CPUArchState *env, DisasContextBase *db,
  */
 void translator_fake_ldb(uint8_t insn8, vaddr pc);
 
+#ifdef NEED_CPU_H
 /*
  * Return whether addr is on the same page as where disassembly started.
  * Translators can use this to enforce the rule that only single-insn
@@ -239,5 +240,6 @@ static inline bool is_same_page(const DisasContextBase *db, vaddr addr)
 {
     return ((addr ^ db->pc_first) & TARGET_PAGE_MASK) == 0;
 }
+#endif
 
 #endif /* EXEC__TRANSLATOR_H */
-- 
2.34.1


