Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D301CD98EE
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:15:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZEa-00057a-MG; Tue, 16 Jun 2026 15:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8b-0004n6-0m
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:55 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8X-0001H6-IA
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:52 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-46066e640easo3025347f8f.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636868; x=1782241668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pydwboiAW0ie4TrQJ57zGqQSKcjPD0l8ffuTD4pEfpg=;
 b=Gf7We0RpWi0nTEyU4yg8w7za9rWa6WDBN8q3nykvEK0lRx4Eiwnzukxn/XEwzXXvSF
 KNBOv6E2P+/J9UcHOnr+s06J+WxYh8IOVS3KaA/svd/tbzSeicQRpA2N5uF0RWeiOIay
 G1BBcAEVRarKx3iupl7meCM8BTd4X8mjgsyfkpVjgUNds1ekqXMCME7L6RgX/ThJCMWZ
 j6WaQnNKNFu/kFw4Pf/WNKDytPXWXljCwTQ65CTEzMtm5V6+gippdW/qggf4yAj58+aq
 veGA/+NN58e1XJRPbjsbPsARpOTkrYh+m3E1vgzm0B3W9tM96zRwM4PR/uB+1hSIE7wI
 Qnsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636868; x=1782241668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pydwboiAW0ie4TrQJ57zGqQSKcjPD0l8ffuTD4pEfpg=;
 b=U+MRnA+M+pVLO0hbftpV4hqRYAYCDtb5fBftDwIdkg+Ssma9lZDMxPi6O3K6nDeFgH
 +O0nH767EmjihblGGJ8hZAy4DPhoxHMnxUmTnIRum78vEaX/IY7yuCZOtDCCHGCgRJ0n
 ZjCP5eaQ9D0P1h8L90QdVQj99DlESvGa22FncKzwNOeX9Vmu3shn2ulIxZYspYB29OTI
 17vG+QA+D8H8U19hpN3lNkXIqncGeGvImoG+Qks+AWLpu47be8tNMKTB0NnMF8tf5A36
 MAX6c6rTGbTuNcU2/LsJtvB9KvZP+1wGc1bXwcIJEtr1jx1SRGxuFPc9gjG51F+vARFP
 bflA==
X-Gm-Message-State: AOJu0YwpnKjAXzvS7VHSdlODhDCummB9O9fzKz0YonuMeOC/MBxxl1X7
 JXh+3wMrF/5CRP4TkBHpfDHcFiaLcqIj8IPM2sxmSp8rvE/RQN3nTN3ByX/Nh6D5S2UrIdToE0+
 EhWAW
X-Gm-Gg: Acq92OHn95qACoKjpsbE9YQE4qgUka2aE3fhwwTZW8wYOAamZDR5rQ00b0KP8+8PxCe
 uBVO0OU0U4bJX9SQTl//IuYNI2UkPo++U7F1dvIE3APhwI+FECGWUN3uIv0IuDqGFTrMcZxWFNA
 u0qqoGKpLhZsVDk53h33kg6FkdKqIifN7hHnFgNusx/2ofAUnE4/5fMW3KWkp3RXupnV0u7D2a/
 s87yXm4e9buZldM0Lw+aVwEKwd6304W9hSwy1n306tYpBs4GxSDyDSHd2Z1dI9XS26gJiKpvHRn
 PXGgki68oeLJUsR/7xs45mKDcSVHg8ThFPCfrwRXYBJRg0XOUj1ySHiT7uvsZ9EP4q4/QeuxI75
 FCYux/UJjs2lAEc1nHbB2KTfJtpX7fdR9Xq9Aia4S0aLpRK7c91lhuOxooTlrlNRfhTIDJbNaMx
 KmpB66BaIDXfccKRdF2DA2lMWtfS8iWyqAoZI3Qm4+tDcJx3YIxyXgTMzIZThExD8T84uNkL2f8
 FwP1IYpyv2v6Spk4h+kfvXGLS1HWcpu
X-Received: by 2002:a05:6000:2204:b0:45e:f381:cd7f with SMTP id
 ffacd0b85a97d-46235e98d57mr1305097f8f.5.1781636867788; 
 Tue, 16 Jun 2026 12:07:47 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.07.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:07:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 60/61] target/arm: Implement SVE floating-point convert (top,
 predicated, zeroing)
Date: Tue, 16 Jun 2026 20:06:37 +0100
Message-ID: <20260616190639.3462006-61-peter.maydell@linaro.org>
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

This includes FCVTXNT, BFCVTNT, FCVTNT, FCVTLT.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260604234852.573178-18-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sve.decode      |  7 +++++++
 target/arm/tcg/translate-sve.c | 13 +++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 5c814c7769..673cbaae57 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1941,6 +1941,13 @@ FCVTLT_hs_m     01100100 10 0010 01 101 ... ..... .....  @rd_pg_rn_e0
 FCVTNT_ds_m     01100100 11 0010 10 101 ... ..... .....  @rd_pg_rn_e0
 FCVTLT_sd_m     01100100 11 0010 11 101 ... ..... .....  @rd_pg_rn_e0
 
+FCVTXNT_ds_z    01100100 00 0000 10 101 ... ..... .....  @rd_pg_rn_e0
+FCVTNT_sh_z     01100100 10 0000 00 101 ... ..... .....  @rd_pg_rn_e0
+FCVTNT_ds_z     01100100 11 0000 10 101 ... ..... .....  @rd_pg_rn_e0
+BFCVTNT_z       01100100 10 0000 10 101 ... ..... .....  @rd_pg_rn_e0
+FCVTLT_hs_z     01100100 10 0000 01 101 ... ..... .....  @rd_pg_rn_e0
+FCVTLT_sd_z     01100100 11 0000 11 101 ... ..... .....  @rd_pg_rn_e0
+
 ### SVE2 floating-point convert to integer
 FLOGB_m         01100101 00 011 esz:2 0101 pg:3 rn:5 rd:5  &rpr_esz
 
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index a8d21dedca..21ee10ee5c 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8097,17 +8097,28 @@ static bool trans_RAX1(DisasContext *s, arg_RAX1 *a)
 
 TRANS_FEAT(FCVTNT_sh_m, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
            gen_helper_sve2_fcvtnt_sh, a, 0, FPST_A64)
+TRANS_FEAT(FCVTNT_sh_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve2_fcvtnt_sh, a, 1, FPST_A64)
 TRANS_FEAT(FCVTNT_ds_m, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
            gen_helper_sve2_fcvtnt_ds, a, 0, FPST_A64)
+TRANS_FEAT(FCVTNT_ds_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve2_fcvtnt_ds, a, 1, FPST_A64)
 
 TRANS_FEAT(BFCVTNT_m, aa64_sme_sve_bf16, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_bfcvtnt, a, 0,
            s->fpcr_ah ? FPST_AH : FPST_A64)
+TRANS_FEAT(BFCVTNT_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve_bfcvtnt, a, 1,
+           s->fpcr_ah ? FPST_AH : FPST_A64)
 
 TRANS_FEAT(FCVTLT_hs_m, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
            gen_helper_sve2_fcvtlt_hs, a, 0, FPST_A64_F16)
+TRANS_FEAT(FCVTLT_hs_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve2_fcvtlt_hs, a, 1, FPST_A64_F16)
 TRANS_FEAT(FCVTLT_sd_m, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
            gen_helper_sve2_fcvtlt_sd, a, 0, FPST_A64)
+TRANS_FEAT(FCVTLT_sd_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve2_fcvtlt_sd, a, 1, FPST_A64)
 
 TRANS_FEAT(FCVTX_ds_m, aa64_sme_or_sve2, do_frint_mode, a,
            FPROUNDING_ODD, 0, gen_helper_sve_fcvt_ds)
@@ -8116,6 +8127,8 @@ TRANS_FEAT(FCVTX_ds_z, aa64_sme2p2_or_sve2p2, do_frint_mode, a,
 
 TRANS_FEAT(FCVTXNT_ds_m, aa64_sme_or_sve2, do_frint_mode, a,
            FPROUNDING_ODD, 0, gen_helper_sve2_fcvtnt_ds)
+TRANS_FEAT(FCVTXNT_ds_z, aa64_sme2p2_or_sve2p2, do_frint_mode, a,
+           FPROUNDING_ODD, 1, gen_helper_sve2_fcvtnt_ds)
 
 static gen_helper_gvec_3_ptr * const flogb_fns[] = {
     NULL,               gen_helper_flogb_h,
-- 
2.43.0


