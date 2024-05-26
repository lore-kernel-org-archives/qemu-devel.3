Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F4CC41513
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 19:45:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBJll-0008Aw-VN; Sun, 26 May 2024 15:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJlk-00089q-5V
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:00 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJli-0007cc-C7
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:42:59 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1f47f0d8ec9so6124565ad.3
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 12:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716752577; x=1717357377; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9GjOknDfw6CA/cxmtAArnOVpVQknG/Iz5WJ6byoYh9I=;
 b=fHj1fi10z9afJk+niE4Tr1g69sFWAwxo4M/rzWfvRNDicgudvjBu58iubavjzUQrc6
 bQw7XXQ3VBE1xGH4Z0Zeftxs1CprM2BhIMT/XzCfzkrfKtgknXCsQQWybiRfLUGI8AjF
 MnWUc4X0zS0nec4Rct7ipssmq3aSQKUWov+AOxyTIotmn4YQx+gaIHbJ8mFA+bfWB64W
 TXQKrqzKgD4lcZZZk2BjbtmdY4QZbKB12uUT9dyxTuZYC+TY2mcqy0RuZh6szfYnNuox
 y0RGvFRLN5j1Rniwd5/aLO8LHPsiJXip8TxzQ4oyQliWx+R8bM9fls63RfvRg/amRtuo
 i9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716752577; x=1717357377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9GjOknDfw6CA/cxmtAArnOVpVQknG/Iz5WJ6byoYh9I=;
 b=LZsuo5kUaCiA+hRqHGranEq7+Kb3Xhc0hNj9hYlpMJ60z8FHQRVvemvoP6nsXhcc8F
 3JjSxJaO1hQVa9sui92dargV5f47zhVtqBlZ5mdtyGIz6kII66TtRg9odl7tyJ8yGl/M
 /srnSz7TaJyajWI6WTkCWTackVOM6ih8YW+F6CPmn7ZeLRf+zJQUvdJQ+CNb2Cqmr+z8
 hPeYi4zrYEOqDWPEOTwF3aO+1Hdp3T/kou0a5dApk3tgGiuqp3ezWT5hgIRJOOcQcnVW
 IUaFt2gsv9TfE6JIE+RV8zv4DAdHxPzz+d+nJCDxPzMHGqPX4yPH623Vi22SNcpWC3I6
 D1jQ==
X-Gm-Message-State: AOJu0Yyzwv9fhrIERnDXS5VF/hf0K0W3p1kESZIL1VR4eRZhYFVZFgHH
 C7m1aQrpUNWF5iOHkdeX1qnebMshXg30nG1LAZbQa0YcCiJrqYWEUG6OJVPncFz7YXiL4mXP9rC
 x
X-Google-Smtp-Source: AGHT+IEsRGohjHX8Df/j+T2Roo3PFyAPDP27dNMKXytRDC86w5WqyYEKkmdPec4tH354ZHticb4SWg==
X-Received: by 2002:a17:902:fa46:b0:1f3:4232:76df with SMTP id
 d9443c01a7336-1f4487400b4mr66133285ad.36.1716752577046; 
 Sun, 26 May 2024 12:42:57 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f46ad93c2esm28165935ad.263.2024.05.26.12.42.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 12:42:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 02/37] target/sparc: Rewrite gen_edge
Date: Sun, 26 May 2024 12:42:19 -0700
Message-Id: <20240526194254.459395-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240526194254.459395-1-richard.henderson@linaro.org>
References: <20240526194254.459395-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Drop the tables and compute the left and right edges directly.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 98 +++++++++++++++-------------------------
 1 file changed, 37 insertions(+), 61 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index dca072888a..00c2a11353 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -3519,11 +3519,10 @@ static bool trans_SDIVX(DisasContext *dc, arg_r_r_ri *a)
 }
 
 static bool gen_edge(DisasContext *dc, arg_r_r_r *a,
-                     int width, bool cc, bool left)
+                     int width, bool cc, bool little_endian)
 {
-    TCGv dst, s1, s2, lo1, lo2;
-    uint64_t amask, tabl, tabr;
-    int shift, imask, omask;
+    TCGv dst, s1, s2, l, r, t, m;
+    uint64_t amask = address_mask_i(dc, -8);
 
     dst = gen_dest_gpr(dc, a->rd);
     s1 = gen_load_gpr(dc, a->rs1);
@@ -3533,75 +3532,52 @@ static bool gen_edge(DisasContext *dc, arg_r_r_r *a,
         gen_op_subcc(cpu_cc_N, s1, s2);
     }
 
-    /*
-     * Theory of operation: there are two tables, left and right (not to
-     * be confused with the left and right versions of the opcode).  These
-     * are indexed by the low 3 bits of the inputs.  To make things "easy",
-     * these tables are loaded into two constants, TABL and TABR below.
-     * The operation index = (input & imask) << shift calculates the index
-     * into the constant, while val = (table >> index) & omask calculates
-     * the value we're looking for.
-     */
+    l = tcg_temp_new();
+    r = tcg_temp_new();
+    t = tcg_temp_new();
+
     switch (width) {
     case 8:
-        imask = 0x7;
-        shift = 3;
-        omask = 0xff;
-        if (left) {
-            tabl = 0x80c0e0f0f8fcfeffULL;
-            tabr = 0xff7f3f1f0f070301ULL;
-        } else {
-            tabl = 0x0103070f1f3f7fffULL;
-            tabr = 0xfffefcf8f0e0c080ULL;
-        }
+        tcg_gen_andi_tl(l, s1, 7);
+        tcg_gen_andi_tl(r, s2, 7);
+        tcg_gen_xori_tl(r, r, 7);
+        m = tcg_constant_tl(0xff);
         break;
     case 16:
-        imask = 0x6;
-        shift = 1;
-        omask = 0xf;
-        if (left) {
-            tabl = 0x8cef;
-            tabr = 0xf731;
-        } else {
-            tabl = 0x137f;
-            tabr = 0xfec8;
-        }
+        tcg_gen_extract_tl(l, s1, 1, 2);
+        tcg_gen_extract_tl(r, s2, 1, 2);
+        tcg_gen_xori_tl(r, r, 3);
+        m = tcg_constant_tl(0xf);
         break;
     case 32:
-        imask = 0x4;
-        shift = 0;
-        omask = 0x3;
-        if (left) {
-            tabl = (2 << 2) | 3;
-            tabr = (3 << 2) | 1;
-        } else {
-            tabl = (1 << 2) | 3;
-            tabr = (3 << 2) | 2;
-        }
+        tcg_gen_extract_tl(l, s1, 2, 1);
+        tcg_gen_extract_tl(r, s2, 2, 1);
+        tcg_gen_xori_tl(r, r, 1);
+        m = tcg_constant_tl(0x3);
         break;
     default:
         abort();
     }
 
-    lo1 = tcg_temp_new();
-    lo2 = tcg_temp_new();
-    tcg_gen_andi_tl(lo1, s1, imask);
-    tcg_gen_andi_tl(lo2, s2, imask);
-    tcg_gen_shli_tl(lo1, lo1, shift);
-    tcg_gen_shli_tl(lo2, lo2, shift);
+    /* Compute Left Edge */
+    if (little_endian) {
+        tcg_gen_shl_tl(l, m, l);
+        tcg_gen_and_tl(l, l, m);
+    } else {
+        tcg_gen_shr_tl(l, m, l);
+    }
+    /* Compute Right Edge */
+    if (little_endian) {
+        tcg_gen_shr_tl(r, m, r);
+    } else {
+        tcg_gen_shl_tl(r, m, r);
+        tcg_gen_and_tl(r, r, m);
+    }
 
-    tcg_gen_shr_tl(lo1, tcg_constant_tl(tabl), lo1);
-    tcg_gen_shr_tl(lo2, tcg_constant_tl(tabr), lo2);
-    tcg_gen_andi_tl(lo1, lo1, omask);
-    tcg_gen_andi_tl(lo2, lo2, omask);
-
-    amask = address_mask_i(dc, -8);
-    tcg_gen_andi_tl(s1, s1, amask);
-    tcg_gen_andi_tl(s2, s2, amask);
-
-    /* Compute dst = (s1 == s2 ? lo1 : lo1 & lo2). */
-    tcg_gen_and_tl(lo2, lo2, lo1);
-    tcg_gen_movcond_tl(TCG_COND_EQ, dst, s1, s2, lo1, lo2);
+    /* Compute dst = (s1 == s2 under amask ? l : l & r) */
+    tcg_gen_xor_tl(t, s1, s2);
+    tcg_gen_and_tl(r, r, l);
+    tcg_gen_movcond_tl(TCG_COND_TSTEQ, dst, t, tcg_constant_tl(amask), r, l);
 
     gen_store_gpr(dc, a->rd, dst);
     return advance_pc(dc);
-- 
2.34.1


