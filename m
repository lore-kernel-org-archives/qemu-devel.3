Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D37EC5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 04:05:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxGUg-00068u-DH; Fri, 21 Aug 2026 00:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxGUR-00065C-Ab
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 00:04:23 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxGUP-0003DI-T3
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 00:04:23 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-38deea72eebso498055a91.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 21:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787285060; x=1787889860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ki19VWjqhUrb9W5NVrRU/ayXP3I7g7OAHfGnfTrb0dc=;
 b=bxykv2A4wBgeDyRSBNaGtWGUq2wSugk6yIG+LPBjcfOUqdGxCEhFOtXKmGiwWBWnQC
 Lyz8ijOPKA5hbiqOY8pmCrllD7SNnQpmK18bW3m3xrvgN2lz7frsi+KINC8eohZBwKqj
 UXql0HtFnBaayJCdPK3bcFqnnu1cEFkI8ckwQNs7ZRGsPkQzsbd76Mlah7ykB/p8j9pM
 i+kbWZ9vVmA+YKdBZi8PiAFViXirTMBSGSjQKQjUxlCuUkb3UFRegL2/YJQH5aiuARCJ
 NmID03i8YFRJI46ClunumQOz3jnSJTq4HjbGe0vfwLZ+vZIqwi3p3eVatNrO5MboXdsi
 Hm6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787285060; x=1787889860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ki19VWjqhUrb9W5NVrRU/ayXP3I7g7OAHfGnfTrb0dc=;
 b=f64MyhcndIuPKgOg58JhaUo2gDACaw6mLVlcpF9iMqPsHeL2DsyUWiWmfEXbC3rCWl
 hZzTIxgby70qHQmLpCR6+/j4JluWdvfktkyqOD7A36irsukTgMWKBmXRP5mIkmg/psdM
 1CSQTjSr9M0x7KsTRXvhK0hMmuGV+wGJexIDmDUQFkgMQFNlK0cuV8MW3C/GMJnj3v77
 G3JC5Prgpdbx6QVYqqX+JREu2Fg1WbchOALmgrhpO38yLiFke91L8eEXRsmb9dk+KkcP
 4oEcSlHQQMO4yKwlFlTe5vrD5XBF1Gclsp4oW/OG1ryb9bkUnrnjCUc/pGCkWrFWVQFS
 qfUQ==
X-Gm-Message-State: AFuF++ltQyOd7S8+JxEUD9ppfKDPwidZGJpekkCh5Dpzd1PvDtNBL4pT
 Wd8WbseUxvHnFgG5kO7H9Z/i1T38RbSurM1y00Uz7yEzcaLc63EeATfEchORUWYZav/MxVsV0vD
 0Do6N
X-Gm-Gg: AR+sD12a6u7kKedex0Y+agvqcAvEy38mECjW00sRcOy4iI03FEh6o+R2piLNB4Fk/kJ
 I6v00H5/JYyBKBS93yonwVug0KgB2awmAiAfIP1cCAEgHAluW7ljRo6AAaon6lf9Dn0Ep7ktIOe
 CBS7Jp+HaZ4n3aUnnQI2XfJFZQg/7fg+vCTeJnPmMlNsSItCgw9YihBTOmNeCL2jaQHXYIqF/4u
 DTzd4wqMVy6njTvB/8ikU1VURSisEYs15/JgxmpOSRE3MBpQVYKSaTlrhx11Hc4vAtD0ggYaMva
 tBG3qm1ZGebLvgunsHXtf4S8oo2myPI5VI+j6QrMMoWrfk5Q/M6szSQjrFPElW7PuDXCI5e/qIQ
 XfkXuilDm7AHQw3/ELCiO0Mtu54yhdStYCcI3fD7ABP4MBIlgG0yPij05jABJCzhRzm1VwBDbgs
 Wv12BNDWlvNGeaRt5DlNSV4odv5S+G8C3SBdtiI5VD3O9Qlhp5EqQVjy/k2HgryroGJ6r4
X-Received: by 2002:a17:90b:2ccb:b0:36b:bec8:94c5 with SMTP id
 98e67ed59e1d1-395c35ba5aemr6408309a91.10.1787285060350; 
 Thu, 20 Aug 2026 21:04:20 -0700 (PDT)
Received: from stoup.. ([108.174.179.84]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c4c194d2sm1298383a91.15.2026.08.20.21.04.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 21:04:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: [PATCH v2 12/23] target/riscv: Mark VSTART_CHECK_EARLY_EXIT unlikely
Date: Thu, 20 Aug 2026 21:03:53 -0700
Message-ID: <20260821040404.268123-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821040404.268123-1-richard.henderson@linaro.org>
References: <20260821040404.268123-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/tcg/vector_internals.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/tcg/vector_internals.h b/target/riscv/tcg/vector_internals.h
index 5681b81815..d081397f65 100644
--- a/target/riscv/tcg/vector_internals.h
+++ b/target/riscv/tcg/vector_internals.h
@@ -26,7 +26,7 @@
 #include "internals.h"
 
 #define VSTART_CHECK_EARLY_EXIT(env, vl) do { \
-    if (env->vstart >= vl) {                  \
+    if (unlikely(env->vstart >= vl)) {        \
         env->vstart = 0;                      \
         return;                               \
     }                                         \
-- 
2.43.0


