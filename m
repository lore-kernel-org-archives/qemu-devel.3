Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC9BC369D1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 20:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JRA-0001U3-Ef; Tue, 22 Apr 2025 15:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JP5-0005ST-SV
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:38 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JP2-00075q-JJ
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:35 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22c33677183so65836355ad.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350531; x=1745955331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+gsVC4o8Cb7EzlC8YjKgR6GZM8zAAxzQ3ALZayRZdrA=;
 b=yYLBTEvfd1xl4q/4AvHqReber0FhJt/wbYJqMSbIDg1AFLMsIusXw7miJWbwZOnEhv
 FC/57zeCNcoVSNWk1TRBRpU2BWDjCxv2jZBbcbHaqbPqMsqP0RPtE4ffRk2wo2AiF77X
 pzd1kVGh/8XKn/ObVl2KwX1T06JsOLvzNZfpt47qkRmX+fKem4IEAU3A2l7mZeJ7VVXI
 h0TDppnLHxlNgHW4O0xK+qlujnPgVmcv4+EEN0o6JVQewjVHjejZjaF8Scce7XW8KHHB
 yiGgj23YftSRsvvRpFZ4dbGAQSDO1LWXfadtGnxTpYcPMrCaO5AzJOsOA/5zUxkRCWcG
 ThiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350531; x=1745955331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+gsVC4o8Cb7EzlC8YjKgR6GZM8zAAxzQ3ALZayRZdrA=;
 b=lUm7NHmVZpuzja73qfwZiutkZH1rzBNFGfWhXxpPwnYXynj6pE1I72N3gjfP9ArVOH
 HH0CFS+NW5Gc0jXqKYK4YRwMo96PllF1UyybE6H684TQbJmMvhyqd1Z0eFeW5to3PR9S
 u1LRQuCx7bQy1IldrL5Za4IjfbaT/pjfUanu1b3t0h6D0jL9QkWy6ebgKl66yn1aN5rD
 UXmgHPt1kN8QtPLqkpMkHRi8bFsuviTjmtCsKOH99irsV0LVrU+d9smd5b34dVYpjXGz
 ROluW2H8TUVpQSGUxQHHW20N2Vm9+YlSFy9PcDmt6mgMv7NSm4hLUShhhUWwuLOSEyE4
 vnhQ==
X-Gm-Message-State: AOJu0YxLkpG6xkchOA8/EuPFMAylp+vUYBv/k2Z+4MgwGEOmtGOlsjuf
 DfOoFaTJW/99F3YGIYTNOnjXzI3fpAyqc8k4Qt2KgVgK3N3MO+Js4EHf2kD35zqHvxk/ENy1kdS
 n
X-Gm-Gg: ASbGncvC3aC+vXYtvT2RK6waGbRsRqrn/tKO/H5QcIu5A3LHL7TDj7L8mtOm0OzZP+r
 ZjKp1f5kPJya1z2w2CnKI4Nvpqzbo5lfFgiOxZG0032OqhRyhAhgtgythW8j8ZysHyo6Iy0aHpD
 I0wUdr3e/c107+FdVxFrbngFRvIyaReIMqF8YdrPWPeCpRxD6X3fOJiM5YRAfryNRzTvusfQ955
 4YmIqi9VUBQZiq62wnm9ilkg/+LkSzaW/yMrWl21XomMsH3g5tOEqs43nPvCkzt0/Kaaw4YZMYD
 IktNmaTQBngPLVaTvFGgD3G7qGTKwNu+lHw5ez6VZGxIzVjk96gHMcr3iWek10JF3Du6YjzQG4N
 OblBBvf1pug==
X-Google-Smtp-Source: AGHT+IG54DP+m7uEWtlkjjvIGgMwl1RA4NnEt3wp9ixfn7kKX1l5VjN2+2513mS6yUtLc6OjXDCPoQ==
X-Received: by 2002:a17:903:98c:b0:224:1780:c1ec with SMTP id
 d9443c01a7336-22c5360dc12mr294152165ad.35.1745350530936; 
 Tue, 22 Apr 2025 12:35:30 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdf1f1sm88996795ad.237.2025.04.22.12.35.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:35:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 107/147] accel/tcg: fix missing includes for
 TCG_GUEST_DEFAULT_MO
Date: Tue, 22 Apr 2025 12:27:36 -0700
Message-ID: <20250422192819.302784-108-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

We prepare to remove cpu.h from cpu-all.h, which will transitively
remove it from accel/tcg/tb-internal.h, and thus from most of tcg
compilation units.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250325045915.994760-12-pierrick.bouvier@linaro.org>
---
 accel/tcg/internal-target.h | 1 +
 include/exec/poison.h       | 1 +
 accel/tcg/translate-all.c   | 1 +
 3 files changed, 3 insertions(+)

diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
index c88f007ffb..05abaeb8e0 100644
--- a/accel/tcg/internal-target.h
+++ b/accel/tcg/internal-target.h
@@ -9,6 +9,7 @@
 #ifndef ACCEL_TCG_INTERNAL_TARGET_H
 #define ACCEL_TCG_INTERNAL_TARGET_H
 
+#include "cpu-param.h"
 #include "exec/exec-all.h"
 #include "exec/translation-block.h"
 #include "tb-internal.h"
diff --git a/include/exec/poison.h b/include/exec/poison.h
index 4180a5a489..8ec02b40e8 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -37,6 +37,7 @@
 #pragma GCC poison TARGET_NAME
 #pragma GCC poison TARGET_SUPPORTS_MTTCG
 #pragma GCC poison TARGET_BIG_ENDIAN
+#pragma GCC poison TCG_GUEST_DEFAULT_MO
 
 #pragma GCC poison TARGET_LONG_BITS
 #pragma GCC poison TARGET_FMT_lx
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 87fb6c51d3..ed41fc5d0c 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -43,6 +43,7 @@
 #include "system/ram_addr.h"
 #endif
 
+#include "cpu-param.h"
 #include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "exec/mmap-lock.h"
-- 
2.43.0


