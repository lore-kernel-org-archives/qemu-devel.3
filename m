Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E52C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:00:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiIFD-0001lh-Pz; Fri, 10 Jul 2026 16:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIF7-0001fl-PD
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:54:42 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIEr-0000mz-Ue
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:54:40 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-848479c9bd5so1110700b3a.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783716864; x=1784321664; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Uywufw6tvUASB9x55Dq0IZwzU/8JaTqzxiT122QYyUo=;
 b=NQDprAMqGYaDL+LBWGu4tNeMJQYJ27lxgRID9jRHinzm27aYeHwMaCZHb8EbE+WdRY
 CY05TzFmxrOklF2aBHdtkEJCtNpCcDQbrHD5a/vVmglIacOtVlZ8wuNV1nfTs1QB839R
 i3B/1GEBvYOUQtZ0HO3BmjFKToLHgMT5XQIzJ3ZB6yqU06TtuDf4xfsKJwSXiqapfMIA
 lSRJM1iKFDgqVpES7AEX/6bfQpYbVYAyaayy3DSETnWzB6H4FCbwkAuqOI5S0BvS/xs4
 XOe5mpgDPgwaMND0/y+vbx9IShWYSAEaVtvz72sVf7r6JYWOHHWL06m9EYOFPnB1n8rf
 e8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783716864; x=1784321664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Uywufw6tvUASB9x55Dq0IZwzU/8JaTqzxiT122QYyUo=;
 b=W2REFSghq/zOvAMX9Ot7QVDbP4HiBkCPfp5IwAVAGw61sTLmwDmhZlpr/TBJk3vQ3a
 CeELj4VqayewX3KQ+weLa+flnLo6tAYmyHpKpCZdL6L10V6TcWCxYSusBVEIz7GcMMhJ
 Ly//1qREvEfpG22mimaKp+o9gEDzWgHHZ2hihnjtT479kO7eNX2KGgZRpii1+/2BcqIs
 54D3yIFEiNNEruNMIdJ3XiBZpWlHIfRL2NzSxQyzxqmKib+y6YHr2q/KSSTiG2vd7XX9
 JgdEhQqj8iBfrWFXeA1/qUR+KrubfAP466f9q7MgwQJGQ6ABczHNVS5p0IvIVVFrr884
 hkQQ==
X-Gm-Message-State: AOJu0Yza3N7gaB4tMwkxeWkcJgopPBbx43kjC/AXE7uYgVDWvWNxf5Yf
 1iYnHMCV+ybsUC6S3Xi4lZSEFnxksQKw8SQO1gDr/mcv5KEYPPOAotm/UC81JgPne5zT6J29b4u
 IUFJL
X-Gm-Gg: AfdE7cmT7NGmkT+6arz87KZQ+dlAlEQXS47HEqVekyEFLYHt4GXIVJfso4Y1bye+Bpo
 fHDTY6aaF9vK6t7z57Pum7j2firla34OHBFY74kUeKtChAGoSS5f0PqS8otZEei42jUz6FC9fcb
 MHzPQuLMRjZxqE8/Oisx/wVL/ZiXZk3q2EyAbr1UPuPlsqd+8+rU0YzdCJ1ELipU/CdGCHMAg5o
 TzQT/Os1fRSeIhuMEwfpniCPYiubesBifAoGIabRfxNHRmuZivkynmfpIKzZrtQTTIWfScBWfVJ
 /Vb107Z78kJPuo9Ytag6ZN3ox9YSX72lBbm5SiAycRbZOhj3nDUKPv6ivjDuwli1hoY54szDeqO
 zT4cshb2zFy5UQ+iwfw2EFX7d833BKbL9XXqUX1+qXi7Uw+xobwQ/jUYylVFTn+6BToaVD7ql6E
 NeCYiKyX0QEyhAxGcM8Q==
X-Received: by 2002:a05:6a00:22c9:b0:848:5951:ff78 with SMTP id
 d2e1a72fcca58-848897d2bc7mr497196b3a.36.1783716864532; 
 Fri, 10 Jul 2026 13:54:24 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6d76106sm10780574b3a.40.2026.07.10.13.54.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 13:54:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
Subject: [PATCH v3 20/51] system: Remove cpu_watchpoint_insert error return
 path
Date: Fri, 10 Jul 2026 13:53:30 -0700
Message-ID: <20260710205401.836304-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710205401.836304-1-richard.henderson@linaro.org>
References: <20260710205401.836304-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

Move the validation of the address range to tcg_insert_breakpoint,
which has to deal with gdbstub inputs.  Leave assertions behind
in cpu_watchpoint_insert, but no error return path.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-accel-ops.c | 3 +++
 system/watchpoint.c       | 9 ++-------
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 644c5b04a2..4dee5ea57f 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -143,6 +143,9 @@ static int tcg_insert_gdbstub_breakpoint(CPUState *cs, GdbBreakpointType type,
     case GDB_WATCHPOINT_WRITE:
     case GDB_WATCHPOINT_READ:
     case GDB_WATCHPOINT_ACCESS:
+        if (len == 0 || addr + (len - 1) < addr) {
+            return -EINVAL;
+        }
         CPU_FOREACH(cpu) {
             err = cpu_watchpoint_insert(cpu, addr, len,
                                         xlat_gdb_type(cpu, type), 0, NULL);
diff --git a/system/watchpoint.c b/system/watchpoint.c
index ed505da403..01cf0f61a8 100644
--- a/system/watchpoint.c
+++ b/system/watchpoint.c
@@ -18,7 +18,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/error-report.h"
 #include "exec/cputlb.h"
 #include "exec/target_page.h"
 #include "exec/breakpoint.h"
@@ -33,12 +32,8 @@ int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
     vaddr last = addr + len - 1;
     vaddr in_page;
 
-    /* forbid ranges which are empty or run off the end of the address space */
-    if (len == 0 || last < addr) {
-        error_report("tried to set invalid watchpoint at %"
-                     VADDR_PRIx ", len=%" VADDR_PRIu, addr, len);
-        return -EINVAL;
-    }
+    assert(len != 0);
+    assert(last >= addr);
 
     wp = g_new0(CPUWatchpoint, 1);
 
-- 
2.43.0


