Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5841C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:33:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzm62-00064K-Sa; Wed, 24 Apr 2024 19:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5q-000615-Ub
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:32:03 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5p-0003xi-FO
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:32:02 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-60275a82611so328453a12.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714001520; x=1714606320; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QiNkoAsgvTetR5YHMAeB2w6OV5e9o48b6mfaDP+sgJw=;
 b=bUhXJ64ZORNYSgy8nLI3d6GS4kQtYURrUr4zCkJuZSf61KwtlP3aLISQJBi8nuC9UG
 MfkapkNlCAsDBJ8lY2ivQiEURbE6Qqbzj2cJHwSma4k1VbkZ5wPxQxI7P6WJ/jdYJGnf
 vkLqyXVohk7y4H9XE5G61R07V37/+YKL33BaOCgQqaa2g08X+Q0cZZUA2N5o0dvDPIui
 IgQT+/H0GwnRE/eMzRT1DmvqYruAQtvOd6YEPC1tzH9qzh8K5D5pPjY9k41lrX9dPJLy
 5KYl0I7OTytHirTi3IE9gEPEJRHD27x95DwK0elwQ7gG5/jWNeibuUZ8F2XAXjY6dc5g
 ASww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714001520; x=1714606320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QiNkoAsgvTetR5YHMAeB2w6OV5e9o48b6mfaDP+sgJw=;
 b=eXFq+G6kWwOrWKL60IdfPXocEFS+nEXD1/iIhYIi0iSuI2UtEeIDfcG2sDdJAXnku4
 YisdTGAcQlrHj75Krei/YDv9nj3hIa1eFJILm97AgllDl1vmh2izUasEG+aM87A/QjxK
 0Q/LmpNq9d8laXPYQOdwyNGx/8kojB/EsuLqZDjRMjavyCvdemM2GfDDI3K8nh6eIDKR
 jzVrdar5D7RwR7n+IGQ6UxeB6kFf1k2hOAM9Uh8Ds+WM0tVoUsjyCRrpGA1h/4C86LDX
 QLkbRZSyd8v1IrTVAz4EW7N05pF6wkL2F/KinEe7aOXNQ25ukBZ5HdfP6/daN+x6RIxP
 3T5Q==
X-Gm-Message-State: AOJu0YwaZnjIlTi8NvYa3/0fxvpMwKO9yusOSPg74C2gSlvQ72OgC4r5
 TZR1hMnjNWhjg7JVAVxSZTEhfdHyiRTXZgJDs5uRUtSxktl5KkiaNS0GwyZe41q/Eeq12rdX0bG
 p
X-Google-Smtp-Source: AGHT+IGpDEjKDlvix6YNwXW6IeySsv5QpeLKNyofqowY47aP9qzQC5L5Aq/Ce0WFCATOnsI+OmRorQ==
X-Received: by 2002:a17:90a:7347:b0:2a2:4192:dfc1 with SMTP id
 j7-20020a17090a734700b002a24192dfc1mr3697782pjs.14.1714001520213; 
 Wed, 24 Apr 2024 16:32:00 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 z24-20020a17090abd9800b002a56b3931dfsm11737859pjr.49.2024.04.24.16.31.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:31:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 31/33] target/xtensa: Use translator_ldub in xtensa_insn_len
Date: Wed, 24 Apr 2024 16:31:29 -0700
Message-Id: <20240424233131.988727-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424233131.988727-1-richard.henderson@linaro.org>
References: <20240424233131.988727-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/xtensa/translate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 42109d33ad..75b7bfda4c 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -35,7 +35,6 @@
 #include "tcg/tcg-op.h"
 #include "qemu/log.h"
 #include "qemu/qemu-print.h"
-#include "exec/cpu_ldst.h"
 #include "semihosting/semihost.h"
 #include "exec/translator.h"
 
@@ -1118,7 +1117,7 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
 
 static inline unsigned xtensa_insn_len(CPUXtensaState *env, DisasContext *dc)
 {
-    uint8_t b0 = cpu_ldub_code(env, dc->pc);
+    uint8_t b0 = translator_ldub(env, &dc->base, dc->pc);
     return xtensa_op0_insn_len(dc, b0);
 }
 
-- 
2.34.1


