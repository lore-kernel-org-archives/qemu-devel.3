Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46365CA1000
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNvS-00059K-Uy; Sat, 30 Aug 2025 11:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usELO-0005nd-9o
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:41:42 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usELL-00040m-66
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:41:41 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7718408baf7so2744593b3a.3
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532498; x=1757137298; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xJfNF5k3nu+7zmvA/IxmSosD+BHAmoqUFdC0gCMb2Yo=;
 b=CmmUCL+Lu+5F5ZfK9aOkfMCNK2DofDD7SpgHe55MzyQApC6IgBFvWijiSMK0YrNVFP
 bnv4rzHtO7yTa+PqSy23wouoZ9B+Xf1RdTs7KsH+AsR8DS1k7SwAyae6G6yGf3Yb7w/K
 WHMLviCWZ2/DIzmk4+OW+n+tVF3et5/enfi2a1loL7x6HlAOzrljUQWFlwofk+Mh+4be
 Lzs2e3XOiZx5gA6yZMvAu5L42kTi85nqAux2nqG5nSJdz0aUwQ8s+0U/i9xCelACMAdp
 kcoBOk4o9XX86RSIG0/RDXOOeez3o5JcEDSHWh3pvwUKJjgFv7rhDOQf14Pda9CMa0xu
 za1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532498; x=1757137298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xJfNF5k3nu+7zmvA/IxmSosD+BHAmoqUFdC0gCMb2Yo=;
 b=ghQOqlt1N+yOyg2ILI1wD2JkiqZl6cbitwsI9ijJjgpFrSVTdJcdxoaJRKQ1Ppg+08
 nayL76TiZ1azZNJphkQ6HGy8u+02Dzw6X79kFwWs6JwbfHgGT5KBMJPV+lEmRj8oJMn8
 HChfvAxuJAMJlvrO74oZp3tRMZNrUZvWdHDKO69k6aPeAGkPpNACO1fYXH+QW6R6d7JN
 9vfhQLHQxPx4SF00f1+BT8BE822sEdI8yCyu4YZJ9ltNkeTmxR5Xf3ThzPxwNzrJQ1yV
 Wc7yfYSsuarDgrP+YK5s2Q/0YYTyzI78FZpKduUDWfuWQ+oqFkwX2wMHv20Mabi3nue5
 /qjw==
X-Gm-Message-State: AOJu0YwHtyPuP/pSrmFwwLBipJrnLhRQxETNtIsorIckNHu6OGDfoTXz
 rByfw5+26yGtVErWaaDtZUDHnRb+jWxXS1PLY8K4WHIKK1m3XR1lFOvyvukpHA7PDw2ao33eIWC
 oYhyH+VE=
X-Gm-Gg: ASbGncuFtvFW/OQgckeM5mmVJqOri0tctCe1TiY6YiXRl+AlGBTOoXdVvTjXmamJXQa
 gsj/b2YZ0iCTUL+XDVvqYD4U8wdx2JPo+44gBXMbNG2ok0XLE6ZYUQx4xFOFoIAEkmwDWI3Z/Sc
 NMxUkcmTiLN+tozssATjQtbN+fv9vmIYazZgIaQlcE4wV0W9kaqw5mv/RcR//vpwMtT1NAmR8qu
 uSrZTAc8HZFZvAITnPtFgNSVYkg549wP6sqSOZL6dmD7Jx1W9IZWj74SqcmNlP0XXdE/dMELk8S
 vDOYhTwFPqeO/eAmUjK+Syfw7yP8iSb1cyJqgc13tnljtDd3t7av34ru6YCy2h+LCb0DRchruVI
 ZvBxsfj+TAxlrZORnyZIKTW2CpKQA32af5scLvibPQJ4kGyLQ7f/5jYaAL+4c
X-Google-Smtp-Source: AGHT+IFsg2G0q33hgbIqXPNz+FfHjfUQmk/Yq1VBivb/Lq/aJT3oFqS58Nv8GOib1+SDGkCXFAOX4A==
X-Received: by 2002:a05:6300:218a:b0:243:b20d:5e05 with SMTP id
 adf61e73a8af0-243d6f051e5mr1638088637.39.1756532497643; 
 Fri, 29 Aug 2025 22:41:37 -0700 (PDT)
Received: from stoup.. (122-150-204-48.dyn.ip.vocus.au. [122.150.204.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4d96829a66sm2435905a12.6.2025.08.29.22.41.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:41:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 01/84] linux-user/aarch64: Split out signal_for_exception
Date: Sat, 30 Aug 2025 15:40:05 +1000
Message-ID: <20250830054128.448363-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/cpu_loop.c | 84 ++++++++++++++++++++---------------
 1 file changed, 47 insertions(+), 37 deletions(-)

diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index 4c4921152e..3b2782581b 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -27,11 +27,56 @@
 #include "target/arm/syndrome.h"
 #include "target/arm/cpu-features.h"
 
+/* Use the exception syndrome to map a cpu exception to a signal. */
+static void signal_for_exception(CPUARMState *env, vaddr addr)
+{
+    uint32_t syn = env->exception.syndrome;
+    int si_code, si_signo;
+
+    switch (syn_get_ec(syn)) {
+    case EC_DATAABORT:
+    case EC_INSNABORT:
+        /* Both EC have the same format for FSC, or close enough. */
+        switch (extract32(syn, 0, 6)) {
+        case 0x04 ... 0x07: /* Translation fault, level {0-3} */
+            si_signo = TARGET_SIGSEGV;
+            si_code = TARGET_SEGV_MAPERR;
+            break;
+        case 0x09 ... 0x0b: /* Access flag fault, level {1-3} */
+        case 0x0d ... 0x0f: /* Permission fault, level {1-3} */
+            si_signo = TARGET_SIGSEGV;
+            si_code = TARGET_SEGV_ACCERR;
+            break;
+        case 0x11: /* Synchronous Tag Check Fault */
+            si_signo = TARGET_SIGSEGV;
+            si_code = TARGET_SEGV_MTESERR;
+            break;
+        case 0x21: /* Alignment fault */
+            si_signo = TARGET_SIGBUS;
+            si_code = TARGET_BUS_ADRALN;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        break;
+
+    case EC_PCALIGNMENT:
+        si_signo = TARGET_SIGBUS;
+        si_code = TARGET_BUS_ADRALN;
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+
+    force_sig_fault(si_signo, si_code, addr);
+}
+
 /* AArch64 main loop */
 void cpu_loop(CPUARMState *env)
 {
     CPUState *cs = env_cpu(env);
-    int trapnr, ec, fsc, si_code, si_signo;
+    int trapnr;
     abi_long ret;
 
     for (;;) {
@@ -67,42 +112,7 @@ void cpu_loop(CPUARMState *env)
             break;
         case EXCP_PREFETCH_ABORT:
         case EXCP_DATA_ABORT:
-            ec = syn_get_ec(env->exception.syndrome);
-            switch (ec) {
-            case EC_DATAABORT:
-            case EC_INSNABORT:
-                /* Both EC have the same format for FSC, or close enough. */
-                fsc = extract32(env->exception.syndrome, 0, 6);
-                switch (fsc) {
-                case 0x04 ... 0x07: /* Translation fault, level {0-3} */
-                    si_signo = TARGET_SIGSEGV;
-                    si_code = TARGET_SEGV_MAPERR;
-                    break;
-                case 0x09 ... 0x0b: /* Access flag fault, level {1-3} */
-                case 0x0d ... 0x0f: /* Permission fault, level {1-3} */
-                    si_signo = TARGET_SIGSEGV;
-                    si_code = TARGET_SEGV_ACCERR;
-                    break;
-                case 0x11: /* Synchronous Tag Check Fault */
-                    si_signo = TARGET_SIGSEGV;
-                    si_code = TARGET_SEGV_MTESERR;
-                    break;
-                case 0x21: /* Alignment fault */
-                    si_signo = TARGET_SIGBUS;
-                    si_code = TARGET_BUS_ADRALN;
-                    break;
-                default:
-                    g_assert_not_reached();
-                }
-                break;
-            case EC_PCALIGNMENT:
-                si_signo = TARGET_SIGBUS;
-                si_code = TARGET_BUS_ADRALN;
-                break;
-            default:
-                g_assert_not_reached();
-            }
-            force_sig_fault(si_signo, si_code, env->exception.vaddress);
+            signal_for_exception(env, env->exception.vaddress);
             break;
         case EXCP_DEBUG:
         case EXCP_BKPT:
-- 
2.43.0


