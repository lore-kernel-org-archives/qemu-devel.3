Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33311E7718A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUME-0008P0-Gz; Thu, 19 Dec 2024 23:11:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUMA-0008OI-IL
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:18 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUM9-0006Jk-7v
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:18 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7f46d5d1ad5so1069668a12.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734667876; x=1735272676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=prpZjgFsa/vChv6dl20aQjC+mL9aG1wh+Y/YSCIlCzQ=;
 b=xoH+6XJtGRf9SyAxg+nTYlG0OmcorQR4SdVcPygihM+elcZh7KujXZEujWWNHsiWi2
 dQlhTLRp04N8Ms/C5D0n2jW3MKe6m1ivF/1nF6hpp8bjil9ej1SJAvV0tYEAAMZNbVlq
 121PjHSeLJgKyuv1HgbfD3V+Vf8cY30hwPUBiyQF1/RFkCZtTWf/bvulxul2irV4flr1
 BFXX9SKTS3MY6R7LsFQVR02DpqussF+dCAYJNXuzZ18AzByAOKh02Y4MxIW8KVMS8639
 3YE0+MvGRe6XhgBdATMsGuNEBLhDf/qV1zy3PddLiUXnAIKnL3r2sZZFS0HKUeULolAa
 2/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667876; x=1735272676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=prpZjgFsa/vChv6dl20aQjC+mL9aG1wh+Y/YSCIlCzQ=;
 b=I1tzgHUv69NGdo6F6hiIi1ehvWHt4lGySO1TR5gdB+K+PgiibBFRA4DbyOdZMlPG72
 I+8RCqIMLzrRiL57rMSKEHH1NZfniNjQEauWIbmM+4Q9kaxcSORtby2rXxo/Ng57bVAf
 yFZf0uM48pu1SzZZPejl48rhBuOy1e7BnenSfbeKwMXC295JuEul3B3wWEPQG3E3yJpD
 HRNXClfsc8mQdMNq+o5RKaKjcxit6SwscVXuFJwN8fUOngBbz8SVCceSiQl+2RNqh/qS
 uzxaQPNuRSU2XmhuxXfIIwWtmQEde9y4Dteq4mmEA2UQ2gjhGZ44jgkAjZrEUmCvDRvE
 88Gw==
X-Gm-Message-State: AOJu0Yw900hcrmAXQpRMMa88zhkr5gurE38u0RWCZwxzMnecru/uVQHw
 77XTRDumrJqGpTuEBAdpMS6iLjR3kIoxkxSUxRQTH04F/CaD51LKPDAYY2i8O6i/YlErGjqIw30
 M
X-Gm-Gg: ASbGncvNgDRfsU1WisTLwH5S8MhVMYYLaRryypnKz/voozabuBrjs2AYMFopqnz7RM/
 KTPE1JxUGtGc6g0RxZhBx0ieWX4m/beSzkjHfdNZm2+MnvrLpjve6QsyKA4h3hBQx4xRz7o28Ti
 ZSacBW29NNL/VyTmXay7rLAU4amMKlzeTtXAckbdBa+TeEJ9yy3aXbdzVlJ3iuLwePw3MHWxAuu
 IKRrrfrOiQrN0meaYn0zeHBHwayTtRJ8axD69x09XJhJjg6urxByAWlCuJfwdQ=
X-Google-Smtp-Source: AGHT+IEWnGOZGKmwoNL9C2i6G2ZsLw9V8P/jPAAh8ki6to5d586jEA9ZR1sZtwy1wZBuisJS1x6OlQ==
X-Received: by 2002:a17:90b:520e:b0:2ee:b0f1:ba17 with SMTP id
 98e67ed59e1d1-2f452ee8cdfmr2337945a91.37.1734667875875; 
 Thu, 19 Dec 2024 20:11:15 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee26fc22sm4165260a91.51.2024.12.19.20.11.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:11:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 15/51] tcg/optimize: Use finish_folding in fold_dup,
 fold_dup2
Date: Thu, 19 Dec 2024 20:10:27 -0800
Message-ID: <20241220041104.53105-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220041104.53105-1-richard.henderson@linaro.org>
References: <20241220041104.53105-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 0ae96f34e5..0232fa852e 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1714,7 +1714,7 @@ static bool fold_dup(OptContext *ctx, TCGOp *op)
         t = dup_const(TCGOP_VECE(op), t);
         return tcg_opt_gen_movi(ctx, op, op->args[0], t);
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_dup2(OptContext *ctx, TCGOp *op)
@@ -1729,7 +1729,7 @@ static bool fold_dup2(OptContext *ctx, TCGOp *op)
         op->opc = INDEX_op_dup_vec;
         TCGOP_VECE(op) = MO_32;
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_eqv(OptContext *ctx, TCGOp *op)
-- 
2.43.0


