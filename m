Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D98CCECE577
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 17:29:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sniBn-00046H-9K; Mon, 09 Sep 2024 13:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniBi-0003vw-Lg
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:30 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniBg-00060I-KT
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:30 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2054feabfc3so40719945ad.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 10:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725902907; x=1726507707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m7w703O79/DTa7nR13RVyKW4XTiaiYluVn4vLct/9bg=;
 b=xMaccUGloF3Wcy44le+WHndM1atlQ6a/2zkXGieO0EybkKh2d8jWpRif0i2bQ2v3NE
 jKkd5zFaZFnR3n3FadrsOkhVu+7AwCyJshQGHQU4c6/RCrtTbHQULp3sQBaJNsUoPbek
 prXJwlHpcTvl0SRDP8qjzvrtKfaXNNwN38o3A0OFBM4sVyQYxdsY3LQRmtvxl8RbGeve
 mn+GgJsPyVp+hM71z07dSDYXbUEdlcMUX4owsIEac/gEBICczyHwdUu5rrZQ19Rxmg/m
 icYGq8Fe95F5T+3Ab9DsG7EZEP+s16iUdU81qufPd9bFf1PE6wwyb/IHbUCZzOQKBa3E
 9zWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725902907; x=1726507707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m7w703O79/DTa7nR13RVyKW4XTiaiYluVn4vLct/9bg=;
 b=UUutE/NhVtc1MuXKxTZS/6ofM6ts0/x2MdEGs0NvBOZGfUas5xiAfvPTQYzNCuIlEY
 lyAReUuRrVbMrX8vJuFO0TfhvtKYiBCXLMHsr3amIfFgePk7e+nXbNw2WYEzNm+NbZDO
 WhOurbNUCyI1Y34kbW+M0s3FQ6eHvWSo3nQ+dyOgpDRC3cRceDc+EMJ/T0tWFH24wx2m
 GRefaRNzuy1x6Mwqn3socP9XPRWr0ibcKrAWzISspH6P+RwqgX8rZ36oOH4SEtwdckPo
 A2H+vJgDgNGN0EMN/iTIswjGhGfsxdRVMfPuoC7R7FdJr1Hc/yJ9nyj4HXzFezknKvqr
 ALNA==
X-Gm-Message-State: AOJu0YzBcDUuUgUPTtujBdaN8l/ssRhOxz0fFYaOWQgMhkdfJOnClhWn
 HB/wiasX/LvUTs/Lu4qP2T5xzBUvODsY/YSngUW9+GOX2Hh4v9jj71gIqfviJK8n9C00fWTQwgb
 p
X-Google-Smtp-Source: AGHT+IFELZCDbTWnrlI0HmUXb/9+eTndAyqf81KnblWmUwOaIRp4Py832GWZvtZeby/AEqmqu97g1A==
X-Received: by 2002:a17:902:d2c5:b0:206:d8c2:4a94 with SMTP id
 d9443c01a7336-206f0542c38mr192047795ad.25.1725902907062; 
 Mon, 09 Sep 2024 10:28:27 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710e11e02sm36539875ad.14.2024.09.09.10.28.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 10:28:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	daniel@0x0f.com
Subject: [PATCH v3 02/26] target/m68k: Add FPSR exception bit defines
Date: Mon,  9 Sep 2024 10:27:59 -0700
Message-ID: <20240909172823.649837-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909172823.649837-1-richard.henderson@linaro.org>
References: <20240909172823.649837-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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
 target/m68k/cpu.h        | 21 +++++++++++++++++++++
 target/m68k/fpu_helper.c | 22 +++++++++++-----------
 2 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index b5bbeedb7a..e8dd75d242 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -440,6 +440,27 @@ typedef enum {
 #define FPSR_QT_MASK  0x00ff0000
 #define FPSR_QT_SHIFT 16
 
+/* Exception Status Byte */
+
+#define FPSR_EXC_MASK     0xff00
+#define FPSR_EXC_INEX1    0x0100
+#define FPSR_EXC_INEX2    0x0200
+#define FPSR_EXC_DZ       0x0400
+#define FPSR_EXC_UNFL     0x0800
+#define FPSR_EXC_OVFL     0x1000
+#define FPSR_EXC_OPERR    0x2000
+#define FPSR_EXC_SNAN     0x4000
+#define FPSR_EXC_BSUN     0x8000
+
+/* Accrued Exception Byte */
+
+#define FPSR_AEXC_MASK    0xf8
+#define FPSR_AEXC_INEX    0x08
+#define FPSR_AEXP_DZ      0x10
+#define FPSR_AEXP_UNFL    0x20
+#define FPSR_AEXP_OVFL    0x40
+#define FPSR_AEXP_IOP     0x80
+
 /* Floating-Point Control Register */
 /* Rounding mode */
 #define FPCR_RND_MASK   0x0030
diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index 8314791f50..c6d93b56a0 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -170,19 +170,19 @@ static int cpu_m68k_exceptbits_from_host(int host_bits)
     int target_bits = 0;
 
     if (host_bits & float_flag_invalid) {
-        target_bits |= 0x80;
+        target_bits |= FPSR_AEXP_IOP;
     }
     if (host_bits & float_flag_overflow) {
-        target_bits |= 0x40;
+        target_bits |= FPSR_AEXP_OVFL;
     }
     if (host_bits & (float_flag_underflow | float_flag_output_denormal)) {
-        target_bits |= 0x20;
+        target_bits |= FPSR_AEXP_UNFL;
     }
     if (host_bits & float_flag_divbyzero) {
-        target_bits |= 0x10;
+        target_bits |= FPSR_AEXP_DZ;
     }
     if (host_bits & float_flag_inexact) {
-        target_bits |= 0x08;
+        target_bits |= FPSR_AEXC_INEX;
     }
     return target_bits;
 }
@@ -192,19 +192,19 @@ static int cpu_m68k_exceptbits_to_host(int target_bits)
 {
     int host_bits = 0;
 
-    if (target_bits & 0x80) {
+    if (target_bits & FPSR_AEXP_IOP) {
         host_bits |= float_flag_invalid;
     }
-    if (target_bits & 0x40) {
+    if (target_bits & FPSR_AEXP_OVFL) {
         host_bits |= float_flag_overflow;
     }
-    if (target_bits & 0x20) {
+    if (target_bits & FPSR_AEXP_UNFL) {
         host_bits |= float_flag_underflow;
     }
-    if (target_bits & 0x10) {
+    if (target_bits & FPSR_AEXP_DZ) {
         host_bits |= float_flag_divbyzero;
     }
-    if (target_bits & 0x08) {
+    if (target_bits & FPSR_AEXC_INEX) {
         host_bits |= float_flag_inexact;
     }
     return host_bits;
@@ -214,7 +214,7 @@ uint32_t cpu_m68k_get_fpsr(CPUM68KState *env)
 {
     int host_flags = get_float_exception_flags(&env->fp_status);
     int target_flags = cpu_m68k_exceptbits_from_host(host_flags);
-    int except = (env->fpsr & ~(0xf8)) | target_flags;
+    int except = (env->fpsr & ~FPSR_AEXC_MASK) | target_flags;
     return except;
 }
 
-- 
2.43.0


