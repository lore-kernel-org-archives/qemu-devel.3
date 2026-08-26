Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2682AC61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:45:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzHeM-0000Vk-B4; Wed, 26 Aug 2026 13:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzHdx-000070-T5
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:42:34 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzHdv-0004og-Eu
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:42:33 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c9aea40d799so780960a12.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 10:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787766150; x=1788370950; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4jzGNhaLx3zE9dzspkiZZcbA9C9gEpNpA5SHsyurALs=;
 b=hGO6dYzl9UmA/+KiitDk9b5F7rf+Po5z5r07eSFo3VXKBQQELnGzJ5iX9HVyYlrE+U
 YaSgbG8Jw8I2Dij/ZKk7L9/a13oWs5NSQyjbZOFb7AJqMDUkQDJgFJ/cxYoQ5Yr/SIJJ
 Fey+Z/xSv3piDkvH3ygrrjD8EVCKV9UcgyECc61p6Yhmz4k3WnCutqcfxHmQJTRjBq6i
 6sOos3a1NlHbkauTPC9t0ukHqpCRGcxuHpa6UMqb2r2tcergfbCcTio16VN3IGXaHwS9
 XOYTQm0LxU5Gn0GGVVS8yT6o+bvW0V0XwHpYHqc90fhZBSm++ZeZf6o1IAksxwuYubQ8
 PHjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787766150; x=1788370950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4jzGNhaLx3zE9dzspkiZZcbA9C9gEpNpA5SHsyurALs=;
 b=VQHsW9BmA73N18qpSc8R3h21m7L3Rh/JDmcJs0ZekAUUPA1fxZW2GwPSaHQX09ASZu
 49bw1TJz+4mm2ERaGA1TCD3yyLge2TB/25xn1z/NaifcsVer9sJ975KkaNcUSWfokXCp
 e8NONXVb++AOzxHg4EexdJDGzzUOgiDKoy21L1tcuOTh3PsuibfWeGoo05Bp2+cffXi5
 VmcWJUy1io1oI7xQ7A19xrY8SDjDEMj1373bSG69aVfYU6NqWCrdXcuFzIb3hWWvGkNT
 J6UJBCjJLS1R9ZEghF/vnk2+P8ZF43IpCJTSoHIMnqJ+CaZ2E4MftYBsRFyiaMzKxeP3
 spQQ==
X-Gm-Message-State: AFuF++nREwRkQ3ZCRM+g8kgJ9dT+F+5QaHh5vK2z8Ymrt7TYp8tIDA/k
 R0J30Re5IeW4b3OZhxwIdEZeMebl9V454rO1fbjj7+sTdC4oK9vLwOnW9/KIFytku+vaLAZkJsD
 OUCsS4pw=
X-Gm-Gg: AR+sD13g3xxTHRtYq/TfXOCJJXRMzQEQotlNSfmWNSHB1SmXe1DPf9jOoc6yYNdUx9T
 a0dS7VBr+fbIF1TagEl52yB+dJGaB2x8Gtu8ggiu46AgDs063apVUOFs4DBk42RJwZuhrv7n+hV
 Bk5fBP1ZQ94DqMrJ9pLICT1Tm7V/3Ot1ZkRKRQDv3SUCXVRiaMnQHHo1L+F1DefJTTe+/AI58gB
 HIhGfgOP6DFAaKPxBvEWnxUJdJWDMYVVrUTZeYY5Q4fV4DrhPrWaw4bpPBQZi/rXU5/TeKu0Uoe
 6pi27W0L47SFGk5JRP+Wi/YH+fFFDWddEFb4XDD85HzZqsQcSdQIqh4KqMi/2Yyhab7QffSpLQ/
 q4Ajd1C5ML7fJnbxooDWgw2B9VmFUUoSvJg4sskRChJQY2mksDDl+g8zlpyerFfBw9LCzUmmkwt
 k37rWHHLdMTilkeMeM9v1/gh0gq3+Oc7PryOnYYTiD3msw0tBqkp9Tn4328qo0d4DCfL8iQkjQd
 L9LULclVuRD9DH/RQ==
X-Received: by 2002:a05:6a20:e18b:b0:3be:b0b3:3962 with SMTP id
 adf61e73a8af0-3cf83f36b8amr18852117637.9.1787766149906; 
 Wed, 26 Aug 2026 10:42:29 -0700 (PDT)
Received: from stoup (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc1bec66020sm1260072a12.21.2026.08.26.10.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 10:42:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 13/25] target/arm: Implement SME BFMUL
Date: Wed, 26 Aug 2026 10:42:00 -0700
Message-ID: <20260826174213.614571-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826174213.614571-1-richard.henderson@linaro.org>
References: <20260826174213.614571-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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
 target/arm/tcg/translate-sme.c |  4 ++++
 target/arm/tcg/sme.decode      | 24 ++++++++++++++++++++----
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index d28574a8cf0..08b25b0be9d 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -903,6 +903,10 @@ static gen_helper_gvec_3_ptr * const f_vector_fmul[4] = {
 };
 TRANS_FEAT(FMUL_n1, aa64_sme2p2, do_zzz_n1_fpst, a, f_vector_fmul[a->esz])
 TRANS_FEAT(FMUL_nn, aa64_sme2p2, do_zzz_nn_fpst, a, f_vector_fmul[a->esz])
+TRANS_FEAT(BFMUL_n1, aa64_sme2_sve_bfscale, do_zzz_n1_fpst, a,
+           gen_helper_gvec_fmul_b16)
+TRANS_FEAT(BFMUL_nn, aa64_sme2_sve_bfscale, do_zzz_nn_fpst, a,
+           gen_helper_gvec_fmul_b16)
 
 /* Add/Sub vector Z[m] to each Z[n*N] with result in ZA[d*N]. */
 static bool do_azz_n1(DisasContext *s, arg_azz_n *a, int esz,
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 4e19c42b196..3e4cb7e5829 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -296,10 +296,18 @@ SQDMULH_n1     1100000 1 .. 10 .... 1010.1 00000 .... 0    @z2z_4x1
   FSCALE_n1    1100000 1 .. 10 .... 1010.0 01100 .... 0    @z2z_4x1
 }
 
-FMUL_n1        1100000 1 esz:2 1 zm:4 0 111010 ....0 ....0 \
+{
+  BFMUL_n1     1100000 1 00    1 zm:4 0 111010 ....0 ....0 \
+               &zzz_en n=2 zd=%zd_ax2 zn=%zn_ax2 esz=0
+  FMUL_n1      1100000 1 esz:2 1 zm:4 0 111010 ....0 ....0 \
                &zzz_en n=2 zd=%zd_ax2 zn=%zn_ax2
-FMUL_n1        1100000 1 esz:2 1 zm:4 1 111010 ...00 ...00 \
+}
+{
+  BFMUL_n1     1100000 1 00    1 zm:4 1 111010 ...00 ...00 \
+               &zzz_en n=4 zd=%zd_ax4 zn=%zn_ax4 esz=0
+  FMUL_n1      1100000 1 esz:2 1 zm:4 1 111010 ...00 ...00 \
                &zzz_en n=4 zd=%zd_ax4 zn=%zn_ax4
+}
 
 ### SME2 Multi-vector Multiple Vectors SVE Destructive
 
@@ -380,10 +388,18 @@ FAMIN_nn       1100000 1 .. 1 ..... 1011.0 01010 .... 1    @z2z_4x4
   FSCALE_nn    1100000 1 .. 1 ..... 1011.0 01100 .... 0    @z2z_4x4
 }
 
-FMUL_nn        1100000 1 esz:2 1 ....0 111001 ....0 ....0  \
+{
+  BFMUL_nn     1100000 1 00    1 ....0 111001 ....0 ....0  \
+               &zzz_en n=2 zd=%zd_ax2 zn=%zn_ax2 zm=%zm_ax2 esz=0
+  FMUL_nn      1100000 1 esz:2 1 ....0 111001 ....0 ....0  \
                &zzz_en n=2 zd=%zd_ax2 zn=%zn_ax2 zm=%zm_ax2
-FMUL_nn        1100000 1 esz:2 1 ...01 111001 ...00 ...00  \
+}
+{
+  BFMUL_nn     1100000 1 00    1 ...01 111001 ...00 ...00  \
+               &zzz_en n=4 zd=%zd_ax4 zn=%zn_ax4 zm=%zm_ax4 esz=0
+  FMUL_nn      1100000 1 esz:2 1 ...01 111001 ...00 ...00  \
                &zzz_en n=4 zd=%zd_ax4 zn=%zn_ax4 zm=%zm_ax4
+}
 
 ### SME2 Multi-vector Multiple and Single Array Vectors
 
-- 
2.53.0


