Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DADFCE7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 03:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN299-0007Nu-BP; Sun, 15 Dec 2024 22:51:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tN296-0007N3-Ll
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 22:51:48 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tN295-00061H-3O
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 22:51:48 -0500
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-71ded02b779so1894275a34.2
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 19:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734321106; x=1734925906; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nSGD2w+KCzI3jUXBSuSbJy5TW+wbwk1/L1q8EYKN6hM=;
 b=sCeghu22UqAm54P9sD/d1kBOy1KZ/mxmaosSfnuqE1l3ey8GQB5VyW6LCKEX8Syy0s
 71qB0T2l8DLdyEtVNm2NkH2Uv/zPbJhfuFRWHE3+j8at8by+UjyGxh1zYl9x9XkFcMQr
 6HDbRwA0QD3DRzInPsWHEgjSQeb7tJSdPPp55Bq2d5o2ognAu9YLa7SMOyfEze7u24J/
 R+DSuJ8OfxLCGopcLfy8mX6Ke+lyDLvx6P6wXijv9+U+yuY3yVhO6DWD50n02vyCMwbZ
 apeg7sL6FhfA+06JfGLgj4g2iWg5lcsS275PxhaSJnp6woCspMZ+hfqQc0MC+o9qbBBA
 mA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734321106; x=1734925906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nSGD2w+KCzI3jUXBSuSbJy5TW+wbwk1/L1q8EYKN6hM=;
 b=UXkIRtq1264IYVMb/afKnypixAdiQOJA/nBga83/1QV3DxGv9EhzogpRu5HSvGH2pZ
 IjIF8u6THu5c6xZDqJBzkImOAS/sc/2rfAvGRzUAIfUSXc6SrcEzaZlQoZoOA9C8JWBy
 kuVfyRO7c0lyU8GfwSLarWYf9DgXRwUzo28wvCuVekCj+BeINyUC3bum1eKjbZWFi/8d
 +CUvg93ZV9+qaDiyzBEA1mFMRtih2+k132V95LyuzezGNfnpfUN7SyvV8OPC+SpHr7qZ
 smDovqlnypEOuQeDndX1ASdO+wgKdwB1lzmvqg5ryUJHnNCqXmio35747Zy/rr/0eGsP
 v6LA==
X-Gm-Message-State: AOJu0YyEw5eCHx/5AmfXy+TlRtTWzUbYIvO6t1uKmnrUfT5WEmKH9A1a
 n8Fqe6AAYmUG4pn3IqhJZ6/4+BLgRCz3FR9nfTa3yIWXgsMQdbhmNu8OelbwN2ex0C8CFlahji5
 bB/kjYjX0
X-Gm-Gg: ASbGncs+r5WDrpsbK+5oLiKJZ49TPJODaRxUrNmuefE/VU5G4F8qXbflRBQ1cyl9eZb
 cW1lTzZwWvNuMhu+GLZUndiNpk+mgWWoCVfnWyJnANZrCt7uwBTExJYfyhITHxjweSAwzPKyXSt
 yXSSIEBmxLw+gfROD8HlfexDAo/9B37PcOSrB1+XTRTbyW6gaxyH9nZOI68q5+CnUkHy06Xmsaa
 1pZxOnWdaHNDrM+8eAUrCAEqkFbidh4YqW1hYsfYAEKjcgfIo49xINZ+pYwwyOX7tnyZn/Ej9aM
 zSIwriz+UzPzXs5/yviAjOG8yLe+VYYg2zFScbwlank=
X-Google-Smtp-Source: AGHT+IFERf8wsgLnia/hGUwDf0/6LqjXMU+FkZp7frufT87+TlR4kPDVHorOmC78QY82fXoghhseRw==
X-Received: by 2002:a05:6830:6997:b0:71e:223c:1786 with SMTP id
 46e09a7af769-71e3ba3afcfmr7000314a34.29.1734321105835; 
 Sun, 15 Dec 2024 19:51:45 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f33a93a6d1sm1287493eaf.33.2024.12.15.19.51.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 19:51:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 19/24] target/riscv: Do not abuse DEFINE_PROP_END_OF_LIST
Date: Sun, 15 Dec 2024 21:51:04 -0600
Message-ID: <20241216035109.3486070-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241216035109.3486070-1-richard.henderson@linaro.org>
References: <20241216035109.3486070-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
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

These are not arrays of Property and had no business
using DEFINE_PROP_END_OF_LIST.  Use plain { } instead.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4329015076..a5aa3a8670 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -213,7 +213,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(xtheadsync, PRIV_VERSION_1_11_0, ext_xtheadsync),
     ISA_EXT_DATA_ENTRY(xventanacondops, PRIV_VERSION_1_12_0, ext_XVentanaCondOps),
 
-    DEFINE_PROP_END_OF_LIST(),
+    { },
 };
 
 bool isa_ext_is_enabled(RISCVCPU *cpu, uint32_t ext_offset)
@@ -1575,7 +1575,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("zvksc", ext_zvksc, false),
     MULTI_EXT_CFG_BOOL("zvksg", ext_zvksg, false),
 
-    DEFINE_PROP_END_OF_LIST(),
+    { },
 };
 
 const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
@@ -1592,12 +1592,12 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
     MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
 
-    DEFINE_PROP_END_OF_LIST(),
+    { },
 };
 
 /* These are experimental so mark with 'x-' */
 const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
-    DEFINE_PROP_END_OF_LIST(),
+    { },
 };
 
 /*
@@ -1610,7 +1610,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
 const RISCVCPUMultiExtConfig riscv_cpu_named_features[] = {
     MULTI_EXT_CFG_BOOL("zic64b", ext_zic64b, true),
 
-    DEFINE_PROP_END_OF_LIST(),
+    { },
 };
 
 /* Deprecated entries marked for future removal */
@@ -1627,7 +1627,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_deprecated_exts[] = {
     MULTI_EXT_CFG_BOOL("Zve64f", ext_zve64f, false),
     MULTI_EXT_CFG_BOOL("Zve64d", ext_zve64d, false),
 
-    DEFINE_PROP_END_OF_LIST(),
+    { },
 };
 
 static void cpu_set_prop_err(RISCVCPU *cpu, const char *propname,
@@ -2699,7 +2699,6 @@ static const Property riscv_cpu_properties[] = {
      * it with -x and default to 'false'.
      */
     DEFINE_PROP_BOOL("x-misa-w", RISCVCPU, cfg.misa_w, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 #if defined(TARGET_RISCV64)
-- 
2.43.0


