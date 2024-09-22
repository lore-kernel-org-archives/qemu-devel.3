Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6163CF9C64
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2024 12:03:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssLHY-0001D4-LL; Sun, 22 Sep 2024 08:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssLHC-0000uu-Ny
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 08:01:27 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssLHA-0002MP-LX
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 08:01:18 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a8d446adf6eso524919166b.2
 for <qemu-devel@nongnu.org>; Sun, 22 Sep 2024 05:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727006474; x=1727611274; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hTTuFTN4SpA/qH4ebOycoogvffWCXKNqvIzNeO+QMwQ=;
 b=vHhku34GnxnSyDmQWf/7Q+YE2PnyciKyGUCOP5A16Jw9VhwuvwaFn1zdXNaDZnz/ug
 eiws0zveb/IEkhT3jjFTGkbCppDVB/0BI41yUmiZVr/OIKoma58941cAPBZ5YGFxoa26
 uz5efg7Kk1888zH84FAJP7rWxsvjgaEqmFymnwPmYxBTYxyRwMmqJ606KGZ7tZv/Girp
 /Q7emZrB7aAvRT1ugr7K27KAOIxV8g0QPSwIDexogSS3fJLeb0DgpXN7e+Gl8MmBgYmr
 6mH3EDKlKAk1z8rFEIRgFt03O7x5JJ8hHcAi5eKsY02ywOEcR8ku1jh+uC4xHiAwhfI5
 MaMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727006474; x=1727611274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hTTuFTN4SpA/qH4ebOycoogvffWCXKNqvIzNeO+QMwQ=;
 b=sQmXMvTqVxWLvduK3XBKHijqD+KHjoA//GV+K+Oqlcy9HEWlBI8V8UHGyn5jwy/1OM
 41wblApt3DvdX4EL/sjn8eWEC3xHvJ2qHhvGSk/wsVmZNmpF3v6P2q/xYoqQoevkV2xi
 rcs3k0MbF7o9IJGEwMR2/B2aLGqDndyBrsHZEc+qUy9EhspltKyiitCIOiZvMIS1/AnN
 +LoUrKbsPvJ6pLAKI3HK/cbvb3G0uyrwaFnlpjrvx7vIfyjnQvKE9gHij+L2AarSSUpr
 yF9y4nfHMeq+DFcNwKHozLumFi9C7ZXHQMKA7CUGbAeVlbzGOui8BM++2cA3N0f8lYhv
 veqA==
X-Gm-Message-State: AOJu0YxlSI/+QYUX9r2moHNA7zPX1uA0Dk4HEk9SUamATWJ0WUyvkMwn
 Y+imsiem66gwRQAjUV/wGnyYoyafGJ1CLVmdQAmuiIZju6XKnOFxoCKqCBK0SeUwblX/pA+BYRB
 lcLE=
X-Google-Smtp-Source: AGHT+IHAJbq4+V8vpaKPPv7+7SPptHoowoRLLz5rZFeP2xBzXtbuKwLJI3+62bx7L9mE516GwesEeA==
X-Received: by 2002:a17:907:ea2:b0:a8d:1545:f48a with SMTP id
 a640c23a62f3a-a90d5114e8cmr813644866b.61.1727006474113; 
 Sun, 22 Sep 2024 05:01:14 -0700 (PDT)
Received: from stoup.. (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612df525sm1067909966b.159.2024.09.22.05.01.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Sep 2024 05:01:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 01/31] tcg: Return TCGOp from tcg_gen_op[1-6]
Date: Sun, 22 Sep 2024 14:00:42 +0200
Message-ID: <20240922120112.5067-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240922120112.5067-1-richard.henderson@linaro.org>
References: <20240922120112.5067-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62b.google.com
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

TCGOp to be propagated further in the next patch.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-internal.h | 12 ++++++------
 tcg/tcg-op.c       | 23 +++++++++++++++--------
 2 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index 9b0d982f65..d18f49f5d3 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -92,12 +92,12 @@ TCGTemp *tcg_temp_new_internal(TCGType type, TCGTempKind kind);
  */
 TCGTemp *tcg_constant_internal(TCGType type, int64_t val);
 
-void tcg_gen_op1(TCGOpcode, TCGArg);
-void tcg_gen_op2(TCGOpcode, TCGArg, TCGArg);
-void tcg_gen_op3(TCGOpcode, TCGArg, TCGArg, TCGArg);
-void tcg_gen_op4(TCGOpcode, TCGArg, TCGArg, TCGArg, TCGArg);
-void tcg_gen_op5(TCGOpcode, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg);
-void tcg_gen_op6(TCGOpcode, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg);
+TCGOp *tcg_gen_op1(TCGOpcode, TCGArg);
+TCGOp *tcg_gen_op2(TCGOpcode, TCGArg, TCGArg);
+TCGOp *tcg_gen_op3(TCGOpcode, TCGArg, TCGArg, TCGArg);
+TCGOp *tcg_gen_op4(TCGOpcode, TCGArg, TCGArg, TCGArg, TCGArg);
+TCGOp *tcg_gen_op5(TCGOpcode, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg);
+TCGOp *tcg_gen_op6(TCGOpcode, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg);
 
 void vec_gen_2(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg);
 void vec_gen_3(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg, TCGArg);
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index eff3728622..28c41b37a4 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -37,38 +37,43 @@
  */
 #define NI  __attribute__((noinline))
 
-void NI tcg_gen_op1(TCGOpcode opc, TCGArg a1)
+TCGOp * NI tcg_gen_op1(TCGOpcode opc, TCGArg a1)
 {
     TCGOp *op = tcg_emit_op(opc, 1);
     op->args[0] = a1;
+    return op;
 }
 
-void NI tcg_gen_op2(TCGOpcode opc, TCGArg a1, TCGArg a2)
+TCGOp * NI tcg_gen_op2(TCGOpcode opc, TCGArg a1, TCGArg a2)
 {
     TCGOp *op = tcg_emit_op(opc, 2);
     op->args[0] = a1;
     op->args[1] = a2;
+    return op;
 }
 
-void NI tcg_gen_op3(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3)
+TCGOp * NI tcg_gen_op3(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3)
 {
     TCGOp *op = tcg_emit_op(opc, 3);
     op->args[0] = a1;
     op->args[1] = a2;
     op->args[2] = a3;
+    return op;
 }
 
-void NI tcg_gen_op4(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3, TCGArg a4)
+TCGOp * NI tcg_gen_op4(TCGOpcode opc, TCGArg a1, TCGArg a2,
+                       TCGArg a3, TCGArg a4)
 {
     TCGOp *op = tcg_emit_op(opc, 4);
     op->args[0] = a1;
     op->args[1] = a2;
     op->args[2] = a3;
     op->args[3] = a4;
+    return op;
 }
 
-void NI tcg_gen_op5(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3,
-                     TCGArg a4, TCGArg a5)
+TCGOp * NI tcg_gen_op5(TCGOpcode opc, TCGArg a1, TCGArg a2,
+                       TCGArg a3, TCGArg a4, TCGArg a5)
 {
     TCGOp *op = tcg_emit_op(opc, 5);
     op->args[0] = a1;
@@ -76,10 +81,11 @@ void NI tcg_gen_op5(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3,
     op->args[2] = a3;
     op->args[3] = a4;
     op->args[4] = a5;
+    return op;
 }
 
-void NI tcg_gen_op6(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3,
-                     TCGArg a4, TCGArg a5, TCGArg a6)
+TCGOp * NI tcg_gen_op6(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3,
+                       TCGArg a4, TCGArg a5, TCGArg a6)
 {
     TCGOp *op = tcg_emit_op(opc, 6);
     op->args[0] = a1;
@@ -88,6 +94,7 @@ void NI tcg_gen_op6(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3,
     op->args[3] = a4;
     op->args[4] = a5;
     op->args[5] = a6;
+    return op;
 }
 
 /*
-- 
2.43.0


