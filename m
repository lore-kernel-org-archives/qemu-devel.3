Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0BADC25B79
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 21:21:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBhkg-0007Fd-NJ; Mon, 27 May 2024 17:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBhke-0007EE-DP
 for qemu-devel@nongnu.org; Mon, 27 May 2024 17:19:28 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBhkc-0003er-Ko
 for qemu-devel@nongnu.org; Mon, 27 May 2024 17:19:28 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6f8e819cf60so115958b3a.0
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 14:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716844765; x=1717449565; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z0L7gyPEJqL35XLMcBWKbKjj2LNhZKoYAZzWq0BXWDI=;
 b=hG2GPSkL7DTXkaJlPOX4lTHVHjXouM91CinwdyEZfLZiHQMBm0zBJeSnX1GVajflA9
 rfj7JQ+OdPE1VVaKUsrDq53aGtAmADMIJDN0/WgRryJldowGlLghog3a/de/CoseqFc6
 dI3qojnTqDK80NozZe0Hz35dFe66ADLTz8yQd3asum1butDUzW6rdvcWLzyZO86Z+RJX
 ZOdm0X8gLQL+DPyif/iyNkxbyBHxqaOHwwwpd2nfuLw6jNvwsYOiMKuomHtcNIKimXnM
 QRJ4V9Z+cyZhofvH2SepHLNO+L6WLdVSuFPnr2QRby257k0mefyC23fDXw1kvx4RKHAn
 p/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716844765; x=1717449565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z0L7gyPEJqL35XLMcBWKbKjj2LNhZKoYAZzWq0BXWDI=;
 b=BD+QdsMOeQsSO7+5S3tfvNhQ6VcmeSd0FXOUpq/R9g8EpbJYipbiX0XJ1q3Jdv2hJz
 6Y/d2ZZRS42J6WNm4DEUUU+EV8MubfuF17JcZ5tSUWrcOmfiDgR0rAxco1jeQZVK5LRi
 1xOMZ1wB0IYyYPaGVgjVKj4cHPvvqC59ymDBD5adq4FDoyYesKKmgWHmUTZhskKjFFhN
 ZobXh3Fu8gC2keGcik9DmSZqmQOk4H1PyUXFZqR+tOw8CguzZYsNWU9NJBtXvewbpl+F
 Cb3fHSr7ok7Bl1Yst+3SJkXqK4x8CPHhDFgLGAucQ/3OijKTegF0ZHgCAC7/F21jbO12
 aCJQ==
X-Gm-Message-State: AOJu0YwGlvYps3QqEhEaZGnC69psBaflAmPdBRqNvcGNTHnRwKosvQgk
 yasZe447tJagIWV/B3XdZXchektmNCKBuxw7Ddl09Ty0hmaFunpoPvLvEhzbiqYriBzgRfa5aP6
 c
X-Google-Smtp-Source: AGHT+IFjDi1z6hoEKS9DBDwA1p95wrPlKnj8wrAzTrRO9aRYWcZFMsmUysWjM3/wk7tbClo4Lk31CA==
X-Received: by 2002:a05:6a21:32a8:b0:1af:fb2c:fac9 with SMTP id
 adf61e73a8af0-1b212d0002emr16687391637.20.1716844765437; 
 Mon, 27 May 2024 14:19:25 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fd1d4d5fsm5265876b3a.165.2024.05.27.14.19.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 14:19:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: git@xen0n.name,
	gaosong@loongson.cn
Subject: [PATCH 13/18] tcg/loongarch64: Split out vdvjvk in tcg_out_vec_op
Date: Mon, 27 May 2024 14:19:07 -0700
Message-Id: <20240527211912.14060-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527211912.14060-1-richard.henderson@linaro.org>
References: <20240527211912.14060-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 tcg/loongarch64/tcg-target.c.inc | 119 ++++++++++++++++---------------
 1 file changed, 63 insertions(+), 56 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 652aa261a3..5f4915c6ac 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1900,49 +1900,55 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         tcg_out_ld(s, type, a0, a1, a2);
         break;
     case INDEX_op_and_vec:
-        tcg_out_opc_vand_v(s, a0, a1, a2);
-        break;
+        insn = OPC_VAND_V;
+        goto vdvjvk;
     case INDEX_op_andc_vec:
         /*
          * vandn vd, vj, vk: vd = vk & ~vj
          * andc_vec vd, vj, vk: vd = vj & ~vk
-         * vk and vk are swapped
+         * vj and vk are swapped
          */
-        tcg_out_opc_vandn_v(s, a0, a2, a1);
-        break;
+        a1 = a2;
+        a2 = args[2];
+        insn = OPC_VANDN_V;
+        goto vdvjvk;
     case INDEX_op_or_vec:
-        tcg_out_opc_vor_v(s, a0, a1, a2);
-        break;
+        insn = OPC_VOR_V;
+        goto vdvjvk;
     case INDEX_op_orc_vec:
-        tcg_out_opc_vorn_v(s, a0, a1, a2);
-        break;
+        insn = OPC_VORN_V;
+        goto vdvjvk;
     case INDEX_op_xor_vec:
-        tcg_out_opc_vxor_v(s, a0, a1, a2);
-        break;
-    case INDEX_op_nor_vec:
-        tcg_out_opc_vnor_v(s, a0, a1, a2);
-        break;
+        insn = OPC_VXOR_V;
+        goto vdvjvk;
     case INDEX_op_not_vec:
-        tcg_out_opc_vnor_v(s, a0, a1, a1);
-        break;
+        a2 = a1;
+        /* fall through */
+    case INDEX_op_nor_vec:
+        insn = OPC_VNOR_V;
+        goto vdvjvk;
     case INDEX_op_cmp_vec:
         {
             TCGCond cond = args[3];
+
             if (const_args[2]) {
                 /*
                  * cmp_vec dest, src, value
                  * Try vseqi/vslei/vslti
                  */
                 int64_t value = sextract64(a2, 0, 8 << vece);
-                if ((cond == TCG_COND_EQ || cond == TCG_COND_LE || \
-                     cond == TCG_COND_LT) && (-0x10 <= value && value <= 0x0f)) {
-                    tcg_out32(s, encode_vdvjsk5_insn(cmp_vec_imm_insn[cond][vece], \
-                                                     a0, a1, value));
+                if ((cond == TCG_COND_EQ ||
+                     cond == TCG_COND_LE ||
+                     cond == TCG_COND_LT) &&
+                    (-0x10 <= value && value <= 0x0f)) {
+                    insn = cmp_vec_imm_insn[cond][vece];
+                    tcg_out32(s, encode_vdvjsk5_insn(insn, a0, a1, value));
                     break;
-                } else if ((cond == TCG_COND_LEU || cond == TCG_COND_LTU) &&
-                    (0x00 <= value && value <= 0x1f)) {
-                    tcg_out32(s, encode_vdvjuk5_insn(cmp_vec_imm_insn[cond][vece], \
-                                                     a0, a1, value));
+                } else if ((cond == TCG_COND_LEU ||
+                            cond == TCG_COND_LTU) &&
+                           (0x00 <= value && value <= 0x1f)) {
+                    insn = cmp_vec_imm_insn[cond][vece];
+                    tcg_out32(s, encode_vdvjuk5_insn(insn, a0, a1, value));
                     break;
                 }
 
@@ -1963,9 +1969,8 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                 insn = cmp_vec_insn[cond][vece];
                 tcg_debug_assert(insn != 0);
             }
-            tcg_out32(s, encode_vdvjvk_insn(insn, a0, a1, a2));
         }
-        break;
+        goto vdvjvk;
     case INDEX_op_add_vec:
         tcg_out_addsub_vec(s, false, vece, a0, a1, a2, const_args[2], true);
         break;
@@ -1976,41 +1981,41 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         tcg_out32(s, encode_vdvj_insn(neg_vec_insn[vece], a0, a1));
         break;
     case INDEX_op_mul_vec:
-        tcg_out32(s, encode_vdvjvk_insn(mul_vec_insn[vece], a0, a1, a2));
-        break;
+        insn = mul_vec_insn[vece];
+        goto vdvjvk;
     case INDEX_op_smin_vec:
-        tcg_out32(s, encode_vdvjvk_insn(smin_vec_insn[vece], a0, a1, a2));
-        break;
+        insn = smin_vec_insn[vece];
+        goto vdvjvk;
     case INDEX_op_smax_vec:
-        tcg_out32(s, encode_vdvjvk_insn(smax_vec_insn[vece], a0, a1, a2));
-        break;
+        insn = smax_vec_insn[vece];
+        goto vdvjvk;
     case INDEX_op_umin_vec:
-        tcg_out32(s, encode_vdvjvk_insn(umin_vec_insn[vece], a0, a1, a2));
-        break;
+        insn = umin_vec_insn[vece];
+        goto vdvjvk;
     case INDEX_op_umax_vec:
-        tcg_out32(s, encode_vdvjvk_insn(umax_vec_insn[vece], a0, a1, a2));
-        break;
+        insn = umax_vec_insn[vece];
+        goto vdvjvk;
     case INDEX_op_ssadd_vec:
-        tcg_out32(s, encode_vdvjvk_insn(ssadd_vec_insn[vece], a0, a1, a2));
-        break;
+        insn = ssadd_vec_insn[vece];
+        goto vdvjvk;
     case INDEX_op_usadd_vec:
-        tcg_out32(s, encode_vdvjvk_insn(usadd_vec_insn[vece], a0, a1, a2));
-        break;
+        insn = usadd_vec_insn[vece];
+        goto vdvjvk;
     case INDEX_op_sssub_vec:
-        tcg_out32(s, encode_vdvjvk_insn(sssub_vec_insn[vece], a0, a1, a2));
-        break;
+        insn = sssub_vec_insn[vece];
+        goto vdvjvk;
     case INDEX_op_ussub_vec:
-        tcg_out32(s, encode_vdvjvk_insn(ussub_vec_insn[vece], a0, a1, a2));
-        break;
+        insn = ussub_vec_insn[vece];
+        goto vdvjvk;
     case INDEX_op_shlv_vec:
-        tcg_out32(s, encode_vdvjvk_insn(shlv_vec_insn[vece], a0, a1, a2));
-        break;
+        insn = shlv_vec_insn[vece];
+        goto vdvjvk;
     case INDEX_op_shrv_vec:
-        tcg_out32(s, encode_vdvjvk_insn(shrv_vec_insn[vece], a0, a1, a2));
-        break;
+        insn = shrv_vec_insn[vece];
+        goto vdvjvk;
     case INDEX_op_sarv_vec:
-        tcg_out32(s, encode_vdvjvk_insn(sarv_vec_insn[vece], a0, a1, a2));
-        break;
+        insn = sarv_vec_insn[vece];
+        goto vdvjvk;
     case INDEX_op_shli_vec:
         tcg_out32(s, encode_vdvjuk3_insn(shli_vec_insn[vece], a0, a1, a2));
         break;
@@ -2020,15 +2025,14 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_sari_vec:
         tcg_out32(s, encode_vdvjuk3_insn(sari_vec_insn[vece], a0, a1, a2));
         break;
-    case INDEX_op_rotrv_vec:
-        tcg_out32(s, encode_vdvjvk_insn(rotrv_vec_insn[vece], a0, a1, a2));
-        break;
     case INDEX_op_rotlv_vec:
         /* rotlv_vec a1, a2 = rotrv_vec a1, -a2 */
         tcg_out32(s, encode_vdvj_insn(neg_vec_insn[vece], temp_vec, a2));
-        tcg_out32(s, encode_vdvjvk_insn(rotrv_vec_insn[vece], a0, a1,
-                                        temp_vec));
-        break;
+        a2 = temp_vec;
+        /* fall through */
+    case INDEX_op_rotrv_vec:
+        insn = rotrv_vec_insn[vece];
+        goto vdvjvk;
     case INDEX_op_rotli_vec:
         /* rotli_vec a1, a2 = rotri_vec a1, -a2 */
         a2 = extract32(-a2, 0, 3 + vece);
@@ -2058,6 +2062,9 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         break;
     default:
         g_assert_not_reached();
+    vdvjvk:
+        tcg_out32(s, encode_vdvjvk_insn(insn, a0, a1, a2));
+        break;
     }
 }
 
-- 
2.34.1


