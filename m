Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CAB1C44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:43:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wggit-0007gN-Ty; Mon, 06 Jul 2026 06:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggim-0007Nb-Nm
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:40 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggij-0003Vy-CB
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:40 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-493b61b52b6so19449985e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 03:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783334316; x=1783939116; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VHdBugLZUkVPDrBYTqD633IxuT9ll0hpLXYvZbK3TXQ=;
 b=XMrH98MG/jAwPF+xB6KTf6Crpn7ddyvgs1tjzK/oJ/XLN8a9qN5Hy8pn4sd3tQYmA8
 SzpHIzcor2lOgQswhyz5tIbxpJ/+xd8N6kFV1MzOpHHA+rJg5e0zulhayojrAyVeCXL6
 2z/emWb3yt5oGKzqvDxr14FCHqYhmKxIP8Q45vpeZ1VZ3KB8FCwRePO7eIyy7MW8VCY3
 wa2qBX41hJNbRnuHzA6LXEBuIzNxqHdq8IKBRZlGep3Uqy8FRWRXPElru/nCyeRAe4Q6
 AeOuRoTQWkbutRHkS7f0WOJ99QzFeR2FA5OU0WdNkO33X3xw/f4gnK4uv3FQtYJUwt4k
 9qxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783334316; x=1783939116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=VHdBugLZUkVPDrBYTqD633IxuT9ll0hpLXYvZbK3TXQ=;
 b=YqpKq8CNtUyPjj4I2v96GsBd4RR39SIMVqYyGXAy8Ymn0syr6HzEJUD17gZy3tAqi0
 Pr17JmCMyfWKwRdHP9U328jdUWGKCx7JFdjZyi0m7AAnda+ESoCUKHLeigsFenqmOP0w
 IKkFeyiTJGdjX3HNJXu6efKpxZ750myVcy/gmVLhogMevmCZ1kObP8MGcDqtbSLqCjIt
 8oo253uNZOGPa0maziT9k3yN/QjQpDZLXr/qT3dEuTHkS6pnximBYmstN67PxeT2xT65
 BxuWG8PMPrmDw2xWicKrnrPe+rhZEQeYjQ1MazaZz2WIOWBKxo5TdPnIuRnuvE4x6p9q
 YC0A==
X-Gm-Message-State: AOJu0YxPIYMKZFS+iEUo6qAb/2DJQ7cPcSjybOuj4bmp7spRdXXcAjNV
 amVvBp7lUsKpieZs3789+ukazGz5cc9VkS+ik2pqQB8ot73LOmrqDujEsRe5IAOD8TGIS2AAuwu
 GTpSitQUjPQ==
X-Gm-Gg: AfdE7cm/SDFJRaVEDVi+eGqa38us1vAUCGiPzl4MiK7oN40sENet2iQCV4DRZTfM8Mh
 rHf+U5gahGurtcw15rRkPyIjExgjvNJ6p76r6JuSQnptAfHLrSXKjkgzi0qp+aVdP0Af16xVQ4z
 d5AiUwXSJmC8iR2AlbIbFDYTJpHEQsrBFFUUnTJKYIdy3SlViEtSewmP7I3GRR48Mib463bBDrM
 V+UxjhwrSz7M6K5z8giNwxDCu8Sc3+++xBzm4Ep85K1a664qs0PDRw/oc1jL0aeEteiE5zf3vXB
 JUMoDR8ivN6FrKMtgPgt7K3PWxQYFcKEDfn8ZOVFCqNXQ2MQ+noIyb76+ap447D4x97+4EGbTCw
 nDzmWkBJ7rEj11dOydW9sI3tmA+6tiRNE/UhWJ6F+l1F85gx6wmlaNw8bg3wBdOR203/bshPvhX
 a82s9MwRGqAXux1t0/IbfCzVHGaw0/cuCNzIkPbktEEWU+Y4nXwQD4HVvPwibABftZGnGgqodY+
 P0Mim3NIA6WIkQ/RRZYNA==
X-Received: by 2002:a05:600c:314f:b0:490:b7e6:bd1d with SMTP id
 5b1f17b1804b1-493d11d8186mr110688915e9.16.1783334315754; 
 Mon, 06 Jul 2026 03:38:35 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f1bsm329501805e9.10.2026.07.06.03.38.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 03:38:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/49] target/arm: Implement SMOP4[AS] (2-way)
Date: Mon,  6 Jul 2026 11:37:42 +0100
Message-ID: <20260706103752.320511-40-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706103752.320511-1-peter.maydell@linaro.org>
References: <20260706103752.320511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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
Message-id: 20260702204314.79224-10-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sme-defs.h |  3 +++
 target/arm/tcg/sme.decode        |  2 ++
 target/arm/tcg/sme_helper.c      | 16 ++++++++++++++++
 target/arm/tcg/translate-sme.c   | 18 ++++++++++++++++++
 4 files changed, 39 insertions(+)

diff --git a/target/arm/tcg/helper-sme-defs.h b/target/arm/tcg/helper-sme-defs.h
index 780b8f162a..ddf771e446 100644
--- a/target/arm/tcg/helper-sme-defs.h
+++ b/target/arm/tcg/helper-sme-defs.h
@@ -379,3 +379,6 @@ DEF_HELPER_FLAGS_5(sme_ah_bfmop4s_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env,
 DEF_HELPER_FLAGS_5(sme_fmop4a_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(sme_fmop4s_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(sme_ah_fmop4s_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_4(sme_smop4a_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme_smop4s_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 4b7a99e203..20a2febd63 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -1116,3 +1116,5 @@ FMOP4_sh        1000 0001 001. ...0 0000 00.. ..0. 00..         @mop4_o2
 
 FMOP4A_sb       1000 0000 001. ...0 0000 00.. ..00 00..         @mop4_o2_s0
 FMOP4A_hb       1000 0000 001. ...0 0000 00.. ..00 100.         @mop4_o1_s0
+
+SMOP4_sh        1000 0000 000. ...0 1000 00.. ..0. 10..         @mop4_o2
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 123f459342..32fe867a3b 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -2938,3 +2938,19 @@ void HELPER(sme_ah_fmop4s_sh)(void *vza, void *vzn, void *vzm,
 {
     sme_mop4(vza, vzn, vzm, env, desc, sizeof(float32), inner_ah_fmop4s_sh);
 }
+
+#define IMOP4_2WAY(NAME, OP, TYPED, TYPEN, TYPEM)                       \
+static void inner_##NAME(void *vd, void *vn, void *vm, void *vinfo)     \
+{                                                                       \
+    TYPEN *n = vn; TYPEM *m = vm; TYPED *d = vd;                        \
+    *d OP##= (TYPED)n[0] * m[0] + (TYPED)n[1] * m[1];                   \
+}                                                                       \
+void HELPER(sme_##NAME)(void *vza, void *vzn, void *vzm, uint32_t desc) \
+{                                                                       \
+    sme_mop4(vza, vzn, vzm, NULL, desc, sizeof(TYPED), inner_##NAME);   \
+}
+
+IMOP4_2WAY(smop4a_sh, +, int32_t, int16_t, int16_t)
+IMOP4_2WAY(smop4s_sh, -, int32_t, int16_t, int16_t)
+
+#undef IMOP4_2WAY
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index b198c7c855..b948591dd3 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -2092,3 +2092,21 @@ TRANS_FEAT(FMOP4A_sb, aa64_sme_mop4_f8f32,
            do_mop4_fp8, a, MO_32, gen_helper_sme_fmop4a_sb)
 TRANS_FEAT(FMOP4A_hb, aa64_sme_mop4_f8f16,
            do_mop4_fp8, a, MO_16, gen_helper_sme_fmop4a_hb)
+
+static bool do_mop4_int(DisasContext *s, arg_mop4 *a, MemOp esz,
+                        gen_helper_gvec_3 *fn)
+{
+    if (sme_smza_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        uint32_t desc = simd_desc(svl, svl, (a->m << 1) | a->n);
+        TCGv_ptr za = get_tile(s, esz, a->zad);
+        TCGv_ptr zn = vec_full_reg_ptr(s, a->zn);
+        TCGv_ptr zm = vec_full_reg_ptr(s, a->zm);
+
+        fn(za, zn, zm, tcg_constant_i32(desc));
+    }
+    return true;
+}
+
+TRANS_FEAT(SMOP4_sh, aa64_sme_mop4, do_mop4_int, a, MO_32,
+           a->s ? gen_helper_sme_smop4s_sh : gen_helper_sme_smop4a_sh)
-- 
2.43.0


