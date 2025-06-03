Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6916C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 08:11:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMMiu-00012u-T9; Tue, 03 Jun 2025 04:10:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMiq-00010Y-Oq
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:10:12 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMin-0005i7-VD
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:10:12 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a4fd1ba177so2027286f8f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 01:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748938207; x=1749543007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sb4IKKb0kLmPSCYm8QqmAMxB0ZWKcO3Z/T7FCPZckVg=;
 b=gejlii6badDbS0pjBQA/Y+c7PCDlk0vNn0C5VIbHT2qARt26osQUjB119vn7kKV3El
 VW9usvhMP49XsnUs5RzKZa+mBBJW3RBFJABZqwNke3M3kwKasaq8mEtUORWpMm01c24r
 /Hl4Imb8IdKmiACsDoGfNhDbaj+g0TtZCrU9P8Nasq0G+s+HMqRbkzNbBi1M714Y+nVr
 ZCMjazQlucdvnBXjwe8k1YA3Ley6KGOVTNnWVAFOphfYDKPggCKEzCGpeXhjn8e+m4S8
 AuIqdWL+xVrj5UaKkHmksx09UBpXu8eXemwGy5qL0DPZSVqmEl4XWr1RuZWppOkcxnxx
 vTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748938207; x=1749543007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sb4IKKb0kLmPSCYm8QqmAMxB0ZWKcO3Z/T7FCPZckVg=;
 b=MqnWcr/+kSFxLbGO/LVWpP8X/R4qk+VNi6iSUVQAFgPWwDbYu+ydrm22E3JuEvuFRg
 MEKzBLFZuKnVPx2AoTm1BXckzeUF+tfxUl7IhsUsfseZMBJG8w8jpD721lvqhFi2JQcG
 NjLoyQOd3rYmHqldPQG72ltXI6paEs4fe6Z8MSM+dPRQ1VF669TArafpt9dZW7JvL/EB
 udhlZUMh9bWzLV2XL4cEvuaaO5naeDukipiTQ82aaJYwtTpD0A5XSYFy95PjKmy3jXLU
 Di8HCS7aT5iArzbevZmMX/RusHDsaq8HXmQcPJvnLaosT0LwZATXBRqtJ3BR+clMRm3f
 mTyA==
X-Gm-Message-State: AOJu0YwFAwoviqJrGVhAl/ffaFLuBhZ5HfWgClsOr1cEn9ZveYp+e1LO
 uI346aGnNCtHWUDkRzmX/VCbBtCgPyzlVHSBuKhaJdy7noxan+vsNLAcZMJFLHv8FN37SmBipkO
 OUomEb3g=
X-Gm-Gg: ASbGncs7Exg8evAzMAHt+/GvmZJz8jQulPMuDclFfLrLy7ZNP1GsU37u2Pgta7ZRiZq
 WiqoNxbdUcaY9mZMhFKMUdlW9dBt6PxVXncghwgPOeugKEb6a4nYk3BQd5OBO80QMYziJzX8AkH
 gbxLYAAUSBM+6TG2OGSeTT06JpWmik7ZNlZ0Qe0yOW4LkxpHTRfVTNRakALVRN1vn1yPF1Gc+CR
 IHNjl4SLPolvPM9V/iGjV7mVIX1nhrHaTnAc53wErmrvBtlt08A36yQX8QAqgIa1sEZURfMnClG
 zfAHPDBIOaV0/v30ypROn+L8Ig8wSp+k2J53mTdn1XRpyt98R1I68BFpC8djkO7zbzLQQ4IMExM
 U9si7UeSLMUXTrQCBEBMyY94=
X-Google-Smtp-Source: AGHT+IHDVAs0FQNUCv3LwjhKoLj9JipRhvny8pcAVtU5T3K1pvIEW9K0CIjm4PDCsinkgPdBWFOYMQ==
X-Received: by 2002:a5d:64c3:0:b0:3a4:d79a:3599 with SMTP id
 ffacd0b85a97d-3a5144c2ec7mr1003998f8f.11.1748938207031; 
 Tue, 03 Jun 2025 01:10:07 -0700 (PDT)
Received: from stoup.lan (host-80-41-64-133.as13285.net. [80.41.64.133])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f009ff7asm17668852f8f.90.2025.06.03.01.10.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 01:10:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 07/27] tcg/optimize: Build and use z_bits and o_bits in
 fold_nand
Date: Tue,  3 Jun 2025 09:08:48 +0100
Message-ID: <20250603080908.559594-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603080908.559594-1-richard.henderson@linaro.org>
References: <20250603080908.559594-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42d.google.com
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
 tcg/optimize.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 6d35a2e58b..758f7b142e 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2197,16 +2197,22 @@ static bool fold_multiply2(OptContext *ctx, TCGOp *op)
 
 static bool fold_nand(OptContext *ctx, TCGOp *op)
 {
-    uint64_t s_mask;
+    uint64_t z_mask, o_mask, s_mask;
+    TempOptInfo *t1, *t2;
 
     if (fold_const2_commutative(ctx, op) ||
         fold_xi_to_not(ctx, op, -1)) {
         return true;
     }
 
-    s_mask = arg_info(op->args[1])->s_mask
-           & arg_info(op->args[2])->s_mask;
-    return fold_masks_s(ctx, op, s_mask);
+    t1 = arg_info(op->args[1]);
+    t2 = arg_info(op->args[2]);
+
+    z_mask = ~(t1->o_mask & t2->o_mask);
+    o_mask = ~(t1->z_mask & t2->z_mask);
+    s_mask = t1->s_mask & t2->s_mask;
+
+    return fold_masks_zos(ctx, op, z_mask, o_mask, s_mask);
 }
 
 static bool fold_neg_no_const(OptContext *ctx, TCGOp *op)
-- 
2.43.0


