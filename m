Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A4DC43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 04:48:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgEdp-000810-6e; Sun, 05 Jul 2026 00:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgEcK-00056t-H0
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 00:38:10 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgEc1-0004Gy-Aw
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 00:38:08 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2cacf197759so28986615ad.2
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2026 21:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783226268; x=1783831068; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=G80BIhmHv+bQcepwqHTSRclxi+Da20PNHFYyztrE4Ag=;
 b=OPXd7n894wMc9G86nZH9X43zeGoYmSvwR/pWoInvilPNa9T3jom+XtozXNl+rGwFpE
 YP+sJJUqeCnRI7RLyDWY8zoMPFf1SNZOGUrHr8WXx8dRtGaIxLm+K1E3Fg2fjlJElhJ2
 jtOEAIF+TOgQ8G1sYLaqlOCUmVWDDCD1FnZJ0f52++hTxpu3ZW0DX34I0z2TsJHZUOqO
 AMSLUCPtl4fB2dSJbepoU7DNrjLNgGaNoIOSj9yuHUABSGScIhPmk/tweEE5enL1cYd4
 eQSRdPXX2gvj//sCykcmQ3uZJp5q0Pmj8gUzl21dzKr2P8QuSZNQtwcqHCU01MUt6Qb5
 +IyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783226268; x=1783831068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=G80BIhmHv+bQcepwqHTSRclxi+Da20PNHFYyztrE4Ag=;
 b=tRTwd0DnmG2EWyw9lMOmDk9JYftOCNNrkZZIw3XmEAwIf8gkMD3NujVZly9KosKcYS
 J5nih/fGHy2cv2WVHil7qJRdBEBoFtXwbHOkCZaZGmGnDNA2sY0Qh08wa2ShfiBqlEx2
 K0QmByldFqkvhgp7EUwNd7I1/JDABij+pqT7Zi9XY54V+m46pXkbUSvOLVgQVPZa2ajn
 jJ9k2cxsfn7sCKqLVQww0x6hoZf/y/QOxeNRFDDTiZ1vdEXYrLiUY/hYgVgF8dl9pK8T
 Pc61/sEEoSy+hCb3vx3m20Rs/eLfubr4LV/6UZro6qCCTkan8kO7cQRGtq1iWlpwSaEx
 BQkw==
X-Gm-Message-State: AOJu0Yxlk78xa2ArVK1i7zqdVyE9KhVUJmsAV0mojtnkj3FObLhA1Xeo
 zpZ+c13SLMdf45ifszmoFEgPovHb0BQmnL3Gru8wxODbRgVgGHWs5+Geu+rRr59AuEVaM9phC0D
 mhFgT
X-Gm-Gg: AfdE7cnbCp1fpN3Pudl/dTlZfIm9vNPc6f3rPew7M/1if6zxhggdgDIy5nJm0F6meBV
 W5sseh4VH34JwHY11rP1XiiJiV0/lPoOphnz5hB1zIcj01PGMWBe0h7OD1HMxQYxhH6R8/BQ3K+
 mYWRMhxkuupf9YNPXkIEe5Kg4zIC0HaSS7rA3VZtq/dj0r/qhi2XDZaNewReRdRaNlXthCH1tH9
 ZR94EeJyDwcEVIlThJdiuWwTuaxqfQJNEH70XHWbbrdO1rrxsfH7kwQsAuldKChSkxIwLwfPp3m
 bk21/fJq2EIxY1wFSPXqbfBT6OqsGNFIVqEqWPbulIFH6utJmTjaF6rwyzalSYazrF2FgWwdi0d
 5m74HO0l5cSyhyYSMcipBpZvNNd9rSLXDTUxiMUrG1M4KHps6exhkMqocTPahn0RG2XqfU25x0h
 lUUkqJyH0gYx7YCDoy7ymb2JVUPrl58Aa9LeUvyBIv+OWdyts=
X-Received: by 2002:a17:902:f78c:b0:2c9:c95e:5836 with SMTP id
 d9443c01a7336-2cb97e42fedmr53057565ad.5.1783226267658; 
 Sat, 04 Jul 2026 21:37:47 -0700 (PDT)
Received: from stoup.. (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cad712ca17sm29863785ad.28.2026.07.04.21.37.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 21:37:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, philmd@oss.qualcomm.com
Subject: [PATCH v2 24/46] system: Remove cpu_watchpoint_insert error return
 path
Date: Sat,  4 Jul 2026 21:37:03 -0700
Message-ID: <20260705043725.1373137-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260705043725.1373137-1-richard.henderson@linaro.org>
References: <20260705043725.1373137-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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
index 9d9ecf542c..8954514f24 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -147,6 +147,9 @@ static int tcg_insert_breakpoint(CPUState *cs, int type, vaddr addr, vaddr len)
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


