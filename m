Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D71C282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 13:18:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt4u8-00057Y-Er; Fri, 14 Mar 2025 09:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tt4u7-000574-4x
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 09:16:47 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tt4u5-00013Z-Ds
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 09:16:46 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cfebc343dso13290185e9.2
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 06:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741958204; x=1742563004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5P8dI0LglzsFCzU+xe5Ql8suIL1Ju80i0bFOQatlqoo=;
 b=CQrpiDW8ySkM8T7K4el0Rh0kasmyLBTefy+py52VN09NqLUguHvN+L3GT1VHztSKhP
 HN3vO/kOY368PkJ+4Ni//02ItkBQ9GPmDZl0s1Z6EGj/c6QMhiJTcKafTjZEaqhIu5sw
 lu/KaDOpAir6MOIYHqqFB7fjWYB6gOjFkqrTvaOjSOipBqXOo7KLAKgES6qB0fCT6Jy5
 ARFn6vsJgtGCfXCNZZkxmGijzljYY5Iyw2OoDDsF4gCs98yH0y0OVnMPRdb77tadCnnt
 JRvrWK/7Cf1PBMw9O9pUwYrdAxPbKLpxxGeaKFh+btq2oCQKgi7fnrkLSPC9c2iW1cEK
 kk4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741958204; x=1742563004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5P8dI0LglzsFCzU+xe5Ql8suIL1Ju80i0bFOQatlqoo=;
 b=CKi0BfjdsBYQc1hmY3xA4FEMUJrYMOtc52UhhnpDFBNFyKI9ND+udOuoc/0UkSiNHQ
 /xrJm+d6+EqKQFu+hzSe5jb5xGxCxV4nbI6llcZOfcSyWH9/TxSJX/MH8p0NtCJMt5AG
 VR1bfadrdWHyf7XDLTdNfBW+YU0ryfQoMaCHggp9/EW6u1xskCz5tFQjcHuYRGUeHaUG
 GuFVe87giJTVu0FWWOYmXIp6IcFs67i4jqDRWVxP4w5xstAfSZd9qcMobwOJ1VqxrU5h
 uSie5WQx08OopZDDmuq76N0PohNqAHBZi0w2usxZ42zmSdDQYXkV/eEiqGw7mzNLKpoF
 tZgQ==
X-Gm-Message-State: AOJu0YyQI+szSfFdfHFjY/74UmvSd7xL5ztBycqnZkHdB12FwYzYEo6D
 RKpfPhdfbFbI3elUbG3L/yfo9RW3V6dZ+Zk+lcvHwO8txhh1EmnZPeB+QW9UXzQlPbu3YNxX07V
 L
X-Gm-Gg: ASbGnctssegS5LvwenaXSZ/042Gm8cEzYBJUXSzx7v+2x0o54gKGpvwl245Xwd+eQB9
 KJiLRBgwB+Ed8CEONWC1D+AXoE9pwYC/bwPrHZdTN1SC2JFax2b6c+TKAdk4vLTMA0yDOCYElvE
 NYpyfpPWKE6bQogpXwkCUGYKTLuUwaEkPXuqMKjhTHdpwf18czj/J+CxKuWwCutAuzhZTrUiWte
 5sE+U/uOV5w06A1ki2C/tjzCphzakvwpNisEMGmtvx5V1PJ5d8HV/kTqri4t5obN/gA5I7Urw0+
 W1xKpFko+wuROAtv1zIqGRNGfTe+12JBCCerrXRTDw0SBssjye4=
X-Google-Smtp-Source: AGHT+IE7loksS9ITNgf0pQMVyo3Ny7NbPm8wrL0+sBkxvMRCVXFFNLVyYMCRmGEcJJyzANPUxdBBew==
X-Received: by 2002:a5d:588c:0:b0:391:47d8:de3a with SMTP id
 ffacd0b85a97d-3971f7f6c9cmr2880347f8f.53.1741958203799; 
 Fri, 14 Mar 2025 06:16:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb7eb93csm5437923f8f.86.2025.03.14.06.16.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 06:16:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/17] linux-user/arm: Remove unused get_put_user macros
Date: Fri, 14 Mar 2025 13:16:24 +0000
Message-ID: <20250314131637.371866-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314131637.371866-1-peter.maydell@linaro.org>
References: <20250314131637.371866-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

In linux-user/arm/cpu_loop.c we define a full set of get/put
macros for both code and data (since the endianness handling
is different between the two). However the only one we actually
use is get_user_code_u32(). Remove the rest.

We leave a comment noting how data-side accesses should be handled
for big-endian, because that's a subtle point and we just removed the
macros that were effectively documenting it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/arm/cpu_loop.c | 43 ++++-----------------------------------
 1 file changed, 4 insertions(+), 39 deletions(-)

diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index 10d8561f9b9..7416e3216ea 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -36,45 +36,10 @@
         __r;                                            \
     })
 
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
+/*
+ * Note that if we need to do data accesses here, they should do a
+ * bswap if arm_cpu_bswap_data() returns true.
+ */
 
 /*
  * Similar to code in accel/tcg/user-exec.c, but outside the execution loop.
-- 
2.43.0


