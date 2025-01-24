Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01565C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:43:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMbv-00031a-Uz; Fri, 24 Jan 2025 11:32:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYk-0004k8-Qz
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:30 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYi-0005dn-VW
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:30 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4364a37a1d7so23483485e9.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736167; x=1738340967; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Nm4fVPVn7klvhgQljpSjOnO06niRdClvbiI2p5tiBiU=;
 b=yfy+f6wiqmoxjA6Fi8mWB3GY4bvQtgjspvanO5kuTYeNjxFSmmkD6NzJ8KMqeJ4jB9
 iWAVc980Z0YcI3RNLe4OP00Q2E7dDC9xmvhnqz2kBnNmvV7DOlW6HTXTuuW5SRCFeJLJ
 o+Uj868okSIdi+PaXJXUqFWdmhNW6T8WiZ5kTLmWEMj5PFdzfhH84NeCRXcOQqGRp0Hb
 6GCl9RagWjt1PS4Mczf0Bulh4hIIn6ARggLu53u8II+L6zT3OLH45jd0MzRabNIwtBVN
 uloA+ERHB5HU4ynf8spnbDGnHLHxm23l8kBMYgTduSglSaRgO6MNQCwDImAOESAXPt9E
 OO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736167; x=1738340967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nm4fVPVn7klvhgQljpSjOnO06niRdClvbiI2p5tiBiU=;
 b=WDHTNegVXD8BC6HeNkKNtrb7aVAdbMHuwfRETrw8RJ7GM6X1D4BPriUnKrB2FOYwM/
 bywD/65zi/XiOVMn8gP5o+MuYIN8+vSUea22LafuHO7tbq5BmWpo+eVO3rk9Q71U1meo
 bqF12/YUI1RS9zqpFCwKDm+E/CGI9BblMNvmaBxvmzyNyYA47z7mDuU2iMEqV3tiW9xJ
 FWQdzUxLaSnAJaRb1nj3GVSgaPIqOrPzRf6LdZWnePnOq/HmQ+yvXwRy39o+eup2Q/ch
 6Me4HF9kcfwPrgGt47mKC+kRpeqxe0zCtn24iGHve1JgEq4/VI2Nv5k899w0li3LUMX/
 G7dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNE+zBMy1YZAJKPngK0BSGQXl+ETMr4N5x3XWp9FbdI5LLlvM7B31r9ajKJ/EUWOR+LkLplws6yXj4@nongnu.org
X-Gm-Message-State: AOJu0YyRISyIp4y3tsWsfr9gHUg4jvm56rUl5WYb6S4o8AfkvcCD0hyV
 zH7FvvOYvLDbpZSR9u3KBw584KFd18PoaWaj2vx+uBmhIy7XGzjUAcYo7MNs8t2nvVAH/8+sk0W
 V
X-Gm-Gg: ASbGncvoU6+sf7FbC9Axbm2IAwIjm8iHTNbz8TipqNeyWhMx8lQoVeujrhGK6Si41Ot
 8Meobl9ypxoj6UBKdifuJp/ZhnMKugV29mwLSP1O+LXyUaQUFGXGoA3IWcnXO53evKgBWwfAQJL
 V4ZTpW4l0EYL1VGAmcCqJjS/6OTpc/ph/WInGRUHPyCi4x6FrNsMb5qu2UA4hjwSU7ML7mXDE2/
 TAG+xsT5zwud/WyWr0jI8QQicPvE7bIvM/a7ooks57ASfiH7tKNNj47wagCla9WSkkLDiWyKHJX
 xxl6uB5lqlo=
X-Google-Smtp-Source: AGHT+IGj8+Vi16DhDUAtMMcSAEq9/itG8BZHsI9Xtkcfkjk67fTwIpNhmG6EaQt3pHmydD/2+X06Dg==
X-Received: by 2002:a05:600c:3b88:b0:436:488f:4d8 with SMTP id
 5b1f17b1804b1-438913cdba3mr344566975e9.11.1737736167464; 
 Fri, 24 Jan 2025 08:29:27 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.29.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:29:26 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 40/76] target/arm: Handle FPCR.NEP for 1-input scalar
 operations
Date: Fri, 24 Jan 2025 16:28:00 +0000
Message-Id: <20250124162836.2332150-41-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Handle FPCR.NEP for the 1-input scalar operations.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 944bdf8cafe..64994d3212f 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8520,17 +8520,17 @@ static bool do_fp1_scalar_with_fpsttype(DisasContext *s, arg_rr_e *a,
     case MO_64:
         t64 = read_fp_dreg(s, a->rn);
         f->gen_d(t64, t64, fpst);
-        write_fp_dreg(s, a->rd, t64);
+        write_fp_dreg_merging(s, a->rd, a->rd, t64);
         break;
     case MO_32:
         t32 = read_fp_sreg(s, a->rn);
         f->gen_s(t32, t32, fpst);
-        write_fp_sreg(s, a->rd, t32);
+        write_fp_sreg_merging(s, a->rd, a->rd, t32);
         break;
     case MO_16:
         t32 = read_fp_hreg(s, a->rn);
         f->gen_h(t32, t32, fpst);
-        write_fp_sreg(s, a->rd, t32);
+        write_fp_hreg_merging(s, a->rd, a->rd, t32);
         break;
     default:
         g_assert_not_reached();
@@ -8651,7 +8651,7 @@ static bool trans_FCVT_s_ds(DisasContext *s, arg_rr *a)
         TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR_A64);
 
         gen_helper_vfp_fcvtds(tcg_rd, tcg_rn, fpst);
-        write_fp_dreg(s, a->rd, tcg_rd);
+        write_fp_dreg_merging(s, a->rd, a->rd, tcg_rd);
     }
     return true;
 }
@@ -8664,8 +8664,8 @@ static bool trans_FCVT_s_hs(DisasContext *s, arg_rr *a)
         TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR_A64);
 
         gen_helper_vfp_fcvt_f32_to_f16(tmp, tmp, fpst, ahp);
-        /* write_fp_sreg is OK here because top half of result is zero */
-        write_fp_sreg(s, a->rd, tmp);
+        /* write_fp_hreg_merging is OK here because top half of result is zero */
+        write_fp_hreg_merging(s, a->rd, a->rd, tmp);
     }
     return true;
 }
@@ -8678,7 +8678,7 @@ static bool trans_FCVT_s_sd(DisasContext *s, arg_rr *a)
         TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR_A64);
 
         gen_helper_vfp_fcvtsd(tcg_rd, tcg_rn, fpst);
-        write_fp_sreg(s, a->rd, tcg_rd);
+        write_fp_sreg_merging(s, a->rd, a->rd, tcg_rd);
     }
     return true;
 }
@@ -8692,8 +8692,8 @@ static bool trans_FCVT_s_hd(DisasContext *s, arg_rr *a)
         TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR_A64);
 
         gen_helper_vfp_fcvt_f64_to_f16(tcg_rd, tcg_rn, fpst, ahp);
-        /* write_fp_sreg is OK here because top half of tcg_rd is zero */
-        write_fp_sreg(s, a->rd, tcg_rd);
+        /* write_fp_hreg_merging is OK here because top half of tcg_rd is zero */
+        write_fp_hreg_merging(s, a->rd, a->rd, tcg_rd);
     }
     return true;
 }
@@ -8707,7 +8707,7 @@ static bool trans_FCVT_s_sh(DisasContext *s, arg_rr *a)
         TCGv_i32 tcg_ahp = get_ahp_flag();
 
         gen_helper_vfp_fcvt_f16_to_f32(tcg_rd, tcg_rn, tcg_fpst, tcg_ahp);
-        write_fp_sreg(s, a->rd, tcg_rd);
+        write_fp_sreg_merging(s, a->rd, a->rd, tcg_rd);
     }
     return true;
 }
@@ -8721,7 +8721,7 @@ static bool trans_FCVT_s_dh(DisasContext *s, arg_rr *a)
         TCGv_i32 tcg_ahp = get_ahp_flag();
 
         gen_helper_vfp_fcvt_f16_to_f64(tcg_rd, tcg_rn, tcg_fpst, tcg_ahp);
-        write_fp_dreg(s, a->rd, tcg_rd);
+        write_fp_dreg_merging(s, a->rd, a->rd, tcg_rd);
     }
     return true;
 }
@@ -8969,7 +8969,9 @@ static bool do_fcvt_f(DisasContext *s, arg_fcvt *a,
     do_fcvt_scalar(s, a->esz | (is_signed ? MO_SIGN : 0),
                    a->esz, tcg_int, a->shift, a->rn, rmode);
 
-    clear_vec(s, a->rd);
+    if (!s->fpcr_nep) {
+        clear_vec(s, a->rd);
+    }
     write_vec_element(s, tcg_int, a->rd, 0, a->esz);
     return true;
 }
-- 
2.34.1


