Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34906E77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:26:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL33d-00059B-En; Tue, 10 Dec 2024 11:25:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL32u-0001CR-Sb
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:25:14 -0500
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL32s-0007gW-KL
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:25:12 -0500
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-53e3a227b82so3266675e87.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733847908; x=1734452708; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tqVb2Q5hg/RzZZ6DxpbE6MUffVDXywo5HLKvgPknPPQ=;
 b=c2MYG0qmuHIKGoJZCFSch8h/aFZ9LkfI1qC9eNwAnDu2TxXcfN3z2T7acljaTfQqPu
 t4gbTid3vKFL0Xg5cGTA9YHmyDnz4P8BsNQ76gFryfUCsrBwk95FC+N6Sa2D1e8swQE0
 pgtcn9CZTJtz8ZUFIPIccFDux1aXe6/m6Q4irK/dmZm2Snec3XiNAMGY6c/mE8UxsE+S
 hMoz/XfLuCGvZGUI5Sdv/WqxG0MQ/3ASdeDagzDHFYVkxiaW8NMj2NrMcl1unjgqurFu
 e+bZumD2GnL3BXW2GJgyNWvSEsQ3XHbmO4R+wZ6LWvOoexUIbY2KVTzG9phF1lEEI36+
 InGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847908; x=1734452708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tqVb2Q5hg/RzZZ6DxpbE6MUffVDXywo5HLKvgPknPPQ=;
 b=M/gviRQJhhCcUNqdILoLXEA8amZPGMER2n5KfICOd0CJQ2EJ2mBAgMWQ1HPfzAbV3g
 ntsaEzj+NxgOfLHu+bStK8p5IskDQcr65ClaJYHjDXXHLnck3NdU03FHOipI2ALKTIaf
 fRkuey8r5BcIiVqPAPodzjS+bjiZ/LEg8Fn3vOh2Ta0SpkvGQJ4P7bxBvbNVwGuVwcRk
 N4vwkVHFebl2ntAhlKk85SuEF5ehljec+1YqDJaVlVTgJzQTBLbZP6amSRKPbVlMJD5K
 AYy+OATxN+hvmp0PLg8xE8sxMpcY997CS028wfSyGl1mAoRbPHtMvOvnqn5Zhy3xAXvC
 agww==
X-Gm-Message-State: AOJu0Yzc3vKOI1Gx1pIwPRaCjGpfYCsTb6rPOWN6X+4wAmkO4pLZ6Gak
 bZ/DcRXjJQOwr1tgA9P2NgyEiN8HQ6wrAr12ti5dTu3Yn5wgKSndvuXy6yNy1D7tTEH01kXtg2c
 CVedxwUGw
X-Gm-Gg: ASbGnct80sHg15clGGUYK+ydBy4e/vyANEgYCz8DKjhvAsY6SSp5W/NiqpZMYocBdCN
 a56nHS9J1eglpUsoTAiNHrJiqTALJ3xajX9TAOb8TF6TCINY1pZNPY+tZwkKOIgvmWEYe9Fumos
 SAonhwyCxYvAiOhhyByQV5FC9ffqoTjc/6croxWccJLHkqVXNJndDhcKPMzMKvrOEatvWv7RlNY
 DfnETquBYZN+UiYqOFB3HvbhxPRlK3Zyee7rSK0UsgxCVbwMj8r9jViXqg=
X-Google-Smtp-Source: AGHT+IHA7UeDROryG0yez/y0gN7xHR6vxSUB6Ovj/ADmmCAgsOy4JjAi2GNnJBnlQGgKNMbI1StGfw==
X-Received: by 2002:a05:6512:3ba3:b0:53e:3a73:6ddc with SMTP id
 2adb3069b0e04-53e3a736e1dmr4858225e87.33.1733847908037; 
 Tue, 10 Dec 2024 08:25:08 -0800 (PST)
Received: from stoup.. ([91.209.212.80]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5402960b0absm26024e87.102.2024.12.10.08.25.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:25:06 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 67/69] target/arm: Introduce gen_gvec_urecpe,
 gen_gvec_ursqrte
Date: Tue, 10 Dec 2024 10:17:31 -0600
Message-ID: <20241210161733.1830573-68-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210161733.1830573-1-richard.henderson@linaro.org>
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h             |  3 +++
 target/arm/tcg/translate.h      |  5 +++++
 target/arm/tcg/gengvec.c        | 16 ++++++++++++++++
 target/arm/tcg/translate-neon.c |  4 ++--
 target/arm/tcg/vec_helper.c     | 22 ++++++++++++++++++++++
 5 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 1132a5cab6..9919b1367b 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -1121,6 +1121,9 @@ DEF_HELPER_FLAGS_4(gvec_uminp_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_uminp_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_uminp_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_3(gvec_urecpe_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_ursqrte_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
 #ifdef TARGET_AARCH64
 #include "tcg/helper-a64.h"
 #include "tcg/helper-sve.h"
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index b996de2c15..9b9abf1992 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -608,6 +608,11 @@ void gen_gvec_fabs(unsigned vece, uint32_t dofs, uint32_t aofs,
 void gen_gvec_fneg(unsigned vece, uint32_t dofs, uint32_t aofs,
                    uint32_t oprsz, uint32_t maxsz);
 
+void gen_gvec_urecpe(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                     uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_ursqrte(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                      uint32_t opr_sz, uint32_t max_sz);
+
 /*
  * Forward to the isar_feature_* tests given a DisasContext pointer.
  */
diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
index 01c9d5436d..01867f8ace 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -2711,3 +2711,19 @@ void gen_gvec_fneg(unsigned vece, uint32_t dofs, uint32_t aofs,
     uint64_t s_bit = 1ull << ((8 << vece) - 1);
     tcg_gen_gvec_xori(vece, dofs, aofs, s_bit, oprsz, maxsz);
 }
+
+void gen_gvec_urecpe(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                     uint32_t opr_sz, uint32_t max_sz)
+{
+    assert(vece == MO_32);
+    tcg_gen_gvec_2_ool(rd_ofs, rn_ofs, opr_sz, max_sz, 0,
+                       gen_helper_gvec_urecpe_s);
+}
+
+void gen_gvec_ursqrte(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                      uint32_t opr_sz, uint32_t max_sz)
+{
+    assert(vece == MO_32);
+    tcg_gen_gvec_2_ool(rd_ofs, rn_ofs, opr_sz, max_sz, 0,
+                       gen_helper_gvec_ursqrte_s);
+}
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index f9ca889bec..c4fecb8fd6 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -3070,7 +3070,7 @@ static bool trans_VRECPE(DisasContext *s, arg_2misc *a)
     if (a->size != 2) {
         return false;
     }
-    return do_2misc(s, a, gen_helper_recpe_u32);
+    return do_2misc_vec(s, a, gen_gvec_urecpe);
 }
 
 static bool trans_VRSQRTE(DisasContext *s, arg_2misc *a)
@@ -3078,7 +3078,7 @@ static bool trans_VRSQRTE(DisasContext *s, arg_2misc *a)
     if (a->size != 2) {
         return false;
     }
-    return do_2misc(s, a, gen_helper_rsqrte_u32);
+    return do_2misc_vec(s, a, gen_gvec_ursqrte);
 }
 
 #define WRAP_1OP_ENV_FN(WRAPNAME, FUNC) \
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 0f4b5670f3..c824e8307b 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -3105,3 +3105,25 @@ void HELPER(gvec_rbit_b)(void *vd, void *vn, uint32_t desc)
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
+
+void HELPER(gvec_urecpe_s)(void *vd, void *vn, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    uint32_t *d = vd, *n = vn;
+
+    for (i = 0; i < opr_sz / 4; ++i) {
+        d[i] = helper_recpe_u32(n[i]);
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_ursqrte_s)(void *vd, void *vn, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    uint32_t *d = vd, *n = vn;
+
+    for (i = 0; i < opr_sz / 4; ++i) {
+        d[i] = helper_rsqrte_u32(n[i]);
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
-- 
2.43.0


