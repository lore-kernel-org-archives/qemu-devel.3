Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF2DC369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:31:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbPr-0008AB-KM; Thu, 01 May 2025 17:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbOu-0005GJ-HL
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:25:01 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbOs-0002EG-Bz
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:25:00 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-af5139ad9a2so1061394a12.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134697; x=1746739497; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PA8iG/6Wck7wG5tIJ+lEJmOSQS/i8rOew0LoQTBL9os=;
 b=lmr4dlizquMePdz8PnI9kLCG35RvcyejyBLZfbFh6Gs+rAucS4BFjGePTZ03RLHEp6
 +1OxL59zCojU7/ZGgeATU3kfV3cq3hWZb2fxq4d2Ocfs9PyKl7vBzdy9FpNmxZrYCbnS
 GrfXw0Fdu7cpanzY+j3KETCCtW682G968o2+5/jZ+WP03hi88HtZp7M2hwD9oCojhH37
 /gDXCZr1WmzDnUbhoh6V/q09ULvYwEJKadlIQH0b9YLBScr5qJUWN6oq2+cbrIWp5lCc
 3CrigixEoasinsjUhMBU4YpCaGHi6KGeImlxOG3YHxSCZvGSx6tA6PgnQF5TOB1wR6g/
 3JUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134697; x=1746739497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PA8iG/6Wck7wG5tIJ+lEJmOSQS/i8rOew0LoQTBL9os=;
 b=aqFQWgN7RUCmlGW71zTmu4Ql1nw2oCSTNCIMs5Yvh04yDnmX9qML5SntQrrzl+uSLF
 ibfwrLf1/kIFAWF2ZXauUEMOGDI+jyymX/m4lEeFBry+JKQprP/FLlmTKwTKdlI3+kTT
 Nq2mXQnTrY0WPGFMGN3kvD+kKQ5sBav7NWTUztsB+v5B/wYm22sWgqX5fziYFQ/oqeTU
 IBH1XscJ2gsfNrXjkqjrLZbZCRRG33XjKX6z6RHOZC16s0Lllhn0QauyCtin1/8JGJ3x
 otYKAKF/tmKjnEcJaaLt+iJAi45iLIjxRgQzeJ7CWV56jQ8vtjT0xHJEqXoJljmDWNbh
 qkIw==
X-Gm-Message-State: AOJu0YxSpIUfdfJzirwKksLpE3x3uFf3PDNDnUrmToIMoxPp/HpSuZxo
 N9brgF42DtKKdqz0GqOi2+1fh94aC9Ex0RgTu+02WlNiBJ4qILwthsu034rwedUt5Bbl5NENrvn
 i
X-Gm-Gg: ASbGncsjhUcmouiucb5GX4048+zv4vKSLDJ6TAsEACHoqhuBgbSGnKAlXzPyqc1pyhB
 NYrHE6j/XLoHr46cGlFrOpRV6Wa3q/miuH/rkM8grhmbZ72QP1bvNVZhh5YByjuN+z9bNLCtGMD
 84v6fflOlTdtutJIlMJrCj/QVoMVFumD+ivFxYdIQId4C0B2UnMVAt24Q33Xd4GgBvJPsKSDpsx
 S55LtMpr7G1KaU2/uOk/uG04P9kWJpVIZk/BgN/KHldQfE+/Zu/RH07XvYt7ITkI9hbVTyxHmHW
 JOHB0JbWvK8ctYk7gTCABf4Esj5zzK5kSGahdc0o9jfKdJuFGkqaDT4fv7hzDBNzpAz2h+ayJHQ
 =
X-Google-Smtp-Source: AGHT+IGivPy+vLNa4yiAhHOWCCzhPbkzHj7KYAZcCtrItkCDiY8rwBJ6K1I9aSsKceoO37zNILOwWA==
X-Received: by 2002:a05:6a21:32a4:b0:1f5:8072:d7f3 with SMTP id
 adf61e73a8af0-20cdfdf5576mr740710637.30.1746134696799; 
 Thu, 01 May 2025 14:24:56 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590610desm135897b3a.146.2025.05.01.14.24.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:24:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 55/59] include/user: Use vaddr in guest-host.h
Date: Thu,  1 May 2025 14:21:09 -0700
Message-ID: <20250501212113.2961531-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

Replace abi_ptr and abi_ulong with vaddr.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/user/guest-host.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/user/guest-host.h b/include/user/guest-host.h
index 8e10d36948..0656f2e356 100644
--- a/include/user/guest-host.h
+++ b/include/user/guest-host.h
@@ -8,7 +8,7 @@
 #ifndef USER_GUEST_HOST_H
 #define USER_GUEST_HOST_H
 
-#include "user/abitypes.h"
+#include "exec/vaddr.h"
 #include "user/guest-base.h"
 #include "cpu.h"
 
@@ -30,29 +30,29 @@ extern unsigned long reserved_va;
 extern unsigned long guest_addr_max;
 
 #ifndef TARGET_TAGGED_ADDRESSES
-static inline abi_ptr cpu_untagged_addr(CPUState *cs, abi_ptr x)
+static inline vaddr cpu_untagged_addr(CPUState *cs, vaddr x)
 {
     return x;
 }
 #endif
 
 /* All direct uses of g2h and h2g need to go away for usermode softmmu.  */
-static inline void *g2h_untagged(abi_ptr x)
+static inline void *g2h_untagged(vaddr x)
 {
     return (void *)((uintptr_t)(x) + guest_base);
 }
 
-static inline void *g2h(CPUState *cs, abi_ptr x)
+static inline void *g2h(CPUState *cs, vaddr x)
 {
     return g2h_untagged(cpu_untagged_addr(cs, x));
 }
 
-static inline bool guest_addr_valid_untagged(abi_ulong x)
+static inline bool guest_addr_valid_untagged(vaddr x)
 {
     return x <= guest_addr_max;
 }
 
-static inline bool guest_range_valid_untagged(abi_ulong start, abi_ulong len)
+static inline bool guest_range_valid_untagged(vaddr start, vaddr len)
 {
     return len - 1 <= guest_addr_max && start <= guest_addr_max - len + 1;
 }
@@ -62,7 +62,7 @@ static inline bool guest_range_valid_untagged(abi_ulong start, abi_ulong len)
 
 #define h2g_nocheck(x) ({ \
     uintptr_t __ret = (uintptr_t)(x) - guest_base; \
-    (abi_ptr)__ret; \
+    (vaddr)__ret; \
 })
 
 #define h2g(x) ({ \
-- 
2.43.0


