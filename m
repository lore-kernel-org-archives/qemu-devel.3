Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C972DC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 23:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAGVp-0001lr-9q; Wed, 30 Apr 2025 19:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAGVj-0001j3-Pf
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 19:06:40 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAGVh-0007VO-Cy
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 19:06:39 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-736e52948ebso538025b3a.1
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 16:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746054396; x=1746659196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JQMSsVL5Qlj5plf+juQAIXCjkfEY+x7lY+AAGxAAiXU=;
 b=nSec6mJtJgr8tmi7TAjS6j0e+hpWYI4s3SdXt3qXRFzzRntuF/JNcHorQonwklnoMw
 lZ3vrKzPbfUi5/TnlFH3QKTI0z9vliP1r4FuQ8ZlLh/aaznIpG8kC19tEcY/e16KwEYR
 1lBIrS5Fxmw9GzF4UyADpy7mEFBRkRpp0Fmibe/gS3BKyR3G/zZcfzUfHs34FzOgpK1E
 2cXfHi5rRDtMdcbezsguUtGqNM8DRR7bscGi5uCR4XPmCxxEA3/AohVKG9C0Tm3j0UkR
 ur4tz9kVh/jZ5CQTTkD36yqZwtgyt70HHC7Mw/HHB+y4NR/xb52PX0XF3Ff9l5/DyLVb
 RZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746054396; x=1746659196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JQMSsVL5Qlj5plf+juQAIXCjkfEY+x7lY+AAGxAAiXU=;
 b=v0jgl6kbpnMFEKuxyVi7zne2OUDHbogUw/INxKgCR4Sa37Vg5QDjvvyQqVU1krWoS4
 BbzhYRV3XXX6lHWIAr56mQ4EKCketPA+FCgSZo9Ia/h8GQ9FuKb24+jEut9do8gGwEN+
 NRg5ac3GtFeSpHSIunnRdUDZ6G9JKhSEFsEG0QYxfpZzgGb4mUvxhaJXvUpjdaetaoJ3
 14jPcAJdlrA9AujcOBdWJAmMBCxPbf8rAeDBjoD8ID5fEh4z7B68wm0lyjs+Y7pdjGap
 2HKyqJu49dQvVpDwR+KiW/3Kdj05Lr+kmVE+P74gc/wSgZ8PTeY9UzEShsQqharfP2LE
 lE1g==
X-Gm-Message-State: AOJu0Yz1nDJs+iJGX6DHNETNGOFanUvj614Gf5yzdczMJU9cY2XyLQMW
 5Ikqkt25R0PpclmbN4VS7Zb2n/8pc0LjJZAycHRp0wZ9lXXWmPnK7vfyRUKyNOXnSi7cNUuAIqn
 6
X-Gm-Gg: ASbGnct77ewjcZ5h8E1WUa1vXF6QiTIVZuquh2qy0PzcGonoCGVhCUwldcir6tboYF9
 ykFkweBzx/gbGGiv3mg2HOvpvPSr2+AbQUbIVmsTi9JW9ZDKjN/qW/tQVUqauhCNDZYSFwuTGBH
 IfyHHm+HChqxLGs7K7vqpqf2NsNgeSzlM2XyVw7aTIXsxHkAjXEThhLSaYm/f79rTNvwP8Z0wkC
 2YWZUvlU91m4TO8igT+svMZCrl0LJIpGrqGRREvCpdvA5Zmyb3qi/m3Ni7+YCJ+edD/Ne8UmYGQ
 HT2xcWpmLhdcHtxIFB5Y1j/4ZsazQCoVm/CpumgFo6rn0+O80T9T+2sffgQpytKBZScLMYK5BfU
 =
X-Google-Smtp-Source: AGHT+IGa75+rTqlB6U2gbH/010nm8GLmf5QG2C7y7qFQeekZ7he9GRxMNPpmD1HH7/inHFbiQQcaxw==
X-Received: by 2002:a05:6a00:3915:b0:736:3768:6d74 with SMTP id
 d2e1a72fcca58-740491c9454mr501166b3a.7.1746054395738; 
 Wed, 30 Apr 2025 16:06:35 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74039a30e2fsm2323287b3a.103.2025.04.30.16.06.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 16:06:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/6] accel/tcg: Build translate-all.c twice
Date: Wed, 30 Apr 2025 16:06:29 -0700
Message-ID: <20250430230631.2571291-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250430230631.2571291-1-richard.henderson@linaro.org>
References: <20250430230631.2571291-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Remove lots and lots of unused headers.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 32 --------------------------------
 accel/tcg/meson.build     |  2 +-
 2 files changed, 1 insertion(+), 33 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 6b6e10be9d..451b383aa8 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -22,46 +22,15 @@
 #include "trace.h"
 #include "disas/disas.h"
 #include "tcg/tcg.h"
-#if defined(CONFIG_USER_ONLY)
-#include "qemu.h"
-#if defined(__FreeBSD__) || defined(__FreeBSD_kernel__)
-#include <sys/param.h>
-#if __FreeBSD_version >= 700104
-#define HAVE_KINFO_GETVMMAP
-#define sigqueue sigqueue_freebsd  /* avoid redefinition */
-#include <sys/proc.h>
-#include <machine/profile.h>
-#define _KERNEL
-#include <sys/user.h>
-#undef _KERNEL
-#undef sigqueue
-#include <libutil.h>
-#endif
-#endif
-#else
-#include "system/ram_addr.h"
-#endif
-
-#include "cpu-param.h"
-#include "exec/cputlb.h"
-#include "exec/page-protection.h"
 #include "exec/mmap-lock.h"
 #include "tb-internal.h"
 #include "tlb-bounds.h"
-#include "exec/translator.h"
 #include "exec/tb-flush.h"
-#include "qemu/bitmap.h"
-#include "qemu/qemu-print.h"
-#include "qemu/main-loop.h"
 #include "qemu/cacheinfo.h"
 #include "qemu/target-info.h"
-#include "qemu/timer.h"
 #include "exec/log.h"
 #include "exec/icount.h"
-#include "system/tcg.h"
-#include "qapi/error.h"
 #include "accel/tcg/cpu-ops.h"
-#include "accel/tcg/getpc.h"
 #include "tb-jmp-cache.h"
 #include "tb-hash.h"
 #include "tb-context.h"
@@ -69,7 +38,6 @@
 #include "internal-common.h"
 #include "tcg/perf.h"
 #include "tcg/insn-start-words.h"
-#include "cpu.h"
 
 TBContext tb_ctx;
 
diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 0bb089299b..7eb4619aea 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -10,6 +10,7 @@ tcg_ss.add(files(
   'tcg-runtime.c',
   'tcg-runtime-gvec.c',
   'tb-maint.c',
+  'translate-all.c',
   'translator.c',
 ))
 if get_option('plugins')
@@ -22,7 +23,6 @@ libsystem_ss.add_all(tcg_ss)
 tcg_specific_ss = ss.source_set()
 tcg_specific_ss.add(files(
   'tcg-all.c',
-  'translate-all.c',
 ))
 tcg_specific_ss.add(when: 'CONFIG_USER_ONLY', if_true: files('user-exec.c'))
 specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_specific_ss)
-- 
2.43.0


