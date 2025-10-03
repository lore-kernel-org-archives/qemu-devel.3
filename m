Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E63CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jKo-00063t-EP; Fri, 03 Oct 2025 13:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jIs-0002yq-Uz
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:10:56 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jGt-0006LK-Nk
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:10:45 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-33082c95fd0so2790113a91.1
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759511316; x=1760116116; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6099xIso0OFn4ttKkB5bkTTJ8lJK+Y0KaGWfua0ZG/Y=;
 b=yM+d17XAQxEdKAHk4aETETD2afLQtejDD6oX+mrEkO0Pkuke2q8H8ltA6A7wHhsZtp
 Jbc/kEB5Wk6TL0smCw53UkNaTjhxL4zGr2XTHHmfyXLHZapgfw63Q1AnNwMWzxbvsLcA
 UR/QKGpkDTgvIbtQXo0GZfgVk8fxhKMM56247Xdtv5KI/2mBoWowMA+Bv72PlRe6MJM0
 5yvmnapuFzFfgsaWNMj4BryFRguIQs7sbHT7+sXR6my0rpyMS7zF4mTcc5B+HgzjvNpE
 zjC0Y0lUTUELv00nT5ZRoxhDiON+aYg0irhkofQNt60Ytycdbi7i4uuJWl7Lv6UDwPip
 XqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759511316; x=1760116116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6099xIso0OFn4ttKkB5bkTTJ8lJK+Y0KaGWfua0ZG/Y=;
 b=USAWaCxBABq4j2NcEwyTwUitonzOgRDSHgfT+i17e6ff2Ncq6/v9D1NdAVILBNNhF0
 slwDRlnYqX2ke/Rxsz7xpGGvbEfmhcLd5sk2c58/DwgyyHz56MBmy5GR5lLx5T9HLsD8
 RnEsEuo3vYokEw6a2fEnCenjNP7Wuc1u2WMbcYq3BvFCffQRKjKyqlLv7is30+qAbah7
 GxxbuwQY9ob0dByzma+wEd27xtiSTRI5EoF7wcA66qrmtKF4KYeIiIVJdcXw81QSTsKX
 efOGbMziwbZZcsIfpfM7+7FzThltjOaoU6zjTLqLx6WRBVpEf5XFNfRELTlra2EQCyFJ
 zKSA==
X-Gm-Message-State: AOJu0Ywy9GHc6TGO9XFzsiaDKiZPoNHRYLWp3Rdsk/l1wULWxjCd2t8P
 PnnehWiwSFE7TqCQMCEQmGx3lLnUsY8So9QIjZVvELK8OIPkipKtlxp47iac6qcCAeGuHSSyc6F
 cykVSUsQ=
X-Gm-Gg: ASbGnctZxulJeBGsSSrEILsjUFQk7IZDyFNpsxkQZbgpsHV6quBucWqPypdMKQP7FMU
 Z3d8goLPniUvG06NEMWxHgOF2GOljwr81/etMSuF6Uls7kDEPOjY+zJXiojsCJee86+SCxJdp0s
 T9mn248WDQyzExW+GnYWmnYC7imj1gZeL1aaaxJ3VZv5qrii9FfBeB493Lw7u+sYl/TIV6RlTm1
 Z0dkRP0TZ4Qaj8leQTQ+9Sk/g1xOASCKl8SEzDJkden68NAREiCMgdzoBGsEyV4rvy6qkBqP+X4
 3GB6ezS+RK+uE8CRkxIflIyw1LK5qOr8hyhzGJ6affHbvEUYh9fe4+jJIcHX8N/4Ne6rjgCtTLB
 radlWUFgRJlzDGRys1U1/w4YyuJA2yjux8Q3M+Sq4EiJMCGONKMmcPkye
X-Google-Smtp-Source: AGHT+IGvV+/YWrcJOpkQF9gN2Klx+XnZynb+vF4fIa238yIbgG37PSESG3TYD9gXiIYywqtYwYB/VQ==
X-Received: by 2002:a17:903:1c9:b0:274:5030:2906 with SMTP id
 d9443c01a7336-28e9a6570fbmr46122925ad.46.1759511315672; 
 Fri, 03 Oct 2025 10:08:35 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d110d86sm55327115ad.6.2025.10.03.10.08.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 10:08:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v6 39/73] target/arm: Use arm_hcr_el2_nvx_eff in access_nv1
Date: Fri,  3 Oct 2025 10:07:26 -0700
Message-ID: <20251003170800.997167-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003170800.997167-1-richard.henderson@linaro.org>
References: <20251003170800.997167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 4d66143f46..b84cd3fbbd 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3427,7 +3427,7 @@ static CPAccessResult access_nv1(CPUARMState *env, const ARMCPRegInfo *ri,
                                  bool isread)
 {
     if (arm_current_el(env) == 1) {
-        uint64_t hcr_nv = arm_hcr_el2_eff(env) & (HCR_NV | HCR_NV1 | HCR_NV2);
+        uint64_t hcr_nv = arm_hcr_el2_nvx_eff(env);
 
         if (hcr_nv == (HCR_NV | HCR_NV1)) {
             return CP_ACCESS_TRAP_EL2;
-- 
2.43.0


