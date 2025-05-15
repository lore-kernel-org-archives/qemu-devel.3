Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C0FC3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:30:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVne-0005OZ-OI; Thu, 15 May 2025 06:26:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnJ-00050L-QD
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:30 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnE-0008C1-Ca
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:29 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-442e9c00bf4so5680865e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304782; x=1747909582; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LysuqBZEQ7TEXzoI4X5szGeQ4D/3+Ej8EqCa4rKNEJg=;
 b=B8Ps/ZoqSqAwT+al6sJlLEzvFRn/wuLCAmctmvTUVsfVTqpzdxahdiMZYcdy8ZiN9T
 48odWcK1rFEwCXoTjaM+DHxNoSMedXvJUtZNjCUxAMY2jJdkZrJ3ZBqtfCoTkoS6tuZR
 HtXk56wlz1HG0Rty+JsMeSZ08l6ITFG5g/d27PV/XTm9DN3U1ZUuyQoui/+dcEMqk1KP
 z+EsoQhkZooooHn3vg+xrUAOGmfAaA9g1Fcc37GSU7aE4TFcmYVbMWcxlH5x3jbfGzMi
 Wha1XQoKUFYMSnBOJIM+rMs6s7lFcDrVdbcBhGl4aoc5mJDSsv13B9/gqNRjP2C8QzyD
 Zo8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304782; x=1747909582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LysuqBZEQ7TEXzoI4X5szGeQ4D/3+Ej8EqCa4rKNEJg=;
 b=kB8oljs9e71Vt5GZTaP+3o18PCt6pFPMB7g/vvbW1V++MybBwVEPAzAWzNhY5Qi8Nd
 FVRAMIS3Mv/Idw3hBg7L9m5z6fXv8Lqxn4hIcfUZebuht4hVUgc7QfeZlfRndxgv1LSB
 qj4fl4hJTTzi4tSwWcHEKIkvhjEVcU133W5VTjVD+VCsttY50s84rh58ZjWS/0Lhxfye
 VI+GlNh3dGyH9/EaONFnZXynhznNdVpoXVQakE0y7DsxVmsPWU3lgA1XqO0P9DQ2V6hv
 zbFU9NDOrotxwE1CM3e7A1EnbuWxx1O0kd+QZjcFW1TYrdHzbzmh79QvTj3OXeqp4Zo0
 ZSyg==
X-Gm-Message-State: AOJu0YwCLJ8Y7px1PMXHEJ8jHpTtpoFVUBCcfD01miDQm9ulo20HhSOT
 WrmO80q7+n1Gn32IwMWZa9J7KBQrxnmnXaF/hcfcDMBTi9gT0dTUEVghs3cPkuo6M3TAKdI3IDe
 7h80=
X-Gm-Gg: ASbGncvUvDtSlv5RlwtWkKWtCLn2TZh6KShQmaQBKKjJCPr+CUQd8y+/xSJdgbuT9Gj
 PhqvO8dlTRPfq09/vMgLqMI862c2rYQi21SGzmuzA0i8S/Ns2fXd4AHqSxp9zTP7dDjjQWuOmCl
 RCyFZQHdc7HKrjFRYS3GUJpp2R5nsJTly3JI/vIl8BhoNofgHXhe634hmjgU8+MYpx1S9+tUDU6
 u6hQ3Y/sLV4t7xJSZDaWtqYB6UahJMDirkYGjLX9iLghk4K6+dgS6skFzEcyRtiD3yPt+SktOVC
 TRvxc/39/v86Vw/JWDLyF++lJWSp0gJpYE2UeFsT8d54Ed9OnN9nmYnhlQ==
X-Google-Smtp-Source: AGHT+IEJ3+1RGBrXn5vGI+ERFqCxp4b1pA2uzt6bahe4Aw4PTcLZ2g4f18dtJIt4diaQ9W9ROAFNRQ==
X-Received: by 2002:a05:600c:154a:b0:442:d9f2:c6ef with SMTP id
 5b1f17b1804b1-442f96e5234mr16640345e9.2.1747304782024; 
 Thu, 15 May 2025 03:26:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.26.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:26:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/58] target/arm/helper: extract common helpers
Date: Thu, 15 May 2025 11:25:13 +0100
Message-ID: <20250515102546.2149601-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Allow later commits to include only the "new" tcg/helper.h, thus
preventing to pull aarch64 helpers (+ target/arm/helper.h contains a
ifdef TARGET_AARCH64).

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250512180502.2395029-16-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h           | 1152 +--------------------------------
 target/arm/{ => tcg}/helper.h |   10 +-
 2 files changed, 4 insertions(+), 1158 deletions(-)
 copy target/arm/{ => tcg}/helper.h (99%)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 0a4fc90fa8b..f340a49a28a 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -1,1154 +1,6 @@
-DEF_HELPER_FLAGS_1(sxtb16, TCG_CALL_NO_RWG_SE, i32, i32)
-DEF_HELPER_FLAGS_1(uxtb16, TCG_CALL_NO_RWG_SE, i32, i32)
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 
-DEF_HELPER_3(add_setq, i32, env, i32, i32)
-DEF_HELPER_3(add_saturate, i32, env, i32, i32)
-DEF_HELPER_3(sub_saturate, i32, env, i32, i32)
-DEF_HELPER_3(add_usaturate, i32, env, i32, i32)
-DEF_HELPER_3(sub_usaturate, i32, env, i32, i32)
-DEF_HELPER_FLAGS_3(sdiv, TCG_CALL_NO_RWG, s32, env, s32, s32)
-DEF_HELPER_FLAGS_3(udiv, TCG_CALL_NO_RWG, i32, env, i32, i32)
-DEF_HELPER_FLAGS_1(rbit, TCG_CALL_NO_RWG_SE, i32, i32)
-
-#define PAS_OP(pfx)  \
-    DEF_HELPER_3(pfx ## add8, i32, i32, i32, ptr) \
-    DEF_HELPER_3(pfx ## sub8, i32, i32, i32, ptr) \
-    DEF_HELPER_3(pfx ## sub16, i32, i32, i32, ptr) \
-    DEF_HELPER_3(pfx ## add16, i32, i32, i32, ptr) \
-    DEF_HELPER_3(pfx ## addsubx, i32, i32, i32, ptr) \
-    DEF_HELPER_3(pfx ## subaddx, i32, i32, i32, ptr)
-
-PAS_OP(s)
-PAS_OP(u)
-#undef PAS_OP
-
-#define PAS_OP(pfx)  \
-    DEF_HELPER_2(pfx ## add8, i32, i32, i32) \
-    DEF_HELPER_2(pfx ## sub8, i32, i32, i32) \
-    DEF_HELPER_2(pfx ## sub16, i32, i32, i32) \
-    DEF_HELPER_2(pfx ## add16, i32, i32, i32) \
-    DEF_HELPER_2(pfx ## addsubx, i32, i32, i32) \
-    DEF_HELPER_2(pfx ## subaddx, i32, i32, i32)
-PAS_OP(q)
-PAS_OP(sh)
-PAS_OP(uq)
-PAS_OP(uh)
-#undef PAS_OP
-
-DEF_HELPER_3(ssat, i32, env, i32, i32)
-DEF_HELPER_3(usat, i32, env, i32, i32)
-DEF_HELPER_3(ssat16, i32, env, i32, i32)
-DEF_HELPER_3(usat16, i32, env, i32, i32)
-
-DEF_HELPER_FLAGS_2(usad8, TCG_CALL_NO_RWG_SE, i32, i32, i32)
-
-DEF_HELPER_FLAGS_3(sel_flags, TCG_CALL_NO_RWG_SE,
-                   i32, i32, i32, i32)
-DEF_HELPER_2(exception_internal, noreturn, env, i32)
-DEF_HELPER_3(exception_with_syndrome, noreturn, env, i32, i32)
-DEF_HELPER_4(exception_with_syndrome_el, noreturn, env, i32, i32, i32)
-DEF_HELPER_2(exception_bkpt_insn, noreturn, env, i32)
-DEF_HELPER_2(exception_swstep, noreturn, env, i32)
-DEF_HELPER_2(exception_pc_alignment, noreturn, env, vaddr)
-DEF_HELPER_1(setend, void, env)
-DEF_HELPER_2(wfi, void, env, i32)
-DEF_HELPER_1(wfe, void, env)
-DEF_HELPER_2(wfit, void, env, i64)
-DEF_HELPER_1(yield, void, env)
-DEF_HELPER_1(pre_hvc, void, env)
-DEF_HELPER_2(pre_smc, void, env, i32)
-DEF_HELPER_1(vesb, void, env)
-
-DEF_HELPER_3(cpsr_write, void, env, i32, i32)
-DEF_HELPER_2(cpsr_write_eret, void, env, i32)
-DEF_HELPER_1(cpsr_read, i32, env)
-
-DEF_HELPER_3(v7m_msr, void, env, i32, i32)
-DEF_HELPER_2(v7m_mrs, i32, env, i32)
-
-DEF_HELPER_2(v7m_bxns, void, env, i32)
-DEF_HELPER_2(v7m_blxns, void, env, i32)
-
-DEF_HELPER_3(v7m_tt, i32, env, i32, i32)
-
-DEF_HELPER_1(v7m_preserve_fp_state, void, env)
-
-DEF_HELPER_2(v7m_vlstm, void, env, i32)
-DEF_HELPER_2(v7m_vlldm, void, env, i32)
-
-DEF_HELPER_2(v8m_stackcheck, void, env, i32)
-
-DEF_HELPER_FLAGS_2(check_bxj_trap, TCG_CALL_NO_WG, void, env, i32)
-
-DEF_HELPER_4(access_check_cp_reg, cptr, env, i32, i32, i32)
-DEF_HELPER_FLAGS_2(lookup_cp_reg, TCG_CALL_NO_RWG_SE, cptr, env, i32)
-DEF_HELPER_FLAGS_2(tidcp_el0, TCG_CALL_NO_WG, void, env, i32)
-DEF_HELPER_FLAGS_2(tidcp_el1, TCG_CALL_NO_WG, void, env, i32)
-DEF_HELPER_3(set_cp_reg, void, env, cptr, i32)
-DEF_HELPER_2(get_cp_reg, i32, env, cptr)
-DEF_HELPER_3(set_cp_reg64, void, env, cptr, i64)
-DEF_HELPER_2(get_cp_reg64, i64, env, cptr)
-
-DEF_HELPER_2(get_r13_banked, i32, env, i32)
-DEF_HELPER_3(set_r13_banked, void, env, i32, i32)
-
-DEF_HELPER_3(mrs_banked, i32, env, i32, i32)
-DEF_HELPER_4(msr_banked, void, env, i32, i32, i32)
-
-DEF_HELPER_2(get_user_reg, i32, env, i32)
-DEF_HELPER_3(set_user_reg, void, env, i32, i32)
-
-DEF_HELPER_FLAGS_1(rebuild_hflags_m32_newel, TCG_CALL_NO_RWG, void, env)
-DEF_HELPER_FLAGS_2(rebuild_hflags_m32, TCG_CALL_NO_RWG, void, env, int)
-DEF_HELPER_FLAGS_1(rebuild_hflags_a32_newel, TCG_CALL_NO_RWG, void, env)
-DEF_HELPER_FLAGS_2(rebuild_hflags_a32, TCG_CALL_NO_RWG, void, env, int)
-DEF_HELPER_FLAGS_2(rebuild_hflags_a64, TCG_CALL_NO_RWG, void, env, int)
-
-DEF_HELPER_FLAGS_5(probe_access, TCG_CALL_NO_WG, void, env, vaddr, i32, i32, i32)
-
-DEF_HELPER_1(vfp_get_fpscr, i32, env)
-DEF_HELPER_2(vfp_set_fpscr, void, env, i32)
-
-DEF_HELPER_3(vfp_addh, f16, f16, f16, fpst)
-DEF_HELPER_3(vfp_adds, f32, f32, f32, fpst)
-DEF_HELPER_3(vfp_addd, f64, f64, f64, fpst)
-DEF_HELPER_3(vfp_subh, f16, f16, f16, fpst)
-DEF_HELPER_3(vfp_subs, f32, f32, f32, fpst)
-DEF_HELPER_3(vfp_subd, f64, f64, f64, fpst)
-DEF_HELPER_3(vfp_mulh, f16, f16, f16, fpst)
-DEF_HELPER_3(vfp_muls, f32, f32, f32, fpst)
-DEF_HELPER_3(vfp_muld, f64, f64, f64, fpst)
-DEF_HELPER_3(vfp_divh, f16, f16, f16, fpst)
-DEF_HELPER_3(vfp_divs, f32, f32, f32, fpst)
-DEF_HELPER_3(vfp_divd, f64, f64, f64, fpst)
-DEF_HELPER_3(vfp_maxh, f16, f16, f16, fpst)
-DEF_HELPER_3(vfp_maxs, f32, f32, f32, fpst)
-DEF_HELPER_3(vfp_maxd, f64, f64, f64, fpst)
-DEF_HELPER_3(vfp_minh, f16, f16, f16, fpst)
-DEF_HELPER_3(vfp_mins, f32, f32, f32, fpst)
-DEF_HELPER_3(vfp_mind, f64, f64, f64, fpst)
-DEF_HELPER_3(vfp_maxnumh, f16, f16, f16, fpst)
-DEF_HELPER_3(vfp_maxnums, f32, f32, f32, fpst)
-DEF_HELPER_3(vfp_maxnumd, f64, f64, f64, fpst)
-DEF_HELPER_3(vfp_minnumh, f16, f16, f16, fpst)
-DEF_HELPER_3(vfp_minnums, f32, f32, f32, fpst)
-DEF_HELPER_3(vfp_minnumd, f64, f64, f64, fpst)
-DEF_HELPER_2(vfp_sqrth, f16, f16, fpst)
-DEF_HELPER_2(vfp_sqrts, f32, f32, fpst)
-DEF_HELPER_2(vfp_sqrtd, f64, f64, fpst)
-DEF_HELPER_3(vfp_cmph, void, f16, f16, env)
-DEF_HELPER_3(vfp_cmps, void, f32, f32, env)
-DEF_HELPER_3(vfp_cmpd, void, f64, f64, env)
-DEF_HELPER_3(vfp_cmpeh, void, f16, f16, env)
-DEF_HELPER_3(vfp_cmpes, void, f32, f32, env)
-DEF_HELPER_3(vfp_cmped, void, f64, f64, env)
-
-DEF_HELPER_2(vfp_fcvtds, f64, f32, fpst)
-DEF_HELPER_2(vfp_fcvtsd, f32, f64, fpst)
-DEF_HELPER_FLAGS_2(bfcvt, TCG_CALL_NO_RWG, i32, f32, fpst)
-DEF_HELPER_FLAGS_2(bfcvt_pair, TCG_CALL_NO_RWG, i32, i64, fpst)
-
-DEF_HELPER_2(vfp_uitoh, f16, i32, fpst)
-DEF_HELPER_2(vfp_uitos, f32, i32, fpst)
-DEF_HELPER_2(vfp_uitod, f64, i32, fpst)
-DEF_HELPER_2(vfp_sitoh, f16, i32, fpst)
-DEF_HELPER_2(vfp_sitos, f32, i32, fpst)
-DEF_HELPER_2(vfp_sitod, f64, i32, fpst)
-
-DEF_HELPER_2(vfp_touih, i32, f16, fpst)
-DEF_HELPER_2(vfp_touis, i32, f32, fpst)
-DEF_HELPER_2(vfp_touid, i32, f64, fpst)
-DEF_HELPER_2(vfp_touizh, i32, f16, fpst)
-DEF_HELPER_2(vfp_touizs, i32, f32, fpst)
-DEF_HELPER_2(vfp_touizd, i32, f64, fpst)
-DEF_HELPER_2(vfp_tosih, s32, f16, fpst)
-DEF_HELPER_2(vfp_tosis, s32, f32, fpst)
-DEF_HELPER_2(vfp_tosid, s32, f64, fpst)
-DEF_HELPER_2(vfp_tosizh, s32, f16, fpst)
-DEF_HELPER_2(vfp_tosizs, s32, f32, fpst)
-DEF_HELPER_2(vfp_tosizd, s32, f64, fpst)
-
-DEF_HELPER_3(vfp_toshh_round_to_zero, i32, f16, i32, fpst)
-DEF_HELPER_3(vfp_toslh_round_to_zero, i32, f16, i32, fpst)
-DEF_HELPER_3(vfp_touhh_round_to_zero, i32, f16, i32, fpst)
-DEF_HELPER_3(vfp_toulh_round_to_zero, i32, f16, i32, fpst)
-DEF_HELPER_3(vfp_toshs_round_to_zero, i32, f32, i32, fpst)
-DEF_HELPER_3(vfp_tosls_round_to_zero, i32, f32, i32, fpst)
-DEF_HELPER_3(vfp_touhs_round_to_zero, i32, f32, i32, fpst)
-DEF_HELPER_3(vfp_touls_round_to_zero, i32, f32, i32, fpst)
-DEF_HELPER_3(vfp_toshd_round_to_zero, i64, f64, i32, fpst)
-DEF_HELPER_3(vfp_tosld_round_to_zero, i64, f64, i32, fpst)
-DEF_HELPER_3(vfp_tosqd_round_to_zero, i64, f64, i32, fpst)
-DEF_HELPER_3(vfp_touhd_round_to_zero, i64, f64, i32, fpst)
-DEF_HELPER_3(vfp_tould_round_to_zero, i64, f64, i32, fpst)
-DEF_HELPER_3(vfp_touqd_round_to_zero, i64, f64, i32, fpst)
-DEF_HELPER_3(vfp_touhh, i32, f16, i32, fpst)
-DEF_HELPER_3(vfp_toshh, i32, f16, i32, fpst)
-DEF_HELPER_3(vfp_toulh, i32, f16, i32, fpst)
-DEF_HELPER_3(vfp_toslh, i32, f16, i32, fpst)
-DEF_HELPER_3(vfp_touqh, i64, f16, i32, fpst)
-DEF_HELPER_3(vfp_tosqh, i64, f16, i32, fpst)
-DEF_HELPER_3(vfp_toshs, i32, f32, i32, fpst)
-DEF_HELPER_3(vfp_tosls, i32, f32, i32, fpst)
-DEF_HELPER_3(vfp_tosqs, i64, f32, i32, fpst)
-DEF_HELPER_3(vfp_touhs, i32, f32, i32, fpst)
-DEF_HELPER_3(vfp_touls, i32, f32, i32, fpst)
-DEF_HELPER_3(vfp_touqs, i64, f32, i32, fpst)
-DEF_HELPER_3(vfp_toshd, i64, f64, i32, fpst)
-DEF_HELPER_3(vfp_tosld, i64, f64, i32, fpst)
-DEF_HELPER_3(vfp_tosqd, i64, f64, i32, fpst)
-DEF_HELPER_3(vfp_touhd, i64, f64, i32, fpst)
-DEF_HELPER_3(vfp_tould, i64, f64, i32, fpst)
-DEF_HELPER_3(vfp_touqd, i64, f64, i32, fpst)
-DEF_HELPER_3(vfp_shtos, f32, i32, i32, fpst)
-DEF_HELPER_3(vfp_sltos, f32, i32, i32, fpst)
-DEF_HELPER_3(vfp_sqtos, f32, i64, i32, fpst)
-DEF_HELPER_3(vfp_uhtos, f32, i32, i32, fpst)
-DEF_HELPER_3(vfp_ultos, f32, i32, i32, fpst)
-DEF_HELPER_3(vfp_uqtos, f32, i64, i32, fpst)
-DEF_HELPER_3(vfp_shtod, f64, i64, i32, fpst)
-DEF_HELPER_3(vfp_sltod, f64, i64, i32, fpst)
-DEF_HELPER_3(vfp_sqtod, f64, i64, i32, fpst)
-DEF_HELPER_3(vfp_uhtod, f64, i64, i32, fpst)
-DEF_HELPER_3(vfp_ultod, f64, i64, i32, fpst)
-DEF_HELPER_3(vfp_uqtod, f64, i64, i32, fpst)
-DEF_HELPER_3(vfp_shtoh, f16, i32, i32, fpst)
-DEF_HELPER_3(vfp_uhtoh, f16, i32, i32, fpst)
-DEF_HELPER_3(vfp_sltoh, f16, i32, i32, fpst)
-DEF_HELPER_3(vfp_ultoh, f16, i32, i32, fpst)
-DEF_HELPER_3(vfp_sqtoh, f16, i64, i32, fpst)
-DEF_HELPER_3(vfp_uqtoh, f16, i64, i32, fpst)
-
-DEF_HELPER_3(vfp_shtos_round_to_nearest, f32, i32, i32, fpst)
-DEF_HELPER_3(vfp_sltos_round_to_nearest, f32, i32, i32, fpst)
-DEF_HELPER_3(vfp_uhtos_round_to_nearest, f32, i32, i32, fpst)
-DEF_HELPER_3(vfp_ultos_round_to_nearest, f32, i32, i32, fpst)
-DEF_HELPER_3(vfp_shtod_round_to_nearest, f64, i64, i32, fpst)
-DEF_HELPER_3(vfp_sltod_round_to_nearest, f64, i64, i32, fpst)
-DEF_HELPER_3(vfp_uhtod_round_to_nearest, f64, i64, i32, fpst)
-DEF_HELPER_3(vfp_ultod_round_to_nearest, f64, i64, i32, fpst)
-DEF_HELPER_3(vfp_shtoh_round_to_nearest, f16, i32, i32, fpst)
-DEF_HELPER_3(vfp_uhtoh_round_to_nearest, f16, i32, i32, fpst)
-DEF_HELPER_3(vfp_sltoh_round_to_nearest, f16, i32, i32, fpst)
-DEF_HELPER_3(vfp_ultoh_round_to_nearest, f16, i32, i32, fpst)
-
-DEF_HELPER_FLAGS_2(set_rmode, TCG_CALL_NO_RWG, i32, i32, fpst)
-
-DEF_HELPER_FLAGS_3(vfp_fcvt_f16_to_f32, TCG_CALL_NO_RWG, f32, f16, fpst, i32)
-DEF_HELPER_FLAGS_3(vfp_fcvt_f32_to_f16, TCG_CALL_NO_RWG, f16, f32, fpst, i32)
-DEF_HELPER_FLAGS_3(vfp_fcvt_f16_to_f64, TCG_CALL_NO_RWG, f64, f16, fpst, i32)
-DEF_HELPER_FLAGS_3(vfp_fcvt_f64_to_f16, TCG_CALL_NO_RWG, f16, f64, fpst, i32)
-
-DEF_HELPER_4(vfp_muladdd, f64, f64, f64, f64, fpst)
-DEF_HELPER_4(vfp_muladds, f32, f32, f32, f32, fpst)
-DEF_HELPER_4(vfp_muladdh, f16, f16, f16, f16, fpst)
-
-DEF_HELPER_FLAGS_2(recpe_f16, TCG_CALL_NO_RWG, f16, f16, fpst)
-DEF_HELPER_FLAGS_2(recpe_f32, TCG_CALL_NO_RWG, f32, f32, fpst)
-DEF_HELPER_FLAGS_2(recpe_rpres_f32, TCG_CALL_NO_RWG, f32, f32, fpst)
-DEF_HELPER_FLAGS_2(recpe_f64, TCG_CALL_NO_RWG, f64, f64, fpst)
-DEF_HELPER_FLAGS_2(rsqrte_f16, TCG_CALL_NO_RWG, f16, f16, fpst)
-DEF_HELPER_FLAGS_2(rsqrte_f32, TCG_CALL_NO_RWG, f32, f32, fpst)
-DEF_HELPER_FLAGS_2(rsqrte_rpres_f32, TCG_CALL_NO_RWG, f32, f32, fpst)
-DEF_HELPER_FLAGS_2(rsqrte_f64, TCG_CALL_NO_RWG, f64, f64, fpst)
-DEF_HELPER_FLAGS_1(recpe_u32, TCG_CALL_NO_RWG, i32, i32)
-DEF_HELPER_FLAGS_1(rsqrte_u32, TCG_CALL_NO_RWG, i32, i32)
-DEF_HELPER_FLAGS_4(neon_tbl, TCG_CALL_NO_RWG, i64, env, i32, i64, i64)
-
-DEF_HELPER_3(shl_cc, i32, env, i32, i32)
-DEF_HELPER_3(shr_cc, i32, env, i32, i32)
-DEF_HELPER_3(sar_cc, i32, env, i32, i32)
-DEF_HELPER_3(ror_cc, i32, env, i32, i32)
-
-DEF_HELPER_FLAGS_2(rinth_exact, TCG_CALL_NO_RWG, f16, f16, fpst)
-DEF_HELPER_FLAGS_2(rints_exact, TCG_CALL_NO_RWG, f32, f32, fpst)
-DEF_HELPER_FLAGS_2(rintd_exact, TCG_CALL_NO_RWG, f64, f64, fpst)
-DEF_HELPER_FLAGS_2(rinth, TCG_CALL_NO_RWG, f16, f16, fpst)
-DEF_HELPER_FLAGS_2(rints, TCG_CALL_NO_RWG, f32, f32, fpst)
-DEF_HELPER_FLAGS_2(rintd, TCG_CALL_NO_RWG, f64, f64, fpst)
-
-DEF_HELPER_FLAGS_2(vjcvt, TCG_CALL_NO_RWG, i32, f64, env)
-DEF_HELPER_FLAGS_2(fjcvtzs, TCG_CALL_NO_RWG, i64, f64, fpst)
-
-DEF_HELPER_FLAGS_3(check_hcr_el2_trap, TCG_CALL_NO_WG, void, env, i32, i32)
-
-/* neon_helper.c */
-DEF_HELPER_2(neon_pmin_u8, i32, i32, i32)
-DEF_HELPER_2(neon_pmin_s8, i32, i32, i32)
-DEF_HELPER_2(neon_pmin_u16, i32, i32, i32)
-DEF_HELPER_2(neon_pmin_s16, i32, i32, i32)
-DEF_HELPER_2(neon_pmax_u8, i32, i32, i32)
-DEF_HELPER_2(neon_pmax_s8, i32, i32, i32)
-DEF_HELPER_2(neon_pmax_u16, i32, i32, i32)
-DEF_HELPER_2(neon_pmax_s16, i32, i32, i32)
-
-DEF_HELPER_2(neon_shl_u16, i32, i32, i32)
-DEF_HELPER_2(neon_shl_s16, i32, i32, i32)
-DEF_HELPER_2(neon_rshl_u8, i32, i32, i32)
-DEF_HELPER_2(neon_rshl_s8, i32, i32, i32)
-DEF_HELPER_2(neon_rshl_u16, i32, i32, i32)
-DEF_HELPER_2(neon_rshl_s16, i32, i32, i32)
-DEF_HELPER_2(neon_rshl_u32, i32, i32, i32)
-DEF_HELPER_2(neon_rshl_s32, i32, i32, i32)
-DEF_HELPER_2(neon_rshl_u64, i64, i64, i64)
-DEF_HELPER_2(neon_rshl_s64, i64, i64, i64)
-DEF_HELPER_3(neon_qshl_u8, i32, env, i32, i32)
-DEF_HELPER_3(neon_qshl_s8, i32, env, i32, i32)
-DEF_HELPER_3(neon_qshl_u16, i32, env, i32, i32)
-DEF_HELPER_3(neon_qshl_s16, i32, env, i32, i32)
-DEF_HELPER_3(neon_qshl_u32, i32, env, i32, i32)
-DEF_HELPER_3(neon_qshl_s32, i32, env, i32, i32)
-DEF_HELPER_3(neon_qshl_u64, i64, env, i64, i64)
-DEF_HELPER_3(neon_qshl_s64, i64, env, i64, i64)
-DEF_HELPER_3(neon_qshlu_s8, i32, env, i32, i32)
-DEF_HELPER_3(neon_qshlu_s16, i32, env, i32, i32)
-DEF_HELPER_3(neon_qshlu_s32, i32, env, i32, i32)
-DEF_HELPER_3(neon_qshlu_s64, i64, env, i64, i64)
-DEF_HELPER_3(neon_qrshl_u8, i32, env, i32, i32)
-DEF_HELPER_3(neon_qrshl_s8, i32, env, i32, i32)
-DEF_HELPER_3(neon_qrshl_u16, i32, env, i32, i32)
-DEF_HELPER_3(neon_qrshl_s16, i32, env, i32, i32)
-DEF_HELPER_3(neon_qrshl_u32, i32, env, i32, i32)
-DEF_HELPER_3(neon_qrshl_s32, i32, env, i32, i32)
-DEF_HELPER_3(neon_qrshl_u64, i64, env, i64, i64)
-DEF_HELPER_3(neon_qrshl_s64, i64, env, i64, i64)
-DEF_HELPER_FLAGS_5(neon_sqshl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
-DEF_HELPER_FLAGS_5(neon_sqshl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
-DEF_HELPER_FLAGS_5(neon_sqshl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
-DEF_HELPER_FLAGS_5(neon_sqshl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
-DEF_HELPER_FLAGS_5(neon_uqshl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
-DEF_HELPER_FLAGS_5(neon_uqshl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
-DEF_HELPER_FLAGS_5(neon_uqshl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
-DEF_HELPER_FLAGS_5(neon_uqshl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
-DEF_HELPER_FLAGS_5(neon_sqrshl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
-DEF_HELPER_FLAGS_5(neon_sqrshl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
-DEF_HELPER_FLAGS_5(neon_sqrshl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
-DEF_HELPER_FLAGS_5(neon_sqrshl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
-DEF_HELPER_FLAGS_5(neon_uqrshl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
-DEF_HELPER_FLAGS_5(neon_uqrshl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
-DEF_HELPER_FLAGS_5(neon_uqrshl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
-DEF_HELPER_FLAGS_5(neon_uqrshl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
-DEF_HELPER_FLAGS_4(neon_sqshli_b, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
-DEF_HELPER_FLAGS_4(neon_sqshli_h, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
-DEF_HELPER_FLAGS_4(neon_sqshli_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
-DEF_HELPER_FLAGS_4(neon_sqshli_d, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
-DEF_HELPER_FLAGS_4(neon_uqshli_b, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
-DEF_HELPER_FLAGS_4(neon_uqshli_h, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
-DEF_HELPER_FLAGS_4(neon_uqshli_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
-DEF_HELPER_FLAGS_4(neon_uqshli_d, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
-DEF_HELPER_FLAGS_4(neon_sqshlui_b, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
-DEF_HELPER_FLAGS_4(neon_sqshlui_h, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
-DEF_HELPER_FLAGS_4(neon_sqshlui_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
-DEF_HELPER_FLAGS_4(neon_sqshlui_d, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
-
-DEF_HELPER_FLAGS_4(gvec_srshl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_srshl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_srshl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_srshl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_urshl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_urshl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_urshl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_urshl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_2(neon_add_u8, i32, i32, i32)
-DEF_HELPER_2(neon_add_u16, i32, i32, i32)
-DEF_HELPER_2(neon_sub_u8, i32, i32, i32)
-DEF_HELPER_2(neon_sub_u16, i32, i32, i32)
-DEF_HELPER_2(neon_mul_u8, i32, i32, i32)
-DEF_HELPER_2(neon_mul_u16, i32, i32, i32)
-
-DEF_HELPER_2(neon_tst_u8, i32, i32, i32)
-DEF_HELPER_2(neon_tst_u16, i32, i32, i32)
-DEF_HELPER_2(neon_tst_u32, i32, i32, i32)
-
-DEF_HELPER_1(neon_clz_u8, i32, i32)
-DEF_HELPER_1(neon_clz_u16, i32, i32)
-DEF_HELPER_1(neon_cls_s8, i32, i32)
-DEF_HELPER_1(neon_cls_s16, i32, i32)
-DEF_HELPER_1(neon_cls_s32, i32, i32)
-DEF_HELPER_FLAGS_3(gvec_cnt_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_rbit_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-
-DEF_HELPER_3(neon_qdmulh_s16, i32, env, i32, i32)
-DEF_HELPER_3(neon_qrdmulh_s16, i32, env, i32, i32)
-DEF_HELPER_4(neon_qrdmlah_s16, i32, env, i32, i32, i32)
-DEF_HELPER_4(neon_qrdmlsh_s16, i32, env, i32, i32, i32)
-DEF_HELPER_3(neon_qdmulh_s32, i32, env, i32, i32)
-DEF_HELPER_3(neon_qrdmulh_s32, i32, env, i32, i32)
-DEF_HELPER_4(neon_qrdmlah_s32, i32, env, s32, s32, s32)
-DEF_HELPER_4(neon_qrdmlsh_s32, i32, env, s32, s32, s32)
-
-DEF_HELPER_1(neon_narrow_u8, i64, i64)
-DEF_HELPER_1(neon_narrow_u16, i64, i64)
-DEF_HELPER_2(neon_unarrow_sat8, i64, env, i64)
-DEF_HELPER_2(neon_narrow_sat_u8, i64, env, i64)
-DEF_HELPER_2(neon_narrow_sat_s8, i64, env, i64)
-DEF_HELPER_2(neon_unarrow_sat16, i64, env, i64)
-DEF_HELPER_2(neon_narrow_sat_u16, i64, env, i64)
-DEF_HELPER_2(neon_narrow_sat_s16, i64, env, i64)
-DEF_HELPER_2(neon_unarrow_sat32, i64, env, i64)
-DEF_HELPER_2(neon_narrow_sat_u32, i64, env, i64)
-DEF_HELPER_2(neon_narrow_sat_s32, i64, env, i64)
-DEF_HELPER_1(neon_narrow_high_u8, i32, i64)
-DEF_HELPER_1(neon_narrow_high_u16, i32, i64)
-DEF_HELPER_1(neon_narrow_round_high_u8, i32, i64)
-DEF_HELPER_1(neon_narrow_round_high_u16, i32, i64)
-DEF_HELPER_1(neon_widen_u8, i64, i32)
-DEF_HELPER_1(neon_widen_s8, i64, i32)
-DEF_HELPER_1(neon_widen_u16, i64, i32)
-DEF_HELPER_1(neon_widen_s16, i64, i32)
-
-DEF_HELPER_FLAGS_1(neon_addlp_s8, TCG_CALL_NO_RWG_SE, i64, i64)
-DEF_HELPER_FLAGS_1(neon_addlp_s16, TCG_CALL_NO_RWG_SE, i64, i64)
-DEF_HELPER_3(neon_addl_saturate_s32, i64, env, i64, i64)
-DEF_HELPER_3(neon_addl_saturate_s64, i64, env, i64, i64)
-DEF_HELPER_2(neon_abdl_u16, i64, i32, i32)
-DEF_HELPER_2(neon_abdl_s16, i64, i32, i32)
-DEF_HELPER_2(neon_abdl_u32, i64, i32, i32)
-DEF_HELPER_2(neon_abdl_s32, i64, i32, i32)
-DEF_HELPER_2(neon_abdl_u64, i64, i32, i32)
-DEF_HELPER_2(neon_abdl_s64, i64, i32, i32)
-DEF_HELPER_2(neon_mull_u8, i64, i32, i32)
-DEF_HELPER_2(neon_mull_s8, i64, i32, i32)
-DEF_HELPER_2(neon_mull_u16, i64, i32, i32)
-DEF_HELPER_2(neon_mull_s16, i64, i32, i32)
-
-DEF_HELPER_1(neon_negl_u16, i64, i64)
-DEF_HELPER_1(neon_negl_u32, i64, i64)
-
-DEF_HELPER_FLAGS_2(neon_qabs_s8, TCG_CALL_NO_RWG, i32, env, i32)
-DEF_HELPER_FLAGS_2(neon_qabs_s16, TCG_CALL_NO_RWG, i32, env, i32)
-DEF_HELPER_FLAGS_2(neon_qabs_s32, TCG_CALL_NO_RWG, i32, env, i32)
-DEF_HELPER_FLAGS_2(neon_qabs_s64, TCG_CALL_NO_RWG, i64, env, i64)
-DEF_HELPER_FLAGS_2(neon_qneg_s8, TCG_CALL_NO_RWG, i32, env, i32)
-DEF_HELPER_FLAGS_2(neon_qneg_s16, TCG_CALL_NO_RWG, i32, env, i32)
-DEF_HELPER_FLAGS_2(neon_qneg_s32, TCG_CALL_NO_RWG, i32, env, i32)
-DEF_HELPER_FLAGS_2(neon_qneg_s64, TCG_CALL_NO_RWG, i64, env, i64)
-
-DEF_HELPER_3(neon_ceq_f32, i32, i32, i32, fpst)
-DEF_HELPER_3(neon_cge_f32, i32, i32, i32, fpst)
-DEF_HELPER_3(neon_cgt_f32, i32, i32, i32, fpst)
-DEF_HELPER_3(neon_acge_f32, i32, i32, i32, fpst)
-DEF_HELPER_3(neon_acgt_f32, i32, i32, i32, fpst)
-DEF_HELPER_3(neon_acge_f64, i64, i64, i64, fpst)
-DEF_HELPER_3(neon_acgt_f64, i64, i64, i64, fpst)
-
-/* iwmmxt_helper.c */
-DEF_HELPER_2(iwmmxt_maddsq, i64, i64, i64)
-DEF_HELPER_2(iwmmxt_madduq, i64, i64, i64)
-DEF_HELPER_2(iwmmxt_sadb, i64, i64, i64)
-DEF_HELPER_2(iwmmxt_sadw, i64, i64, i64)
-DEF_HELPER_2(iwmmxt_mulslw, i64, i64, i64)
-DEF_HELPER_2(iwmmxt_mulshw, i64, i64, i64)
-DEF_HELPER_2(iwmmxt_mululw, i64, i64, i64)
-DEF_HELPER_2(iwmmxt_muluhw, i64, i64, i64)
-DEF_HELPER_2(iwmmxt_macsw, i64, i64, i64)
-DEF_HELPER_2(iwmmxt_macuw, i64, i64, i64)
-DEF_HELPER_1(iwmmxt_setpsr_nz, i32, i64)
-
-#define DEF_IWMMXT_HELPER_SIZE_ENV(name) \
-DEF_HELPER_3(iwmmxt_##name##b, i64, env, i64, i64) \
-DEF_HELPER_3(iwmmxt_##name##w, i64, env, i64, i64) \
-DEF_HELPER_3(iwmmxt_##name##l, i64, env, i64, i64) \
-
-DEF_IWMMXT_HELPER_SIZE_ENV(unpackl)
-DEF_IWMMXT_HELPER_SIZE_ENV(unpackh)
-
-DEF_HELPER_2(iwmmxt_unpacklub, i64, env, i64)
-DEF_HELPER_2(iwmmxt_unpackluw, i64, env, i64)
-DEF_HELPER_2(iwmmxt_unpacklul, i64, env, i64)
-DEF_HELPER_2(iwmmxt_unpackhub, i64, env, i64)
-DEF_HELPER_2(iwmmxt_unpackhuw, i64, env, i64)
-DEF_HELPER_2(iwmmxt_unpackhul, i64, env, i64)
-DEF_HELPER_2(iwmmxt_unpacklsb, i64, env, i64)
-DEF_HELPER_2(iwmmxt_unpacklsw, i64, env, i64)
-DEF_HELPER_2(iwmmxt_unpacklsl, i64, env, i64)
-DEF_HELPER_2(iwmmxt_unpackhsb, i64, env, i64)
-DEF_HELPER_2(iwmmxt_unpackhsw, i64, env, i64)
-DEF_HELPER_2(iwmmxt_unpackhsl, i64, env, i64)
-
-DEF_IWMMXT_HELPER_SIZE_ENV(cmpeq)
-DEF_IWMMXT_HELPER_SIZE_ENV(cmpgtu)
-DEF_IWMMXT_HELPER_SIZE_ENV(cmpgts)
-
-DEF_IWMMXT_HELPER_SIZE_ENV(mins)
-DEF_IWMMXT_HELPER_SIZE_ENV(minu)
-DEF_IWMMXT_HELPER_SIZE_ENV(maxs)
-DEF_IWMMXT_HELPER_SIZE_ENV(maxu)
-
-DEF_IWMMXT_HELPER_SIZE_ENV(subn)
-DEF_IWMMXT_HELPER_SIZE_ENV(addn)
-DEF_IWMMXT_HELPER_SIZE_ENV(subu)
-DEF_IWMMXT_HELPER_SIZE_ENV(addu)
-DEF_IWMMXT_HELPER_SIZE_ENV(subs)
-DEF_IWMMXT_HELPER_SIZE_ENV(adds)
-
-DEF_HELPER_3(iwmmxt_avgb0, i64, env, i64, i64)
-DEF_HELPER_3(iwmmxt_avgb1, i64, env, i64, i64)
-DEF_HELPER_3(iwmmxt_avgw0, i64, env, i64, i64)
-DEF_HELPER_3(iwmmxt_avgw1, i64, env, i64, i64)
-
-DEF_HELPER_3(iwmmxt_align, i64, i64, i64, i32)
-DEF_HELPER_4(iwmmxt_insr, i64, i64, i32, i32, i32)
-
-DEF_HELPER_1(iwmmxt_bcstb, i64, i32)
-DEF_HELPER_1(iwmmxt_bcstw, i64, i32)
-DEF_HELPER_1(iwmmxt_bcstl, i64, i32)
-
-DEF_HELPER_1(iwmmxt_addcb, i64, i64)
-DEF_HELPER_1(iwmmxt_addcw, i64, i64)
-DEF_HELPER_1(iwmmxt_addcl, i64, i64)
-
-DEF_HELPER_1(iwmmxt_msbb, i32, i64)
-DEF_HELPER_1(iwmmxt_msbw, i32, i64)
-DEF_HELPER_1(iwmmxt_msbl, i32, i64)
-
-DEF_HELPER_3(iwmmxt_srlw, i64, env, i64, i32)
-DEF_HELPER_3(iwmmxt_srll, i64, env, i64, i32)
-DEF_HELPER_3(iwmmxt_srlq, i64, env, i64, i32)
-DEF_HELPER_3(iwmmxt_sllw, i64, env, i64, i32)
-DEF_HELPER_3(iwmmxt_slll, i64, env, i64, i32)
-DEF_HELPER_3(iwmmxt_sllq, i64, env, i64, i32)
-DEF_HELPER_3(iwmmxt_sraw, i64, env, i64, i32)
-DEF_HELPER_3(iwmmxt_sral, i64, env, i64, i32)
-DEF_HELPER_3(iwmmxt_sraq, i64, env, i64, i32)
-DEF_HELPER_3(iwmmxt_rorw, i64, env, i64, i32)
-DEF_HELPER_3(iwmmxt_rorl, i64, env, i64, i32)
-DEF_HELPER_3(iwmmxt_rorq, i64, env, i64, i32)
-DEF_HELPER_3(iwmmxt_shufh, i64, env, i64, i32)
-
-DEF_HELPER_3(iwmmxt_packuw, i64, env, i64, i64)
-DEF_HELPER_3(iwmmxt_packul, i64, env, i64, i64)
-DEF_HELPER_3(iwmmxt_packuq, i64, env, i64, i64)
-DEF_HELPER_3(iwmmxt_packsw, i64, env, i64, i64)
-DEF_HELPER_3(iwmmxt_packsl, i64, env, i64, i64)
-DEF_HELPER_3(iwmmxt_packsq, i64, env, i64, i64)
-
-DEF_HELPER_3(iwmmxt_muladdsl, i64, i64, i32, i32)
-DEF_HELPER_3(iwmmxt_muladdsw, i64, i64, i32, i32)
-DEF_HELPER_3(iwmmxt_muladdswl, i64, i64, i32, i32)
-
-DEF_HELPER_FLAGS_2(neon_unzip8, TCG_CALL_NO_RWG, void, ptr, ptr)
-DEF_HELPER_FLAGS_2(neon_unzip16, TCG_CALL_NO_RWG, void, ptr, ptr)
-DEF_HELPER_FLAGS_2(neon_qunzip8, TCG_CALL_NO_RWG, void, ptr, ptr)
-DEF_HELPER_FLAGS_2(neon_qunzip16, TCG_CALL_NO_RWG, void, ptr, ptr)
-DEF_HELPER_FLAGS_2(neon_qunzip32, TCG_CALL_NO_RWG, void, ptr, ptr)
-DEF_HELPER_FLAGS_2(neon_zip8, TCG_CALL_NO_RWG, void, ptr, ptr)
-DEF_HELPER_FLAGS_2(neon_zip16, TCG_CALL_NO_RWG, void, ptr, ptr)
-DEF_HELPER_FLAGS_2(neon_qzip8, TCG_CALL_NO_RWG, void, ptr, ptr)
-DEF_HELPER_FLAGS_2(neon_qzip16, TCG_CALL_NO_RWG, void, ptr, ptr)
-DEF_HELPER_FLAGS_2(neon_qzip32, TCG_CALL_NO_RWG, void, ptr, ptr)
-
-DEF_HELPER_FLAGS_4(crypto_aese, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(crypto_aesd, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(crypto_aesmc, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(crypto_aesimc, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(crypto_sha1su0, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(crypto_sha1c, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(crypto_sha1p, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(crypto_sha1m, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(crypto_sha1h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(crypto_sha1su1, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(crypto_sha256h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(crypto_sha256h2, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(crypto_sha256su0, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(crypto_sha256su1, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(crypto_sha512h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(crypto_sha512h2, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(crypto_sha512su0, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(crypto_sha512su1, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(crypto_sm3tt1a, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(crypto_sm3tt1b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(crypto_sm3tt2a, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(crypto_sm3tt2b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(crypto_sm3partw1, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(crypto_sm3partw2, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(crypto_sm4e, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(crypto_sm4ekey, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(crypto_rax1, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_3(crc32, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
-DEF_HELPER_FLAGS_3(crc32c, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
-
-DEF_HELPER_FLAGS_5(gvec_qrdmlah_s16, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_qrdmlsh_s16, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_qrdmlah_s32, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_qrdmlsh_s32, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_5(sve2_sqrdmlah_b, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(sve2_sqrdmlsh_b, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(sve2_sqrdmlah_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(sve2_sqrdmlsh_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(sve2_sqrdmlah_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(sve2_sqrdmlsh_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(sve2_sqrdmlah_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(sve2_sqrdmlsh_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_5(gvec_sdot_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_udot_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_sdot_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_udot_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_usdot_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_5(gvec_sdot_idx_b, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_udot_idx_b, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_sdot_idx_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_udot_idx_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_sudot_idx_b, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_usdot_idx_b, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_5(gvec_fcaddh, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_fcadds, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_fcaddd, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, fpst, i32)
-
-DEF_HELPER_FLAGS_6(gvec_fcmlah, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_6(gvec_fcmlah_idx, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_6(gvec_fcmlas, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_6(gvec_fcmlas_idx, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_6(gvec_fcmlad, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, fpst, i32)
-
-DEF_HELPER_FLAGS_4(gvec_sstoh, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_4(gvec_sitos, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_4(gvec_ustoh, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_4(gvec_uitos, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_4(gvec_tosszh, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_4(gvec_tosizs, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_4(gvec_touszh, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_4(gvec_touizs, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-
-DEF_HELPER_FLAGS_4(gvec_vcvt_sf, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_4(gvec_vcvt_uf, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_4(gvec_vcvt_rz_fs, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_4(gvec_vcvt_rz_fu, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-
-DEF_HELPER_FLAGS_4(gvec_vcvt_sh, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_4(gvec_vcvt_uh, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_4(gvec_vcvt_rz_hs, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_4(gvec_vcvt_rz_hu, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-
-DEF_HELPER_FLAGS_4(gvec_vcvt_sd, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_4(gvec_vcvt_ud, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_4(gvec_vcvt_rz_ds, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_4(gvec_vcvt_rz_du, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-
-DEF_HELPER_FLAGS_4(gvec_vcvt_rm_sd, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_4(gvec_vcvt_rm_ud, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_4(gvec_vcvt_rm_ss, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_4(gvec_vcvt_rm_us, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_4(gvec_vcvt_rm_sh, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_4(gvec_vcvt_rm_uh, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-
-DEF_HELPER_FLAGS_4(gvec_vrint_rm_h, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_4(gvec_vrint_rm_s, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-
-DEF_HELPER_FLAGS_4(gvec_vrintx_h, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_4(gvec_vrintx_s, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-
-DEF_HELPER_FLAGS_4(gvec_frecpe_h, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_4(gvec_frecpe_s, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_4(gvec_frecpe_rpres_s, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_4(gvec_frecpe_d, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-
-DEF_HELPER_FLAGS_4(gvec_frsqrte_h, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_4(gvec_frsqrte_s, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_4(gvec_frsqrte_rpres_s, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_4(gvec_frsqrte_d, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-
-DEF_HELPER_FLAGS_4(gvec_fcgt0_h, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_4(gvec_fcgt0_s, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_4(gvec_fcgt0_d, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-
-DEF_HELPER_FLAGS_4(gvec_fcge0_h, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_4(gvec_fcge0_s, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_4(gvec_fcge0_d, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-
-DEF_HELPER_FLAGS_4(gvec_fceq0_h, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_4(gvec_fceq0_s, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_4(gvec_fceq0_d, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-
-DEF_HELPER_FLAGS_4(gvec_fcle0_h, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_4(gvec_fcle0_s, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_4(gvec_fcle0_d, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-
-DEF_HELPER_FLAGS_4(gvec_fclt0_h, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_4(gvec_fclt0_s, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_4(gvec_fclt0_d, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
-
-DEF_HELPER_FLAGS_5(gvec_fadd_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_fadd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_fadd_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-
-DEF_HELPER_FLAGS_5(gvec_fsub_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_fsub_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_fsub_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-
-DEF_HELPER_FLAGS_5(gvec_fmul_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_fmul_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_fmul_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-
-DEF_HELPER_FLAGS_5(gvec_fabd_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_fabd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_fabd_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-
-DEF_HELPER_FLAGS_5(gvec_ah_fabd_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_ah_fabd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_ah_fabd_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-
-DEF_HELPER_FLAGS_5(gvec_fceq_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_fceq_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_fceq_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-
-DEF_HELPER_FLAGS_5(gvec_fcge_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_fcge_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_fcge_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-
-DEF_HELPER_FLAGS_5(gvec_fcgt_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_fcgt_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_fcgt_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-
-DEF_HELPER_FLAGS_5(gvec_facge_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_facge_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_facge_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-
-DEF_HELPER_FLAGS_5(gvec_facgt_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_facgt_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_facgt_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-
-DEF_HELPER_FLAGS_5(gvec_fmax_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_fmax_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_fmax_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-
-DEF_HELPER_FLAGS_5(gvec_fmin_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_fmin_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_fmin_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-
-DEF_HELPER_FLAGS_5(gvec_fmaxnum_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_fmaxnum_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_fmaxnum_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-
-DEF_HELPER_FLAGS_5(gvec_fminnum_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_fminnum_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_fminnum_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-
-DEF_HELPER_FLAGS_5(gvec_recps_nf_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_recps_nf_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-
-DEF_HELPER_FLAGS_5(gvec_rsqrts_nf_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_rsqrts_nf_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-
-DEF_HELPER_FLAGS_5(gvec_fmla_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_fmla_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-
-DEF_HELPER_FLAGS_5(gvec_fmls_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_fmls_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-
-DEF_HELPER_FLAGS_5(gvec_vfma_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_vfma_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_vfma_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-
-DEF_HELPER_FLAGS_5(gvec_vfms_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_vfms_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_vfms_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-
-DEF_HELPER_FLAGS_5(gvec_ah_vfms_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_ah_vfms_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_ah_vfms_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-
-DEF_HELPER_FLAGS_5(gvec_ftsmul_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_ftsmul_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_ftsmul_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, fpst, i32)
-
-DEF_HELPER_FLAGS_5(gvec_fmul_idx_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_fmul_idx_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_fmul_idx_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, fpst, i32)
-
-DEF_HELPER_FLAGS_5(gvec_fmla_nf_idx_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_fmla_nf_idx_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, fpst, i32)
-
-DEF_HELPER_FLAGS_5(gvec_fmls_nf_idx_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_fmls_nf_idx_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, fpst, i32)
-
-DEF_HELPER_FLAGS_6(gvec_fmla_idx_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_6(gvec_fmla_idx_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_6(gvec_fmla_idx_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, fpst, i32)
-
-DEF_HELPER_FLAGS_6(gvec_fmls_idx_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_6(gvec_fmls_idx_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_6(gvec_fmls_idx_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, fpst, i32)
-
-DEF_HELPER_FLAGS_6(gvec_ah_fmls_idx_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_6(gvec_ah_fmls_idx_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_6(gvec_ah_fmls_idx_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, fpst, i32)
-
-DEF_HELPER_FLAGS_5(gvec_uqadd_b, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_uqadd_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_uqadd_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_uqadd_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_sqadd_b, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_sqadd_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_sqadd_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_sqadd_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_uqsub_b, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_uqsub_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_uqsub_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_uqsub_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_sqsub_b, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_sqsub_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_sqsub_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_sqsub_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_usqadd_b, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_usqadd_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_usqadd_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_usqadd_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_suqadd_b, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_suqadd_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_suqadd_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_suqadd_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_5(gvec_fmlal_a32, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, env, i32)
-DEF_HELPER_FLAGS_5(gvec_fmlal_a64, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, env, i32)
-DEF_HELPER_FLAGS_5(gvec_fmlal_idx_a32, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, env, i32)
-DEF_HELPER_FLAGS_5(gvec_fmlal_idx_a64, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, env, i32)
-
-DEF_HELPER_FLAGS_2(frint32_s, TCG_CALL_NO_RWG, f32, f32, fpst)
-DEF_HELPER_FLAGS_2(frint64_s, TCG_CALL_NO_RWG, f32, f32, fpst)
-DEF_HELPER_FLAGS_2(frint32_d, TCG_CALL_NO_RWG, f64, f64, fpst)
-DEF_HELPER_FLAGS_2(frint64_d, TCG_CALL_NO_RWG, f64, f64, fpst)
-
-DEF_HELPER_FLAGS_3(gvec_ceq0_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_ceq0_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_clt0_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_clt0_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_cle0_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_cle0_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_cgt0_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_cgt0_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_cge0_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_cge0_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_smulh_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_smulh_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_smulh_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_smulh_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_umulh_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_umulh_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_umulh_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_umulh_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_sshl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_sshl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_ushl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_ushl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_pmul_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_pmull_q, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(neon_pmull_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_3(gvec_ssra_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_ssra_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_ssra_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_ssra_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_3(gvec_usra_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_usra_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_usra_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_usra_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_3(gvec_srshr_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_srshr_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_srshr_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_srshr_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_3(gvec_urshr_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_urshr_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_urshr_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_urshr_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_3(gvec_srsra_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_srsra_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_srsra_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_srsra_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_3(gvec_ursra_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_ursra_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_ursra_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_ursra_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_3(gvec_sri_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_sri_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_sri_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_sri_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_3(gvec_sli_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_sli_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_sli_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_sli_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_sabd_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_sabd_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_sabd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_sabd_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_uabd_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_uabd_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_uabd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_uabd_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_saba_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_saba_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_saba_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_saba_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_uaba_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_uaba_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_uaba_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_uaba_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_mul_idx_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_mul_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_mul_idx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_5(gvec_mla_idx_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_mla_idx_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_mla_idx_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_5(gvec_mls_idx_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_mls_idx_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_mls_idx_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_5(neon_sqdmulh_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_sqdmulh_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_5(neon_sqrdmulh_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_sqrdmulh_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_5(neon_sqdmulh_idx_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_sqdmulh_idx_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_5(neon_sqrdmulh_idx_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_sqrdmulh_idx_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_5(neon_sqrdmlah_idx_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_sqrdmlah_idx_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_5(neon_sqrdmlsh_idx_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_sqrdmlsh_idx_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(sve2_sqdmulh_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(sve2_sqdmulh_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(sve2_sqdmulh_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(sve2_sqdmulh_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(sve2_sqrdmulh_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(sve2_sqrdmulh_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(sve2_sqrdmulh_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(sve2_sqrdmulh_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(sve2_sqdmulh_idx_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(sve2_sqdmulh_idx_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(sve2_sqdmulh_idx_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(sve2_sqrdmulh_idx_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(sve2_sqrdmulh_idx_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(sve2_sqrdmulh_idx_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_6(sve2_fmlal_zzzw_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, env, i32)
-DEF_HELPER_FLAGS_6(sve2_fmlal_zzxw_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, env, i32)
-
-DEF_HELPER_FLAGS_4(gvec_xar_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_5(gvec_smmla_b, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_ummla_b, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_usmmla_b, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_6(gvec_bfdot, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, env, i32)
-DEF_HELPER_FLAGS_6(gvec_bfdot_idx, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, env, i32)
-
-DEF_HELPER_FLAGS_6(gvec_bfmmla, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, env, i32)
-
-DEF_HELPER_FLAGS_6(gvec_bfmlal, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_6(gvec_bfmlal_idx, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, fpst, i32)
-
-DEF_HELPER_FLAGS_5(gvec_sclamp_b, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_sclamp_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_sclamp_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_sclamp_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_5(gvec_uclamp_b, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_uclamp_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_uclamp_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_uclamp_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_5(gvec_faddp_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_faddp_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_faddp_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-
-DEF_HELPER_FLAGS_5(gvec_fmaxp_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_fmaxp_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_fmaxp_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-
-DEF_HELPER_FLAGS_5(gvec_fminp_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_fminp_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_fminp_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-
-DEF_HELPER_FLAGS_5(gvec_fmaxnump_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_fmaxnump_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_fmaxnump_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-
-DEF_HELPER_FLAGS_5(gvec_fminnump_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_fminnump_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_fminnump_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-
-DEF_HELPER_FLAGS_4(gvec_addp_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_addp_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_addp_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_addp_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_smaxp_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_smaxp_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_smaxp_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_sminp_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_sminp_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_sminp_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_umaxp_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_umaxp_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_umaxp_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_uminp_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_uminp_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_uminp_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_3(gvec_urecpe_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_ursqrte_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+#include "tcg/helper.h"
 
 #ifdef TARGET_AARCH64
 #include "tcg/helper-a64.h"
diff --git a/target/arm/helper.h b/target/arm/tcg/helper.h
similarity index 99%
copy from target/arm/helper.h
copy to target/arm/tcg/helper.h
index 0a4fc90fa8b..80db7c2c37a 100644
--- a/target/arm/helper.h
+++ b/target/arm/tcg/helper.h
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
 DEF_HELPER_FLAGS_1(sxtb16, TCG_CALL_NO_RWG_SE, i32, i32)
 DEF_HELPER_FLAGS_1(uxtb16, TCG_CALL_NO_RWG_SE, i32, i32)
 
@@ -1149,11 +1151,3 @@ DEF_HELPER_FLAGS_4(gvec_uminp_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_3(gvec_urecpe_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(gvec_ursqrte_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-
-#ifdef TARGET_AARCH64
-#include "tcg/helper-a64.h"
-#include "tcg/helper-sve.h"
-#include "tcg/helper-sme.h"
-#endif
-
-#include "tcg/helper-mve.h"
-- 
2.43.0


