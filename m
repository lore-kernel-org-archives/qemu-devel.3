Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BCAAC0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:30:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht6Q-0007E4-GO; Tue, 11 Feb 2025 11:27:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5Y-0006To-R6
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:21 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5X-000388-4x
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:20 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-38dc0cd94a6so2764819f8f.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291177; x=1739895977; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=crXCHXq9JvpLBL04WHbV2f/eJJDZQDZc51amOdmF980=;
 b=HmoOJXUDKaU/yPAHszTQRF7hdFFDD4S1gxUnoZJ8qvxoYLg0dNvuyNhuULpNatBa0Z
 OpO/Rr52triztCisHEwRnWDFE7qTlSHB/WlBRM6bM/0+NEcPHUNqmFqdNP2RiDF1gYAb
 glMNjJoW86+mO5T1B4MpZrIfAiD8ZYgljRl2+W6FJyemJtg3OkQolNlsgahEMKSjLVcC
 1cu8xwbMWm1qITYdMWAfxUJeuXpo3OEvWvsy568zpcMKtOd7Z4FTpGp42SSFhwzkiFxY
 n8qj/O3+FvUW5GV+5UTvu4reNqGZ5TF9r+Sb2SeGfimi6NxTUGoBHJLmuUW1/cmfbLXi
 m8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291177; x=1739895977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=crXCHXq9JvpLBL04WHbV2f/eJJDZQDZc51amOdmF980=;
 b=rBd+rkLHCq80qdruPPY6sGl4mB1MsCyCgtRqXE3I4sR9wDnYC0F4Bv75unSdQxFGye
 V+UyUYUR7osjJ1TP/uQOQZ2wYCndIa6ro3h5mHp/S9/ilTib8QuEUlAclPdHStB7Jh+s
 QHHjnWJMhM8HXzgiv+YaYZthv5x/Bp9gxL1yuUpfpdcw8wmq5wcAhvKo+U2SxOQLDkeB
 gChSuw3bWvU1ciqqlY38ntk4SmGRu085FO8JyeYFF2+zwD1BeZNl7HnShsmF0ZeyIWHU
 8sRnfdWg+bm37xsG3nWNCpcHfS5xdcR7VI0jhPh5Pcjc5/7YucMmfRYFWUrC54L/bxJI
 tTEw==
X-Gm-Message-State: AOJu0YyvamtwUqjKS8EyR6QaBv1XGS7hTco3a/em+RfOaacBVprfX0WJ
 xY/hLt+qOu42PdCDokqzcbi0N4kiX3Y5TI2Fu8yYL5yLLrAvRXobroYAFGsXNFPvkTKK5t9IfOA
 w
X-Gm-Gg: ASbGnctnhsU4Ew2f9U5+kfd668o6yLmYzGFq3poVEKRObQoajbIKfl73Ufgp17uh1+k
 fj3nhtj6YAnlSf73BTqNeFDFcR2K5c2WUExI1lWCdGyeQ47QdQxcWp62L3grwU1wpzAPV4WufnH
 VL9Lsaw8TTIAbCIMA2X/lhSjc0rPQK0XncdJX35RqTYOzxPuJyVtFlq6acHPvuSciY2CSVRfM8H
 MsQgeEljXTAGGQZG0rwFbG8Fwwm8yhL3u38g9uAdhpE8ImA5l89SZqJldQxFzZF5cMWj2DjeiEW
 nPxfnEL01lhLVw0ihVvX
X-Google-Smtp-Source: AGHT+IHME1TiawMcf42zBKx1ZyEJe7ZzZpVGkN0rEfL2rqRcjuN0rSz56cW6XZO4wbu0fReG94046A==
X-Received: by 2002:a05:6000:1aca:b0:38d:df70:23e7 with SMTP id
 ffacd0b85a97d-38ddf7025a8mr5781543f8f.31.1739291177523; 
 Tue, 11 Feb 2025 08:26:17 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/68] target/arm: Handle FPCR.NEP in do_cvtf_scalar()
Date: Tue, 11 Feb 2025 16:25:05 +0000
Message-Id: <20250211162554.4135349-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

Handle FPCR.NEP in the operations handled by do_cvtf_scalar().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index a5f59a94ec2..804b6b5b67d 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8733,7 +8733,7 @@ static bool do_cvtf_scalar(DisasContext *s, MemOp esz, int rd, int shift,
         } else {
             gen_helper_vfp_uqtod(tcg_double, tcg_int, tcg_shift, tcg_fpstatus);
         }
-        write_fp_dreg(s, rd, tcg_double);
+        write_fp_dreg_merging(s, rd, rd, tcg_double);
         break;
 
     case MO_32:
@@ -8743,7 +8743,7 @@ static bool do_cvtf_scalar(DisasContext *s, MemOp esz, int rd, int shift,
         } else {
             gen_helper_vfp_uqtos(tcg_single, tcg_int, tcg_shift, tcg_fpstatus);
         }
-        write_fp_sreg(s, rd, tcg_single);
+        write_fp_sreg_merging(s, rd, rd, tcg_single);
         break;
 
     case MO_16:
@@ -8753,7 +8753,7 @@ static bool do_cvtf_scalar(DisasContext *s, MemOp esz, int rd, int shift,
         } else {
             gen_helper_vfp_uqtoh(tcg_single, tcg_int, tcg_shift, tcg_fpstatus);
         }
-        write_fp_sreg(s, rd, tcg_single);
+        write_fp_hreg_merging(s, rd, rd, tcg_single);
         break;
 
     default:
-- 
2.34.1


