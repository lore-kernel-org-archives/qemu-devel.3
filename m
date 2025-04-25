Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 640F1C369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 21:57:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R1C-0007dR-Ax; Fri, 25 Apr 2025 17:55:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R11-0007XW-E2
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:55:23 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R0y-0000ZU-D0
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:55:23 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-736b34a71a1so3225228b3a.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 14:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618119; x=1746222919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AHpl3TQ1gAJNluoeZYF2B9bVi2xRa/fgeCq2ywDqjJY=;
 b=UnxesSJL+IfGdUN1k98LRvkk/8UcnmqYiQ3cBWdOX05/IGsmC+fu9HnWVpz6cIqPDK
 qCsj8jYwXEM6O4DBuxW+Sxi5r2GiMdV+U+Ml9ppLLmH4K8KRX5u+et9fid+q7k4l2ncy
 kiYJLenUx3ZQEkZyeWuaxr71TRZFnktitNonw7WsXjM6VZAzMLgURmnsXozNe9oYTsdc
 DFQL9Q1+YfOq8oSOvwXiLdgEOTatrYui/wnljdx4MSxW+EFDAD4pIXehGWTXT33mx3qz
 ltSMRjXPQz521JDlKvVc4sOeBxd0BhefHcTy3M8a9mRpa9gMBt8FnMBMjJy8Wxs5ZbX8
 gLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618119; x=1746222919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AHpl3TQ1gAJNluoeZYF2B9bVi2xRa/fgeCq2ywDqjJY=;
 b=GYLEdvUKiSJSNBBP/jbMaXD2xq9a2rnKX2SRRF7f/pg6HvvzEQnfX8JPL2HhDNTnI6
 hMRJslt0UGo9x69nBOweXCvSCf91m1pL6/hJHdy8B/acXeTZI91LGIVEUFpufzk3Oijy
 I/BDTkMXpDFPyKJ63CQsmbwGSexy5AbL7wvBvjKZwQzb1RMyJ8E7ZJmlzTczphb34aBq
 RCc/NQuLxZmbsKDOAPO8ZKkSP7VHRP6ZCqO89SQ2liT0SuxeEoN/O/aKuM8z8AK/2Gos
 kTGLzKaPIFT+tinUzynJHORMFv9EArTmOkIY6ycIOBQNuMhgwEW4nnWPumC7XDlVybbs
 b5lg==
X-Gm-Message-State: AOJu0YxRdyoSixSVUbK4XIWQF1EnwMphRH2XWwYl1/6tV+tqJIiRLN6N
 6OkoIotkpwHVLPJhIMx33o+Pdr43cGur9yE/Fkctbd9+eVJpSD5GVgEyN+OQ7wLgZCbtnCE41EU
 Z
X-Gm-Gg: ASbGncswWdXoBKrFiwfNbBwu807Ei9C6NmfPGUwVP9dMoyHU8CFmQ8MEp+Yoq1U43Ns
 6SzhPxF/5QqOM1obBy8LMktkGPxz7AZqn3B/9OBtv5qjp/0aFRn1veF9Q2KK12YrFjZxn7s9aS9
 QK/StJIzzSJqbaJXAZUnXy1SQCEJQfnWgLinzu6B6SZ4A/AEBLewBPPiYDW0qiCKya83WqHrXiP
 1Tug/zZ7NSZREncOEiR+S2u9/TadpmJ4y8moRykrq522qFbqQGGcCQjuFaiSMXWOF/9J8PzP2cS
 +ZKTdrxFHxz+qur4FxtP6oVsh8VqGlpj/X4eD046nBU9FA2P6SpNhoaz9LBCjL/ZxZOq2BAEfJU
 =
X-Google-Smtp-Source: AGHT+IHj7jFvWORzNcPLUsNqMA/MDVfj3ArdWpnRJNFQAc0BMZj/E34Jyi9/e1GlozqrutSqngnxkw==
X-Received: by 2002:a05:6a00:3a15:b0:736:ab1d:7ed5 with SMTP id
 d2e1a72fcca58-73ff70d05c8mr1504289b3a.0.1745618118916; 
 Fri, 25 Apr 2025 14:55:18 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e259414b0sm3664392b3a.48.2025.04.25.14.55.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 14:55:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 032/159] tcg/arm: Fix constraints for sub
Date: Fri, 25 Apr 2025 14:52:46 -0700
Message-ID: <20250425215454.886111-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

In 7536b82d288 we lost the rI constraint that allowed the use of
RSB to perform reg = imm - reg.  At the same time, drop support
for reg = reg - imm, which is now transformed generically to
addition, and need not be handled by the backend.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/arm/tcg-target-con-set.h |  1 +
 tcg/arm/tcg-target.c.inc     | 11 ++++-------
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/tcg/arm/tcg-target-con-set.h b/tcg/arm/tcg-target-con-set.h
index 229ae258ac..f46a8444fb 100644
--- a/tcg/arm/tcg-target-con-set.h
+++ b/tcg/arm/tcg-target-con-set.h
@@ -30,6 +30,7 @@ C_O1_I2(r, r, rI)
 C_O1_I2(r, r, rIK)
 C_O1_I2(r, r, rIN)
 C_O1_I2(r, r, ri)
+C_O1_I2(r, rI, r)
 C_O1_I2(r, rZ, rZ)
 C_O1_I2(w, 0, w)
 C_O1_I2(w, w, w)
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 8e9edeb7c6..47c09ff2b1 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1984,12 +1984,8 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         break;
     case INDEX_op_sub_i32:
         if (const_args[1]) {
-            if (const_args[2]) {
-                tcg_out_movi32(s, COND_AL, args[0], args[1] - args[2]);
-            } else {
-                tcg_out_dat_rI(s, COND_AL, ARITH_RSB,
-                               args[0], args[2], args[1], 1);
-            }
+            tcg_out_dat_imm(s, COND_AL, ARITH_RSB,
+                            args[0], args[2], encode_imm_nofail(args[1]));
         } else {
             tcg_out_dat_rIN(s, COND_AL, ARITH_SUB, ARITH_ADD,
                             args[0], args[1], args[2], const_args[2]);
@@ -2234,10 +2230,11 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i32:
         return C_O0_I2(r, r);
 
-    case INDEX_op_sub_i32:
     case INDEX_op_setcond_i32:
     case INDEX_op_negsetcond_i32:
         return C_O1_I2(r, r, rIN);
+    case INDEX_op_sub_i32:
+        return C_O1_I2(r, rI, r);
 
     case INDEX_op_clz_i32:
     case INDEX_op_ctz_i32:
-- 
2.43.0


