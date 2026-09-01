Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA49DC61DE4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 03:50:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1FUa-0000cZ-M1; Mon, 31 Aug 2026 23:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x1FUY-0000c3-Of
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 23:48:58 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x1FUW-0004Lw-W1
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 23:48:58 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-66d23c88af0so2044488d50.1
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 20:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788234536; x=1788839336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bwP7cQaRP/GqhipJ0CESBAL8FySLg3GbdoTs9nGIJiA=;
 b=CVI6oL1SkYwShF9iInuPNBIjNk5Y0wPycpB1H9AdxQXjJqNRGe9VXlgHqWlAmmYwpl
 8loKCFCycF/ZmIByjTYHt8TkqS+xOcTiZKNkWP7HZ/M1xU3hs9Ln6RPTjpS2I2ipjMUS
 b72U8Y7pDk9dGK2a61iMazH/0c2ldMd4mm84ipi1+B+Gfra6oIfpDzMr5wCAlqi3Xp92
 togRk1upKXVKUc+RA0pfn4aMSER4ou3AX2y4j1x8KMEksH3GBIvQclTuSdNW1+inlFKz
 HsUjk0z1O7Skvg3XGNNAd/U8gIDskOdwRlfIuT2Qjps0WfMG3ZZj66fUNkyJT6444Xt5
 7KlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788234536; x=1788839336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bwP7cQaRP/GqhipJ0CESBAL8FySLg3GbdoTs9nGIJiA=;
 b=T1Qj8vabKn1tKgNhX87fnTnZW/mX/Cb3T+/summRjWiyNgz/IjOF73XHOZEV+ghrxh
 EmHikbzeUFQESIlZNds2qEuXTdv25fk593gBh0bcyq+Bi2niw6lEQ6YpmIoh7Po5rJfj
 +6H9M8itsT9VhErk9LTIEXdXOf0LupTTjzX2SL64pX6zaje+dN40wHXW+Let3+fzdt4T
 YDY8SkYq21x8MnAV36yFDg4FXLiDb34bi4uihUCPQbVZi1za/HbQWuJUyJ093yyIeqz6
 CdEJ5OeVS/nXypW6SDGI6OFixn4+Q47W68KaOZ7eqjBITVQZ7Lgr+/q6tKxdWLFBiRVA
 63uA==
X-Gm-Message-State: AFuF++lGO+cGI8sS3b1sR/LIT9jyq4/whsxAKxU5fdtuGDFkY6q5+vjW
 /k49oOl60Z9bBMEftBft1krjUsa/qKfghppB1Cfx14CKW/twKKWd2seo/xv2YA==
X-Gm-Gg: AYBFou2hQacsaVEvM56p0D1R9YYkO/AYWiWDWzYpRcayU9e/LDWBnodglvp+UBqWUom
 FqER55SLUjwzNLf61a0389aljSxGEiE28rnpTtizM4lQeaoRAHicas9EiURw5aWri0E0cUUpsxM
 KA/L8S5V1rnQiHFUGbpRtE0Rmw1nngGrAn/H5tnj80DEALSYydTjjJkhPy+2qeIMXkGO0e1LPsL
 y7UBVusBOA7DI2AcKInVzL081UWO6uYuF0S9o06l6/Cj/arpOutlWHtBwQXgNJoAqW8yn/KpZxb
 OKFenbqtLb60BMRXFpipkTPQ1vjm2p8lwchKbIUwKhaMoY+nPJL1It22uxFteD/ZGgZzluqWSfl
 mU6/VSt/z+WYiWyBEecj1q5ckYYa4fDZCdYDJjfL3iaL11cEyUCiOtXDcmUfFWo+qsd97Cm/70O
 gu9JdS754aljDvJ31eWlYNmeZy9IpP1fcxtc2yq12c9kya02sgOZ3ZK7vcAaDfImUYSS+GqV1X0
 W7DX22pyeg8exCV23BWmwg3v3zbL+6A9zL7BOnn
X-Received: by 2002:a05:690e:1386:b0:66c:51c5:61df with SMTP id
 956f58d0204a3-66f875fc4a2mr1869738d50.44.1788234533325; 
 Mon, 31 Aug 2026 20:48:53 -0700 (PDT)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net.
 [107.220.129.194]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66e4ed1fbebsm7511499d50.17.2026.08.31.20.48.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 20:48:52 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, philmd@oss.qualcomm.com,
 alex.bennee@linaro.org, zhao1.liu@intel.com,
 Matt Turner <mattst88@gmail.com>
Subject: [PATCH v5 5/9] accel/tcg: add CF_NO_GOTO_JC,
 set while a breakpoint is present
Date: Mon, 31 Aug 2026 23:48:04 -0400
Message-ID: <20260901034808.3524945-6-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260901034808.3524945-1-mattst88@gmail.com>
References: <20260827050241.3713332-1-mattst88@gmail.com>
 <20260901034808.3524945-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=mattst88@gmail.com; helo=mail-yx1-xb12c.google.com
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

The next patch dispatches a goto_jc by probing the TB jump cache from
generated code. That probe cannot check everything helper_lookup_tb_ptr()
checks, and the one that matters is breakpoints: check_for_breakpoints()
raises EXCP_DEBUG on an exact pc match and selects CF_BP_PAGE cflags for the
rest of the page, and inserting a breakpoint deliberately invalidates no TB.

The probe does compare the destination's cflags against the cflags of the
block doing the dispatching, and only takes the destination when they are
equal. So a cflag is all that is needed. Add CF_NO_GOTO_JC, set it in
CPUState::tcg_cflags while cpu->breakpoints is non-empty, and blocks
translated from then on both decline to dispatch inline themselves -- the
next patch makes them emit the plain helper call -- and are unreachable from
blocks that do, because their cflags no longer match.

The two ends of the flag are cpu_breakpoint_insert() and
cpu_breakpoint_remove_by_ref(), which are the only places the list changes.
Both already run either on the CPU's own thread or with it stopped, or reach
another CPU exactly as cpu_single_step() does, which is where the previous
patch put the same kind of update.

That leaves blocks translated before the breakpoint was inserted, which are
still live and still chain to each other. They do so on the old cflags, so
inline dispatch among them keeps working until the vCPU reaches its main
loop, which then looks up with the new cflags and translates afresh. In
system mode gdb inserts breakpoints with the vCPUs stopped, so there is no
window at all. In user mode the window is the one goto_tb chaining already
has: a chained direct jump consults nothing either, and is not broken by
inserting a breakpoint.

Nothing reads CF_NO_GOTO_JC yet; the next patch does.

v5: New patch, replacing "accel/tcg: give the TB jump cache a second base
    pointer for generated code", which forced the same fallback by pointing
    generated code at a zero-filled jump cache when a breakpoint was
    inserted, and needed a cross-thread poison and an un-poison race to do
    it. Richard Henderson suggested a cflag instead, and pointed out that
    the previous patch had already shown how to update tcg_cflags from
    gdbstub. The base pointer comes back later in the series, for pending
    exits, which a cflag cannot express.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 accel/tcg/cpu-exec-common.c      | 13 ++++++++++++-
 cpu-common.c                     |  7 +++++++
 include/exec/translation-block.h |  1 +
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git ./accel/tcg/cpu-exec-common.c ./accel/tcg/cpu-exec-common.c
index 9f3517f36b..a3148bbf8f 100644
--- ./accel/tcg/cpu-exec-common.c
+++ ./accel/tcg/cpu-exec-common.c
@@ -41,7 +41,7 @@ void tcg_cflags_set(CPUState *cpu, uint32_t flags)
  * they are derived from gdb single-step, one-insn-per-tb and -d nochain.
  */
 #define CF_DERIVED  (CF_COUNT_MASK | CF_NO_GOTO_TB | CF_NO_GOTO_PTR | \
-                     CF_SINGLE_STEP)
+                     CF_SINGLE_STEP | CF_NO_GOTO_JC)
 
 void tcg_update_cflags(CPUState *cpu)
 {
@@ -62,6 +62,17 @@ void tcg_update_cflags(CPUState *cpu)
         cflags |= CF_NO_GOTO_TB;
     }
 
+    /*
+     * A block that dispatches through the jump cache inline does not consult
+     * cpu->breakpoints, and inserting a breakpoint deliberately invalidates
+     * nothing.  Give blocks translated while one is set a distinct cflags, so
+     * that they neither dispatch inline themselves nor are reached by a block
+     * that does, and check_for_breakpoints() gets to run on every dispatch.
+     */
+    if (unlikely(!QTAILQ_EMPTY(&cpu->breakpoints))) {
+        cflags |= CF_NO_GOTO_JC;
+    }
+
     cpu->tcg_cflags = cflags;
 }
 
diff --git ./cpu-common.c ./cpu-common.c
index adb76b3a78..3178601987 100644
--- ./cpu-common.c
+++ ./cpu-common.c
@@ -22,6 +22,7 @@
 #include "exec/cpu-common.h"
 #include "hw/core/cpu.h"
 #include "qemu/lockable.h"
+#include "system/tcg.h"
 #include "trace/trace-root.h"
 
 QemuMutex qemu_cpu_list_lock;
@@ -429,6 +430,9 @@ int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, int flags,
         *breakpoint = bp;
     }
 
+    /* The first breakpoint takes the CPU off the inline dispatch path. */
+    tcg_update_cflags(cpu);
+
     trace_breakpoint_insert(cpu->cpu_index, pc, flags);
     return 0;
 }
@@ -456,6 +460,9 @@ void cpu_breakpoint_remove_by_ref(CPUState *cpu, CPUBreakpoint *bp)
 {
     QTAILQ_REMOVE(&cpu->breakpoints, bp, entry);
 
+    /* The last breakpoint puts the CPU back on it. */
+    tcg_update_cflags(cpu);
+
     trace_breakpoint_remove(cpu->cpu_index, bp->pc, bp->flags);
     g_free(bp);
 }
diff --git ./include/exec/translation-block.h ./include/exec/translation-block.h
index 40cc699031..8c4778c681 100644
--- ./include/exec/translation-block.h
+++ ./include/exec/translation-block.h
@@ -84,6 +84,7 @@ struct TranslationBlock {
 #define CF_NOIRQ         0x00010000 /* Generate an uninterruptible TB */
 #define CF_PCREL         0x00020000 /* Opcodes in TB are PC-relative */
 #define CF_BP_PAGE       0x00040000 /* Breakpoint present in code page */
+#define CF_NO_GOTO_JC    0x00080000 /* Do not dispatch via the inline probe */
 #define CF_CLUSTER_MASK  0xff000000 /* Top 8 bits are cluster ID */
 #define CF_CLUSTER_SHIFT 24
 
-- 
2.54.0


