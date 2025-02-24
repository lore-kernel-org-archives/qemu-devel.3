Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48DCAC021BC
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 17:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmc2o-0006vV-4G; Mon, 24 Feb 2025 12:15:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmc2j-0006uH-JX
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 12:14:58 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmc2i-0005YP-0b
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 12:14:57 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2210d92292eso140926325ad.1
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 09:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740417294; x=1741022094; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tntGWMBMvPlJGVingDVk2a4SNqW2ToCOYJjDKTb72Po=;
 b=HQdK6DLi6kKwZ5xuf8ht/3Thb5zDWKunyrHX3kwtpHsYqx/ed3pVg0v9AVorEyiHix
 xlu32CAtoGpPOB9eK6BKdEeMc04yw7xNuI5JGIIRXzv14UdBmhQiN9yq4ES3z39/pxUq
 gVn72KO75qObqekpcwLLDkMO86nc7YfCFbUbbGK4wO6MT5y5yU5yHTmamuKIAgV5F4yO
 yWYjeEEXQViri9i27fs8C+mnIGpoVpRB7bN0Nu+ERlZDxTgsgzPlgckc9Ea9aeV5ICvS
 KlT50IN901iVzuPQbezUaUftANRjIilm5Pkh3tiNmJ78awuevkSeaOFr+SNB3eewC3jI
 xq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740417294; x=1741022094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tntGWMBMvPlJGVingDVk2a4SNqW2ToCOYJjDKTb72Po=;
 b=md0/wyj8QsLpmKd6WgunOeFif4KiWtkLsMD1B5ldMBW7X2nXlo1qtufQqXQrx5aXju
 Cm7F+3xeLS6m22qgpd6VYYcuOZ2KkAuU4YxKykmrCHgwuxgtb3Pj4I5305wL5+Db38gH
 JDJ7WVTEFHQ34cWoxfEE8whoe5oFWQj6lEraU2ys37YViXZYvViwHkaaPqEI69pMDEWV
 qu8uNcjs5XafcLAFgtw6+RO85vWSg3Xd/Z/XUbsYM+NyXetRNThlXY3JJlK9oMrOJOz+
 EeCMEDEnauS5IEy6Q81/uCtKw2i3ALwuXeO4w8FC8/pc1GekXiVf2uHyDUqunv1ophN/
 5VXA==
X-Gm-Message-State: AOJu0Yzh05V82sSjQ5GvkpSoV8UecDbjBZypQf1FX3Qgv4TuJbSFfmNt
 tm3XCrxmggWcaHmpzzl91Obg2HfNLW7Iav96ZIb3Wg13axDs00QPthT3vQDjG5Oe/XIvvkv1DC+
 R
X-Gm-Gg: ASbGncsBXnfLNg5I086uHWoLYk02b/CnD1iaUBfUKXbTjyeThNiOWBq2F5urmNVXsJE
 Fj9ThOYUmrSkrX0IDGiwnNwMmAGk6znPl290drQphh6850DHFTLTjB2kpv44ZFHOnF5QeAeHtPL
 x7d8AxO2+HKTPhW4Mdj+RBk2KSLwF/lvlFgxjFZ9h2CAFyb3xWFRxynLCA1JVH8sBJrmZ0TIS8u
 qRum88PJmesbhPpna9Muhn/bL5khdAhtvi0c9+Co7sw1vCGVXDwQ9LS6Ij9akDRoyeiKbd0wsYg
 P0XMDHwmnh8Pj8UUpBnGUfI7KIKWSwQ5mTY=
X-Google-Smtp-Source: AGHT+IHKpQF4yoS3Hw8BjjuZp21dKg/aUOQjX9HZdCBFS2JxdQrO3aZpKFLRpD9neg7g/vmQr2DSKg==
X-Received: by 2002:a05:6a21:78a4:b0:1ee:7e68:6987 with SMTP id
 adf61e73a8af0-1eef3c9ae6emr26187774637.14.1740417293197; 
 Mon, 24 Feb 2025 09:14:53 -0800 (PST)
Received: from stoup.. ([2607:fb90:c9e2:d7e3:c85c:d4f0:c8b8:8fa7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-732425466besm20580780b3a.9.2025.02.24.09.14.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 09:14:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Subject: [PATCH v4 04/24] target/m68k: Update FPSR.EXC
Date: Mon, 24 Feb 2025 09:14:24 -0800
Message-ID: <20250224171444.440135-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224171444.440135-1-richard.henderson@linaro.org>
References: <20250224171444.440135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

So far we've only been updating the AEXC byte.
Update the EXC byte as well.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/fpu_helper.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index d5551bee41..206ceeba16 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -169,26 +169,28 @@ static void update_fpsr(CPUM68KState *env, int cc)
     uint32_t fpsr = env->fpsr;
     int flags = get_float_exception_flags(&env->fp_status);
 
-    fpsr &= ~FPSR_CC_MASK;
+    fpsr &= ~(FPSR_CC_MASK | FPSR_EXC_MASK);
     fpsr |= cc;
 
     if (flags) {
         set_float_exception_flags(0, &env->fp_status);
 
-        if (flags & float_flag_invalid) {
-            fpsr |= FPSR_AEXP_IOP;
+        if (flags & float_flag_invalid_snan) {
+            fpsr |= FPSR_EXC_SNAN | FPSR_AEXP_IOP;
+        } else if (flags & float_flag_invalid) {
+            fpsr |= FPSR_EXC_OPERR | FPSR_AEXP_IOP;
         }
         if (flags & float_flag_overflow) {
-            fpsr |= FPSR_AEXP_OVFL;
+            fpsr |= FPSR_EXC_OVFL | FPSR_AEXP_OVFL;
         }
         if (flags & (float_flag_underflow | float_flag_output_denormal_flushed)) {
-            fpsr |= FPSR_AEXP_UNFL;
+            fpsr |= FPSR_EXC_UNFL | FPSR_AEXP_UNFL;
         }
         if (flags & float_flag_divbyzero) {
-            fpsr |= FPSR_AEXP_DZ;
+            fpsr |= FPSR_EXC_DZ | FPSR_AEXP_DZ;
         }
         if (flags & float_flag_inexact) {
-            fpsr |= FPSR_AEXC_INEX;
+            fpsr |= FPSR_EXC_INEX2 | FPSR_AEXC_INEX;
         }
     }
     env->fpsr = fpsr;
-- 
2.43.0


