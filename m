Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B79C3ABB9
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 20:30:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC2Q8-0006nz-I8; Mon, 05 May 2025 16:28:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC2Py-0006ir-2G
 for qemu-devel@nongnu.org; Mon, 05 May 2025 16:28:02 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC2Pw-0000Nz-B0
 for qemu-devel@nongnu.org; Mon, 05 May 2025 16:28:01 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-73bf5aa95e7so4650929b3a.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 13:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746476878; x=1747081678; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bNMUa6fOg/QOVlgIUDbzwyMY2i8YHnlDdM4yZLD9BYY=;
 b=aKF37gdB5e32w/bw590fFmHRAygY1M8bDnrqXFnUgtqI8MJjUEcxjBhRxCaBGDQkcG
 5KNsRTN0Y76nTZd3fVmeNCLzqEInFj2/Lm+L+4PQB2boq5hkfE5m6CE2CKsAU28g3p1h
 W5tDJEhmez5gH/YtLDnklYfWh2wpwlrNHGTOX1Hg1wnloi+WiMBN0hp92ByUR+rUSRst
 Yfa2VSsajOwXzPCWRuwYrodtdr50H1WlfpkbC8s2iZlmoOsqbR5Q7e9oqWDJuFvaWQfJ
 V5P4ti+j4TbN77bqaUTIcLCnrT066Gj0kkH3SFKAiXbXNt1JEFcN1lcRlFc1uHRcsvh3
 W9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746476878; x=1747081678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bNMUa6fOg/QOVlgIUDbzwyMY2i8YHnlDdM4yZLD9BYY=;
 b=JdvmNhKMGM7RaQN8aNXEhcDoF7sa2lszUt096eya39IiUrS/gUEzMFRk6Dfkva+rU0
 uv+jxbg6fmStcEAXFYkmsozBzYa3ouWugNMrlyCpbBaMXbBVjLN+guHkUpQ6g2B1o6t7
 ETP+C0Sjg0T+IkF5+HmeRZKBE4dxDusViNF/GRlncDWTd9XvhoQz2f47pUzxnAYSHIdC
 /CeaAhqnv93UYU8GfZL6fkadtVjrrq35emBcAam1evNI38Ua7+u50fdQDKYSN3Higti6
 5OVPpPS0OXVmortlajEC0Oni2a5tEsRQetL1+rvoBpbCxR33I4/FSOSQq90I2fV2H/3d
 /hGg==
X-Gm-Message-State: AOJu0YxXLh9hCYXdfW0n4GPqFiv5HPc8mKVdH1TX4juJTfG5ZXIbHNcH
 FbPnSIPVzuPKvxVk8RhueGyX6b87taa22zFcTMUj8p+Yu5vpT0Z5ng95fvUxdMZdfHG7WzH0DZH
 s
X-Gm-Gg: ASbGncsP1nB/G3JPe5RSYW5CxzTfIeFzsl4fGi5MsqPvpF+MfMVVFo6tRJHwneo1ndl
 P7RqiblCnjR1qbiCbIPr8xtEBLwy4mBC48Be//UFxihZk4sajSm5ojdXB5pzZEo1LuaGHROP0pd
 0OS1jbBLpr6kXSXQsCT5yEnPfWvawYzS2DQXdPPI6CqO5Y+u16auVYSu3iZiXGdsUj88H+kAorS
 cqXXrBZYrmUcB4SzjXoWMU6H0Ftic5KMwv/6js9JbBssn8dr8iliwoGJWK2qqct+ojIuXdrq6/B
 JwGDB2ChZ/yeCsCkBJ5YD/yLo5cjiGFQcPBgJqXdWL/da9EyICqWJdiU7DLRzoTIwwyND4xW/Qg
 =
X-Google-Smtp-Source: AGHT+IGI64E6qUQvTtD0dQJ27en3xx7zQ3dJ2hnYFKTNdAeTnalfdSgmIf7iZ/uEIKGxCBIOqL8MJQ==
X-Received: by 2002:a05:6a00:e0d:b0:736:4ebd:e5a with SMTP id
 d2e1a72fcca58-7406f1a3c00mr12867802b3a.20.1746476878519; 
 Mon, 05 May 2025 13:27:58 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059021067sm7516485b3a.107.2025.05.05.13.27.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 13:27:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/20] tcg/optimize: Build and use z_bits and o_bits in
 fold_nand
Date: Mon,  5 May 2025 13:27:37 -0700
Message-ID: <20250505202751.3510517-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250505202751.3510517-1-richard.henderson@linaro.org>
References: <20250505202751.3510517-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 08d15e5395..9721c80943 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2192,16 +2192,22 @@ static bool fold_multiply2(OptContext *ctx, TCGOp *op)
 
 static bool fold_nand(OptContext *ctx, TCGOp *op)
 {
-    uint64_t s_mask;
+    uint64_t z_mask, o_mask, s_mask;
+    TempOptInfo *t1, *t2;
 
     if (fold_const2_commutative(ctx, op) ||
         fold_xi_to_not(ctx, op, -1)) {
         return true;
     }
 
-    s_mask = arg_info(op->args[1])->s_mask
-           & arg_info(op->args[2])->s_mask;
-    return fold_masks_s(ctx, op, s_mask);
+    t1 = arg_info(op->args[1]);
+    t2 = arg_info(op->args[2]);
+
+    z_mask = ~(t1->o_mask & t2->o_mask);
+    o_mask = ~(t1->z_mask & t2->z_mask);
+    s_mask = t1->s_mask & t2->s_mask;
+
+    return fold_masks_zos(ctx, op, z_mask, o_mask, s_mask);
 }
 
 static bool fold_neg_no_const(OptContext *ctx, TCGOp *op)
-- 
2.43.0


