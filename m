Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F999CD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:16:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZAs-0000Yk-Vq; Tue, 16 Jun 2026 15:10:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8V-0004ii-2Z
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:51 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8R-0001Db-U2
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:46 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-461edb387ddso546094f8f.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636862; x=1782241662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jQlAupbk8yS2XMtWWkeHglESBt2Myt7OXOOVYx/Sdaw=;
 b=t/nJN2Ik5N6J5C3FXKGHQNzfNEcWCZNG/nUQT9msXliKylBTSV5WKeF5Mzqwbhwopa
 6uNM5NA8Lvl8wutNK6EvmT8ARAj5iWzhm/DxDG9/N/Tk1n7B9rLS4HVHrXjm/uO9TLKZ
 17NDdCgiyg6qccVMok0/Q0ZkeUHQwMhjN29t5EPIxkAhPU++faZRUjUPNeMjTE/7D1Ho
 IE2jUX1IMn+KTBg/E9SR5dOCQwid/muRiZ+RDb/Z/xjP1NWM51yRMp4aSC6Nuy+DuCkp
 MJYEJp9GHUVHsU6EkL4nNLSg9i91VseWay1Kh6OkB8RFQoujS+FcVMAk/Ypj13axD/po
 DaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636862; x=1782241662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jQlAupbk8yS2XMtWWkeHglESBt2Myt7OXOOVYx/Sdaw=;
 b=hFtgsNzIXE6JmjA/lqHjZcv/DWlRFvCLDK7X+RVAaAtaJnn78fDu/7MX8pLcy/UEZK
 rY0KFnuAUVnI7xovD42G+96aqd6NijKG1KjiHkkzjtZ1lMco1qpVNeyZJMiJ1OqxaPcv
 kaT43MG3ZaN41g8V6MGAVyjt0gQu+aF30Ohc+NWLGsp4VxZVdEDFkbyzBAM0FfLr0PSS
 mw1s9mC3+wxBU6ekU/Ix9V94/4luQ2klXmGQK/9BcEk/K9YcBRoZ/SaBWf6m1Wi+uWwm
 KmufUAcvd6eZNovWI+3qW9y1grDa1E/UDFD/vWmCTqQbPGT3YVGZnQndt9/iRm5zubdy
 n3ZQ==
X-Gm-Message-State: AOJu0YxbmiiwABGpGvExhjSzWIONJN9BjRA8SZhmd2ew5nGXOUGoAofL
 1YbKZ6CO7gb+D4cgNYx1VT399O3rz/CXXX0Ip7Ck9X7TIjzY2CYfWglzEu0NUmq61N4iosWjNTo
 prhb1
X-Gm-Gg: Acq92OFQ+RYKK6Y3tIwVePDtPov/S5WvuE63D88NVfywt0bjjMNfLFuQeIfXbM4nv0a
 n/wUOZdyx6RqF6dyr+wfvJjDtSA98tTT79Ihzl5SXN1uU827OZ5ytyQ501M36SWdGfjoLCc7oNB
 Pf7nhCeEXVU3bnzTdmc4IcDsh16O5U4hnt+PwcS2FVV22fG8ZxqfO+RqivNb2qHTh9C+gGv9YoM
 HaemcQFsVyp1BYcsd9qQvc9U3EzRX2CtAeIoa2i8JNwHpieR5jTCQKNfiAhrCQsUpbtH3PXLfws
 +CWp/G1fv2IoFGwlVJkSGrxSOPEKFNlXCUD2WVm91mX6dxXcTjvkx2IU9GuGuqP1C8IJzV6Q0jx
 dHMVyg8HFKSIK7y/wo2o6acpeMQeACN11w3TEczZybXSDGLEF0vGphJjHzs3r61uTmqdA5gU9ha
 /YLHgpjpfN3vQRCzzQMVqmLlXEwihY05+dT9xiTk1O7wIGG7Og2ic6TFughrKJmxmsaKmd1cZKz
 GmCH0IgxjFb5cpUD9YYGJBHErqiY+jj
X-Received: by 2002:adf:fcca:0:b0:45e:f302:95b with SMTP id
 ffacd0b85a97d-46238f972damr797946f8f.37.1781636862258; 
 Tue, 16 Jun 2026 12:07:42 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.07.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:07:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 55/61] target/arm: Implement Floating-point convert (predicated,
 zeroing)
Date: Tue, 16 Jun 2026 20:06:32 +0100
Message-ID: <20260616190639.3462006-56-peter.maydell@linaro.org>
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

This is FCVTX, FCVT and BFCVT.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260604234852.573178-13-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sve.decode      | 11 +++++++++++
 target/arm/tcg/translate-sve.c | 22 ++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 099cd4e93d..889ff85f72 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1215,6 +1215,17 @@ FCVT_hd_m       01100101 11 0010 01 101 ... ..... .....         @rd_pg_rn_e0
 FCVT_ds_m       01100101 11 0010 10 101 ... ..... .....         @rd_pg_rn_e0
 FCVT_sd_m       01100101 11 0010 11 101 ... ..... .....         @rd_pg_rn_e0
 
+FCVTX_ds_z      01100100 00 0110 101 10 ... ..... .....         @rd_pg_rn_e0
+
+FCVT_sh_z       01100100 10 0110 101 00 ... ..... .....         @rd_pg_rn_e0
+FCVT_hs_z       01100100 10 0110 101 01 ... ..... .....         @rd_pg_rn_e0
+BFCVT_z         01100100 10 0110 101 10 ... ..... .....         @rd_pg_rn_e0
+
+FCVT_dh_z       01100100 11 0110 101 00 ... ..... .....         @rd_pg_rn_e0
+FCVT_hd_z       01100100 11 0110 101 01 ... ..... .....         @rd_pg_rn_e0
+FCVT_ds_z       01100100 11 0110 101 10 ... ..... .....         @rd_pg_rn_e0
+FCVT_sd_z       01100100 11 0110 101 11 ... ..... .....         @rd_pg_rn_e0
+
 # SVE floating-point convert to integer
 FCVTZS_hh_m     01100101 01 011 01 0 101 ... ..... .....        @rd_pg_rn_e0
 FCVTZU_hh_m     01100101 01 011 01 1 101 ... ..... .....        @rd_pg_rn_e0
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 64ee1f7752..d610ea561d 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4588,21 +4588,40 @@ TRANS_FEAT(FCMLA_zzxz, aa64_sme_or_sve, gen_gvec_fpst_zzzz, fcmla_idx_fns[a->esz
 
 TRANS_FEAT(FCVT_sh_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvt_sh, a, 0, FPST_A64)
+TRANS_FEAT(FCVT_sh_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve_fcvt_sh, a, 1, FPST_A64)
+
 TRANS_FEAT(FCVT_hs_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvt_hs, a, 0, FPST_A64_F16)
+TRANS_FEAT(FCVT_hs_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve_fcvt_hs, a, 1, FPST_A64_F16)
 
 TRANS_FEAT(BFCVT_m, aa64_sme_sve_bf16, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_bfcvt, a, 0,
            s->fpcr_ah ? FPST_AH : FPST_A64)
+TRANS_FEAT(BFCVT_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve_bfcvt, a, 1,
+           s->fpcr_ah ? FPST_AH : FPST_A64)
 
 TRANS_FEAT(FCVT_dh_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvt_dh, a, 0, FPST_A64)
+TRANS_FEAT(FCVT_dh_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve_fcvt_dh, a, 1, FPST_A64)
+
 TRANS_FEAT(FCVT_hd_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvt_hd, a, 0, FPST_A64_F16)
+TRANS_FEAT(FCVT_hd_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve_fcvt_hd, a, 1, FPST_A64_F16)
+
 TRANS_FEAT(FCVT_ds_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvt_ds, a, 0, FPST_A64)
+TRANS_FEAT(FCVT_ds_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve_fcvt_ds, a, 1, FPST_A64)
+
 TRANS_FEAT(FCVT_sd_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvt_sd, a, 0, FPST_A64)
+TRANS_FEAT(FCVT_sd_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve_fcvt_sd, a, 1, FPST_A64)
 
 TRANS_FEAT(FCVTZS_hh_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvtzs_hh, a, 0, FPST_A64_F16)
@@ -8017,6 +8036,9 @@ TRANS_FEAT(FCVTLT_sd_m, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
 
 TRANS_FEAT(FCVTX_ds_m, aa64_sme_or_sve2, do_frint_mode, a,
            FPROUNDING_ODD, 0, gen_helper_sve_fcvt_ds)
+TRANS_FEAT(FCVTX_ds_z, aa64_sme2p2_or_sve2p2, do_frint_mode, a,
+           FPROUNDING_ODD, 1, gen_helper_sve_fcvt_ds)
+
 TRANS_FEAT(FCVTXNT_ds_m, aa64_sme_or_sve2, do_frint_mode, a,
            FPROUNDING_ODD, 0, gen_helper_sve2_fcvtnt_ds)
 
-- 
2.43.0


