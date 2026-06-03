Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F6DCD6E6B
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 03:30:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUcIS-00077l-1j; Tue, 02 Jun 2026 23:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUcI8-0006ki-O6
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:29:20 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUcI6-0003hg-NE
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:29:16 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-8422871b42dso2080827b3a.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 20:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780457353; x=1781062153; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZvTdErfxKyM18jy4fYLJA8neNrcYEuEEmDnUu40A3Ns=;
 b=AeM+BCdXwQbzmN128vqLAqtA3ISvWJfx8vaHqE0vBWYYRl7A9cgDEnLvW6xYWB/pmb
 qX+6ez0DAyoeco30dohw0FHtGyqQCRce2KrDxrjoLyIp8xLEELRC0xou39hZc3hFMTfO
 +UotWle5C8Yes1R0zreKyprQCScFpftY2UG70pV/VApxXeaMNkfoIxJFKKuy0BoFfsiU
 +CnV2JeoAzRn73qBtJREa5ZbeTn54S6KfKnAxYiuLQHxjF8XHkpb9symOWQOUu4YOqFP
 DWIwUx4nYP22W7mq9W9xNyn9REb1TD8PFW5JfiqDwJebXx7ee+kZIgxU27RQ775IeZnu
 7qPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780457353; x=1781062153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZvTdErfxKyM18jy4fYLJA8neNrcYEuEEmDnUu40A3Ns=;
 b=EQ8rdoMsLg0XqfSV6n7g9TzjYoMEiGLS1DiNRLgA5i5zGr7lfoZrH8lajsrPZ6as4A
 MnxnbYKowZxn49ne56o8fkA93G6Y9u2jyfMoQjdFl5ZyQGndkLWhgsKatsDs8aYRRcJc
 B8z/IESLNyNz5bKGnrc4HKPRQhhusUfeW3djGe+BlMqaSAHngHN1kmQW3KNfLKfm/MbO
 +WFXcHF/D+PO8m4fguie31JqTeMDruqyWsAsRqMCxVBTHUSoaInh9kEI+pY2+fka5RG5
 03XUA8tGdvgpxwvfzf1kVRpJU06CBeh0HON4eqL7OgDCc6JutADtUmeWt0ZcHpOvM/ep
 ov6Q==
X-Gm-Message-State: AOJu0YxdfxwQKdWFqZyiY0IqN/8xoVilkD353Pe9o3W8fM0BGI7Xzm84
 hj1XGqAJsXEPW1ALYHC978KizOaoYl7gBDRh7o6oV2rX9XZR/WHViqRPCrkyfh2rlNo32Dq++Mt
 fm0uGScw=
X-Gm-Gg: Acq92OFErbDSlTOacwPxdb2rKf0T+aWS2kijzJjqu4iO6oRIh6IoNaonrgxr+cNqGa6
 Ge9Wf/2kslpTEgJxdg1l3IVQL9EPf+Ot3sduKAzl+uam6aKKY+WpYj8EfQDa8PkkVkIzItXgJjW
 M2fprQbe1qnrX3M6NDBpxUO8USnzjt0MhuGysv0wK7kDNRTQ/CuKyHKJJ3Zyq56RUxwcKg2JUos
 9erl0tLqY+dzc/bPg+CsHJ2+ze/V6B4nEzJcKI/jFKrJR3dF66y1Vd2o/EY2BoWEeuQesESH2YL
 Rt2WYaLUQpMqZIJvETLFmBW5QYu+A/zD/t+iHypMlK27Zqk+zko8XFRVRhuQ/PzfAaUDEApnEyd
 OwTtRGILKjC7vjh0sCNsMWfq5mxSh2dHPLDhNsbiB6SBdE5Da6u89bLLh+kNmIHYXWycgGXk0v5
 GI6Xyp0/zUdIH5IuX+LA91THn2tEEAp4oDv3YJ0Mk=
X-Received: by 2002:a05:6a00:2d29:b0:842:6c02:2fa3 with SMTP id
 d2e1a72fcca58-84284da7c66mr1526321b3a.15.1780457353288; 
 Tue, 02 Jun 2026 20:29:13 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8428222263dsm1477831b3a.2.2026.06.02.20.29.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 20:29:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v9 24/45] target/arm: Enable FEAT_FP8 for -cpu max
Date: Tue,  2 Jun 2026 20:28:33 -0700
Message-ID: <20260603032855.106930-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603032855.106930-1-richard.henderson@linaro.org>
References: <20260603032855.106930-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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
 linux-user/aarch64/elfload.c  | 3 +++
 target/arm/tcg/cpu64.c        | 6 ++++++
 docs/system/arm/emulation.rst | 1 +
 3 files changed, 10 insertions(+)

diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 5ed7a7badb..1c0c404b7c 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -222,6 +222,9 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
     GET_FEATURE_ID(aa64_faminmax, ARM_HWCAP2_A64_FAMINMAX);
     GET_FEATURE_ID(aa64_fpmr, ARM_HWCAP2_A64_FPMR);
     GET_FEATURE_ID(aa64_lut, ARM_HWCAP2_A64_LUT);
+    GET_FEATURE_ID(aa64_f8cvt, ARM_HWCAP2_A64_F8CVT |
+                               ARM_HWCAP2_A64_F8E4M3 |
+                               ARM_HWCAP2_A64_F8E5M2);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 39dc769a04..b48dd01a2c 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1392,6 +1392,12 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64SMFR0, FA64, 1);     /* FEAT_SME_FA64 */
     SET_IDREG(isar, ID_AA64SMFR0, t);
 
+    t = GET_IDREG(isar, ID_AA64FPFR0);
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8E5M2, 1);   /* FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8E4M3, 1);   /* FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8CVT, 1);    /* FEAT_FP8 */
+    SET_IDREG(isar, ID_AA64FPFR0, t);
+
     /* Replicate the same data to the 32-bit id registers.  */
     aa32_max_features(cpu);
 
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index dc20632097..470f7d891e 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -75,6 +75,7 @@ the following architecture extensions:
 - FEAT_FHM (Floating-point half-precision multiplication instructions)
 - FEAT_FP (Floating Point extensions)
 - FEAT_FP16 (Half-precision floating-point data processing)
+- FEAT_FP8 (FP8 convert instructions)
 - FEAT_FPAC (Faulting on AUT* instructions)
 - FEAT_FPACCOMBINE (Faulting on combined pointer authentication instructions)
 - FEAT_FPACC_SPEC (Speculative behavior of combined pointer authentication instructions)
-- 
2.43.0


