Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0211FC369D1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 21:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7KuD-0001IM-8y; Tue, 22 Apr 2025 17:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7Ktx-000104-Ds
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 17:11:35 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7Ktu-0000Px-U3
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 17:11:33 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7376e311086so7939001b3a.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 14:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745356289; x=1745961089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p5VV71JY8goeor4xQCwdYnut93y9ysd8cImiGLe4Oic=;
 b=cdIMRHb0xncuM2ogmE18r1QK5LH6SKLBjGovynlt+fA6VojwqYzZO5P1SuO7YQhv+m
 TzHnd8OfDWpjirtnj5gwMIOBeEiY6S66e84xD+b3JDlfy9gWTbf/ZrYTjOaI3TIxuXRv
 jDe76pZKzkoMDFLvPAV749jCLLZV4LaMkfxO/IPW8V2FyIfFFCznsZu4TysWmgKGhHal
 00uSmAYUusUalFhSJzoMAGqUKUd10ZV0oMlgnA3BC3ueNiOjssQSVz23feeLq7JUKhA9
 u+ogYriRVKqu9pX/Gsf2JRheoJVdAbreFn/R5TOKXWRdm0MDPhzKjDqHiDZzs7zliE1o
 bHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745356289; x=1745961089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p5VV71JY8goeor4xQCwdYnut93y9ysd8cImiGLe4Oic=;
 b=t0Fajb9/YnTrCR0WV18A9LkkYff8tyveNADP23VtXp0/0GWdUc1334g7SYmI/QWizg
 9YxwV8ZbBpBmWXSfH4eX7pf38eHveeJpa2RuE9tuGiqDe5PuoKfxOpBMaqmQZC0BKNea
 rvj1QB2raz8xOuVA/2xoQF+2/P3o03laWNsEeprDEJS5dY1k+cVx+JTF5QTONyghz1Rf
 8X8KPT569HHZ2n8zeJ5SHdfBmeGXe68I3pJgeXAFSJiL3KN+oYjJCNwNpRC86XTUIvSm
 ErFghgOSm2HGJ9EKOY3mLRr1hKQCj/xlURuWP/gERjtrGXnB4Uaa7prwJA6nkknOf80b
 FXZQ==
X-Gm-Message-State: AOJu0YxnpwD2JMu69ULz1MhUJWZnfKiFyXX3GEMFl5iJFla0Kdj+/zBi
 AeXDQ2UcaviEZdcRa8HpnL1yQ0TX7uyquEtAUyNVVizTvzv2KZcU3/fXZ+wDwjq+X6wm4A5j183
 a
X-Gm-Gg: ASbGncsulLrPaKcVZAqYwHhDVJFfP30fdoQleNijLfvPEQ9RL9DtaFVGs/11oe6EnGP
 IrDL2A8olsFEFeGgK2lOGS5EgMRDVVd35JJlS8G18YHWVB7ZK78sqPbr8UKCSpjOG6zEo/x9UvL
 /L3oNpJ6STsTcHVBPsp+KuDAinL+yrfuW14dOn1SZjT4pXmVxTNP9wmcIJAMK/W3Ev4GuA4DA5a
 l4S8lBvFVHXti8A+YgCPrbuTYuRI9lEjX3vRKQvDGFqJqaldorkMkgW0WMfLsSC5YwaSa47zgCP
 44ciBU6APQ6X7j2Gm8a/G5+G4Kcwd3gFnqgq75IhpkJRKaTjIPEEv9YUmWcGvLjvPto7pi5xv7u
 BqyYLAbvIXQ==
X-Google-Smtp-Source: AGHT+IHTmj97/XIhOWaDIfMuPpU/MN817slYKPVzToFE9ugCieekAdRzSiy9368mzhF0sj8vxIpK4A==
X-Received: by 2002:a05:6a00:1947:b0:730:95a6:3761 with SMTP id
 d2e1a72fcca58-73dc144d8fdmr24243657b3a.3.1745356289569; 
 Tue, 22 Apr 2025 14:11:29 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbf8e4932sm9448160b3a.55.2025.04.22.14.11.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 14:11:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 6/9] target/avr: Use cpu_stb_mmuidx_ra in helper_fullwr
Date: Tue, 22 Apr 2025 14:11:21 -0700
Message-ID: <20250422211124.305724-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422211124.305724-1-richard.henderson@linaro.org>
References: <20250422211124.305724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Avoid direct use of address_space_memory.
Make use of the softmmu cache of the i/o page.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/avr/helper.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/target/avr/helper.c b/target/avr/helper.c
index d0e86f5614..7d6954ec26 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -23,10 +23,10 @@
 #include "qemu/error-report.h"
 #include "cpu.h"
 #include "accel/tcg/cpu-ops.h"
+#include "accel/tcg/getpc.h"
 #include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "exec/cpu_ldst.h"
-#include "exec/address-spaces.h"
 #include "exec/helper-proto.h"
 
 bool avr_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
@@ -67,6 +67,11 @@ bool avr_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     return false;
 }
 
+static void do_stb(CPUAVRState *env, uint32_t addr, uint8_t data, uintptr_t ra)
+{
+    cpu_stb_mmuidx_ra(env, addr, data, MMU_DATA_IDX, ra);
+}
+
 void avr_cpu_do_interrupt(CPUState *cs)
 {
     CPUAVRState *env = cpu_env(cs);
@@ -311,8 +316,7 @@ void helper_fullwr(CPUAVRState *env, uint32_t data, uint32_t addr)
         break;
 
     default:
-        address_space_stb(&address_space_memory, OFFSET_DATA + addr, data,
-                          MEMTXATTRS_UNSPECIFIED, NULL);
+        do_stb(env, addr, data, GETPC());
         break;
     }
 }
-- 
2.43.0


