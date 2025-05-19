Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AEF6C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:29:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGs3t-0001Ou-TB; Mon, 19 May 2025 00:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGroQ-0007m2-Bv
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:09:15 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGroO-0004K2-EC
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:09:13 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22d95f0dda4so42468885ad.2
 for <qemu-devel@nongnu.org>; Sun, 18 May 2025 21:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627750; x=1748232550; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9+8m5dgUHffTrvncW6hBDGM/ivLaHuneNLED/QiZRAg=;
 b=f75CQJLz5+OjZSeeqJJeRkmRUQ+dp/L3kctCxmx7qyQWHl+1itMeY5QslMCEWY70xo
 HIP0wtTPkKIoFGFgz3Y3Uh+YjEGqoBubUyBAPmpcFP2KH8GJixUsNyjEG3wL/2GBm6mL
 5ugUkMv2abGZi2hv4mMAo/lgpY2DyMZpF1TM2GKRMA9c017aTeMcKwcko07ZFWv/HHeT
 CtyGCopAUjIg/YKT+768RBdk/C9aFgx6FvmpnT74k6lwK1tmOKkqqh8+SAtPM0SUBNs4
 7cK4rR0Y8kTxsnB07qlph4lNeZj1nG5FGb0FgO6K5uDAlVTnkjR7ImGWgdBslkKtsEKu
 tAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627750; x=1748232550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9+8m5dgUHffTrvncW6hBDGM/ivLaHuneNLED/QiZRAg=;
 b=VyybapadvmEu8arF3bXUsqaNySL1jHh0Mv4/RJg3CR/htB9M6UQr6crZ4vVV+zhoHf
 eW6lm2rjEiKS7tPWuuMkpdpXnNEXN+oEFXRX8FfywmFFETP6cMSOzx1h6R2NEKK4kLea
 e2l/GnTO23KNNtx7x1ryKDLzhzoSFL4lrZlKIDZMr0MPAgloCBaZzzvXCOXOPh+vDZT4
 EnMo+3uHdapRFGx6HIKy/DAUVomM6ogc+oDoDu8IRwrcXyA2DprnKnS4yaUBg05WgjfR
 yqjE7F7FqRrB8CcBi6EYKm+904/iTJq0hV6gYpMvXvQWjSeoR1Mceu1k3u+u3cPd5F6E
 fhKg==
X-Gm-Message-State: AOJu0YxGyB4m7A2tB/nSjn82Z7HzE56wClwJtcD7koX7YPXbsA8k5r63
 ljcs8ocJ53j2pM5kYz36lzlPgo6Tfmsoz9fSX073g47b8j1C9AauFFloImDuZg==
X-Gm-Gg: ASbGncsr3p/gy5x2bGA8ReKgHZWfseSs1hCvNmMNLHeZSjOjhn7OiaFkT4AMqwbkVd7
 HPACNOgUS2RNciP/pyub8811eZUV4dQk/qTjRSqQmnIdTEzVHhEj8klwmNexYHo9hlwCeKAlB+p
 xDbt5eu9z6TIUKGbqqAwJy65hF2atZWNCTZR4ORiTHusO4k2VONFK3r2KxU8Tor1neHrsSSGVOx
 uAL+2/YQWl/n6SvBlEMQWm+4AcnWJV+yZMVCTatYg4PlmYdBxxH3c4ovhcFYagK0MgHH78+PlSe
 4dKR/JZjqDVgEQZyIQRfOaaGOhmynqmQTWHcA+txrbk85ZZdnP1IGx7N45PgBAQAHz+c+B0mAEx
 1wfcVN8K98b+3jahAZUZbQ8XDGUXfKgbuHdum3wXbQ9iezq9ch/BZkKyz
X-Google-Smtp-Source: AGHT+IH9IW+xcFs2W1OGg3+FuV44wsEpcHuOoc6tY8aE9WOp7AoOJ8c4NPByYxXLbhFuPdl9l1zM1g==
X-Received: by 2002:a17:903:3d0f:b0:220:faa2:c911 with SMTP id
 d9443c01a7336-231d44e8833mr163446435ad.14.1747627749827; 
 Sun, 18 May 2025 21:09:09 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.09.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:09:09 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 38/56] target/riscv: Fix write_misa vs aligned next_pc
Date: Mon, 19 May 2025 14:05:35 +1000
Message-ID: <20250519040555.3797167-39-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Do not examine a random host return address, but
properly compute the next pc for the guest cpu.

Fixes: f18637cd611 ("RISC-V: Add misa runtime write support")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250425152311.804338-8-richard.henderson@linaro.org>
[ Changes by AF:
 - Change `& ~3` to `& 3`
]
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 53458491da..288edeedea 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -30,6 +30,8 @@
 #include "accel/tcg/getpc.h"
 #include "qemu/guest-random.h"
 #include "qapi/error.h"
+#include "tcg/insn-start-words.h"
+#include "internals.h"
 #include <stdbool.h>
 
 /* CSR function table public API */
@@ -2099,6 +2101,19 @@ static RISCVException read_misa(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+static target_ulong get_next_pc(CPURISCVState *env, uintptr_t ra)
+{
+    uint64_t data[INSN_START_WORDS];
+
+    /* Outside of a running cpu, env contains the next pc. */
+    if (ra == 0 || !cpu_unwind_state_data(env_cpu(env), ra, data)) {
+        return env->pc;
+    }
+
+    /* Within unwind data, [0] is pc and [1] is the opcode. */
+    return data[0] + insn_len(data[1]);
+}
+
 static RISCVException write_misa(CPURISCVState *env, int csrno,
                                  target_ulong val, uintptr_t ra)
 {
@@ -2114,11 +2129,8 @@ static RISCVException write_misa(CPURISCVState *env, int csrno,
     /* Mask extensions that are not supported by this hart */
     val &= env->misa_ext_mask;
 
-    /*
-     * Suppress 'C' if next instruction is not aligned
-     * TODO: this should check next_pc
-     */
-    if ((val & RVC) && (GETPC() & ~3) != 0) {
+    /* Suppress 'C' if next instruction is not aligned. */
+    if ((val & RVC) && (get_next_pc(env, ra) & 3) != 0) {
         val &= ~RVC;
     }
 
-- 
2.49.0


