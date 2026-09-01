Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF1CEC624D5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:18:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ON0-0000wS-CT; Tue, 01 Sep 2026 09:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1OMu-0000vV-WA
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:17:41 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1OMs-00076m-B3
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:17:39 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c250c6a6a9aso749265466b.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268656; x=1788873456; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AuvITvHbmN25u273hcimyVG9B2jeI5oleKMoM9/dBbs=;
 b=fh1Kth3jh9zpV6zYEaDcwevVRiRqZ9l8dpyEtqmcW07TojxpFmJsNqu8LmGI3D1E2X
 0NBh5FCbgzcq264e7NF45JbTr9cXiO/jdNYTztVmYyRIflM5Q52tgxdj2h9f4iz+c5nj
 eUVVUYukvlZEKreADHYl2QHFWIvEu1QgYo0RG3nIjLHUgVNuwAo/lsjatPFVRdLQ5iVT
 vrnVF/t10+LwfZiYex2U2B54Y4T5FKlwB53Dxxv+jtK4yOJczaF3gfovSDg3rjEAAICV
 7vXeOHnuXq1hyYrEV2Zg9oQqhivjwkaU7Y+FeMGyUxi9nmWoAQraNCKdZjVBUagwysmQ
 4Q1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268656; x=1788873456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=AuvITvHbmN25u273hcimyVG9B2jeI5oleKMoM9/dBbs=;
 b=Ho62SOZkoV5K2uC1W2ccMJv5KPEYk9CdvtGuix+eusSWT9iJFREQ32jkN4MIvYtbKa
 7iFAbKq4BxiUCg8gf8ohIXN5U1pUQV09uE6M/cyWwSE7FwX9/gJRFJSD8mx/K7vzKmog
 dgBO6ifYQrfplIrupQZE0Xm6cJolqAzdMDyXURpjylP1sucdv/4YkHv2KtW35mJgzWzI
 QGSZxs56jH+VTujH4sgx2AmBs62U+9Euodo/1aQYT3lEvtZPSMfX5y3boHpqD2a0CzYh
 yrxhOMRuwylHZE1kVXux8eYPAGwsJzl99nTNllXnMCNmZ83U+rpnw36puMdlvZ+Q6uN1
 Mttw==
X-Gm-Message-State: AFuF++kYByO53cX32K7dZJACzi7twfYFlbOw+M5WqkLkTxylkM4TLHm0
 YoQLCyKJochXUSvmLK3Lp6kRoZWtISR9qT6LhbhAKyUu2Hf8nz3jtJyr0u/1Izo4Tk+SmWSJ9vC
 0sQ2n6lc=
X-Gm-Gg: AR+sD10sZQjoeloE9OBkHB6YhlyBtgc0+Yg0URUSc9Mm8Fj2pC19BzRNQLTIrPgLWik
 HGjpKK5+fQJGrLS78Ll8/8ZxPEV+5VG2yRzml65/4UoZDVmz8sCLJqXWnr0Kg0nbUx6vcO2l6Mj
 DnwnYxL+0seUx+FHysHKM0LERb7VTywvgtnYd3abOhn+QRd7Bt4Wc5M+p7mdvfz84/Nz8SEAIZB
 eXu61AHuxPyYol2T1Ik2MTKWNQJ0tERNgTnj5oN2+XgnHDAJ96n9BfbsAvLXbZSiOxP5qw1JloJ
 csH/fKIWglms5aWGTVflC3xI2ir1SJBVy39DsQFhi01HOLFosr1eAlmuu3mNSKzjxcivj4OXRFZ
 1CinEs/M82KQc3+IVrIQdOiQ2xP4N41TjFxrALhZ4eCXCJk5KhyRKGlgHHryXp0IGjH5xgHy4Fh
 SUqhYEkBIVmwlJFYNfHKZ2hjrJoD9Nt5SZf54KPTACfFCcXBsX2n8BZAIcStzMpZq/VcojoGjSN
 dhDtiSJt3d3D8cTMrnIVd6XWhtII4e3fdcZJalRjTGu/SjoqqtRUM4EQgwnV1yAuGkrpw==
X-Received: by 2002:a17:907:9945:b0:c25:5fa5:dea4 with SMTP id
 a640c23a62f3a-c25b3b80cecmr422144966b.4.1788268656375; 
 Tue, 01 Sep 2026 06:17:36 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.17.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:17:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/58] target/arm: fix TTA instruction S bit for IDAU-exempt
 addresses
Date: Tue,  1 Sep 2026 14:16:36 +0100
Message-ID: <20260901131732.2263947-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x634.google.com
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

From: Alexandre Frey <alexandre.frey@nxp.com>

The TTA (Test Target Alternate Domain) instruction is specific to
ARMv8-M processors with the Security Extension (TrustZone). It allows
Secure code to query the security attributes and access permissions of
a memory address as seen from the Non-secure domain, and is typically
used by Secure code to validate pointers received from Non-secure
callers before dereferencing them.

The TTA instruction incorrectly reports the S bit (bit 22) of the
result register for IDAU-exempt addresses when executed from Secure
state.

According to the ARMv8-M Architecture Reference Manual (DDI0553B.z),
the TTResp() pseudocode (E2.1.408) always calls SecurityCheck() with
the current security state, regardless of the alt flag:

  sAttributes = SecurityCheck(address, FALSE, IsSecure());

The alt flag only affects which MPU bank is queried for the R/RW/MREGION
fields. It does not affect the SAU/IDAU security attribute lookup that
determines the S bit.

For an IDAU-exempt address, SecurityCheck() (E2.1.366) sets:

  result.ns = !isSecure;  // isSecure = current CPU security state

So TTA executed from Secure state on an IDAU-exempt address should
return S=1. This is confirmed by testing on real Cortex-M33 hardware.

QEMU currently passes targetsec (which is flipped to !env->v7m.secure
when alt=true) to v8m_security_lookup(), causing the IDAU-exempt path
to set sattrs->ns = TRUE and return S=0 instead.

Fix this by always passing the current security state to
v8m_security_lookup(), as the spec requires.

Cc: qemu-stable@nongnu.org
Fixes: 5158de241b0f ("target/arm: Implement TT instruction")
(the is_secure argument to v8m_security_lookup() was only added in
dbf2a71ad62b992 ("target/arm: Add is_secure parameter to
v8m_security_lookup"), but the code before that implicitly had the
equivalent bug.)
Signed-off-by: Alexandre Frey <alexandre.frey@nxp.com>
Message-id: ZR6PR04MB44238851A057F385D7EECEAD3599AE2@ZR6PR04MB442388.eurprd04.prod.outlook.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: added comment]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/m_helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index f4ba93b291b..33c9e7c55bc 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -2869,8 +2869,9 @@ uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_t addr, uint32_t op)
     }
 
     if (env->v7m.secure) {
+        /* Note that security check is done as Secure even if alt is true */
         v8m_security_lookup(env, addr, MMU_DATA_LOAD, mmu_idx,
-                            targetsec, &sattrs);
+                            env->v7m.secure, &sattrs);
         nsr = sattrs.ns && r;
         nsrw = sattrs.ns && rw;
     } else {
-- 
2.43.0


