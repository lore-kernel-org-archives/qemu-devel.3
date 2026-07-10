Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3560AC44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 03:00:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi1Pr-00086z-6b; Thu, 09 Jul 2026 22:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1Pf-0007uJ-Bf
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:56:27 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1Pd-0008OA-HC
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:56:27 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-84867f07d63so447961b3a.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 19:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783652184; x=1784256984; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MdcafjiFXFuJrZ0Mtwb0BBBWElZ4I5sC9RwHK2DaMdA=;
 b=nCRoLNNrCSO+Tiqg9cH7wkk9vo4l4v5nz34qLX4KB03MssgGwd7snAdSzbArZ9ufS5
 TH1WnEFvlokw2qtDZG81l0hvNKl/OT/Uot1zM/Qg8vAS3dUgTEIq2bfagS08l1Umz7Wy
 ZyZ1Xed9a771K1a/gi1Qc1XpVWtaYt8kS/+BrolDB+OBhvQis/aZ2foKJmsNrUTHPfOL
 hK3CiurxIUClwnV6tzthKCPtaeOt4+nKoNKqVeOoMgjnUNTwI+ioSt4ESfFpKHC/qMrz
 3txukCP3fbrgyJg74r1C0TWUiLnQkEgHMe8IjXpd9C4InuStodyIFZyLHVb70XW04DWw
 tEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783652184; x=1784256984;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MdcafjiFXFuJrZ0Mtwb0BBBWElZ4I5sC9RwHK2DaMdA=;
 b=Y1eyMw2QYNj7rg6xfqF+uhnxH+4D4VEkGeDlEDSsUhyF6+gfN8cXQMzyb+/7geVNoJ
 CyL4X2FanDcKRbNhTpdZ3h5px9RZzyESZb3kfIGCAFCbUYd+jauji905vl9iIxX+WU2w
 037DSG/MI1wa0fuhq99LSFWfUMlk+XbY9+jQykmrmQ5hy7PdCv3+Sc3UXgXMVre1gzc7
 J0ZcnEBnIGfB6Os8M/ttl3a5IkhDihKqH5FtoTrlZLpIoD9hw5rFuPUol5I5cbyGIZLG
 DjTgIvUNkHx3Bsa1orfYpO4MuY71RtrvnjxmSV9nU/sNY7cvOfMStbOzCspgjTprFF0z
 +e3g==
X-Gm-Message-State: AOJu0YxgEVNs7NHOI77FGgWJKdqDNPhVPdkUOtdKPmaaeyAXfPYqwTAt
 PlY37E07Z3caNfQjjL2oZ/463aYtt/7fWl+o0ak5oA99wDLh0HmE5+xZSrhV/w==
X-Gm-Gg: AfdE7cmkAFRqI7ETxFLTzZKyaH7r3uL8840uJw3iGQv13wBFqdfSABfUskcjmRK2E1D
 uBUDIFKPDq1xL3x3/DS3g4743uxFi1t1PktqTCUl1DQapcxKaRAu9QAOaAMxPp+E69kHDP1cqN9
 CO4Z8MmZnBrBypWuzp58iiq9R9AOzXjZKVmrMY3TYKPSRH8k+Nnv3ofLbogYOBIWyf7U7HbIk3s
 QEezR1vKtK1a6gLQRXnw4V9rmaI7iewFopIRQtLx+UbrLR+hHm2Il03aENRseB70bDtOwBbIxi5
 75Eg4EQcSDjSsIvKAcoPPvGDPU/SORROidl3U+C17ZQ0Q1npJkAu7BKbmiV0FURDcUGIdzZWLSG
 7rOPPSQ58ZjpguXqwykcI0Zau+dXmotGGIY1WveODp7OXHTCSKZJTsJ+ahyIYTZ6Jw+CQqnousb
 zpjCLpiYILu7/sdWGkz2tsOmk5fkz1LZA4QyjwcQ639g==
X-Received: by 2002:a05:6a21:4a89:b0:3b4:7b2a:6a0a with SMTP id
 adf61e73a8af0-3c0bd206afdmr12269169637.35.1783652184266; 
 Thu, 09 Jul 2026 19:56:24 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5af6e04fcsm4576769a12.4.2026.07.09.19.56.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 19:56:23 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 14/40] target/riscv: move debug.h to tcg subdir
Date: Fri, 10 Jul 2026 12:54:59 +1000
Message-ID: <20260710025525.1704417-15-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710025525.1704417-1-alistair.francis@wdc.com>
References: <20260710025525.1704417-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42d.google.com
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

riscv_trigger_* APIs are TCG only.  Wrap the usages we have of them
in cpu.c with CONFIG_TCG.

After that we can move the header to the tcg subdir.  This will be
enough to get this out of the way for the --disable-tcg build.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260703180538.3346781-9-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/{ => tcg}/debug.h | 0
 target/riscv/cpu.c             | 8 +++++---
 target/riscv/machine.c         | 2 +-
 target/riscv/tcg/cpu_helper.c  | 2 +-
 target/riscv/tcg/csr.c         | 2 +-
 target/riscv/tcg/debug.c       | 2 +-
 target/riscv/tcg/tcg-cpu.c     | 2 +-
 7 files changed, 10 insertions(+), 8 deletions(-)
 rename target/riscv/{ => tcg}/debug.h (100%)

diff --git a/target/riscv/debug.h b/target/riscv/tcg/debug.h
similarity index 100%
rename from target/riscv/debug.h
rename to target/riscv/tcg/debug.h
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d17ba0474a..a2887adf16 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -39,7 +39,7 @@
 #include "kvm/kvm_riscv.h"
 #include "tcg/tcg-cpu.h"
 #if !defined(CONFIG_USER_ONLY)
-#include "target/riscv/debug.h"
+#include "target/riscv/tcg/debug.h"
 #endif
 
 /* RISC-V CPU definitions */
@@ -856,9 +856,11 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     env->vill = true;
 
 #ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_TCG
     if (cpu->cfg.debug) {
         riscv_trigger_reset_hold(env);
     }
+#endif
 
     if (cpu->cfg.ext_smrnmi) {
         env->rnmip = 0;
@@ -1016,7 +1018,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
 
     riscv_cpu_register_gdb_regs_for_features(cs);
 
-#ifndef CONFIG_USER_ONLY
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     if (cpu->cfg.debug) {
         riscv_trigger_realize(&cpu->env);
     }
@@ -1031,7 +1033,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
 static void riscv_cpu_unrealize(DeviceState *dev)
 {
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
-#ifndef CONFIG_USER_ONLY
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     RISCVCPU *cpu = RISCV_CPU(dev);
 
     if (cpu->cfg.debug) {
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index ef0a8eae24..0ab613a298 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -23,7 +23,7 @@
 #include "system/tcg.h"
 #include "migration/cpu.h"
 #include "exec/icount.h"
-#include "target/riscv/debug.h"
+#include "target/riscv/tcg/debug.h"
 #include "hw/riscv/machines-qom.h"
 
 static bool pmp_needed(void *opaque)
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 885b4172c0..310c18db46 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -35,7 +35,7 @@
 #include "semihosting/common-semi.h"
 #include "exec/icount.h"
 #include "cpu_bits.h"
-#include "target/riscv/debug.h"
+#include "target/riscv/tcg/debug.h"
 #include "pmp.h"
 #include "qemu/plugin.h"
 
diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 7818d81fb0..36d12b6a51 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -34,7 +34,7 @@
 #include "tcg/insn-start-words.h"
 #include "internals.h"
 #if !defined(CONFIG_USER_ONLY)
-#include "target/riscv/debug.h"
+#include "target/riscv/tcg/debug.h"
 #endif
 
 /* CSR function table public API */
diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
index ba5bc6ae13..3c0fe70101 100644
--- a/target/riscv/tcg/debug.c
+++ b/target/riscv/tcg/debug.c
@@ -28,7 +28,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "cpu.h"
-#include "target/riscv/debug.h"
+#include "target/riscv/tcg/debug.h"
 #include "trace.h"
 #include "exec/helper-proto.h"
 #include "exec/watchpoint.h"
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index b73e3e9dd4..fe6350f497 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -37,7 +37,7 @@
 #include "hw/core/boards.h"
 #include "system/tcg.h"
 #include "exec/icount.h"
-#include "target/riscv/debug.h"
+#include "target/riscv/tcg/debug.h"
 #endif
 
 /* Hash that stores user set extensions */
-- 
2.54.0


