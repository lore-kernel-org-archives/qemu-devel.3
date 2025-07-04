Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99537C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhN9-000790-Vz; Fri, 04 Jul 2025 10:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhIa-000642-U6
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:56 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhIZ-0006CU-5m
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:56 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-2da3c572a0bso856331fac.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751638914; x=1752243714; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WjUNsC/tPxG2dLETLc6CC9CFxkrBSGpmnmuEo26OYIY=;
 b=q1ZtL359je06Sw7GsPFHFNcJ7D5frtsfShP+A/qg3/CnTjhbsGdivRuKAaNd8yM0qR
 5dFc9sM/nbJUYnMhNIEYl8G5rXto6eSbRhsaVIF0qswgTp3VqPOq1Ga7AfW5E/c0xbu7
 PfR61dvdWKrUQQGTqkXDApexybK44YZGCvQU0XKzN2kTd4LRvNGjViCae+/uAPddKhWX
 mHgCPGH8JF80JpTJPce4CCewt6Cik3vFZ1QJnLRxjgavI1VnkLqFdR1hsyEsimrGehWq
 o1QSP9X10HKIc+hn2/UthyQRYL9LtWBBn15xiXhOoo3DUJDM96QrBJ7RW0Q8JRPofgH7
 zoCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751638914; x=1752243714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WjUNsC/tPxG2dLETLc6CC9CFxkrBSGpmnmuEo26OYIY=;
 b=mxLklFU9k5ukFFazbHM1rhC+kHz8VLZ4bUTs4Fd9DJjfwFJ5cNBV6RMJvNf8sUCgjJ
 baFuKxjwmg1guSeV+pgSdJrBtzDZ81iyKkJ4bv8VHVbED5CNxAVMNKBUMzbfEj2qW7Xi
 GQ+MTkiSi2Der39K9/X8QPGbVvXj252d7f9J6BKR3Ntg3/XafI7QNuoXWoX5NyaH9rKY
 x8ksHBYWI5kSTiuLsibadeI0Lo5VNezMcAtDmyS0wdI/3XmuckhYRQOYB7NRapYXxrR4
 Ks6amsWZIwAmyyGGsn3a8J6yVQjd51AuIdorXmyMGdIP/ziLcV1rtVT4afWSK69M7kkq
 7Rag==
X-Gm-Message-State: AOJu0Yx1gedA8INsY/SHcebFgLW1LVuXdSM4CyztngWgg3asghsiWLBY
 gpWYEircQL4f2ab13/KMOwnLnGVdsMpcdg++BZ+vtB3nh+U3vvCvAYBa5Uq8jW7J3YUS6qxE/rs
 dovRiNSQ=
X-Gm-Gg: ASbGnctsGezL5FqEJyNwwVvpLlAd5UfZPE03QxwAY9ueVcI40zSCViU4xhsN6gq0sYk
 NPLxdf9G+iBEAsoInDbZOuvFmLZNMaXjbIZo28Aq3k5cWOBUFCi40/5cWZIVYIJ8yKyqtiohjjc
 f6854ioBBzL3/LGVdemuCPrYZxEfokQLILfpX7DE7eznBMcG4svZgHRv+kwfE8wdeX758e72y2V
 M3XoAO0vGY5OPHZYQ7jcWGjdgvtjWCOPqNTKy/LWzXsgH4X5aaBtgVu+SiTBxYeA7F4262HxHZP
 wcN0LY6Scs1ytguz5Kn+qx6FcgIrJy+J3csicPLRWPJEVfeDZPtYvmhpwrdR/AQkm3G0cKZuNT6
 zFVCMJEULBqvtNWiqNTDyJ40PsaxttDFMx+boUFpZ6I4L8oHj
X-Google-Smtp-Source: AGHT+IFCDVO5NxKLg259/Yv9AzY9bTZpAmyfOg5nFNDPvKluQko6xxRQqJCz/V0YdGQVZNA9OTRJbw==
X-Received: by 2002:a05:6871:7c03:b0:2f7:5945:2d2b with SMTP id
 586e51a60fabf-2f796d04f4dmr1646472fac.34.1751638913595; 
 Fri, 04 Jul 2025 07:21:53 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff0471esm528016fac.3.2025.07.04.07.21.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:21:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 038/108] target/arm: Implement SME2 BFDOT
Date: Fri,  4 Jul 2025 08:20:01 -0600
Message-ID: <20250704142112.1018902-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sme.c | 17 +++++++++++++++++
 target/arm/tcg/sme.decode      |  9 +++++++++
 2 files changed, 26 insertions(+)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 761584c90b..965a49465e 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -921,3 +921,20 @@ static bool do_fdot_nx(DisasContext *s, arg_azx_n *a)
 }
 
 TRANS_FEAT(FDOT_nx, aa64_sme2, do_fdot_nx, a)
+
+static bool do_bfdot(DisasContext *s, arg_azz_n *a, bool multi)
+{
+    return do_azz_acc_fp(s, a->n, 1, a->rv, a->off, a->zn, a->zm, 0, 0,
+                         multi, FPST_ENV, gen_helper_gvec_bfdot);
+}
+
+TRANS_FEAT(BFDOT_n1, aa64_sme2, do_bfdot, a, false)
+TRANS_FEAT(BFDOT_nn, aa64_sme2, do_bfdot, a, true)
+
+static bool do_bfdot_nx(DisasContext *s, arg_azx_n *a)
+{
+    return do_azz_acc_fp(s, a->n, 1, a->rv, a->off, a->zn, a->zm, a->idx, 0,
+                         false, FPST_ENV, gen_helper_gvec_bfdot_idx);
+}
+
+TRANS_FEAT(BFDOT_nx, aa64_sme2, do_bfdot_nx, a)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index a2b93519c4..18e625605f 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -288,6 +288,9 @@ BFMLSL_n1       11000001 001 1 .... 0 .. 010 ..... 110 ..   @azz_nx1_o2x2 n=4
 FDOT_n1         11000001 001 0 .... 0 .. 100 ..... 00 ...   @azz_nx1_o3 n=2
 FDOT_n1         11000001 001 1 .... 0 .. 100 ..... 00 ...   @azz_nx1_o3 n=4
 
+BFDOT_n1        11000001 001 0 .... 0 .. 100 ..... 10 ...   @azz_nx1_o3 n=2
+BFDOT_n1        11000001 001 1 .... 0 .. 100 ..... 10 ...   @azz_nx1_o3 n=4
+
 ### SME2 Multi-vector Multiple Array Vectors
 
 %zn_ax2         6:4 !function=times_2
@@ -328,6 +331,9 @@ BFMLSL_nn       11000001 101 ...01 0 .. 010 ...00 110 ..    @azz_4x4_o2x2
 FDOT_nn         11000001 101 ....0 0 .. 100 ....0 00 ...    @azz_2x2_o3
 FDOT_nn         11000001 101 ...01 0 .. 100 ...00 00 ...    @azz_4x4_o3
 
+BFDOT_nn        11000001 101 ....0 0 .. 100 ....0 10 ...    @azz_2x2_o3
+BFDOT_nn        11000001 101 ...01 0 .. 100 ...00 10 ...    @azz_4x4_o3
+
 ### SME2 Multi-vector Indexed
 
 &azx_n          n off rv zn zm idx
@@ -365,3 +371,6 @@ BFMLSL_nx       11000001 1001 .... 1 .. 1 .. ...00 11 ...   @azx_4x1_o2x2
 
 FDOT_nx         11000001 0101 .... 0 .. 1 .. ....0 01 ...   @azx_2x1_i2_o3
 FDOT_nx         11000001 0101 .... 1 .. 1 .. ...00 01 ...   @azx_4x1_i2_o3
+
+BFDOT_nx        11000001 0101 .... 0 .. 1 .. ....0 11 ...   @azx_2x1_i2_o3
+BFDOT_nx        11000001 0101 .... 1 .. 1 .. ...00 11 ...   @azx_4x1_i2_o3
-- 
2.43.0


