Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 312E1CD98D6
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 17:50:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY61f-0003F2-H3; Fri, 12 Jun 2026 13:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wY61e-0003El-37
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 13:50:38 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wY61c-00083N-Gf
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 13:50:37 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-84275887a3fso1696988b3a.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 10:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781286635; x=1781891435; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s4Mxpm3Ijhd3Vq3CMSEdh6q5iQG1sogEEwFShXJRnLw=;
 b=gBfVIpUSFeo03ZqXG+0S4YzWbWWsRXzC0FT0G5SO+4bOYRaEMsmpjJxLoG5miFahYs
 VSe3y2gDX4OOK1F4+d3TmeGRHfruFspiYV10L1AwyH6/3nW1NW8uRCZVTyZVsG29mOPo
 Oup32+e7lwE39KflTIK7x94LNQL/mZbokyYyKDCBdbNzGDvoQTaDy7kIwzL7h+LLrpKr
 i0/G4KNoerK/0dx1uNDWCEW6JipySm3LjdVPaCyNpjqTyIAAFkhMzp0+GSpgI8YgZGv/
 NT12WGdt5GXyr3MUAjqQtRfpTrrJaWvCHyDFm+N2NYemsWJpxy7/AyA2QUzbTHONZ0HY
 708g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781286635; x=1781891435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s4Mxpm3Ijhd3Vq3CMSEdh6q5iQG1sogEEwFShXJRnLw=;
 b=lAAteX0pqWbcDv5fNkuuaGWedT61yr646qoHpeWCz5T+KfOJPckpC4BSjGBFFOY503
 JsoWScPUVP1v5ihWH0l65kRi1SdRuC2S9/NgN3dlcnvgoHkOPqCi4QhJomLwLr5qkv+v
 bkLGbhrYv7UqjpPkY5Yc+9DY5hy9yhBo3lh6ICIC4yTR2WZfNa3xB8ZMOsjwlef1SDw4
 S1lUfnxI5nk6aLTyU3QLmI5YM+PFVValnbkMlBZPJP72wmjsDY7X2yBqwXCjcOGAKegr
 tiCjlAowj4dNCiXAn1rEcP8X7919D0SlmlExfSqPrsSpyua8csNO+83F0NsMSUqYgSmK
 c0xQ==
X-Gm-Message-State: AOJu0YxjCVVXhMpNbqOdRGuzdX1w6UC/trFUh4WI4WPqcGnbhkhg2uhF
 3kmDzCGtlAAAXIDCc8VWKCH8XwZP1op6wnmiSle0nm1Pzq4aDiVnC6iRhSLV1M1DYKk8MXjtUew
 Zj0UXMpk=
X-Gm-Gg: Acq92OFKc4Znj9cVNa10U0/+h7NIa6WIF73iffbNVztNOF1Ur1IumbA6BtH/kBkGt7W
 Dbqqd2b+6lLw7W1z7K6DqGje76pwcj5WkTItWN/dwEphKtJMwYlSFNksbgLMbDCIYiSJmNd16WS
 S08046iIWSCo1dSSOQkrLpPUR08hw09EEWoxJDrzThgFlnFh6kFjfUCyYQixBpSKLFd6Rs00Kkl
 Kbo91VqtMavpu4mQzynzyh9Dzaz0Xoy/S4KtGHBfDwEbaIQ5X2iTIWIfbCKleRwczT6uglU4J82
 KOMIdWDQOj6O1viUNApZWy/GcoeisWW2yuqx+k7LPxkgIsnUN7KgELadPl3QDj3X2cglITfLfwa
 DCxwwbPsLjhCJvAC71NrC/PDBZJuHkA7+Qg5xl/JVcsg/pzIiGp77nPkZG+7dLGbhBKGGMvhye4
 XnzdjpY5In3G+v2sC8dIkSDdaXno+5
X-Received: by 2002:a05:6a00:3313:b0:82f:51e8:b38e with SMTP id
 d2e1a72fcca58-8434978a303mr3619021b3a.24.1781286635028; 
 Fri, 12 Jun 2026 10:50:35 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434afc8a84sm3393319b3a.38.2026.06.12.10.50.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 10:50:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PULL 1/1] tcg: Silence ubsan error on tcg_splitwx_diff causing
 overflow
Date: Fri, 12 Jun 2026 10:50:33 -0700
Message-ID: <20260612175033.58007-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612175033.58007-1-richard.henderson@linaro.org>
References: <20260612175033.58007-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

From: Fabiano Rosas <farosas@suse.de>

UBSAN complains:
runtime error: addition of unsigned offset to 0x7bc06e1f5000
overflowed to 0x7bc02e1f5000

Change tcg_splitwx_diff to ptrdiff_t and silence the error.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260605132539.2775364-1-farosas@suse.de>
---
 include/tcg/tcg.h | 2 +-
 tcg/tcg.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 45c7e118c3..7669dc1c2d 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -447,7 +447,7 @@ static inline bool temp_readonly(TCGTemp *ts)
 
 extern __thread TCGContext *tcg_ctx;
 extern const void *tcg_code_gen_epilogue;
-extern uintptr_t tcg_splitwx_diff;
+extern ptrdiff_t tcg_splitwx_diff;
 extern TCGv_env tcg_env;
 
 bool in_code_gen_buffer(const void *p);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 2ca44766f6..1e77f2365a 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -244,7 +244,7 @@ unsigned int tcg_cur_ctxs;
 unsigned int tcg_max_ctxs;
 TCGv_env tcg_env;
 const void *tcg_code_gen_epilogue;
-uintptr_t tcg_splitwx_diff;
+ptrdiff_t tcg_splitwx_diff;
 
 #ifndef CONFIG_TCG_INTERPRETER
 tcg_prologue_fn *tcg_qemu_tb_exec;
-- 
2.43.0


