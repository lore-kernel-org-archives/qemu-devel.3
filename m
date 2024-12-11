Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34DA9E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:44:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPcy-0004fS-4U; Wed, 11 Dec 2024 11:31:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPcO-0003wh-3B
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:31:20 -0500
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPcM-0001D0-8h
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:31:19 -0500
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-4676f1a43dfso8013881cf.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934677; x=1734539477; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jketwBKoo02OCAcU1bp5I+NgSnbqc1IWZRElDFeh+xg=;
 b=Dx3btb73jPj3pGCoEM6xu/O6LTICxuDmIOnzHZ893aEW3TCLeo+FS4D/rNtxziigHj
 Zpk0/COkB7l0BWOuUQxcxaHvFkup5fBCWC+ncCqqtk2QeUFxudvkrbPhOLuTj+NwuaAk
 XRovxBdlRgJ05efLaaYtzuHzgJcfUP3YLTsDPVyx0Rjm7QMlkiTNvvKdHNDznAeiq5+g
 VTf6lBXJKrAuAAPMyFHWfzDMMlePgBdPukMfpjVRNS7DtusSPJZV11sdnMW+cqCJMxJY
 JlzeRrWgIWrfGPxtMK5N+DxvLwegveOb7C3I7dEh22L/7LEJAkUYcJSQ9O2iGaO38S+r
 vscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934677; x=1734539477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jketwBKoo02OCAcU1bp5I+NgSnbqc1IWZRElDFeh+xg=;
 b=g1q+rLVxz/hsWdKYstSbqxfRosJWpMYdbpQgYdtlMTTQHsKmpd8/smYGbA+vsaORMy
 tgnNMKzrrmQ3C8V5LxmEe6wsr9ddEP+L4bWL4CMcaRhdxhr9OjusjUcPEbhIx5Rdwpbo
 arHoImUfAFo8FBTb2HKffPtq1hRNKet07oR679J1CYqjKchJh+waywclLlb8rn8Y+RU0
 +gxouh01HjSJ2vi5QEV8hIAMcaR45vTln9WN2GTsu6WA9Bh3icGGIgX14gFOLxKP/uxT
 AvY5C/sxA0iPzFZl0kC16XGtXBKqd60nPo8ivkLzqQyVgNHbcnjLniaCSTvjDx4qbtRh
 xyBw==
X-Gm-Message-State: AOJu0YwIBSDOoWoLhFFUCi8tRRb3u/eX0hgqA6p/y6iNzxFbtLK5tUZm
 9AnXWWSeaMrbmBcHgOLapOyIPf4F0GQmyojiOxqL1c4l5/+A053dGPo044jyISQjOplMhLZOuEn
 pBDPrdPZG
X-Gm-Gg: ASbGncspQzAaCxPPXYbe4l8ieK6CXz5CE/BI5AxpBeYYlXAEiIMdh4GCZUxtji0r/K8
 ws40eMuleKje5S9s6TjtZ5Qc+JeZiXhnzFru8np8eXcJ75Y2MeErvy8+qDB/SHGG2nv6wuOkBsZ
 qN8fJrLovsf5gu87FnsoWorXy0d9E+vnePp1MXA++3mDvgAPoDY7MrCFeHXhLonIrcbXTkXtBEB
 eq+2GrMEg8GtIL7VV9r2M+Y34T6HHMQbBZsEMWtAbyqTsFh9EUVeI96EZOVvw==
X-Google-Smtp-Source: AGHT+IFs6ctrtoXMaXslHWW4Sqm0xdvonitJYyfHG/QR7LXdU8EXkRtcLLG2TcFg1/jvD4fK2Uf7lg==
X-Received: by 2002:a05:622a:8d03:b0:460:ffdc:4cb7 with SMTP id
 d75a77b69052e-467894dc699mr58390891cf.4.1733934677116; 
 Wed, 11 Dec 2024 08:31:17 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46755db613csm43849381cf.70.2024.12.11.08.31.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:31:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 08/69] target/arm: Convert CLZ, CLS to decodetree
Date: Wed, 11 Dec 2024 10:29:35 -0600
Message-ID: <20241211163036.2297116-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211163036.2297116-1-richard.henderson@linaro.org>
References: <20241211163036.2297116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::829;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x829.google.com
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


