Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E2BAC28B30
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 13:17:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt4u9-00058G-Vc; Fri, 14 Mar 2025 09:16:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tt4u6-00056c-9K
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 09:16:46 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tt4u4-00012l-EY
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 09:16:45 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cfecdd8b2so18766555e9.2
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 06:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741958203; x=1742563003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6J/9ANglDaXRI5YIXs5GXgTFWRT7etnt/oN9SrKqW4s=;
 b=NaBsHhaAEMQneUKIbHgj5o2V1iY2VfGA0S+D1oQMsGxgVPiMKtDkWq+U+nZt0F0KMP
 BxwanrXme4NrIN8R1Yr20soPbwE2LIn2zu1KMdPpbVRj5LeUiz9IUr5wefDrGKA6EvjB
 x5nhkZDLByo6isA+oo4/m2gOq/Foq5HmjhbNtJAzAYbP0ZN1TtKOfmCxsSqEO9VbYeSA
 40+NTkJWbpA5NHxfsdWQ4tpyG3167fTiAIJhLLunByhRGZmOaP9mzb59uzf9tahUz4e6
 6Wy2tGUItjOX6kSzDDfW0kPKUVhm9LS983EHtUZFyeueuXMUNH4AyCNkH6y/JwVdDUQb
 aXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741958203; x=1742563003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6J/9ANglDaXRI5YIXs5GXgTFWRT7etnt/oN9SrKqW4s=;
 b=GnXQuO9ASjUBe+R7P9EBkS/XRH8qKTTK69MXCp3SDC0a599ZAcGRTdvXHtPyBzcV9N
 ueAiK5sw6BYrZ2LjhgyL11REjruN0beRioCPp8iq2ebdzm1LlmawItXsd8ZQJrfO4ulV
 LaHr1Lu9pg5xXr2/FtI4xSua3bLF3/xDfKP2P2If7jpZSDYB3VUNzPnbJCPbgcnx+VH6
 74x72LnNoMoeiaPtwFEa+kFxV1LJURyLNMqWZdtI64DogsmfjIl3ADcIwDwsFOyORSVL
 9VkRpiPNshyJwFbYRD/5YWymx3BorSOKsCq7XZuiI+5W3KPYwB2RzhdoUQ/+MZdA7ZPi
 IUhQ==
X-Gm-Message-State: AOJu0YyeYBE3/TTSd+6mGqLdMypln+qWV0xlTTaqpsgohJnBFZNxbD2O
 11i18T1crI1tROkUmB6To8vhWaUEhIGJwH8/+W0IX5yLSZJT3TPoePMo+liknH2B0Sm+mbJQAPq
 5
X-Gm-Gg: ASbGncsjaIWyYVXT5p/mStNTzJO+HLF7GcD+aUyjx5Ib7T3mHdqp4y08CQo4aXcSeOS
 25Ub22U3bDxPJ6dQp+wFTh9P6BWiqNbP+a2jQp1vC8/Vf48gFNSzajz3WBeF/3BTMPFz63TjMMF
 KZLqvzcY3vnvnRSrkraRMJ3fnxE2W8zelmu0yHx8QOCjqg17PygVS+kO5smwqNY24UOlA0poc2i
 RArazKruHrCzI1H01V2/uqtSgep66WQwycRqYnHXINyo8+vdIRx0IwabiYLxU5Iivu0N3Dr3GxA
 FA3lSQqTPi2WXqsd9E5aVzBd+RZ5yXKAl2kuseqLBjlIMVkV0aE=
X-Google-Smtp-Source: AGHT+IGsZulyPT6HoYAsv7K9Rw7mGi9IZDElMny09ouenrmd0aFjZMUBSLSp0Y7bdVHyPayIL7EuEw==
X-Received: by 2002:a05:600c:1c85:b0:43c:fb5b:84d8 with SMTP id
 5b1f17b1804b1-43d1ec81231mr35125045e9.16.1741958202677; 
 Fri, 14 Mar 2025 06:16:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb7eb93csm5437923f8f.86.2025.03.14.06.16.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 06:16:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/17] linux-user/aarch64: Remove unused get/put_user macros
Date: Fri, 14 Mar 2025 13:16:23 +0000
Message-ID: <20250314131637.371866-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314131637.371866-1-peter.maydell@linaro.org>
References: <20250314131637.371866-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

At the top of linux-user/aarch64/cpu_loop.c we define a set of
macros for reading and writing data and code words, but we never
use these macros. Delete them.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/cpu_loop.c | 48 -----------------------------------
 1 file changed, 48 deletions(-)

diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index c5d8a483a3f..fea43cefa6b 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -27,54 +27,6 @@
 #include "target/arm/syndrome.h"
 #include "target/arm/cpu-features.h"
 
-#define get_user_code_u32(x, gaddr, env)                \
-    ({ abi_long __r = get_user_u32((x), (gaddr));       \
-        if (!__r && bswap_code(arm_sctlr_b(env))) {     \
-            (x) = bswap32(x);                           \
-        }                                               \
-        __r;                                            \
-    })
-
-#define get_user_code_u16(x, gaddr, env)                \
-    ({ abi_long __r = get_user_u16((x), (gaddr));       \
-        if (!__r && bswap_code(arm_sctlr_b(env))) {     \
-            (x) = bswap16(x);                           \
-        }                                               \
-        __r;                                            \
-    })
-
-#define get_user_data_u32(x, gaddr, env)                \
-    ({ abi_long __r = get_user_u32((x), (gaddr));       \
-        if (!__r && arm_cpu_bswap_data(env)) {          \
-            (x) = bswap32(x);                           \
-        }                                               \
-        __r;                                            \
-    })
-
-#define get_user_data_u16(x, gaddr, env)                \
-    ({ abi_long __r = get_user_u16((x), (gaddr));       \
-        if (!__r && arm_cpu_bswap_data(env)) {          \
-            (x) = bswap16(x);                           \
-        }                                               \
-        __r;                                            \
-    })
-
-#define put_user_data_u32(x, gaddr, env)                \
-    ({ typeof(x) __x = (x);                             \
-        if (arm_cpu_bswap_data(env)) {                  \
-            __x = bswap32(__x);                         \
-        }                                               \
-        put_user_u32(__x, (gaddr));                     \
-    })
-
-#define put_user_data_u16(x, gaddr, env)                \
-    ({ typeof(x) __x = (x);                             \
-        if (arm_cpu_bswap_data(env)) {                  \
-            __x = bswap16(__x);                         \
-        }                                               \
-        put_user_u16(__x, (gaddr));                     \
-    })
-
 /* AArch64 main loop */
 void cpu_loop(CPUARMState *env)
 {
-- 
2.43.0


