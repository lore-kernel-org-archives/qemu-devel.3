Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD37C87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 16:51:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufLdf-00016P-3v; Fri, 25 Jul 2025 12:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufLda-00015H-Pi
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 12:51:15 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufLdZ-0000Jd-0k
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 12:51:14 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3138e64b42aso2378445a91.0
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 09:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753462271; x=1754067071; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iNgmCYp7/jLUeXPpGRJsfeU47Lc0eatRrDR5p/QWI+g=;
 b=o6r6XyEwvJS0q0H40+03KlBCBGTqx59Ek5zKz9m0OdGviRGQ9TayIA2oNlgU6Tnfoe
 IQx+U0jNKKOfhQuXs593AMAknJDvPBB6Gk2BiUnp05aHNbEa2QCLSAlnOw99FKN+bnM/
 9LtSUn2o2Cwzdw+xH/araBMqdTQZMXINi9DHIJ7cWj9AF3HxmX2DL9OWNHSsGIPWOdMl
 wb26YJrwiSvxKxufWoYPdTZTfnz1mmAthGcAf7NSEaUpPcMha4QeuyumkUbWoKlgA02D
 9BFI88rT4Zr0aa3T22/8uE6Y2bDRf5eE33PlWSolxni1moGN1A1dLmeodBwqadKhe9NB
 369w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753462271; x=1754067071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iNgmCYp7/jLUeXPpGRJsfeU47Lc0eatRrDR5p/QWI+g=;
 b=rQW1Dyz2b8QCzPQq5zXoWTErThk0kRWk2XQ+9mE1xmxrh84R/yRj7v+bctM59PqcQA
 fPrarDkFreGsQ6x0XGVTPphh0spqNOZmjDDIiv8kz7B3It7fDRU3D2SWF2JTGu8OjaaS
 Qm/ak0gK8fGUYodkuyry8juYss9ZUxwR4UUlFQW+GcUoVbIDPt9fP1OqepPBLZvDru94
 l8dFIVLOIK7bEzhP5Ocl2JRLNvt4MExah8dFqlTnf+SUqSseQ1T1tzhsoDlrD0Vi2w0r
 zcqknj0x3XH43Xb6dQSPMAF+zLv71R8R+qz91RtFAWD789jAOddK1HAYbtgJN9Ce75+B
 XPsg==
X-Gm-Message-State: AOJu0YzQH4ShB7Qs3O2olHa6d1eiskW7FCQMm/En+wUXt+rno4/b17ju
 RTfT3bT0vjDY7WPj0pp+ll5B+6R7IVTzyJalIJgWA7Vh1JoyGB96h+pPHUxNAvIdBoHWv9XbOJm
 QXK5P
X-Gm-Gg: ASbGncv77vxWRJjVGzwBgewHSq3AJhMCexbCvLzvSuHRzPUekkiMludkAwfjbTB7XRo
 NXWfCsbeV+FngvWNpYlLcoXaebynD4x0vJX2TS6j0QnLXQObC8FK4fOTvgqat5r6O5zE3AxLfO7
 4jANB23Aw+FsCplDqJwKG127DuAYYMRVSg33/kVe1wodwa00icJXIuyIOvXJP0vZ6i3wgZTRAVE
 R3ok6gpjSrl3ZLDIJ4YCxZI47UeM9Fh0XJAJizas9qLnx5IeaEZvC83sbAGLTW3GSDB2w7/zgo/
 02/7odTPoW37h0OOIoJZIPho/YD11FOYNNKk1qgyr1v6w23QKeRkuULokpYMEN6yzlmThmmMP24
 HO0isI5wydgBX99qjJaJ0ftWqe+peMEJn3HnImBD+XafE609fJXf6NCicr3FUAsqH9ntcoIUq+J
 hf+E5oz+O44w==
X-Google-Smtp-Source: AGHT+IEnL7/ZjO42065RwrfGDp7eg35Xjs/SJev8o7Hp3ILLh14yYqMiYjqUldReCt02S2psBaTK2w==
X-Received: by 2002:a17:90b:4a06:b0:311:b5ac:6f63 with SMTP id
 98e67ed59e1d1-31e778f7d18mr3962529a91.21.1753462271431; 
 Fri, 25 Jul 2025 09:51:11 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e6635efc3sm3864080a91.22.2025.07.25.09.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 09:51:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH for-10.1 1/2] linux-user/aarch64: Check syndrome for EXCP_UDEF
Date: Fri, 25 Jul 2025 06:51:04 -1000
Message-ID: <20250725165106.37105-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250725165106.37105-1-richard.henderson@linaro.org>
References: <20250725165106.37105-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

Note that we have been passing the incorrect code for
uncategorized and bti faults.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/cpu_loop.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index fea43cefa6..43a471b535 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -32,6 +32,7 @@ void cpu_loop(CPUARMState *env)
 {
     CPUState *cs = env_cpu(env);
     int trapnr, ec, fsc, si_code, si_signo;
+    uint64_t addr;
     abi_long ret;
 
     for (;;) {
@@ -63,10 +64,12 @@ void cpu_loop(CPUARMState *env)
             /* just indicate that signals should be handled asap */
             break;
         case EXCP_UDEF:
-            force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPN, env->pc);
-            break;
+            addr = env->pc;
+            goto do_syndrome;
         case EXCP_PREFETCH_ABORT:
         case EXCP_DATA_ABORT:
+            addr = env->exception.vaddress;
+        do_syndrome:
             ec = syn_get_ec(env->exception.syndrome);
             switch (ec) {
             case EC_DATAABORT:
@@ -99,10 +102,19 @@ void cpu_loop(CPUARMState *env)
                 si_signo = TARGET_SIGBUS;
                 si_code = TARGET_BUS_ADRALN;
                 break;
+            case EC_UNCATEGORIZED:
+            case EC_BTITRAP:
+                si_signo = TARGET_SIGILL;
+                si_code = TARGET_ILL_ILLOPC;
+                break;
+            case EC_PACFAIL:
+                si_signo = TARGET_SIGILL;
+                si_code = TARGET_ILL_ILLOPN;
+                break;
             default:
                 g_assert_not_reached();
             }
-            force_sig_fault(si_signo, si_code, env->exception.vaddress);
+            force_sig_fault(si_signo, si_code, addr);
             break;
         case EXCP_DEBUG:
         case EXCP_BKPT:
-- 
2.43.0


