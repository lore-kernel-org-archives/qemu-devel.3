Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB5DE77182
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:49:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPcW-00047U-Qy; Wed, 11 Dec 2024 11:31:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPcM-0003sw-Hf
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:31:19 -0500
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPcI-0001Bh-5c
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:31:17 -0500
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7b6e5ee6ac7so118895585a.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934672; x=1734539472; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sjwu/WCIKU5sioc59WkYMjpiHpm5dBrQM69XD4ADE/A=;
 b=aIAFxWkEMO0t10BMyUtZ0d90Iv48my2jcrNimt1r7965dmKoBBHlc2RFN+1XI09k5L
 rXlWEUSKnhPCsXTjt6AaF7BqzEjCNEzvRScPynU+LtfzKda3g/LM2+7rlB7poQSAnf84
 L37G5CxC6rE73FjVPjZLIiXSUYv6vH9mcf2Pg3FbFbx3Mhj686v2l5I2IEcHMk8VFL0o
 fxqCEV5xVUgKcRPqxkzgPY8gBjRjNwlNtNnoqm55mTBK4wOMnqSWIGo45gziZu+9ITX1
 YVmZNHBbwgcgFppKNjixSPWIqLsY8i1pS6veTSy67SVzFO4FGbRfCRK7aL5kO9OW2COA
 H3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934672; x=1734539472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sjwu/WCIKU5sioc59WkYMjpiHpm5dBrQM69XD4ADE/A=;
 b=OM/m3WppOLbKaZH/vdFPajhQ6cQKSgELuZQoASdVsKBicEBTzHvcQoUe6nV2NXB9YJ
 Lwzn5vKZUPsQbPLCO107CAq0vtD7rYY2xHhkfCdwVlsrvW14WCNizGrdsWs7JwcGmSKC
 bAwRlOf2Galipfhwa8jXFJ4GBuOKtbypiFVAYcztIka5tlHN798ooOfUvIAKJfqiyGTN
 UUzA6eoRTge0+QMjmm7wuMKFjW2LO39YSehw0eKyhiE3/Pc8dJ+Jt0EyuwESNIoOHyWb
 yEGKUOSLXIeGUWXvVILysI6VyqMpwyetGKfB7uPk8F7zpXiI6OH3ZTPgGU2TH326dGS4
 106A==
X-Gm-Message-State: AOJu0YzG17pcglrAF6IPoeKsmmlEPTjeQ0GaqOGUkym7qgjuIrDc2hcy
 sMkRqVILA98My7qpEbN59/gkGYCUlgxED8Bm1MYLGBiUHqDwaTSS5OsHJkODgtC7ENVcq+gfucc
 bly2FVH/H
X-Gm-Gg: ASbGncsYUhfMBDQj5H/9aYBne3fB1DOfysc3EmUO41glCWBsZi4R9wiM+icJbYcrLPD
 xXmUE4WnURRvGCquFN62UNq2WIN0hvR3K87H7o6JURUxtl/p3Nsy+xa/ejSlmT6Pku2RZqECR8E
 QYuhgpHUvhg97PSGzsBwBokRHNA1u8OxfOEXuJvdtq3YmDMoq1P6IUjvnke/KM4mB3Dds2hXVi6
 y4fwfdmy6lMrv1w1RTJ8bf0GFCCnGX8Ai+Uqe5X34dyRanEKwrKU373dLvJYQ==
X-Google-Smtp-Source: AGHT+IFKzPp76/oNFVm3lxjUVUimGsMa4QqP0nFc+b6VmdCPVSaEBD1A6TcWCdW090JHo520ljT41A==
X-Received: by 2002:a05:620a:1926:b0:7b6:c92e:2e6f with SMTP id
 af79cd13be357-7b6eb459f29mr594302585a.22.1733934672557; 
 Wed, 11 Dec 2024 08:31:12 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46755db613csm43849381cf.70.2024.12.11.08.31.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:31:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 07/69] target/arm: Convert RBIT, REV16, REV32,
 REV64 to decodetree
Date: Wed, 11 Dec 2024 10:29:34 -0600
Message-ID: <20241211163036.2297116-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211163036.2297116-1-richard.henderson@linaro.org>
References: <20241211163036.2297116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::729;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x729.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 137 +++++++++++++++------------------
 target/arm/tcg/a64.decode      |  11 +++
 2 files changed, 72 insertions(+), 76 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index ca8b644dc7..1805d77f43 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7684,6 +7684,60 @@ static bool trans_PACGA(DisasContext *s, arg_rrr *a)
     return false;
 }
 
+typedef void ArithOneOp(TCGv_i64, TCGv_i64);
+
+static bool gen_rr(DisasContext *s, int rd, int rn, ArithOneOp fn)
+{
+    fn(cpu_reg(s, rd), cpu_reg(s, rn));
+    return true;
+}
+
+static void gen_rbit32(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn)
+{
+    TCGv_i32 t32 = tcg_temp_new_i32();
+
+    tcg_gen_extrl_i64_i32(t32, tcg_rn);
+    gen_helper_rbit(t32, t32);
+    tcg_gen_extu_i32_i64(tcg_rd, t32);
+}
+
+static void gen_rev16_xx(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn, TCGv_i64 mask)
+{
+    TCGv_i64 tcg_tmp = tcg_temp_new_i64();
+
+    tcg_gen_shri_i64(tcg_tmp, tcg_rn, 8);
+    tcg_gen_and_i64(tcg_rd, tcg_rn, mask);
+    tcg_gen_and_i64(tcg_tmp, tcg_tmp, mask);
+    tcg_gen_shli_i64(tcg_rd, tcg_rd, 8);
+    tcg_gen_or_i64(tcg_rd, tcg_rd, tcg_tmp);
+}
+
+static void gen_rev16_32(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn)
+{
+    gen_rev16_xx(tcg_rd, tcg_rn, tcg_constant_i64(0x00ff00ff));
+}
+
+static void gen_rev16_64(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn)
+{
+    gen_rev16_xx(tcg_rd, tcg_rn, tcg_constant_i64(0x00ff00ff00ff00ffull));
+}
+
+static void gen_rev_32(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn)
+{
+    tcg_gen_bswap32_i64(tcg_rd, tcg_rn, TCG_BSWAP_OZ);
+}
+
+static void gen_rev32(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn)
+{
+    tcg_gen_bswap64_i64(tcg_rd, tcg_rn);
+    tcg_gen_rotri_i64(tcg_rd, tcg_rd, 32);
+}
+
+TRANS(RBIT, gen_rr, a->rd, a->rn, a->sf ? gen_helper_rbit64 : gen_rbit32)
+TRANS(REV16, gen_rr, a->rd, a->rn, a->sf ? gen_rev16_64 : gen_rev16_32)
+TRANS(REV32, gen_rr, a->rd, a->rn, a->sf ? gen_rev32 : gen_rev_32)
+TRANS(REV64, gen_rr, a->rd, a->rn, tcg_gen_bswap64_i64)
+
 /* Logical (shifted register)
  *   31  30 29 28       24 23   22 21  20  16 15    10 9    5 4    0
  * +----+-----+-----------+-------+---+------+--------+------+------+
@@ -8302,67 +8356,6 @@ static void handle_cls(DisasContext *s, unsigned int sf,
     }
 }
 
-static void handle_rbit(DisasContext *s, unsigned int sf,
-                        unsigned int rn, unsigned int rd)
-{
-    TCGv_i64 tcg_rd, tcg_rn;
-    tcg_rd = cpu_reg(s, rd);
-    tcg_rn = cpu_reg(s, rn);
-
-    if (sf) {
-        gen_helper_rbit64(tcg_rd, tcg_rn);
-    } else {
-        TCGv_i32 tcg_tmp32 = tcg_temp_new_i32();
-        tcg_gen_extrl_i64_i32(tcg_tmp32, tcg_rn);
-        gen_helper_rbit(tcg_tmp32, tcg_tmp32);
-        tcg_gen_extu_i32_i64(tcg_rd, tcg_tmp32);
-    }
-}
-
-/* REV with sf==1, opcode==3 ("REV64") */
-static void handle_rev64(DisasContext *s, unsigned int sf,
-                         unsigned int rn, unsigned int rd)
-{
-    if (!sf) {
-        unallocated_encoding(s);
-        return;
-    }
-    tcg_gen_bswap64_i64(cpu_reg(s, rd), cpu_reg(s, rn));
-}
-
-/* REV with sf==0, opcode==2
- * REV32 (sf==1, opcode==2)
- */
-static void handle_rev32(DisasContext *s, unsigned int sf,
-                         unsigned int rn, unsigned int rd)
-{
-    TCGv_i64 tcg_rd = cpu_reg(s, rd);
-    TCGv_i64 tcg_rn = cpu_reg(s, rn);
-
-    if (sf) {
-        tcg_gen_bswap64_i64(tcg_rd, tcg_rn);
-        tcg_gen_rotri_i64(tcg_rd, tcg_rd, 32);
-    } else {
-        tcg_gen_bswap32_i64(tcg_rd, tcg_rn, TCG_BSWAP_OZ);
-    }
-}
-
-/* REV16 (opcode==1) */
-static void handle_rev16(DisasContext *s, unsigned int sf,
-                         unsigned int rn, unsigned int rd)
-{
-    TCGv_i64 tcg_rd = cpu_reg(s, rd);
-    TCGv_i64 tcg_tmp = tcg_temp_new_i64();
-    TCGv_i64 tcg_rn = read_cpu_reg(s, rn, sf);
-    TCGv_i64 mask = tcg_constant_i64(sf ? 0x00ff00ff00ff00ffull : 0x00ff00ff);
-
-    tcg_gen_shri_i64(tcg_tmp, tcg_rn, 8);
-    tcg_gen_and_i64(tcg_rd, tcg_rn, mask);
-    tcg_gen_and_i64(tcg_tmp, tcg_tmp, mask);
-    tcg_gen_shli_i64(tcg_rd, tcg_rd, 8);
-    tcg_gen_or_i64(tcg_rd, tcg_rd, tcg_tmp);
-}
-
 /* Data-processing (1 source)
  *   31  30  29  28             21 20     16 15    10 9    5 4    0
  * +----+---+---+-----------------+---------+--------+------+------+
@@ -8388,21 +8381,6 @@ static void disas_data_proc_1src(DisasContext *s, uint32_t insn)
 #define MAP(SF, O2, O1) ((SF) | (O1 << 1) | (O2 << 7))
 
     switch (MAP(sf, opcode2, opcode)) {
-    case MAP(0, 0x00, 0x00): /* RBIT */
-    case MAP(1, 0x00, 0x00):
-        handle_rbit(s, sf, rn, rd);
-        break;
-    case MAP(0, 0x00, 0x01): /* REV16 */
-    case MAP(1, 0x00, 0x01):
-        handle_rev16(s, sf, rn, rd);
-        break;
-    case MAP(0, 0x00, 0x02): /* REV/REV32 */
-    case MAP(1, 0x00, 0x02):
-        handle_rev32(s, sf, rn, rd);
-        break;
-    case MAP(1, 0x00, 0x03): /* REV64 */
-        handle_rev64(s, sf, rn, rd);
-        break;
     case MAP(0, 0x00, 0x04): /* CLZ */
     case MAP(1, 0x00, 0x04):
         handle_clz(s, sf, rn, rd);
@@ -8557,6 +8535,13 @@ static void disas_data_proc_1src(DisasContext *s, uint32_t insn)
         break;
     default:
     do_unallocated:
+    case MAP(0, 0x00, 0x00): /* RBIT */
+    case MAP(1, 0x00, 0x00):
+    case MAP(0, 0x00, 0x01): /* REV16 */
+    case MAP(1, 0x00, 0x01):
+    case MAP(0, 0x00, 0x02): /* REV/REV32 */
+    case MAP(1, 0x00, 0x02):
+    case MAP(1, 0x00, 0x03): /* REV64 */
         unallocated_encoding(s);
         break;
     }
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index a23d6a6645..dd44651f34 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -28,6 +28,8 @@
 &r              rn
 &rrr            rd rn rm
 &ri             rd imm
+&rr             rd rn
+&rr_sf          rd rn sf
 &rri_sf         rd rn imm sf
 &rrr_sf         rd rn rm sf
 &i              imm
@@ -685,6 +687,15 @@ GMI             1 00 11010110 ..... 000101 ..... .....  @rrr
 PACGA           1 00 11010110 ..... 001100 ..... .....  @rrr
 
 # Data Processing (1-source)
+
+@rr             . .......... ..... ...... rn:5 rd:5     &rr
+@rr_sf          sf:1 .......... ..... ...... rn:5 rd:5  &rr_sf
+
+RBIT            . 10 11010110 00000 000000 ..... .....  @rr_sf
+REV16           . 10 11010110 00000 000001 ..... .....  @rr_sf
+REV32           . 10 11010110 00000 000010 ..... .....  @rr_sf
+REV64           1 10 11010110 00000 000011 ..... .....  @rr
+
 # Logical (shifted reg)
 # Add/subtract (shifted reg)
 # Add/subtract (extended reg)
-- 
2.43.0


