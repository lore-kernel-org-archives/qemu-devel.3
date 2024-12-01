Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCD5D49773
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 15:14:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHlX2-0001W8-Jq; Sun, 01 Dec 2024 10:06:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlWz-0001TM-Ov
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:06:41 -0500
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlWy-0004Ia-4S
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:06:41 -0500
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5f1f81e51b1so1423173eaf.3
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 07:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733065599; x=1733670399; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oa8jCHWcHUduOv5ySi+C3ZNEUi60S76SFi2t2Jixe3U=;
 b=ooMvb3KqilpflaykpaWLKzzTXmYv9/rLTlxIo1Vl8wfOEEbZ/PXTH+IFb7+xKhOfRd
 JZbW9stHQcfmVnpELWzXBISlSLGEXNZZa1yyHlHr1PapRST/ib503j8KJRXn8a+o43+2
 hDASQcrBQ5cyYO9jK4+uSnuP6ixxX/Ku7JCBe2keMGDUaE1JQJ6tcFttk1NimeVRznt7
 f5eUjckn2tMRWcmmrxehkn16BMyS5QyEW4P9SIa86T5aLNW/kisjSbTnRX5PtVCY6e5x
 lOAZnpsx25OV9Ovaeine/OSZLTnZxc4gCnp6bdO+oev6OMdhTYm72ZEcu2uippBuWrN/
 v5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733065599; x=1733670399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Oa8jCHWcHUduOv5ySi+C3ZNEUi60S76SFi2t2Jixe3U=;
 b=fRFH3/ZDjdu40YQnL4pv4SP+hnpas8A+Kj5PiqTxiAZjZSViEO8/FG4m4xGTA3IjmD
 izivYp/cEr1Ny+9/QA9tgrGNDYgQYDljvf9yh43tpCko/uy1LJXmWdFVj/zgOjaKeo3T
 9CMLKyw+Wq0n0aaBlarN1BLnGJT/I9w7BLMkhd1gnpu1r46kuZ+211vtY0UuWtluAHiZ
 uCHCaPm+zisPLyWs7vw3yU3PKfnOwWIczHI1/Ya51/E7V+jT51cxR5WwBgXAgwL4cZsA
 ow6y7XXWfoRTkF54qykrJxx9IyfucziwYjTmxqgaiOz0MwuX+VcFhZxd1c30ufXDue4T
 I6ow==
X-Gm-Message-State: AOJu0YyBjpGkuQqk4swv0sf3kyEI36ci31PoMQBGjI7EaYYZa6PjRZzF
 3IISNiQrlizoLgv+UVgLm7zcnSutj6I/bUsgbcBh/WHsuLU2VnzMWtswzJ2OfDS5eg+lAO6SpWb
 Ul5Q=
X-Gm-Gg: ASbGncswn5LV8nMB3bDqrexvCMXHlZI81lXRncJs9nDrowBQo4s92WYbGqZ26D7XgkO
 ZaAQJqTWcSzad1VI2ONmodYrwILaNwwXz0u0HHZHcAWg1EJXBcu6bZ/DVGJVeTN7izGYSafQbNX
 +bA2m4dc8t4kMUU4t6lWFtRjPLpXbeBhOtizfVFWs0z5yTapy5Ndg9gNdecGlsAmjkCxyGXkQU2
 llKTmtJjpOCIwDy/MdWcQUBkpuJBlyiLkS5I2nigR9UVPczDbMhD0+ivIajNJmr6ExwWnXzKMBW
 hjKzCZPVClOynjSqyrVLv9NH2k95sl+6QYxg
X-Google-Smtp-Source: AGHT+IGCdewSCExyTvibmpMzeQHEUdpOYzum3VL6Kor+ZT1jXPgYRqOyqvpA9BD44ieuV4YDpT+3dA==
X-Received: by 2002:a05:6830:6a8d:b0:70f:7123:1f34 with SMTP id
 46e09a7af769-71d65d36c77mr14382124a34.30.1733065598991; 
 Sun, 01 Dec 2024 07:06:38 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d7254473asm1822220a34.27.2024.12.01.07.06.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:06:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 26/67] target/arm: Convert FSQRT (scalar) to decodetree
Date: Sun,  1 Dec 2024 09:05:25 -0600
Message-ID: <20241201150607.12812-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201150607.12812-1-richard.henderson@linaro.org>
References: <20241201150607.12812-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc32.google.com
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
 target/arm/tcg/translate-a64.c | 70 +++++++++++++++++++++++++++++-----
 target/arm/tcg/a64.decode      |  1 +
 2 files changed, 61 insertions(+), 10 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 4d945f2d5b..750db921cd 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8348,6 +8348,63 @@ static const FPScalar1Int f_scalar_fneg = {
 };
 TRANS(FNEG_s, do_fp1_scalar_int, a, &f_scalar_fneg)
 
+typedef struct FPScalar1 {
+    void (*gen_h)(TCGv_i32, TCGv_i32, TCGv_ptr);
+    void (*gen_s)(TCGv_i32, TCGv_i32, TCGv_ptr);
+    void (*gen_d)(TCGv_i64, TCGv_i64, TCGv_ptr);
+} FPScalar1;
+
+static bool do_fp1_scalar(DisasContext *s, arg_rr_e *a,
+                          const FPScalar1 *f, int rmode)
+{
+    TCGv_i32 tcg_rmode = NULL;
+    TCGv_ptr fpst;
+    TCGv_i64 t64;
+    TCGv_i32 t32;
+    int check = fp_access_check_scalar_hsd(s, a->esz);
+
+    if (check <= 0) {
+        return check == 0;
+    }
+
+    fpst = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
+    if (rmode >= 0) {
+        tcg_rmode = gen_set_rmode(rmode, fpst);
+    }
+
+    switch (a->esz) {
+    case MO_64:
+        t64 = read_fp_dreg(s, a->rn);
+        f->gen_d(t64, t64, fpst);
+        write_fp_dreg(s, a->rd, t64);
+        break;
+    case MO_32:
+        t32 = read_fp_sreg(s, a->rn);
+        f->gen_s(t32, t32, fpst);
+        write_fp_sreg(s, a->rd, t32);
+        break;
+    case MO_16:
+        t32 = read_fp_hreg(s, a->rn);
+        f->gen_h(t32, t32, fpst);
+        write_fp_sreg(s, a->rd, t32);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    if (rmode >= 0) {
+        gen_restore_rmode(tcg_rmode, fpst);
+    }
+    return true;
+}
+
+static const FPScalar1 f_scalar_fsqrt = {
+    gen_helper_vfp_sqrth,
+    gen_helper_vfp_sqrts,
+    gen_helper_vfp_sqrtd,
+};
+TRANS(FSQRT_s, do_fp1_scalar, a, &f_scalar_fsqrt, -1)
+
 /* Floating-point data-processing (1 source) - half precision */
 static void handle_fp_1src_half(DisasContext *s, int opcode, int rd, int rn)
 {
@@ -8356,10 +8413,6 @@ static void handle_fp_1src_half(DisasContext *s, int opcode, int rd, int rn)
     TCGv_i32 tcg_res = tcg_temp_new_i32();
 
     switch (opcode) {
-    case 0x3: /* FSQRT */
-        fpst = fpstatus_ptr(FPST_FPCR_F16);
-        gen_helper_vfp_sqrth(tcg_res, tcg_op, fpst);
-        break;
     case 0x8: /* FRINTN */
     case 0x9: /* FRINTP */
     case 0xa: /* FRINTM */
@@ -8386,6 +8439,7 @@ static void handle_fp_1src_half(DisasContext *s, int opcode, int rd, int rn)
     case 0x0: /* FMOV */
     case 0x1: /* FABS */
     case 0x2: /* FNEG */
+    case 0x3: /* FSQRT */
         g_assert_not_reached();
     }
 
@@ -8404,9 +8458,6 @@ static void handle_fp_1src_single(DisasContext *s, int opcode, int rd, int rn)
     tcg_res = tcg_temp_new_i32();
 
     switch (opcode) {
-    case 0x3: /* FSQRT */
-        gen_fpst = gen_helper_vfp_sqrts;
-        break;
     case 0x6: /* BFCVT */
         gen_fpst = gen_helper_bfcvt;
         break;
@@ -8442,6 +8493,7 @@ static void handle_fp_1src_single(DisasContext *s, int opcode, int rd, int rn)
     case 0x0: /* FMOV */
     case 0x1: /* FABS */
     case 0x2: /* FNEG */
+    case 0x3: /* FSQRT */
         g_assert_not_reached();
     }
 
@@ -8469,9 +8521,6 @@ static void handle_fp_1src_double(DisasContext *s, int opcode, int rd, int rn)
     tcg_res = tcg_temp_new_i64();
 
     switch (opcode) {
-    case 0x3: /* FSQRT */
-        gen_fpst = gen_helper_vfp_sqrtd;
-        break;
     case 0x8: /* FRINTN */
     case 0x9: /* FRINTP */
     case 0xa: /* FRINTM */
@@ -8504,6 +8553,7 @@ static void handle_fp_1src_double(DisasContext *s, int opcode, int rd, int rn)
     case 0x0: /* FMOV */
     case 0x1: /* FABS */
     case 0x2: /* FNEG */
+    case 0x3: /* FSQRT */
         g_assert_not_reached();
     }
 
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index fca64c63c3..9e5ea14683 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1327,6 +1327,7 @@ FMINV_s         0110 1110 10 11000 01111 10 ..... .....     @rr_q1e2
 FMOV_s          00011110 .. 1 000000 10000 ..... .....      @rr_hsd
 FABS_s          00011110 .. 1 000001 10000 ..... .....      @rr_hsd
 FNEG_s          00011110 .. 1 000010 10000 ..... .....      @rr_hsd
+FSQRT_s         00011110 .. 1 000011 10000 ..... .....      @rr_hsd
 
 # Floating-point Immediate
 
-- 
2.43.0


