Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4BA4C83035
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 15:35:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWGRc-0000RF-07; Mon, 30 Jun 2025 11:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRY-0000Nw-Rs
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:16 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRM-0008Cb-W8
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:15 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-72c09f8369cso1286858a34.3
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 08:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751297343; x=1751902143; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XWCTAyFZpYLfY4pk7pvKybm5SaB2cnEmwYcfGu+sc/k=;
 b=l6MbZY3fzcZgXpJDHg2vFGOJ8h09sxfu7b4E1iOcjpNxN2nzR3/uWY43K0bG/KCwas
 Tyjx7a7CV7JaDxswJEINIQUNj57m0AZltdv+ChnsrO7wna52sLas6OVt9I/GjUfBgqSi
 xJH/8F6qBeqPLY0yb0q9jj3S+VM+LrQBXQaPnJSScnCOym+LH6hY8F6vG8EieFUWnR/Y
 X1Jm4YxxWuEcZ8OFqkhOOAVNT5U6oor+F4rl0m2h9Yf/VpFqyu15JEGvDaDs+AZJGDty
 gdtjhKS71YjTqclE6lWlpHp5c/X237MRx9V6pw4Zc+G6Sjunfk4QNo2BB8VrGnPovnkD
 kSjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751297343; x=1751902143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XWCTAyFZpYLfY4pk7pvKybm5SaB2cnEmwYcfGu+sc/k=;
 b=h1ItHMtu8ig63Khu/p6xjmiNcHtboRUzG9JETEwa3DOqH+oXZ+MC4wRg3EMl+gIQn3
 zeXHFRp/61JxuuLkZMEinh4UxDBBIkw9Hf/IIOb0qoqakJfG/qlVrvyK8IXkzhmu/Wyr
 5R8shmODwG0wHn23YoQ/HKmN81fd7KybUL1abJq9UdoEr9BW8g7maLNOoX/QzpR9z32m
 DNXYEKALfBVaIZ9DwUJE/1tdHsk1WpbgxOgk83221mats45PfUK1yhwn0MLfg4l8IbiZ
 xTIBTngRTz68rbmIYK/VSnRdOI/BQzebdL6G3ABL00nf8KUHN6bzeSMLrrCK/Bo8wNA9
 N5Yg==
X-Gm-Message-State: AOJu0YxFUlzZUpLMTCTnM3IbuZVcEy1QjLg6pFRKSLYM0VpYAnC5ZqPA
 oxS/w1nTsXUM4adgmJ3W/fgfEnoQz5jU/oqMCq8gKvPw6j3e3krLeJf3KFyRRjQek3v4XXZ0ffL
 kcIwS
X-Gm-Gg: ASbGnctGh6L1jgYbqmgAbfk382ZbD6SgVRrPRZYSexGfG1C8H//SFxwYMpG+lbGssah
 P6xrt+7bMqvGi90ovTWmXW2c5D5CSmMfY5Jqu4S0UMtoluuqsLwlM0WDJWqHufsTsGUj/IZ1JOb
 S5OMjNzEs0KBDrc/MlCMySBqYIP4NZ2KaU2Z8icxM9dEtORlXhlc1IU7L18SFgoqofSzF7dTgbx
 dUo/fmfH2ED1T8jFD3syEO/6nPTTL8cOTfWlZvH1sYSzCt43X8lr58KzHuLtJCaUWJfgvzFZbr0
 DzCZ/X3yeCee7y9T3TElbuiZksbynXPPO16kLX+gNFu8ufDQUVhrt53Nwdw18Y/8+ThaPg==
X-Google-Smtp-Source: AGHT+IFdVlZKuo/jzcP7bd7llTDjnN9z3gnNRDZSAooDBiiWgEmzAFJV0yE5ib5SCl2+byVQb2kHrg==
X-Received: by 2002:a05:6830:7110:b0:73b:bd6:dfdd with SMTP id
 46e09a7af769-73b0bd6e0camr6692075a34.14.1751297343030; 
 Mon, 30 Jun 2025 08:29:03 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb00c48asm1712478a34.27.2025.06.30.08.29.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 08:29:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 06/29] tcg/optimize: Build and use z_bits and o_bits in fold_eqv
Date: Mon, 30 Jun 2025 09:28:32 -0600
Message-ID: <20250630152855.148018-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630152855.148018-1-richard.henderson@linaro.org>
References: <20250630152855.148018-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
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
 tcg/optimize.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 123734b167..6d35a2e58b 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1093,6 +1093,12 @@ static bool fold_masks_zosa(OptContext *ctx, TCGOp *op, uint64_t z_mask,
     return true;
 }
 
+static bool fold_masks_zos(OptContext *ctx, TCGOp *op,
+                           uint64_t z_mask, uint64_t o_mask, uint64_t s_mask)
+{
+    return fold_masks_zosa(ctx, op, z_mask, o_mask, s_mask, -1);
+}
+
 static bool fold_masks_zs(OptContext *ctx, TCGOp *op,
                           uint64_t z_mask, uint64_t s_mask)
 {
@@ -1916,7 +1922,7 @@ static bool fold_dup2(OptContext *ctx, TCGOp *op)
 
 static bool fold_eqv(OptContext *ctx, TCGOp *op)
 {
-    uint64_t s_mask;
+    uint64_t z_mask, o_mask, s_mask;
     TempOptInfo *t1, *t2;
 
     if (fold_const2_commutative(ctx, op) ||
@@ -1946,8 +1952,12 @@ static bool fold_eqv(OptContext *ctx, TCGOp *op)
     }
 
     t1 = arg_info(op->args[1]);
+
+    z_mask = (t1->z_mask | ~t2->o_mask) & (t2->z_mask | ~t1->o_mask);
+    o_mask = ~(t1->z_mask | t2->z_mask) | (t1->o_mask & t2->o_mask);
     s_mask = t1->s_mask & t2->s_mask;
-    return fold_masks_s(ctx, op, s_mask);
+
+    return fold_masks_zos(ctx, op, z_mask, o_mask, s_mask);
 }
 
 static bool fold_extract(OptContext *ctx, TCGOp *op)
-- 
2.43.0


