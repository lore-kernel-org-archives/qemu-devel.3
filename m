Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3398DC5B559
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 08:14:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMMjx-0003om-H2; Tue, 03 Jun 2025 04:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMjo-00033E-4w
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:11:12 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMjm-0005ow-2K
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:11:11 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a4fdc27c4aso1613710f8f.3
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 01:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748938267; x=1749543067; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+GqWQo+w+tjyq4sllYwzFk28p9KJiT8wTCZDpo4XdKE=;
 b=UzxohZL3NHh+K5DQB1YefAO4pGK6jN9FrWXYdqOkNK3Obw59T//D/2mWTf/dDTtPgk
 Tj2JtTWSd/DQiPCg1VyMAFzjwEtGfKZt0Fl6Onu78QBMlMzFsMMhluTkymyf0aUCafwM
 lIFshBdYEUa4yuYyKmOevVkKpDctN1DXRTV5qSOE/f6VgxMNmEDyItgWc3DeSb0RafpR
 cl86jFHq/S7yW0c6NXrHIfZbrZ2Ij0twoCX4thA2zwOjVFvIiC8cWhmDJLcxD3wP+haD
 +TccMpku3JTU/Z+dsQ1VbF1v+vRxEYYM3gptN14lh9VvNa4LnXKvMp0w8PqYo2t9DLy+
 j68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748938267; x=1749543067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+GqWQo+w+tjyq4sllYwzFk28p9KJiT8wTCZDpo4XdKE=;
 b=G1xm6ukpQcUsm+BJ8ofYHTsGOrKtsGOMsZYqAfCCIgEs0i/fFcb/XzwT2COJsYdGb/
 8mrOrYdhAAFxzTca8aMUOjxD8jH0RspCON6Aw54slLpW6TD7fGgmlsqbEeW67kTXGBrs
 b6kvqdr5WwiPEM3eszlXZzjfktY9lPQTxSJt8SP75ONKDNKN6q/xI6TOCh54Hl9tncnx
 JQZj1SpVr5BS0tOenhykNfPAK06sQbGwO1gtwuod7LGqB5BfLjAKZgjFYYb8X31vGeyg
 v/XhfmhWXAhzCaJOWXQpkcBG9HfxUUqE3S197TRWsiEsJU4sZAujuSw8hI1gJd6vL6qd
 7+7g==
X-Gm-Message-State: AOJu0YytE0Qj3ATpx09BoY+198HDOyHOCHrY4oETFKKo6TfaSio2U6rh
 oDQ4VR3EpvQgXYipf5cIxa/051xYIUWmvE8zQlDEnu4BJiorWM/XqpbBHrKRMYYuArADVmy+c4x
 v2yOXoOc=
X-Gm-Gg: ASbGnculWe8f9ZWABM84zrUHgq4sllhrAFY8O8fJOXywDyoUIiB0b/pDWoYypIZYqC4
 MpyaKoGVOYEFGuWPU/RhBR+g22whF6ERJf2doJPHl5Kpil/xbyXbZeCdCp0HFkDqV93IDUlhY8l
 fJdw/ijGveJlsmK7Ir4zBb17o2mvLo0E9HweCPRZ9yJyoAv8+aH3EqsjsVPbEHAYStYN6uZc5X6
 B1MOAFgipwRoDZeiYenekSQw4ZArWoi/CuWQOoYcVoqAZI6m0wub9zNlKFyRX8F00z34cOb0dbP
 7igGKZMCLqUMLwXMtpXuOO0GjUWJ8+d7lh4TAn95bhes6KCLi/svRHjjoch1DZVZuL4i7DNp61G
 3Humu6oIA5RfWVxUZkbT2hogt9ibcpjsjZA==
X-Google-Smtp-Source: AGHT+IFtnGQtu7FXP0Vj6tB4aN4r+Cq7W3eeBWrvqRBVwW+NupuTCnbQ0Qw72PiZv09AQA0AgJZ56Q==
X-Received: by 2002:a05:6000:18af:b0:3a4:efc3:88d3 with SMTP id
 ffacd0b85a97d-3a4f89ddd87mr11965415f8f.28.1748938267189; 
 Tue, 03 Jun 2025 01:11:07 -0700 (PDT)
Received: from stoup.lan (host-80-41-64-133.as13285.net. [80.41.64.133])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f009ff7asm17668852f8f.90.2025.06.03.01.11.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 01:11:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 18/27] tcg/optimize: Build and use o_bits in fold_extu
Date: Tue,  3 Jun 2025 09:08:59 +0100
Message-ID: <20250603080908.559594-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603080908.559594-1-richard.henderson@linaro.org>
References: <20250603080908.559594-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42b.google.com
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
 tcg/optimize.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 103c94b12f..42d5ee23c0 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2039,25 +2039,31 @@ static bool fold_exts(OptContext *ctx, TCGOp *op)
 
 static bool fold_extu(OptContext *ctx, TCGOp *op)
 {
-    uint64_t z_mask;
+    uint64_t z_mask, o_mask;
+    TempOptInfo *t1;
 
     if (fold_const1(ctx, op)) {
         return true;
     }
 
-    z_mask = arg_info(op->args[1])->z_mask;
+    t1 = arg_info(op->args[1]);
+    z_mask = t1->z_mask;
+    o_mask = t1->o_mask;
+
     switch (op->opc) {
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extu_i32_i64:
         z_mask = (uint32_t)z_mask;
+        o_mask = (uint32_t)o_mask;
         break;
     case INDEX_op_extrh_i64_i32:
         z_mask >>= 32;
+        o_mask >>= 32;
         break;
     default:
         g_assert_not_reached();
     }
-    return fold_masks_z(ctx, op, z_mask);
+    return fold_masks_zo(ctx, op, z_mask, o_mask);
 }
 
 static bool fold_mb(OptContext *ctx, TCGOp *op)
-- 
2.43.0


