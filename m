Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41BD3E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPiD-0003WR-AP; Wed, 11 Dec 2024 11:37:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPhe-00010w-UQ
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:36:47 -0500
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPhc-0002Hf-Of
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:36:46 -0500
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6d8edad9932so39772356d6.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733935004; x=1734539804; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SjNCXqWLXBfOyQBfYtoOK+ENmcPrhXIDdj2qnDqUAHQ=;
 b=usl+ykL0b0H3gXNpRaFT+o0+A682ynd/vguw8UhkwTuCSbJqENI+5Fme+8A7OfwVcq
 u1WipdWn/tIdZz7KruuQPWsZU91ELHEKcV/Dvp/8OgV7x9ihFokOMnX7OTCNw9r44zHM
 PANRdxogfESSJAUjhfpFYKsppsfoWV8x8/ItVGt5KVHW4/GJvYCMFel+JjDg8gMvkdqZ
 xdtkndZ/+fbniJvAleYcWEvXT59TDWOpiXguW+6Xo5dLV5UsTvMetIZhTi0+RMR3CSIP
 Nw7kICSflSKt3j3uVwfhYKNX+OV4yjVH5208rj9sz+BIxqjq3TdyDDA+7jia7dhU0yBC
 lyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733935004; x=1734539804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SjNCXqWLXBfOyQBfYtoOK+ENmcPrhXIDdj2qnDqUAHQ=;
 b=DWlZ2qgICSpwvcHtdKgIXrD3Cn9VZklJmAqey9P/MUI8weL/m6meWxtAZ7fnnpiWkh
 7mM8SCmh8qHW5wj/EgRlgGH6ppDnB4dDIxrs/XV+LmU8ByvLZDXiT5s1twOlSDh+hFbF
 WjZpG+WdMMtvwTb//c/v8+gfh3Us7vmXHH9JuICo/FdXnid8ZqauHZzsob5jAOLQhvNc
 rcwYfJW3WFWZfKeJCpQrQDiwTGs7DnJude66gVu2HFGbnkcTyypnPItjLHzMoN7YY7Qx
 ayeVbvP0dR9gNhRWXSBJbMeUAT6HeY2Iu6d6DoJGTUPVOkNZgK9DOryehn2GXZ5f2pAv
 TA6A==
X-Gm-Message-State: AOJu0YyJtd/3Cwm7sXAcRLD+05lAqxv/4/OvCVteDmAssTjEdxWc6L/0
 ZJZ48RjmmFgDXBmO1DyYBLFPqa2Rh+DqLihwZOJ/HuJxmxHtYvfXW5k3NX1vPWUma93Lj6N9tKj
 2EPe790kV
X-Gm-Gg: ASbGncsmvfnzBbBV8kOLx8tYTl1F473f+84vMD00XUW/C+7tClsZr3AayVrALZL8sOa
 fex2Ta/409Am1MoDOEyWBpWhyD7OAVAKj+IDGaZXVk9OSHOIgk2OCGXCrkjV3p2prM0lTRreZ5w
 udWbUmFnonFUvZOfycCukMGFHNxkfhBicdW/POZBMLEa0GbRx/DYSX80iDPbuR2dmMeAopc7Bih
 GTfVn+Dlyt+d/tURq1ZVjcDW1axcGGPyZ2fYwqRx69jx6ykB8toHo25/mahKg==
X-Google-Smtp-Source: AGHT+IHQPTJoyxPHM7VcoRepVuI7iCHH63Af0Esdu9e1stecRJ1tpOonL8xMU5hMHtjpu9w2RsgOaA==
X-Received: by 2002:a05:6214:21a2:b0:6d4:20fa:83f4 with SMTP id
 6a1803df08f44-6d934be9199mr49018926d6.48.1733935003822; 
 Wed, 11 Dec 2024 08:36:43 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da675214sm71856276d6.11.2024.12.11.08.36.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:36:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 59/69] target/arm: Convert [US]CVTF (vector,
 integer) scalar to decodetree
Date: Wed, 11 Dec 2024 10:30:26 -0600
Message-ID: <20241211163036.2297116-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211163036.2297116-1-richard.henderson@linaro.org>
References: <20241211163036.2297116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf2c.google.com
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
 target/arm/tcg/translate-a64.c | 35 ++++++++++++++++++++++++----------
 target/arm/tcg/a64.decode      |  6 ++++++
 2 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 894befef4d..6e9d040ebf 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8599,6 +8599,29 @@ static bool do_cvtf_g(DisasContext *s, arg_fcvt *a, bool is_signed)
 TRANS(SCVTF_g, do_cvtf_g, a, true)
 TRANS(UCVTF_g, do_cvtf_g, a, false)
 
+/*
+ * [US]CVTF (vector), scalar version.
+ * Which sounds weird, but really just means input from fp register
+ * instead of input from general register.  Input and output element
+ * size are always equal.
+ */
+static bool do_cvtf_f(DisasContext *s, arg_fcvt *a, bool is_signed)
+{
+    TCGv_i64 tcg_int;
+    int check = fp_access_check_scalar_hsd(s, a->esz);
+
+    if (check <= 0) {
+        return check == 0;
+    }
+
+    tcg_int = tcg_temp_new_i64();
+    read_vec_element(s, tcg_int, a->rn, 0, a->esz | (is_signed ? MO_SIGN : 0));
+    return do_cvtf_scalar(s, a->esz, a->rd, a->shift, tcg_int, is_signed);
+}
+
+TRANS(SCVTF_f, do_cvtf_f, a, true)
+TRANS(UCVTF_f, do_cvtf_f, a, false)
+
 static void do_fcvt_scalar(DisasContext *s, MemOp out, MemOp esz,
                            TCGv_i64 tcg_out, int shift, int rn,
                            ARMFPRounding rmode)
@@ -9838,16 +9861,6 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
         case 0x6d: /* FCMLE (zero) */
             handle_2misc_fcmp_zero(s, opcode, true, u, true, size, rn, rd);
             return;
-        case 0x1d: /* SCVTF */
-        case 0x5d: /* UCVTF */
-        {
-            bool is_signed = (opcode == 0x1d);
-            if (!fp_access_check(s)) {
-                return;
-            }
-            handle_simd_intfp_conv(s, rd, rn, 1, is_signed, 0, size);
-            return;
-        }
         case 0x3d: /* FRECPE */
         case 0x3f: /* FRECPX */
         case 0x7d: /* FRSQRTE */
@@ -9867,6 +9880,8 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
         case 0x1c: /* FCVTAS */
         case 0x5c: /* FCVTAU */
         case 0x56: /* FCVTXN, FCVTXN2 */
+        case 0x1d: /* SCVTF */
+        case 0x5d: /* UCVTF */
         default:
             unallocated_encoding(s);
             return;
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index f66f62da4f..146500d9c4 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1657,6 +1657,12 @@ FCVTXN_s        0111 1110 011 00001 01101 0 ..... .....     @rr_s
 @icvt_sd        . ....... .. ...... ...... rn:5 rd:5 \
                 &fcvt sf=0 esz=%esz_sd shift=0
 
+SCVTF_f         0101 1110 011 11001 11011 0 ..... .....     @icvt_h
+SCVTF_f         0101 1110 0.1 00001 11011 0 ..... .....     @icvt_sd
+
+UCVTF_f         0111 1110 011 11001 11011 0 ..... .....     @icvt_h
+UCVTF_f         0111 1110 0.1 00001 11011 0 ..... .....     @icvt_sd
+
 FCVTNS_f        0101 1110 011 11001 10101 0 ..... .....     @icvt_h
 FCVTNS_f        0101 1110 0.1 00001 10101 0 ..... .....     @icvt_sd
 FCVTNU_f        0111 1110 011 11001 10101 0 ..... .....     @icvt_h
-- 
2.43.0


