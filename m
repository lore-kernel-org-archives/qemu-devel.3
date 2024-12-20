Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 514B4E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:13:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUMZ-00006H-FX; Thu, 19 Dec 2024 23:11:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUMO-0008Rf-5C
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:32 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUML-0006OP-Rb
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:30 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2efe25558ddso1055840a91.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734667889; x=1735272689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TJ5jaLrHM0v89QaKJI8z+UOp7RGcZR7YVrz2twbR1Jw=;
 b=iO47zXw74+UnBaidqkFyTzrLQjjL+w56LW2dJBnWCsVHgr5W+z/E6JJYGnSOefp4Q2
 L1YfxU5oP48gwdj2MK0MnMuUjcITxI2RsfaE7nK7+xIQamS199VEHy3Obq+WgXeEq1Ko
 s7ugLCr2JJqthUHGEU0FDkc5BEkvxQ2l62IpZod+UQurp6Rue1A8LeKlZIBOjJmvN2HQ
 NzwTSYUv2FCtGDfgC+2wFmNyBCoLO+7H30pVGtdNUIm6XTJNNPIDpyR60oJaLg03H0im
 pwE7yYBFzRXhxWQ7A9zz1DeikhSD+QsNsDfuq4QwiTgNgaARo0KNaUEzN/CjuvfIloOR
 5YSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667889; x=1735272689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TJ5jaLrHM0v89QaKJI8z+UOp7RGcZR7YVrz2twbR1Jw=;
 b=Y7tVyZEpRE0trT71wAhcaieDvLsmEVWwNXX/Xq8jTDP1+Yx+j3irjj7WOdGjI0hE0Y
 73e1JADH+g04pHITTS93gLdvB85M4pRCqiaiERpLR31KswJDVTczbZytwL5e9YiPStDg
 KgBOU4IzTLuG1MGVdFZWulWyZ2JmE2BWYdx14Mmu8afxDaeBUxszSFRGW/HxsaMY5Yea
 pHJSU3mpryUdE4ayJ12hnDDi7+YjKWlS2JqSMHTH/GeF3ye7K0pDg/aaTZsFC2E98m04
 XFZ5CGnxdW/2W14sazC5oogx902orzYM9zrlkuIDCZvixPkZEDSKmnV+Cc4LR+TCV1HD
 m+UA==
X-Gm-Message-State: AOJu0YwsuhJlVYLh3hs2qiwPOB4X1U9lgKUQpsM2D/QbFdtKEsUjoyWZ
 DEHNCxUIeF0ierO7/cypKrxEB8fB3HWhhzt8OIHeCCD9KK1w4Cuq5nelo1/c/VfXIqi5aagBiEA
 W
X-Gm-Gg: ASbGnct1kKPGAKo7q6bEiwfjqUBstQQ/vWZD1GYdSwMpY67DjEaM2xDqdVct/8wUr0+
 uuziIisi8evP/C/aTH/MrTcVq9aFcOQmtl+vAco5YImnRSn63joPNNXNX2AJ4PTmpzpBMscRS8P
 dgvSZGgCEq/6zP4hFCS3ey0pTxJtqzWUt+GcaJuHgj1XXOLvy1Hoe+zZB4oQodrcfkju7G50nW3
 coU+sTYcR2FFJ6rhpBbOY6smFYLDrOvoJSIvg1eBV66SDV3mzDVs8Si9VWy1OQ=
X-Google-Smtp-Source: AGHT+IEhUSwzL93Db5paJ6QEUAp56ruLf/ObvkF0jv0q4yIQr+u0X+JrKC5u9sQfe+UGDpuLuKAlXA==
X-Received: by 2002:a17:90b:2dc2:b0:2ee:acb4:fecd with SMTP id
 98e67ed59e1d1-2f452e044damr2339553a91.9.1734667888677; 
 Thu, 19 Dec 2024 20:11:28 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee26fc22sm4165260a91.51.2024.12.19.20.11.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:11:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 33/51] tcg/optimize: Use fold_masks_z in fold_setcond
Date: Thu, 19 Dec 2024 20:10:45 -0800
Message-ID: <20241220041104.53105-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220041104.53105-1-richard.henderson@linaro.org>
References: <20241220041104.53105-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

Avoid the use of the OptContext slots.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 9c4bb1fb91..079b5b82ba 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2384,8 +2384,7 @@ static bool fold_setcond(OptContext *ctx, TCGOp *op)
         fold_setcond_tst_pow2(ctx, op, false);
     }
 
-    ctx->z_mask = 1;
-    return false;
+    return fold_masks_z(ctx, op, 1);
 }
 
 static bool fold_negsetcond(OptContext *ctx, TCGOp *op)
-- 
2.43.0


