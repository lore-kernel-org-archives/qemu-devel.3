Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F54C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXf6-0007t2-CS; Mon, 12 May 2025 14:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXaC-0001Hj-Ne
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:08:57 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXaA-0000SU-A4
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:08:56 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7418e182864so3795461b3a.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 11:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747073332; x=1747678132; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=45kfheSbx4dAVwou8HhqFlnvbUQXjacWSTonOtivRHk=;
 b=vvhGHWNkkVgYOlw/V9GpT4aiAU4UacA7nPO6dhfbT+Cb47HJsrc3jfIr1XGOSbZhuA
 YwXp6FqFkm/vUIRcYVUhLcYo/TmsWEOD/EBlEszWzmmgYnxUmKhp0w7NpO/Cp13evcvf
 rRg2OlqgdvrGPlW7aoOhgNbBzmBzcR7FsVqqJnXPM0/VnGowdmDwRKpnrPMQZLc4lyMs
 9B3YCsAJtbCe33b75PHHhfbHK73L8Te4xvQZsS5Uk4x6tGsimVZbFxfZ1mkuiAoHhVls
 GjQ10wkccytlSxRkwCCT6if32UC11w80HzrnA1LNylVTh+337WYQaOm/17irQ81nJ6ap
 9aUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747073332; x=1747678132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=45kfheSbx4dAVwou8HhqFlnvbUQXjacWSTonOtivRHk=;
 b=a0pgmuyvJId0P4Yz28c/TurBJnN01s6F/dmCIBt1hishTziqZDycjRBURuBstTFsUs
 z7YkLexIkZhElOieJAietJISgX7vJHJrq4YC+LTuHX9yboTTpWT+gFnv136A7FQi28rR
 rystdYAviuNvMqIHqAgvDDrqe4Of4zzzhdaZ3FA08QtdY8KFNlhDCD5D7ynOy5MwGeCZ
 c3YIFKcopEGP+wUhw7mgSjfIxNFGvoLC5F6o5mcnL8A2JgcqYbCiWIyXF3CR+zLi4e42
 V1q+vmNi264MSY02JHQ7opKI4R5MReKP5rQLb9NWoomFqP235XpdxT/v1bsFjOx53b5G
 Fd5A==
X-Gm-Message-State: AOJu0YxwErGFwlLYCtSk23htBNJCMZq5smVawBMb6MtnbuC5sGkEetUf
 q8bhAP6XKDMOhKPyEgBitOdMkIV5jdolBb7lZ21/B0x3UwrsxWlfZlaqGrhXHofjSLEu6dBZObs
 5
X-Gm-Gg: ASbGncuCMM1PK9CCqdSWZK/F9Yt1eitXhq+ivSeOs/SgjDI8Z07yHW0DeBC2r9wMxrz
 LkoaxAhxbEcLZCdQoGt6+efMzmotZ7rE+3TAL3sKR3jX1cJrph/WmXUPqe8MuTwjORZu2D1OSiM
 eQOzUqK2SQMQOC7vqB6TmGfBvURzOQrysmQVl0p8dAu4CdvGX/90vyBAkuNE832wzLlBRNGXy/1
 WNSFFOA59HzUy5owEa5tm3Kuu7VyEa7mAMl+7dE9RmoK+YeaDS9x/fOmwby4nnB9MbC/X4wOuUw
 WKEESioCNXZ+1EnkyaeQ3lUL81+x+JQyKAW/wNiDyymc7YotzcY=
X-Google-Smtp-Source: AGHT+IFhUEj8B0jzi2eY3hecuRh90QxHVyJSzWdBkDPS+yb9VWe1l8ymSiC5MeyMfg79bhe3uOQ8HA==
X-Received: by 2002:a05:6a00:a16:b0:732:5164:3cc with SMTP id
 d2e1a72fcca58-7423bffde33mr21159796b3a.19.1747073332366; 
 Mon, 12 May 2025 11:08:52 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74237705499sm6438580b3a.33.2025.05.12.11.08.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 11:08:52 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 40/48] target/arm/tcg/crypto_helper: compile file once
Date: Mon, 12 May 2025 11:04:54 -0700
Message-ID: <20250512180502.2395029-41-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/crypto_helper.c | 6 ++++--
 target/arm/tcg/meson.build     | 5 ++++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/crypto_helper.c b/target/arm/tcg/crypto_helper.c
index 7cadd61e124..3428bd1bf0b 100644
--- a/target/arm/tcg/crypto_helper.c
+++ b/target/arm/tcg/crypto_helper.c
@@ -10,14 +10,16 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bitops.h"
 
-#include "cpu.h"
-#include "exec/helper-proto.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "crypto/aes-round.h"
 #include "crypto/sm4.h"
 #include "vec_internal.h"
 
+#define HELPER_H "tcg/helper.h"
+#include "exec/helper-proto.h.inc"
+
 union CRYPTO_STATE {
     uint8_t    bytes[16];
     uint32_t   words[4];
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index dd12ccedb18..2f73eefe383 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -30,7 +30,6 @@ arm_ss.add(files(
   'translate-mve.c',
   'translate-neon.c',
   'translate-vfp.c',
-  'crypto_helper.c',
   'hflags.c',
   'iwmmxt_helper.c',
   'm_helper.c',
@@ -63,3 +62,7 @@ arm_system_ss.add(files(
 
 arm_system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('cpu-v7m.c'))
 arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files('cpu-v7m.c'))
+
+arm_common_ss.add(files(
+  'crypto_helper.c',
+))
-- 
2.47.2


