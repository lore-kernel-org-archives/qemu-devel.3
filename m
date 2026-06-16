Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84CAECD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZC7-00028m-Gv; Tue, 16 Jun 2026 15:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8S-0004iF-NQ
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:49 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8L-00019a-5C
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:43 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-490ac357c55so46760535e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636852; x=1782241652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ah0CRDAJN/ATHeQbNI5Cn7/twLVIaLzn6NT18+EPD/Q=;
 b=tsdJf5Nl/qF3Cd279Hruk4rqet3YSYutrK+bSGMVA1uhRWLKI/qtz08pXsTRWbtSgX
 vfo2vAdS6xupOm/NiTfDNA3gofbT6b4B1tvBBt1mplKdcS76JRA3ydgTp9kphk1AiaRs
 IjiRYw98AkUP6LyJ8UO9DMRbMHYze9g8Wvb8a0U6eEaI74T3G7HfVrFbXyvpDTRWEYMj
 /2eywn9EfsOvF2UIw4LVk1yXN9qfJ9s+7mNu4ddszsdCQaAbyBSyxePjYpD9QpYZk8Zl
 E9jjNPpqTJwv9DMKAo02FzoO6wEyI/nBmoOk0+bwDZMpUKkecuBOCQQRoJJPSnBo0H8v
 iOzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636852; x=1782241652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ah0CRDAJN/ATHeQbNI5Cn7/twLVIaLzn6NT18+EPD/Q=;
 b=ZJg4zthh9TDkjxN6duLviBcZtVlXU5owb/DJkSlv30QH7+L63UY2jWH72X0cdj9nTj
 wvwGfPtrmBFYU/JvrYtmFNTQQvx19DxmvjdGJMeG0omh7bNL03hCSCAp+O7ffawwqhmr
 BAheH+j6BJrO0ZKb1qQ3aPocZCIRunpbX/JlA/lCu7O/5eUunmlDlMedg3873MJND+fM
 F5KX/blPggtQGGddZsq2nWjVGVeJyPV57az0ItXjlIxvFqafvmP0Gr3yAD+nAqLNTeaR
 K987XCz3u6QV9hhqoM4jNulUgvyDqnGL3irWBnBLd6mjhB87nWgAbJ4iz6ZwW2398ZO0
 sZBA==
X-Gm-Message-State: AOJu0YyyiIMBM1nXGmrNsr9BeS9/voUfThmi0Oke1WuNMzZAKMTrCYRA
 pl57kaBX4n6srnUbowdjKOpsPmXfoCkGnW6dpMbut5TvNZI9rxL/ekY3cBqpe59WWZQwW+R5WGF
 9JeQA
X-Gm-Gg: Acq92OGEfQcxQvpls0/OsGV3JVTJFUeJV52RwFRMDWjRr/Jt+htR3H4wjkCUtcgdQrl
 Ktle9hhjp6HyVXjJ6UubeWASsXfKflhJmFv2jWBVxku7y5+/JxxK1JrGAHgcRXTi08/wJKpAnvp
 Ui2/Ue0ilkPvlQibCImXCrJ/XKbhjmshguFbBLrjW4igdTzLRDKldjvPV02AFygGjmyPD20ruYR
 0IQGrukFlFfnxeUBbRaLHOeGXgjpEajTKL0gKBZUgI90ZPgxhmbgSoF3iOMgZwbS5Crp2GmNlwP
 5zSV5C/123HlYekjH0uN13TZQF5yuaJjXj0n7PPr2oIhiFUyhUE3HCWwIKuK0rc/xhEngntzJNa
 tA6GJTDnYK1bYxkDkg1C7VTcvmdVwGHrtMdXNWZ0Qxv6ahNS5AiADzYicHX/Uy9XU9i6yAyKd5H
 DNC2P4mDLhDxAzmUP9Zk4y+ICWBQaY6wyQRfKL0e/cKYgRI+X/LYi2JjPnG0JkYr/xHP2Bt0qkL
 1ksZb81xLpJqS7G3R09R+gLZV1GV7ZuSRXCtrF7cqE=
X-Received: by 2002:a05:600c:a105:b0:490:cb90:3e00 with SMTP id
 5b1f17b1804b1-492333aaf90mr15981385e9.14.1781636852183; 
 Tue, 16 Jun 2026 12:07:32 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.07.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:07:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 45/61] target/arm: Rename sve unary predicated patterns
Date: Tue, 16 Jun 2026 20:06:22 +0100
Message-ID: <20260616190639.3462006-46-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

Add an "_m" suffix to indicate merging, in preparation for
adding new predicated zeroing instructions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260604234852.573178-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sve.decode      | 152 ++++++++++++++---------------
 target/arm/tcg/translate-sve.c | 169 +++++++++++++++++----------------
 2 files changed, 165 insertions(+), 156 deletions(-)

diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index b53fe6a58f..c7e633ec4f 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -392,24 +392,24 @@ LSL_zpzw        00000100 .. 011 011 100 ... ..... .....         @rdn_pg_rm
 
 # SVE unary bit operations (predicated)
 # Note esz != 0 for FABS and FNEG.
-CLS             00000100 .. 011 000 101 ... ..... .....         @rd_pg_rn
-CLZ             00000100 .. 011 001 101 ... ..... .....         @rd_pg_rn
-CNT_zpz         00000100 .. 011 010 101 ... ..... .....         @rd_pg_rn
-CNOT            00000100 .. 011 011 101 ... ..... .....         @rd_pg_rn
-NOT_zpz         00000100 .. 011 110 101 ... ..... .....         @rd_pg_rn
-FABS            00000100 .. 011 100 101 ... ..... .....         @rd_pg_rn
-FNEG            00000100 .. 011 101 101 ... ..... .....         @rd_pg_rn
+CLS_m           00000100 .. 011 000 101 ... ..... .....         @rd_pg_rn
+CLZ_m           00000100 .. 011 001 101 ... ..... .....         @rd_pg_rn
+CNT_zpz_m       00000100 .. 011 010 101 ... ..... .....         @rd_pg_rn
+CNOT_m          00000100 .. 011 011 101 ... ..... .....         @rd_pg_rn
+NOT_zpz_m       00000100 .. 011 110 101 ... ..... .....         @rd_pg_rn
+FABS_m          00000100 .. 011 100 101 ... ..... .....         @rd_pg_rn
+FNEG_m          00000100 .. 011 101 101 ... ..... .....         @rd_pg_rn
 
 # SVE integer unary operations (predicated)
 # Note esz > original size for extensions.
-ABS             00000100 .. 010 110 101 ... ..... .....         @rd_pg_rn
-NEG             00000100 .. 010 111 101 ... ..... .....         @rd_pg_rn
-SXTB            00000100 .. 010 000 101 ... ..... .....         @rd_pg_rn
-UXTB            00000100 .. 010 001 101 ... ..... .....         @rd_pg_rn
-SXTH            00000100 .. 010 010 101 ... ..... .....         @rd_pg_rn
-UXTH            00000100 .. 010 011 101 ... ..... .....         @rd_pg_rn
-SXTW            00000100 .. 010 100 101 ... ..... .....         @rd_pg_rn
-UXTW            00000100 .. 010 101 101 ... ..... .....         @rd_pg_rn
+ABS_m           00000100 .. 010 110 101 ... ..... .....         @rd_pg_rn
+NEG_m           00000100 .. 010 111 101 ... ..... .....         @rd_pg_rn
+SXTB_m          00000100 .. 010 000 101 ... ..... .....         @rd_pg_rn
+UXTB_m          00000100 .. 010 001 101 ... ..... .....         @rd_pg_rn
+SXTH_m          00000100 .. 010 010 101 ... ..... .....         @rd_pg_rn
+UXTH_m          00000100 .. 010 011 101 ... ..... .....         @rd_pg_rn
+SXTW_m          00000100 .. 010 100 101 ... ..... .....         @rd_pg_rn
+UXTW_m          00000100 .. 010 101 101 ... ..... .....         @rd_pg_rn
 
 ### SVE Floating Point Compare - Vectors Group
 
@@ -707,11 +707,11 @@ CPY_m_r         00000101 .. 101000 101 ... ..... .....          @rd_pg_rn
 
 # SVE reverse within elements
 # Note esz >= operation size
-REVB            00000101 .. 1001 00 100 ... ..... .....         @rd_pg_rn
-REVH            00000101 .. 1001 01 100 ... ..... .....         @rd_pg_rn
-REVW            00000101 .. 1001 10 100 ... ..... .....         @rd_pg_rn
-RBIT            00000101 .. 1001 11 100 ... ..... .....         @rd_pg_rn
-REVD            00000101 00 1011 10 100 ... ..... .....         @rd_pg_rn_e0
+REVB_m          00000101 .. 1001 00 100 ... ..... .....         @rd_pg_rn
+REVH_m          00000101 .. 1001 01 100 ... ..... .....         @rd_pg_rn
+REVW_m          00000101 .. 1001 10 100 ... ..... .....         @rd_pg_rn
+RBIT_m          00000101 .. 1001 11 100 ... ..... .....         @rd_pg_rn
+REVD_m          00000101 00 1011 10 100 ... ..... .....         @rd_pg_rn_e0
 
 # SVE vector splice (predicated, destructive)
 SPLICE          00000101 .. 101 100 100 ... ..... .....         @rdn_pg_rm
@@ -1184,59 +1184,59 @@ FNMLS_zpzzz     01100101 .. 1 ..... 111 ... ..... .....         @rdn_pg_rm_ra
 ### SVE FP Unary Operations Predicated Group
 
 # SVE floating-point convert precision
-FCVT_sh         01100101 10 0010 00 101 ... ..... .....         @rd_pg_rn_e0
-FCVT_hs         01100101 10 0010 01 101 ... ..... .....         @rd_pg_rn_e0
-BFCVT           01100101 10 0010 10 101 ... ..... .....         @rd_pg_rn_e0
-FCVT_dh         01100101 11 0010 00 101 ... ..... .....         @rd_pg_rn_e0
-FCVT_hd         01100101 11 0010 01 101 ... ..... .....         @rd_pg_rn_e0
-FCVT_ds         01100101 11 0010 10 101 ... ..... .....         @rd_pg_rn_e0
-FCVT_sd         01100101 11 0010 11 101 ... ..... .....         @rd_pg_rn_e0
+FCVT_sh_m       01100101 10 0010 00 101 ... ..... .....         @rd_pg_rn_e0
+FCVT_hs_m       01100101 10 0010 01 101 ... ..... .....         @rd_pg_rn_e0
+BFCVT_m         01100101 10 0010 10 101 ... ..... .....         @rd_pg_rn_e0
+FCVT_dh_m       01100101 11 0010 00 101 ... ..... .....         @rd_pg_rn_e0
+FCVT_hd_m       01100101 11 0010 01 101 ... ..... .....         @rd_pg_rn_e0
+FCVT_ds_m       01100101 11 0010 10 101 ... ..... .....         @rd_pg_rn_e0
+FCVT_sd_m       01100101 11 0010 11 101 ... ..... .....         @rd_pg_rn_e0
 
 # SVE floating-point convert to integer
-FCVTZS_hh       01100101 01 011 01 0 101 ... ..... .....        @rd_pg_rn_e0
-FCVTZU_hh       01100101 01 011 01 1 101 ... ..... .....        @rd_pg_rn_e0
-FCVTZS_hs       01100101 01 011 10 0 101 ... ..... .....        @rd_pg_rn_e0
-FCVTZU_hs       01100101 01 011 10 1 101 ... ..... .....        @rd_pg_rn_e0
-FCVTZS_hd       01100101 01 011 11 0 101 ... ..... .....        @rd_pg_rn_e0
-FCVTZU_hd       01100101 01 011 11 1 101 ... ..... .....        @rd_pg_rn_e0
-FCVTZS_ss       01100101 10 011 10 0 101 ... ..... .....        @rd_pg_rn_e0
-FCVTZU_ss       01100101 10 011 10 1 101 ... ..... .....        @rd_pg_rn_e0
-FCVTZS_ds       01100101 11 011 00 0 101 ... ..... .....        @rd_pg_rn_e0
-FCVTZU_ds       01100101 11 011 00 1 101 ... ..... .....        @rd_pg_rn_e0
-FCVTZS_sd       01100101 11 011 10 0 101 ... ..... .....        @rd_pg_rn_e0
-FCVTZU_sd       01100101 11 011 10 1 101 ... ..... .....        @rd_pg_rn_e0
-FCVTZS_dd       01100101 11 011 11 0 101 ... ..... .....        @rd_pg_rn_e0
-FCVTZU_dd       01100101 11 011 11 1 101 ... ..... .....        @rd_pg_rn_e0
+FCVTZS_hh_m     01100101 01 011 01 0 101 ... ..... .....        @rd_pg_rn_e0
+FCVTZU_hh_m     01100101 01 011 01 1 101 ... ..... .....        @rd_pg_rn_e0
+FCVTZS_hs_m     01100101 01 011 10 0 101 ... ..... .....        @rd_pg_rn_e0
+FCVTZU_hs_m     01100101 01 011 10 1 101 ... ..... .....        @rd_pg_rn_e0
+FCVTZS_hd_m     01100101 01 011 11 0 101 ... ..... .....        @rd_pg_rn_e0
+FCVTZU_hd_m     01100101 01 011 11 1 101 ... ..... .....        @rd_pg_rn_e0
+FCVTZS_ss_m     01100101 10 011 10 0 101 ... ..... .....        @rd_pg_rn_e0
+FCVTZU_ss_m     01100101 10 011 10 1 101 ... ..... .....        @rd_pg_rn_e0
+FCVTZS_ds_m     01100101 11 011 00 0 101 ... ..... .....        @rd_pg_rn_e0
+FCVTZU_ds_m     01100101 11 011 00 1 101 ... ..... .....        @rd_pg_rn_e0
+FCVTZS_sd_m     01100101 11 011 10 0 101 ... ..... .....        @rd_pg_rn_e0
+FCVTZU_sd_m     01100101 11 011 10 1 101 ... ..... .....        @rd_pg_rn_e0
+FCVTZS_dd_m     01100101 11 011 11 0 101 ... ..... .....        @rd_pg_rn_e0
+FCVTZU_dd_m     01100101 11 011 11 1 101 ... ..... .....        @rd_pg_rn_e0
 
 # SVE floating-point round to integral value
-FRINTN          01100101 .. 000 000 101 ... ..... .....         @rd_pg_rn
-FRINTP          01100101 .. 000 001 101 ... ..... .....         @rd_pg_rn
-FRINTM          01100101 .. 000 010 101 ... ..... .....         @rd_pg_rn
-FRINTZ          01100101 .. 000 011 101 ... ..... .....         @rd_pg_rn
-FRINTA          01100101 .. 000 100 101 ... ..... .....         @rd_pg_rn
-FRINTX          01100101 .. 000 110 101 ... ..... .....         @rd_pg_rn
-FRINTI          01100101 .. 000 111 101 ... ..... .....         @rd_pg_rn
+FRINTN_m        01100101 .. 000 000 101 ... ..... .....         @rd_pg_rn
+FRINTP_m        01100101 .. 000 001 101 ... ..... .....         @rd_pg_rn
+FRINTM_m        01100101 .. 000 010 101 ... ..... .....         @rd_pg_rn
+FRINTZ_m        01100101 .. 000 011 101 ... ..... .....         @rd_pg_rn
+FRINTA_m        01100101 .. 000 100 101 ... ..... .....         @rd_pg_rn
+FRINTX_m        01100101 .. 000 110 101 ... ..... .....         @rd_pg_rn
+FRINTI_m        01100101 .. 000 111 101 ... ..... .....         @rd_pg_rn
 
 # SVE floating-point unary operations
-FRECPX          01100101 .. 001 100 101 ... ..... .....         @rd_pg_rn
-FSQRT           01100101 .. 001 101 101 ... ..... .....         @rd_pg_rn
+FRECPX_m        01100101 .. 001 100 101 ... ..... .....         @rd_pg_rn
+FSQRT_m         01100101 .. 001 101 101 ... ..... .....         @rd_pg_rn
 
 # SVE integer convert to floating-point
-SCVTF_hh        01100101 01 010 01 0 101 ... ..... .....        @rd_pg_rn_e0
-SCVTF_sh        01100101 01 010 10 0 101 ... ..... .....        @rd_pg_rn_e0
-SCVTF_dh        01100101 01 010 11 0 101 ... ..... .....        @rd_pg_rn_e0
-SCVTF_ss        01100101 10 010 10 0 101 ... ..... .....        @rd_pg_rn_e0
-SCVTF_sd        01100101 11 010 00 0 101 ... ..... .....        @rd_pg_rn_e0
-SCVTF_ds        01100101 11 010 10 0 101 ... ..... .....        @rd_pg_rn_e0
-SCVTF_dd        01100101 11 010 11 0 101 ... ..... .....        @rd_pg_rn_e0
+SCVTF_hh_m      01100101 01 010 01 0 101 ... ..... .....        @rd_pg_rn_e0
+SCVTF_sh_m      01100101 01 010 10 0 101 ... ..... .....        @rd_pg_rn_e0
+SCVTF_dh_m      01100101 01 010 11 0 101 ... ..... .....        @rd_pg_rn_e0
+SCVTF_ss_m      01100101 10 010 10 0 101 ... ..... .....        @rd_pg_rn_e0
+SCVTF_sd_m      01100101 11 010 00 0 101 ... ..... .....        @rd_pg_rn_e0
+SCVTF_ds_m      01100101 11 010 10 0 101 ... ..... .....        @rd_pg_rn_e0
+SCVTF_dd_m      01100101 11 010 11 0 101 ... ..... .....        @rd_pg_rn_e0
 
-UCVTF_hh        01100101 01 010 01 1 101 ... ..... .....        @rd_pg_rn_e0
-UCVTF_sh        01100101 01 010 10 1 101 ... ..... .....        @rd_pg_rn_e0
-UCVTF_dh        01100101 01 010 11 1 101 ... ..... .....        @rd_pg_rn_e0
-UCVTF_ss        01100101 10 010 10 1 101 ... ..... .....        @rd_pg_rn_e0
-UCVTF_sd        01100101 11 010 00 1 101 ... ..... .....        @rd_pg_rn_e0
-UCVTF_ds        01100101 11 010 10 1 101 ... ..... .....        @rd_pg_rn_e0
-UCVTF_dd        01100101 11 010 11 1 101 ... ..... .....        @rd_pg_rn_e0
+UCVTF_hh_m      01100101 01 010 01 1 101 ... ..... .....        @rd_pg_rn_e0
+UCVTF_sh_m      01100101 01 010 10 1 101 ... ..... .....        @rd_pg_rn_e0
+UCVTF_dh_m      01100101 01 010 11 1 101 ... ..... .....        @rd_pg_rn_e0
+UCVTF_ss_m      01100101 10 010 10 1 101 ... ..... .....        @rd_pg_rn_e0
+UCVTF_sd_m      01100101 11 010 00 1 101 ... ..... .....        @rd_pg_rn_e0
+UCVTF_ds_m      01100101 11 010 10 1 101 ... ..... .....        @rd_pg_rn_e0
+UCVTF_dd_m      01100101 11 010 11 1 101 ... ..... .....        @rd_pg_rn_e0
 
 ### SVE Memory - 32-bit Gather and Unsized Contiguous Group
 
@@ -1517,10 +1517,10 @@ UADALP_zpzz     01000100 .. 000 101 101 ... ..... .....  @rdm_pg_rn
 
 ### SVE2 integer unary operations (predicated)
 
-URECPE          01000100 .. 000 000 101 ... ..... .....  @rd_pg_rn
-URSQRTE         01000100 .. 000 001 101 ... ..... .....  @rd_pg_rn
-SQABS           01000100 .. 001 000 101 ... ..... .....  @rd_pg_rn
-SQNEG           01000100 .. 001 001 101 ... ..... .....  @rd_pg_rn
+URECPE_m        01000100 .. 000 000 101 ... ..... .....  @rd_pg_rn
+URSQRTE_m       01000100 .. 000 001 101 ... ..... .....  @rd_pg_rn
+SQABS_m         01000100 .. 001 000 101 ... ..... .....  @rd_pg_rn
+SQNEG_m         01000100 .. 001 001 101 ... ..... .....  @rd_pg_rn
 
 ### SVE2 saturating/rounding bitwise shift left (predicated)
 
@@ -1847,16 +1847,16 @@ SM4EKEY         01000101 00 1 ..... 11110 0 ..... .....  @rd_rn_rm_e0
 RAX1            01000101 00 1 ..... 11110 1 ..... .....  @rd_rn_rm_e0
 
 ### SVE2 floating-point convert precision odd elements
-FCVTXNT_ds      01100100 00 0010 10 101 ... ..... .....  @rd_pg_rn_e0
-FCVTX_ds        01100101 00 0010 10 101 ... ..... .....  @rd_pg_rn_e0
-FCVTNT_sh       01100100 10 0010 00 101 ... ..... .....  @rd_pg_rn_e0
-BFCVTNT         01100100 10 0010 10 101 ... ..... .....  @rd_pg_rn_e0
-FCVTLT_hs       01100100 10 0010 01 101 ... ..... .....  @rd_pg_rn_e0
-FCVTNT_ds       01100100 11 0010 10 101 ... ..... .....  @rd_pg_rn_e0
-FCVTLT_sd       01100100 11 0010 11 101 ... ..... .....  @rd_pg_rn_e0
+FCVTXNT_ds_m    01100100 00 0010 10 101 ... ..... .....  @rd_pg_rn_e0
+FCVTX_ds_m      01100101 00 0010 10 101 ... ..... .....  @rd_pg_rn_e0
+FCVTNT_sh_m     01100100 10 0010 00 101 ... ..... .....  @rd_pg_rn_e0
+BFCVTNT_m       01100100 10 0010 10 101 ... ..... .....  @rd_pg_rn_e0
+FCVTLT_hs_m     01100100 10 0010 01 101 ... ..... .....  @rd_pg_rn_e0
+FCVTNT_ds_m     01100100 11 0010 10 101 ... ..... .....  @rd_pg_rn_e0
+FCVTLT_sd_m     01100100 11 0010 11 101 ... ..... .....  @rd_pg_rn_e0
 
 ### SVE2 floating-point convert to integer
-FLOGB           01100101 00 011 esz:2 0101 pg:3 rn:5 rd:5  &rpr_esz
+FLOGB_m         01100101 00 011 esz:2 0101 pg:3 rn:5 rd:5  &rpr_esz
 
 ### SVE2 floating-point multiply-add long (vectors)
 FMLALB_zzzw     01100100 10 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index a85558bdaa..4fd17905d5 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -783,14 +783,14 @@ TRANS_FEAT(SEL_zpzz, aa64_sme_or_sve, do_sel_z, a->rd, a->rn, a->rm, a->pg, a->e
     };                                                              \
     TRANS_FEAT(NAME, FEAT, gen_gvec_ool_arg_zpz, name##_fns[a->esz], a, 0)
 
-DO_ZPZ(CLS, aa64_sme_or_sve, sve_cls)
-DO_ZPZ(CLZ, aa64_sme_or_sve, sve_clz)
-DO_ZPZ(CNT_zpz, aa64_sme_or_sve, sve_cnt_zpz)
-DO_ZPZ(CNOT, aa64_sme_or_sve, sve_cnot)
-DO_ZPZ(NOT_zpz, aa64_sme_or_sve, sve_not_zpz)
-DO_ZPZ(ABS, aa64_sme_or_sve, sve_abs)
-DO_ZPZ(NEG, aa64_sme_or_sve, sve_neg)
-DO_ZPZ(RBIT, aa64_sme_or_sve, sve_rbit)
+DO_ZPZ(CLS_m, aa64_sme_or_sve, sve_cls)
+DO_ZPZ(CLZ_m, aa64_sme_or_sve, sve_clz)
+DO_ZPZ(CNT_zpz_m, aa64_sme_or_sve, sve_cnt_zpz)
+DO_ZPZ(CNOT_m, aa64_sme_or_sve, sve_cnot)
+DO_ZPZ(NOT_zpz_m, aa64_sme_or_sve, sve_not_zpz)
+DO_ZPZ(ABS_m, aa64_sme_or_sve, sve_abs)
+DO_ZPZ(NEG_m, aa64_sme_or_sve, sve_neg)
+DO_ZPZ(RBIT_m, aa64_sme_or_sve, sve_rbit)
 DO_ZPZ(ORQV, aa64_sme2p1_or_sve2p1, sve2p1_orqv)
 DO_ZPZ(EORQV, aa64_sme2p1_or_sve2p1, sve2p1_eorqv)
 DO_ZPZ(ANDQV, aa64_sme2p1_or_sve2p1, sve2p1_andqv)
@@ -803,7 +803,7 @@ static gen_helper_gvec_3 * const fabs_ah_fns[4] = {
     NULL,                  gen_helper_sve_ah_fabs_h,
     gen_helper_sve_ah_fabs_s, gen_helper_sve_ah_fabs_d,
 };
-TRANS_FEAT(FABS, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
+TRANS_FEAT(FABS_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
            s->fpcr_ah ? fabs_ah_fns[a->esz] : fabs_fns[a->esz], a, 0)
 
 static gen_helper_gvec_3 * const fneg_fns[4] = {
@@ -814,34 +814,38 @@ static gen_helper_gvec_3 * const fneg_ah_fns[4] = {
     NULL,                  gen_helper_sve_ah_fneg_h,
     gen_helper_sve_ah_fneg_s, gen_helper_sve_ah_fneg_d,
 };
-TRANS_FEAT(FNEG, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
+TRANS_FEAT(FNEG_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
            s->fpcr_ah ? fneg_ah_fns[a->esz] : fneg_fns[a->esz], a, 0)
 
 static gen_helper_gvec_3 * const sxtb_fns[4] = {
     NULL,                  gen_helper_sve_sxtb_h,
     gen_helper_sve_sxtb_s, gen_helper_sve_sxtb_d,
 };
-TRANS_FEAT(SXTB, aa64_sme_or_sve, gen_gvec_ool_arg_zpz, sxtb_fns[a->esz], a, 0)
+TRANS_FEAT(SXTB_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
+           sxtb_fns[a->esz], a, 0)
 
 static gen_helper_gvec_3 * const uxtb_fns[4] = {
     NULL,                  gen_helper_sve_uxtb_h,
     gen_helper_sve_uxtb_s, gen_helper_sve_uxtb_d,
 };
-TRANS_FEAT(UXTB, aa64_sme_or_sve, gen_gvec_ool_arg_zpz, uxtb_fns[a->esz], a, 0)
+TRANS_FEAT(UXTB_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
+           uxtb_fns[a->esz], a, 0)
 
 static gen_helper_gvec_3 * const sxth_fns[4] = {
     NULL, NULL, gen_helper_sve_sxth_s, gen_helper_sve_sxth_d
 };
-TRANS_FEAT(SXTH, aa64_sme_or_sve, gen_gvec_ool_arg_zpz, sxth_fns[a->esz], a, 0)
+TRANS_FEAT(SXTH_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
+           sxth_fns[a->esz], a, 0)
 
 static gen_helper_gvec_3 * const uxth_fns[4] = {
     NULL, NULL, gen_helper_sve_uxth_s, gen_helper_sve_uxth_d
 };
-TRANS_FEAT(UXTH, aa64_sme_or_sve, gen_gvec_ool_arg_zpz, uxth_fns[a->esz], a, 0)
+TRANS_FEAT(UXTH_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
+           uxth_fns[a->esz], a, 0)
 
-TRANS_FEAT(SXTW, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
+TRANS_FEAT(SXTW_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
            a->esz == 3 ? gen_helper_sve_sxtw_d : NULL, a, 0)
-TRANS_FEAT(UXTW, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
+TRANS_FEAT(UXTW_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
            a->esz == 3 ? gen_helper_sve_uxtw_d : NULL, a, 0)
 
 static gen_helper_gvec_3 * const addqv_fns[4] = {
@@ -2984,17 +2988,19 @@ static gen_helper_gvec_3 * const revb_fns[4] = {
     NULL,                  gen_helper_sve_revb_h,
     gen_helper_sve_revb_s, gen_helper_sve_revb_d,
 };
-TRANS_FEAT(REVB, aa64_sme_or_sve, gen_gvec_ool_arg_zpz, revb_fns[a->esz], a, 0)
+TRANS_FEAT(REVB_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
+           revb_fns[a->esz], a, 0)
 
 static gen_helper_gvec_3 * const revh_fns[4] = {
     NULL, NULL, gen_helper_sve_revh_s, gen_helper_sve_revh_d,
 };
-TRANS_FEAT(REVH, aa64_sme_or_sve, gen_gvec_ool_arg_zpz, revh_fns[a->esz], a, 0)
+TRANS_FEAT(REVH_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
+           revh_fns[a->esz], a, 0)
 
-TRANS_FEAT(REVW, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
+TRANS_FEAT(REVW_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
            a->esz == 3 ? gen_helper_sve_revw_d : NULL, a, 0)
 
-TRANS_FEAT(REVD, aa64_sme_or_sve2p1, gen_gvec_ool_arg_zpz,
+TRANS_FEAT(REVD_m, aa64_sme_or_sve2p1, gen_gvec_ool_arg_zpz,
            gen_helper_sme_revd_q, a, 0)
 
 TRANS_FEAT(SPLICE, aa64_sme_or_sve, gen_gvec_ool_arg_zpzz,
@@ -4491,53 +4497,53 @@ TRANS_FEAT(FCMLA_zzxz, aa64_sme_or_sve, gen_gvec_fpst_zzzz, fcmla_idx_fns[a->esz
  *** SVE Floating Point Unary Operations Predicated Group
  */
 
-TRANS_FEAT(FCVT_sh, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVT_sh_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvt_sh, a, 0, FPST_A64)
-TRANS_FEAT(FCVT_hs, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVT_hs_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvt_hs, a, 0, FPST_A64_F16)
 
-TRANS_FEAT(BFCVT, aa64_sme_sve_bf16, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(BFCVT_m, aa64_sme_sve_bf16, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_bfcvt, a, 0,
            s->fpcr_ah ? FPST_AH : FPST_A64)
 
-TRANS_FEAT(FCVT_dh, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVT_dh_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvt_dh, a, 0, FPST_A64)
-TRANS_FEAT(FCVT_hd, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVT_hd_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvt_hd, a, 0, FPST_A64_F16)
-TRANS_FEAT(FCVT_ds, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVT_ds_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvt_ds, a, 0, FPST_A64)
-TRANS_FEAT(FCVT_sd, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVT_sd_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvt_sd, a, 0, FPST_A64)
 
-TRANS_FEAT(FCVTZS_hh, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTZS_hh_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvtzs_hh, a, 0, FPST_A64_F16)
-TRANS_FEAT(FCVTZU_hh, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTZU_hh_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvtzu_hh, a, 0, FPST_A64_F16)
-TRANS_FEAT(FCVTZS_hs, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTZS_hs_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvtzs_hs, a, 0, FPST_A64_F16)
-TRANS_FEAT(FCVTZU_hs, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTZU_hs_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvtzu_hs, a, 0, FPST_A64_F16)
-TRANS_FEAT(FCVTZS_hd, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTZS_hd_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvtzs_hd, a, 0, FPST_A64_F16)
-TRANS_FEAT(FCVTZU_hd, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTZU_hd_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvtzu_hd, a, 0, FPST_A64_F16)
 
-TRANS_FEAT(FCVTZS_ss, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTZS_ss_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvtzs_ss, a, 0, FPST_A64)
-TRANS_FEAT(FCVTZU_ss, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTZU_ss_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvtzu_ss, a, 0, FPST_A64)
-TRANS_FEAT(FCVTZS_sd, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTZS_sd_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvtzs_sd, a, 0, FPST_A64)
-TRANS_FEAT(FCVTZU_sd, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTZU_sd_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvtzu_sd, a, 0, FPST_A64)
-TRANS_FEAT(FCVTZS_ds, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTZS_ds_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvtzs_ds, a, 0, FPST_A64)
-TRANS_FEAT(FCVTZU_ds, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTZU_ds_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvtzu_ds, a, 0, FPST_A64)
 
-TRANS_FEAT(FCVTZS_dd, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTZS_dd_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvtzs_dd, a, 0, FPST_A64)
-TRANS_FEAT(FCVTZU_dd, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTZU_dd_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvtzu_dd, a, 0, FPST_A64)
 
 static gen_helper_gvec_3_ptr * const frint_fns[] = {
@@ -4546,8 +4552,9 @@ static gen_helper_gvec_3_ptr * const frint_fns[] = {
     gen_helper_sve_frint_s,
     gen_helper_sve_frint_d
 };
-TRANS_FEAT(FRINTI, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz, frint_fns[a->esz],
-           a, 0, a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
+TRANS_FEAT(FRINTI_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+           frint_fns[a->esz], a, 0,
+           a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
 
 static gen_helper_gvec_3_ptr * const frintx_fns[] = {
     NULL,
@@ -4555,8 +4562,9 @@ static gen_helper_gvec_3_ptr * const frintx_fns[] = {
     gen_helper_sve_frintx_s,
     gen_helper_sve_frintx_d
 };
-TRANS_FEAT(FRINTX, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz, frintx_fns[a->esz],
-           a, 0, a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
+TRANS_FEAT(FRINTX_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+           frintx_fns[a->esz], a, 0,
+           a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
 
 static bool do_frint_mode(DisasContext *s, arg_rpr_esz *a,
                           ARMFPRounding mode, gen_helper_gvec_3_ptr *fn)
@@ -4585,63 +4593,64 @@ static bool do_frint_mode(DisasContext *s, arg_rpr_esz *a,
     return true;
 }
 
-TRANS_FEAT(FRINTN, aa64_sme_or_sve, do_frint_mode, a,
+TRANS_FEAT(FRINTN_m, aa64_sme_or_sve, do_frint_mode, a,
            FPROUNDING_TIEEVEN, frint_fns[a->esz])
-TRANS_FEAT(FRINTP, aa64_sme_or_sve, do_frint_mode, a,
+TRANS_FEAT(FRINTP_m, aa64_sme_or_sve, do_frint_mode, a,
            FPROUNDING_POSINF, frint_fns[a->esz])
-TRANS_FEAT(FRINTM, aa64_sme_or_sve, do_frint_mode, a,
+TRANS_FEAT(FRINTM_m, aa64_sme_or_sve, do_frint_mode, a,
            FPROUNDING_NEGINF, frint_fns[a->esz])
-TRANS_FEAT(FRINTZ, aa64_sme_or_sve, do_frint_mode, a,
+TRANS_FEAT(FRINTZ_m, aa64_sme_or_sve, do_frint_mode, a,
            FPROUNDING_ZERO, frint_fns[a->esz])
-TRANS_FEAT(FRINTA, aa64_sme_or_sve, do_frint_mode, a,
+TRANS_FEAT(FRINTA_m, aa64_sme_or_sve, do_frint_mode, a,
            FPROUNDING_TIEAWAY, frint_fns[a->esz])
 
 static gen_helper_gvec_3_ptr * const frecpx_fns[] = {
     NULL,                    gen_helper_sve_frecpx_h,
     gen_helper_sve_frecpx_s, gen_helper_sve_frecpx_d,
 };
-TRANS_FEAT(FRECPX, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz, frecpx_fns[a->esz],
-           a, 0, select_ah_fpst(s, a->esz))
+TRANS_FEAT(FRECPX_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+           frecpx_fns[a->esz], a, 0, select_ah_fpst(s, a->esz))
 
 static gen_helper_gvec_3_ptr * const fsqrt_fns[] = {
     NULL,                   gen_helper_sve_fsqrt_h,
     gen_helper_sve_fsqrt_s, gen_helper_sve_fsqrt_d,
 };
-TRANS_FEAT(FSQRT, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz, fsqrt_fns[a->esz],
-           a, 0, a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
+TRANS_FEAT(FSQRT_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+           fsqrt_fns[a->esz], a, 0,
+           a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
 
-TRANS_FEAT(SCVTF_hh, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(SCVTF_hh_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_scvt_hh, a, 0, FPST_A64_F16)
-TRANS_FEAT(SCVTF_sh, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(SCVTF_sh_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_scvt_sh, a, 0, FPST_A64_F16)
-TRANS_FEAT(SCVTF_dh, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(SCVTF_dh_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_scvt_dh, a, 0, FPST_A64_F16)
 
-TRANS_FEAT(SCVTF_ss, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(SCVTF_ss_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_scvt_ss, a, 0, FPST_A64)
-TRANS_FEAT(SCVTF_ds, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(SCVTF_ds_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_scvt_ds, a, 0, FPST_A64)
 
-TRANS_FEAT(SCVTF_sd, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(SCVTF_sd_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_scvt_sd, a, 0, FPST_A64)
-TRANS_FEAT(SCVTF_dd, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(SCVTF_dd_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_scvt_dd, a, 0, FPST_A64)
 
-TRANS_FEAT(UCVTF_hh, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(UCVTF_hh_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_ucvt_hh, a, 0, FPST_A64_F16)
-TRANS_FEAT(UCVTF_sh, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(UCVTF_sh_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_ucvt_sh, a, 0, FPST_A64_F16)
-TRANS_FEAT(UCVTF_dh, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(UCVTF_dh_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_ucvt_dh, a, 0, FPST_A64_F16)
 
-TRANS_FEAT(UCVTF_ss, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(UCVTF_ss_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_ucvt_ss, a, 0, FPST_A64)
-TRANS_FEAT(UCVTF_ds, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(UCVTF_ds_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_ucvt_ds, a, 0, FPST_A64)
-TRANS_FEAT(UCVTF_sd, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(UCVTF_sd_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_ucvt_sd, a, 0, FPST_A64)
 
-TRANS_FEAT(UCVTF_dd, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(UCVTF_dd_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_ucvt_dd, a, 0, FPST_A64)
 
 /*
@@ -6691,23 +6700,23 @@ TRANS_FEAT(UADALP_zpzz, aa64_sme_or_sve2, gen_gvec_ool_arg_zpzz,
  * SVE2 integer unary operations (predicated)
  */
 
-TRANS_FEAT(URECPE, aa64_sme_or_sve2, gen_gvec_ool_arg_zpz,
+TRANS_FEAT(URECPE_m, aa64_sme_or_sve2, gen_gvec_ool_arg_zpz,
            a->esz == 2 ? gen_helper_sve2_urecpe_s : NULL, a, 0)
 
-TRANS_FEAT(URSQRTE, aa64_sme_or_sve2, gen_gvec_ool_arg_zpz,
+TRANS_FEAT(URSQRTE_m, aa64_sme_or_sve2, gen_gvec_ool_arg_zpz,
            a->esz == 2 ? gen_helper_sve2_ursqrte_s : NULL, a, 0)
 
 static gen_helper_gvec_3 * const sqabs_fns[4] = {
     gen_helper_sve2_sqabs_b, gen_helper_sve2_sqabs_h,
     gen_helper_sve2_sqabs_s, gen_helper_sve2_sqabs_d,
 };
-TRANS_FEAT(SQABS, aa64_sme_or_sve2, gen_gvec_ool_arg_zpz, sqabs_fns[a->esz], a, 0)
+TRANS_FEAT(SQABS_m, aa64_sme_or_sve2, gen_gvec_ool_arg_zpz, sqabs_fns[a->esz], a, 0)
 
 static gen_helper_gvec_3 * const sqneg_fns[4] = {
     gen_helper_sve2_sqneg_b, gen_helper_sve2_sqneg_h,
     gen_helper_sve2_sqneg_s, gen_helper_sve2_sqneg_d,
 };
-TRANS_FEAT(SQNEG, aa64_sme_or_sve2, gen_gvec_ool_arg_zpz, sqneg_fns[a->esz], a, 0)
+TRANS_FEAT(SQNEG_m, aa64_sme_or_sve2, gen_gvec_ool_arg_zpz, sqneg_fns[a->esz], a, 0)
 
 DO_ZPZZ(SQSHL, aa64_sme_or_sve2, sve2_sqshl)
 DO_ZPZZ(SQRSHL, aa64_sme_or_sve2, sve2_sqrshl)
@@ -7879,30 +7888,30 @@ static bool trans_RAX1(DisasContext *s, arg_RAX1 *a)
     return gen_gvec_fn_arg_zzz(s, gen_gvec_rax1, a);
 }
 
-TRANS_FEAT(FCVTNT_sh, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTNT_sh_m, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
            gen_helper_sve2_fcvtnt_sh, a, 0, FPST_A64)
-TRANS_FEAT(FCVTNT_ds, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTNT_ds_m, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
            gen_helper_sve2_fcvtnt_ds, a, 0, FPST_A64)
 
-TRANS_FEAT(BFCVTNT, aa64_sme_sve_bf16, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(BFCVTNT_m, aa64_sme_sve_bf16, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_bfcvtnt, a, 0,
            s->fpcr_ah ? FPST_AH : FPST_A64)
 
-TRANS_FEAT(FCVTLT_hs, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTLT_hs_m, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
            gen_helper_sve2_fcvtlt_hs, a, 0, FPST_A64_F16)
-TRANS_FEAT(FCVTLT_sd, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
+TRANS_FEAT(FCVTLT_sd_m, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
            gen_helper_sve2_fcvtlt_sd, a, 0, FPST_A64)
 
-TRANS_FEAT(FCVTX_ds, aa64_sme_or_sve2, do_frint_mode, a,
+TRANS_FEAT(FCVTX_ds_m, aa64_sme_or_sve2, do_frint_mode, a,
            FPROUNDING_ODD, gen_helper_sve_fcvt_ds)
-TRANS_FEAT(FCVTXNT_ds, aa64_sme_or_sve2, do_frint_mode, a,
+TRANS_FEAT(FCVTXNT_ds_m, aa64_sme_or_sve2, do_frint_mode, a,
            FPROUNDING_ODD, gen_helper_sve2_fcvtnt_ds)
 
 static gen_helper_gvec_3_ptr * const flogb_fns[] = {
     NULL,               gen_helper_flogb_h,
     gen_helper_flogb_s, gen_helper_flogb_d
 };
-TRANS_FEAT(FLOGB, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz, flogb_fns[a->esz],
+TRANS_FEAT(FLOGB_m, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz, flogb_fns[a->esz],
            a, 0, a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
 
 static bool do_FMLAL_zzzw(DisasContext *s, arg_rrrr_esz *a, bool sub, bool sel)
-- 
2.43.0


