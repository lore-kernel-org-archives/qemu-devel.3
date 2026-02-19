Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1DCE9A04C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 04:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsvF7-0008P9-NS; Wed, 18 Feb 2026 23:02:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vsvF5-0008NF-EP
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 23:02:19 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vsvF0-0001DZ-Ny
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 23:02:19 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c6c444e89bcso191761a12.2
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 20:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771473733; x=1772078533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UdK2rOS2bitRzrDxI30pyU/TEy+Znetuyj+EjMa6JSY=;
 b=tkCiZxEWMP/XI8dyFZC70iVT+RregtBn+YNDqgK5gcDhWNVqsE6CEsy47kj4PcvjlP
 DqEuhUH+HJbi4rLkIYdpz8tpsIdov3k3MFNjrMo2PLnGJoAB3TF3KlaZbjshFplZm+Ay
 WzRvxCqRl4JNC6W9TYz/Rq46fdDYeZc4CFCEitp2Nc/p7+buFBvRaRj2qdCPuZ1NXXAs
 c2ekCsHr4sW4e065dFUBkiom1MkRp0ld2MnYK64SERhJ+ZcSUr2CCvCHUIYHS02tzx4R
 v1soJNqNX3WPrXEfFRUwp5JteKH/LtxLI4A0BELEXhbOEZ05QcvVWOM61q212jt3gGzp
 N6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771473733; x=1772078533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UdK2rOS2bitRzrDxI30pyU/TEy+Znetuyj+EjMa6JSY=;
 b=qAct0W9Tk37UbL6LMQM5099do+4RTarcG34CBujLL9wsCuvmZysZei0v3JhcDss6bN
 uR29YIvO/HZa1NzZVgTHgaQOzPsk91TFrSV2k435kCLxH/U3xE1MbiNFfRa/MGBxRG1J
 Flt2aznwCVdzPrl1XSf7w/eO7ErxFkX0xuMDeuv6sqn1KVDQ4sv89XB+aarj/v4VAluD
 P7J52AorpKzOF75uwKkQMS0KWSLKQ2+4mG22/RTekPOhGDVwljnl//CSb93O1/oGFmun
 vtCQCowvYRJkYFjY3H7GtI3a2ymzoq77uc0Q89tIjbX2RkZ6YiuY3W1/bAkLHvofoT+X
 J/Fg==
X-Gm-Message-State: AOJu0YxNLFaDiUcFlXnXFz32tF0/bka+SQ5zbRxV3sJNr0IyhEBFjtYk
 LqE5RtRRiX47LSxQ3rrhGtmqkh4xRFf9FlckEiHRdzvrqMt8EuMjayeevhnii54OaJVtfx7gGD+
 /OhcN
X-Gm-Gg: AZuq6aJxEAr2eqAWSGsf2P0aW1zC4kk0H8kNpaDqm1VF/LSnL/8NeAQn0wIr4Zc+x58
 UPtF8hMcev9OPSPJoCA5oiz8m7DPNPS+u78ZZRf6s1HUfu8hZJNDglT/RlDHH5yli3yuSWyCCv+
 wQXMwPGooYimzyo7SlRFJgVq2S2oWpHfYQbqFrKge1U/Ig9ZHg2KgM95uIbsC/lgc9wltRWG06z
 EAyOVXHqVkIHYUjpYkeLwgf6hUGMtSCtj4UgyE3czuSh/xIrxzrP35tvGhkWBWtWfraKbu/5DBv
 SkoE72Hs6x13KBgUAtxTQDgOvWAKKIPdOzUUQhvm6uyxSaycv51tvw3uKMUg6oW0da0dM8Qcfe5
 CFCNua4e+89cWp99YJC/r7v0UexQQZF5NleWbY3sgAjYQAc+mXvoIfqvw3AsmIqD+F899xvxLBH
 0bxXfFMKPnI3gfipOoRwGKkIPL3S9dkv2ECYsW2g3RJjGNjfeAr5z5MVzT6vvDDoY7SnCd9Sj2K
 3l0
X-Received: by 2002:a17:903:3b84:b0:2a9:616c:1711 with SMTP id
 d9443c01a7336-2ad50f8b526mr36135435ad.42.1771473733004; 
 Wed, 18 Feb 2026 20:02:13 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1a73200asm147636225ad.36.2026.02.18.20.02.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 20:02:12 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH v4 04/14] target/arm: extract helper-a64.h from helper.h
Date: Wed, 18 Feb 2026 20:01:40 -0800
Message-ID: <20260219040150.2098396-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260219040150.2098396-1-pierrick.bouvier@linaro.org>
References: <20260219040150.2098396-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52f.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/helper-a64.h                            | 14 ++++++++++++++
 target/arm/helper.h                                |  1 -
 target/arm/tcg/{helper-a64.h => helper-a64-defs.h} |  0
 target/arm/tcg/helper-a64.c                        |  4 ++++
 target/arm/tcg/mte_helper.c                        |  1 +
 target/arm/tcg/pauth_helper.c                      |  1 +
 target/arm/tcg/sve_helper.c                        |  1 +
 target/arm/tcg/translate-a64.c                     |  1 +
 target/arm/tcg/vec_helper.c                        |  1 +
 9 files changed, 23 insertions(+), 1 deletion(-)
 create mode 100644 target/arm/helper-a64.h
 rename target/arm/tcg/{helper-a64.h => helper-a64-defs.h} (100%)

diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
new file mode 100644
index 00000000000..cda7e039b72
--- /dev/null
+++ b/target/arm/helper-a64.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef HELPER_A64_H
+#define HELPER_A64_H
+
+#include "exec/helper-proto-common.h"
+#include "exec/helper-gen-common.h"
+
+#define HELPER_H "tcg/helper-a64-defs.h"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen.h.inc"
+#undef HELPER_H
+
+#endif /* HELPER_A64_H */
diff --git a/target/arm/helper.h b/target/arm/helper.h
index 44c7f3ed751..79f8de1e169 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -3,7 +3,6 @@
 #include "tcg/helper.h"
 
 #ifdef TARGET_AARCH64
-#include "tcg/helper-a64.h"
 #include "tcg/helper-sve.h"
 #include "tcg/helper-sme.h"
 #endif
diff --git a/target/arm/tcg/helper-a64.h b/target/arm/tcg/helper-a64-defs.h
similarity index 100%
rename from target/arm/tcg/helper-a64.h
rename to target/arm/tcg/helper-a64-defs.h
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index e4d2c2e3928..07ddfb895dd 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -22,6 +22,7 @@
 #include "cpu.h"
 #include "gdbstub/helpers.h"
 #include "exec/helper-proto.h"
+#include "helper-a64.h"
 #include "qemu/host-utils.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
@@ -43,6 +44,9 @@
 #endif
 #include "vec_internal.h"
 
+#define HELPER_H "tcg/helper-a64-defs.h"
+#include "exec/helper-info.c.inc"
+
 /* C2.4.7 Multiply and divide */
 /* special cases for 0 and LLONG_MIN are mandated by the standard */
 uint64_t HELPER(udiv64)(uint64_t num, uint64_t den)
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 08b8e7176a6..01b7f099f4a 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -31,6 +31,7 @@
 #endif
 #include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/probe.h"
+#include "helper-a64.h"
 #include "exec/helper-proto.h"
 #include "exec/tlb-flags.h"
 #include "accel/tcg/cpu-ops.h"
diff --git a/target/arm/tcg/pauth_helper.c b/target/arm/tcg/pauth_helper.c
index c591c3052c3..5a20117ae89 100644
--- a/target/arm/tcg/pauth_helper.c
+++ b/target/arm/tcg/pauth_helper.c
@@ -22,6 +22,7 @@
 #include "internals.h"
 #include "cpu-features.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "helper-a64.h"
 #include "exec/helper-proto.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "qemu/xxhash.h"
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index c442fcb540d..0600eea47c7 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -24,6 +24,7 @@
 #include "exec/helper-proto.h"
 #include "exec/target_page.h"
 #include "exec/tlb-flags.h"
+#include "helper-a64.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "fpu/softfloat.h"
 #include "tcg/tcg.h"
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 7a8cd99e004..1a54337b6a8 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -18,6 +18,7 @@
  */
 #include "qemu/osdep.h"
 #include "exec/target_page.h"
+#include "helper-a64.h"
 #include "translate.h"
 #include "translate-a64.h"
 #include "qemu/log.h"
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 33a136b90a6..7451a283efa 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
+#include "helper-a64.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "fpu/softfloat.h"
 #include "qemu/int128.h"
-- 
2.47.3


