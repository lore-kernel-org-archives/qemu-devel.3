Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C438C0218A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGY0-000689-NE; Sat, 01 Feb 2025 11:40:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGXy-00066Y-Sj
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:40:43 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGXx-00017E-Fa
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:40:42 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-436326dcb1cso20686515e9.0
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428039; x=1739032839; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=j+IEg0CkEoamQo7lN9mBa6LGDBjZtlXQ5vioOX8GKig=;
 b=BX+sf3YN2FCCkxVcVAf+qTTHZIVJeKHqvWVMixMArhLhrB+umGu86Jkn4QZ7x/VfRA
 dlpqzAr8PbeYRvE9CjI8aGYq9UcARJTUQtbf8QG2jYDN/wrZcSrRxbtv6NHqWg7wmPi9
 ioqhdDe6F4HmnbO9PMv9A4c30nqR2RsNrSFYsnv+LnMg+pY59CeZy2s8CziN26IFyLXb
 KNAW4Ov3NfR3xhnpTzNQG2rXHL93Y+o3x7f9C8iNy7EpSJ+YwYO4SvEcpOZ/M6zgntrW
 /2HUTVWZ1lUohv4w1ERZV12gGNPzWgRaywxohOJIFfzA1+hdXT8dWBXvJbGsw96ETcbq
 /pAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428039; x=1739032839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j+IEg0CkEoamQo7lN9mBa6LGDBjZtlXQ5vioOX8GKig=;
 b=UhaEfzediCO29E3+fXVjmwtAkm59JRbRM+j4P46Qz1ABi3qG9ehPRRUc2mjo9GI8u8
 jVfci7MtseZg+O8kdtFGAo7fzTwN8IS/6mMD/X346ZHDZ9epvYBLy9rdxzV26BLmKyZq
 5PhVXA9+tBlqkp7w9r0i+OXXqHeCpb5x49KjQvi4Ek6TVpFmEI7uFs/OImF9GpvumQy2
 zOBmw++bB1e+vl97zci2P5BFeXguHjdTmOeD1agaaGBjYX4KUkiIKwBbY0Tq6uYbk8Av
 zZsHXWmlUQx1ZWvANoujtH+SxUcg2BcMecfyewBzB1alRudwvSD9dRDQlTPeWEDHlXVb
 2EKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVddvNZRc225+KEhvXbV+gM7KtKcyIlthDMfeD3qvnBfE2npamBqWD8KnjjBRWvXz7bnnjbTE27FNIu@nongnu.org
X-Gm-Message-State: AOJu0YwQzM8SSeKV6s6PP1AjsNu65voBLAK5SVv60D7VtcAHJrQs+G3I
 tlA2oj2ij3zWJAtepHHY3lIei8GADSoC/KSyZ+TItiW/W5usAw0+Y/lUulnl+gg=
X-Gm-Gg: ASbGncuPCC2nRdOm4fKEXxXvkfGEBEGGB3psrL40LJsJJip34t6gUFzXxnIvDXpsnZ2
 IompSovGvEhNSXe5nMznCKdhEBUtFJLo9F1Xr4ctybqkge3+vs0kNuA4CoToCR6tnei6EXvaMha
 WDIK52vQLJ8sSJum5bt2M5aq4zYqTaw8DWHrpxzmzsfLI9ZZTsMprXqOAZ6xULznuVNCO7DUD8V
 7enSPtw2yAwBB+Z51PNtwfjlDvrksOG2kQ1V7ZkR4fzY7RYBWNmqyQD7rajCDAs3D7R/HGSxxg3
 1QNmFvAwzKTIdHvASaqM
X-Google-Smtp-Source: AGHT+IGXDARwFsl9jpNIbeKqvYJA1zgsxYsmCtQhMRTN64Lg7gkTUML+6LS9pJJVgHobiU+7Yh1c5g==
X-Received: by 2002:a7b:c3cd:0:b0:438:e231:d342 with SMTP id
 5b1f17b1804b1-438e231d503mr78993105e9.1.1738428038991; 
 Sat, 01 Feb 2025 08:40:38 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.40.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:40:37 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 17/69] target/arm: Handle FPCR.NEP for 3-input scalar
 operations
Date: Sat,  1 Feb 2025 16:39:20 +0000
Message-Id: <20250201164012.1660228-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201164012.1660228-1-peter.maydell@linaro.org>
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

Handle FPCR.NEP for the 3-input scalar operations which use
do_fmla_scalar_idx() and do_fmadd(), by making them call the
appropriate write_fp_*reg_merging() functions.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index e45d96763fd..96696c342a9 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6356,7 +6356,7 @@ static bool do_fmla_scalar_idx(DisasContext *s, arg_rrx_e *a, bool neg)
                 gen_vfp_negd(t1, t1);
             }
             gen_helper_vfp_muladdd(t0, t1, t2, t0, fpstatus_ptr(FPST_A64));
-            write_fp_dreg(s, a->rd, t0);
+            write_fp_dreg_merging(s, a->rd, a->rd, t0);
         }
         break;
     case MO_32:
@@ -6370,7 +6370,7 @@ static bool do_fmla_scalar_idx(DisasContext *s, arg_rrx_e *a, bool neg)
                 gen_vfp_negs(t1, t1);
             }
             gen_helper_vfp_muladds(t0, t1, t2, t0, fpstatus_ptr(FPST_A64));
-            write_fp_sreg(s, a->rd, t0);
+            write_fp_sreg_merging(s, a->rd, a->rd, t0);
         }
         break;
     case MO_16:
@@ -6388,7 +6388,7 @@ static bool do_fmla_scalar_idx(DisasContext *s, arg_rrx_e *a, bool neg)
             }
             gen_helper_advsimd_muladdh(t0, t1, t2, t0,
                                        fpstatus_ptr(FPST_A64_F16));
-            write_fp_sreg(s, a->rd, t0);
+            write_fp_hreg_merging(s, a->rd, a->rd, t0);
         }
         break;
     default:
@@ -6867,7 +6867,7 @@ static bool do_fmadd(DisasContext *s, arg_rrrr_e *a, bool neg_a, bool neg_n)
             }
             fpst = fpstatus_ptr(FPST_A64);
             gen_helper_vfp_muladdd(ta, tn, tm, ta, fpst);
-            write_fp_dreg(s, a->rd, ta);
+            write_fp_dreg_merging(s, a->rd, a->ra, ta);
         }
         break;
 
@@ -6885,7 +6885,7 @@ static bool do_fmadd(DisasContext *s, arg_rrrr_e *a, bool neg_a, bool neg_n)
             }
             fpst = fpstatus_ptr(FPST_A64);
             gen_helper_vfp_muladds(ta, tn, tm, ta, fpst);
-            write_fp_sreg(s, a->rd, ta);
+            write_fp_sreg_merging(s, a->rd, a->ra, ta);
         }
         break;
 
@@ -6906,7 +6906,7 @@ static bool do_fmadd(DisasContext *s, arg_rrrr_e *a, bool neg_a, bool neg_n)
             }
             fpst = fpstatus_ptr(FPST_A64_F16);
             gen_helper_advsimd_muladdh(ta, tn, tm, ta, fpst);
-            write_fp_sreg(s, a->rd, ta);
+            write_fp_hreg_merging(s, a->rd, a->ra, ta);
         }
         break;
 
-- 
2.34.1


