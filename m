Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2FFC43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:39:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wggik-0007Ik-08; Mon, 06 Jul 2026 06:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggih-0007Fb-Fz
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:35 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggif-0003V0-Iy
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:35 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-493ba701891so22642885e9.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 03:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783334312; x=1783939112; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=A8R8dZlCN8WO6uXUoBiK2ihGrMytlRB4Ym4GCJaga+8=;
 b=b8jowHQeOxoy/UuKDHA9yNgQlQHphf/+NBJFrjW98cudN1Pgm1sutpMxDRzlaNIQfg
 qRxvSml+yNSxKjdpOi/cjOm/uwLZ3YJEu2AVHJWZXKjgWpPpTVukdzhA83gKKn+V2/y8
 k4I3xKgcRWA8FWsnJdj29xLt8OlyN4ZCwKwAG24ln9AxhbIAJfvtpUJGr1EehpI+Sv+H
 SEgJwhI6WieJ/p5Ynv+s6tv8lCdbZdZvMVqPwYVwzCPQUTO6RCE16IZdFBbGw5+RmB+9
 ouzyc5aE0qIuT/+ZVNOdDcfD7kakSQMZkohEhDaOy6UjzOo5TwFBLRNzLK5yE+QA+nOg
 MxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783334312; x=1783939112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=A8R8dZlCN8WO6uXUoBiK2ihGrMytlRB4Ym4GCJaga+8=;
 b=q0JXjhtWanbJTR9ERavv2HHS0GKygs1vJiLFSBbeVbMufgUVAOknysZeKwu01hwoiF
 t3TONgNCKLYCxBbE5EJplqQr+dF5m2Wly6G5DszZPZREN0zLmXXqqL6ZkFflLODHzSgg
 3E/4fY9kGL9rNAl4pWghMa4dZzYfIe/fQbWWvlMmpQRZc5NMG7vCw9cegUni9Pp8tg7o
 AM+iU/ck5qVcFA85bb//5KAtB7G1VfiyFtnw1fTm8tDRVQmdCARsjsbuFltoA5NlqRD5
 wdK8TXxL7HTpPKx0GaCh4D8ys7W/9cV68OgqKEHtBIkLV3OCj138GRUIXxvug3D+mhyO
 tlsg==
X-Gm-Message-State: AOJu0YzhJL7TmkioBA2xMqraYDGwzE497TS/BqXZqNNaMRhOzSBUnjS0
 4Wj17CNK8eyXgzESnpCS9atKzpEBEMpl8jAriUwlCHeKWnRg2QyQN+nJNz6BB7q//jJcopr5on/
 revG1tMtkPg==
X-Gm-Gg: AfdE7cn8y0qPqKPRdJ0UhMJFKhxMtMkyg4FuySj9ZxFZX5m3UoALYF9Z0KAtueYDYfo
 mLHsjpMBwtfKLvL3Gb9EHtVcFPtAuHrnYTm6ZeEv6e1lxqrnGSWY33SnwXIICtAsj69UnK9w+L5
 xOEsYhgwELOpKt9kYf6On+T2f53IrM9NpwaII9jJLNj6nQQpFd8x+heX13sZpAad224ib8xgcX1
 +GosVVWtDZSOx6WQXtUgc/ZXZJvXZrT+0K1bjp/ujWOFpFZd7rRfwY7NShtoZBM1CFjA7D6z9cP
 i/zynPdRGr1bhTQ/tI+lF7hBSUiPXKbK1QZcHVFgPD3tAvpK6Wu+MhWBzA4JXpQqGZeAr3oPd8k
 I+gJ6uppwCVj9P0VCHhLr+UbqiNsLYgGtpBjIR0mHI8wKlt+stQrhHbUnkX3bnNLWRTc5e1trM2
 +Sa698tywKYssiXH7OgTJh67dEzX8kf35xh5Q8CU0wBpal89kY2Qxc+2fUjD2JaogG6FB97k2mn
 OGbZMsmdklqcAQ7ZM14HvNRgxj7HJP4
X-Received: by 2002:a05:600d:6409:10b0:493:bc4a:c6b5 with SMTP id
 5b1f17b1804b1-493d1644aafmr84702725e9.39.1783334312125; 
 Mon, 06 Jul 2026 03:38:32 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f1bsm329501805e9.10.2026.07.06.03.38.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 03:38:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/49] target/arm: Implement BFMOP4 (widening)
Date: Mon,  6 Jul 2026 11:37:38 +0100
Message-ID: <20260706103752.320511-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706103752.320511-1-peter.maydell@linaro.org>
References: <20260706103752.320511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260702204314.79224-6-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sme-defs.h |  4 ++
 target/arm/tcg/sme.decode        |  2 +
 target/arm/tcg/sme_helper.c      | 84 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c   | 16 ++++--
 4 files changed, 103 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/helper-sme-defs.h b/target/arm/tcg/helper-sme-defs.h
index 05ccb0d1e2..0e4bb12b38 100644
--- a/target/arm/tcg/helper-sme-defs.h
+++ b/target/arm/tcg/helper-sme-defs.h
@@ -371,3 +371,7 @@ DEF_HELPER_FLAGS_5(sme_ah_fmop4s_dd, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst,
 DEF_HELPER_FLAGS_5(sme_bfmop4a_hh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sme_bfmop4s_hh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sme_ah_bfmop4s_hh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_5(sme_bfmop4a_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(sme_bfmop4s_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(sme_ah_bfmop4s_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 6021803ca0..12a3a61432 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -1105,3 +1105,5 @@ BFMOP4_hh       1000 0001 001. ...0 0000 00.. ..0. 100.         @mop4_o1
 FMOP4_hh        1000 0001 000. ...0 0000 00.. ..0. 100.         @mop4_o1
 FMOP4_ss        1000 0000 000. ...0 0000 00.. ..0. 00..         @mop4_o2
 FMOP4_dd        1000 0000 110. ...0 0000 00.. ..0. 1...         @mop4_o3
+
+BFMOP4_sh       1000 0001 000. ...0 0000 00.. ..0. 00..         @mop4_o2
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 0de7dd84e5..5a661ca616 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -2803,3 +2803,87 @@ void HELPER(sme_ah_bfmop4s_hh)(void *vza, void *vzn, void *vzm,
 {
     sme_mop4(vza, vzn, vzm, fpst, desc, sizeof(bfloat16), inner_ah_bfmop4s_hh);
 }
+
+static void inner_bfmop4a_sh(void *vd, void *vn, void *vm, void *vinfo)
+{
+    float32 *d = vd;
+    uint32_t *n = vn, *m = vm;
+    float_status *fpst = vinfo;
+
+    *d = bfdotadd(*d, *n, *m, fpst);
+}
+
+static void inner_ebf_bfmop4a_sh(void *vd, void *vn, void *vm, void *vinfo)
+{
+    float32 *d = vd;
+    uint32_t *n = vn, *m = vm;
+    float_status *fpst = vinfo;
+
+    *d = bfdotadd_ebf(*d, *n, *m, fpst);
+}
+
+void HELPER(sme_bfmop4a_sh)(void *vza, void *vzn, void *vzm,
+                            CPUArchState *env, uint32_t desc)
+{
+    float_status fpst;
+
+    sme_mop4(vza, vzn, vzm, &fpst, desc, sizeof(float32),
+             is_ebf(env, &fpst) ? inner_ebf_bfmop4a_sh
+                                : inner_bfmop4a_sh);
+}
+
+static void inner_bfmop4s_sh(void *vd, void *vn, void *vm, void *vinfo)
+{
+    float32 *d = vd;
+    uint32_t *n = vn, *m = vm;
+    float_status *fpst = vinfo;
+
+    *d = bfdotadd(*d, *n ^ 0x80008000u, *m, fpst);
+}
+
+static void inner_ebf_bfmop4s_sh(void *vd, void *vn, void *vm, void *vinfo)
+{
+    float32 *d = vd;
+    uint32_t *n = vn, *m = vm;
+    float_status *fpst = vinfo;
+
+    *d = bfdotadd_ebf(*d, *n ^ 0x80008000u, *m, fpst);
+}
+
+void HELPER(sme_bfmop4s_sh)(void *vza, void *vzn, void *vzm,
+                            CPUArchState *env, uint32_t desc)
+{
+    float_status fpst;
+
+    sme_mop4(vza, vzn, vzm, &fpst, desc, sizeof(float32),
+             is_ebf(env, &fpst) ? inner_ebf_bfmop4s_sh
+                                : inner_bfmop4s_sh);
+}
+
+static void inner_ah_bfmop4s_sh(void *vd, void *vn, void *vm, void *vinfo)
+{
+    float32 *d = vd;
+    uint32_t *n = vn, *m = vm;
+    float_status *fpst = vinfo;
+
+    *d = bfdotadd(*d, bf16mop_ah_neg_adj_pair(*n, -1), *m, fpst);
+}
+
+static void inner_ebf_ah_bfmop4s_sh(void *vd, void *vn, void *vm, void *vinfo)
+{
+    float32 *d = vd;
+    uint32_t *n = vn, *m = vm;
+    float_status *fpst = vinfo;
+
+    *d = bfdotadd_ebf(*d, bf16mop_ah_neg_adj_pair(*n, -1), *m, fpst);
+}
+
+void HELPER(sme_ah_bfmop4s_sh)(void *vza, void *vzn, void *vzm,
+                               CPUArchState *env, uint32_t desc)
+{
+    float_status fpst;
+
+    sme_mop4(vza, vzn, vzm, &fpst, desc, sizeof(float32),
+             is_ebf(env, &fpst) ? inner_ebf_ah_bfmop4s_sh
+                                : inner_ah_bfmop4s_sh);
+}
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index f833975875..df4a5c2125 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -2004,8 +2004,7 @@ TRANS_FEAT(LUTI4_s_4b, aa64_sme2p1_lutv2, do_lut_s4, a,
            gen_helper_sme2_luti4_4b)
 
 static bool do_mop4_fp(DisasContext *s, arg_mop4 *a, MemOp esz,
-                       ARMFPStatusFlavour e_fpst,
-                       gen_helper_gvec_3_ptr * const fns[3])
+                       int e_fpst, gen_helper_gvec_3_ptr * const fns[3])
 {
     int svl = streaming_vec_reg_size(s);
     uint32_t desc = simd_desc(svl, svl, (a->m << 1) | a->n);
@@ -2019,7 +2018,11 @@ static bool do_mop4_fp(DisasContext *s, arg_mop4 *a, MemOp esz,
     za = get_tile(s, esz, a->zad);
     zn = vec_full_reg_ptr(s, a->zn);
     zm = vec_full_reg_ptr(s, a->zm);
-    fpst = fpstatus_ptr(e_fpst);
+    if (e_fpst >= 0) {
+        fpst = fpstatus_ptr(e_fpst);
+    } else {
+        fpst = tcg_env;
+    }
 
     fns[fns_idx](za, zn, zm, fpst, tcg_constant_i32(desc));
     return true;
@@ -2055,3 +2058,10 @@ static gen_helper_gvec_3_ptr * const fmop4_dd[3] = {
 };
 TRANS_FEAT(FMOP4_dd, aa64_sme_mop4_f64f64,
            do_mop4_fp, a, MO_64, FPST_ZA, fmop4_dd)
+
+static gen_helper_gvec_3_ptr * const bfmop4_sh[3] = {
+    gen_helper_sme_bfmop4a_sh,
+    gen_helper_sme_bfmop4s_sh,
+    gen_helper_sme_ah_bfmop4s_sh
+};
+TRANS_FEAT(BFMOP4_sh, aa64_sme_mop4, do_mop4_fp, a, MO_32, FPST_ENV, bfmop4_sh)
-- 
2.43.0


