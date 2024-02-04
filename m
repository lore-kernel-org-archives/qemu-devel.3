Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D9AEC48286
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 21:42:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWkFM-0002Xu-6n; Sun, 04 Feb 2024 16:41:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkFH-0002We-S1
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:47 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkFG-0003Yk-68
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:47 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1d9b2400910so1721385ad.0
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 13:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707082905; x=1707687705; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hIn73/7L0/UvLzTpfBg1BsspTF3e93L6IUnQvuIa2EY=;
 b=ZZR/75q5nFwwSicoFVqm2pu2L2zRUXWXLfK6CoUEVO3Y/QggrGulSm3BunGNN98hAf
 d9wppF0yiBgTh7XNJMKmTo82IVwCWIzImyDG1a8texXDvmaYTfsQquSK1AR+LGonfM5h
 n6f7SiTe+csO1A/BJgh6YXbNyxfyxt8CBkGITTBgoBVlYqeKdL0E9Tq3T/soTjEJa8zC
 WhlccH1LmxuULH9GWhMxvqudkZ1MvVB3Fw4EIvDEbRHk2IqreovTNmxIfkq1+ZX4f+ks
 Jv2u/j8zfSplVq1tF2F78kfkEKbYg5Zo2ZXlPZRRnH457MEOjQf8LTbWMkeKT+688NBk
 V26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707082905; x=1707687705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hIn73/7L0/UvLzTpfBg1BsspTF3e93L6IUnQvuIa2EY=;
 b=QjweXN2nhbIwYCW6uIAns/1PQi6p3wWQUkCXTnTM/0TwZc1ItF/Ryta4dLDhvvc9NA
 MEcu5z376E45qv1CsOHGNOqncNgShdsbcRn9cpMswBfzLLRD7mNYLGrvAR0m5DOro5JY
 F6IpA6+vF+BDz+OlCB3V4zRJ3rzPmjLNf8eE9S4RN6FYhfjrQdJJDI6JSp+qNTgc7Oj8
 Zfdd7YLk+nrpgICV2su8EiSDXHn+kobhLYkPP2ruB1ilYP+yosxEm/LvlaXzV3I2eZiH
 VYe+rcTuLa57S7on0xh0fwy1TmgWBB1HotFtwNS4OLFnJ99L367qQSJTE+wTULMd9rYZ
 kTAQ==
X-Gm-Message-State: AOJu0Yy3qR5/loiQZ0gZscUjsG+4xfzFLGsiUOy05wCFqEXxEySaKWki
 OXsEkGSvoGqo3yE2J2DYDBHBt7MOJZXv3DzBN9oCFb2617ObNVSunCoL10EaW7pGH6dAcvWSURK
 QEkk=
X-Google-Smtp-Source: AGHT+IElh91oqVueosTk5QSh5C4vECOE4Jevi+HwVqSL8faNPvLJBYq5RUyXJTE1CK1vM9l0FvM+Ew==
X-Received: by 2002:a17:903:234b:b0:1d8:ff72:eef8 with SMTP id
 c11-20020a170903234b00b001d8ff72eef8mr7029712plh.18.1707082904974; 
 Sun, 04 Feb 2024 13:41:44 -0800 (PST)
Received: from stoup.. ([43.252.112.156]) by smtp.gmail.com with ESMTPSA id
 mf11-20020a170902fc8b00b001d8f5560503sm4953670plb.222.2024.02.04.13.41.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 13:41:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 23/39] tcg/i386: Pass x86 condition codes to tcg_out_cmov
Date: Mon,  5 Feb 2024 07:40:36 +1000
Message-Id: <20240204214052.5639-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240204214052.5639-1-richard.henderson@linaro.org>
References: <20240204214052.5639-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hoist the tcg_cond_to_jcc index outside the function.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index accaaa2660..2d6100a8f4 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1699,14 +1699,14 @@ static void tcg_out_setcond2(TCGContext *s, const TCGArg *args,
 }
 #endif
 
-static void tcg_out_cmov(TCGContext *s, TCGCond cond, int rexw,
+static void tcg_out_cmov(TCGContext *s, int jcc, int rexw,
                          TCGReg dest, TCGReg v1)
 {
     if (have_cmov) {
-        tcg_out_modrm(s, OPC_CMOVCC | tcg_cond_to_jcc[cond] | rexw, dest, v1);
+        tcg_out_modrm(s, OPC_CMOVCC | jcc | rexw, dest, v1);
     } else {
         TCGLabel *over = gen_new_label();
-        tcg_out_jxx(s, tcg_cond_to_jcc[tcg_invert_cond(cond)], over, 1);
+        tcg_out_jxx(s, jcc ^ 1, over, 1);
         tcg_out_mov(s, TCG_TYPE_I32, dest, v1);
         tcg_out_label(s, over);
     }
@@ -1717,7 +1717,7 @@ static void tcg_out_movcond(TCGContext *s, int rexw, TCGCond cond,
                             TCGReg v1)
 {
     tcg_out_cmp(s, c1, c2, const_c2, rexw);
-    tcg_out_cmov(s, cond, rexw, dest, v1);
+    tcg_out_cmov(s, tcg_cond_to_jcc[cond], rexw, dest, v1);
 }
 
 static void tcg_out_ctz(TCGContext *s, int rexw, TCGReg dest, TCGReg arg1,
@@ -1729,12 +1729,12 @@ static void tcg_out_ctz(TCGContext *s, int rexw, TCGReg dest, TCGReg arg1,
             tcg_debug_assert(arg2 == (rexw ? 64 : 32));
         } else {
             tcg_debug_assert(dest != arg2);
-            tcg_out_cmov(s, TCG_COND_LTU, rexw, dest, arg2);
+            tcg_out_cmov(s, JCC_JB, rexw, dest, arg2);
         }
     } else {
         tcg_debug_assert(dest != arg2);
         tcg_out_modrm(s, OPC_BSF + rexw, dest, arg1);
-        tcg_out_cmov(s, TCG_COND_EQ, rexw, dest, arg2);
+        tcg_out_cmov(s, JCC_JE, rexw, dest, arg2);
     }
 }
 
@@ -1747,7 +1747,7 @@ static void tcg_out_clz(TCGContext *s, int rexw, TCGReg dest, TCGReg arg1,
             tcg_debug_assert(arg2 == (rexw ? 64 : 32));
         } else {
             tcg_debug_assert(dest != arg2);
-            tcg_out_cmov(s, TCG_COND_LTU, rexw, dest, arg2);
+            tcg_out_cmov(s, JCC_JB, rexw, dest, arg2);
         }
     } else {
         tcg_debug_assert(!const_a2);
@@ -1760,7 +1760,7 @@ static void tcg_out_clz(TCGContext *s, int rexw, TCGReg dest, TCGReg arg1,
 
         /* Since we have destroyed the flags from BSR, we have to re-test.  */
         tcg_out_cmp(s, arg1, 0, 1, rexw);
-        tcg_out_cmov(s, TCG_COND_EQ, rexw, dest, arg2);
+        tcg_out_cmov(s, JCC_JE, rexw, dest, arg2);
     }
 }
 
-- 
2.34.1


