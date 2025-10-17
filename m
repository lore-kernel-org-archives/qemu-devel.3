Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27247CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 08:54:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9gDw-00033P-C0; Fri, 17 Oct 2025 04:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9gDu-00033H-9k
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 04:54:06 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9gDk-0006OG-63
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 04:53:59 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4711f156326so2908375e9.1
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 01:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760691232; x=1761296032; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DPkVBlxqn36yOIrDXASSScNzO+E5lUwIyiL/iFj4KKU=;
 b=j3d3VKS/XjQKAXEkMLLrWoMVk3VH2ASNHtZzYha4snS0BNQRhQKa0Cst8+0s3RVgTR
 XnAS8JZgLlw42Fj8QTUbGTUugAbZ8k2Rf+78uASrfDuvGaHT1Zq2zRTMw8DxDZjFV03s
 5ps5zU7ve2sU320+IOVZzzh1scuy8N8qTIf7i0FyvJ56UCpqU6Q+ZiZpNqkq/r3dQ6nD
 m+Ol/+xqkYbWafHhZlZG3X+dVCZbExn/0iAeHLNzLF653dCZ+nY/evIe94MbpTOo2qTJ
 BfHTWx9CFDEuSpbjQN4lISxE/VdliP0YgvsTtQZfmftn2qrsSBxFCF+zk/dYVQAk9sxb
 Cibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760691232; x=1761296032;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DPkVBlxqn36yOIrDXASSScNzO+E5lUwIyiL/iFj4KKU=;
 b=msuUWhPNX7iC8v0sxu7r/JGplUAx4mDukvWOjW6F33hG4Aw44vzgsUpRxBZ5//LiWc
 rZT7xHM63hPDj/aN0I9lwa/l6KczI7lkXEiMkqLiYV1bk/tUjh89vBTFGZmNiVdOjDHg
 f1Yyn1KmTVtWyWTKl57ZtvKDBhRWcwU4iSOicn3gC8A355nLXQ/69I7KC4t2AukBQjSs
 gKkWPqyxYNM3EhZvFtAaiA/7Oq6lsgi4GZtXJmyYhAefBlSJvc0yJ8OXDPE1g7hj143v
 Gtx+Ew2DhOC8jFEXpmrUtXBAswkukpKfYFU4botGf81pmr40Ea3IBMNZt3tLxxTX18Nl
 VuzA==
X-Gm-Message-State: AOJu0YyUCHVxUHUpiBusElX2hklCZiB1g6nZIME6v0wIXDALR3XHf/ct
 Zl7rTCqUjudko5RiG1tuNnBwiQmQiTuEYOnSyzbRp+/ajD5ZZupXoF57kcrdeWw3YsLBKwJytgI
 AXimy
X-Gm-Gg: ASbGncvdIuAzo9yHJL9+6R8KbGf/TFAfe5Q7CovKMrZKa0KdmFD9fEaxWZErRFbVoea
 +1165L3ICCBL79Jkslt7b9TvrJlL5Z4RigKEepyzryMY1b0QIE9aj2bCgkQzfaa19IvvUMTeSDq
 CRqglJOVojowwDOA9ySIl6lxA55Key90Y9jX77T+ShkSIVpW7SL1WPQShXALpx26et7ziAYeNh4
 x9PQzuRvf6pbqRL2F0LY71zQJkckXnnWV0L8Y6u8xov21DkmeUeoJqu1iK/Z0FHHYceTh1ZZ+x+
 aXg7aNxO6Eh9N9mrqrUuusZzMXSuGWEt6jWyd6S/pXYEwn1S3m1NLl0lBzppZiQ4+NrlplCDEAp
 Su8B1zRowhqHMOUP9CenR1n0WskDVxELTIv7H2nsmsV3d0U/IiCuE6BF/Qb0pSaeYwZ5zpgwaa1
 W50HERTgys7UFtUsyz
X-Google-Smtp-Source: AGHT+IFb8vlzXIgQkwYeFlqP03B8SrtcUEWsou+wpDaJCRZR4BbsrZCzlY9tyEPpMPYY/zehZEzWlw==
X-Received: by 2002:a05:600c:6290:b0:46e:2cfe:971c with SMTP id
 5b1f17b1804b1-471177c0f91mr21285545e9.0.1760691232337; 
 Fri, 17 Oct 2025 01:53:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce57cd11sm39929648f8f.5.2025.10.17.01.53.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 01:53:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH] target/hppa: Set FPCR exception flag bits for non-trapped
 exceptions
Date: Fri, 17 Oct 2025 09:53:50 +0100
Message-ID: <20251017085350.895681-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

In commit ebd394948de4e8 ("target/hppa: Fix FPE exceptions") when
we added the code for setting up the registers correctly on trapping
FP exceptions, we accidentally broke the handling of the flag bits
for non-trapping exceptions.

In update_fr0_op() we incorrectly zero out the flag bits and the C
bit, so any fp operation would clear previously set flag bits. We
also stopped setting the flag bits when the fp operation raises
an exception and the trap is not enabled.

Adjust the code so that we set the Flag bits for every exception that
happened and where the trap is not enabled.  (This is the correct
behaviour for the case where an instruction triggers two exceptions,
one of which traps and one of which does not; that can only happen
for inexact + underflow or inexact + overflow.)

Cc: qemu-stable@nongnu.org
Fixes: ebd394948de4e8 ("target/hppa: Fix FPE exceptions")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3158
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/hppa/fpu_helper.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/hppa/fpu_helper.c b/target/hppa/fpu_helper.c
index 45353202fae..2d272730f60 100644
--- a/target/hppa/fpu_helper.c
+++ b/target/hppa/fpu_helper.c
@@ -94,7 +94,8 @@ static void update_fr0_op(CPUHPPAState *env, uintptr_t ra)
 {
     uint32_t soft_exp = get_float_exception_flags(&env->fp_status);
     uint32_t hard_exp = 0;
-    uint32_t shadow = env->fr0_shadow & 0x3ffffff;
+    uint32_t shadow = env->fr0_shadow;
+    uint32_t to_flag = 0;
     uint32_t fr1 = 0;
 
     if (likely(soft_exp == 0)) {
@@ -122,6 +123,10 @@ static void update_fr0_op(CPUHPPAState *env, uintptr_t ra)
             fr1 |= hard_exp << (R_FPSR_FLAGS_SHIFT - R_FPSR_ENABLES_SHIFT);
         }
     }
+    /* Set the Flag bits for every exception that was not enabled */
+    to_flag = hard_exp & ~shadow;
+    shadow |= to_flag << (R_FPSR_FLAGS_SHIFT - R_FPSR_ENABLES_SHIFT);
+
     env->fr0_shadow = shadow;
     env->fr[0] = (uint64_t)shadow << 32 | fr1;
 
-- 
2.43.0


