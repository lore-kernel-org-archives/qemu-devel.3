Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCAAAC35FF3
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 21:34:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tueZF-0002NJ-48; Tue, 18 Mar 2025 17:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueY3-0001J7-8l
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:31 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueXz-0000mc-Dl
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:30 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22438c356c8so107498965ad.1
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 14:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742333546; x=1742938346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hSTxcdVupVH5RULwmr3LUReRVWUe6351QoWFFPPNbok=;
 b=ugzD6i+cpM32xiAybeIElbec0YrnTo4BvFe/QyRACSjmtjueHeUecfRBJ9fyNAMzjn
 sS29xKovGHTvRtPmV+2DfPu1JiAWUmwDnCfhW7gQ84ERhevqNl74DXcR4dUjQXvzTcIF
 t39b0eAJ8GI3URriQI9Nm564Ha07kdD6CvUVv/z6xFrqJkngF4hTUB2kCNbNDmhkMRpN
 mzFUIlM/Vu+72yUJmi6wKxmC6ouR/4okJ2aMX8dUNU4cU3aFiPAQx6jeRkumKbWn+7iN
 5URmIP2iXuyH9mmxEeoDS/YZ8s2Mh2bU8Nrnj4Qo9YV7rVbJCm7h2yLqmGe1FkAqt4/9
 lD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742333546; x=1742938346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hSTxcdVupVH5RULwmr3LUReRVWUe6351QoWFFPPNbok=;
 b=mIRNMvDZcJ35W9RVmjlZ7uKRwGt+hJvGHW1RHODrghh4XVO6n12bFwnscEf0Szrn2j
 6IH2xFEoQKPKR7uGpvrFIQ1sNksmJ7Wfzi25SlDnS/a+LEZBy7ihDrDjYcAEQ0d+/wAa
 IiEhuzHCdXBrh7yn78m8JtCiccO0KLiv4NEu5yuCdEDNRDei9HBd9SEYP8UuftTpFB8G
 P/cBEEn09NzVH+7uvJNEOxZc10+8mGgnIQGE2xyrO3VIS8lYraPitzZjT5g230HMnJCp
 lULpzi19xckGF6zEktaqdPXPP9LklKvhtNuDCW9TyQOg0qyDXsej/gnqmebrliScSDvI
 TGqg==
X-Gm-Message-State: AOJu0Yxh4FWz7f2TA3BDJOJpi3ePFI8MuFpNGStDoKHKriDs3iJ1EZVY
 GrSYM+38oO5eGP9qjqiG+2OFT4jAyJIOeKH7Z5gejIsSTnVRviLTDSXJCJzgMKenfc6nMouFUj7
 9
X-Gm-Gg: ASbGncs+blMaUHVl5aqf9K8SZ/hYx4mUtyzVic23J+bHYLvH5G8qT5l4Qyu4K9YUjFS
 rcAYKw7gN/yCu4dasKYA4rtzOf6WB8sMU9Y9a5/7ZeJwdFXG8DpPlF/GIHNxBcMtkYiDqza/aot
 kPyi3EpIWQXVuxgHq9E7RYYv0tR3+3wYia20X0frUypcOOJILWe6TUahful+Kx8x1QeNxKmdWxk
 /w8GkuSrs2pnm4XwtJQI5RwE64p3QKzqW9Z6yRBEVxdSRoHhjTKaUAp6fVdn7C7+iIV3eg15ujt
 BhABdLnI1DMd0Ggp9vv6JiV2KoazkXvaoDHHBymz9FLRclsrZJVe1X8Kt2frRbrWXnKcHLGeuJX
 C
X-Google-Smtp-Source: AGHT+IHKWmLNanCqBOzd8s3+cgtQd5OViDbSAeF52zsXDWqCnQJJ+N7kGnw3LxhNFI8xOvSjyXcKlA==
X-Received: by 2002:a05:6a21:33a5:b0:1f5:8655:3282 with SMTP id
 adf61e73a8af0-1fbed503dcemr233053637.42.1742333545878; 
 Tue, 18 Mar 2025 14:32:25 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9ddf4fsm9473854a12.21.2025.03.18.14.32.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 14:32:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 21/42] accel/tcg: Remove unnecesary inclusion of
 memory-internal.h in cputlb.c
Date: Tue, 18 Mar 2025 14:31:46 -0700
Message-ID: <20250318213209.2579218-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318213209.2579218-1-richard.henderson@linaro.org>
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

At some point cputlb.c stopped depending on the
"exec/memory-internal.h" header. Clean that now.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250317161329.40300-2-philmd@linaro.org>
---
 accel/tcg/cputlb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 134e523cab..613f919fff 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -26,7 +26,6 @@
 #include "exec/cpu_ldst.h"
 #include "exec/cputlb.h"
 #include "exec/tb-flush.h"
-#include "exec/memory-internal.h"
 #include "system/ram_addr.h"
 #include "exec/mmu-access-type.h"
 #include "exec/tlb-common.h"
-- 
2.43.0


