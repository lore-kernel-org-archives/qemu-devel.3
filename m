Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA20C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 18:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugSTC-0000Dm-Ki; Mon, 28 Jul 2025 14:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ugSPT-0004tH-2T
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 14:17:28 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ugSPL-0002p9-8N
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 14:17:13 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7426c44e014so3969436b3a.3
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 11:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753726626; x=1754331426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c9TCFAgVKBzK90J2gsyNT7SK5mNcifsRduRa1q59NyE=;
 b=vXMDAIodXWz+S1xPScC2wnzwDl3J8ib7xMyZ6r4Zf4HRTgjxrO7XImrRb3A+7SnB3y
 KHquJvIbxdOj9bt47PPH52Rv5TjZaGC5ju9/2zlJY6JmTHrAGcWXj33xUfBdXnXRQQyd
 w+GNipdMrsFgJShDYNwNNmoE3H0UhmhnZ9JSJvSKGqqgybwR2Ejkgp07Hv2DClGnFrgH
 hKiCz4OuTjzEoq/GuugVZOWp9H0ySua7SsLJTYQcdNTH98GDbye3XdLVGr21H2jVSF8C
 lGHXlecvRK6bR9/eR+ChJq10h0LrJay+o8K8aer+S9lEgzEULfpZLp5gbFran+UENq6F
 I5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753726626; x=1754331426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c9TCFAgVKBzK90J2gsyNT7SK5mNcifsRduRa1q59NyE=;
 b=cOuAiFJTW76GfuCM2G19AL9N8miVn+ZL3ui0rhhqIYQVnfxE3YFmpPcsS7D1rTnJES
 0IVEAy1WEm6T1Hd6yGYEakymNnZVXj33rmc53tY2KcObVawLjWdxF0fCjCOCBkCqog9s
 IA33fjk2NSRN0nhwCrhrct4yvySRqp123DEDrrBLpoNiRe0wyQqgft/CXh8UomzNqpbm
 Ev67R8b1KU6gM9AhIYXPatUmj8RnAjOApH/AWY2mf041vpmXRHvCAY+uuaHXLmkOR8CP
 OZTDjQhPu4tAsBFwSYlsTIsSs4AGyEBA1n/yjvMjeU5w5qsodpnXMNyVuBSpgokAKCzx
 h0gg==
X-Gm-Message-State: AOJu0Yw6m57WsoYhQq9Y3vhJDNOH//DNMlezPNLysX84NxD7AsSyRFYY
 AqT4ftOoy8KnMHms98Etm1y8X3cduQZkwGqKlKThbJxLrAam0fjWP3gt83de4k8top0xeVgTesl
 ZqZkS
X-Gm-Gg: ASbGncu7ftyliVjTSLQrFpa6gqOifJBoOpu11XT4gKrw/VQ98d+VRiqTwT7SFcwISnE
 fK2ieVooOUHIOKZFIdkzcnbc6vjJYl4V+IN0my7t5fx7qe63XDdvrY2Mtn4gfGyQHyScqECEtlC
 jpPEgMBfRjaGv1XO2dGPvEM8E9SEVrn6h6Ay42V35vsYEKy2wMb/TXLVq6RsFsM9bsBnnL34Xtk
 ZBNSFiVQ6Mq8axT2/ISvO/7VwJ9KgzKJ+KoL9I3reyO+owRy4HNUamLuvZaabhN0G++ywEBQJKv
 22uUq8tB8aDN/q22QOGPLPR413gLZ9pssTqFXsFCQiElUQWtgUWCFnNYrfPt9UQPkuckJp5R/j1
 pb0wBzcvnoT9Uab3Up9vb9HCQX5g+kQFiJBpXb+BlxOF5KZ6vlS7lHuysRmYOOrzXh8bCCRylEU
 KSwcZkOKWwQw==
X-Google-Smtp-Source: AGHT+IESpIDTtiJ0awHkuF39x7aQEdyGyCmSfKY7kHtnv3xDDkDwdq4kfPJ42BsdWx1uSXFVO+CqwQ==
X-Received: by 2002:a05:6a00:148b:b0:74d:247f:faf1 with SMTP id
 d2e1a72fcca58-76332861265mr17466403b3a.6.1753726625613; 
 Mon, 28 Jul 2025 11:17:05 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640adfeb83sm5985103b3a.66.2025.07.28.11.17.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 11:17:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru, Peter Maydell <peter.maydell@linaro.org>,
 qemu-stable@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 8/9] linux-user/aarch64: Clear TPIDR2_EL0 when delivering
 signals
Date: Mon, 28 Jul 2025 08:16:49 -1000
Message-ID: <20250728181650.165114-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250728181650.165114-1-richard.henderson@linaro.org>
References: <20250728181650.165114-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

A recent change to the kernel (Linux commit b376108e1f88
"arm64/fpsimd: signal: Clear TPIDR2 when delivering signals") updated
the signal-handler entry code to always clear TPIDR2_EL0.

This is necessary for the userspace ZA lazy saving scheme to work
correctly when unwinding exceptions across a signal boundary.
(For the essay-length description of the incorrect behaviour and
why this is the correct fix, see the commit message for the
kernel commit.)

Make QEMU also clear TPIDR2_EL0 on signal entry, applying the
equivalent bugfix to our implementation.

Note that getting this unwinding to work correctly also requires
changes to the userspace code, e.g.  as implemented in gcc in
https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=b5ffc8e75a8

This change is technically an ABI change; from the kernel's
point of view SME was never enabled (it was hidden behind
CONFIG_BROKEN) before the change. From QEMU's point of view
our SME-related signal handling was broken anyway as we weren't
saving and restoring TPIDR2_EL0.

Cc: qemu-stable@nongnu.org
Fixes: 78011586b90d1 ("target/arm: Enable SME for user-only")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250725175510.3864231-2-peter.maydell@linaro.org>
(cherry picked from commit 3cdd990aa920ec8f2994b634f758dab4a86ac167)
---
 linux-user/aarch64/signal.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
index b265cfd470..85cb25ae91 100644
--- a/linux-user/aarch64/signal.c
+++ b/linux-user/aarch64/signal.c
@@ -665,8 +665,12 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
         env->btype = 2;
     }
 
-    /* Invoke the signal handler with both SM and ZA disabled. */
+    /*
+     * Invoke the signal handler with a clean SME state: both SM and ZA
+     * disabled and TPIDR2_EL0 cleared.
+     */
     aarch64_set_svcr(env, 0, R_SVCR_SM_MASK | R_SVCR_ZA_MASK);
+    env->cp15.tpidr2_el0 = 0;
 
     if (info) {
         tswap_siginfo(&frame->info, info);
-- 
2.43.0


