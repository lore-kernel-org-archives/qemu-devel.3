Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F782C5DF7D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 00:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwThm-0005xI-8C; Tue, 18 Aug 2026 19:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwThk-0005qX-DX
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:58:52 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwThi-0005Ll-Od
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:58:52 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-462df62f872so612967fac.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 16:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1787097530; x=1787702330;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sGX1jc55xYmO11nLE9YAO+NyXCHPIuF2VOVhWdvByqQ=;
 b=WQ4nAsHVT9xaH02/RoDBOu0z6Fp7MsBdxaNgZbFx7JI2D+D9qr7Ig2Cj8E4VzFIfKn
 H1tqAGaOCnodvHhUtJCBVpvw5vVfJRC06ntgNDFnwOqwlNbSFMaWIwaQbVFBJqXcV+y+
 q4fURDcymO85WM5catvI4To7CeCwTcfSABeqheWHFL35+Q6e6XahcWJaWfMeb4rw9BdA
 O4WGVTP4qdLhIuNf+kNYP7CrBe9kYuERSCyiOPLF6XGFNcViktIqFQ/ssKzm5wgvBjii
 ilO+AYE3PUAvx8pLdmPOzYl5QdttcXafkMANnEk0nlxtljDDEbd/14kfauYCglLreZR5
 jr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787097530; x=1787702330;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sGX1jc55xYmO11nLE9YAO+NyXCHPIuF2VOVhWdvByqQ=;
 b=OKL0IUQx612zXpo85SgytPIWzqYHiyLOm6WpHSmKYOhpayFQQ8TuaDMvotA1pvJGvQ
 44/yqZLSYE6yncWdNrG+LC8/P9FXOhICOu7I3kXz7IQcs0r1yEBCEmtFvs84nJXhwPMk
 II3o/Vo8U7X9ugVqp93WS2/N7q3qcp24QLZAq1GL2X6KFkHwZD3vh/sjXg/mSfHtUt1o
 +A3cJ9O5hN4CQWBbTxh2wrQC246EGb2Db9uIR3o8dcmcjFi3kEnI/Slo2D8cGnTuvjj+
 LHh1j2qNBGshS35KyL+/KLvMt7au1RC0+98jxrLaMVPBf+C9Qh5WjLxuZgqm0hv8R7la
 FfSg==
X-Gm-Message-State: AOJu0Yzqbknt4FS7cNcD9xIb4UmM/6AdPJ7cBKD5On1Z9GC+R33ATtYK
 Fxb/Zd92LaxM+BbYoHWjluxaxcpZCIPPkkSpCATOleIpxDERw3qowLymEd3oml/TXsw=
X-Gm-Gg: AR+sD11YCRBYieMhubgjRfIjgyRNVla0to1qW1oWeFb7wMz36dxbhVh4GHdY5mh1B5L
 iEv9M9UkcgzmX96rakHN2ELWM5wo30/xuCOgaTcPKy25aur+ovnMRBVoMoUtR2X4sHFN4J6kRS5
 24u0ONBlDqSefgTvLe1jsrRB90nYQdh14Q1RMYQRqzIsv3LRhoam5VgTZd/L5E8QVuFEhoj/C1b
 X/oKFXjJ30qVYfH+fbO4yWk+OOu47/32/gRkkHhyIuFba71dLYClbBX/qndx9ItsMsGS11iYSHy
 /NcWhaCq4uQis3jzqbzoBiHSsj0hIsVeG/7v27Mbz+vb/c7TK3d+8YISO+zi759kN+CefIj9plM
 hpvOeDZckBtxpXCFEz6mWKSjp93r0HXeD7ce0+pHEwR/xUYytkdBalF5IyIxkC6Jof+dMGbQYSN
 KwBZp0luxjEkgMngQfMHSIsvlm2ebE//1QfomXucu2q0nMmwK6cr1VaDPLsw==
X-Received: by 2002:a05:6808:23d4:b0:4a4:c95a:38d1 with SMTP id
 5614622812f47-4b2ba5e8fe6mr849040b6e.4.1787097529635; 
 Tue, 18 Aug 2026 16:58:49 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2906a3edesm4835341b6e.0.2026.08.18.16.58.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 16:58:48 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 18 Aug 2026 17:56:33 -0600
Subject: [PATCH v4 40/40] bsd-user Update random_seed on thread creation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-misc-2026q2-v4-40-09bf5647c98e@bsdimp.com>
References: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
In-Reply-To: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1665; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=jel7BUfjuAeI94sDVtPsn23nHuJBSBrlyEnEBbOpMBI=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqhPFfB+211hzwCLxoPj1Lgw5ajiXPcEPoTbJfj
 De0hUOy0GCJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaoTxXxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQA8cw//WYsBFKwkbLBQeyJFvQSh27gtuySKwHw
 RZuhUB0xrFT68xDP7iqXSnda+j/7zlWvU/yLPy4/5SnSNnRVc7PM6/wpznmvFWQTzUsjfLwCz5a
 HW0ns+RGXzBdWDErWc1nL/cs/3cUw5/lr+AnOpAWV3M0jLvubUYDN7ziPyBxwe19wdaxMNsZcB3
 gHC3169kGFjns3qFG904sERifScf+N8KrVV0VLH1LPSr3SmiR6zrpYl05jnsDmarIHJuKMFeG3T
 xlQ1M0+e8dWyuwflFg4kUsXRlw8aCJTHCe0JujgwEXdZklrd1T90iiNkdmwH8wbBs/Rp0gSe6TR
 1wB6eTaPkjwfb5QLRs7yWtxeImVUNfp5vHIre6T/uOHUyAiVN/JslRVlcI5mYDWNFhYzPv8TiN0
 tr9fZNbzwpxVQILHPl2Mtx0aKyQiwfMSQMgfIEbR86br2t9lCJQWSi6H6NA/4TqbHd3o125rPc7
 a4HYFDMXr9Nm9XFu0XRMBetgVGvZoWsI83Oehh3M0ePvby3dv74huvKmNBtaytKQLW4WIU5IkZP
 sXnnlsm3qD7gUTa8xcHKyzSricJG2tC73bZ03ZW0E4jBMOw4wc2OQuBAr3GC57cWOyescnCYH1U
 HoRox1iLEp6WoQ6jX/hDm9xWWPIV/EgPI96/RSIqhLnNEpv5cuKg=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::29;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x29.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Initialize / update cpu->random_seed in similar locations to the
linux-user code. Set it just before we create the thread, and update it
in the thread startup code.

Reported-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-thread.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/bsd-user/freebsd/os-thread.c b/bsd-user/freebsd/os-thread.c
index 63c17e10d0..15872f03fd 100644
--- a/bsd-user/freebsd/os-thread.c
+++ b/bsd-user/freebsd/os-thread.c
@@ -14,6 +14,7 @@
 #include "signal-common.h"
 #include "target_arch_cpu.h"
 #include "target_arch_thread.h"
+#include "qemu/guest-random.h"
 #include "tcg/startup.h"
 #include "exec/tb-flush.h"
 
@@ -142,7 +143,7 @@ void *new_freebsd_thread_start(void *arg)
     target_thread_set_upcall(env, info->param.start_func, info->param.arg,
         info->param.stack_base, info->param.stack_size);
     target_cpu_set_tls(env, info->param.tls_base);
-
+    qemu_guest_random_seed_thread_part2(cpu->random_seed);
     /* Enable signals */
     sigprocmask(SIG_SETMASK, &info->sigmask, NULL);
     /* Signal to the parent that we're ready. */
@@ -1657,6 +1658,7 @@ abi_long do_freebsd_thr_new(CPUArchState *env,
      */
     sigfillset(&sigmask);
     sigprocmask(SIG_BLOCK, &sigmask, &info.sigmask);
+    cpu->random_seed = qemu_guest_random_seed_thread_part1();
 
     ret = pthread_create(&info.thread, &attr, new_freebsd_thread_start, &info);
 

-- 
2.55.0


