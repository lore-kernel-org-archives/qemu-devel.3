Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD20CD37B2
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 20:43:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMAxA-0005E9-FH; Sun, 10 May 2026 16:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAx0-00059C-7y
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:36 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAwy-00046y-Gm
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:34 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-479d4df9035so3127999b6e.0
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778445631; x=1779050431; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=x1n/wa+vo1hnO+AttuyRN+qTfObXqzgkhvrlkD7A7fk=;
 b=WDARVtXndasDiuJccIKPkiBT4nELRSdCxmZwuw6SlERvNhIpZvxE7JwRTML7dfPlki
 ROuCm9ajdlqtWG6jNPdybW0P9zAud3IThcBvXrYpCemxspMZWHUE1pLaPNsCluDOraC2
 QWWtzsrmDhgiwZJKGuLsSo2oQrcHWOAmc+F3k+F82p6QScfyH+NlrQLUoecqkMZq2KjT
 V77lMoMnwoo30u/LHxGySZ/FLltVvTNCm0j8s4qq46swFSW9ZHYGzyzCHjex5pKeDmrf
 H2LdOSfh8xD+xEuq3TxgpxiHhmpIbvz8nTxBwevRdiJ9gGva2CsdgdSgRGEuLl2hBI4r
 FGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778445631; x=1779050431;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=x1n/wa+vo1hnO+AttuyRN+qTfObXqzgkhvrlkD7A7fk=;
 b=Q9dS1XdRPhLnEK0cqZB46f5DoAImX6ab9My+SGTlhg1s19aplhWiw47pe+YA69MTEV
 R2cxC4BWeP5zw/o2VVbA/uqyE8PZTwEXi/GmV6leWBzFYrXCt8/c63e7LmhphrKekoyq
 z7fMiLTqvHMJzOSjK/v/pnUneXcagRrtHZP0DBt++Tdpgr7fY4dISNPHgQGGyaYA9fhj
 RCGnfoyYs2Iu6mJjiekstrv55Kiklm8Fv2f4tltzf2gx4/cL1AoHWNK5cnfJzlpjMu7s
 K4oKO5Cd7jxgK9xQR9reKrYQ3aUTS6qeuKDRhJHhUUaIjI6zhtdWK54QbYDH/q5FU4Ju
 xVYQ==
X-Gm-Message-State: AOJu0YwTTGNEyDu+gmbZq1Vzm4wb9VhU/1D0V0sUOl/4IKPCLMYvVQZi
 yihqAPF0v1pP89kDCFjrUj3LZ0ENeLfK4oYS0A//07JIZdcRVn3hEhhp
X-Gm-Gg: Acq92OGvvolB26l5FpjzNGmTut1EhG8ZJv5ExTagT33ie3y69aF1DVxzzwQYUvRPtK2
 nSXu76bb4NKAgKYcbyoZliJWIlpzBmMNK+XUe1G8WzNnFfwCVoZWmTutlJEfjjv9quDrPw5VdR6
 um7c+rNmERX/MYzSloIXjihLhhdxAbYqTKX5mo768e7jyYa5seGpoEbZQOZRR+qPF2R89kV0uqK
 vHoQZKwxl+Wbc4yIEYWqNO8u9R6dMK52auN9J91NebLIzhFTPr560TLfx2elB62ayrEGNilzFjK
 Z4uqgJ0HurAD3q/IjDPQpzpgvq2tj6ykw93lCsAIU6/QDtoio6m8D4u/+8xev/UHO7R3s7B3Qys
 Jgjti7x/gibdMKiBYnjFWjp+r0Pj4JifJWAAZJjfYnsBPWgem5iqeLubA349oPgPdr3dcvGxC/v
 wIeY21BeGNGAdGquCYkJbxfmfiRjTij99uY1ZoZ1AMflDCx5UmoO6dsjTcNiEtcNlqNOnj6ecoW
 qjNpLdO+wPoJDtD+aQBaMCq2rQWcEZNFr2rDPguPr8=
X-Received: by 2002:a05:6808:5087:b0:453:58dc:c006 with SMTP id
 5614622812f47-48061aa68afmr7778751b6e.3.1778445631093; 
 Sun, 10 May 2026 13:40:31 -0700 (PDT)
Received: from MacBook-Pro.local ([209.245.15.183])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c76935637sm18908207b6e.12.2026.05.10.13.40.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2026 13:40:30 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 10 May 2026 14:39:55 -0600
Subject: [PATCH v5 25/32] target/mips: add Octeon LA* atomic instructions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-mips-octeon-missing-insns-v2-v5-25-d5d2668d15ab@gmail.com>
References: <20260510-mips-octeon-missing-insns-v2-v5-0-d5d2668d15ab@gmail.com>
In-Reply-To: <20260510-mips-octeon-missing-insns-v2-v5-0-d5d2668d15ab@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x233.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Implement the Octeon LA* read-modify-write atomic instruction family:
LAI/LAID, LAD/LADD, LAA/LAAD, LAS/LASD, LAC/LACD, and LAW/LAWD.

These operations are architecturally distinct from SAA/SAAD and are used
by existing Octeon user-mode code for atomic counters, bit operations,
and exchange-style updates.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - Keep LA* atomics naturally aligned per Octeon L2 transaction
    semantics.
  - Use explicit i64 TCG ops in the LA* translator paths.  (suggested by
    Philippe Mathieu-Daudé)

Changes v2 -> v3:
  - Drop redundant TARGET_LONG_BITS guards from doubleword atomic paths.
    (suggested by Richard Henderson)
  - Group LA* translator wrappers by argument shape instead of adding one
    wrapper per instruction.  (suggested by Richard Henderson)

Changes v3 -> v4:
  - Use i64 atomic helpers for both word and doubleword paths and select
    word sign-extension through MO_SL.  (suggested by Richard Henderson)
---
 target/mips/tcg/octeon.decode      | 17 +++++++++
 target/mips/tcg/octeon_translate.c | 74 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 9c1fe8f4f1..69c592fc23 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -59,6 +59,23 @@ V3MULU       011100 ..... ..... ..... 00000 010001 @r3
 SAA          011100 ..... ..... 00000 00000 011000 @saa
 SAAD         011100 ..... ..... 00000 00000 011001 @saa
 
+&la          base rd
+&laa         base add rd
+@la          ...... base:5 ..... rd:5 ........... &la
+@laa         ...... base:5 add:5 rd:5 ........... &laa
+LAI          011100 ..... 00000 ..... 00010 011111 @la
+LAID         011100 ..... 00000 ..... 00011 011111 @la
+LAD          011100 ..... 00000 ..... 00110 011111 @la
+LADD         011100 ..... 00000 ..... 00111 011111 @la
+LAA          011100 ..... ..... ..... 10010 011111 @laa
+LAAD         011100 ..... ..... ..... 10011 011111 @laa
+LAS          011100 ..... 00000 ..... 01010 011111 @la
+LASD         011100 ..... 00000 ..... 01011 011111 @la
+LAC          011100 ..... 00000 ..... 01110 011111 @la
+LACD         011100 ..... 00000 ..... 01111 011111 @la
+LAW          011100 ..... ..... ..... 10110 011111 @laa
+LAWD         011100 ..... ..... ..... 10111 011111 @laa
+
 &zcb         base
 ZCB          011100 base:5 00000 00000 11100 011111 &zcb
 ZCB          011100 base:5 00000 00000 11101 011111 &zcb  # ZCBT
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 11a15a3cff..7bbc20d82b 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -176,6 +176,68 @@ static bool trans_saa(DisasContext *ctx, arg_saa *a, MemOp mop)
     return true;
 }
 
+static bool trans_la_common(DisasContext *ctx, int base, int add_reg,
+                            int rd, int64_t imm, MemOp mop)
+{
+    TCGv_i64 addr = tcg_temp_new_i64();
+    TCGv_i64 value = tcg_temp_new_i64();
+    TCGv_i64 old = tcg_temp_new_i64();
+    MemOp amo = mo_endian(ctx) | mop | MO_ALIGN;
+
+    gen_base_offset_addr(ctx, addr, base, 0);
+
+    if (add_reg >= 0) {
+        gen_load_gpr(value, add_reg);
+    } else {
+        tcg_gen_movi_i64(value, imm);
+    }
+
+    tcg_gen_atomic_fetch_add_i64(old, addr, value, ctx->mem_idx, amo);
+    gen_store_gpr(old, rd);
+    return true;
+}
+
+static bool trans_law_common(DisasContext *ctx, int base, int add_reg, int rd,
+                             int64_t imm, MemOp mop)
+{
+    TCGv_i64 addr = tcg_temp_new_i64();
+    TCGv_i64 value = tcg_temp_new_i64();
+    TCGv_i64 old = tcg_temp_new_i64();
+    MemOp amo = mo_endian(ctx) | mop | MO_ALIGN;
+
+    gen_base_offset_addr(ctx, addr, base, 0);
+
+    if (add_reg >= 0) {
+        gen_load_gpr(value, add_reg);
+    } else {
+        tcg_gen_movi_i64(value, imm);
+    }
+
+    tcg_gen_atomic_xchg_i64(old, addr, value, ctx->mem_idx, amo);
+    gen_store_gpr(old, rd);
+    return true;
+}
+
+static bool do_lai(DisasContext *ctx, arg_la *a, int64_t imm, MemOp mop)
+{
+    return trans_la_common(ctx, a->base, -1, a->rd, imm, mop);
+}
+
+static bool do_laa(DisasContext *ctx, arg_laa *a, MemOp mop)
+{
+    return trans_la_common(ctx, a->base, a->add, a->rd, 0, mop);
+}
+
+static bool do_las(DisasContext *ctx, arg_la *a, int64_t imm, MemOp mop)
+{
+    return trans_law_common(ctx, a->base, -1, a->rd, imm, mop);
+}
+
+static bool do_law(DisasContext *ctx, arg_laa *a, MemOp mop)
+{
+    return trans_law_common(ctx, a->base, a->add, a->rd, 0, mop);
+}
+
 static bool trans_ZCB(DisasContext *ctx, arg_zcb *a)
 {
     TCGv_i64 addr = tcg_temp_new_i64();
@@ -283,6 +345,18 @@ static bool trans_vmul(DisasContext *ctx, arg_decode_ext_octeon1 *a,
 
 TRANS(SAA,  trans_saa, MO_UL);
 TRANS(SAAD, trans_saa, MO_UQ);
+TRANS(LAI,  do_lai, 1, MO_SL);
+TRANS(LAID, do_lai, 1, MO_UQ);
+TRANS(LAD,  do_lai, -1, MO_SL);
+TRANS(LADD, do_lai, -1, MO_UQ);
+TRANS(LAA,  do_laa, MO_SL);
+TRANS(LAAD, do_laa, MO_UQ);
+TRANS(LAS,  do_las, -1, MO_SL);
+TRANS(LASD, do_las, -1, MO_UQ);
+TRANS(LAC,  do_las, 0, MO_SL);
+TRANS(LACD, do_las, 0, MO_UQ);
+TRANS(LAW,  do_law, MO_SL);
+TRANS(LAWD, do_law, MO_UQ);
 TRANS(LBX,  trans_lx, MO_SB);
 TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);

-- 
2.54.0


