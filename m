Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE2F2C83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 12:49:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwoH-00025z-OR; Wed, 02 Jul 2025 08:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwjg-0004Ue-0J
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:38:48 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwjV-0002A4-Go
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:38:47 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-2ea08399ec8so3839945fac.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459911; x=1752064711; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ymtxh/t5Vz2HpH0lDSu55N56lt8mlCDF9TtMdx4EgyM=;
 b=tJau4tOmJw0sP3UDFwCwjPm9I3bl6BYQA8avv/eX+dQMYiThJYb5mV5/I2UPvXrO/D
 1qrLO1a+ykY/GS29R1zNyaagzS8PSbbdVc4ZRA/C/Iq3XkAvSVlphPpWaLVM5iOT8eHz
 g1QYq3GOwWxcOWrE+vfWypqohVoeUR0Tf4GEZJ9GwKUn/1xSlgSYy78OuC/pNrfl2ZKh
 7tAzAK0y6octqtP1wJEvpdS2LrHiEkksgR6SclDgQ9ac1nQB30OW+mEfWDtu4LVWpoeA
 HFdRc1pQzZa6Dn8Vdn+UOVsWu+2GCvMpf/C4ns+QxMCr9DMhmRF+8Z456aQcE9ErH0Ev
 8h6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459911; x=1752064711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ymtxh/t5Vz2HpH0lDSu55N56lt8mlCDF9TtMdx4EgyM=;
 b=DUK1C9FPEj62gVMaX1G2jG8pZDCGo8PJsdqAn103qoBHAleuCuvK86PDWnbGmtkoxf
 eoWQ5k8Cq+RMS27Mp/zL0XeP5AI3ZAwUNZ05KDomlTE2+WTQw6GVyLfLxN3HSOd+ZNpA
 Uir0Xdv2EE4irckqIWoHm8JHziJM+y+1BdfNh29ImTDXCM4wAlhYk9O6gNc+sWf8/g9X
 +PPdi+Cy+rkgUvBUTCP1wEegx4R0dXkw5P+dfVwa/0Ib2WvwE/CYvPvTgWqXROIxVb0h
 XWWnTyyeSWZwFisS2O+XlCwBtc67eO3J0D6r+wjxm+MYrbTv1XJgBJcKYGIdSe06xoNh
 2k9g==
X-Gm-Message-State: AOJu0Yx+R9syUaV/xv3inZoMyrTSyI+kmwS0d8JeV4RSCSLwlETwy5tZ
 /0aXGyvHvbvoeSFjVOywQgtmxTXcbzf7eOclN6to1QKA9xkjKBUE8Df6RU4fFQprDf3pEjdecJT
 o43SMTnc=
X-Gm-Gg: ASbGncvCsSwN2/KdBQumK5r6MohvB0R2tK2R11ey02oYG+LcPSA678tFz35b4pqx4q/
 +TKMJzA5v8orMApFsYkGjFXeXuG3wVKHXGHVSzmK3tthwE6mlo08AeGeqkyY6XgjBKry4wRJnB0
 qq4MNDZU/LVd65JFFdcAw1ehZt/0oUg+kEbvjt4j6/+LhVrQC1halLveHuyGHEm91EQ14f71WuM
 YPWHku41iLSy7i1XMjATmoyiaAvxiwnjbMD3bSeQDe+KieVrMmN0qmtmNWc6c9NOopm2KqoVJNG
 IntamYw/ehJYIy+Rxbb6gTmksWksUPN007/RGBCsNE3rKivYdEI0pMOrWvx5m78OVOQ/gZWXwUn
 Jotur
X-Google-Smtp-Source: AGHT+IE31TBwuBdeBf4OED1e31fTW0REoNFsooj+GvNtla6HpctZDID1yVjZGA+GPHPq+k4HP0yilw==
X-Received: by 2002:a05:6870:ef05:b0:2f3:e087:7ced with SMTP id
 586e51a60fabf-2f5a8ba6a07mr1858594fac.2.1751459911225; 
 Wed, 02 Jul 2025 05:38:31 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4ea5d9fsm3843451fac.10.2025.07.02.05.38.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:38:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 61/97] target/arm: Fold predtest_ones into helper_sve_brkns
Date: Wed,  2 Jul 2025 06:33:34 -0600
Message-ID: <20250702123410.761208-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Merge predtest_ones into its only caller.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/sve_helper.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 8fb9d0241d..5014fd135d 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4061,31 +4061,25 @@ void HELPER(sve_brkn)(void *vd, void *vn, void *vg, uint32_t pred_desc)
     }
 }
 
-/* As if PredTest(Ones(PL), D, esz).  */
-static uint32_t predtest_ones(ARMPredicateReg *d, intptr_t oprsz,
-                              uint64_t esz_mask)
-{
-    uint32_t flags = PREDTEST_INIT;
-    intptr_t i;
-
-    for (i = 0; i < oprsz / 8; i++) {
-        flags = iter_predtest_fwd(d->p[i], esz_mask, flags);
-    }
-    if (oprsz & 7) {
-        uint64_t mask = ~(-1ULL << (8 * (oprsz & 7)));
-        flags = iter_predtest_fwd(d->p[i], esz_mask & mask, flags);
-    }
-    return flags;
-}
-
 uint32_t HELPER(sve_brkns)(void *vd, void *vn, void *vg, uint32_t pred_desc)
 {
     intptr_t oprsz = FIELD_EX32(pred_desc, PREDDESC, OPRSZ);
     if (last_active_pred(vn, vg, oprsz)) {
-        return predtest_ones(vd, oprsz, -1);
-    } else {
-        return do_zero(vd, oprsz);
+        ARMPredicateReg *d = vd;
+        uint32_t flags = PREDTEST_INIT;
+        intptr_t i;
+
+        /* As if PredTest(Ones(PL), D, MO_8).  */
+        for (i = 0; i < oprsz / 8; i++) {
+            flags = iter_predtest_fwd(d->p[i], -1, flags);
+        }
+        if (oprsz & 7) {
+            uint64_t mask = ~(-1ULL << (8 * (oprsz & 7)));
+            flags = iter_predtest_fwd(d->p[i], mask, flags);
+        }
+        return flags;
     }
+    return do_zero(vd, oprsz);
 }
 
 uint64_t HELPER(sve_cntp)(void *vn, void *vg, uint32_t pred_desc)
-- 
2.43.0


