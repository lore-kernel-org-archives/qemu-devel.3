Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8EDFCD98F0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 08:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa7zP-0005MP-9o; Thu, 18 Jun 2026 04:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wa7zG-0005IU-OE
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 04:20:34 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wa7zC-0006Ry-L3
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 04:20:34 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c074142cf6dso109106066b.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 01:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781770825; x=1782375625; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XSyoOJAmArybZ+UUMz0cxVFulqFQTyodQLZknSBN2HY=;
 b=cn7eofW4++QG5jIkaIYHdPgWwACPEshF/6z0ccbwFwo+fDqbrjmEmBCelEzW3Vn076
 SWAib9xvLm1RDWNYpG+b1+XLnFjKAfLqJlbWn1yIBr3VdxTElXAzlt4r8olmQIvQF46w
 MKuPWEb4vtIbif8EjoaeI91eD8rkVgLGHfp7u8Orfvk18iEkeskubM/v0MIRWbpidQ5C
 CuSb43UOCCpfV2le7nZiBkb13xVP3dxNYiZQ7UvcpCSky/urnNIpPPu0qr0mCChGuSRf
 JaxNfNDumNbY0mst0CKGbjRoEuqIEdOp58QCgGiQ823ZaZPi48pIdpyuw8usOxiJ8kin
 xECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781770825; x=1782375625;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XSyoOJAmArybZ+UUMz0cxVFulqFQTyodQLZknSBN2HY=;
 b=GQXPLwGaJ3iPwjruETGGQ2YeUe+nmkFrO35SVZd15w2Pkcwb2/lc1ivQfqBexeu4dZ
 ayUpyhW2vWsE2fVbZvvHP1tVsY5HewYzWDbEwi2CkyIUanW23tIrQTRxRIQxRwzOP5WD
 fgbBvZU1UlgEH74q9Aw96OMUEZcq5e/xPRhyWKFG12DIaJe/+XKkGr8T5p1341W66Pls
 F7HX7y90Ro0oTDZyDrallEe7GYDAFzGjC5pe5f0czLcShJFpbIV4rZ9whoOOgv8oA4H7
 +n0yZq9VIMyh/8FiHDRvZcwJjBdto+T3afJVnCCxz94d4QDyGaPxgXBrd/SF0OedndV0
 /WtA==
X-Gm-Message-State: AOJu0Yy3mDkDFvtiHMvO88uOq2MdSh3UJ89E6k2TAUBluj2hrUDHexIT
 wS2n+YtbICK5kRCm551TwPRwlMjGU9Zw8rTUZmpTdeTvsc3p8UnoUC+N9W0bjQEpwQI=
X-Gm-Gg: AfdE7ck6AfECnqk0kn8gmNGMmc53Q+cmv3d/+PjHq+SbfMXblTHgZjrIleIAs5kd0MZ
 5Vxzg5TfAG5oI29Ji7q2h5S4p8NYx83/9gEA0OneALqFxbSFDS5CDZZoG1rDxuLyTbX3Q4TtkEb
 tKDnY0+I9LKcBIzSx7jvl601Jm/Af/IwK9nhleifWG++LA8csBZKmvIGiDcL33jW9Y7dpYuYlz0
 jSq4PKGTwbNEvmtnDmjXh51S2VVRoqqTZY2Hv1258fVhjx+LjCbyPUpf32A1t5e4bM2Ew23OTrh
 4KYdIZtKuO7SVIqlH9DdAJu6plE5nYonCILYqRYlb/EZgvll+xqAA8oOdxKv3jhVby19aYd9fXw
 4ZyCNcFS2LwQVMPcMp2bN5OEnWtqvv3UGksyigVclcKLF5aDWAkg/dp01vObjVXDwEOWyhndI+O
 p3H0vq4MZqryYL88g=
X-Received: by 2002:a17:907:94d3:b0:bd3:7514:14f3 with SMTP id
 a640c23a62f3a-c0731268508mr127241566b.11.1781770825406; 
 Thu, 18 Jun 2026 01:20:25 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:a63e:e8c0:5950:f3f9])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfe7cc615b7sm854334166b.48.2026.06.18.01.20.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 01:20:25 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Thu, 18 Jun 2026 09:20:23 +0100
Subject: [PATCH 1/3] target/arm/tcg: Implement new instructions for FPRCVT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-jmac-fprcvt-v1-1-1b4475bacf51@linaro.org>
References: <20260618-jmac-fprcvt-v1-0-1b4475bacf51@linaro.org>
In-Reply-To: <20260618-jmac-fprcvt-v1-0-1b4475bacf51@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Jim MacArthur <jim.macarthur@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=jim.macarthur@linaro.org; helo=mail-ej1-x62c.google.com
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

Adds the opcode format for the SIMD versions of FCVTXX and [US]CVTF.
These use very similar logic to the FP-to-general and general-to-FP
register versions which exist, but use another SIMD/FP register
as source or destination. The source and destination size rules are
slightly different.

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 target/arm/tcg/a64.decode      | 15 ++++++++++
 target/arm/tcg/translate-a64.c | 66 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 28cd1faf61..5b6f156d08 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1456,6 +1456,21 @@ FCVTZU_g        . 0011110 .. 111001 000000 ..... .....  @icvt
 FCVTAS_g        . 0011110 .. 100100 000000 ..... .....  @icvt
 FCVTAU_g        . 0011110 .. 100101 000000 ..... .....  @icvt
 
+# Conversion between floating-point and integer (SIMD & FP)
+SCVTF_simd      . 0011110 .. 111100 000000 ..... .....  @icvt
+UCVTF_simd      . 0011110 .. 111101 000000 ..... .....  @icvt
+
+FCVTAS_g_simd   . 0011110 .. 111010 000000 ..... .....  @icvt
+FCVTAU_g_simd   . 0011110 .. 111011 000000 ..... .....  @icvt
+FCVTMS_g_simd   . 0011110 .. 110100 000000 ..... .....  @icvt
+FCVTMU_g_simd   . 0011110 .. 110101 000000 ..... .....  @icvt
+FCVTNS_g_simd   . 0011110 .. 101010 000000 ..... .....  @icvt
+FCVTNU_g_simd   . 0011110 .. 101011 000000 ..... .....  @icvt
+FCVTPS_g_simd   . 0011110 .. 110010 000000 ..... .....  @icvt
+FCVTPU_g_simd   . 0011110 .. 110011 000000 ..... .....  @icvt
+FCVTZS_g_simd   . 0011110 .. 110110 000000 ..... .....  @icvt
+FCVTZU_g_simd   . 0011110 .. 110111 000000 ..... .....  @icvt
+
 FJCVTZS         0 0011110 01 111110 000000 ..... .....  @rr
 
 FMOV_ws         0 0011110 00 100110 000000 ..... .....  @rr
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 227719ef25..4930846f5c 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -9904,6 +9904,33 @@ static bool do_cvtf_g(DisasContext *s, arg_fcvt *a, bool is_signed)
 TRANS(SCVTF_g, do_cvtf_g, a, true)
 TRANS(UCVTF_g, do_cvtf_g, a, false)
 
+/*
+ * [US]CVTF, scalar SIMD & FP version.
+ * Converts an integer value in a SIMD/FP register to a float
+ * in another FP register.
+ */
+static bool do_cvtf_simd(DisasContext *s, arg_fcvt *a, bool is_signed)
+{
+    TCGv_i64 tcg_int;
+    int check = fp_access_check_scalar_hsd(s, a->esz);
+
+    if (check <= 0) {
+        return check == 0;
+    }
+
+    tcg_int = tcg_temp_new_i64();
+    /*
+     * a->sf should specify source size (64 bit or 32 bit)
+     * a->esz specifies destination size
+     */
+    read_vec_element(s, tcg_int, a->rn, 0,
+                     (a->sf ? MO_64 : MO_32) | (is_signed ? MO_SIGN : 0));
+    return do_cvtf_scalar(s, a->esz, a->rd, 0, tcg_int, is_signed);
+}
+
+TRANS(SCVTF_simd, do_cvtf_simd, a, true)
+TRANS(UCVTF_simd, do_cvtf_simd, a, false)
+
 /*
  * [US]CVTF (vector), scalar version.
  * Which sounds weird, but really just means input from fp register
@@ -10044,6 +10071,34 @@ static bool do_fcvt_g(DisasContext *s, arg_fcvt *a,
     return true;
 }
 
+/*
+ * Floating point to int conversion, but puts the result
+ * in a SIMD register.
+ */
+static bool do_fcvt_simd(DisasContext *s, arg_fcvt *a,
+                      ARMFPRounding rmode, bool is_signed)
+{
+    TCGv_i64 tcg_int;
+    int check = fp_access_check_scalar_hsd(s, a->esz);
+
+    if (check <= 0) {
+        return check == 0;
+    }
+    /*
+     * a->sf should specify destination size (64 bit or 32 bit)
+     * a->esz specifies source size
+     */
+    tcg_int = tcg_temp_new_i64();
+    do_fcvt_scalar(s, (a->sf ? MO_64 : MO_32) | (is_signed ? MO_SIGN : 0),
+                   a->esz, tcg_int, a->shift, a->rn, rmode);
+
+    if (!s->fpcr_nep) {
+        clear_vec(s, a->rd);
+    }
+    write_vec_element(s, tcg_int, a->rd, 0, (a->sf ? MO_64 : MO_32));
+    return true;
+}
+
 TRANS(FCVTNS_g, do_fcvt_g, a, FPROUNDING_TIEEVEN, true)
 TRANS(FCVTNU_g, do_fcvt_g, a, FPROUNDING_TIEEVEN, false)
 TRANS(FCVTPS_g, do_fcvt_g, a, FPROUNDING_POSINF, true)
@@ -10055,6 +10110,17 @@ TRANS(FCVTZU_g, do_fcvt_g, a, FPROUNDING_ZERO, false)
 TRANS(FCVTAS_g, do_fcvt_g, a, FPROUNDING_TIEAWAY, true)
 TRANS(FCVTAU_g, do_fcvt_g, a, FPROUNDING_TIEAWAY, false)
 
+TRANS(FCVTNS_g_simd, do_fcvt_simd, a, FPROUNDING_TIEEVEN, true)
+TRANS(FCVTNU_g_simd, do_fcvt_simd, a, FPROUNDING_TIEEVEN, false)
+TRANS(FCVTPS_g_simd, do_fcvt_simd, a, FPROUNDING_POSINF, true)
+TRANS(FCVTPU_g_simd, do_fcvt_simd, a, FPROUNDING_POSINF, false)
+TRANS(FCVTMS_g_simd, do_fcvt_simd, a, FPROUNDING_NEGINF, true)
+TRANS(FCVTMU_g_simd, do_fcvt_simd, a, FPROUNDING_NEGINF, false)
+TRANS(FCVTZS_g_simd, do_fcvt_simd, a, FPROUNDING_ZERO, true)
+TRANS(FCVTZU_g_simd, do_fcvt_simd, a, FPROUNDING_ZERO, false)
+TRANS(FCVTAS_g_simd, do_fcvt_simd, a, FPROUNDING_TIEAWAY, true)
+TRANS(FCVTAU_g_simd, do_fcvt_simd, a, FPROUNDING_TIEAWAY, false)
+
 /*
  * FCVT* (vector), scalar version.
  * Which sounds weird, but really just means output to fp register

-- 
2.43.0


