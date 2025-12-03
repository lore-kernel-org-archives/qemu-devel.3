Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6BFBD12D7A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 16:16:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQpVV-0004Aw-Nn; Wed, 03 Dec 2025 11:15:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vQpVT-00049N-LM
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 11:15:07 -0500
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vQpVR-0006Xw-2g
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 11:15:07 -0500
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-3f0d1a39cabso3952462fac.3
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 08:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764778504; x=1765383304; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9j2crjoCrA/yBIViXmRa5qDZhpH7ZS6YU+XGm2gA7ZM=;
 b=ASGKaOJv6LK2caauWyvaH7e/PhwEw20Mq7HUUmyXYcZoK9oGdxi9bD+C3ApdGh/sIZ
 n4rfNqew1PJh3SDYuF6oC06o3uVoj1PHHI65hFotm0oY69QFjcLknvRIX35qdbmLTLCl
 NeBHosJyaA3NLUVur2icHuYhy9k0F9rUax6VdxoRaMId/x7TUptMaYQNKBoS+vytgoFI
 Hzo8s/iH47fBf1wCH5nYpQhWUF2chT1xHE2kMTqnBcEfKZ4AMdcVBRakQ/TawuPMuduV
 oz+27izWmTaLTUVs6mgqSmCL/4RDpU4FT8tw+TuU1WMs61+F2VU5Ugvacd4QGgZtih8M
 exRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764778504; x=1765383304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9j2crjoCrA/yBIViXmRa5qDZhpH7ZS6YU+XGm2gA7ZM=;
 b=m9FwcneIG63SUhq5CwBNynkJatrElg8JESW0N3jeT68EHoaWp8C3UZY4C1S3+iZMDp
 89kJTwSpw2I26c/JZUOlKbM4kmYhX0FeXACW6pV1R1QCgRqtlmlLwsO61Im+2tJiXB/b
 6OMaV1DkanaDZCqhCsbXXEQ+eXGgPnC15IW+DK4Lt9d83BILKgeoXRdT7UWRiHx3zaaN
 oxYdjIsy/LVbAa1PmSsA6SZFMDevom50QB4TfzDpcAMhF73cUZbUZj43BNsr7/LbcHO0
 bXL63/g4AKMdU4/CWs0s0Rfq9oZQAs2jj6Qib1JuiivxxmLQEoWKdYvEgx8RhcwZmatw
 l6vA==
X-Gm-Message-State: AOJu0YxM2NrPktVBK71CGghO2sk8xu1sdRuN9xZAZr/KYEwkrZlifU0d
 AC6xRqU/sagdIGbKkNBscrV4MCru33duizW3sGa1dSO1QH4O/AC/MJn/x5SgbTH3fuGX83PUIEt
 hKUXB1ZI=
X-Gm-Gg: ASbGncv87X27xnfPL63em5pi7WtWVJ+lZkAXROI/wuYJ7MCr/fnt/5CvIQ1YH45MrCd
 HnP2d1SWW0W3gCBuU4iPEZxAuXj0OteIn/2y9XKtPMYyQjMXa6ggCfcDkALIO1fTj1UNrZoV1a4
 CkxfgPDqDrbd4Q3SLH4kL61PC10/g8SDDdRcswSeG8y1dSIT5KVpOs+pIw0UBrw5dEMP9aGAAwA
 wXBJmajrFlo/s2Ygo6tL9detteo2JB4UKV/clUUqBF6Jo+sOR1xySD7hRDHpenp2Khq14G+8qUh
 pscSmPuzK48TWuLmITTySMmm13NEbOTj5RPSXKOHftC2W0wArTejcv/OcvFOqWyU8Y1r3SpzKWm
 m0X4Kj62BX7r+hcyzNNau9dIECfZVRIZ/MzRrhkBdiRdEQqMu9Iw4Pf0UPLQ4KPfJdQFYPKhoUk
 lHi8hS2KGT6zt1QnxKsg==
X-Google-Smtp-Source: AGHT+IFGmd1k1BNZTKfVL4qiCp1IrUNDlISdhhU4WvzL6Lw1x2IiUMBGaEYo6zm3rIa7wLsc4nWGhA==
X-Received: by 2002:a05:6870:9f13:b0:3e8:172f:da82 with SMTP id
 586e51a60fabf-3f16922c30dmr1433033fac.19.1764778503753; 
 Wed, 03 Dec 2025 08:15:03 -0800 (PST)
Received: from stoup.. ([187.210.107.189]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f0dca40d4dsm10141625fac.9.2025.12.03.08.15.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Dec 2025 08:15:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 2/6] tcg/tci: Introduce INDEX_op_tci_qemu_{ld,st}_rrr
Date: Wed,  3 Dec 2025 08:14:55 -0800
Message-ID: <20251203161500.501084-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251203161500.501084-1-richard.henderson@linaro.org>
References: <20251203161500.501084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x30.google.com
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

Since d182123974c4, the number of bits in a MemOpIdx tops out at 17.
which won't fit in the TCI rrm format, thus an assertion failure.
Introduce new opcodes that take the MemOpIdx from a register, as
we already do for qemu_ld2 and qemu_st2.

Fixes: d182123974c4 ("include/exec/memopidx: Adjust for 32 mmu indexes")
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tci.c                    | 19 +++++++++++++++++++
 tcg/tci/tcg-target-opc.h.inc |  2 ++
 tcg/tci/tcg-target.c.inc     | 14 ++++++++++++--
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/tcg/tci.c b/tcg/tci.c
index 700e672616..e15d4e8e08 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -794,12 +794,24 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             taddr = regs[r1];
             regs[r0] = tci_qemu_ld(env, taddr, oi, tb_ptr);
             break;
+        case INDEX_op_tci_qemu_ld_rrr:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            taddr = regs[r1];
+            oi = regs[r2];
+            regs[r0] = tci_qemu_ld(env, taddr, oi, tb_ptr);
+            break;
 
         case INDEX_op_qemu_st:
             tci_args_rrm(insn, &r0, &r1, &oi);
             taddr = regs[r1];
             tci_qemu_st(env, taddr, regs[r0], oi, tb_ptr);
             break;
+        case INDEX_op_tci_qemu_st_rrr:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            taddr = regs[r1];
+            oi = regs[r2];
+            tci_qemu_st(env, taddr, regs[r0], oi, tb_ptr);
+            break;
 
         case INDEX_op_qemu_ld2:
             tcg_debug_assert(TCG_TARGET_REG_BITS == 32);
@@ -1050,6 +1062,13 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
                            op_name, str_r(r0), str_r(r1), oi);
         break;
 
+    case INDEX_op_tci_qemu_ld_rrr:
+    case INDEX_op_tci_qemu_st_rrr:
+        tci_args_rrr(insn, &r0, &r1, &r2);
+        info->fprintf_func(info->stream, "%-12s  %s, %s, %s",
+                           op_name, str_r(r0), str_r(r1), str_r(r2));
+        break;
+
     case INDEX_op_qemu_ld2:
     case INDEX_op_qemu_st2:
         tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
diff --git a/tcg/tci/tcg-target-opc.h.inc b/tcg/tci/tcg-target-opc.h.inc
index 4eb32ed736..f8bfffc125 100644
--- a/tcg/tci/tcg-target-opc.h.inc
+++ b/tcg/tci/tcg-target-opc.h.inc
@@ -13,3 +13,5 @@ DEF(tci_rotl32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
 DEF(tci_rotr32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
 DEF(tci_setcond32, 1, 2, 1, TCG_OPF_NOT_PRESENT)
 DEF(tci_movcond32, 1, 2, 1, TCG_OPF_NOT_PRESENT)
+DEF(tci_qemu_ld_rrr, 1, 2, 0, TCG_OPF_NOT_PRESENT)
+DEF(tci_qemu_st_rrr, 0, 3, 0, TCG_OPF_NOT_PRESENT)
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 35c66a4836..532f87262c 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -1188,7 +1188,12 @@ static const TCGOutOpStore outop_st = {
 static void tgen_qemu_ld(TCGContext *s, TCGType type, TCGReg data,
                          TCGReg addr, MemOpIdx oi)
 {
-    tcg_out_op_rrm(s, INDEX_op_qemu_ld, data, addr, oi);
+    if (oi & ~0xffff) {
+        tcg_out_movi(s, TCG_TYPE_I32, TCG_REG_TMP, oi);
+        tcg_out_op_rrr(s, INDEX_op_tci_qemu_ld_rrr, data, addr, TCG_REG_TMP);
+    } else {
+        tcg_out_op_rrm(s, INDEX_op_qemu_ld, data, addr, oi);
+    }
 }
 
 static const TCGOutOpQemuLdSt outop_qemu_ld = {
@@ -1213,7 +1218,12 @@ static const TCGOutOpQemuLdSt2 outop_qemu_ld2 = {
 static void tgen_qemu_st(TCGContext *s, TCGType type, TCGReg data,
                          TCGReg addr, MemOpIdx oi)
 {
-    tcg_out_op_rrm(s, INDEX_op_qemu_st, data, addr, oi);
+    if (oi & ~0xffff) {
+        tcg_out_movi(s, TCG_TYPE_I32, TCG_REG_TMP, oi);
+        tcg_out_op_rrr(s, INDEX_op_tci_qemu_st_rrr, data, addr, TCG_REG_TMP);
+    } else {
+        tcg_out_op_rrm(s, INDEX_op_qemu_st, data, addr, oi);
+    }
 }
 
 static const TCGOutOpQemuLdSt outop_qemu_st = {
-- 
2.43.0


