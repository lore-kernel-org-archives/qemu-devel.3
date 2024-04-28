Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D917C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 22:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Cov-0000HN-4Z; Sun, 28 Apr 2024 18:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Col-0008Fh-Nc
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:16:22 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Coh-0005fy-RE
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:16:17 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a58ebdd8b64so112212566b.0
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 15:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714342574; x=1714947374; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h6EbUiH0Q23M0FjKSUv3qw/noMjcf2vJ04Bs/jaSM9I=;
 b=FbGoi/44IKm7FwtF0l2gYiXnMQlnd6VEBLjOGqyueS2HoA1wVcZ0sv+s5wTembXKdB
 mIRgRwFpZuSHn8lL6KNWhjswy17JNDfh7owq9maHhSk0OTlCZ/ZbbcmoG+lfG3X4hy1P
 QsS6qcaawu5u4UogpM00i8rFjcrcuBTqTLFgjUo+A20J7mEJYTeUYgou26IlQJol/YKh
 jCtwLaHaTGQhbnn3cNQeh6fGHnuodrfqWpGqwRfw5hxE91ZmVj9OkKmiDSIHOIfR+nTz
 2JbURZdP6V1xkT6oRBwZQjVRbuzeTbDAeXJfPKEIkkDFGoAqtWHNeQ3eq8E4mkF4+xw3
 DP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714342574; x=1714947374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h6EbUiH0Q23M0FjKSUv3qw/noMjcf2vJ04Bs/jaSM9I=;
 b=QkqSgTLdFsxHOVzxifRvTy+9jKkvQW8X+dLTXhJD/pyKrG+jl9GvEljMUQXE9/1sDw
 uiCiuekYGq4WMjxwGixgCuJj0ASFXGe5zUw2xkjH1+3nfbo9c8lLS2uu7ZKa+tbUWt5X
 7srWehsXjXo9JjrMWtbfLYo7i+PYfkJE0yS9a+Nv7VpIa7XcqoqZ+i2K4AibGFxdOvNx
 3JqaOMUPb02twNSlvbYYdU9Sp2X4vCva3uzlM5+LoAUqAyISSEKeTyS/Pkz7CxOe6lHT
 MgRcvG8KvnhBOAfr75lGIvB0IS5NMsozR8bdL0xTIv6lgG2Tk4iSPzB6WqoMFumik004
 HKlg==
X-Gm-Message-State: AOJu0Yyugdjk1gjOmg+qockZNUdFu6hKTAjvCAVTFYgQFdbsSfeMbUEA
 j5sDTVRFDf6/56TNO7wsgw6vwxocmkDUPocJlKMxzAy6csEj1bwMQaocOJtHsAhcS+/Dp21DTMl
 S
X-Google-Smtp-Source: AGHT+IGBfz57FjzrEnS/vD5KgRAh78Z57ZFLDXjtIf07SRHZuv+QBR5wHxEWX48G0cyXPukTBcZzNw==
X-Received: by 2002:a17:906:470d:b0:a52:5925:2a31 with SMTP id
 y13-20020a170906470d00b00a5259252a31mr5118406ejq.29.1714342574107; 
 Sun, 28 Apr 2024 15:16:14 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.142.130])
 by smtp.gmail.com with ESMTPSA id
 dq16-20020a170907735000b00a524318c380sm13190910ejc.80.2024.04.28.15.16.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 28 Apr 2024 15:16:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 15/24] accel/tcg: Restrict IcountDecr and CPUTLB to TCG
Date: Mon, 29 Apr 2024 00:14:41 +0200
Message-ID: <20240428221450.26460-16-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240428221450.26460-1-philmd@linaro.org>
References: <20240428221450.26460-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

IcountDecr union, the CPUTLB* structures and the
"exec/tlb-common.h" header are only required for
TCG.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/tlb-common.h | 4 ++++
 include/hw/core/cpu.h     | 9 ++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/exec/tlb-common.h b/include/exec/tlb-common.h
index dc5a5faa0b..a529c9f056 100644
--- a/include/exec/tlb-common.h
+++ b/include/exec/tlb-common.h
@@ -19,6 +19,10 @@
 #ifndef EXEC_TLB_COMMON_H
 #define EXEC_TLB_COMMON_H 1
 
+#ifndef CONFIG_TCG
+#error Can only include this header with TCG
+#endif
+
 #define CPU_TLB_ENTRY_BITS 5
 
 /* Minimalized TLB entry for use by TCG fast path. */
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index ef8b85b6fe..dc28920bcc 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -27,7 +27,6 @@
 #include "exec/vaddr.h"
 #include "exec/memattrs.h"
 #include "exec/mmu-access-type.h"
-#include "exec/tlb-common.h"
 #include "qapi/qapi-types-run-state.h"
 #include "qemu/bitmap.h"
 #include "qemu/rcu_queue.h"
@@ -256,6 +255,9 @@ typedef struct CPUTLBEntryFull {
     } extra;
 } CPUTLBEntryFull;
 
+#ifdef CONFIG_TCG
+#include "exec/tlb-common.h"
+
 /*
  * Data elements that are per MMU mode, minus the bits accessed by
  * the TCG fast path.
@@ -311,11 +313,9 @@ typedef struct CPUTLBCommon {
  * negative offsets are at the end of the struct.
  */
 typedef struct CPUTLB {
-#ifdef CONFIG_TCG
     CPUTLBCommon c;
     CPUTLBDesc d[NB_MMU_MODES];
     CPUTLBDescFast f[NB_MMU_MODES];
-#endif
 } CPUTLB;
 
 /*
@@ -337,6 +337,7 @@ typedef union IcountDecr {
 #endif
     } u16;
 } IcountDecr;
+#endif
 
 /**
  * CPUNegativeOffsetState: Elements of CPUState most efficiently accessed
@@ -346,6 +347,7 @@ typedef union IcountDecr {
  * @plugin_state: per-CPU plugin state
  */
 typedef struct CPUNegativeOffsetState {
+#ifdef CONFIG_TCG
     CPUTLB tlb;
 #ifdef CONFIG_PLUGIN
     /*
@@ -356,6 +358,7 @@ typedef struct CPUNegativeOffsetState {
 #endif
     IcountDecr icount_decr;
     bool can_do_io;
+#endif
 } CPUNegativeOffsetState;
 
 struct KVMState;
-- 
2.41.0


