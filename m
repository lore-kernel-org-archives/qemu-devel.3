Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41FE1CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:15:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZDM-00033k-EG; Tue, 16 Jun 2026 15:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8Z-0004mn-Ip
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:53 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8V-0001Fk-5B
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:51 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-46019edc13dso2389778f8f.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636865; x=1782241665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=i/smW6GL8OKBS/PXid8fym6NYK4D3UNHQvOfP4IehXY=;
 b=OwF6TPWG/uiYSg4XoxZJ0DzoUT9j31LYROi21M0pXIAOFOxVe/GUOv+Ba6/jzRTyRI
 IncQrc4rljYnMuC5xLwmZUh7mkfwX8p8m++yQJ7J1P5MQm0QJdOQJ8SzQ5O6Ts0FxYa2
 QECGNChSIS3+lqmzxxmJMksLNA/EU5g3USG3l3Jd6z6jQCwZp6jAW6d9e8OQ8xsmpaei
 hgwkrbx/6kke6zZ3g36Hi8pWYR5aHq4kBAHjGB0PROaKy5LVo+ke2whd+2SZ2H4aveLh
 DjHIeS3KUAz/jHGxRB/uOaHexkzFB4cFK/9zhOz+JMMMaNgzUwse8GYgo7qnDtSlQau3
 8pfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636865; x=1782241665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=i/smW6GL8OKBS/PXid8fym6NYK4D3UNHQvOfP4IehXY=;
 b=O3IxMfEP8hamBzwi2hIXSVS74FTcJDmy0xT2p4NT5vBKCtn6WNbtDP+i8J+gWZFCPs
 yVxIcYyUgG1mi7Le3lNZa9BfykTf1y//4+4680JL2RJU8MN9JWBoJVWzMpZO/TTv45+x
 doh7v0LaG7xwREK2Kjr1tF+fQfmuuY/ngFIAXt59/0Ihp+UOUmLDPalefYecbjh4GlTZ
 yXuqSZ2DCWyYLNCcUJ7kWwaX0b39ZRu+xXW4Tgd2KcWGDHfESZuYMMB0N5Wz6KL9iPu0
 LcCwCYy4r36pj3Fp3XHExPgfbWl+ZL1LXrNtYE+qDtFooaiLNgu5cEmEDcoxpuAyGJQJ
 2Lwg==
X-Gm-Message-State: AOJu0YzyJp831lEXwA15KxDGgP2AULiUS3UXPBY6bAAhdpeVH54qUbZZ
 ComD2bNEVxEG5CWz0MAYwmPDEE+JpxK5lO/UskKUFVqOUUSCdVtbvP8tE6yh4pgKp6lTFsb9XAZ
 9pw1r
X-Gm-Gg: Acq92OHm1rPwSsN393aLS+JaDWsalRcGpCtUzOqwfyx631tbYFSzMkI7V4Ot5bmSCSg
 n8t+1rZVBijHTp9/38hX/zSGeMxcdvKsEVzpucljLkBb3sN+sBejqYOShSIujMUXrOCkLkScK8A
 DZTl7Evd9U1X+KqWJ7YqtDc1Pi0YkbhbB6WyNhvOnYvZJbVNhhBsm+yxuhuD1rgWTriDlO/P6i4
 gFiypRUkcrUwhHGLU0rpJxNLJPRJQRSmCJYaebgxlyHM7iD9dz5o9mk8WqmbB+x6h75J7EeMP0r
 h1ijZqsw5wOWzZXXbQKcSksWU529Tu7Ve1tY8vLS6WqxTNzWLeiq6JkKH5hYPQP3Sisx+89zT/x
 hI94JVFZkeaFICIDtJD6WDKtJsSmh01bLNV7zzwz5vte0X+2z0LjOpwgGs5l/rLygqh+KoH4VAU
 pr5Ph24AAy46poxSKkwMpkQ2954aW2z8qDLg2iSTaxyLBj1p1qXrkf0OtS/VB6bddrFeWW8FVc6
 K7bpqNrh6Vr3ECUnn76w/jnshovGPil
X-Received: by 2002:a5d:4ec4:0:b0:461:a15f:66c2 with SMTP id
 ffacd0b85a97d-46240cf967emr686568f8f.22.1781636864961; 
 Tue, 16 Jun 2026 12:07:44 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.07.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:07:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 57/61] target/arm: Implement SCVTF, UCVTF (predicated, zeroing)
Date: Tue, 16 Jun 2026 20:06:34 +0100
Message-ID: <20260616190639.3462006-58-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260604234852.573178-15-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sve.decode      | 16 ++++++++++++++++
 target/arm/tcg/translate-sve.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index c39d80360f..7460eee4a9 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1283,6 +1283,22 @@ UCVTF_sd_m      01100101 11 010 00 1 101 ... ..... .....        @rd_pg_rn_e0
 UCVTF_ds_m      01100101 11 010 10 1 101 ... ..... .....        @rd_pg_rn_e0
 UCVTF_dd_m      01100101 11 010 11 1 101 ... ..... .....        @rd_pg_rn_e0
 
+SCVTF_hh_z      01100100 01 011 10 0 110 ... ..... .....        @rd_pg_rn_e0
+SCVTF_sh_z      01100100 01 011 10 1 100 ... ..... .....        @rd_pg_rn_e0
+SCVTF_ss_z      01100100 10 011 10 1 100 ... ..... .....        @rd_pg_rn_e0
+SCVTF_sd_z      01100100 11 011 10 0 100 ... ..... .....        @rd_pg_rn_e0
+SCVTF_dh_z      01100100 01 011 10 1 110 ... ..... .....        @rd_pg_rn_e0
+SCVTF_ds_z      01100100 11 011 10 1 100 ... ..... .....        @rd_pg_rn_e0
+SCVTF_dd_z      01100100 11 011 10 1 110 ... ..... .....        @rd_pg_rn_e0
+
+UCVTF_hh_z      01100100 01 011 10 0 111 ... ..... .....        @rd_pg_rn_e0
+UCVTF_sh_z      01100100 01 011 10 1 101 ... ..... .....        @rd_pg_rn_e0
+UCVTF_ss_z      01100100 10 011 10 1 101 ... ..... .....        @rd_pg_rn_e0
+UCVTF_sd_z      01100100 11 011 10 0 101 ... ..... .....        @rd_pg_rn_e0
+UCVTF_dh_z      01100100 01 011 10 1 111 ... ..... .....        @rd_pg_rn_e0
+UCVTF_ds_z      01100100 11 011 10 1 101 ... ..... .....        @rd_pg_rn_e0
+UCVTF_dd_z      01100100 11 011 10 1 111 ... ..... .....        @rd_pg_rn_e0
+
 ### SVE Memory - 32-bit Gather and Unsized Contiguous Group
 
 # SVE load predicate register
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 1ea9454267..4ac59664ae 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4784,6 +4784,40 @@ TRANS_FEAT(UCVTF_sd_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
 TRANS_FEAT(UCVTF_dd_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_ucvt_dd, a, 0, FPST_A64)
 
+TRANS_FEAT(SCVTF_hh_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve_scvt_hh, a, 1, FPST_A64_F16)
+TRANS_FEAT(SCVTF_sh_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve_scvt_sh, a, 1, FPST_A64_F16)
+TRANS_FEAT(SCVTF_dh_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve_scvt_dh, a, 1, FPST_A64_F16)
+
+TRANS_FEAT(SCVTF_ss_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve_scvt_ss, a, 1, FPST_A64)
+TRANS_FEAT(SCVTF_ds_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve_scvt_ds, a, 1, FPST_A64)
+
+TRANS_FEAT(SCVTF_sd_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve_scvt_sd, a, 1, FPST_A64)
+TRANS_FEAT(SCVTF_dd_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve_scvt_dd, a, 1, FPST_A64)
+
+TRANS_FEAT(UCVTF_hh_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve_ucvt_hh, a, 1, FPST_A64_F16)
+TRANS_FEAT(UCVTF_sh_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve_ucvt_sh, a, 1, FPST_A64_F16)
+TRANS_FEAT(UCVTF_dh_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve_ucvt_dh, a, 1, FPST_A64_F16)
+
+TRANS_FEAT(UCVTF_ss_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve_ucvt_ss, a, 1, FPST_A64)
+TRANS_FEAT(UCVTF_ds_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve_ucvt_ds, a, 1, FPST_A64)
+TRANS_FEAT(UCVTF_sd_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve_ucvt_sd, a, 1, FPST_A64)
+
+TRANS_FEAT(UCVTF_dd_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve_ucvt_dd, a, 1, FPST_A64)
+
 /*
  *** SVE Memory - 32-bit Gather and Unsized Contiguous Group
  */
-- 
2.43.0


