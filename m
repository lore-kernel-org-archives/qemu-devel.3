Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A218ECD1296
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 10:30:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsgm7-0006tH-OI; Fri, 05 Apr 2024 06:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsglU-0006Bo-ME
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:45 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsglT-0004q7-3R
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:44 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6e69a9c0eaeso1286098a34.3
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 03:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712312742; x=1712917542; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1wv+sXT5wyXDzAXP3RgOrCGl/NGDrvrLpRUdogc33UA=;
 b=QoEr5cvPn/Rv+E5ZkdOC3Picqa65m1pHXtO7gNgYFZWwJ41WMo2KlUksRHCCW9OfHP
 IxvwvdxbSDoESA0wQbF6iysGQXNu6r34vUq8NpciYt/88DewyzcY+Zp6GE1KrC2iTt+v
 MF2bQlsSDDTUgzBIlYgOecXaNv1LRKH24av/+NveyoFBZDCmexEMMgr710Blo5FYASuR
 wzGh/dewGcInA2OJPvMupGT9uEOPf/49EAD3/BUTuthC4RurlGaGo/ZmRQichyRnF7av
 EBmFajuMPOQXgmY3C93ABdM2aEBjUCAEh1wEhyiv49eD4YX6+fxb4m6wz3OocCVTYu9n
 9xyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712312742; x=1712917542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1wv+sXT5wyXDzAXP3RgOrCGl/NGDrvrLpRUdogc33UA=;
 b=aopizQrZT9O7RcFQXjKFuTxZ3Z4nqwkKJwN1q41U7qh9qZFKu3p0jmkUcki0tNbme9
 gsedfhO0AFHlhOy3AgZovTaSdhT2qUKBp5SgTmpEalK+/Iu+YMVxl7oHDE7ff7E8x8YN
 4J710S3Odu42pU84QFmKav11dE0cO6mDf+7/2dTQ0os24qBCJxDNB6/u/fgLSTj/U7DW
 4oCQJfzyxISU/2k8qHHZcHwTQ6sLCdV73l2lKvVcmXleJZYG0bFr8k1l/pvP5Ijgpv5L
 XmlExERKz8TACc+6DR0kkBaIsPW6tXYvKDBSrf5ISnO1JcaiqHaH3hbHnguJ9dH9ALko
 LYEg==
X-Gm-Message-State: AOJu0Yw1yFsC5gFa9yYLcjAmloI7lI0pOTKOrcG2P4kan+AE27yKRjeV
 MycrwPmpAFXgeMT+bXebjVs49ooLT5nB8auOG7CcJTVZM5R0Unc1EzG09867HxtID5VVrFsjfTh
 C
X-Google-Smtp-Source: AGHT+IEySmfZUDwVmpT8fRBVA/xfVosAEI4PiTQsbijH15+McVS/mHuO3ULFyiEm+ullsrb6BRNR4w==
X-Received: by 2002:a05:6359:100c:b0:17b:5fda:a544 with SMTP id
 ib12-20020a056359100c00b0017b5fdaa544mr1290157rwb.24.1712312741962; 
 Fri, 05 Apr 2024 03:25:41 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a63f90a000000b005e438fe702dsm1104304pgi.65.2024.04.05.03.25.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 03:25:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 31/32] target/xtensa: Use translator_ldub in xtensa_insn_len
Date: Fri,  5 Apr 2024 00:24:58 -1000
Message-Id: <20240405102459.462551-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405102459.462551-1-richard.henderson@linaro.org>
References: <20240405102459.462551-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
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

Cc: Max Filippov <jcmvbkbc@gmail.com>
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


