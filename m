Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5028FC5DF66
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 22:38:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuHUm-0007a5-6q; Wed, 12 Aug 2026 18:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUd-0007P1-1Y
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:32:15 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUY-00012s-M9
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:32:14 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-ca80d708489so267513a12.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786573929; x=1787178729; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ggi/wNI46A8QrJvaOskdBGjRytPqZa5Byd+LQudZv10=;
 b=w21B+We/TgzZ44un1rPVxB6B+CS+N67DSOIlG5jy9l7Kz12AwmN2pg6zr501akadwO
 lW+c2xTtjRy8VuKcI39Lfbs2xz7l6JBlGATNQJ0IKBEWas4dON/67CjiTk+HM7vFpODL
 r48HjD4UnA9JjBpRBFwld28Y3teleje8eKDOM4ejJAhFLaV/TD3O6tkaSY4SzW29F1Gs
 aaPq54G1ja1aNRenrSKJTTeDx10JS/to9Q70zoLpqNxVGeXS+4vwbnJwvPwwgxDRzRRC
 R4qQSUQ++Czgqmk8BRvul9kaq3ZLiMlOCgSJm372QffYNHpPg5HdwmfQ8E0TGpKibSxU
 Lfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786573929; x=1787178729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ggi/wNI46A8QrJvaOskdBGjRytPqZa5Byd+LQudZv10=;
 b=L4Vkplr60rcDP88rgO7xEYZDx+4Iufo1kz7WEq33SfIt5KXS8Tzi2ZnrZjRTgcN60H
 1sbZSnxtZvTuMSBSm0AjvkGxK+GWzYKQNZXvOuyaFHKI3sr3H9LUTDmOwcR5dUgd8gqi
 zQtAshlckCtz8FqCsJXgB63afkeIdnpCUURXtwWB3IFFQIoy0YuwrtsfzsnKvOQHYKww
 CSdN8O0G9cZJ5PagjEu6ZZk94OhDPPvcuXFyS9viXAILU6sKeipFeyFQYgWPBpyqwzfT
 VGqhO2l8g6nlM5FcO8aQhiSWGP/tTQsEb1DVF4LHOU3Ir5zKaGvGpZvsfmhAi3etzLA5
 jq6w==
X-Gm-Message-State: AOJu0YzAvhY6EJbK7vo6TcRj/uxk2o+qeQWFROAsqKw6BB54i83WfSrf
 aaN1LIV3mBNFMMiqJJmKjchc0akQy4Sanilb564eK4Q30fh0TOmELmhSs5XRvgZIHVzLNy3cZXs
 H3ofz
X-Gm-Gg: AR+sD125MtFWbOTGMm0MSClxFVDblyD0zCnDkZeFuEUgWxpvVFTOW0+GUZ3QLXM2wi4
 /pPXqOCOoFcBColxEiDxDDJhvybtkplkiNBlOstob5W8SW5T5Rw9BD4m9+kWNwnaYhEUTskSO2E
 4k5O07UF412BjPAFDRnPcrcTB63kFVtBJaRzE480wFlSPsmMCJXqAwEz8NgHUO854H78f0aK5Yj
 kSu/UyiLmDHoWW2Odjdn3+AYmPucjgwA4McaMP2D9A+EaRySjCwL+5zNijKaBHzJh//v5MADf2f
 eBtWjfwT5WFjFC2TDJ5OKmqlu8Qf6Sv71gp7XVHKTuUSOiTyLSDv+Aie1uB3I/P/5KQiBfpg32y
 Jx0BxQJ82SpGZ2lefJC6iP6ha0/4z8nh1p/3NX8T7QuPanMtGoXWVpsCu/uPc5Ld3D/UszYLxit
 6UrtP1h5X2ejHmzGpT3UAtORArgvbrD7MvCzRu7JyH4TzhdcnGa5yYft9t5GQyWgZ3S/9Tcfmbh
 Kjil5MEKiTE0lRmyb9aawufKyb6AuU=
X-Received: by 2002:a05:6a21:4610:b0:39c:4e62:b843 with SMTP id
 adf61e73a8af0-3cc57bdb1ffmr1042807637.10.1786573928693; 
 Wed, 12 Aug 2026 15:32:08 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbef721cb0bsm212031a12.26.2026.08.12.15.32.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 15:32:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair.Francis@wdc.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 24/52] disas/riscv: Handle aliases of csrrwi during decode
Date: Wed, 12 Aug 2026 15:31:14 -0700
Message-ID: <20260812223142.349142-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812223142.349142-1-richard.henderson@linaro.org>
References: <20260812223142.349142-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.h |  2 --
 disas/riscv.c | 28 ++++++++--------------------
 2 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/disas/riscv.h b/disas/riscv.h
index d8c5acd969..3bbcbf10fb 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -84,8 +84,6 @@ typedef enum {
     rvc_imm_eq_zero,
     rvc_imm_eq_n1,
     rvc_imm_eq_p1,
-    rvc_csr_eq_0x001,
-    rvc_csr_eq_0x002,
 } rvc_constraint;
 
 typedef enum {
diff --git a/disas/riscv.c b/disas/riscv.c
index 9ec79baf4d..d3cbfb86ac 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1063,8 +1063,6 @@ static const rvc_constraint rvcc_ret[] = { rvc_rd_eq_x0, rvc_rs1_eq_ra,
                                            rvc_end };
 static const rvc_constraint rvcc_jr[] = { rvc_rd_eq_x0, rvc_imm_eq_zero,
                                           rvc_end };
-static const rvc_constraint rvcc_fsrmi[] = { rvc_csr_eq_0x002, rvc_end };
-static const rvc_constraint rvcc_fsflagsi[] = { rvc_csr_eq_0x001, rvc_end };
 
 /* pseudo-instruction metadata */
 
@@ -1145,12 +1143,6 @@ static const rv_comp_data rvcp_subw[] = {
     { rv_op_illegal, NULL }
 };
 
-static const rv_comp_data rvcp_csrrwi[] = {
-    { rv_op_fsrmi, rvcc_fsrmi },
-    { rv_op_fsflagsi, rvcc_fsflagsi },
-    { rv_op_illegal, NULL }
-};
-
 static const rv_comp_data rvcp_fsgnj_s[] = {
     { rv_op_fmv_s, rvcc_fmv_s },
     { rv_op_illegal, NULL }
@@ -1722,7 +1714,7 @@ static const rv_opcode_data rvi_opcode_data[] = {
     { "csrrw", rv_codec_i_csr, rv_fmt_rd_csr_rs1 },
     { "csrrs", rv_codec_i_csr, rv_fmt_rd_csr_rs1 },
     { "csrrc", rv_codec_i_csr, rv_fmt_rd_csr_rs1 },
-    { "csrrwi", rv_codec_i_csr, rv_fmt_rd_csr_zimm, rvcp_csrrwi },
+    { "csrrwi", rv_codec_i_csr, rv_fmt_rd_csr_zimm },
     { "csrrsi", rv_codec_i_csr, rv_fmt_rd_csr_zimm },
     { "csrrci", rv_codec_i_csr, rv_fmt_rd_csr_zimm },
     { "flw", rv_codec_i, rv_fmt_frd_offset_rs1 },
@@ -4469,7 +4461,13 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                     }
                 }
                 break;
-            case 5: op = rv_op_csrrwi; break;
+            case 5:
+                switch (operand_csr12(inst)) {
+                case 1: op = rv_op_fsflagsi; break;
+                case 2: op = rv_op_fsrmi; break;
+                default: op = rv_op_csrrwi; break;
+                }
+                break;
             case 6: op = rv_op_csrrsi; break;
             case 7: op = rv_op_csrrci; break;
             }
@@ -4991,16 +4989,6 @@ static bool check_constraints(rv_decode *dec, const rvc_constraint *c)
                 return false;
             }
             break;
-        case rvc_csr_eq_0x001:
-            if (!(imm == 0x001)) {
-                return false;
-            }
-            break;
-        case rvc_csr_eq_0x002:
-            if (!(imm == 0x002)) {
-                return false;
-            }
-            break;
         default: break;
         }
         c++;
-- 
2.43.0


