Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB46E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPbf-00079k-W9; Thu, 02 Jan 2025 13:07:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbN-00070h-KL
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:24 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbM-0005B2-4Y
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:21 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2163dc5155fso155963215ad.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841239; x=1736446039; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sgVoWtpK77rxg1O2HQrgvJBz3K4KKWV6yZyPELMF82w=;
 b=SWCBWjXpdBDRPmCCNtlFLb3qcwSVCaMe2Hhr6hBv96d8WK8ooRj9vDShU2Q5erRQU3
 8XCt/UDozTOfvn9Drjy87iwESQczuPJcU4ASsvHu7y6teM2kJx8uLZpRTzxGEXsSQuBO
 kaBcjaPLe+FCl0BE9nEPD4WdK+eVhWW1fSJp0LILazmpkYWR6JJ/Gw4GgZuPB+sawKcA
 cvuL7XhsbsNruBanZL4J+nHxwqNb7gbFazPE3aeYi5DdYVUaaDSULTVkiS21GLKHgH1j
 MqSTPGEc5CLgKBqBup0O7jdim4/p9BAuD2suqQEIasD6ikJWqiWdE6P0c8gp9jiUNlVf
 o4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841239; x=1736446039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sgVoWtpK77rxg1O2HQrgvJBz3K4KKWV6yZyPELMF82w=;
 b=h5JMARDgsoVQa9ifs5pXv/YfcaA42acTSUbQ21btWkF3QaMMEkaskb0TweshJvDPIx
 7IJ5nko0GNqzGxZcQlP1aBYcA9N1N0+pxMvHmYZDqqqUU6ddox5MSwK1mPBVw1neO6Mt
 8pKBFt9WOapF86mjkKh0dzjgERbecphBxtWOA9oYlyrAsafCHekm0PtyiVreZb8H2SKE
 fA9//xLgkwX52HjwpaQS5BJJKYBSulLmzaC+yzoxYmrwikx7p/Y5FEhD2bGe6hGaJ2EV
 /OQ3tLIxs6UEYRKlftmSaxMtPU2DvVRSteY63uYjtoDVR8WpGpi24BelYS349CLBH73X
 mSqg==
X-Gm-Message-State: AOJu0YzcTXocbnefL9kES6vH8m1ME/ycIuntlqAQSqg6mLS9m3GkUqrG
 WK0hv+5RcJO7HHCGKSPU+v8bnsYHxueWJ1EHN1rDYJEGHyUfpZWJ+Z4MKR4uya7B+XwcjTr6nKr
 m
X-Gm-Gg: ASbGncvzOh4MMc63lsLbuqCKCQRNVrRZ3DrwG7AtzcwYD9XA8PIxmsjTv37CIC0/5B7
 JG0IjkaZLQcWW6+eY597xchOi605A9c7cG8SNe5405Cimrxh4lIK57haD6vr+fgUip+LS/6d/TJ
 gywc+uFGWIjoXmRVwx0VKk1dOG/pzc23kkA/hQN2c6WrjcBY8IVw8FPhPslop8qCNF2sIELtSSG
 8aH+KZ07aIGNKmlbW5crrOsW1K5bfiTPD1U9ModBK+X0xHSwqzy82ud3cIPXQ==
X-Google-Smtp-Source: AGHT+IFZjE012ieqYz4o3TJB+kEDanAgooIA8cKRrX74XQCuKy8dccuZn6ir4TRR3IZtGjY1iAQo3g==
X-Received: by 2002:a05:6a20:cf83:b0:1e1:a094:f20e with SMTP id
 adf61e73a8af0-1e5e0470541mr65711929637.17.1735841238866; 
 Thu, 02 Jan 2025 10:07:18 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm20604456b3a.154.2025.01.02.10.07.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:07:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 30/73] tcg/i386: Handle all 8-bit extensions for i686
Date: Thu,  2 Jan 2025 10:06:10 -0800
Message-ID: <20250102180654.1420056-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

When we generalize {s}extract_i32, we'll lose the
specific register constraints on ext8u and ext8s.
It's just as easy to emit a couple of insns instead.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 167228a781..b7a8b3880c 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1329,16 +1329,31 @@ static inline void tcg_out_rolw_8(TCGContext *s, int reg)
 
 static void tcg_out_ext8u(TCGContext *s, TCGReg dest, TCGReg src)
 {
-    /* movzbl */
-    tcg_debug_assert(src < 4 || TCG_TARGET_REG_BITS == 64);
+    if (TCG_TARGET_REG_BITS == 32 && src >= 4) {
+        tcg_out_mov(s, TCG_TYPE_I32, dest, src);
+        if (dest >= 4) {
+            tcg_out_modrm(s, OPC_ARITH_EvIz, ARITH_AND, dest);
+            tcg_out32(s, 0xff);
+            return;
+        }
+        src = dest;
+    }
     tcg_out_modrm(s, OPC_MOVZBL + P_REXB_RM, dest, src);
 }
 
 static void tcg_out_ext8s(TCGContext *s, TCGType type, TCGReg dest, TCGReg src)
 {
     int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
-    /* movsbl */
-    tcg_debug_assert(src < 4 || TCG_TARGET_REG_BITS == 64);
+
+    if (TCG_TARGET_REG_BITS == 32 && src >= 4) {
+        tcg_out_mov(s, TCG_TYPE_I32, dest, src);
+        if (dest >= 4) {
+            tcg_out_shifti(s, SHIFT_SHL, dest, 24);
+            tcg_out_shifti(s, SHIFT_SAR, dest, 24);
+            return;
+        }
+        src = dest;
+    }
     tcg_out_modrm(s, OPC_MOVSBL + P_REXB_RM + rexw, dest, src);
 }
 
-- 
2.43.0


