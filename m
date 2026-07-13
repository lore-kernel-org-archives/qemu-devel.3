Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C30EAC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 15:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjIek-0000bY-Dz; Mon, 13 Jul 2026 11:33:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIeK-0008Ss-Ug
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:32:52 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIeI-00019G-0T
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:32:52 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-493bb510ce4so23509365e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 08:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783956768; x=1784561568; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K8ImuL8sE4fwwihfUxdtRBCshDkOb3mVVTN5ujtcTjk=;
 b=ggXzxRtBYf3eS6X8GkDSVuNrZUgzTjhQ2nBoXA6cFvGUNjx/EiMD3tXCREk/A4OKNE
 rS8v47fJQw8RV4BrzI5NGj77JmnALrcOPBFEDFa94Hvio38B9E/0crlBcHLk5sSBN0+Q
 ih+nUIpAm1abIyJ+W1D42s22NofXE87yhY26K9rz9auQww8Gv2a1qWXj47YFqte42BC2
 aULxrkLRrpcF7vybyrH6hJWykv9N0QVEBwBAPkzFXTuFV+fqqd2dqJxVw0E01qZH4rEE
 h2eTILxXVPkedkEKAkgmBcxx1gior1ScsgJnsW8j1MfDN87sI5EYUxlTwkMPIcT8YuKT
 MfgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783956768; x=1784561568;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=K8ImuL8sE4fwwihfUxdtRBCshDkOb3mVVTN5ujtcTjk=;
 b=fwcxHj5x5cnfPUAiFOdceOpGZJZjiWDFOwD16iPZXo3eMCOz59lxlJf7Fm7ribu9Ew
 0db84bxlZFMMApCcyJkGSBc+RZaVm8JISOcFTMsNH6N51fpw745dBERYLv3pPPbIpRac
 aS/L2geAK1GVSr2GwP1rjVsTyE2qbgj2jnzgulzAo7isus9cnmMXFfd/PjjySkP1wkZT
 R/3oj6IZAus0nQS5sWikySjvgDQsIj5o3iQWRF1FueZv6JF3hrqEym5LaU4O4ym9jRNW
 kfujILw11Pk75Qf6752H+4Mz3DB8BCcasY31O0mnR9U8aM4l0dErNJNT2Oghv6Q8/BCI
 Wkgg==
X-Gm-Message-State: AOJu0YzzfMFPyNyL/gjVCKvAYErYSRpf13ENMOFbpwvTWDppKP3fWpIp
 n2AF84regysSt1dXVrCJ2sv92dfNSqfaNFADrjXZbhEGIgZKpzgQu/rJMuVRnD6XFvsW6sY0IAS
 xQ8Ow42re8g==
X-Gm-Gg: AfdE7cmDwZeUqNK5rj/DILTVUahvbEvscrTa5FyeK098XrVrQIuDNXgy4RYLDpwp8kJ
 M/FFZvAmKM7PLy5X8wYt0DRmZPMjTqiD83P1BOQWbO+4gcrwSZYndS5VdZjTqBu3qet8F52qt2M
 SVcZjsLVUYRiRaYAfqGK9zqTNoKE//UF1iKKuIQR+ptQfaG6WRNZBAPcRsjqlhlx6XhgA3uhsf6
 5FDqsAIboDPpBedkcYoB7mG4kOdt0ichBLWSVWR26ySLszTGQPwmXbEa0daDKYxc7+FQGdbhzKr
 1wsFIVNZIt3Z9Y2f+wTtXkXMISfY3i1q5WVUvYvgSc3bMhejjV+Cl+V7vof7+ypyGXwEj8FUpDv
 SazMKYtXxcJl1JR6bN1aiqfOqwTbZWzT6I1A6t89hPtqwV+RLmNfWO49fJU1myrvnbbo8uGQcGI
 owF2KGcmWn/INlbu7peqph1OLZmA3isUxVMWEjAQma2Z3/a5kxCclbelrWO1PcSOSNxypLSIsag
 XFebtyaipESuk20ctWOcg==
X-Received: by 2002:a05:600c:c166:b0:493:f262:cc4c with SMTP id
 5b1f17b1804b1-493f881907amr98332225e9.23.1783956768215; 
 Mon, 13 Jul 2026 08:32:48 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508727f7dsm3825985e9.4.2026.07.13.08.32.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 08:32:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/26] docs/system: fix sorting of FEAT_S2[PIE|FWB]
Date: Mon, 13 Jul 2026 16:32:21 +0100
Message-ID: <20260713153233.3391818-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713153233.3391818-1-peter.maydell@linaro.org>
References: <20260713153233.3391818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260708145841.3032079-7-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 7806982e0d6..b4b65694ff5 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -160,8 +160,8 @@ the following architecture extensions:
 - FEAT_RNG_TRAP (Trapping support for RNDR/RNDRRS)
 - FEAT_RPRES (Increased precision of FRECPE and FRSQRTE)
 - FEAT_S1PIE (Stage 1 permission indirections)
-- FEAT_S2PIE (Stage 2 permission indirections)
 - FEAT_S2FWB (Stage 2 forced Write-Back)
+- FEAT_S2PIE (Stage 2 permission indirections)
 - FEAT_SB (Speculation Barrier)
 - FEAT_SCTLR2 (Extension to SCTLR_ELx)
 - FEAT_Secure (Support for Secure state)
-- 
2.43.0


