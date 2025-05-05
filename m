Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04379C3ABC0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 23:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC5Ce-0003nN-MC; Mon, 05 May 2025 19:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC5Aa-00070g-NE
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:24:23 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC5AY-0003z1-Qt
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:24:20 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso45737795ad.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 16:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746487456; x=1747092256; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D50FgSNi0pKqcQ8O05hlTOFeOSvMmvlw2mBrg4KVMZU=;
 b=VkpOuLlahY/71yxxiojUFRbPOeHhF0BdIFzY68gzdxDJUcuDm362mDkW/lhFCUVEKK
 KhgyTqDVmcwIejwwI/1bCsHUL1i25ugq/gamSC9f8ML8h8QO5EvU0D4KyR+THozdqfGX
 OkfYrO8aV+XfRylTdVaMvCgwsM/SKiG/ZVt9GJpClkhd1dJHDXip6lOYOFjH/bGvXlOy
 F5xSklHnGpbO34CgLmnnT/tYr5PEdoFjNuyVETXSJysLXbdxOJ8PDoW95DqNPQTMDYQZ
 ADQskctt2Qv6z6HstpNuSnZQDeHvAuPFwHjh8kEpBTplkqnhiwwfH66iKYXvHMg6WIKt
 Cxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746487456; x=1747092256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D50FgSNi0pKqcQ8O05hlTOFeOSvMmvlw2mBrg4KVMZU=;
 b=viAwe88S5SGzmH+XU3whTMwQ7YwW+ezyTqNjrkl4za6qzWQBa5HCKMqCe1+e4lD/Wj
 Rjasd2uksCyXsQczqQamOc91zwBW3pIiMNWZ1sWn2mc36oUOGzi3D1m7FIFBjKoxEaoi
 ku8j0l48cyBgnjf/ZE3PvnLX4KlHHzjExdTjAHiTw2915YUTo2N4CSH6gDYptLxY0TmC
 ueRhDMxvTswAKDHKzV2sDsunUAVT4dt9+OZmlmdXoZORpeyQR+NXLaabhIFCaNAgt3k8
 +M1I4A94W8AvBuVYazdU5eClADHeUfaNnxEyEP3YRRRgwpH7wdElPdBRmUx1NRvvVVId
 G2KQ==
X-Gm-Message-State: AOJu0Yy/mXUmgMXrZBbNeAXUqkBouk5896/ktgRLDheDL/hfBfeXT0Oq
 k+W7myNEWXWh2di/nPNmYa+RI/UAgr1wwnwGEXiwvzaaDKtD18gCY0Hbkl51MV2JbODXLIX8Hk8
 RST8=
X-Gm-Gg: ASbGncvMWKu4arxApiQITVmetIY8kGHbU761sx2QkYL0CWFUs4gq9z7gGk+4X+23zCx
 qyYe5ygXcz1QhKoBVd7IUNmdf/A9nI6wZwrQKnBPB52Us+6sxF7lhADnS0nTjNhG2VFQvN5Kb+3
 ohsISnDoQg6RpwKXPNhpiACLeEhiDZKicns7Y760qGc/wat9jqE4SluqbmG0iu7Xw7ESDcqVxzC
 I9iedDEulMVIC8W/BekdrOml+XAHpof2Uo9h/FrFcYkHFcF6de2/ZCU0ns0GIxqrnpCfAkxrcPn
 QgXxfvBdND5f0eME+Sk3id+3V5vmH4BWRQlHEaVE
X-Google-Smtp-Source: AGHT+IEL4UfW/fNN2+1qFoskfy2C2PqX7WLykiEeT5Zb9TMUjzEO1zSNYPd1AXKmg/5TTMpRlWPNzg==
X-Received: by 2002:a17:902:e5ca:b0:21f:53a5:19e0 with SMTP id
 d9443c01a7336-22e327f74c6mr16808835ad.12.1746487456046; 
 Mon, 05 May 2025 16:24:16 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e16348edasm58705265ad.28.2025.05.05.16.24.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:24:15 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 49/50] target/arm/tcg/arith_helper: compile file once
Date: Mon,  5 May 2025 16:20:14 -0700
Message-ID: <20250505232015.130990-50-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
References: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/arith_helper.c | 5 +++--
 target/arm/tcg/meson.build    | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/arith_helper.c b/target/arm/tcg/arith_helper.c
index 9a555c7966c..670139819df 100644
--- a/target/arm/tcg/arith_helper.c
+++ b/target/arm/tcg/arith_helper.c
@@ -6,11 +6,12 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 #include "qemu/osdep.h"
-#include "cpu.h"
-#include "exec/helper-proto.h"
 #include "qemu/crc32c.h"
 #include <zlib.h> /* for crc32 */
 
+#define HELPER_H "tcg/helper.h"
+#include "exec/helper-proto.h.inc"
+
 /*
  * Note that signed overflow is undefined in C.  The following routines are
  * careful to use unsigned types where modulo arithmetic is required.
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 5d326585401..7502c5cded6 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -34,7 +34,6 @@ arm_ss.add(files(
   'mve_helper.c',
   'op_helper.c',
   'vec_helper.c',
-  'arith_helper.c',
   'vfp_helper.c',
 ))
 
@@ -59,6 +58,7 @@ arm_system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('cpu-v7m.c'))
 arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files('cpu-v7m.c'))
 
 arm_common_ss.add(files(
+  'arith_helper.c',
   'crypto_helper.c',
 ))
 
-- 
2.47.2


