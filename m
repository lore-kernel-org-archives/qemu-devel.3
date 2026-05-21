Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0041FCD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 18:08:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ7mv-0000BT-HF; Thu, 21 May 2026 14:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQ7mq-00009u-9t
 for qemu-devel@nongnu.org; Thu, 21 May 2026 14:06:24 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQ7mn-00021h-Fg
 for qemu-devel@nongnu.org; Thu, 21 May 2026 14:06:23 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7dbe07d3ec3so3350666a34.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 11:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779386780; x=1779991580; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=z9OZKj50dZv5s1heY9l5Z9IxHiDUoqE1DOEEF5VctYg=;
 b=U9yWTBg/+PljeJQQraIM9UstlhRLFC9eMGuUxy20ChXLEw8impxWPfOqtwUY48jpfy
 O94T3bh1+SJAv/ZhGVEMHiR4f+7k3prMl10J0UCiaP5JFnoeJQtKPI3RvApR7SWrEfSh
 uyhrNftEb0fT1aWts4c9A457VOIPlBEvhJfVPjvd4UYyJf2O/WRQQq8MzTfR7E/7LBbv
 8+a/ulkl3uUxH2/3iWMil7W7olRQCnEdx1ghgLbRgdTPTdG/tB9FZX/GxO+JRldA7nN2
 YNuLqhWPTaj4B0jfDhn0bOjZRLe7u98F1C6Shzci/lAtwdaLh+7nT0xO40FgSGS4XtT5
 /itA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779386780; x=1779991580;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=z9OZKj50dZv5s1heY9l5Z9IxHiDUoqE1DOEEF5VctYg=;
 b=l2bpWTCU+eXAqYRPY80i847ZYddJ01Xcy4AcLlKrK6Du9cN9XAopZqyA5/Utsnohr9
 io/PtZNFBjkMKoqIxSv0T3nj75xPBaDmiB7ghb10Mqcun76o5M8aNZHnWnp32MZI1E1n
 FGQd/p86D8KohvP71iMi1jDLaxNXzbTq0Skz7hYGX7JpgPHKN23kt4789xWILBe3qX7P
 3hW9IYQCss2kdgw6hLVVR8rzkZ1jlp2t4ZpnkG8u6ySbeJbf2h+HLXB6custzPrIzL8R
 LHlbdwc06rh8AVZ85OyLlujHUSROu1EaIevt2nnT7hQUWbEPX/4tg3b7Au9DYBFxu5B1
 kgAA==
X-Gm-Message-State: AOJu0YxtM3xD8KSvtltUJxqVRox4fuuWrXFzIq3X150z1g3Y88z51w1r
 dx0WfC9WcDtWdAKYDs5YcQ14GiLp35j30lL9+6eh74wjcnlcmrVaUKxH
X-Gm-Gg: Acq92OGY5BjriO8gKAlYwFWZc9guDQN2jHZI9Zdu7PB0IHVhZjZ6/YvTtPPGXxExb1g
 Nt+c+2haVh3hJg3zo9OptBpgjc3M0vMF8ojC1v0dXc1J08RGfyoVQk77FXgMTQHgn72hm2Hs9rw
 AO5xKfRle+A4ciQLo48yUdEIHCjeNqTRKmSInQOvVtex9ymDVM+08oFQjw058pxSQvPBoRU2n2E
 78s/Zx/Qne7RJtZ89WblQER/1hP9yjpyo6oQ4LptFK3CTSacAqKhx70F03DiQkawoAY8QSEe6HR
 mtnFYDOShwAEdpmBYFKcTxzXPNVT3l3TXIZ7ORjhF3QAEhnewNdQHbedR2V3TuroHkS0BTGSHib
 Mn74hDOuCiYbxnIpTOrNLnNoz8kQmWo2JrmvddEYHTU7qJ0FM7rmFw3AvrMyff2GW4Cb6+1y8Qm
 VolG9BELkjGZ4Jke4Kc4r9BF9xXwWZZDFPWSeQ++XGbmfz0pCV/rRYYNgM7hjt9e//r4WfT+yYY
 GjyJp6mNHTb0dEP0EHLxpLadK4A1QcwJ9YOzWhtfA8f3U5L1Vc4S4MYIe/GgEs+4v8Ubm81JH+U
 bWs=
X-Received: by 2002:a05:6830:7186:b0:7d7:5113:f83a with SMTP id
 46e09a7af769-7e5fef032bcmr129565a34.25.1779386780215; 
 Thu, 21 May 2026 11:06:20 -0700 (PDT)
Received: from mac.localdomain (184-96-131-78.hlrn.qwest.net. [184.96.131.78])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e5f6ee286fsm903089a34.25.2026.05.21.11.06.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 11:06:19 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 21 May 2026 12:05:56 -0600
Subject: [PATCH v13 03/22] target/mips: add Octeon COP2 crypto helper plumbing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-mips-octeon-missing-insns-v2-v13-3-5a4cb8ec9cd3@gmail.com>
References: <20260521-mips-octeon-missing-insns-v2-v13-0-5a4cb8ec9cd3@gmail.com>
In-Reply-To: <20260521-mips-octeon-missing-insns-v2-v13-0-5a4cb8ec9cd3@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x32a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Add the Octeon COP2 crypto helper source file and build it with the MIPS
TCG target. This provides the common compilation unit for the COP2 engine
helpers.

The instruction dispatch itself remains fully decoded by decodetree, and
operation selectors call per-operation helpers rather than a common
selector-dispatch helper.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v9 -> v10:
  - Remove shared-window selector constants and the shared-mode setter.

Changes v8 -> v9:
  - Split helper plumbing out of the former monolithic COP2 helper patch.
  - Keep shared-window selector arithmetic local to octeon_crypto.c.
---
 target/mips/tcg/meson.build     |  1 +
 target/mips/tcg/octeon_crypto.c | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/target/mips/tcg/meson.build b/target/mips/tcg/meson.build
index fff9cd6c7f..4ee359874a 100644
--- a/target/mips/tcg/meson.build
+++ b/target/mips/tcg/meson.build
@@ -18,6 +18,7 @@ mips_ss.add(files(
   'lmmi_helper.c',
   'msa_helper.c',
   'msa_translate.c',
+  'octeon_crypto.c',
   'op_helper.c',
   'rel6_translate.c',
   'translate.c',
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
new file mode 100644
index 0000000000..df5b0449ae
--- /dev/null
+++ b/target/mips/tcg/octeon_crypto.c
@@ -0,0 +1,16 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * MIPS Octeon crypto emulation helpers.
+ *
+ * Copyright (c) 2026 James Hilliard
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "internal.h"
+#include "exec/helper-proto.h"
+#include "crypto/aes.h"
+#include "crypto/sm4.h"
+#include "qemu/bitops.h"
+#include "qemu/host-utils.h"

-- 
2.54.0


