Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEAF2E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:32:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL26u-0005Gp-U3; Tue, 10 Dec 2024 10:25:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL26U-0004SN-Kx
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:50 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL26T-0008P0-3v
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:50 -0500
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3eb4da24f3bso1156949b6e.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733844288; x=1734449088; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GRgI4ZZV/EtnyFcPzwtNskYp/Bon/iIPBoBs+FuTAuw=;
 b=jlHEpNdt3MNTN4A8uK31CShU41j2bUgRKQbTgitKf5CqiOEceh21KAzaHLjQKzVNYv
 DhN4xAsCA/BfuGh9rdYWQL4fpzZSN4hAQMVTQM+l8KBMlRLr1s3VUQ72+20LSD40IovS
 Sob8bTg+Nvq6i28y0Ii28LCdrbcqZ90aSY2mhpHWAVpz5PlfcD97wf11zytQloEgrgKJ
 Rz2WYUSqjpFrgjrPpygwEwi/j5Si1mAEiSom3rYdV0rr3IWM7QKNZ2A1Kx4rhhkHup4u
 bEAVxHnmsQL54C3X3SMXhLHHCmxgPWnxhIb361269kguKeQQmjmpB13QdwEKWWFhqtW7
 16Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733844288; x=1734449088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GRgI4ZZV/EtnyFcPzwtNskYp/Bon/iIPBoBs+FuTAuw=;
 b=QaOrD3XVMtbBriwCdnogefBPU17fnfH6WOwh+snfb35Sq0JUOo+2oRPYIOa/DISOei
 cYgxHFz7SIMheiHEa/THUznPXK6sxyRV4YUoyBH8OL6ZhVNLfhbf2tV/tXyiS04Hj70w
 WVeCIxFkl9IfgvXjBaHhsDEWAn48vx5wiF4RAjcdbc30w8Ji/sUlgJvsaCns7AKqidyq
 DlzUf67IZCQ36/3Q6wVh+jbyifg9pZZKuWxzDsS/uLcA2iiQw+aZuRhDbJ22flY3v6cQ
 hJzfELnMNsLVJUT2OXs3td+WM4MQYISXZVPDhb1Uj/Nmi3aCZ8HnVz0x6qPs89Wrrhvz
 Q/6Q==
X-Gm-Message-State: AOJu0Yz2l36Jnt4/TeARuYxS53crALbO9JjV1Po1JT2LPhP5cHgz7n4p
 CjwTx7J1uOpFkfws4+U3p9dX9beTyhNjZY6siwdWxJ+nTFUEWEyVR/z7tr1VYRoSqYw3Q/+PBDi
 NVvcttZF+
X-Gm-Gg: ASbGncvvrKxSDo2kFFPAps+M9vs8lMSLrdFHNDHHgz76v3YzwnPmtPMF/N4kewA3F7q
 iqeSu/+lyRolSQlThIRIdB/Q9fz77/YpkTCL33u+6Z0QDtot3Z7JXPrT+l60XF6BKp5NxDHnp+c
 3wySFRJn5LoiUJY0BZ4Uwr8jTle3fCCKahl5THexoMnsKSwcqBHw3j2i9+dgwfF7wRMjVBeEoFh
 1pGKCWzil4X2qVFfyAQJOL8SDbmpwTk+tt1QZLWaeOtYFmNCAklLE9HvxMWAA==
X-Google-Smtp-Source: AGHT+IFCGl5eA/8iILOcLhtkcOA3sSrKjWtSbXtffvd5ybUGCjhjwge804DyW0OVzcu4MvuRNzA1dw==
X-Received: by 2002:a05:6808:124b:b0:3ea:5809:2835 with SMTP id
 5614622812f47-3eb19ce7e2fmr15319044b6e.21.1733844287849; 
 Tue, 10 Dec 2024 07:24:47 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb076b9168sm2776435b6e.14.2024.12.10.07.24.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 07:24:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 31/46] tcg/optimize: Use fold_masks_z in fold_setcond
Date: Tue, 10 Dec 2024 09:23:46 -0600
Message-ID: <20241210152401.1823648-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210152401.1823648-1-richard.henderson@linaro.org>
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
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
 tcg/optimize.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 7b1d437c27..cfd4c08f11 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2349,9 +2349,7 @@ static bool fold_setcond(OptContext *ctx, TCGOp *op)
         fold_setcond_tst_pow2(ctx, op, false);
     }
 
-    ctx->z_mask = 1;
-    ctx->s_mask = smask_from_zmask(1);
-    return false;
+    return fold_masks_z(ctx, op, 1);
 }
 
 static bool fold_negsetcond(OptContext *ctx, TCGOp *op)
-- 
2.43.0


