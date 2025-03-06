Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B542BC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 16:00:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDVx-00059l-N0; Thu, 06 Mar 2025 10:52:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDVe-0004ZO-3C
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:51:42 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDVS-0006mO-S2
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:51:32 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-390f69f8083so792225f8f.0
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741276289; x=1741881089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Q/XxsDfHOS1Wk77anKxnWzNd9TMtmnv8t/Ha/8QCoUc=;
 b=rVjt2CuKUdiIILIowYcmfg1WSNe6qzM8rAJi3pJ0lLb7Y3Tl2ZWG3iX0GiV92KOoq5
 ZFvFjHzfJEahq4dldDwkKpbo68NZJ7zMjPGFGaRyx9DOF0vKY6r8pS6GEH60V3qcHBft
 M7Q8U+Juk6bv31Fy0FBPfKZZCfKAQ5DNzoRkA1zqrNYtOASuarEPNdP57qFsPtIwlQ/H
 npp2xP3eGeUHZksQQLcsO5fX2W3ns56WuxnX908Z5V8sQJDyTAUZgZyfIaB0EQ1QWtCi
 EqgkvtMtae9veSb1Ess3R1XdvYEvcSZhTGh1+x1sE9mWWJ+fQD4oCI0uOgUvCVj8eb72
 9KsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276289; x=1741881089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q/XxsDfHOS1Wk77anKxnWzNd9TMtmnv8t/Ha/8QCoUc=;
 b=QqFN9iPnTH6u7huIqDGyVM3+MWVpCUN+Sn0jlFAaBIvPif5d6auH9eUyuNoUonoDGp
 iUknY53+LcSPjXVLcKQTx0EZDLOoUshWtCf4zkw2QbW8ap0Rjh8gN2pTWYpHyHA0BrfH
 m/c2O6PbVVxynmwHmHy+WnXlRzIlAYhGLxKakyPRSkqgaw81sdaT3xoX3EMde2E7Vg8a
 k8EaHk6qvKUiCH9lwAPLk6jeeoEy7NCHfql87a27mNIZ9m9iNZizdDLuuBINmfdUrPB0
 LgORtgjZd1hKNftJLfXB7oZMccSVEimkjI9ENoHYqvPDGMay6KNgR5p//EHftL7nXFta
 7nsA==
X-Gm-Message-State: AOJu0YzZCcw5kHW8Ee9DmmWLBaNvpP4huZP/XZxNzrgVOF4hg6p0aAmd
 TkPZeumvFiJBIkcafDZG5A+lUOmv8T9O1nWeoh8dePCddsdBMfdd1KG6RdZ39fNi6pw08m2rf3k
 308w=
X-Gm-Gg: ASbGncthdanmPoVhs5ispT3zNUPsAogE9tKgeJ+K3itRfiOAYAYPToTDVQMjpsxbaGU
 OcPm1lozuQR09flQxlUViVpkJvRzFIjqYNCCisQvakQ1W86RRDvpdQ22d6WZOxcqNq8Kp/OwxqG
 wWVvCZqxM/Qf1OQ3IPVAYOPUIgsG8vKrEoWGI7p6uvGUkxO70wmDWZRUXLk5IqowlUTapKtV7v8
 l0TWjJDCUFvQdfqlpUj8nzcVbyUg+baycS2UD8esBoKMTm2N0EEi0/0H8nGVUHnivbcbedSSE/A
 UZ1XoTV/2Gzy3LC4G/c71yPUFHxtn8+MMZhY8cYiA8pQLUXvxZjMCK/ZysyEQW68uwO9cApGn2Y
 Mo/BKXsC641jG15RcwI4=
X-Google-Smtp-Source: AGHT+IGGNEqDa0CO5YNd8YzyxzegQ4aopm2urFOdqm7MPPMhG/1u0hidlTkpMaCoM1tqej1CNlMtaA==
X-Received: by 2002:a05:6000:156d:b0:391:22e2:cce1 with SMTP id
 ffacd0b85a97d-39122e2d0c7mr5474838f8f.42.1741276288822; 
 Thu, 06 Mar 2025 07:51:28 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c103f41sm2371624f8f.85.2025.03.06.07.51.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Mar 2025 07:51:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 51/54] target/alpha: Do not mix exception flags and FPCR bits
Date: Thu,  6 Mar 2025 16:47:33 +0100
Message-ID: <20250306154737.70886-52-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306154737.70886-1-philmd@linaro.org>
References: <20250306154737.70886-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

get_float_exception_flags() returns exception flags,
which are distinct from the FPCR bits used as error code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250211162604.83446-1-philmd@linaro.org>
---
 target/alpha/fpu_helper.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/target/alpha/fpu_helper.c b/target/alpha/fpu_helper.c
index f810a9b6a47..6aefb9b851a 100644
--- a/target/alpha/fpu_helper.c
+++ b/target/alpha/fpu_helper.c
@@ -455,29 +455,28 @@ static uint64_t do_cvttq(CPUAlphaState *env, uint64_t a, int roundmode)
 {
     float64 fa;
     int64_t ret;
-    uint32_t exc;
+    uint32_t exc = 0;
+    int flags;
 
     fa = t_to_float64(a);
     ret = float64_to_int64_modulo(fa, roundmode, &FP_STATUS);
 
-    exc = get_float_exception_flags(&FP_STATUS);
-    if (unlikely(exc)) {
+    flags = get_float_exception_flags(&FP_STATUS);
+    if (unlikely(flags)) {
         set_float_exception_flags(0, &FP_STATUS);
 
         /* We need to massage the resulting exceptions. */
-        if (exc & float_flag_invalid_cvti) {
+        if (flags & float_flag_invalid_cvti) {
             /* Overflow, either normal or infinity. */
             if (float64_is_infinity(fa)) {
                 exc = FPCR_INV;
             } else {
                 exc = FPCR_IOV | FPCR_INE;
             }
-        } else if (exc & float_flag_invalid) {
+        } else if (flags & float_flag_invalid) {
             exc = FPCR_INV;
-        } else if (exc & float_flag_inexact) {
+        } else if (flags & float_flag_inexact) {
             exc = FPCR_INE;
-        } else {
-            exc = 0;
         }
     }
     env->error_code = exc;
-- 
2.47.1


