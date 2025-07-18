Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E97FAC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 17:44:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucp89-000867-Us; Fri, 18 Jul 2025 13:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ucov3-00055z-Uq
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 13:30:52 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ucov0-0000sa-Nt
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 13:30:49 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-451d54214adso17179825e9.3
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 10:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752859845; x=1753464645; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VTq6sdILRqpJUa4aACdnr1dXTMtMDz2K4P9Jj5bpG7E=;
 b=Cr1rBjbQOPdd0iMcCKRN8oEZlarmlzn7k232BHijLQBlBsBpTUdjMZjNkQy7F3TPbN
 Qs2vVNmaBcjJNO1Go+tUZwwy5m7c725j3rHb0Bof3oO+d119QECTCBh6ecfvDg2/unBe
 GA9kLqqktK7h2EEmwxpwWEht1sKk6K528Q7oAm1L/78KvqUBpNLwBQZHXm48Xp+IlTEN
 EmhrSKZU/v+bVI5qGvVopxXpsPdcLOBk47ahikYh9Q3W6QiRmrjNDVofdryD5sFDQv+l
 IC3NDq1Jxz5dvjDmNpUd4lt0earNkwfvcRZxyCHbFs2zYCFFZj9plB1hMN+ASZJ9TpuD
 o8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752859845; x=1753464645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VTq6sdILRqpJUa4aACdnr1dXTMtMDz2K4P9Jj5bpG7E=;
 b=YlnieUhdDGCheW1jy/s1AEb8YEWpAS8PCRzdC3jhQkoK/aXCuScDl+FxO/+MkVD/cL
 EWB5flvhhugKtGr14uFGThIOCScdazJjYWi1j2yzQPPo+4RkBIRyf2994iQDHZ4PS3E+
 Dv+1FVkrIVun0RvKV+RT1i/9zrbOF2ZWFmteHjyT5ZmnVSv0mRpP7CnfScjY/RCH2zUj
 tClpyIXqt8XC16rS2hTka3F3uVkaHlAN5Kaoe2D3ebbk0jg2PEst9e+eeWq9NM7+rKSZ
 rKP372X+TZPdQUAc5Ybq4cZTGFu0yhiGej8RBlDkQVR5f2j8bhyxMvnkSo6Cv4kS1Btt
 qHFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjf4k+UmfV53tNkOZricLMz+lvChWoBruQwbLZf3IeFZa+nbIE5Z8Y96Ymp00UxsJzuUZ/JJcSPdsX@nongnu.org
X-Gm-Message-State: AOJu0YwT00u5YxIN4kVfkkucVkSBvEYDFAx8dU45wQVYbzN9s722XgD7
 JB9AcDowA4SK0i5EjnJrIyvIB25VS0Yp0rznMvgtYR0gH4Sbn0xgpVGMPAKV58cFz38HsTuM50s
 lyZZd
X-Gm-Gg: ASbGncvsUcPx3ffRbxFiOqWFinpKdr6nhCDjl0MiezPVbQu2CoNyQp4DJmz7MzmGNjD
 jCCdqMFvKK0Imw9sHC2/zoJiQvSeCL9tJL+4uwKUB5NwPqFItm+gg6IZgk2oQgkBeWrTV69ptpF
 UYnuGxCPZZj5FSqngK+X/eB3SP8O0/Dew9wEX0FXcEhaY6CqSsIuMsRvSUb5vhpK2bKv/c82t11
 abLiIcOlZvMwX2GqHt3J0imgCDE6V4K4hsW+FTiIljfLIMbyRzJAyksxC06SeH1Tt4g3ujvnec6
 7ZLg+AGPDYM4dL8tAGJ1pbEaFN7EXrpDUn5GqWXTk6W7ksrGSf781PZg/nNMhHlzKIBVJ55myDU
 g71N196o7lb/KDKKA+WZvaHlp5pA2EzhwfmybzMQ=
X-Google-Smtp-Source: AGHT+IFgt7aZDHGjiKQDQO1pSNy326DvR33iyVj7kf8kRYd06fhb2TFbEm0B9AIQoF6bRuk1daRsSA==
X-Received: by 2002:a05:6000:230b:b0:3b6:333:256f with SMTP id
 ffacd0b85a97d-3b613eb49f0mr6272738f8f.58.1752859844744; 
 Fri, 18 Jul 2025 10:30:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca25443sm2454655f8f.9.2025.07.18.10.30.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 10:30:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH for-10.1 08/10] target/arm: Don't nest H() macro calls in SVE
 DO_REDUCE
Date: Fri, 18 Jul 2025 18:30:30 +0100
Message-ID: <20250718173032.2498900-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250718173032.2498900-1-peter.maydell@linaro.org>
References: <20250718173032.2498900-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

In the part of the SVE DO_REDUCE macro used by the SVE2p1 FMAXQV,
FMINQV, etc insns, we incorrectly applied the H() macro twice when
calculating an offset to add to the vn pointer.  This has no effect
on little-endian hosts but on big-endian hosts the two invocations
will cancel each other out and we will access the wrong part of the
array.

The "s * 16" part of the expression is already aligned, so we only
need to use the H macro on the "e". Correct the macro usage.

Fixes: 1de7ecfc12d05 ("target/arm: Implement FADDQV, F{MIN, MAX}{NM}QV for SVE2p1")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sve_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 105cc5dd122..bf894f0bf13 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4509,7 +4509,7 @@ void helper_sve2p1_##NAME##qv_##SUF(void *vd, void *vn, void *vg,     \
         TYPE data[ARM_MAX_VQ];                                        \
         for (unsigned s = 0; s < segments; s++) {                     \
             uint16_t pg = *(uint16_t *)(vg + H1_2(s * 2));            \
-            TYPE nn = *(TYPE *)(vn + H(s * 16 + H(e)));               \
+            TYPE nn = *(TYPE *)(vn + (s * 16 + H(e)));                \
             data[s] = (pg >> e) & 1 ? nn : IDENT;                     \
         }                                                             \
         *(TYPE *)(vd + H(e)) = FUNC##_reduce(data, status, segments); \
-- 
2.43.0


