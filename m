Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58440C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 14:41:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk3I2-0003eh-Je; Tue, 12 Mar 2024 10:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk3Ha-0003XZ-Ka
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:39:12 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk3HK-0007k5-Ph
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:39:08 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1dd6412da28so31257555ad.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 07:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710254333; x=1710859133; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6WDUOYZWLT555AjxYlW12yt2eENGmiwsLor7nsvhIVw=;
 b=lRLcYKbkvLIoyBXEn13gBq0+IFApEDPWli8p9TsfDu3IbnvqDiq2QCh5MAFkd4/pJs
 y7v2+5bNr+WJnl9v/18xoHdr4DpznzpJlhlwhIpv9+cjQMyNF5koCLVDamDCgkaR+Pjj
 GThT+byZghQAb23dkRA1dI5L4xyuHoamGAJz9nNd/DDfNolbXuqpty6qUFoAVySvB+s8
 +fNcXFgLIjWoKYyEr5m5zd3BexKobwc/ptgcIQrz9vMmLj5oZC56NDn5tX0cPxSqAAaH
 suJLWOquxWJtiVKflSbtNxY5gxfkf6vYUX3BG2xIdCDAToMICHaTdMqGi7LuibvEl70+
 Ek8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710254333; x=1710859133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6WDUOYZWLT555AjxYlW12yt2eENGmiwsLor7nsvhIVw=;
 b=PZesqedBw325K46BUVDn6bjtKdJwWgUqXxpsoIUNR3klGUwGn4OCpY220pIB9/Jnb9
 UEWE264EGZYz+Cixih9lLMsDURbmTfEJCxQdOHVUjI32Z6Gd34O+Xt+SOuQkN0wF3VGA
 Qin5oZMbwiK8JG+CQn+lGbBT+LihohAkQjM4GuTZ8y/TGDnoHishOOsYdGLzX3sQZf4w
 7TViC3AhWbifamajM0w1GusJmACa5g3bWcQnMFGWRnuQi5FnWEPCYDH7Q/QA+lm9mXUv
 Se1rApG0LoDgjToiqnA83Epjg/mw2RM3rMHcc2uzTCrrM4kdezevgNOTk431Kdq6vCzc
 Pzaw==
X-Gm-Message-State: AOJu0Yz/U6sW5ijXl0dxAxF78HnEZSfQZtoya/M60j0TuTtCc2MUeGgH
 Cl8Y6DHIYIB8oDelfl2E2xj2R3dZd+Ug8TDj2yEd8/ttWnTFIKcjeVUaGpwHYH+h2YtDXPxBh0g
 n
X-Google-Smtp-Source: AGHT+IFaMkrDWHpiY2l+oYdKcp54wHTy7L5FTS2UYvlT/xgW9ehyio4yPtRZ7DllwhIGPfaSRAPpVQ==
X-Received: by 2002:a17:90a:77c5:b0:299:1777:134c with SMTP id
 e5-20020a17090a77c500b002991777134cmr3281311pjs.33.1710254333445; 
 Tue, 12 Mar 2024 07:38:53 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 jx15-20020a17090b46cf00b0029baa0b1a6csm7492214pjb.24.2024.03.12.07.38.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 07:38:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/15] tcg/ppc: Do not accept immediate operand for andc, orc,
 eqv
Date: Tue, 12 Mar 2024 04:38:31 -1000
Message-Id: <20240312143839.136408-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312143839.136408-1-richard.henderson@linaro.org>
References: <20240312143839.136408-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

The transformations with inverted immediate are now done
generically and need not be handled by the backend.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 32 +++++---------------------------
 1 file changed, 5 insertions(+), 27 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 7f3829beeb..336b8a28ba 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3070,36 +3070,14 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         }
         break;
     case INDEX_op_andc_i32:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
-            tcg_out_andi32(s, a0, a1, ~a2);
-        } else {
-            tcg_out32(s, ANDC | SAB(a1, a0, a2));
-        }
-        break;
     case INDEX_op_andc_i64:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
-            tcg_out_andi64(s, a0, a1, ~a2);
-        } else {
-            tcg_out32(s, ANDC | SAB(a1, a0, a2));
-        }
+        tcg_out32(s, ANDC | SAB(args[1], args[0], args[2]));
         break;
     case INDEX_op_orc_i32:
-        if (const_args[2]) {
-            tcg_out_ori32(s, args[0], args[1], ~args[2]);
-            break;
-        }
-        /* FALLTHRU */
     case INDEX_op_orc_i64:
         tcg_out32(s, ORC | SAB(args[1], args[0], args[2]));
         break;
     case INDEX_op_eqv_i32:
-        if (const_args[2]) {
-            tcg_out_xori32(s, args[0], args[1], ~args[2]);
-            break;
-        }
-        /* FALLTHRU */
     case INDEX_op_eqv_i64:
         tcg_out32(s, EQV | SAB(args[1], args[0], args[2]));
         break;
@@ -4120,16 +4098,12 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_and_i32:
     case INDEX_op_or_i32:
     case INDEX_op_xor_i32:
-    case INDEX_op_andc_i32:
-    case INDEX_op_orc_i32:
-    case INDEX_op_eqv_i32:
     case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
     case INDEX_op_sar_i32:
     case INDEX_op_rotl_i32:
     case INDEX_op_rotr_i32:
     case INDEX_op_and_i64:
-    case INDEX_op_andc_i64:
     case INDEX_op_shl_i64:
     case INDEX_op_shr_i64:
     case INDEX_op_sar_i64:
@@ -4145,10 +4119,14 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_divu_i32:
     case INDEX_op_rem_i32:
     case INDEX_op_remu_i32:
+    case INDEX_op_andc_i32:
+    case INDEX_op_orc_i32:
+    case INDEX_op_eqv_i32:
     case INDEX_op_nand_i32:
     case INDEX_op_nor_i32:
     case INDEX_op_muluh_i32:
     case INDEX_op_mulsh_i32:
+    case INDEX_op_andc_i64:
     case INDEX_op_orc_i64:
     case INDEX_op_eqv_i64:
     case INDEX_op_nand_i64:
-- 
2.34.1


