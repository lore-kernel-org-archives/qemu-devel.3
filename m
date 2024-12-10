Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DAF4E77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:26:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL265-0004GV-Ag; Tue, 10 Dec 2024 10:24:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL263-0004Fd-PG
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:23 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL262-0008KA-Av
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:23 -0500
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3eb551be83cso640350b6e.2
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733844261; x=1734449061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2d60TSxsDICwowDfmunBt9iG+mRRxpu7LB3Cj2n+HL4=;
 b=AtT//ihAuDr+uzAJ6f6xC7tVtMcm0ip5xzMNLBzjlQm8mo1EpmV/GvyEG5SwLjUGci
 LwKCVIpYp+xrYlsNxINGyUuVBXiDf54yzX8GcZIvoPM63Fl7zdlPACRebeE9z38WeraC
 Msi8XdeWop0FIQtIrwo44BBvX/G4I0kEKh4qqmfH0G1QtoW7sW5BInAXwXCIU49LvJGw
 PG/C4/8vMOnoKYNoVpyJ5Sf87gwS5QQC+SHunORK7H6XU9TtmkAtlq+mvF7xKkg4WPF+
 PaO+B8NCsKkQ+qRQwagxU+NOJ060gVwlZ1OZoUTdhIqtRIDjZn+KRsxpxRjvk7YCcN6C
 cwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733844261; x=1734449061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2d60TSxsDICwowDfmunBt9iG+mRRxpu7LB3Cj2n+HL4=;
 b=sc9tq9/+Dr/RmwfoclRAra4zjVTjSjKvcPGKMWQc97c4al+QoXcVlGYsJ1A126zIk6
 5Ac7bqr/6jSoNbDjpIJA4t/7odlM3VEwUy56UdwD56R5qaOfxUsodcdJDUJxrih7u+2n
 /5QVAmQpmpgzO2DWUw8BXlhSbV3GJzOWWd8Hi0ZCNa7Z+WHhfxVThMkCkogarUC/BDJH
 U5og7Koxd6/1yH7VugbsS/yb4YmwFRhJAuk0SMHQRSxBBgIghq2IgiOfw2FkhrnYxT6z
 ASU9XhSwJXlAUDTN3Djo+RP6sF58YJ/nCF00LLhJBYeogCSX5W1Z8o6904DOdeHJNb+a
 6V/A==
X-Gm-Message-State: AOJu0YyMYeVQqmrGh6pzylz3tmjWZffs3sxuGE8lvg0BLHSHEoceSerT
 uNWlULjF23GmRvAb4lvq6BMLtQactIcNHXCDtl3Zi6rOf4VQcwOiS/VgS5KEWIzeh6wREtr/05s
 PYaX6/RZt
X-Gm-Gg: ASbGncsTvAoadJ62UsjBJPHT/GsfbNU+gfRRMhE/TzAtm+Q6Nb+inzxikKXZxZ9XaCj
 +ix/huM+B1H1M9K/FuXqTdnsMuxcWSmFEETyeN1G9MzHPOMleYjwTHMZkuw3+5yEwn4e/6tmxa8
 syEQezp5pzFGCANJV2fS+gyJdr8Dz7dLwDfukvCrgizohJHny0LZzZI+RddgAf9ehBxINWr+cyS
 XJ2YWV8mERdf8taaMFmJGIDWqNV3+ZDb1UWw+xNb0uVUdtImzcj3T1CBI1LVA==
X-Google-Smtp-Source: AGHT+IEAdgi9OqQrilNb1B+MT31uTD9yXo+TOHAUt6u5BVCz3PP04WUMsNAwJnfz53fwEQVlYY+q5A==
X-Received: by 2002:a05:6808:1316:b0:3eb:575e:3eaf with SMTP id
 5614622812f47-3eb66e13ea1mr4002235b6e.19.1733844261059; 
 Tue, 10 Dec 2024 07:24:21 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb076b9168sm2776435b6e.14.2024.12.10.07.24.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 07:24:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/46] tcg/optimize: Use fold_masks_z in fold_ctpop
Date: Tue, 10 Dec 2024 09:23:25 -0600
Message-ID: <20241210152401.1823648-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210152401.1823648-1-richard.henderson@linaro.org>
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22b.google.com
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
 tcg/optimize.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index c97ec10989..424ed7674d 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1598,22 +1598,23 @@ static bool fold_count_zeros(OptContext *ctx, TCGOp *op)
 
 static bool fold_ctpop(OptContext *ctx, TCGOp *op)
 {
+    uint64_t z_mask;
+
     if (fold_const1(ctx, op)) {
         return true;
     }
 
     switch (ctx->type) {
     case TCG_TYPE_I32:
-        ctx->z_mask = 32 | 31;
+        z_mask = 32 | 31;
         break;
     case TCG_TYPE_I64:
-        ctx->z_mask = 64 | 63;
+        z_mask = 64 | 63;
         break;
     default:
         g_assert_not_reached();
     }
-    ctx->s_mask = smask_from_zmask(ctx->z_mask);
-    return false;
+    return fold_masks_z(ctx, op, z_mask);
 }
 
 static bool fold_deposit(OptContext *ctx, TCGOp *op)
-- 
2.43.0


