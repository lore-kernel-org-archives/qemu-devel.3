Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8164CC02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:34:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMcO-0005r8-TH; Fri, 24 Jan 2025 11:33:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYl-0004od-RU
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:32 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYk-0005eI-8Z
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:31 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4364a37a1d7so23483655e9.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736169; x=1738340969; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=e+vM7eVw9FNDbWBcJu93gLE5yRUZL1XievyTDuJkQaA=;
 b=pRNDCYwzUnEXJz/7dt5sl1nSNYD+bZh6w6ajXX9FeeDZ5W2mVzdKaxZWkXZ8AFCb5M
 KapDNIlTC+s1ukg01WMFgx1JLa01Izj1GY9SZ5BRYK+spJOImSNBYWdaAA134u+x5o6Z
 V7DiKvLjjmZPkmyJuZdutRgsVnx4bDUJRUOdLBsnkFflwU/F3pCxFJcIp0GO35PqEusx
 QvCzwq0JRZv0G8A+reA4n5HkMAqiPRDEL5WD1Np6SXzrV65mV8oxyDLlYvhmxeaq+OlO
 wAun5dAwlR+cS7O1ClXhJpjfoRMgSsNZPoda0xYF2HFrOa1wJbI3LMOzDdJm63gEnc1H
 5A5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736169; x=1738340969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e+vM7eVw9FNDbWBcJu93gLE5yRUZL1XievyTDuJkQaA=;
 b=bC5s8bO4x1FsGpd3pDEtbAGu4XOIS832OFdomZtQUC/eB3u+4oUOiVlj4aIIIWqVok
 eKmmwSKAX5IdxUR4mEnB340SSWs5qMOWvnudHHD4OUGSYS/z1/h7/v4UIyZoxFF9Z88P
 TAVeX5kS17m0Lf7eACOv0aW3WKFPJaCQdvn9Z68Gy22fqS7Oz9MHl/YJTdmP8hwGVrp3
 anMOwFPCllpL3eaIjgLf6ZKwt7MVbAPmv4ufEFmBNnUZn2truMVTrZJftAJMk4P6zUDE
 4KZZZr51XV4IA+UT0KOalKtFvv0Yix/+gmd5ztyE9raSg+SBi9rR3RFa0KXFD8Ckie3k
 G5rA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV141WyNHxal9KgyB3zMn2RreFftHnPOv9mH561v632gxpCDsBZ/hFOAEmF7YsPqRxni6M2EnhyteGC@nongnu.org
X-Gm-Message-State: AOJu0Ywj3MX6HfeDGi1ta2lYXIanKRgvr+HvydouUej23yi4Yo9BPX6O
 UJMrEcXmmJNJm1Mr7IvCNMA0ke96qbh03vikI57xTB7TS8Kib4Pj6A+aPqP2rrP00gdCCVGTPLj
 f
X-Gm-Gg: ASbGncumLVw7FBaNr8S1As+CU1eQrPKxGBV1hJLJISZRRlVMoocPYdlMKVcYriN2E44
 6NR5QkZdimnHCukzwYwTJxToARlKFMZOpDN3VRKD9EYYVzGx9Fk6vwsYMaGNGh/b5lsiOQzw4HC
 2/jVe86yJYsPlcU4h7X5xj1Tg5gYs0NZLP0F9FLRBqgug8eH7FaB2czuBd7D2ZKblcXwwD+8Vl2
 T8Pd1DLiGJA8jBFNQwYaUgYouur8My79/nSfioQ+RT/IEUsGecCK/1e6Zq3tP+Gt184b1RwWdnu
 6Sm1U7jnaB8=
X-Google-Smtp-Source: AGHT+IFyVnT0BgF7+jp5aUkVCdHG3hzarzWmRQ8+n35ar0RgaMdkAa6xH1R1JFPmQOFAE2hKOiHAxg==
X-Received: by 2002:a05:600c:83ce:b0:436:ed33:1535 with SMTP id
 5b1f17b1804b1-438913e0384mr307041865e9.12.1737736168902; 
 Fri, 24 Jan 2025 08:29:28 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.29.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:29:27 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 41/76] target/arm: Handle FPCR.NEP in do_cvtf_scalar()
Date: Fri, 24 Jan 2025 16:28:01 +0000
Message-Id: <20250124162836.2332150-42-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

Handle FPCR.NEP in the operations handled by do_cvtf_scalar().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 64994d3212f..6c20293961a 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8744,7 +8744,7 @@ static bool do_cvtf_scalar(DisasContext *s, MemOp esz, int rd, int shift,
         } else {
             gen_helper_vfp_uqtod(tcg_double, tcg_int, tcg_shift, tcg_fpstatus);
         }
-        write_fp_dreg(s, rd, tcg_double);
+        write_fp_dreg_merging(s, rd, rd, tcg_double);
         break;
 
     case MO_32:
@@ -8754,7 +8754,7 @@ static bool do_cvtf_scalar(DisasContext *s, MemOp esz, int rd, int shift,
         } else {
             gen_helper_vfp_uqtos(tcg_single, tcg_int, tcg_shift, tcg_fpstatus);
         }
-        write_fp_sreg(s, rd, tcg_single);
+        write_fp_sreg_merging(s, rd, rd, tcg_single);
         break;
 
     case MO_16:
@@ -8764,7 +8764,7 @@ static bool do_cvtf_scalar(DisasContext *s, MemOp esz, int rd, int shift,
         } else {
             gen_helper_vfp_uqtoh(tcg_single, tcg_int, tcg_shift, tcg_fpstatus);
         }
-        write_fp_sreg(s, rd, tcg_single);
+        write_fp_hreg_merging(s, rd, rd, tcg_single);
         break;
 
     default:
-- 
2.34.1


