Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84CECC5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 08:12:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMMjw-0003hz-FC; Tue, 03 Jun 2025 04:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMjX-0002Ov-MM
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:10:58 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMjU-0005mX-EK
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:10:54 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-442f9043f56so31729215e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 01:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748938251; x=1749543051; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=alu4+06hafBjdM//+iURuOExniKuVOhxa2fbp54muUc=;
 b=iq/NZmaG/DlwTQtBVi+TocSK7e1ZRGGkGD/aNP0OvTs5cb8NSoRnwee0EYrpGKLamG
 eXRFCiRvWD6p1pp5HhmQLu3hQ0LSAX4PXKeGE5nCCIzJSpK2iUlenMUiuYmKP7pImhzG
 QeYq+bfXy4ovFQtLFgi4dEhJyjNhhuEVNInsBoYAMC+2QpUzrmGzuVv/zfqD3jdu1baB
 ypwUUcS04ByvVsg1lYsN5+2L4eKpgLhqoMLssQNZRdvN1gYLX3djySY4a6WpChpSeTPc
 7vb1neT4oTFQef5WPQUA2MXPB9t4KU/61xyBqcgYEbzyU34di/mJTqGMWhRirDcOxEVc
 5nTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748938251; x=1749543051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=alu4+06hafBjdM//+iURuOExniKuVOhxa2fbp54muUc=;
 b=H/H6WZ7j/ASVatxBd61hgRqp7I3mjr7Q3NZBvuzA8S0KYrxruFMPtHa2hM3Z5utjKE
 jrkXNw8+8EmcPTxlQR5EgoEzqlDz2w32eMpMuWYJ8LPvlGjQ8wmIZJonQeIvkzWqwoVs
 vuOemXp/Z01radv9El8keAHr7lFFfg7sV/2ZaaIEq21ZPuyI7gly/FSxm2PFvus8Kqf9
 r3t1kEVOkgDQIu8ayC0rXTHqEw1K4aTRhR2EYUJhqK2eLkxpWq2HzE35ujC/oKz1uc8e
 ogjDuBI4pFj8pNnT8FGgH8loKSuwQ18s74LOWy4W79seTM3zcPFwoK04hO3JXoEQ5VEt
 wAog==
X-Gm-Message-State: AOJu0Yw5cJV48biKR/ZngqHWaCYXjm/uoqJMZzahw3YeUBz2xkr7f5Ih
 TJ6tahuZYHzTSZOOrNSlfiGasQ0HSJfTo+vJadXp8ykucSS/MGYimnuiGoK3MoMZoEMH1I/z2kt
 x09SUSyI=
X-Gm-Gg: ASbGncv42+ykblBXBdNx3nD/k1DYjMl4yEYQQ5DMbl8tCjDCO5X36fqudCAH+l/7iaz
 hQlIvx7dLPjbpjkRH2YoJwesTH2ScSgt3NdaME2EGuA2EOJrspEQhmNhmC4vzJRLEJ1ozu1/JvM
 0tREF2ezdarCzRot/skh52AowEiFemfmR2LCU5H8HnLEmTodU6puxHUTiLkN97Oss6uarBBJeJc
 5R7CHVr+mW0Q1zFip/0KyyrHQGMMqr5PQZ2hfAnP1Ag/pehQGFBUqbtiV0lCRc1PjDfZjJxl0lZ
 JtJql7Z6blDSnohK77L6vPVo0EsAKIAAurWXuW33GsgOlBWhJGL61UbM/iGN7KDFKWoQJWpn5fU
 v4CkKvpXWD42mJ9FiNAxHMe0=
X-Google-Smtp-Source: AGHT+IEJL6/gkQnA0JCuGug+BDNK4/d2IJHZ+xAdN1mRczuFfysc5SVKmF/kwZk4pvtokoPPYWtDow==
X-Received: by 2002:a05:6000:2207:b0:3a4:c8c1:aed8 with SMTP id
 ffacd0b85a97d-3a4fe398eb6mr9657602f8f.39.1748938250766; 
 Tue, 03 Jun 2025 01:10:50 -0700 (PDT)
Received: from stoup.lan (host-80-41-64-133.as13285.net. [80.41.64.133])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f009ff7asm17668852f8f.90.2025.06.03.01.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 01:10:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 15/27] tcg/optimize: Build and use o_bits in fold_extract
Date: Tue,  3 Jun 2025 09:08:56 +0100
Message-ID: <20250603080908.559594-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603080908.559594-1-richard.henderson@linaro.org>
References: <20250603080908.559594-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
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
 tcg/optimize.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 043568a10d..f5fc0cfff9 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1963,7 +1963,7 @@ static bool fold_eqv(OptContext *ctx, TCGOp *op)
 
 static bool fold_extract(OptContext *ctx, TCGOp *op)
 {
-    uint64_t z_mask_old, z_mask;
+    uint64_t z_mask, o_mask, a_mask;
     TempOptInfo *t1 = arg_info(op->args[1]);
     int pos = op->args[2];
     int len = op->args[3];
@@ -1973,13 +1973,11 @@ static bool fold_extract(OptContext *ctx, TCGOp *op)
                                 extract64(ti_const_val(t1), pos, len));
     }
 
-    z_mask_old = t1->z_mask;
-    z_mask = extract64(z_mask_old, pos, len);
-    if (pos == 0 && fold_affected_mask(ctx, op, z_mask_old ^ z_mask)) {
-        return true;
-    }
+    z_mask = extract64(t1->z_mask, pos, len);
+    o_mask = extract64(t1->o_mask, pos, len);
+    a_mask = pos ? -1 : t1->z_mask ^ z_mask;
 
-    return fold_masks_z(ctx, op, z_mask);
+    return fold_masks_zosa(ctx, op, z_mask, o_mask, 0, a_mask);
 }
 
 static bool fold_extract2(OptContext *ctx, TCGOp *op)
-- 
2.43.0


