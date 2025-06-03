Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E1BAC61CE5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 08:12:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMMkB-0005Z0-KU; Tue, 03 Jun 2025 04:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMk4-0004vC-Gf
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:11:28 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMk2-0005rJ-KO
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:11:28 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6020ff8d51dso9128271a12.2
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 01:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748938283; x=1749543083; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=imo6l4YAJCNpBwtK2gFvupgfZPyatWqKQn0WtDN75Hg=;
 b=FAYGwiNWCu/xW6Hh1riPXXTxIIrRfHN/c66ePQ3aG5L2vBaVm39jbkW0yq7K0ygryu
 oprn6eKekBEa6WVDxVVFKteJ0vRNTk02LwSoBqRNHXsWtB0ocK/b/vkUctKxNad3BM9b
 ADAUHS87rCd5gQOYsaHyvTvSQ+mVQPeDIw0Eh0AitpreduW1chyhtfLEpNTyJ91r0EZw
 +lTGNxG6gNVXjQLd7b1FinujUYudoB+3pZJLmqt80XRKNwj3YyIgafxMkiGohOKTQbKK
 glxlkjegVP7AffF2DjMiEN2oU4U9hP0LSnP4r5B3JTK1XgxNCWNHVp0Z6H7hXZml7Lpm
 nLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748938283; x=1749543083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=imo6l4YAJCNpBwtK2gFvupgfZPyatWqKQn0WtDN75Hg=;
 b=oJzRV9komP8uiA7xPndXwJYQxgAfQzKe0YnZ9uPjbNyVfXdWaELsUZfgvUGdzO8NF8
 tY1TP/lf3E/IWqCuzfmPiwqow2bqvEPLrl0Xy8KlPhY1z3jilp9sDCHAeQDTH1Al9R4L
 2BvbLExIYtdzgXWpI9icevjvaQ+4+0c9sVfb21ljaHg3NRiQ9gFRq75YhPFbVnaL4hPG
 Mz0/ipugM+GofYhgFb7wV0yVY0NUb4t3SBEX+4xS8/JIWUwCzVLRu0Xi7wa1gIV3SG8M
 1mR7hLik4w+pgs54Bo2maJm/NQJLnUju7VpGkbRtKxj0wqqLqE69rFGSIQsbwsoLGMdu
 EKzA==
X-Gm-Message-State: AOJu0YwsWczyEH7rBdcsaw8g/QJ4XMivTKGL7F4I0Q/wEN9jul7n/ndn
 zSdiV7iRRl1CJXYAu21vr0+rvV+niZ64pJHBmBOCFJ9vS/7kDfyhTuyyhYsBlnt0yiltR2ktlB8
 vofXCocg=
X-Gm-Gg: ASbGncstF6ANdIK+pT4CAVaTwnwb1R/wKHp63bnOZArXHPkwGedByOCETBLa7k7vLJu
 wDswKNVpaeOwBvY8ls2NCy4WOZc54e+3raAs8DxsqWullM+YhbvWSds08KaNL7jqAcU/rUu6Eut
 FaWx5U/Bbr+kmaKqa+I9t/LGY3dnqn5ndtCWHM61fnvo5AmE8qSHxs55LDuThFNreCdZm3tS6yX
 14VRT0Tz2z4bx4SIrQ+4ZXkfwXBg4yxdNI6wjgBmWaDT80vYNlezjyglYltDC/+0OTbovBEABYv
 +wgD40SbHILLCfjrunB61WPUxj3qusKhgdw3aLEZcr/pCLh062l3MGz9+lkV+1Ec7AQ1tUJXTQY
 68hiqPIuw0YodhGlp8Me++K8=
X-Google-Smtp-Source: AGHT+IFmExVLQwwWEwAI1iHSgR2OjEMSa1DHYDddy+pg3Q0mZvZHGIYswq4KU2auXv38Mj/qnP3o0A==
X-Received: by 2002:a05:6000:2901:b0:3a4:fc3f:b7fd with SMTP id
 ffacd0b85a97d-3a4fc3fb82bmr9282150f8f.19.1748938272569; 
 Tue, 03 Jun 2025 01:11:12 -0700 (PDT)
Received: from stoup.lan (host-80-41-64-133.as13285.net. [80.41.64.133])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f009ff7asm17668852f8f.90.2025.06.03.01.11.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 01:11:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 19/27] tcg/optimize: Build and use o_bits in fold_movcond
Date: Tue,  3 Jun 2025 09:09:00 +0100
Message-ID: <20250603080908.559594-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603080908.559594-1-richard.henderson@linaro.org>
References: <20250603080908.559594-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x52b.google.com
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
 tcg/optimize.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 42d5ee23c0..abcbee9111 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2097,7 +2097,7 @@ static bool fold_mov(OptContext *ctx, TCGOp *op)
 
 static bool fold_movcond(OptContext *ctx, TCGOp *op)
 {
-    uint64_t z_mask, s_mask;
+    uint64_t z_mask, o_mask, s_mask;
     TempOptInfo *tt, *ft;
     int i;
 
@@ -2123,6 +2123,7 @@ static bool fold_movcond(OptContext *ctx, TCGOp *op)
     tt = arg_info(op->args[3]);
     ft = arg_info(op->args[4]);
     z_mask = tt->z_mask | ft->z_mask;
+    o_mask = tt->o_mask & ft->o_mask;
     s_mask = tt->s_mask & ft->s_mask;
 
     if (ti_is_const(tt) && ti_is_const(ft)) {
@@ -2145,7 +2146,7 @@ static bool fold_movcond(OptContext *ctx, TCGOp *op)
         }
     }
 
-    return fold_masks_zs(ctx, op, z_mask, s_mask);
+    return fold_masks_zos(ctx, op, z_mask, o_mask, s_mask);
 }
 
 static bool fold_mul(OptContext *ctx, TCGOp *op)
-- 
2.43.0


