Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD686C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urau3-0003LG-LW; Thu, 28 Aug 2025 07:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uratz-0003Gs-BX
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:34:47 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uratx-0005hO-5w
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:34:46 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-45b7d485204so1575245e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 04:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756380883; x=1756985683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9rv5evHq+vjKZvOo6i0wNloSfFYxnuEPBkxKdkW8gSk=;
 b=BiI9Ryov44Zy82sONzBcKN54Ju7z8WfGuwV5STgfF/GX6SSxdMDOkG5tLhvNaQbfqF
 w/D+9htgdNrxDW3wig4RI7jAls9uhidRxet9MPzMvl+X7taThHQWslSgIRCSpX16Kngu
 bkjp+0DMdzt8BBrXkfHNpUD9HZQlLTSyjzJhg0WM4o+8yTx5W2hWOY4ndXECQU6PCylp
 IBLqEg91zu7sBVBkp7GH1arP67zol1ikMdSnSq1DuMUHDQU/6CQ3CQvYucMgP0kaKOCU
 sdAN3vGVQtbSACGeqSpVedfp0gdImMVYT78lmkoEY2URJQ48B51X7TBpUab5UaUSs9dJ
 bh6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756380883; x=1756985683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9rv5evHq+vjKZvOo6i0wNloSfFYxnuEPBkxKdkW8gSk=;
 b=W/SZRQqj4w5SbZtO2mjzWjfLdlU89nHFjlPa8AYlA7YSpwyZSg11c4pOtPgV9wWDFe
 KFO23W76s3H/ucjKmnqdlodm3HYvq8raizw27X1k3qW8/oDaZF2JkG0ba/rDEL4Im14w
 3aNBA46ZYkgfZISGW9HAILakM/vvUKLhg6ikYpqxiVFq2c0Knkq6YWF3vnSo3+lRCSrw
 qkWVBP30srtgWkN2bEdJSOhQBmCC55oRY8LPMCuHzLjgGDR1yxGUC6LJpkmvVQ9erjuZ
 VB0X7QOsP4zz1nVpRsB7kErODpqu6TTV6PP0omuAvI9BGaU686/3No6gNbha+mUGRhxu
 G3NQ==
X-Gm-Message-State: AOJu0YxwGZGIj/6ukyUzQLw+4qVA8NFnussTqfWE10uXJtVcf23ie6VF
 8ZM6LxnNBW2I8zwFQce0KLpOUvc4wG8v5mdHSx/3dwUEDw24w5X1NJe8a+pI+pscf9w+5aNpbEI
 4xqUo
X-Gm-Gg: ASbGncuwHq7cHNDW/vVHFNlnaLFMcwCt8L6VA6IS8rpKNP9uN6a03yy9IL3PaqhsRY7
 rpIQ3BA19Pti7LE4DQxRZrRH1/OWoUYH5P8H106xiPxymjlfERDIaGbz13Jhc5n2fCrjvoZsTDo
 ZVHvl7LKvkGS7C4PBoTh9edNgkfts/dSPUfwD+xrAbx5xG25RaJgKQ1GtRHIvykMxTZWCEFsL4C
 8vGrtIYh0/RtUpQkJaHeea3YyfV/vaYV+bO6VKDb+u2L8uKRyMzdPfY0XAof3Zam3TDygmiltb4
 7MT5LQEG89Hx4jh+hsyfT2YKOZWewOESoSZtfHneaRaogXDs2R/3ZkYKyhvgV3GlDLdq8PmRr/c
 Z7cz1ooYY/9i98Kxeua3vqmRvJdrXCKq0BwhUh7DXLiZoeN0dmA==
X-Google-Smtp-Source: AGHT+IGTdTRweGagzdZ13NT2qbQTj+E4X8+5zJWCCNScCnRWGNrlqPbhUh60EbBjdGSQwEaIKVuypQ==
X-Received: by 2002:a05:600c:4ecf:b0:459:d3ce:2cea with SMTP id
 5b1f17b1804b1-45b5179947cmr232275815e9.6.1756380883235; 
 Thu, 28 Aug 2025 04:34:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b79799c33sm28691015e9.5.2025.08.28.04.34.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 04:34:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/32] target/arm: Implement MIN/MAX (immediate)
Date: Thu, 28 Aug 2025 12:34:06 +0100
Message-ID: <20250828113430.3214314-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828113430.3214314-1-peter.maydell@linaro.org>
References: <20250828113430.3214314-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20250803014019.416797-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      | 10 ++++++++
 target/arm/tcg/translate-a64.c | 44 ++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 8c798cde2b4..c1811b02747 100644
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
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index dbf47595dbe..b70ae5befd2 100644
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
-- 
2.43.0


