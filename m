Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F0AEC87FD3
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 01:43:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiNiN-0006ts-8g; Sat, 02 Aug 2025 21:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiNiK-0006qR-IL
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 21:40:40 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiNiI-0004c8-W5
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 21:40:40 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-71b6ad2d6fcso23247917b3.3
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 18:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754185237; x=1754790037; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tvGZH+bmzZVMm/Dci9lihogJ/vULk9Ac9jLiyluBLDI=;
 b=ZQjWDzkKe7gENm4hnl6XM5WcFvm0b7UP8jq68xbgFtY1lQzA/yojyUDiljzq8rODho
 NW8aEvpb2UMb24Ry0+hYsWMUJJsielxa8AItH8IL4WM88xQ7jtPpbxMNG7YCIZPNfF1f
 mMsAqHgFD9N107Ihz06Wz8plMAySD0AklTOwKwGPWpBQn/VczlYLZzbfwoxiXCihWkTS
 5TVCVITcbjyK51A+64zhCgJQo7zIV5kHrd8l8FUmoF7qI6It8jnB6gmL2Rjp74W8v/Mm
 RpANC5RQMMMxfTytZbuLF+FPuA2Jr7HQB81VhyEHEJrCxC6Js+teJMm5b3FlJTW43/Vd
 UJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754185237; x=1754790037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tvGZH+bmzZVMm/Dci9lihogJ/vULk9Ac9jLiyluBLDI=;
 b=SmQppu6O0Rlo/EMkvqFCh91jASiL92JwotuNl4bFTxlvmZ2/U5S9+EoT/kl4bSgoBG
 LR4OsacWQbv8eTT/blCb3TkBfsRwh7/EsnR/crjx7NBWHzKz4cxVTj16xGFI+BkXszlp
 UEtnPyNf1GH3vZmTW3rohFvPTAy15230QRpQ8hIGyCiihBPOpW5dmJ/GkMtIAddLOmhZ
 oq5cwVWCt0PptU7jbeAmj0Pj/qtsiY/cPRdbytBz0Pdy0gxUBeQ9HOLNFYIXqT2zBjZ0
 ZpzN32QydqbR2pwv6arPY43MattwVEc5hlarQYs6EFtRR0ZIHX96psZUMKXmCgnW6MCC
 lugA==
X-Gm-Message-State: AOJu0YzRAhhCPs5s6W6TI1E/saYxZ6ktDbXaF+pTgx6ZTyfJtsgot7Ba
 UHi5dIZJVUXoNn/YHVhVAJ1INkexi1GKe5Scnh+kTHTAhLeNQr9lEzrWxauoqN9chwV6IUT7TQk
 bnssNLTY=
X-Gm-Gg: ASbGncsuwY0nvOFFRsd57xbMnfA/t90myWjxIzfhJtG7XjYcx341G6/D9ytRAEci8de
 qKxkHOKN4D64AfJDiDMrnDO+owPUiQINThRwyYgXa9NLeWWDEe8VvJts+xtFs2qXqDdfNcshR5s
 XBLzneKazkJek+CcXPiZ4cyK4+NkasIi/nT3Jnjua04GuELAAZvIwN3E0mFrn19NzJMvsKG3E1N
 G2SIRIG7uBzzym4uLfARK2JFoYhuuhWnlXDAaCJs+pC+bT/88EvD6NfVtdshNQFIVLMEcACYcum
 N+tCTDLSb+iqUAy7pGOkiyU/YoAXtrzriS2HtA2Ma6l5Wt1PxI8VTfoK1p+2haHifqmVMRkWc6Q
 Co7Ycutpr65MrVrA6zXRs5j0LCo/bIWwuALdut1XXVsNzNcIS1uFqlHlbJShNESU=
X-Google-Smtp-Source: AGHT+IEsVZLSif8/KZEicQO+IoSQ9gUvnz5Z79+sWB43WjZLCo6Sv1xMiR5Slz3M07WiqVuRCHL18Q==
X-Received: by 2002:a05:690c:6d01:b0:71b:6703:b710 with SMTP id
 00721157ae682-71b7ef8b436mr54861927b3.33.1754185237407; 
 Sat, 02 Aug 2025 18:40:37 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-71b5a6031a1sm18753227b3.86.2025.08.02.18.40.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 18:40:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 02/11] target/arm: Implement MIN/MAX (immediate)
Date: Sun,  3 Aug 2025 11:40:10 +1000
Message-ID: <20250803014019.416797-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250803014019.416797-1-richard.henderson@linaro.org>
References: <20250803014019.416797-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x1132.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 44 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/a64.decode      | 10 ++++++++
 2 files changed, 54 insertions(+)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index dbf47595db..b70ae5befd 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -4552,6 +4552,50 @@ TRANS(SUB_i, gen_rri, a, 1, 1, tcg_gen_sub_i64)
 TRANS(ADDS_i, gen_rri, a, 0, 1, a->sf ? gen_add64_CC : gen_add32_CC)
 TRANS(SUBS_i, gen_rri, a, 0, 1, a->sf ? gen_sub64_CC : gen_sub32_CC)
 
+/*
+ * Min/Max (immediate)
+ */
+
+static void gen_wrap3_i32(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m, NeonGenTwoOpFn fn)
+{
+    TCGv_i32 t1 = tcg_temp_new_i32();
+    TCGv_i32 t2 = tcg_temp_new_i32();
+
+    tcg_gen_extrl_i64_i32(t1, n);
+    tcg_gen_extrl_i64_i32(t2, m);
+    fn(t1, t1, t2);
+    tcg_gen_extu_i32_i64(d, t1);
+}
+
+static void gen_smax32_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m)
+{
+    gen_wrap3_i32(d, n, m, tcg_gen_smax_i32);
+}
+
+static void gen_smin32_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m)
+{
+    gen_wrap3_i32(d, n, m, tcg_gen_smin_i32);
+}
+
+static void gen_umax32_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m)
+{
+    gen_wrap3_i32(d, n, m, tcg_gen_umax_i32);
+}
+
+static void gen_umin32_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m)
+{
+    gen_wrap3_i32(d, n, m, tcg_gen_umin_i32);
+}
+
+TRANS_FEAT(SMAX_i, aa64_cssc, gen_rri, a, 0, 0,
+           a->sf ? tcg_gen_smax_i64 : gen_smax32_i64)
+TRANS_FEAT(SMIN_i, aa64_cssc, gen_rri, a, 0, 0,
+           a->sf ? tcg_gen_smin_i64 : gen_smin32_i64)
+TRANS_FEAT(UMAX_i, aa64_cssc, gen_rri, a, 0, 0,
+           a->sf ? tcg_gen_umax_i64 : gen_umax32_i64)
+TRANS_FEAT(UMIN_i, aa64_cssc, gen_rri, a, 0, 0,
+           a->sf ? tcg_gen_umin_i64 : gen_umin32_i64)
+
 /*
  * Add/subtract (immediate, with tags)
  */
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 8c798cde2b..c1811b0274 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -156,6 +156,16 @@ MOVZ            . 10 100101 .. ................ .....   @movw_32
 MOVK            . 11 100101 .. ................ .....   @movw_64
 MOVK            . 11 100101 .. ................ .....   @movw_32
 
+# Min/Max (immediate)
+
+@minmaxi_s      sf:1 .. ........... imm:s8 rn:5 rd:5    &rri_sf
+@minmaxi_u      sf:1 .. ........... imm:8  rn:5 rd:5    &rri_sf
+
+SMAX_i          . 00 1000111 0000 ........ ..... .....  @minmaxi_s
+SMIN_i          . 00 1000111 0010 ........ ..... .....  @minmaxi_s
+UMAX_i          . 00 1000111 0001 ........ ..... .....  @minmaxi_u
+UMIN_i          . 00 1000111 0011 ........ ..... .....  @minmaxi_u
+
 # Bitfield
 
 &bitfield       rd rn sf immr imms
-- 
2.43.0


