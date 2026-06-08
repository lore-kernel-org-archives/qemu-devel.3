Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C2ECD6E79
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 19:01:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWfCz-00013L-UR; Mon, 08 Jun 2026 15:00:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wWfCl-0000xU-VX
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:00:12 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wWfCi-0006bI-D9
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:00:11 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7e6f27619e7so3821306a34.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 12:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780945207; x=1781550007; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=48Ai9CIUSaGzXZYONL1dAcOkXHUHQVK32aP2mmtN5aU=;
 b=LH4XhlEGYus3g+QpHt54dp9xba2JXiqudxIJZQ9n3BAi6X6ga78f1FU1hx0iIYgB0J
 WIkT4xgSw43YqsR8m39Tjwif+u7Hd5p8Uikc8+6hgxA55rMoMMG9pOuWb/rLpaBPc4Qg
 3DaiNYk41LoZu6wLvukP9oEpF7Ve+vok8DzEDlng4HrbDIGRf++K/blKUbb6F7Zgonw3
 DzINF47MrYCwqJGLPlpB6ZKpRWXpSc6uirNeGx4Jv/oJ3EQ9rMFM5xSfdTD0w0L3Yo2M
 Ef0ZGUAQ7ljZnD0Pnj5Jnp3MTl+jTZI7JAWDl5IcumZmZErV0n/GJRLvf3QKMEecttEw
 y3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780945207; x=1781550007;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=48Ai9CIUSaGzXZYONL1dAcOkXHUHQVK32aP2mmtN5aU=;
 b=gfhz02XHNkWvMtpomSPojdmgsvkc6LGphiQOohlothF4tgMa7lTcFT99L17OtcQL3O
 W++go57+kpgGh58tU0yH3Zv3R8itmm67tCZlKX0LE3XDv/KVb7OuruSh1asvai3Enhau
 7Y2Tk/7zEPoUrD1tJHbAS8UhvAAuTJ9+S890VZEuFiKe7SxOW3O3qLSC4Pu35B8VNsqs
 gwiu+6bSA3uTG6uz2i22G0CziNcDBgOZBH1s+twX+yFmZ0jit6xAgU/sjolZ1xvv1bC9
 7tuqeqyxtmJno4p8cAQUTpfF88l3gqlB/D19e5apaSwbn3eFLmPitfLEjnG2szxqZSmh
 FbrA==
X-Gm-Message-State: AOJu0YzN9BJ98G0K/L968Ia87QLxuMyhLzpYB/pMONV9zHBWkReeJYt4
 OaSIu3A/isFQPVaezFw/EAW6JUgUJ7zAeH8EXkQLDCTcoAv6OMiU0nEmMq4bFvr2yz4=
X-Gm-Gg: Acq92OGZTaZUEepdOJ6YDN3R/rxB9Kpl0rB6MpzVwlRQe8rFsF3DwpspppFK71VIvRU
 dV8f1GEpPJKGE+PtN4bGFynIof6l+ABcJ8K5HMxaleDcEnJml9vyTipcsokeZHynWUcCYGXx+i4
 2+AW27L2ajlfO4TXCW0Yk1LIeHFGmUq02QJdKLiAo8vBoe5Ft+1iGmEk4YKCRiPBnv60fvdHXYj
 p+T33kmqPop56xjkl4MmkUWWNq1+ZSJHpmgCDkxQNn7ssEmpqvVResqg8iiKyGzj9y4q+J3m/WC
 mDfYHpHczmneSLSo27IPx3bXoY7RHAIYcNMW5/K5nAEraI3mQKTJodE0jO2LF17J/x1DuKFEu0/
 lcE0ZVYcuD+FsY1ooulxeHFA19F/9imDOcnVK9tfRvf7ag8fGXNVN3unvtDekoRVpNCnmtrco3Q
 9VvwhqaOVyxfgHrq5ShUtwLotNG9SsvT9zU5ilzvktqbh2VC6A/J6syQCl//oU55ZkJfrI0e4PU
 2cnwZII6N7Uu69pG4GUudSUnPxGN8/gW99RAznUqdQZ+wBSn3rsNyFoIn1GB4Vm2TLCMKvCovVw
 BVPerpjWTJIjXoqsU3Ek4+O/iRg7TdWnGUBRs5KfI2w=
X-Received: by 2002:a05:6830:83b7:b0:7e7:682:77a5 with SMTP id
 46e09a7af769-7e70c61f3d5mr10752249a34.3.1780945207101; 
 Mon, 08 Jun 2026 12:00:07 -0700 (PDT)
Received: from mac.localdomain (97-118-5-210.hlrn.qwest.net. [97.118.5.210])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6e75db138sm12397777a34.11.2026.06.08.12.00.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 12:00:06 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 08 Jun 2026 12:59:27 -0600
Subject: [PATCH v16 02/21] target/mips: add Octeon COP2 crypto helper plumbing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-mips-octeon-missing-insns-v2-v16-2-daef7a0d8b04@gmail.com>
References: <20260608-mips-octeon-missing-insns-v2-v16-0-daef7a0d8b04@gmail.com>
In-Reply-To: <20260608-mips-octeon-missing-insns-v2-v16-0-daef7a0d8b04@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x335.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


