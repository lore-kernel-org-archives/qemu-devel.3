Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB871C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:48:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMa5-0006l7-KG; Fri, 24 Jan 2025 11:30:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYI-0003rU-Fg
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:04 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYE-0005R3-H0
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:01 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4363dc916ceso22307665e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736136; x=1738340936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6JkebY7aHBt5+Ow5GGAKlfmA8fph3Hd4QWwYFSpEozU=;
 b=CFVAX6je7XhjM1owNryTwHLqfHcDeCl01qto9TvhLfavMY0lyOiWrZ6HadogQhf11r
 V+69BMooARVcib4x3+temzoDTuYTkk0EHHeGTrPcu0G+q70zteKrNKsoxPTsHOaCWdjP
 rnffCQZVL1X/Q+kruQMkA46Gsy7y7eewHwijqsN0XgQBueRdN8ta0CCV7O8o4WxlMjg4
 1kOVP+f4WCiwCfl98duN+zHqL5zR48WOk3dV1bdIn6Q4SYs8PefUaC3eYmzwfO9RG8/z
 dQViVV9g7XQhfp0d/F0lfGEgCA5Kb1udFLa1fhoNTV0NP/9xnREQF7d2yaaFbripwcMO
 FBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736136; x=1738340936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6JkebY7aHBt5+Ow5GGAKlfmA8fph3Hd4QWwYFSpEozU=;
 b=FCAp7drasuBjkW49MCPnlvn/m826WIBeYZYcDc5te/VL4WEIFZazY3DTSggCyWBjST
 whlQ9E/rW7X6ReT6goO6oGGtIC2UxRpIy44qKIdtFsoKgqnLQ7v9hYQKGtb/Cf5tmRku
 N1nosMBcqo7i6efFD4ZkWzqEMHQgCPGtJCbBkXAdQ6mHdXrNltoJqUE4ps+/4+0yP2I8
 bzdzWvTyDBbF25u0UHknI1Pb2thRK85F2rgbs7OUmH7olK0JAryckLs2ibjs+aClZj7l
 k8Y4bqTVDLu7INUmEwtX481UD+Dp+oGWV9KptwHZSBztffj+nXvh07afmTWlnUm1AgTY
 eDHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLKNPDyBLlJ01Ps7DoSLABiHF1CPnCiBXDzFTWDDMJPsrMl4l2TOfPwAUhp5X57p91S8JwAHAxcvOX@nongnu.org
X-Gm-Message-State: AOJu0YzBp9aFd8Rj1pr0g+n0SFDWB3EZgttRRuHqMYwiYvpIqO1Z+aAF
 vG/mOyXWTpD8FR9D1LSySJHqxvTCpmeF/JKjd+zNZhfm6zIJp+xGvQk8mnoJnMU=
X-Gm-Gg: ASbGncvqbmGUrVFp8v/g9aITZw/M8/M47ivi3yaNqKHhV7JE3amtr0PeHwgJn97oe7t
 vJ80OK7E+qAjG5mcFlXEMTCKrsZzJgRmXvlVxhYIckycnegESQqfiqUVcQ/5JR4fC/LRFcx7CK1
 n3U+acthCtBPpNxMzV8k91Y7ZMFBrQIY/UG9y0t8weAqekmCRwWOiVKq1ZoDLRx/nRUaG9MAQuJ
 qoYwqmTMTNUYkydNxkBJuKanqgDgVxPB7ANvBdjZt8DInzZ1zcDolkIVw9DKHxoI15fYsCDpa7p
 P+2V5o8CfvE=
X-Google-Smtp-Source: AGHT+IEwOpcqj31q/M8UewMFt0fX0STfL8fd2sFyEktKezSwbKAfDz6dQlDeQ4C2ZijGHnGD8wJDuw==
X-Received: by 2002:a05:600c:3153:b0:436:76bf:51cc with SMTP id
 5b1f17b1804b1-438bd0a875emr36686715e9.12.1737736136189; 
 Fri, 24 Jan 2025 08:28:56 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.28.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:28:55 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 15/76] target/arm: Use fp_status_f16_a64 in AArch64-only
 helpers
Date: Fri, 24 Jan 2025 16:27:35 +0000
Message-Id: <20250124162836.2332150-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

We directly use fp_status_f16 in a handful of helpers that are
AArch64-specific; switch to fp_status_f16_a64 for these.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sme_helper.c | 4 ++--
 target/arm/tcg/vec_helper.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 2aad00d3ad9..727c085f374 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1038,12 +1038,12 @@ void HELPER(sme_fmopa_h)(void *vza, void *vzn, void *vzm, void *vpn,
     float_status fpst_odd, fpst_std, fpst_f16;
 
     /*
-     * Make copies of fp_status and fp_status_f16, because this operation
+     * Make copies of the fp status fields we use, because this operation
      * does not update the cumulative fp exception status.  It also
      * produces default NaNs. We also need a second copy of fp_status with
      * round-to-odd -- see above.
      */
-    fpst_f16 = env->vfp.fp_status_f16;
+    fpst_f16 = env->vfp.fp_status_f16_a64;
     fpst_std = env->vfp.fp_status_a64;
     set_default_nan_mode(true, &fpst_std);
     set_default_nan_mode(true, &fpst_f16);
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index aaad947e506..3fbca8bc8bf 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2067,7 +2067,7 @@ void HELPER(gvec_fmlal_a64)(void *vd, void *vn, void *vm,
                             CPUARMState *env, uint32_t desc)
 {
     do_fmlal(vd, vn, vm, &env->vfp.fp_status_a64, desc,
-             get_flush_inputs_to_zero(&env->vfp.fp_status_f16));
+             get_flush_inputs_to_zero(&env->vfp.fp_status_f16_a64));
 }
 
 void HELPER(sve2_fmlal_zzzw_s)(void *vd, void *vn, void *vm, void *va,
@@ -2077,7 +2077,7 @@ void HELPER(sve2_fmlal_zzzw_s)(void *vd, void *vn, void *vm, void *va,
     uint16_t negn = extract32(desc, SIMD_DATA_SHIFT, 1) << 15;
     intptr_t sel = extract32(desc, SIMD_DATA_SHIFT + 1, 1) * sizeof(float16);
     float_status *status = &env->vfp.fp_status_a64;
-    bool fz16 = get_flush_inputs_to_zero(&env->vfp.fp_status_f16);
+    bool fz16 = get_flush_inputs_to_zero(&env->vfp.fp_status_f16_a64);
 
     for (i = 0; i < oprsz; i += sizeof(float32)) {
         float16 nn_16 = *(float16 *)(vn + H1_2(i + sel)) ^ negn;
@@ -2129,7 +2129,7 @@ void HELPER(gvec_fmlal_idx_a64)(void *vd, void *vn, void *vm,
                                 CPUARMState *env, uint32_t desc)
 {
     do_fmlal_idx(vd, vn, vm, &env->vfp.fp_status_a64, desc,
-                 get_flush_inputs_to_zero(&env->vfp.fp_status_f16));
+                 get_flush_inputs_to_zero(&env->vfp.fp_status_f16_a64));
 }
 
 void HELPER(sve2_fmlal_zzxw_s)(void *vd, void *vn, void *vm, void *va,
@@ -2140,7 +2140,7 @@ void HELPER(sve2_fmlal_zzxw_s)(void *vd, void *vn, void *vm, void *va,
     intptr_t sel = extract32(desc, SIMD_DATA_SHIFT + 1, 1) * sizeof(float16);
     intptr_t idx = extract32(desc, SIMD_DATA_SHIFT + 2, 3) * sizeof(float16);
     float_status *status = &env->vfp.fp_status_a64;
-    bool fz16 = get_flush_inputs_to_zero(&env->vfp.fp_status_f16);
+    bool fz16 = get_flush_inputs_to_zero(&env->vfp.fp_status_f16_a64);
 
     for (i = 0; i < oprsz; i += 16) {
         float16 mm_16 = *(float16 *)(vm + i + idx);
-- 
2.34.1


