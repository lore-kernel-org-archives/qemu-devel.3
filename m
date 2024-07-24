Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA68C3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 04:57:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWU3u-0001e0-W4; Wed, 24 Jul 2024 00:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWU3r-0001d7-JL
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 00:57:11 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWU3n-0002J2-P8
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 00:57:09 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7a2123e9ad5so347695a12.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 21:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721797026; x=1722401826; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=K/CnMhuvnZ2rqnpBp7fJkM6WGv4i8Jdhm4C9UBOmEGg=;
 b=xkNpfyc/KL8PuliyGRqFhAGTZasFbGiulKn56dK1Slrkr3w0wEsrC2jMOAvboUnrdO
 +OcZL5kX5jmOjzlKn6KoRnCsINe/vmbAXJn7+TJpv0UZ/Vc8pvMIrdv6Wn/Z6kubU0hH
 WW0doMaTFkm06gAlgwsEyByadRU1VaZE36PMeJaseUbQNRV1nCaN+GXfezs2BcPKkpab
 fUaGbzsUf/JDCIsvkC5lfPgdtSjoH87kWpffnii8B6hi7yF/QP0jnTpJiWRv6eN5Mu53
 kFJZ1vWkQT7SVpuA9dL7XxZs9xRFLtgh9Nq1sdy0WkX3HZf0pZbpElspl7tL1hmg7EBZ
 pdXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721797026; x=1722401826;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K/CnMhuvnZ2rqnpBp7fJkM6WGv4i8Jdhm4C9UBOmEGg=;
 b=jFyRJAakdXERECSwcCS18D1HS1I+T6S3oF8HY/0HIgT1TqucHQjX4ujDDEeOUHpNJa
 A4OupG3/M9pH1qG02wHOM69/CdcjFX1+tTntm//yeyPhLqbO4XlZVa76lsqQfBIBBtkG
 BtUOunVKsN0zICFdUx0L86vGGqZrLola/H7He9vLpkLa6cIUVKmtjVZMxL9glw5/tCZG
 tKXYPieWUSdvypAhAyt2WIFkoKFbThRFPFr4Fhi4HrHeMf88R8IHRwjj8H943cjrS8XQ
 56Zkzl+A7tOZJQAm//ARpqrxubpI1mVRnFM/xUt4RoAL0QhTbqwHM1t6j+dSBkpuPKs5
 aK8g==
X-Gm-Message-State: AOJu0YyXdhQ8JOMEcAQ3PtHU1HaHUArxAZH+dzi/pnNmFdQKiq049zdP
 v0NXEpnd4ha5uOdvHoC7/XsIjjAF/AMe/CWfpzYSjxcBdkFrYBkezcOGoUkUZan17IPM/EgXoTi
 UBrwi9A==
X-Google-Smtp-Source: AGHT+IGyPys+nc7o9QTlYHoTtGrIcoiPSGKimEbVG0vH1EXGgVMCIFhWcvSHc4FOQSneHkWRdgeaOQ==
X-Received: by 2002:a17:90b:33cb:b0:2c9:75a7:5c25 with SMTP id
 98e67ed59e1d1-2cdb9443005mr1255550a91.15.1721797026084; 
 Tue, 23 Jul 2024 21:57:06 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cd8f73bd52sm994975a91.1.2024.07.23.21.57.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 21:57:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com
Subject: [PATCH] target/rx: Use target_ulong for address in LI
Date: Wed, 24 Jul 2024 14:56:59 +1000
Message-ID: <20240724045659.160684-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

Using int32_t meant that the address was sign-extended to uint64_t
when passing to translator_ld*, triggering an assert.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2453
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/rx/translate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/rx/translate.c b/target/rx/translate.c
index 9b81cf20b3..9aade2b6e5 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -85,7 +85,8 @@ static uint32_t decode_load_bytes(DisasContext *ctx, uint32_t insn,
 
 static uint32_t li(DisasContext *ctx, int sz)
 {
-    int32_t tmp, addr;
+    target_ulong addr;
+    uint32_t tmp;
     CPURXState *env = ctx->env;
     addr = ctx->base.pc_next;
 
-- 
2.43.0


