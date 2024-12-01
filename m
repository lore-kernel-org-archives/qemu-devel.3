Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0376DD49771
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 15:12:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHlWk-0001GF-G9; Sun, 01 Dec 2024 10:06:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlWg-0001Dg-9T
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:06:22 -0500
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlWe-000479-MK
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:06:22 -0500
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5f1e73033cbso1407027eaf.3
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 07:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733065579; x=1733670379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+yoyh9K2K+390OchJBgvM17dKnlsh3dj4ZAo5zedWuQ=;
 b=P1TL+uGcFBXT5GNvnjtdDUGuP559HLPoutdUzZpiNs08HlpXio9SI/1LA8xSlod2xV
 V4+ctDU5ISR0L7YaxJyRvDYeAWjJlCvysW57M8zlqPLaAqqCPFxTfoEmdy233uCF1/Pu
 ZaXAUi1NRby/7LpPNnOfxnnUdInqjZUqkW8UQOodJQy6EyrHFslvFXbOuaotdVFl3ACM
 m1Ep3Uh/y1VmMTQQglRla0wpf3b7B7+LqRSdQbu0UqX8aA0D2+ECU8pYivfPFYyWX7lH
 99O8bsr/rwVUG9xJz/oitKjGX8pP7XZk86XIXXHTdrkR3qounckDo9bBjFA+Q//qgOSp
 dEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733065579; x=1733670379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+yoyh9K2K+390OchJBgvM17dKnlsh3dj4ZAo5zedWuQ=;
 b=WUZA9WnsMDdQwcxdEYm9DpXa9AjkGE56dOO4hXHlJJv5iSdb659APZVdIDcCcLPt9c
 DIzX/wuJZdm67KPDKSNjjoN4BA6jwGch1F/O9BP/e3lbSDli4tvsMmJWTMe/cWZxyHWA
 qewKeJ2dUXgw3Ud3MMy0VEk8A5Uf4T8HFJssLZh6oTD4vRSsM/yzePmCSr9MtaK4hQ/m
 e2slfw1eFER/cWrUs100LjXLKVwvwTAY9ylY+UExZYGJ/R2OR9tSXJeA1wjq56RhV0HU
 0qqmDHEPvpbhDZJFa8wHvxGs5sZZyJCzAAjjnidwUkZn3VWcHhathhwZ+BaKC20ChVZV
 ReuA==
X-Gm-Message-State: AOJu0Yxd2tpb1GV/gSzBsBG3PqkrEZ16Y3ijXy2ccsv5gIijhDb4RYFh
 nlCV6OUE3gqHR/39I0sryBjMTxZ1JPSbgzUf26QRJIsB41yNZSo/vYnxQsaKOPtANeaPbbruXsk
 ivqc=
X-Gm-Gg: ASbGncsnPUGGsUMJcOWyQdXN+bViybgfaxY+pDZFQaVCvp1aG4/hd5pOvu/SDbhqq09
 DJ57sIKYLzpEqep1nwMXtWQq2Kr2hB1IwF8KXSRsVa9swygnSlEQ28McgAsnXsp2T2T8D4kz/0c
 KXslxciNseaLomYrSIYd2jiLb5ekmha8ypmWOA9nGFTxC28uZlEyvP+KNiP9O3W0TWuyZ06e+bl
 jjtEzW6Xf19wi2pDVHJBGZ09gDkJDIJYzttM4hB8T/xKkaeae7gQIWMGnlMEIBxbC0trUEWO0eE
 Ryvj60qc3O0SRA4YehLbRDeQdVWXrBXLW8PQ
X-Google-Smtp-Source: AGHT+IHIaHfQQigjB1v0LNYqhRkm8kvWjYnF0dR0UBpOFxqiB5crW/ybkjtcYDWiFpjV0lhU6uVjJQ==
X-Received: by 2002:a05:6820:1acc:b0:5f2:9aa:5821 with SMTP id
 006d021491bc7-5f20a14f39amr12513692eaf.2.1733065579451; 
 Sun, 01 Dec 2024 07:06:19 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d7254473asm1822220a34.27.2024.12.01.07.06.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:06:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 08/67] target/arm: Convert CLZ, CLS to decodetree
Date: Sun,  1 Dec 2024 09:05:07 -0600
Message-ID: <20241201150607.12812-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201150607.12812-1-richard.henderson@linaro.org>
References: <20241201150607.12812-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2c.google.com
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


