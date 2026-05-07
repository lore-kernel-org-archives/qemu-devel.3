Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A096DCD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 23:46:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL8OQ-0000LL-0r; Thu, 07 May 2026 19:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8ON-0000Jl-L6
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:44:31 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8OM-00013Q-4Y
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:44:31 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7d4be94eeacso1508705a34.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 16:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778197469; x=1778802269; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XfEjDJlVu7LsFiNptc3UAEkKV/ApJAH3Ld019vvaP5k=;
 b=n6/KV6XpZ8K0fWEj+qch0vsWpg/JGw2qvEG39PPwfDigPEqTKmMT1DlotgYLakliOG
 1hTmoa8rtsYXQD9mnZ6ozDsuzKGS9fRp5OKoR0/WaSKH5t0LIZilvaV+nHtCPheSZTY5
 GCyO8s8pY3v3SNUMNF0+gFj0bV+vVdk4aGCgDpWuyfKzad1AXI+R2rWpaUBMZTGb5ffL
 FgumeGBXIdfXQXOOTpRiCdldm+EQG9TFnzNbt/X5Xc3JNuVG4LldBz5YUFsgd9Lv4v5+
 MLNt4h3awDpnLEbhCiiww9QK5cPUc/tux6kI4O/nr9QpnwtcVMTsXYoYxPQO5+EQG4hq
 MPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778197469; x=1778802269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XfEjDJlVu7LsFiNptc3UAEkKV/ApJAH3Ld019vvaP5k=;
 b=emmwgccZHQwYhrEl07v5U3JqQND1iRdC/z0U8lH3Uetr8Nafmu3eXZsxfvVSdVySBM
 zuFDdaJXP699nTntHGm6176t8R5LmA5HpE2UJEy4wbDmJxsFzfiiZ32zBzNVo5XpzSVl
 oIjBZt+fK2ul3ld68KqbJhxBdDja1RCdYDuurVkK+Bwsy0WRfB3k351HfBZVnbZYeOEl
 QYtWBzRgzhFsYQgOMyJ3m2Zj0bVIbYzihUgEodh71Jxd9DfyQwe6tmldkiOUvfACfwB6
 5TOz4Mbi5MDBDsNjyDSJu6/1ARNRjIZo+6zYvFCOwm5uE5xkOxzZ0XUkpKHVq54tPHCB
 8zoQ==
X-Gm-Message-State: AOJu0YxEZ/aXzCvI65okH13fMixHtSz/MYlFyexmqtGAWwydZJybvJ/V
 LTxIrr7dh7b7b0ozFbEvu+L+SmPu4ueblm0U27bWyr6FVklcuhpEE/XKiJICs3ISHmPd8a+rvoh
 nwYGC
X-Gm-Gg: AeBDieuOLKNrLaLTq79YjG42xVQLkaS4gqTxzgOjq0kpzu1ujS4cHymx+42LdSgY+yB
 nkUruB9CDG09kGE4qUMrXG+yhRakH4oa6xYlu1tRohyy9rn0WaKwNBggCQgbD7VPIMGP8/Nbugk
 +TXHrohZO92lyKl20yXoDpCAWRIovd0M6DWN0ch1hU0SO7ieNsyDY78RXPXCzBtyuaALMy3bIWu
 DcrueWoPhY60oCioMMOSfWBzJFQXea6feDPiD/gFBraoclRYEw/tQLsM+xQUKbN9+ZIk/aVb1PF
 J8i8OnocflS1uIB4FbDw716VeeC2sY2S8LqGNnKrZSjlbOrGM4g/xkE3jstJlu8OPJImKDA8AUs
 szJBBkD+b7bh2iPfaSI8zqps6Pi/H+conR4krCmSZ+QLVcRmNo2FoOHASEwrU0XRLsakToaKgH3
 gafbHDeB0roBobt9w73FS4x1Xqb8nauD3Vi+LhBGihma5apg==
X-Received: by 2002:a05:6830:44aa:b0:7d9:7209:4378 with SMTP id
 46e09a7af769-7e1df050633mr6154398a34.17.1778197468779; 
 Thu, 07 May 2026 16:44:28 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d8feb1sm84320a34.23.2026.05.07.16.44.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 16:44:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v4 15/60] target/arm: Enable FEAT_FPMR for -cpu max
Date: Thu,  7 May 2026 18:43:28 -0500
Message-ID: <20260507234413.643512-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507234413.643512-1-richard.henderson@linaro.org>
References: <20260507234413.643512-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32f.google.com
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
 target/arm/tcg/cpu64.c        | 4 ++++
 docs/system/arm/emulation.rst | 1 +
 2 files changed, 5 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index ff0c2b1c47..a377f67b9c 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1297,6 +1297,10 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64PFR1, GCS, 1);       /* FEAT_GCS */
     SET_IDREG(isar, ID_AA64PFR1, t);
 
+    t = GET_IDREG(isar, ID_AA64PFR2);
+    t = FIELD_DP64(t, ID_AA64PFR2, FPMR, 1);      /* FEAT_FPMR */
+    SET_IDREG(isar, ID_AA64PFR2, t);
+
     t = GET_IDREG(isar, ID_AA64MMFR0);
     t = FIELD_DP64(t, ID_AA64MMFR0, PARANGE, 6); /* FEAT_LPA: 52 bits */
     t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN16, 1);   /* 16k pages supported */
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index da5f7efce2..44c7196d09 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -77,6 +77,7 @@ the following architecture extensions:
 - FEAT_FPAC (Faulting on AUT* instructions)
 - FEAT_FPACCOMBINE (Faulting on combined pointer authentication instructions)
 - FEAT_FPACC_SPEC (Speculative behavior of combined pointer authentication instructions)
+- FEAT_FPMR (Floating-point mode register)
 - FEAT_FRINTTS (Floating-point to integer instructions)
 - FEAT_FlagM (Flag manipulation instructions v2)
 - FEAT_FlagM2 (Enhancements to flag manipulation instructions)
-- 
2.43.0


