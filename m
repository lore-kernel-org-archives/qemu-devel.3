Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14FE8C3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:41:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVpm-0001xL-Po; Thu, 15 May 2025 06:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnk-0005ZV-RS
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:27:00 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVni-0008IR-G3
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:56 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43ede096d73so5415035e9.2
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304813; x=1747909613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=13/BUoafMVf2hXB1lodB0NtYzojM6Xz4vl88q8j35NI=;
 b=uyxjCxQiaKwNiUnmFVLxKc+YEsArTjPNsXl9Pbrqx20jaMWhCakFVQ8JIix2IOcOEe
 qxv2sqBQQ2cvMkvvh/BK1HN4nJ/NHzGgFQ8nP38BMy5dyKc43mclTgYUlto+mOPBU1Tc
 MZ+0LJCazUKMXNkCZHQURqG4yOFUBbc3dzxCVdDvVD7EhLhPMiKLJBIrJrehnq0iRsqX
 lJBuxjKvs1QxZ0gHjYLS/YdR6cPmEqlE5NEBMDjX/iM7ol7j4WipyMOJDH6nJgP+59sT
 INo2qjEN70hplIxsxEAQfC4l7JydLjFRI63aITB4Mtqqt7VCBTbTeda1ayYCroi8hy05
 2ygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304813; x=1747909613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=13/BUoafMVf2hXB1lodB0NtYzojM6Xz4vl88q8j35NI=;
 b=SInJkE1fNartVCy0VHQh6S+nKt3BgdvVQ019m1n5jsDckMltgGXYuKzv4H1qIeTKtf
 aCwRVTUycnAZfH1BnvNMjkZfPaAcxYUcQKKHN33ivBI/Aa2OZh3MhCt9MEco5ImuJ6XL
 9koY13pGQg3ztRLWI2j7EUc/MEx609Kygcq1L0JIkPwdMI3yo8QBsRz625gS2h8AMjst
 CXK/8eMajSnuraigp+CqVWnBbAeGz6d0GR/hLB2RLpKd2NWl47QySo9KClk8UQye4InH
 rT19v8iT2arYZODKI3sVAPcZraiRXQmCgzx26WxI/sKAsKbJ9q2QMZsQxRLyhV+ksXV2
 Qrjg==
X-Gm-Message-State: AOJu0YzyV4LzlD3lWuXFBmnCxPMbt/chgem/6tZmk52jibpp27P/kj3n
 kIvZUCuSnTtg6xC+imtsIhXFqdCuS4U7NKbQWfgMSFtXZMW/qC3iLvWgz34iLkGn1vwFSXqaAbX
 mvR0=
X-Gm-Gg: ASbGncuNqu5dcHqmpFphY4VDpLQwd9ETTPeiFf2yj1U6NCgnxkCec7ooqUErrtDv5Xw
 ebRlIIfOMGF4kr30QR5UPNGkBm5h7XJ2p899jMrLNVNViqCDtEIE+1bOLRG2UcMQYL1OkL8gNoC
 iskgmPBoBBx0flNKQBjB9ncRVCfHd3L/swbLnLrjI2WhgeYfR1Lxd8P9P2xXzXlq1hwRuOxIdGw
 1C7K57EMT8CD0CBCI3QpgEs3uyUiU8QGYEceadBjwsKVwbzumfiXjkGG8v0O3v0KZoXvq4c0lwI
 ++lqhpXYquGcIzMOCfGbMltTrzsR7XzAiymi70GRWNb921UXc22yi27/kw==
X-Google-Smtp-Source: AGHT+IEQ+bUV8f0g053GKL8XBB4aRlfFXX30GPxDrCHlLioGD/cEFVHhR95XwuItmCZp4VCXjmc6iw==
X-Received: by 2002:a05:600c:3d06:b0:43d:585f:ebf5 with SMTP id
 5b1f17b1804b1-442f20b90ddmr49362915e9.1.1747304812790; 
 Thu, 15 May 2025 03:26:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.26.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:26:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 53/58] target/arm/tcg/neon_helper: compile file twice (system,
 user)
Date: Thu, 15 May 2025 11:25:41 +0100
Message-ID: <20250515102546.2149601-54-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250512180502.2395029-44-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/neon_helper.c | 4 +++-
 target/arm/tcg/meson.build   | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/neon_helper.c b/target/arm/tcg/neon_helper.c
index e2cc7cf4ee6..2cc8241f1e4 100644
--- a/target/arm/tcg/neon_helper.c
+++ b/target/arm/tcg/neon_helper.c
@@ -9,11 +9,13 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/helper-proto.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "fpu/softfloat.h"
 #include "vec_internal.h"
 
+#define HELPER_H "tcg/helper.h"
+#include "exec/helper-proto.h.inc"
+
 #define SIGNBIT (uint32_t)0x80000000
 #define SIGNBIT64 ((uint64_t)1 << 63)
 
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 02dfe768c5d..af786196d2f 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -32,7 +32,6 @@ arm_ss.add(files(
   'translate-vfp.c',
   'm_helper.c',
   'mve_helper.c',
-  'neon_helper.c',
   'op_helper.c',
   'tlb_helper.c',
   'vec_helper.c',
@@ -68,8 +67,10 @@ arm_common_ss.add(files(
 arm_common_system_ss.add(files(
   'hflags.c',
   'iwmmxt_helper.c',
+  'neon_helper.c',
 ))
 arm_user_ss.add(files(
   'hflags.c',
   'iwmmxt_helper.c',
+  'neon_helper.c',
 ))
-- 
2.43.0


