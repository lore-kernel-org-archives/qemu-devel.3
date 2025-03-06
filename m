Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E74FC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 16:41:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqEGB-0006vu-BP; Thu, 06 Mar 2025 11:39:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqEFx-0006km-Se
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:39:36 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqEFv-0004Xx-Nh
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:39:33 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43bc4b1603fso6021235e9.0
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 08:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741279170; x=1741883970; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=k5hIZtfWRRivBnmcIBAqfcb8VlTDxUApJC/AqX8qCP4=;
 b=aeCxaM4dCe5pBIWdJWX2aetAxBvkC+jC8SlF6DN9rPXudbQ2297KRZFHgv1WJgYByk
 BJc14/pnsoQgaFDZpqtJEHqXT8WE2OMYCsgEn5SQh5c3QyIrDUWu491Js8K8RDN7nCFH
 njt+nkDzMJU2lkKsPpQvFS/VpjLqefnDdHahbALRw6Np+2RxrKBtgczZCy577vUXl+SP
 gnUB8kQ04pNYFofrIWjK+tIAAgAuanATbC8I9j7RMhjp2ZnLOV7hIKez4uZtKvbaMANp
 562uhsoZ0tUHHbbhaPT7nucTXFNScrEUwCfN/RmS1cXQd+V1/H3JU8/LLrMrsiNReZIe
 uQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741279170; x=1741883970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k5hIZtfWRRivBnmcIBAqfcb8VlTDxUApJC/AqX8qCP4=;
 b=wFqc0p6CEHHh7vLi2Uc1IcQtoLfXHDPljpuAzYfhZt6wH/kGiTb7N8kI+1rYmb6pA6
 zFb7AQWNgud3qNgL35v7Jtkf5zvYl66Qb0pFCLrQKGBcWTXFGhzCKuCc5v2T5Og1jhs2
 woiseU4rNPKVh25/+VhEwKwie7FYg4Mu5NW6MT/anPjXV6D+U6vtcZ9i85x4Rsb17G9b
 YyW3mT7sz4Rbcxxif1zMWMhN7oeGJ+nQWNuhuS3PCMDHDZcuJ2TYKF9ntnTqv2x7QNtp
 dWvJiKXHDf24W46ftM+mZkjmuIPRFyiaqAx1ACW2KcSKbCKw3S/tS8TkEWxmOAZYxloM
 Erjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnFgE2FFYRceXla+VZ9yCKFcY03JD1HLN8G2rIXn0lBr+7bSo2knBH6EYJl29+GVDKC5OHT2KALc1h@nongnu.org
X-Gm-Message-State: AOJu0YyuMDhuGQenY9rJjIJvknLEz/Ix4iTGAPR0F7+yCmUluuVcQ55A
 nnDoz4qKQbEIsA8PmeEF2YSQWnQD/vJUE3wOxYyTARZh8NCILHrySj2K90/3P3g=
X-Gm-Gg: ASbGnctY2cjlms0tY1U3yp9qBGHZZ+KCiQx/o24r6+Go9iW7VuOZoJzPra/vTLdlBgO
 DyVqkI20XCM0vOgUUYOx+sxmMLPwIABp3KZ9a5yeSxzSNVNG5ZblTvDiORWLeTqfgJ0msxESW66
 RFGzN0yNzP6pFkrClD6inNqUaHfdGruBRhNQdonjI6bPpE5F2ASLe8uPd6J96JsSBBQBD08TEYP
 artR+r/oxZia8++LKopksP/5FkqhWgDm3iumzAyqcDSQmRIOa1UgXlmh10UXE82GdNFRg6sfujg
 tCcF4tvtKzCc+/Er/1wdT+u9cdLxAdoZAPbcL1uLHLmY4ekNhoA=
X-Google-Smtp-Source: AGHT+IFabVIqy8aCxJEcyjhR80/9tWEvJ9O8DiM/wCJERMGnJVT3HpHx0G9e0dkiNc3FMufcA8zwwQ==
X-Received: by 2002:a05:600c:4ece:b0:43b:c390:b77f with SMTP id
 5b1f17b1804b1-43c5cb68e08mr1457075e9.26.1741279170193; 
 Thu, 06 Mar 2025 08:39:30 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd94913fsm23999905e9.37.2025.03.06.08.39.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:39:29 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 03/10] linux-user/aarch64: Remove unused get/put_user macros
Date: Thu,  6 Mar 2025 16:39:17 +0000
Message-ID: <20250306163925.2940297-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306163925.2940297-1-peter.maydell@linaro.org>
References: <20250306163925.2940297-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

At the top of linux-user/aarch64/cpu_loop.c we define a set of
macros for reading and writing data and code words, but we never
use these macros. Delete them.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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


