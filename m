Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78031D25031
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 22:00:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf3SV-0005Lf-Ca; Sun, 11 Jan 2026 16:58:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vf3SK-0005KZ-5G
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 16:58:40 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vf3SH-0003r3-PF
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 16:58:39 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2a137692691so38701545ad.0
 for <qemu-devel@nongnu.org>; Sun, 11 Jan 2026 13:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768168716; x=1768773516; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BpSHIWQQ8x9eIJTo+o+MCuWeunb6JYZPGxKktINRqfc=;
 b=p8nEEVwO4ezk+DgcFbpPQCBGCXiz44+3u7S9KB1t73JfYXv0qorJg5nP0/rW6pkNBX
 CqP/Jad/OeOr4d4w0sWc4BDBbX6//R2R++mjaBZag1f1TADjbV7cr/IG9UH/IZaGBvzz
 LQ28hreESnXjH6Tzr1B0Fy4/oo47XGWNChD4BbIyBjOVK13twqBEmS2i9beL5twWMky7
 bJDXL2LeZVOiE/qnFuBlzlPBQBIa9tEf65ywIG92uCv/Eo2AXV2yw7zspyOi0XdYqhLp
 sL84yccZHOldfb5yz+mlVvYT4Nwnbq3T0WdiqFratIGZgtovQvXgy5w3cu2ZGHFIaImn
 Jk7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768168716; x=1768773516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BpSHIWQQ8x9eIJTo+o+MCuWeunb6JYZPGxKktINRqfc=;
 b=TMYdtyn60lx3CGXZGQ8y72oQ1/9F9dRx4pKwFvurqMLwmyyvoTxzkmeOGohn+xYSp/
 r9Ls6XEV1QzfVRJ9WcGTLNBHgTg91JVL2yduw7rwQyLp0ngxGX/VAaCLEh6B4VYaPMKV
 eBlFnVtmrr1r1EhoqwrOExYAA8E+7r7g4tBorvW7guLM6ypYOQbCTm/LMVN1IrPr4wFW
 gdhbD5zbliIYTxOf8y3OtvNHhV0TI7ITyMVMERmh0OcWI2j8j6U5+sSf0mW7GUT0ohei
 lZmCYTJVnSRQA35nT2pVB0fp83gkClHeANd+iPjjzv9UBd5V/KCICB9O9pkH339EdKHq
 r0qQ==
X-Gm-Message-State: AOJu0YxGcR677N3e/wCKEMsaRLR8XaUHw7M+Xc6B5morU+004+jOYRHe
 wqHaC3gmPM53oRN965JNBtAAbxtyZmX8UKUVmxUYKjt9T8Z7E6woIfXh/RvW7ny3Ie6INyzVI8d
 CFMVkDJw=
X-Gm-Gg: AY/fxX7jKx/Q2moC8/NcmjJBBHEpwM8r2roJ45Kp+yfCRgoaoRN9x8lUmOGgILraovw
 1zA5Cm4GMuO53xe7MngYF9M+RPAlhL2IQUqTFLQORLc3ffyMay0tNF+sHX8AeFELID4q6FqKoiu
 7mbJJsuqUaNB6FHGS6HkHDwCfbs0Pxst8JTkiAbnHWv/SCIISrjDLQcvqLafMTwjXgRw1y8q9ip
 gCKNT1QvShIUHNE4r38FoSMVPjVeZ4aHJYnA31xnqvuIBm/wRCn52ZKYU2SUzp+Hvalico32A2o
 xMPSpRdzeaiqhQrkRjoBPEYbAArvyIdfzTDL5F7YpbzcbcqQTB0qqincInYPISz4cUjGDc4/V3j
 6lHlYShSKTrKzM7kIU3ogWoAYlflGLmoXw05DOuwW5g7VgxjemHyHp9hANaMDzOJjmNXFeVEchc
 MOBpYZw/XI+vtvAJs=
X-Google-Smtp-Source: AGHT+IGNt+0Jl8uu3qyE0YRsm6P47B95trxtelKxi6ARj3ce/EmytsjH4kQee5bpvnx4iaua8+Iaxg==
X-Received: by 2002:a17:902:f68e:b0:2a0:941a:6b08 with SMTP id
 d9443c01a7336-2a3ee47d754mr162761725ad.21.1768168716353; 
 Sun, 11 Jan 2026 13:58:36 -0800 (PST)
Received: from stoup.. ([202.86.209.61]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c3a31dsm155272365ad.9.2026.01.11.13.58.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jan 2026 13:58:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Zhijin Zeng <zengzhijin@linux.spacemit.com>
Subject: [PULL 04/13] tcg/riscv: Fix TCG_REG_TMP0 clobber in tcg_gen_dup{m,i}
Date: Mon, 12 Jan 2026 08:58:09 +1100
Message-ID: <20260111215819.569209-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260111215819.569209-1-richard.henderson@linaro.org>
References: <20260111215819.569209-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

TCG_REG_TMP0 may be used by set_vtype* to load the vtype
parameter, so delay any other use of TCG_REG_TMP0 until
the correct vtype has been installed.

Cc: qemu-stable@nongnu.org
Fixes: d4be6ee1111 ("tcg/riscv: Implement vector mov/dup{m/i}")
Reported-by: Zhijin Zeng <zengzhijin@linux.spacemit.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target.c.inc | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 31b9f7d87a..0967a445a3 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -1074,7 +1074,7 @@ static bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
 }
 
 static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
-                                   TCGReg dst, TCGReg src)
+                            TCGReg dst, TCGReg src)
 {
     set_vtype_len_sew(s, type, vece);
     tcg_out_opc_vx(s, OPC_VMV_V_X, dst, 0, src);
@@ -1082,29 +1082,34 @@ static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
 }
 
 static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
-                                    TCGReg dst, TCGReg base, intptr_t offset)
+                             TCGReg dst, TCGReg base, intptr_t offset)
 {
+    /* Note set_vtype* may clobber TMP0, so do that first. */
+    set_vtype_len_sew(s, type, vece);
     tcg_out_ld(s, TCG_TYPE_REG, TCG_REG_TMP0, base, offset);
-    return tcg_out_dup_vec(s, type, vece, dst, TCG_REG_TMP0);
+    tcg_out_opc_vx(s, OPC_VMV_V_X, dst, 0, TCG_REG_TMP0);
+    return true;
 }
 
 static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
-                                    TCGReg dst, int64_t arg)
+                             TCGReg dst, int64_t arg)
 {
     /* Arg is replicated by VECE; extract the highest element. */
     arg >>= (-8 << vece) & 63;
 
-    if (arg >= -16 && arg < 16) {
-        if (arg == 0 || arg == -1) {
-            set_vtype_len(s, type);
-        } else {
-            set_vtype_len_sew(s, type, vece);
-        }
-        tcg_out_opc_vi(s, OPC_VMV_V_I, dst, 0, arg);
-        return;
+    /* Note set_vtype* may clobber TMP0, so do that first. */
+    if (arg == 0 || arg == -1) {
+        set_vtype_len(s, type);
+    } else {
+        set_vtype_len_sew(s, type, vece);
+    }
+
+    if (arg >= -16 && arg < 16) {
+        tcg_out_opc_vi(s, OPC_VMV_V_I, dst, 0, arg);
+    } else {
+        tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_TMP0, arg);
+        tcg_out_opc_vx(s, OPC_VMV_V_X, dst, 0, TCG_REG_TMP0);
     }
-    tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_TMP0, arg);
-    tcg_out_dup_vec(s, type, vece, dst, TCG_REG_TMP0);
 }
 
 static void tcg_out_br(TCGContext *s, TCGLabel *l)
-- 
2.43.0


