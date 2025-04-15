Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5690FC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 19:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4luU-0008RO-MY; Tue, 15 Apr 2025 15:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4luS-0008QH-VE
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:25:28 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4luP-0007wM-C8
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:25:27 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2241053582dso82577335ad.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745123; x=1745349923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=72cGlcfTXUkZ8eDE1OmXiJGkbM/2dDEjFpS0ZCtWDGw=;
 b=caJEjwE4gruAfiKJ7kIbyf7ffM3ZjOMYSdqi5alZItpNruK2XPClaMvVyb7vUeN2VC
 kPh3DlVyFMOeyTHlF8MWkFdjSanw++H5dLksYuVM/CjwOHBpWjfDA5v89dd88OzT/6C0
 sR5rb67WnJQO/RxHaH1dO/7qFOdwqKf2mzTRJ44B3HfaZqhTsb6C2kyvdc08NP6L9J0j
 rqVQlRYcpYnmo2kNhPXROm80p/kNpNaoHkcPSC5DuNWl9u6mDRt27qzT8svyRMPSJUzS
 hCuh33TNgUrPgbHAcPzS+lxsV+3EojYTCu4XV71n/UxviD0sop2rBg2JN3V+Bc6o8/eV
 m2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745123; x=1745349923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=72cGlcfTXUkZ8eDE1OmXiJGkbM/2dDEjFpS0ZCtWDGw=;
 b=cdOLW2MZt/jPJ4Ml4GrCTIyrwiYYLcOD7vQYvpltKixzmmpzpKhnYC0gwfyh4aQ8q5
 OGuYuVg0lU+uzezkTozZSyE+Yms65kyUdsem8Iw+Rt5maT2VSVUPXIh0mskx6lrjf/6P
 uAvpy5EMwpQrkXdvBPMbQfaePCdZyRHo+y7F2xfbW6jRkXPdm3Gh5h0bpJX1Jk5LYxqG
 c8CZCvdpUAhtMCl8qdfv1QF0Z+gjVh/1wPXuIAseav7pwPsWSeNpimg/zdwm4GKXHG5I
 wHC7bCa+xKX0hVTJ5YgdYkgH/RRp/d0eeBUHjs2KcUKuUUoOlj5nOIq9JjwmzQ7xtxG2
 iHvA==
X-Gm-Message-State: AOJu0YwZDhi46iCY8zzj+M+ugUuY+LUnNuxpd6icMQdm5rN1WVUJ9J6F
 lLRhCW4c/GaI5FD0W6mzueoS6d4aX5DxJzD0QZE9XJ5PHt8AUfOqMJmXJopKfaOrlGwIDqHPFP2
 6
X-Gm-Gg: ASbGnctBdyzkRj1jnb+VQ3GVhvWJ2LZyMYHk2iAn0eusn4zKbP+L15rD79UdaK0A7X6
 7ODpBscpZGkpR6/IneHV59B7ypYLWkDw3OhDxeHzc0V2q8RPo4PT+qZINVAPMgJflMCmfYC8PfV
 dE61scjdOYva5au2wTjL2UPI++UoVwOpBFAnUve0+PhaNrq9QPVLDHRZiBJottD04CktfUTk5YN
 hpUX+M5Oa824cuGQGBAeSCN/9OZXWDefcUWivHcY8KftvzgQn5+OuizYV7IMbYRwyOsxz9lK0NQ
 BNTrjCxELIUr442Uv4Twe2TbykXtrQpDee8Px0rWtB3fzHRvL7GxZI90NYbs+agcU1EQNOJQSg4
 W1cZVgA8eQQ==
X-Google-Smtp-Source: AGHT+IGQUO9Zl+Irr07mQXJ6pFPWr5uUN9KCadTZmSCANVoMwiEuOyOC+c9XvfxvPASsOgVBlXofeg==
X-Received: by 2002:a17:902:d490:b0:220:be86:a421 with SMTP id
 d9443c01a7336-22c31a8dc2cmr4643215ad.38.1744745123506; 
 Tue, 15 Apr 2025 12:25:23 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd22f82ebsm9225124b3a.92.2025.04.15.12.25.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:25:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 009/163] tcg/optimize: Fold andc with immediate to and
Date: Tue, 15 Apr 2025 12:22:40 -0700
Message-ID: <20250415192515.232910-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index f217ed9366..0b84d97051 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1331,6 +1331,25 @@ static bool fold_andc(OptContext *ctx, TCGOp *op)
     t2 = arg_info(op->args[2]);
     z_mask = t1->z_mask;
 
+    if (ti_is_const(t2)) {
+        /* Fold andc r,x,i to and r,x,~i. */
+        switch (ctx->type) {
+        case TCG_TYPE_I32:
+        case TCG_TYPE_I64:
+            op->opc = INDEX_op_and;
+            break;
+        case TCG_TYPE_V64:
+        case TCG_TYPE_V128:
+        case TCG_TYPE_V256:
+            op->opc = INDEX_op_and_vec;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        op->args[2] = arg_new_constant(ctx, ~ti_const_val(t2));
+        return fold_and(ctx, op);
+    }
+
     /*
      * Known-zeros does not imply known-ones.  Therefore unless
      * arg2 is constant, we can't infer anything from it.
-- 
2.43.0


