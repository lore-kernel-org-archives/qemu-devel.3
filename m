Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5828E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL2wF-0002WJ-7T; Tue, 10 Dec 2024 11:18:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2wE-0002W0-6Y
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:18:18 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2wC-0006Ka-Ej
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:18:17 -0500
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-54020b0dcd2so2072382e87.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733847495; x=1734452295; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jketwBKoo02OCAcU1bp5I+NgSnbqc1IWZRElDFeh+xg=;
 b=glnCh/l0d4JLsT1FkAD23fJIkb/0IsE0J70HkT2MvN5Mpy53qr6G6GYXWes2wRHXVi
 6MjcMDBhP62uZaYZL/k5VnAY6CRA1QEqJ4813q+c/kEQWQn1GVAUv6rliXnPA+JbCi21
 MMxo/3eL4/a95b799Rmv5h92tsN1vTQWIYywHNIfcHT7hGICHHIKlkGGlYZaEQzh6S9M
 grU086p0m931eCKMm4x308Q7s1z98f/K+tvpC4PV/jCgDUVSMFOzlv2RVS3ZgXA3yqLz
 z8NndD+PkOarYTWeeuMXIQ2QGlsIpjEZtPVNaS7rFe6j65Uo2tsO4np8a3oc3zJric5N
 xLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847495; x=1734452295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jketwBKoo02OCAcU1bp5I+NgSnbqc1IWZRElDFeh+xg=;
 b=YqSSPL2xAhBZd4PgD0jTp5C2Iyl8zfGbCzwL34+zUNuvqwbkZ0WqSt0bGLL4hPLicE
 boUGNqhlyycmP8b+dwDUrUUNgBWj4ESggthblCV+NPfqMlnQ2wJdmkpvn4YenTwJ1YC3
 Zc9fXOTfNlXFNjvaacR3m1PE5wTOi+gPPxGiB/Xh6ELFN6nJjbk6Zsp5H9qtBXILJz96
 sSP66C6AUfDh9r8MFJL4OKppQV+N5dfYjourv6T6NH5Jqwn/vD41tz3NpwCydaOoyDWI
 296rnck3SUHpddA3Vz3gvEtdTzs18VaF/6wtk5gb3ab8qVBxCSRp1kxO1iYLWiJDFTM5
 /FYA==
X-Gm-Message-State: AOJu0YwjFKkS4jJmt46yQoILGhtJ7iOa69csdgPhwEaXknHh9XDluGer
 Asc3gABu7b9EXQXz/kUL8X9vI0DZrFLPEUd3I3jGPyad/oNiY/83YWkHBfBrWYUxkCRu6viahe3
 OATIKNduW
X-Gm-Gg: ASbGnctsojQXk4kClk7zqWUyoys0j1EFvw2owk+GuRqliW5Ql8Mbq0tIxLyJCOnWHHi
 CIeRnVb5p/MbryBUttm559gVGEBYDH8g6KQvrTY3f3otjmbVOfhZ/78HpcCD7VJOPH459CYdVu4
 SNIRMQIbUmD3ps/B35X5NZ+CxS7q6SGT1z3gnpcfEEGeoILmjCZNegEeov14srmOwpGqRCXG0iv
 uA0EWdw7mMucFv5DlHd41uEekAiju0eqlU0aP8DaF3hvlfawvn63oANziw=
X-Google-Smtp-Source: AGHT+IGHpyA4C9ra7T2Pcj0v5l5MSeCHiwNgSCebH7saMt+4ZsHzRcHcikxJIZS1u8CCci00Ft5Wug==
X-Received: by 2002:a05:6512:3a83:b0:53e:94f8:bb3e with SMTP id
 2adb3069b0e04-540251f216emr1408444e87.19.1733847494723; 
 Tue, 10 Dec 2024 08:18:14 -0800 (PST)
Received: from stoup.. ([91.209.212.80]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53f93377eefsm1026343e87.67.2024.12.10.08.18.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:18:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 08/69] target/arm: Convert CLZ, CLS to decodetree
Date: Tue, 10 Dec 2024 10:16:32 -0600
Message-ID: <20241210161733.1830573-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210161733.1830573-1-richard.henderson@linaro.org>
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x133.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 72 ++++++++++++++--------------------
 target/arm/tcg/a64.decode      |  3 ++
 2 files changed, 33 insertions(+), 42 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 1805d77f43..552b45b4e2 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7738,6 +7738,32 @@ TRANS(REV16, gen_rr, a->rd, a->rn, a->sf ? gen_rev16_64 : gen_rev16_32)
 TRANS(REV32, gen_rr, a->rd, a->rn, a->sf ? gen_rev32 : gen_rev_32)
 TRANS(REV64, gen_rr, a->rd, a->rn, tcg_gen_bswap64_i64)
 
+static void gen_clz32(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn)
+{
+    TCGv_i32 t32 = tcg_temp_new_i32();
+
+    tcg_gen_extrl_i64_i32(t32, tcg_rn);
+    tcg_gen_clzi_i32(t32, t32, 32);
+    tcg_gen_extu_i32_i64(tcg_rd, t32);
+}
+
+static void gen_clz64(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn)
+{
+    tcg_gen_clzi_i64(tcg_rd, tcg_rn, 64);
+}
+
+static void gen_cls32(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn)
+{
+    TCGv_i32 t32 = tcg_temp_new_i32();
+
+    tcg_gen_extrl_i64_i32(t32, tcg_rn);
+    tcg_gen_clrsb_i32(t32, t32);
+    tcg_gen_extu_i32_i64(tcg_rd, t32);
+}
+
+TRANS(CLZ, gen_rr, a->rd, a->rn, a->sf ? gen_clz64 : gen_clz32)
+TRANS(CLS, gen_rr, a->rd, a->rn, a->sf ? tcg_gen_clrsb_i64 : gen_cls32)
+
 /* Logical (shifted register)
  *   31  30 29 28       24 23   22 21  20  16 15    10 9    5 4    0
  * +----+-----+-----------+-------+---+------+--------+------+------+
@@ -8322,40 +8348,6 @@ static void disas_cond_select(DisasContext *s, uint32_t insn)
     }
 }
 
-static void handle_clz(DisasContext *s, unsigned int sf,
-                       unsigned int rn, unsigned int rd)
-{
-    TCGv_i64 tcg_rd, tcg_rn;
-    tcg_rd = cpu_reg(s, rd);
-    tcg_rn = cpu_reg(s, rn);
-
-    if (sf) {
-        tcg_gen_clzi_i64(tcg_rd, tcg_rn, 64);
-    } else {
-        TCGv_i32 tcg_tmp32 = tcg_temp_new_i32();
-        tcg_gen_extrl_i64_i32(tcg_tmp32, tcg_rn);
-        tcg_gen_clzi_i32(tcg_tmp32, tcg_tmp32, 32);
-        tcg_gen_extu_i32_i64(tcg_rd, tcg_tmp32);
-    }
-}
-
-static void handle_cls(DisasContext *s, unsigned int sf,
-                       unsigned int rn, unsigned int rd)
-{
-    TCGv_i64 tcg_rd, tcg_rn;
-    tcg_rd = cpu_reg(s, rd);
-    tcg_rn = cpu_reg(s, rn);
-
-    if (sf) {
-        tcg_gen_clrsb_i64(tcg_rd, tcg_rn);
-    } else {
-        TCGv_i32 tcg_tmp32 = tcg_temp_new_i32();
-        tcg_gen_extrl_i64_i32(tcg_tmp32, tcg_rn);
-        tcg_gen_clrsb_i32(tcg_tmp32, tcg_tmp32);
-        tcg_gen_extu_i32_i64(tcg_rd, tcg_tmp32);
-    }
-}
-
 /* Data-processing (1 source)
  *   31  30  29  28             21 20     16 15    10 9    5 4    0
  * +----+---+---+-----------------+---------+--------+------+------+
@@ -8381,14 +8373,6 @@ static void disas_data_proc_1src(DisasContext *s, uint32_t insn)
 #define MAP(SF, O2, O1) ((SF) | (O1 << 1) | (O2 << 7))
 
     switch (MAP(sf, opcode2, opcode)) {
-    case MAP(0, 0x00, 0x04): /* CLZ */
-    case MAP(1, 0x00, 0x04):
-        handle_clz(s, sf, rn, rd);
-        break;
-    case MAP(0, 0x00, 0x05): /* CLS */
-    case MAP(1, 0x00, 0x05):
-        handle_cls(s, sf, rn, rd);
-        break;
     case MAP(1, 0x01, 0x00): /* PACIA */
         if (s->pauth_active) {
             tcg_rd = cpu_reg(s, rd);
@@ -8542,6 +8526,10 @@ static void disas_data_proc_1src(DisasContext *s, uint32_t insn)
     case MAP(0, 0x00, 0x02): /* REV/REV32 */
     case MAP(1, 0x00, 0x02):
     case MAP(1, 0x00, 0x03): /* REV64 */
+    case MAP(0, 0x00, 0x04): /* CLZ */
+    case MAP(1, 0x00, 0x04):
+    case MAP(0, 0x00, 0x05): /* CLS */
+    case MAP(1, 0x00, 0x05):
         unallocated_encoding(s);
         break;
     }
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index dd44651f34..410eaa9333 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -696,6 +696,9 @@ REV16           . 10 11010110 00000 000001 ..... .....  @rr_sf
 REV32           . 10 11010110 00000 000010 ..... .....  @rr_sf
 REV64           1 10 11010110 00000 000011 ..... .....  @rr
 
+CLZ             . 10 11010110 00000 000100 ..... .....  @rr_sf
+CLS             . 10 11010110 00000 000101 ..... .....  @rr_sf
+
 # Logical (shifted reg)
 # Add/subtract (shifted reg)
 # Add/subtract (extended reg)
-- 
2.43.0


