Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA46CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:06:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXyg-0008Dv-5D; Fri, 22 May 2026 18:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXxk-0007jT-Nx
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:24 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXxj-00089I-2T
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:24 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-367d88b9940so5145205a91.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779487402; x=1780092202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9z+JFOy5VW1L9e/IPMpyMJ75J7iMlDKsJ+qJyg8YwF8=;
 b=DeJbLmPB0IOeNXZbOfD6ZzVqJdxn4u0dykAUEYK3Qr8L2oom1z/jEMzP17G/Qxf7Jc
 PQp5kcY/DDXE0b1F2JFRq7SyTpUiVEWwJcEPiiXJX71B/8+syks1R49fD3XW4VBEnx6q
 /LWC04WOotj7Wy++rNoeEYJ+l6M+9/lxYIhYIDFZ1cipY02pGNvI1mhdWycib4zcIdRt
 x+Y2T+p1ebTLgIMUUXdKckbNKpkvlRQ2pA8f44Pp3N/+ODUfiQ8mANXZh3cvmioAmlJI
 BSOqWPImvwCocxViSBUUBds4BVm6Rko97Iy9pJcLR9qxjlqdS67NNSltzefk56XoVFfw
 eO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779487402; x=1780092202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9z+JFOy5VW1L9e/IPMpyMJ75J7iMlDKsJ+qJyg8YwF8=;
 b=XU5RFy+ssSksY/U0nr37Zhl2sYb0KqFXU5i7QLFY4p9mchGqpxWY8WqlBiYyLJ2YyO
 vkuTTq5X7/sTNA5sgaHY9JhLZ/ebRKE+9ZQYIOhn7VGCj0P056SbXR495ilrUUjcP5Eb
 sFLEUGpsk5i7bJ8Rz1Fd0sNA6d0rWcE81hPZtYsjeWOG+ICV00+evoYuT9GGb+1sWE36
 AiVs77Nqn9W8Z3tIP29rVKMgPC16QWUrVYOgb4EXJq++Siwb88EvHzIVidRf0blV6hME
 +TEXcBe1N87xJMa6xsg5pIu0d0Z/tl2HkkAuDscXkevyFXRceuHoHh6K3pPRVeXpwHDS
 VwOg==
X-Gm-Message-State: AOJu0Yw8p17FBXxEdGqmSqj5B5z9iGg5Ff0YRPORszoHgeL2SIjqhOW4
 OHSWxmvc7G95/T5f3Ey15xNwrB7/IcIyIT2b4zWBpk0yUf9pT5DIaWvq8WP3mr19ciE2qN67uTL
 Wn9Zy
X-Gm-Gg: Acq92OHMJdPKXwWCokPWfpv3sCAb3QZqVXc9IumzlTpqZ+/vDZtGauYmwDAvmC9xyHi
 V0c0mvk/OLsUAPMHFBWg+qx6cUyhWA4Lnq1wFNvMzcYP47IZELsXmz0WNLqbOwOk5tgM2SSHmJg
 +Ygcf1pL/VDShGghXQDgqQimMgguyTmKFqoWuYBLpkHESA4ofx/s0Dg5P88+RzYLTxZLEW6SMxf
 pEF6crJ7e8Fm4dYXC4D7sUjut+77aQNxic8FGMBof4fP8ny/Z3MbpW7th+MGEOwBCu+z/c5jpBy
 gXAKNnVUxShCrQH5nkXUNrnYVlVWhySPIlDDFBdr2+nbTy7plbTVG66nF/CBG9xurrQvujOPld0
 WlerBe7SjtSb1vrkMTtUbumVauyOmkIfh5Hjbo4h2zh2U0XZ5dkluWTyj81ZapovQU664AQ8tNR
 JojUBSDZQDi7uxNWPQmBmvvtevtLwn
X-Received: by 2002:a17:90b:1e06:b0:35d:9c32:6219 with SMTP id
 98e67ed59e1d1-36a67734210mr5298628a91.9.1779487401526; 
 Fri, 22 May 2026 15:03:21 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a6772f486sm1726789a91.2.2026.05.22.15.03.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 15:03:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v7 13/64] target/arm: Trap direct acceses to FPMR
Date: Fri, 22 May 2026 15:02:15 -0700
Message-ID: <20260522220306.235200-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522220306.235200-1-richard.henderson@linaro.org>
References: <20260522220306.235200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index d1a581acfd..41dd013784 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2899,6 +2899,10 @@ static void handle_sys(DisasContext *s, bool isread,
     }
 
     if (!skip_fp_access_checks) {
+        if ((ri->type & ARM_CP_FPMR) && s->fpmr_el != 0) {
+            gen_exception_insn_el(s, 0, EXCP_UDEF, syndrome, s->fpmr_el);
+            return;
+        }
         if ((ri->type & ARM_CP_FPU) && !fp_access_check_only(s)) {
             return;
         } else if ((ri->type & ARM_CP_SVE) && !sve_access_check(s)) {
-- 
2.43.0


