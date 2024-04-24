Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118EDC19F4E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 22:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzlSk-00070m-2C; Wed, 24 Apr 2024 18:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzlSj-0006ym-4S
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 18:51:37 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzlSh-0006hO-K9
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 18:51:36 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6f043f9e6d7so447750b3a.3
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 15:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713999094; x=1714603894; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G1KuH29eWKziwjTP2PdMM65i8n1Oaouq5HMuEevb+aM=;
 b=Xv3f/LPjN1GU3fW0+zrMz3qZ4OtqiYKtMU2D7gVofRX6fb/oDDyMyOWRQAOAQua4On
 A+H1glALATjfCPHIIW0H4fkOowie/yfHmnZ+bDjvXDMnuhdUT7s2ahxIZdcQFq2FQgOR
 LFdLGAW7YKP4vBPIm0hAd5Is5I5ifDSJwimHmfI3izEuOReAhYaNtys4dRmgxXX/jYTO
 ujZoDswmUKpG7ZI+Ye2cCU3GyAsr+tm6ulQX0bXJi8mxwGXjCabnaDenf7Aq5AnEGsCC
 e8VftJYdFtdZ7oukl29jaMHxT3VfyDY7rAPlImz7Mm6qVfox4u7wxqajJruLbiqr7LHb
 Ps4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713999094; x=1714603894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G1KuH29eWKziwjTP2PdMM65i8n1Oaouq5HMuEevb+aM=;
 b=Ip3b5h8H8V35KcG/fuHvcgb4CMH78iNa3+wpP3idd0BHGu2LTj+zuKVHKJ1wVHbnLJ
 fImWQMTSThb017JW/OghLzgNzpTxEBj/kfkk6HLi3eUWGdZzTeXJVQhN5fYdWMClDDW+
 hvAlda7hmtaFTsxis5lyGDbGmJt/ByetVQXlHZ1yIoJDvWdHybE6PWOx7LxSzUJmGbwt
 lapi4ZSbVsL1I8L6C30fe0IjiMVVPqb+cdY8Ifaa17BYicLT99c8ToUP6iGUzPpWGh8c
 jezRxQOJMA9QBoXlhAhy3+eR2xtSeU3PCMvR6LYcoYcCnz46tNl8Z54B3hJ8j1kJlfs0
 drvA==
X-Gm-Message-State: AOJu0YxaJE54pg5mLCDjSA8zffE6dxOCtzcU8uwp+KwN4AmhDQW2P25G
 XcGiM1m6m3n0hpda7aySIzljywS6alFY31tVp5jwHuxPJV2WdQ+Oa8xDIqTVoYciyivqUkvSw7q
 S
X-Google-Smtp-Source: AGHT+IEkVSn7F/keH1gg+6OUG59K7Aho0Tg7877FgFWd3CZqxAYqP+8ZxthE3JqyRMDWGLjusLtVYQ==
X-Received: by 2002:a05:6a20:3d88:b0:1aa:340e:237e with SMTP id
 s8-20020a056a203d8800b001aa340e237emr4626663pzi.59.1713999094263; 
 Wed, 24 Apr 2024 15:51:34 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 it12-20020a056a00458c00b006ead792b6f2sm11960864pfb.1.2024.04.24.15.51.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 15:51:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Keith Packard <keithp@keithp.com>
Subject: [PULL 9/9] target/m68k: Support semihosting on non-ColdFire targets
Date: Wed, 24 Apr 2024 15:51:23 -0700
Message-Id: <20240424225123.929152-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424225123.929152-1-richard.henderson@linaro.org>
References: <20240424225123.929152-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

From: Keith Packard <keithp@keithp.com>

According to the m68k semihosting spec:

"The instruction used to trigger a semihosting request depends on the
 m68k processor variant.  On ColdFire, "halt" is used; on other processors
 (which don't implement "halt"), "bkpt #0" may be used."

Add support for non-CodeFire processors by matching BKPT #0 instructions.

Signed-off-by: Keith Packard <keithp@keithp.com>
[rth: Use semihosting_test()]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 647bd9d9be..169927552a 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -2646,6 +2646,11 @@ DISAS_INSN(bkpt)
 #if defined(CONFIG_USER_ONLY)
     gen_exception(s, s->base.pc_next, EXCP_DEBUG);
 #else
+    /* BKPT #0 is the alternate semihosting instruction. */
+    if ((insn & 7) == 0 && semihosting_test(s)) {
+        gen_exception(s, s->pc, EXCP_SEMIHOSTING);
+        return;
+    }
     gen_exception(s, s->base.pc_next, EXCP_ILLEGAL);
 #endif
 }
-- 
2.34.1


