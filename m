Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF66CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 05:34:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOqYh-0007M9-5Q; Mon, 18 May 2026 01:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqYL-0006wv-0K
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:30:09 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqYG-0003cT-Ls
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:30:07 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-47c7b282d73so1382191b6e.3
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 22:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779082202; x=1779687002; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hJekX8dH52yMvYykB5HOFELCbhNNSoNRaiTZ7e0Y8tM=;
 b=gYEcar2dxMhf2l1yZFRwOEsl36vzLFzhjLjRRjNPtacTiug+QjHSkm89mv1OcSJmoD
 Q8XJnkJfMpKb4FW01gO0IkODa52iMLW5bqcX0oAGl9mOjSa1JyWBXgW6nqWv+btNdRaE
 x9Q9B9gSIgXeluIzEARN6pawEUDds8KYNN3fj4JaSY+RqBFj9m2rvZjhdtK7o1ApT4z1
 j7smFD+8xRW6POEktRLHqVXwCIZLbPc67i7NncWzTvAbObzPF/IgOzMBSbURZMV+SZnA
 pu3mMcoi0lYAuA6l2mGcNnngIOIaO7LmpQ3wBqw4eEvhQAO95a89bA/MXhBpzOat+vRU
 G8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779082202; x=1779687002;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hJekX8dH52yMvYykB5HOFELCbhNNSoNRaiTZ7e0Y8tM=;
 b=Ew8tSPcApNWIv+0T8af/QxWDVbPSxlPBT/+qnW+FoZU2azTa7r6IbWVwLn5eNDzR4k
 0p+Uu9cdtfsGNeKxQpdVQTj7I6OfhqJrzVWRhjREEk+SSD0G5RJANzM+uETBvo/bhEyw
 M6PGNQXhYyNyoTcK2r3kyyrNdkKlu6RdL/vstykyhpX0LXCUwkpyjkTqydLApDO2Db10
 X/m0s4fwF585vUFVfhhEFN2ClJV5w1aXkcYYgLGtVkMJAheovCOVXbf6WLWM42xw1Ayp
 PE1QSCqMoVS1S55RH1IzCZKH+qIYYfe9+IUwq67GU8aFSgg1KLA/pTHmCJSJH1HvtJrT
 99HA==
X-Gm-Message-State: AOJu0YzY+VF3Ro4L8bV6cR4FwWhaDGJ6wquCld2ifprmLc6+0fmsNzU/
 Txhy33Uu6dJheK2UJpfoPhUzNVv6p0wTL7M0WKR8Fh17iO3LrO0C1o4E
X-Gm-Gg: Acq92OENeIBSx9AoyIoKenx2V4PdSRmvc9cyMg4ozg0JzwZVXRlwypE29UhR9V95D0C
 KgCiyHHUfIc/tr62gRdOke4KTqvr3HObcjWxKOnv8TPGHBE/P1TPGG0rAriLoU8qvg39DBxGBua
 nRI+TMsPdPgJ+5QvUj2yOeSP7lGEjeKSZnU0UuDKrnReJRUJrU918wGxeJ+u+fKi6VqWgSMm6FK
 6HAyb1qWskRALMFJ+2H+GogbHss5UQUTim6zi7X0ve4wEG9uz6MvCpJbIS+Y/cYEH8/BdOJL7+f
 CGjgZN5lr01DReAEX/yooAGlWSA0plUYr7S3goG0vBUeFaBRPAMCAwITQfP2S0yGTY5BlMGm6Dk
 3I1lhhmO52ALFHdN2XwA7ZkAqUPrnDEObF3ELf6USl12Eei6szXXhK1Lt5iWWCE2WtgoZDmNx+Q
 oO4SqpRWoI/RFbV9VgmxJJ2Vc5FAFpcYZInkB89lSaRXwVKdkLmLfvIWw5UFo890v6ZB2lOZdBD
 EK396yeYS5MEOiBydC6CZP09o6iIMD8/tUgIeDOjqP1UQgizSOdC+3QKY0WzJF+XmgPM3Q=
X-Received: by 2002:a05:6808:1704:b0:47b:c782:1214 with SMTP id
 5614622812f47-482e597e717mr8805881b6e.37.1779082202033; 
 Sun, 17 May 2026 22:30:02 -0700 (PDT)
Received: from mac.localdomain (71-218-255-245.hlrn.qwest.net.
 [71.218.255.245]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-482ee5349a5sm4628357b6e.15.2026.05.17.22.30.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 22:30:01 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 17 May 2026 23:29:32 -0600
Subject: [PATCH v8 35/35] target/mips: expose Octeon68XX floating-point support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260517-mips-octeon-missing-insns-v2-v8-35-206151ee77ec@gmail.com>
References: <20260517-mips-octeon-missing-insns-v2-v8-0-206151ee77ec@gmail.com>
In-Reply-To: <20260517-mips-octeon-missing-insns-v2-v8-0-206151ee77ec@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x22f.google.com
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

Octeon68XX cores implement CP1. Advertise that in the CPU definition by
setting Config1.FP, enabling the writable Status bits, and providing the
FCR0/FCR31 defaults used by this CPU model.

This lets guests observe the expected floating-point feature bits and
use CP1 with -cpu Octeon68XX.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

---
Changes v1 -> v2:
  - Move this CPU-model correction into a separate final patch.
    (suggested by Philippe Mathieu-Daudé)
---
 target/mips/cpu-defs.c.inc | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc
index faefab0473..cc1916232f 100644
--- a/target/mips/cpu-defs.c.inc
+++ b/target/mips/cpu-defs.c.inc
@@ -997,7 +997,8 @@ const mips_def_t mips_defs[] =
         .CP0_PRid = 0x000D9100,
         .CP0_Config0 = MIPS_CONFIG0 | (0x1 << CP0C0_AR) | (0x2 << CP0C0_AT) |
                        (MMU_TYPE_R4000 << CP0C0_MT),
-        .CP0_Config1 = MIPS_CONFIG1 | (0x3F << CP0C1_MMU) |
+        .CP0_Config1 = MIPS_CONFIG1 | (1 << CP0C1_FP) |
+                       (0x3F << CP0C1_MMU) |
                        (1 << CP0C1_IS) | (4 << CP0C1_IL) | (1 << CP0C1_IA) |
                        (1 << CP0C1_DS) | (4 << CP0C1_DL) | (1 << CP0C1_DA) |
                        (1 << CP0C1_PC) | (1 << CP0C1_WR) | (1 << CP0C1_EP),
@@ -1011,7 +1012,12 @@ const mips_def_t mips_defs[] =
         .CP0_PageGrain = (1 << CP0PG_ELPA),
         .SYNCI_Step = 32,
         .CCRes = 2,
-        .CP0_Status_rw_bitmask = 0x12F8FFFF,
+        .CP0_Status_rw_bitmask = 0x36F8FFFF,
+        .CP1_fcr0 = (1 << FCR0_F64) | (1 << FCR0_3D) | (1 << FCR0_PS) |
+                    (1 << FCR0_L) | (1 << FCR0_W) | (1 << FCR0_D) |
+                    (1 << FCR0_S) | (0x00 << FCR0_PRID) | (0x0 << FCR0_REV),
+        .CP1_fcr31 = 0,
+        .CP1_fcr31_rw_bitmask = 0xFF83FFFF,
         .SEGBITS = 42,
         .PABITS = 49,
         .insn_flags = CPU_MIPS64R2 | INSN_OCTEON,

-- 
2.54.0


