Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5325E7718D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:10:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBE2-00026H-Eo; Tue, 24 Dec 2024 15:09:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDZ-00079L-KD
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:26 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDY-0002zP-1e
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:25 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2162c0f6a39so64892305ad.0
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070963; x=1735675763; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B8Kb81fRDUd8pwBhno+Gknf2gcOv41osiELdqm6o4Ig=;
 b=Lgt/MJmQ63Xwe+Ac77FMc9sAUEiFoSCxZYYx+EP+aIn2qKkhPVJL3eq/gkLj6YaCqB
 vr22VTi5Vz/kroWg3TQ/JBuYMkIBWHRpTURSGIYYuI9mdfmjs7BGLzAr+MxYpEOiv92h
 PyaCA+UmpOPyZYuuBDgvbumQK9Rv3nunQxbeLrL+md6IDY2b0VLYEw6/0y1FHv6EfQy0
 d49rq0l+TqTy/CigU7MJk5V39swjMcDD7k+Db1QTMNTcTvr0aBfO8CmnOzo53yv4GVlF
 8YAda8VS1aRY7trkAfR/bbaxqvL6C+i6Imxxp0b3Dg2+jTTy+91R3/0RTbkHmYhaDLqs
 4fxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070963; x=1735675763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B8Kb81fRDUd8pwBhno+Gknf2gcOv41osiELdqm6o4Ig=;
 b=YkneBrW6MAdsVkc0udkaN9cmMjtgGv8pOaiDuaGKhEzMRNbBPT5YMi2rQY+9ZPGIXD
 ruaoxF2mo/IEMrdHGHUMzcg6ay+V3ZbbtiXgSN1q6akJlhgxrFzbXiu8KoGxWw5xPQ7r
 gt5d4ixosK1y78Pqx9eTLgsoeocMGSIBpcMcRWciLhfazvHjiIcU17j9wQh3T/O1Ho4U
 rOsRlRJk8ga9ku7t9MVHLmcT1PCK2gE5ZlqWMl65fy2Hm1WN6eQprerZEk63i1+yeCzT
 VuM+pwaObnYI9cu3mwUmHshpVbv8xJCRFXNLrccLtw4g++2IZ6HdSiYSkTr/A8gWcNM8
 H3Tg==
X-Gm-Message-State: AOJu0YxDPR3i4cfWa3sFtqvn9xVF0HAyyB2AjEiAwg9z3SuBYUjz78VL
 KpsjHyAENlEBIue2CQ4SakEmPVV0ZJk4nkdWNsYdotwAGKI4wwo40jheRS+wWGj+gBrtwg+8o71
 pEcA=
X-Gm-Gg: ASbGncvf0pbHQPmbx8WmlDy/ZKyNecmi1U1S9DRaooZGYPY7viFCx3qyEpc8VUgixy8
 BWU5NRdivLHsQeMxW+l1hHZLdyT49fa8YrQf8b3cPoD04W5bj1cJlpgHrayKRDJHLSDrAQvsx4S
 PXjCsI7abiPPXb9BSK1fGKxLZVWnRjzhVNJSyFTfN+/0tgngHR33B4Pg8bWW3U0o+vXEvOSUH9n
 ytcYYCNt8lkfgJNA7X/JRbyZQAZT8YennvLyHk7Et091QGv1UHKQDJxZaxbBf24+XVYBggScG0F
 DezCrgWUS8sURNHSguSIj8+11Q==
X-Google-Smtp-Source: AGHT+IHQgSqyKj1Y4aa4cRc35gFRHG5lMPsqgOwxt/+G3QwViO/UYuKvwuK5OFgba/QW6BbIflky/A==
X-Received: by 2002:a05:6a00:820c:b0:725:ce39:4516 with SMTP id
 d2e1a72fcca58-72aa9a3edc8mr28305995b3a.7.1735070962737; 
 Tue, 24 Dec 2024 12:09:22 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8309acsm10033521b3a.45.2024.12.24.12.09.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:09:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PULL 63/72] target/hexagon: Use float32_muladd for helper_sffms
Date: Tue, 24 Dec 2024 12:05:12 -0800
Message-ID: <20241224200521.310066-64-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

There are no special cases for this instruction.  Since hexagon
always uses default-nan mode, explicitly negating the first
input is unnecessary.  Use float_muladd_negate_product instead.

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hexagon/op_helper.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 15b143a568..95bfa5d029 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -1096,10 +1096,9 @@ float32 HELPER(sffma_sc)(CPUHexagonState *env, float32 RxV,
 float32 HELPER(sffms)(CPUHexagonState *env, float32 RxV,
                       float32 RsV, float32 RtV)
 {
-    float32 neg_RsV;
     arch_fpop_start(env);
-    neg_RsV = float32_set_sign(RsV, float32_is_neg(RsV) ? 0 : 1);
-    RxV = internal_fmafx(neg_RsV, RtV, RxV, 0, &env->fp_status);
+    RxV = float32_muladd(RsV, RtV, RxV, float_muladd_negate_product,
+                         &env->fp_status);
     arch_fpop_end(env);
     return RxV;
 }
-- 
2.43.0


