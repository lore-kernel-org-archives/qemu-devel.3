Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABF5C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:40:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8RBf-0006BJ-JT; Fri, 25 Apr 2025 18:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RAz-0003iQ-F3
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:45 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RAx-0001sX-JD
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:41 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-736b34a71a1so3233064b3a.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618738; x=1746223538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N73pKoDb0INGlWZ/JQrCEp9VeW0cZzon0oiZFLZTLc8=;
 b=QRV49gNUZE3fK9nsQr7fnZnMPRduHigfZztLYU+dlaai4rkeYHvoQ/oSGKts+RfxgV
 JVuxVg/bPPdUtlGkOywaWmbV3ZFaOBg4ilYdTNDC40JAAUXIKTpIrOt9JUS4FRTSBXeE
 nyaPyeYSbcWAs9CBJYDnK8nGYgIt2+0/YEvOb4v3r60Xx9AaqGbxR2OWnIldZMGe0vmf
 dqrRn6JrqSOo2EQBu4HIefAXAPj+T+NlsBQXMuiipRcgfHvLn42s1tnPl8wXvoH1yZ36
 56JAjAyotVAyD+kcrSQf7TAlkU7Rfg9F07OLywwNDcH/P75yoBkWHlgRruVaP8AGxZba
 /oVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618738; x=1746223538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N73pKoDb0INGlWZ/JQrCEp9VeW0cZzon0oiZFLZTLc8=;
 b=pBeklfr9vludBKyTdoxJMRXtPic3FJqLWrjq2eJcXuYc7mNGcnZohrHEWHZGLDefKj
 7GW7l5n1XW+0stvUSk1Qs/8g4Zl9q6SzdxO88PEfCTJjxacUfa5oIcY4v/bYU8+8zCR1
 jf19T2kcx85V4+PIpS7OxHcsj9/UbtjbzRgjgDS/vjbU7EwZGyYRCLu7dCSWnXFTwJnc
 sTTiBxN/EYdQSdCwm3NTEMGd2Vm1OpOW7OMikhdYyhwdCvxRD2mx1lTmguW4lIBWnBHE
 HD/MGBc0xqGLbr4PMSMQEJBdwCr7z6q9p8EaXMKTiLP3P3/QKAEv7Sjo8paV8krSPqdn
 dt4w==
X-Gm-Message-State: AOJu0YzucEsmEGqrTZR1NWEhlPORUXWScMu8wG54XgOruNnVAReZDRZW
 LUGapdBhnkvPAShUtEyBYO91yLmOwu/ZrgUFhfZNYUqAajmabp8qARTZmt1f/Utqs0dbWS7JMMN
 k
X-Gm-Gg: ASbGncvIeqFqiJ22jhZ2TvHS5lGY5MM60FM3jbODvuGybK/xCcblPObnBx3wfSN3fdZ
 1G0LB0SPLjOR4BEBUFCVTI9c5XGXOrivsavOQY3R9BkX82l6wmERS0m4WPRVCszT11J9jdZqZUV
 VH+nJQJd5fTz8fMZWgKC0BU2xdoiuyRUkqWGku78Bj+0aotjgz+V6JJZmUz5+HYM6FRneaTGfqa
 F3snchrS0qPUgULvIGWXdug0trDv6BcTsyrKK8sR69/DLlNSymDVCv6I8Q2cxq69++ZrcNGADQ3
 84PdF7BTNWx1BtTcvcRU+pyO2ZzjPFiVVXz7VAQDCxYT0SZ3GYnMzNhbOSrUT4hO51GPWSgY1zw
 =
X-Google-Smtp-Source: AGHT+IFmdKHmKnBsZHEfEu2rBYijESuydocNeY9mvTXCvC9esPXmEORf5lfuWBr6pkCQpVRXt+qUXg==
X-Received: by 2002:a05:6a00:4b03:b0:736:34a2:8a18 with SMTP id
 d2e1a72fcca58-73ff73f4b0bmr1668892b3a.24.1745618737602; 
 Fri, 25 Apr 2025 15:05:37 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a49esm3796573b3a.106.2025.04.25.15.05.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:05:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 139/159] tcg/s390x: Honor carry_live in tcg_out_movi
Date: Fri, 25 Apr 2025 14:54:33 -0700
Message-ID: <20250425215454.886111-140-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

Do not clobber flags if they're live.  Required in order
to perform register allocation on add/sub carry opcodes.
LA and AGHI are the same size, so use LA unconditionally.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/s390x/tcg-target.c.inc | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index a30afb455e..e262876614 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -951,25 +951,32 @@ static void tcg_out_movi(TCGContext *s, TCGType type,
     if (pc_off == (int32_t)pc_off) {
         tcg_out_insn(s, RIL, LARL, ret, pc_off);
         if (sval & 1) {
-            tcg_out_insn(s, RI, AGHI, ret, 1);
+            tcg_out_insn(s, RX, LA, ret, ret, TCG_REG_NONE, 1);
         }
         return;
     }
 
-    /* Otherwise, load it by parts. */
-    i = is_const_p16((uint32_t)uval);
-    if (i >= 0) {
-        tcg_out_insn_RI(s, li_insns[i], ret, uval >> (i * 16));
-    } else {
-        tcg_out_insn(s, RIL, LLILF, ret, uval);
-    }
-    uval >>= 32;
-    i = is_const_p16(uval);
-    if (i >= 0) {
-        tcg_out_insn_RI(s, oi_insns[i + 2], ret, uval >> (i * 16));
-    } else {
-        tcg_out_insn(s, RIL, OIHF, ret, uval);
+    if (!s->carry_live) {
+        /* Load by parts, at most 2 instructions. */
+        i = is_const_p16((uint32_t)uval);
+        if (i >= 0) {
+            tcg_out_insn_RI(s, li_insns[i], ret, uval >> (i * 16));
+        } else {
+            tcg_out_insn(s, RIL, LLILF, ret, uval);
+        }
+        uval >>= 32;
+        i = is_const_p16(uval);
+        if (i >= 0) {
+            tcg_out_insn_RI(s, oi_insns[i + 2], ret, uval >> (i * 16));
+        } else {
+            tcg_out_insn(s, RIL, OIHF, ret, uval);
+        }
+        return;
     }
+
+    /* Otherwise, stuff it in the constant pool.  */
+    tcg_out_insn(s, RIL, LGRL, ret, 0);
+    new_pool_label(s, sval, R_390_PC32DBL, s->code_ptr - 2, 2);
 }
 
 /* Emit a load/store type instruction.  Inputs are:
-- 
2.43.0


