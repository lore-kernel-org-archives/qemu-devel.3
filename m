Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC41AC2BA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 21:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK2PR-0002BI-Fc; Wed, 19 Jun 2024 17:00:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK2PP-0002A0-9P
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 16:59:59 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK2PN-0000J7-Ny
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 16:59:59 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1f9bf484d9fso3690315ad.1
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 13:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718830796; x=1719435596; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dk6gzrY5wVGVjX9UiuPPxDKISH/FVUDrirn7QtI44Ak=;
 b=kBiJpJkMvgOyqXQy3lcVKvmUzOhRrZLjm5hoFPB5BiXpYlqlXoYbXKlvI/t6GIdSyf
 F0W/IdRE7fIKndekisG3S1WxTgyE2dMu6LvgSyMsAIXOXAZjTuTOwU2KDNOpnnZlexHf
 RnwKj8vc8yZWA+n+ieUUwjgAl66QMzSVN21yyzWR2warVTidroTZpD/KbJP57NSTTAT4
 aS4vAKEdZ3KNuFv2pwn9UKZZ/NZrlwRr+ClAJNOnZeozsim1SR+vjTI5cszg7gectwFJ
 l3kc6SM7Q2BjXY6NZOGnl+B8jNn4XgHGUcApZ4Crg49j8NAKlqURJWNGDK4qIMCXwHZi
 S+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718830796; x=1719435596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dk6gzrY5wVGVjX9UiuPPxDKISH/FVUDrirn7QtI44Ak=;
 b=mqcHIrvKUAhPpJe5eAMfoKOZu38nJzDgm+CV9AhcgTMyVToddQhMlWsA5aGlI8tfkz
 LJn6xSCaYRO+8FGhamhmOPNET4wG151v/Dx2c1GAnI4JKIPkVIuIWkXFkBszrThk6MxK
 Gi8jUMXr59vdA+noh1zQuYuSyUezKw/5+L9HZmFpH3+lx16TurEFfwe15wDGvEi07qyz
 5XuY0xHfM3W0OvQXeC2vSpLoXKo9ASuEejqwZFLlwo/wmSf62jeBlwytKpmrfwW84DLf
 8QO4nexfZ6fTzYLOSjwSLWhe91p1o8DEx0hQmuJuqhVvKHn+maBNeXoTwM2W/pQ7xqaX
 1Zhg==
X-Gm-Message-State: AOJu0YymUCzJ+LQa9rCRcifSrj/ksShSNgHRc3KfmaNeCCi/J3Kl1veQ
 fediUwO9/X9sjr1ldKXwD5y1TRDQWGIjjaeTYgbxOqz/JKsPevbZ8v5A88rx0Pa6e50CwsHQnL3
 q
X-Google-Smtp-Source: AGHT+IHrFWNpGSNX2QpBxsrSGVqTdO+SgGsmj/HwQLfxp/23W14ChyWK98SOmihRZdO8XVc7v03I9Q==
X-Received: by 2002:a17:902:f791:b0:1f6:32ef:3e00 with SMTP id
 d9443c01a7336-1f98b12905amr99512905ad.0.1718830795679; 
 Wed, 19 Jun 2024 13:59:55 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f98f8f8c42sm39183765ad.162.2024.06.19.13.59.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 13:59:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>
Subject: [PULL 02/24] tcg/loongarch64: Use fp load/store for I32 and I64 into
 vector regs
Date: Wed, 19 Jun 2024 13:59:30 -0700
Message-Id: <20240619205952.235946-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619205952.235946-1-richard.henderson@linaro.org>
References: <20240619205952.235946-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Reviewed-by: Song Gao <gaosong@loongson.cn>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.c.inc | 36 +++++++++-----------------------
 1 file changed, 10 insertions(+), 26 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 06ca1ab11c..b9078ac793 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -803,6 +803,12 @@ static void tcg_out_ldst(TCGContext *s, LoongArchInsn opc, TCGReg data,
     case OPC_ST_D:
         tcg_out32(s, encode_djsk12_insn(opc, data, addr, imm12));
         break;
+    case OPC_FLD_S:
+    case OPC_FLD_D:
+    case OPC_FST_S:
+    case OPC_FST_D:
+        tcg_out32(s, encode_fdjsk12_insn(opc, data, addr, imm12));
+        break;
     default:
         g_assert_not_reached();
     }
@@ -816,14 +822,14 @@ static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg dest,
         if (dest < TCG_REG_V0) {
             tcg_out_ldst(s, OPC_LD_W, dest, base, offset);
         } else {
-            tcg_out_dupm_vec(s, TCG_TYPE_I128, MO_32, dest, base, offset);
+            tcg_out_ldst(s, OPC_FLD_S, dest, base, offset);
         }
         break;
     case TCG_TYPE_I64:
         if (dest < TCG_REG_V0) {
             tcg_out_ldst(s, OPC_LD_D, dest, base, offset);
         } else {
-            tcg_out_dupm_vec(s, TCG_TYPE_I128, MO_64, dest, base, offset);
+            tcg_out_ldst(s, OPC_FLD_D, dest, base, offset);
         }
         break;
     case TCG_TYPE_V128:
@@ -847,36 +853,14 @@ static void tcg_out_st(TCGContext *s, TCGType type, TCGReg src,
         if (src < TCG_REG_V0) {
             tcg_out_ldst(s, OPC_ST_W, src, base, offset);
         } else {
-            /* TODO: Could use fst_s, fstx_s */
-            if (offset < -0x100 || offset > 0xff || (offset & 3)) {
-                if (-0x800 <= offset && offset <= 0x7ff) {
-                    tcg_out_opc_addi_d(s, TCG_REG_TMP0, base, offset);
-                } else {
-                    tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP0, offset);
-                    tcg_out_opc_add_d(s, TCG_REG_TMP0, TCG_REG_TMP0, base);
-                }
-                base = TCG_REG_TMP0;
-                offset = 0;
-            }
-            tcg_out_opc_vstelm_w(s, src, base, offset, 0);
+            tcg_out_ldst(s, OPC_FST_S, src, base, offset);
         }
         break;
     case TCG_TYPE_I64:
         if (src < TCG_REG_V0) {
             tcg_out_ldst(s, OPC_ST_D, src, base, offset);
         } else {
-            /* TODO: Could use fst_d, fstx_d */
-            if (offset < -0x100 || offset > 0xff || (offset & 7)) {
-                if (-0x800 <= offset && offset <= 0x7ff) {
-                    tcg_out_opc_addi_d(s, TCG_REG_TMP0, base, offset);
-                } else {
-                    tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP0, offset);
-                    tcg_out_opc_add_d(s, TCG_REG_TMP0, TCG_REG_TMP0, base);
-                }
-                base = TCG_REG_TMP0;
-                offset = 0;
-            }
-            tcg_out_opc_vstelm_d(s, src, base, offset, 0);
+            tcg_out_ldst(s, OPC_FST_D, src, base, offset);
         }
         break;
     case TCG_TYPE_V128:
-- 
2.34.1


