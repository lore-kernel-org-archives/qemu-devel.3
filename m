Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89165C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:41:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjEy-0001r1-47; Fri, 04 Jul 2025 12:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEZ-0000jj-Np
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:57 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEY-0006KU-3g
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:55 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a4ef2c2ef3so920018f8f.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646353; x=1752251153; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=w//E3dZM/eISgvGQ8pSH7I6/nrwzye8WLd/7oG6rLcM=;
 b=oCUc6AMVEdhvfnfgooHCSsyfJGtiT3jVxi7Ss/xlNIZs4DhnZodw3h4zT4DYGgpSCu
 i93maaa2PS63IaxIdSBZYmZXvsp/B8PyDlvg+Ly1s3uBpn4JqRXfCqRiAgOWr+sSLbkB
 lBBxQ9UmSpUkpEEo+5/BxGdqaEHH/40b1B3RU5bCDjCHoLiGKx9rBpEduIjqQyJOLl4f
 90gOB9JjTOAyC7vioJhqc49+XhR3FyHgUQdelY66rx+2qrouQ2Jv60TY/T9L9HV2JRnX
 BWQKsgvyF/N066+G1EdZRNyWz34OB1L6eUY66Pm0cig0WxfGOnE9m16HmmfPOqlrTKTF
 ZtSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646353; x=1752251153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w//E3dZM/eISgvGQ8pSH7I6/nrwzye8WLd/7oG6rLcM=;
 b=v35ieTqNdb12eck5CNsOkUcKt/nAYZHg2PZL1s1iCGaz3ubZ2A+a9iaHywuPHe609F
 X5WFfTtV9M67RqAchrdZd/JzecNWiZi422QsJHo4Rr8KPkeeSVtMZUoYi+ymjjcNfJst
 Rj2m7+v7J/OeeibhGwOg/Kfa+RGClb+ZfFxnLveymjk7fkzFUK/o2eErzoR58MROUCv6
 KcRfVbIv7naGXkM965Sc946tDk9x8SIj1NmQDrFEeVDRjRDqe3i6GYO22Jh4n9fHPf/B
 qec4lffDe4nGTgcb+vrldYgJOoIIPZPqqKSL76ua3ZwkmGC0n/Pcu0M/8iLjdlgytikU
 9R9A==
X-Gm-Message-State: AOJu0YwTXq6QAeE3T1vCI/8BAsH0yYfEPWo7PAHb7Dqh+1X01INGL9tw
 O5SSnxdwqSZGJj7w52WgQo/Q5sMJwHk1JdGRsw+MrRISt7LF+VGjpOhXhBi51Si2iyO30Y3XfbA
 opbyo
X-Gm-Gg: ASbGncuyf1AI/GWZTRNU0pqVOjcxwQgtu6xboTZhUj2NfzvpU9WJ/3YLBb79QTATVsp
 f9mW36qbu9OMyIUaVkjo10jxtd7tpeNwkQTiBOf1HHBEb66wSVrMFBcIvv9UD2D9el/UwUWzH/4
 ipfmHZyQD4pyyb5123XMNR1DbqXFWk2lRlISK/iQ34ml0vtB+e3hkcZa53xtjI/IZ9+Hr4S3glK
 dyj8Lm78l6Trq670X8SZnB+1SA4QJYi5svOo3xnDkxfa3yYylA2GKqaXPDD6xfjK4k1Jnbr2UCV
 ds5KFShOPX8fMpwBzDaAwFmqCx80pxuk+PKpcmJWD5NExInzfeGbDkyd8qKRDi8SdqUD
X-Google-Smtp-Source: AGHT+IHuE1FNPhyijRG8UWJNkk/rsVxr+VXlPmVMzWw/eDcs0Y6aenioHqFYwdSu9gubfEihqVCx7w==
X-Received: by 2002:a05:6000:4807:b0:3a6:ec1d:1cba with SMTP id
 ffacd0b85a97d-3b4970103a8mr2127408f8f.20.1751646352643; 
 Fri, 04 Jul 2025 09:25:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 054/119] target/arm: Rename SVE SDOT and UDOT patterns
Date: Fri,  4 Jul 2025 17:23:54 +0100
Message-ID: <20250704162501.249138-55-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Emphasize the 4-way nature of these dot products.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-43-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sve.decode      | 12 ++++++------
 target/arm/tcg/translate-sve.c | 12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 5970ed9ac49..51847ea56ee 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -851,10 +851,10 @@ CDOT_zzzz       01000100 esz:2 0 rm:5 0001 rot:2 rn:5 rd:5  ra=%reg_movprfx
 #### SVE Multiply - Indexed
 
 # SVE integer dot product (indexed)
-SDOT_zzxw_s     01000100 10 1 ..... 000000 ..... .....   @rrxr_2 esz=2
-SDOT_zzxw_d     01000100 11 1 ..... 000000 ..... .....   @rrxr_1 esz=3
-UDOT_zzxw_s     01000100 10 1 ..... 000001 ..... .....   @rrxr_2 esz=2
-UDOT_zzxw_d     01000100 11 1 ..... 000001 ..... .....   @rrxr_1 esz=3
+SDOT_zzxw_4s    01000100 10 1 ..... 000000 ..... .....   @rrxr_2 esz=2
+SDOT_zzxw_4d    01000100 11 1 ..... 000000 ..... .....   @rrxr_1 esz=3
+UDOT_zzxw_4s    01000100 10 1 ..... 000001 ..... .....   @rrxr_2 esz=2
+UDOT_zzxw_4d    01000100 11 1 ..... 000001 ..... .....   @rrxr_1 esz=3
 
 # SVE2 integer multiply-add (indexed)
 MLA_zzxz_h      01000100 0. 1 ..... 000010 ..... .....   @rrxr_3 esz=1
@@ -873,8 +873,8 @@ SQRDMLSH_zzxz_s 01000100 10 1 ..... 000101 ..... .....   @rrxr_2 esz=2
 SQRDMLSH_zzxz_d 01000100 11 1 ..... 000101 ..... .....   @rrxr_1 esz=3
 
 # SVE mixed sign dot product (indexed)
-USDOT_zzxw_s    01000100 10 1 ..... 000110 ..... .....   @rrxr_2 esz=2
-SUDOT_zzxw_s    01000100 10 1 ..... 000111 ..... .....   @rrxr_2 esz=2
+USDOT_zzxw_4s   01000100 10 1 ..... 000110 ..... .....   @rrxr_2 esz=2
+SUDOT_zzxw_4s   01000100 10 1 ..... 000111 ..... .....   @rrxr_2 esz=2
 
 # SVE2 saturating multiply-add (indexed)
 SQDMLALB_zzxw_s 01000100 10 1 ..... 0010.0 ..... .....   @rrxr_3a esz=2
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 1564ee2558f..56353b3bb4d 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3412,18 +3412,18 @@ TRANS_FEAT(DOT_zzzz, aa64_sve, gen_gvec_ool_zzzz,
  * SVE Multiply - Indexed
  */
 
-TRANS_FEAT(SDOT_zzxw_s, aa64_sve, gen_gvec_ool_arg_zzxz,
+TRANS_FEAT(SDOT_zzxw_4s, aa64_sve, gen_gvec_ool_arg_zzxz,
            gen_helper_gvec_sdot_idx_4b, a)
-TRANS_FEAT(SDOT_zzxw_d, aa64_sve, gen_gvec_ool_arg_zzxz,
+TRANS_FEAT(SDOT_zzxw_4d, aa64_sve, gen_gvec_ool_arg_zzxz,
            gen_helper_gvec_sdot_idx_4h, a)
-TRANS_FEAT(UDOT_zzxw_s, aa64_sve, gen_gvec_ool_arg_zzxz,
+TRANS_FEAT(UDOT_zzxw_4s, aa64_sve, gen_gvec_ool_arg_zzxz,
            gen_helper_gvec_udot_idx_4b, a)
-TRANS_FEAT(UDOT_zzxw_d, aa64_sve, gen_gvec_ool_arg_zzxz,
+TRANS_FEAT(UDOT_zzxw_4d, aa64_sve, gen_gvec_ool_arg_zzxz,
            gen_helper_gvec_udot_idx_4h, a)
 
-TRANS_FEAT(SUDOT_zzxw_s, aa64_sve_i8mm, gen_gvec_ool_arg_zzxz,
+TRANS_FEAT(SUDOT_zzxw_4s, aa64_sve_i8mm, gen_gvec_ool_arg_zzxz,
            gen_helper_gvec_sudot_idx_4b, a)
-TRANS_FEAT(USDOT_zzxw_s, aa64_sve_i8mm, gen_gvec_ool_arg_zzxz,
+TRANS_FEAT(USDOT_zzxw_4s, aa64_sve_i8mm, gen_gvec_ool_arg_zzxz,
            gen_helper_gvec_usdot_idx_4b, a)
 
 #define DO_SVE2_RRX(NAME, FUNC) \
-- 
2.43.0


