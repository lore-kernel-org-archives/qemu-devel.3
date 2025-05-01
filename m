Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8255BC369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:26:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbPS-0006QY-IJ; Thu, 01 May 2025 17:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbOo-0004b2-Ui
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:24:55 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbOm-0002Bo-NB
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:24:54 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-736b350a22cso1242999b3a.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134691; x=1746739491; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nJR5rA8G7peaLdmnNfXC4dbOSl1Fc6PId1P5lzDPvoI=;
 b=y22gnZ7T0WMI2lPXJAh8M1fWcukRhqFGD4SIDzqSKSF0xhg3gBcajx07aWPDnVrzjx
 xzuLWeN6gLMZ9FYXC4BTBZFipqAD2iPo+Sc7uXpQyK7Uk1XiQxVlk2BHbh0G1n3BGJd5
 4OfUgrVJNdYCMxE8hefz3U+SyJtjtpk4udq2t0Zkn/WkD6lbr/N1Mb3tWb/b4nye9k3r
 6DFZu2knjENtHTyiq/eBlsHh5JU7Jcy8gp2aBgjPn1F/I38++uIPOin6SHEUmR/stjnJ
 hCnf2qLK0GakaIFsQWKkT9fsrMAa9WgciJcF9RitcFdoxLRCvURHtu/U22NRpRr3N0kI
 JHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134691; x=1746739491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nJR5rA8G7peaLdmnNfXC4dbOSl1Fc6PId1P5lzDPvoI=;
 b=FdQQkXoLPWiE/4CjeVva67TxMK0p5eG3d/68w6ITuGCwP/dDQchd3o0am12varPXXE
 Wztff/P6K/pYdbcTsKVZTA62UadbVeF1VjMrKvqccL7dDK0w257XKZ/bb7lmSatjJEZb
 LRYBHwgBgH2Re3XU026RDkm+AR2VZf4i3wRwkyAejzOeFkGb1Gk84L+lsxN76LhaKda2
 xKb2YKBy53GFzSzitJ0RSbnrBWO1BkDLH8SYQczEmRMtjMHY1M38OfGPzUUXxLU1cloX
 eNM9Yg6UFodV3M/ztjNb/McRl/fQ7LeryoyLVVaXml+d0k54LUCGpV/A5DJBNgBzedyz
 72BA==
X-Gm-Message-State: AOJu0YxtbmWcM3fTKHGzqkLM+XzUCelgA6MfzA3XgZ7usX6DwzlYMXbG
 o5ON0nhab2sASOanYGSY4P430Q3J1/+UlBo7HOrd2XYOwsuhfqpm05r9RdWf8qUsx60qwMLpf+1
 N
X-Gm-Gg: ASbGncsgYdG0eHS4ep9Gpe5SaW9rrTANIJZt+s39QKSOt9JUuYrrvdMsLqJpoHo4948
 /NSrhVaTlA5f5vqyxR3OF7BWxxz1C6nq4gBFutQGwHsNlfa0dGfuXIztZ+2vzSruti1faYlPkbj
 9ah4Up28Smd0oY4xWdTSaM+uSMFaNr38EhI3o/4ho1UyikYK0abjIp3bpJVZBap5sjEJwgVgqI9
 Sb/fNcvTPrjEWTrQfqofo+7LW1fiof9btf9qrd7+hdT6v1ieRGL4ZwfVrlPg0FEiAVFmkY959JC
 U1n0iyrcoMwGWg3XEWFefy+c2+GJvhEC16chAEjXAwLOpQX1JaSPZ/+tJeTKZPYFOlVKdXweLG0
 =
X-Google-Smtp-Source: AGHT+IF5gnslwRycSuZUhZUfBr7P3jws3g75V9HMO/5tfsGLMbZzAjuh9oeR52BVT/7e7/MAvmRq9A==
X-Received: by 2002:a05:6a21:3a4a:b0:1fe:9537:84a0 with SMTP id
 adf61e73a8af0-20cde951a73mr614149637.15.1746134691275; 
 Thu, 01 May 2025 14:24:51 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590610desm135897b3a.146.2025.05.01.14.24.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:24:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 46/59] accel/tcg: Build translate-all.c twice
Date: Thu,  1 May 2025 14:21:00 -0700
Message-ID: <20250501212113.2961531-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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


