Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38552C41513
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 05:09:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLyPm-00013C-05; Tue, 25 Jun 2024 01:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLyPh-00011W-7q
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 01:08:17 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLyPf-0001VC-1X
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 01:08:16 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1f6a837e9a3so31324745ad.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 22:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719292093; x=1719896893; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SxSbNTyLqm62CyX0wlj5AbMtTOd0dfgBThbteUcz5rI=;
 b=FWD41RekZQtVGMVobvF8Qg2MLiuhZ9mQR5ek2awl64oCckp9p84F0+rhDTLJhKqVSu
 9qVoiOW2jXce4It1jdaGxx/SLmRsgCUD4sL6zDgA+K0wIX9PnGLob1bqvKk50KPtbX91
 2JKKwuyDVPJAlM+XqwJRR2TLGmyy0Cc1GISVzEU4LY+Jq3lmPx4crDrzMR/jJ3lO7uLk
 Zwed9hVTe4Zsio2JDLl/VOch5DFAr70kmiJXhCCYGPlNWh9NZwqKvanpWEX4KJ5JLYgv
 QvlvyVL2IgEk4pTT86oIkxIwPhGbDv9eiJAFYNna55v2xxm75hT29wAMWp6I6hsGlmgH
 eWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719292093; x=1719896893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SxSbNTyLqm62CyX0wlj5AbMtTOd0dfgBThbteUcz5rI=;
 b=tUoiDHebIHhYebopr5/hoO0DY8x8gDKnLduGzWqU0J0EVjY7l9q4Z6CQvguy/cnbep
 eHYYbbIkwyp6d/8xnUD3ykZxc6w5BzDovqxmlZ/9lZ7TSF3ds6EXH0fqht5Kc4m0WBty
 KjFfF2lboD6nRZ33DmyPCWK5il4OLQovCEdhevS+b0eePZsL5rkAV3Z7TqtNpvhmRQoq
 NwIXKCGVJ4oW4rkzePqImx/TEoY7D/t/hJBOFGJMG3h291zUyhl2RA7ZeSa0CTYd2D2w
 bxfj3rntbXPjjQw6+w2ortraCrYljMQlYFvwVEWtzMo/2vuyDC3m3fWTLXslVYiJvYhV
 tPDw==
X-Gm-Message-State: AOJu0YzCWUmljup1oKZ2JWENGSyj8AeNLXs7rDD/6diKhBUk3Vg11yJ9
 t0KaAEjqDrvPUTyiyH4XOdf1QBhlqAxOHnNuo2oG1oYF1oapxLbUI25P2J4Q5rm38WEPaLceM4D
 L
X-Google-Smtp-Source: AGHT+IEKbgLPjnAmgrL3V3V8cz1vKIc6oa8zgfNP94DDWXKewOHxkTzue41GWDYFFudtvWaqlDqlyw==
X-Received: by 2002:a17:902:f60b:b0:1f9:fa69:dd4d with SMTP id
 d9443c01a7336-1fa240f27bemr73490835ad.68.1719292093207; 
 Mon, 24 Jun 2024 22:08:13 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9ebbc72e9sm70843865ad.296.2024.06.24.22.08.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 22:08:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-stable@nongnu.org
Subject: [PATCH 01/13] target/arm: Fix VCMLA Dd, Dn, Dm[idx]
Date: Mon, 24 Jun 2024 22:07:58 -0700
Message-Id: <20240625050810.1475643-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625050810.1475643-1-richard.henderson@linaro.org>
References: <20240625050810.1475643-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

The inner loop, bounded by eltspersegment, must not be
larger than the outer loop, bounded by elements.

Cc: qemu-stable@nongnu.org
Fixes: 18fc2405781 ("target/arm: Implement SVE fp complex multiply add (indexed)")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2376
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/vec_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index b05922b425..7b34cc98af 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -907,7 +907,7 @@ void HELPER(gvec_fcmlah_idx)(void *vd, void *vn, void *vm, void *va,
     intptr_t index = extract32(desc, SIMD_DATA_SHIFT + 2, 2);
     uint32_t neg_real = flip ^ neg_imag;
     intptr_t elements = opr_sz / sizeof(float16);
-    intptr_t eltspersegment = 16 / sizeof(float16);
+    intptr_t eltspersegment = MIN(16 / sizeof(float16), elements);
     intptr_t i, j;
 
     /* Shift boolean to the sign bit so we can xor to negate.  */
@@ -969,7 +969,7 @@ void HELPER(gvec_fcmlas_idx)(void *vd, void *vn, void *vm, void *va,
     intptr_t index = extract32(desc, SIMD_DATA_SHIFT + 2, 2);
     uint32_t neg_real = flip ^ neg_imag;
     intptr_t elements = opr_sz / sizeof(float32);
-    intptr_t eltspersegment = 16 / sizeof(float32);
+    intptr_t eltspersegment = MIN(16 / sizeof(float32), elements);
     intptr_t i, j;
 
     /* Shift boolean to the sign bit so we can xor to negate.  */
-- 
2.34.1


