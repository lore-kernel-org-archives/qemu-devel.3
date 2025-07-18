Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45182C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 17:38:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucp2P-0002DT-8k; Fri, 18 Jul 2025 13:38:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ucov5-00056V-QC
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 13:30:52 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ucov3-0000tU-KJ
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 13:30:51 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-456108bf94bso16161345e9.0
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 10:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752859847; x=1753464647; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YaGSJlsr3yRCDJI1YrZClWcvDHAKT1kniD2vWA35Tqc=;
 b=MRH3GgUpWb4t77VnMbgKNxLv4GfXLfZjCWQFDHHYyV1jKi33YOLx6Yju66bExwmClk
 ev1xCHugSneV2PHhTN+oGu6KZ3iresA7toDOK0NxqTajD1HhRDm7pqme+JsvjJXSMckR
 YIlMlCK/70CsTwWL/PTKIiSbV4Sd/MK3ScxLBFhlvE9geKsiz5g/Yg0mUz3tSKkAKayA
 QyQRZIG8oPKRCavCRGBNtLE+LQq+JvH7XoinDrL6hGiM3Dx1tkofqR3kMWmDmkHhIPYs
 JowFApGRS9fBQGE8WBJD+uafJrV/U1JrOuxe5SsfmCfpG1JReeZqQFazngOJO5ovwVsk
 Y39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752859847; x=1753464647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YaGSJlsr3yRCDJI1YrZClWcvDHAKT1kniD2vWA35Tqc=;
 b=mAqBWc3Wsn724eurYzPzwE2xWS+ImCCYpgTECwLenb3bYVoRLORXVx+33UZ3vZWaOb
 tiUFIEjajj75zSOKA3T3zaxEa1jwusRaXn7AtpsMPKDjn2+vwVtGpv9s12WizB2/D9+7
 12A9P9qmUaZ4lP5jy/gAf4KKY+f4BOBwfp39yLmgzAu8HklBeC+Wkncum9QaqPuHd/QE
 MwVAkeAmduyuxSP9LaIjUHCcJIpsHzyyMSgh9VPCSRmEKRChxRtGZtGGp2Gy0IjKKT3M
 BY/QxxB0K0xZJJ5ICVQ+cRgkVMAoCSbcWn48GE95Y2yhVTp9M761F9bm6S3FvJj9dZFs
 fdsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJQHzS7yRw+xBavFb3ubCI8MJy5ocWdwN5RQSl+t2u5kkfi21Of4ywp7JDyWoavnPuVvI6vdYjQcVM@nongnu.org
X-Gm-Message-State: AOJu0YyMmZ01chMlDgTjh0eHqVTiFkmD3P9kjtZ/ioV9PUbmLQuJ39uL
 3q5/YbCLblCPhTvWTTZFPgcPf/RXMNasjHtQUWnOLKM9REFPjHPnvFFqfkdjwzxUU2g=
X-Gm-Gg: ASbGncuJ+lDRl4hLJ8kDr2hbxDbC4EJI6kC+uBAJa6wS3TEnYBTwed6km+7xUkZwur7
 mhlXiKZtqmFLhhScaIbuttdTHQx5S635CdrW7pXurU+Qx8/Z2WFRK+wBazdCkvdBsJ9O17GRsOt
 JhAaaCFlygbkJPJPK/PD5hyOdNwNrf5gktDKy1WHmyR4rrI+Zq0O+Jx269mE412tXANR40OV3t3
 RsqibU6M7U5RLLek0FhMBnpr5tHkSLdDbVCP0H6jpX+UFZFgJBsB/SiNJmG2BXnDpacsFzOEFrV
 g4p7fvO7EIElbiPwvzPkjWcwN2UDnxSkdt9s6yo2CKENturyk758UhGTff01v+K6dAvzEjBj/Gr
 b+HPyfweDrL/jR3190szbYZr55VHJ
X-Google-Smtp-Source: AGHT+IFMMA/UJESRWi1RVuZfqGsjIKXgDCpXcCDJ0EohkVo74Wsu52jpLiByalkjGRVqNYmkISC0dw==
X-Received: by 2002:a5d:5d10:0:b0:3a4:c8c1:aed8 with SMTP id
 ffacd0b85a97d-3b60e53eae9mr11528375f8f.39.1752859847186; 
 Fri, 18 Jul 2025 10:30:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca25443sm2454655f8f.9.2025.07.18.10.30.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 10:30:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH for-10.1 10/10] target/arm: Make LD1Q decode and trans fn
 agree about a->u
Date: Fri, 18 Jul 2025 18:30:32 +0100
Message-ID: <20250718173032.2498900-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250718173032.2498900-1-peter.maydell@linaro.org>
References: <20250718173032.2498900-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

For the LD1Q instruction (gather load of quadwords) we use the
LD1_zprz pattern with MO_128 elements.  At this element size there is
no signed vs unsigned distinction, and we only set the 'u' bit in the
arg_LD1_zprz struct because we share the code and decode struct with
smaller element sizes.

However, we set u=0 in the decode pattern line but then accidentally
asserted that it was 1 in the trans function.  Since our usual convention
is that the "default" is unsigned and we only mark operations as signed
when they really do need to extend, change the decode pattern line to
set u=1 to match the assert.

Fixes: d2aa9a804ee6 ("target/arm: Implement LD1Q, ST1Q for SVE2p1")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sve.decode | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index a77b725c876..aea7f519730 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1345,7 +1345,7 @@ LD1_zprz        1100010 11 1. ..... 11. ... ..... ..... \
 
 # LD1Q
 LD1_zprz        1100 0100 000 rm:5 101 pg:3 rn:5 rd:5 \
-                &rprr_gather_load u=0 ff=0 xs=2 esz=4 msz=4 scale=0
+                &rprr_gather_load u=1 ff=0 xs=2 esz=4 msz=4 scale=0
 
 # SVE 64-bit gather load (vector plus immediate)
 LD1_zpiz        1100010 .. 01 ..... 1.. ... ..... ..... \
-- 
2.43.0


