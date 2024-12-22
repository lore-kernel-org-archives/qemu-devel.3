Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F44EE77188
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOm0-00030n-Qs; Sun, 22 Dec 2024 11:25:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlY-0002fw-RT
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:18 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlW-0003D8-En
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:16 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2164b662090so27974505ad.1
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884710; x=1735489510; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iAElw8y3osLr1ZWh87G2zmGy/BBYjBbHdrU8XQRvtTQ=;
 b=FZaoFQmAdtd/jLksM9tym5rIxOCVV2+xXN7A/ktdWhOzQt17W0qUnmlGyNm9ROW50K
 /BHYz7AjY0LfDDfjFyVMM2qaM3a+hsHPlEAXe+RgkXtbAKP/y16vecsSciBVfZDbDe53
 JtkwFI0I/75ihuNAiHq6qqKMtisJFCgPEV6OPviGN7WAXzMCwTJEJnd5kAgbQTSPDARj
 0KeMkNH/0udJyWUoIXgHdjuJBmdNm4/WZlQzVmtIcBkFT4aB+4rAjtbTtLAObBrGEVtF
 GTE/RwElgPvRx+m7sKJJFQoyDxmQzJPl1E6xOmU3YJ6rOkZ72jmWJXmBoEZXqyvq9HPU
 eAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884710; x=1735489510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iAElw8y3osLr1ZWh87G2zmGy/BBYjBbHdrU8XQRvtTQ=;
 b=piSnxoASD8lKp7YgZ0pcDopE+4Jp6OCXvoXP7zgJOILvb3X5V41vEO6bni7DBYUG/1
 PRxlyUynTk4vBO2qf2MfDByCo/WF7Ao/Jf4HNpVxYe1XNbEHSgj2dM2j0arLvhnJbDJD
 3qugJkLti+xikbVLtjnrISR7TYYz81xLC/PGP5hUMhQzxcx0CYNYK9yO6WSWlwr6Vfh/
 CwH2mk7V1COGaW4Co6E4Ke6W0ynnIEkzzKXRsucq98jWM0rEEJdKBKm06QuG2gJiicHx
 0tnpH1EnpVg9cCEbTVheETXgASKrH0itHtPQ06oWzcyIle7LGG5A17TfpV9CvSyl+fRS
 3p3w==
X-Gm-Message-State: AOJu0YxqCGoOSOgkIBpSHXZVGr3GwykgLs7cJp19M53961AK+X3nweLn
 REllnFQtAXVEcBA7KRzy15wuV/PfK5XRi7xD4uQt517NaTR3T1q++kayRppHIoUyCVzYiEP6PKG
 Iklo=
X-Gm-Gg: ASbGncvXnWuEwvBwyY3xufMPRMTmaOswGAzDirU0iIPEwyP8IUGUaYzVSh6/ZwGf0Al
 7paMK0H6g650lfzeHWBJJJGFRH5ehkQ886kfYkEm7wl7r+cSuF4OfYcYADX81rj/lQTthz7TniN
 Qjku25Qb8nGpNBguKMRfdwsEimVX/tyxARa8z1+CZvzDt/NJnvyedPjo5P1qG4PC1iVzuW7DlBt
 AozzLzYmAwimikiWBEFUyNj83qtKIHRHrf7JSyLVIaZgo6Gp76/4HejLBVx8Z0=
X-Google-Smtp-Source: AGHT+IGJ4PZruBQrTtWH//tHw7r7WxZra2frGR0PGNWXdSeWJwQysH8CgGsE7rh3yvrnw6xfcU3nVQ==
X-Received: by 2002:a17:902:ecd2:b0:215:89a0:416f with SMTP id
 d9443c01a7336-219e6ebd0a4mr116791965ad.30.1734884709993; 
 Sun, 22 Dec 2024 08:25:09 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc971814sm58461385ad.79.2024.12.22.08.25.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:25:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 35/51] tcg/optimize: Use fold_masks_s in fold_negsetcond
Date: Sun, 22 Dec 2024 08:24:30 -0800
Message-ID: <20241222162446.2415717-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241222162446.2415717-1-richard.henderson@linaro.org>
References: <20241222162446.2415717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

Avoid the use of the OptContext slots.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index b6911faca2..16c1192a91 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2370,8 +2370,7 @@ static bool fold_negsetcond(OptContext *ctx, TCGOp *op)
     }
 
     /* Value is {0,-1} so all bits are repetitions of the sign. */
-    ctx->s_mask = -1;
-    return false;
+    return fold_masks_s(ctx, op, -1);
 }
 
 static bool fold_setcond2(OptContext *ctx, TCGOp *op)
-- 
2.43.0


