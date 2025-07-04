Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F62EC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:36:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhOT-0001Q2-GI; Fri, 04 Jul 2025 10:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhLd-0003fO-Mw
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:06 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhLZ-0007d2-V5
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:05 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-610d86b3da9so260768eaf.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639100; x=1752243900; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1S/ZQDP5c+NZHEEUkGxsFokHGbVaRKZEhtxQ6fYJ0KA=;
 b=AiR0jwSBXUe2s4r3HOLYoL1aJb2VqCvvDMAQxLrfHcZ1q8HQSy0QQ/XVf2G/3eKUTw
 6AA+O110lf6BSlPyX4Qv4k6sKPBic6ZcxgSy6eiR6dYPt+3UTH/kJ1Y2Ir0wcmBFsWoM
 tk3yNAb7Ll7tC0vHbMQol97EYLqKbJZph5nX6cO03n2Ex51jq8aYxHRWRqiG7fNgVkfr
 gzJfKs5c0JDhGyK3zZgDEQlzcUkuDYlXM8/qk6SSvzZxZWwli4+59jTiWxOaPfC98yx7
 VSOHvpB8FvZs7Q09W8OPG+j+GkV8TMUHo3WmCOL/92CGlT+VWaV5/jognfEMOgJ7yjoO
 +AEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639100; x=1752243900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1S/ZQDP5c+NZHEEUkGxsFokHGbVaRKZEhtxQ6fYJ0KA=;
 b=KrTU0PDamurI/pwcr1WNE4tUBt4iL8bmX2YPPW4C1psJkcaMeZyIMexGe5O8GJJOeI
 VXZxYtZVbamGzxiZPPWbB/mOLBPmI5OCeeKByMObHMxVvU12lzIqRTjw7Ld1pqCha1PK
 ESnopsT2UGOpTZ9Ek7l43U4mCP6cT1J+zbXJSLPxZ7FIPB7Di6mmSgkZN3t5q4auXOFE
 hT+QtR1sXqvKW2lVrsVJulL+3l7t0bj05qpwZBPMbJtvLuJ1KNQN3ODhosTGwGbPKVn6
 PqYiF8A0BUPK+LWZAGoUksW9TFPB5AmXm5z36VgYVxFUp5Vhk2cUn364xFjvdYeyLK3E
 kvFQ==
X-Gm-Message-State: AOJu0YyIew0PJlvVLYnsDHKvuhX8dqGmyeC9y2dLIzq0GJGexk/yVuvN
 dxjzJhhzRvk3beq4aoiZMbTHFYSQPGZ1MQFfcgfw+zyIikvI0FkAQhZQSlbVI1uX46BX2u3XXBL
 c1qi4ras=
X-Gm-Gg: ASbGnctmbLfGyaIyc3EsjR//pFedNRgcBMmtA/xrabahzkcAOp0TdwQ12AiNn0TxlO9
 oSqjYA5HXeacX/yEbYMkZEFbazevzUdsZcFNo86dKas+xwcidP66Xop4lBLDus/GsKuSUWZW6o0
 q0qS/lLa5UT7CvQB1TQ6Do+Rd+pnwhCP/+GxqFszjVHDbqFUtkltOFmkd++c3ysqzN/r1yh1Pqo
 RbKRjMHbse7CnUhFGa9kqYyyY7O+6TnPwI0KpwXSFLr+bx/Rye77TccF79dABlZkpcK95Ii6oQ8
 kdOJFlDG10bN8XibpLxXDCW6FL4iep5BsZVxBmpwhUf74knNuUms51FXGfLvGtqHXKtjAEVrHM2
 QXlxod+IKU9rLw3coqqVXQevD1fO6PXoBq7rdLzpcLPrgaGUB
X-Google-Smtp-Source: AGHT+IENJbKkzKEqPlA2I4O5yp47X09bUOYitsgmACZRGrRzvjyHWLuBxkGFPbJlztMcmcMw9y4SRg==
X-Received: by 2002:a05:6820:6acf:b0:605:f34d:7e00 with SMTP id
 006d021491bc7-613901117a3mr1982032eaf.7.1751639100312; 
 Fri, 04 Jul 2025 07:25:00 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6138e5ac5eesm310233eaf.29.2025.07.04.07.24.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:24:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 043/108] target/arm: Tighten USDOT (vectors) decode
Date: Fri,  4 Jul 2025 08:20:06 -0600
Message-ID: <20250704142112.1018902-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2b.google.com
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

Rename to USDOT_zzzz_4s and force size=2 during decode.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 4 ++--
 target/arm/tcg/sve.decode      | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 56353b3bb4..c82a0f771d 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7151,8 +7151,8 @@ static gen_helper_gvec_4 * const sqrdcmlah_fns[] = {
 TRANS_FEAT(SQRDCMLAH_zzzz, aa64_sve2, gen_gvec_ool_zzzz,
            sqrdcmlah_fns[a->esz], a->rd, a->rn, a->rm, a->ra, a->rot)
 
-TRANS_FEAT(USDOT_zzzz, aa64_sve_i8mm, gen_gvec_ool_arg_zzzz,
-           a->esz == 2 ? gen_helper_gvec_usdot_4b : NULL, a, 0)
+TRANS_FEAT(USDOT_zzzz_4s, aa64_sve_i8mm, gen_gvec_ool_arg_zzzz,
+           gen_helper_gvec_usdot_4b, a, 0)
 
 TRANS_FEAT_NONSTREAMING(AESMC, aa64_sve2_aes, gen_gvec_ool_zz,
                         gen_helper_crypto_aesmc, a->rd, a->rd, 0)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 51847ea56e..401c025852 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1599,7 +1599,7 @@ SQRDCMLAH_zzzz  01000100 esz:2 0 rm:5 0011 rot:2 rn:5 rd:5  ra=%reg_movprfx
 
 ## SVE mixed sign dot product
 
-USDOT_zzzz      01000100 .. 0 ..... 011 110 ..... .....  @rda_rn_rm
+USDOT_zzzz_4s   01000100 10 0 ..... 011 110 ..... .....  @rda_rn_rm_ex esz=2
 
 ### SVE2 floating point matrix multiply accumulate
 BFMMLA          01100100 01 1 ..... 111 001 ..... .....  @rda_rn_rm_ex esz=1
-- 
2.43.0


