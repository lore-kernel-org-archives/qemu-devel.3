Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1447AC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 15:36:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjIef-0000Uh-8e; Mon, 13 Jul 2026 11:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIeO-0008UU-Tz
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:33:04 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIeM-0001AY-GL
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:32:56 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-493bc8fda98so454965e9.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 08:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783956772; x=1784561572; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ajrBT9nquBJGmemt6AIpUXqNFeuhFS97gkkTM0m0NeU=;
 b=pgj8ziM1r9MqibaT9NC/WYlJAS4Kj7QB+G+uBqTIrdUdFvTQ4KIuNeEpJTg++fCR91
 8CuHD5RI6o78J64RnN+dNKvLxQxJ2G1gpArbv4VNuC9cXyg6wiZD2aqtwS35BG5nrhlb
 pO2Ygm+iJH9q6dvi7VBRxEHF3aO5XLTsHrV7il5zsPyao5hHuXez+l4S9NfubbQBCDh+
 lvFoGXEVejimTnhALGZ4ygfG+Re6rnzYjnPXzkLdy9AOFC2cwxHPTPqWPOljUWeTcbfH
 SXF0Tj9dtfL+WYDbLcX6NPmXIsOi160E1K2OEIT00tkqjqjk2J+zEOEDaY6q4G2/rNO0
 zHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783956772; x=1784561572;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ajrBT9nquBJGmemt6AIpUXqNFeuhFS97gkkTM0m0NeU=;
 b=IqxWtYrgcg42m5OLzyGrdVQUYc+jOXy45Xt8KD+clvlkpjAdaIR66W9rwyEHeS2K7o
 8OXTdMn3SFbiU1lPmIc8BA7fSx20uoEHpDRNG6ATcSyEZbMgarysXAN6NNGtWtmtkKXt
 24ZfFYDGSu0bFte54N+UljAPOoV5QU6BCxglnEFnbSQ/qL5l/wRUDzsFSc1zCrQGGTaB
 dlf8zE6TsDMrrPIdWltIRXt8Sz+8jaq+fCPmEVjfUPrcp7xRidGdgfHWllFl6iKLL8Rs
 xlVqE+aFh2vVtX9P3c6yeiAu+t7KadgpuDj0mOWidzoOFi4qpYnhPS/RXlsTm/J8LKCz
 03bA==
X-Gm-Message-State: AOJu0YxdiIwuy9PBfT7kBe7B6m/Ui+cSzlBmlEt1Z7zFBJAKuo2IrtLR
 WTClTdbnIPH7jgy4LV/j/nIDqHYB/Bw4qg/LnVysT6wIKM0AYLRrTplsEVBMgBzMQoAoFj7NyS+
 /EuMShlT1Wg==
X-Gm-Gg: AfdE7cm18VJYBUvcFVGLWtlLzu4/GYNScHbpmFlrEuHthozb8IMhsPb2kCeHkbgIqUB
 KjpJv6UF41c2BXNts9AkjnlknGJ+hT0C2nrJcwdMGYvQTGWJVDRIWvBeYV3fs8djrZEsIEAnxfw
 OGhH9CfKc9rCyZ1if5fhOcspZrmyfpNsPMGHvHEAYUtYn3y0D4h8vp5mltN7c9KUGfKiL9YPMJi
 qGgAYgSFJWi07hJUilPvHAdSGM3qFtrKLdgHGh00NO1S7igD/VKEbRpuNSRREm/OQ4l6TStowYI
 A8yjxuYYysTRoZ0ztmRcg6pUHaoeiX/krpo7vURv8iMTRLslxhMuUByE/DhpyTgeqPMBtvvWN0s
 +LckZRlpPiO+iSuNOok62ZUFLF9Kl7dGADpQUpD0RH0UI0jwZ27z2XyzvBQic67wfVjn9Nd9FOU
 KbOGNDg4v62eNpemMz8g66I0j4Os51yWyaW/XqgdpMs2HlnvWvjXSMIp6V92LNGTTc2qLnJZliT
 HmCDlT2QBiDBz9GjMcv5Q==
X-Received: by 2002:a05:600c:1914:b0:492:7019:caca with SMTP id
 5b1f17b1804b1-493f882911fmr100644755e9.26.1783956771731; 
 Mon, 13 Jul 2026 08:32:51 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508727f7dsm3825985e9.4.2026.07.13.08.32.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 08:32:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/26] target/arm: Be more defensive for invalid
 tlbi_aa64_get_range
Date: Mon, 13 Jul 2026 16:32:25 +0100
Message-ID: <20260713153233.3391818-19-peter.maydell@linaro.org>
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

From: Richard Henderson <richard.henderson@linaro.org>

It's possible to program TCR_ELx with an invalid granule size,
which could match passing an invalid granule size to TLBI RVA,
which would then fall through to assert in arm_granule_bits.

Cc: qemu-stable@nongnu.org
Fixes: 3c003f7029e ("target/arm: Use ARMGranuleSize in ARMVAParameters")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260710175818.528974-1-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/tlb-insns.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/tlb-insns.c b/target/arm/tcg/tlb-insns.c
index 1a0a3325836..b24eb57788b 100644
--- a/target/arm/tcg/tlb-insns.c
+++ b/target/arm/tcg/tlb-insns.c
@@ -854,7 +854,7 @@ static TLBIRange tlbi_aa64_get_range(CPUARMState *env, ARMMMUIdx mmuidx,
     gran = tlbi_range_tg_to_gran_size(page_size_granule);
 
     /* The granule encoded in value must match the granule in use. */
-    if (gran != param.gran) {
+    if (gran != param.gran || gran == GranInvalid) {
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid tlbi page size granule %d\n",
                       page_size_granule);
         return ret;
-- 
2.43.0


