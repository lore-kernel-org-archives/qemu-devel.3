Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63672C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 20:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mCN-0002Tn-SI; Tue, 15 Apr 2025 15:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m5o-00005M-Bc
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:37:18 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m54-0004X4-4N
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:37:11 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22409077c06so78939805ad.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745772; x=1745350572; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XpMdeCbNzg3JmqdW1xzLz7fjwZKDUFJmzeS0cLmNFrg=;
 b=c2VMoHmGfHf7T13gqTxsPCvoxvgmT3AyZevIYMxR+mm7496AEx2wtBg8cCdfmTtqrV
 p+llFDV87nqNwZpmnZpuUKBsRR57yO60y33pu2+K6eUFMZ//ivsXyGdJVAjlzoM5dLBm
 PlrxsFT+YTKv++g9WSKsBP7nj3dSOEll8S3RU6NLM3OU6VBvliCT4E1ESrRpP0/QJKLe
 o/8fkxhlPe86W/ZhI91t9K1ZAo1WaLRXpzIe+4aAOzRBxanxi9LAuNINpm3YKVk43ID9
 q9LQ4poMtfk4KwSERgROSy7dQayak3B8HjGZAj6pI19mrkSdiLO+4eJ5dt9mYeotyhQA
 CLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745772; x=1745350572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XpMdeCbNzg3JmqdW1xzLz7fjwZKDUFJmzeS0cLmNFrg=;
 b=RZ7xfKK5xFePJAtbLnPYSi1P9Zfib8ctwzg5x9UMCogqNpOK/2iPLIDPYdEGJi9kiR
 wl3SOJx8308vpZw52g6W9zD77L6Foc95NTwHV71Tcp15mWCLUClrZRk309ziN2nhhazu
 Qh8RBh5CfzZsZbp7mqD53ZfqkiZS7dnmhJ6qCb6dpYgQVsCxHKYujj9PL63Nfy9VrwTZ
 dVpZGGkM5fEJznqgYT9JVvnzV3ZnhYZjf0LCUKDnb4Xi7N6rE+Rk83nni6OyCLRIle8D
 7VNYI9HJE4Ue/mzGjR2IBcKkwMyn+6W3MZV2ewmPyJayPzAzTEldB1DTtFncOpkwH1v5
 TQTQ==
X-Gm-Message-State: AOJu0YwylIEMewt+KS94CKNJSG56oTm35++tFXwIC9i6CnqCXw0JDO0u
 BRfw+OFoX3u9D09PnWp9yp3ffHGqRMsboRrjOtVEA9Nb2GEBwT4KwmaPt5So0SGW8FoVBPdqcfG
 Q
X-Gm-Gg: ASbGncvEFHHokFQ3l79JoW2VMLa9RS0WUICnUHk+Q0D4cTl4EcXF97MTdsi9uheAwob
 3Er8WgyGxqmZh5C6oVlO6+/nHabF3I5NIxyHGyKRxUcf4htX6J5SYcOGyjEBkus2CzUqlDmUl05
 EKNfCxJFpcx/HfG5y9m3ERvHOuAkB1/jaFdxBI6s3Lf23HpFob3TUFeOn6MOxv0K3PW7ICuzAOy
 y+zTZSRcFdCd19dht4Hpva5u+IILliI4J0ZSvsBijVsGyjnlHQrU8t9bGRlwp8fKZzetZXhaD8J
 b1lwXwd1q+wOcOnPLCAbVjgzu/dGPQ10r/sTres/Ckc8slUdUbMC0R++cLT6vYSpPg7utv+/q/Y
 =
X-Google-Smtp-Source: AGHT+IHAeeERESPw4b8TRCrG5hRyAijao2ZeOGTOECrZYLSGMbJP7wp9bfKqC1tB852clbMJSaFgUg==
X-Received: by 2002:a17:902:d492:b0:224:2717:7993 with SMTP id
 d9443c01a7336-22c31aba252mr3999325ad.45.1744745771916; 
 Tue, 15 Apr 2025 12:36:11 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230e34asm9155603b3a.137.2025.04.15.12.36.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:36:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 139/163] tcg/s390x: Honor carry_live in tcg_out_movi
Date: Tue, 15 Apr 2025 12:24:50 -0700
Message-ID: <20250415192515.232910-140-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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


