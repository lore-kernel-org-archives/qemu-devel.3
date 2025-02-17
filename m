Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1018AC021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 19:34:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk6pa-0002CY-3O; Mon, 17 Feb 2025 14:31:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6ou-0001uD-R1
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:22 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6oq-0008I9-1b
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:18 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-220e6028214so75943245ad.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 11:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739820613; x=1740425413; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CoSz+0yLhVK3dbyvfDxsdAZSwsgZvLHw47U3xK2XgEE=;
 b=DiD6SrzGktzOiJznQQL1Soh4UqqMB1xL3FQw/v6xhjL0aBPGMg6A/ox4CaofNSxjnz
 viac39LzLiPFWafDjgJYizmAnLoXCQ0w9fd42ov8h3RHjGu3A0ioyAsR5V8aQ7XhfurR
 KLNlK13MP48CO2eT+4QSVsZAVA4YwpndbE3Zbo4kBF7Pr8yvW01x7GKT2g2oGie9Ev6B
 /7W/rOytXMt1Ia2yHmMrq7gRU0nj5CTWDS+0rkZlHSkw6KMUeYnN2/YDDVWfpvw2yvtJ
 kQoD1dsQGPAi7qSAwqgwbAI2c8vOh2JiAr+hg+MVNJ/BMcO8R9XBqhI07655SdpN4Q8o
 n0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739820613; x=1740425413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CoSz+0yLhVK3dbyvfDxsdAZSwsgZvLHw47U3xK2XgEE=;
 b=qV6TUNEWu6SIcfgdwETKXe71w1y+pa+k0GufGcuzpinw87AkHysaEQmxhrkW0xTVXa
 Sea7NUCUWf4lP6ubjYrbLucY6r4l/2m9EnQUeM1jk8zioIe52l7vBZO8wXXbnuj27b3V
 2H6BEM2R7QO4BwJtD007NHHX6krapSLImROn6ZFcP1wK3BIu4lia/UHJudnGvIXcTb2y
 08iGo1Emg01AF501DZbn4bOsd0vm+a1nijXMQ3R68E+o3m7gImFBlXnjtyWX4L56k/4p
 ywhq5/rpB0NT/AdoRZrowp9wYYgtcO0PG5TqakNu/S/ST4nPrpH7P1QC/QUJL/tnXDkB
 Oqug==
X-Gm-Message-State: AOJu0Ywz2HmIYNMRQ+wR7L+qdbTzCLFzUVkAdvamqi2zQjqctFWIiWHI
 k/WvMJkcqDpedOiEnxDZF9iarf9dmITxMNlvxutBrPIONB7XSyjZnMme60z2fBjlX/v5fMjBqZf
 J
X-Gm-Gg: ASbGnct3ebTJKycu1KjrUvQuypdrQxHzu14ZJgo7voisubUT37gobgAjEftt4Q3aZmh
 dyhNeqANa+5yzXF3BicH4svphZvVsh8RJyXhOD9xzeDj1MCgb6Z7cSp/5tBmWTeo9l5SOcatcXG
 nqgJwY8P52HmigyYJcZ44Cc93K7eZzTLxv/TJ/1TQQRhavsx1vy+1kSsW7jmOIAiRGA1fvavgU3
 ME0wL53+OP55pPe5sTshT4XUxjK7am/HeOMqwFkeSr8wsN4SgWVur4zLaLrpPt96UcKlm0hBP5e
 KLMSK+5/8YDiT+QMLrapjHhH9zBrM/hN457UYRsGWNFxMo0=
X-Google-Smtp-Source: AGHT+IEQXiO90AqAnghkhW5ubAGjaT4AbcUesjHkuzGwbTHfPshSM7019osp70VmEHHqNQqWD+Ao+g==
X-Received: by 2002:a05:6a21:6da7:b0:1ee:5d05:a18f with SMTP id
 adf61e73a8af0-1ee8cc25a7cmr19924143637.35.1739820612937; 
 Mon, 17 Feb 2025 11:30:12 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7326a38ff76sm4347164b3a.160.2025.02.17.11.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 11:30:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 03/27] tcg: Drop support for two address registers in
 gen_ldst
Date: Mon, 17 Feb 2025 11:29:44 -0800
Message-ID: <20250217193009.2873875-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217193009.2873875-1-richard.henderson@linaro.org>
References: <20250217193009.2873875-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-ldst.c | 21 +++------------------
 tcg/tcg.c         |  4 +---
 2 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index 77271e0193..7ba9a3ef7e 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -91,25 +91,10 @@ static MemOp tcg_canonicalize_memop(MemOp op, bool is64, bool st)
 static void gen_ldst(TCGOpcode opc, TCGType type, TCGTemp *vl, TCGTemp *vh,
                      TCGTemp *addr, MemOpIdx oi)
 {
-    if (TCG_TARGET_REG_BITS == 64 || tcg_ctx->addr_type == TCG_TYPE_I32) {
-        if (vh) {
-            tcg_gen_op4(opc, type, temp_arg(vl), temp_arg(vh),
-                        temp_arg(addr), oi);
-        } else {
-            tcg_gen_op3(opc, type, temp_arg(vl), temp_arg(addr), oi);
-        }
+    if (vh) {
+        tcg_gen_op4(opc, type, temp_arg(vl), temp_arg(vh), temp_arg(addr), oi);
     } else {
-        /* See TCGV_LOW/HIGH. */
-        TCGTemp *al = addr + HOST_BIG_ENDIAN;
-        TCGTemp *ah = addr + !HOST_BIG_ENDIAN;
-
-        if (vh) {
-            tcg_gen_op5(opc, type, temp_arg(vl), temp_arg(vh),
-                        temp_arg(al), temp_arg(ah), oi);
-        } else {
-            tcg_gen_op4(opc, type, temp_arg(vl),
-                        temp_arg(al), temp_arg(ah), oi);
-        }
+        tcg_gen_op3(opc, type, temp_arg(vl), temp_arg(addr), oi);
     }
 }
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 53de13df71..14c2d38160 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1690,9 +1690,7 @@ void tcg_func_start(TCGContext *s)
     s->emit_before_op = NULL;
     QSIMPLEQ_INIT(&s->labels);
 
-    tcg_debug_assert(s->addr_type == TCG_TYPE_I32 ||
-                     s->addr_type == TCG_TYPE_I64);
-
+    tcg_debug_assert(s->addr_type <= TCG_TYPE_REG);
     tcg_debug_assert(s->insn_start_words > 0);
 }
 
-- 
2.43.0


