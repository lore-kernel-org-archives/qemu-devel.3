Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D442BC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 23:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAGW8-0001qj-9Z; Wed, 30 Apr 2025 19:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAGVl-0001l6-2y
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 19:06:41 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAGVi-0007Vb-B9
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 19:06:40 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-736c1138ae5so450078b3a.3
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 16:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746054397; x=1746659197; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LT3GsVAW+K3YxYOzK2RrjUaER8kwWH4wBwdfp6giJSE=;
 b=WoiVWTznZNVzzj/X3wmz5+uuvk2DnecEhbfOHAdHfEBo8QFedM/7HihsTfxgw5LjTT
 Q3CTGrpsui7e1qKAa5WjYuyXR3OMc4FAK1G4eALo/vXr5nH0FDbUjlix13f3I5NzKihZ
 +6mds2qzlUcrwfbR+Sm1Dwy9tyc0CSy9T01NTNYPkr3TC2LN0PnbcGSjJ73jLwum1aKm
 wLA1se+iXYWhtirG1xp1UmgyCRbArke6Fy5pZ7YASxyiFZRr/WpY2gq0/mN9eANZI4D0
 0ErW23LVGIqhHjU9xe1tJjb3BI9QKZRK3PRAzkbkZxOzjC/aKtFDvREj1u4gxhBVH71H
 RxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746054397; x=1746659197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LT3GsVAW+K3YxYOzK2RrjUaER8kwWH4wBwdfp6giJSE=;
 b=GCFa/uSsT5FWEtDeKOmTa+CFWcREcRVgYYGdUwVaLLH72R+AA7qDwsZoYkWud2X/J1
 ohUhiqG38iHvygFep0go+n9N1aJksXx9IYiRfLIqj59e7aHjb4WYeNanlsuGOYMs9WjD
 19/rhA5XILCT3/IRavWpUcS68S7EJIDo4O//onVPDljxsx2lXytWv6N9UxEtX0SJOMCS
 D6Xq/HBzufPBdlbzWAnOpUntRdHCJV9vpEGFRYRC5Gm46lidRrbl8+n/RqdjJNdLB2kN
 fApXqq7utuyC5idGsCGua6R+/fe/Wo/GQtwCGOn5u+uOio8lmBzF96ssPjfLdJlKhQ+0
 waFg==
X-Gm-Message-State: AOJu0YyJ8Jrmz6XmepJDbS0Jw/h/6IMa3FQpR3w9x2C3YqILZ93ETOs3
 lhmK4rA1IgJXJ+8qRgNkNdxOgbo8cKmixdC/STez+rjLSZH4LmFBJk04QgiKTKLLRYuYC8dvFLl
 I
X-Gm-Gg: ASbGnctqqRK4jU5GNIZSmV3QdygEwy+TWauM9EJwNa/wP0GMUPhNOvMrcG4chyhxS2P
 PT4ncvbPVFRYcOSMWm3TqvWqF6UggK7P6cXgqi8wMTvaHR7wMxDCItgoNWROkohtQSr/hdbvMQG
 u2b6Yd7f6bKJduoyizYolJoI3l53wOCGm+UNEWAEMyB6Y3fU0FL9ex1GcJXy/b34bpPnQhzulhF
 +LsQAa0w49lsvqc3UYyZ/OMuvTdEZaFzpHS3SOywYCH6QiaOghxcxRgFT4Hq8gXT3PEKAvztqkx
 AdMorufIHWjGC1i5QoA9ipz1QZlakCb68Ubq2tRRJEPZY1F38mbQL0pWVUnqcq1rV3i25opgOyx
 8ENBq0uY7Bg==
X-Google-Smtp-Source: AGHT+IEttPXf0c2cZtzi93xwm+WldaEXm2r5JHF3L+uImhCZYvLK/D7UdOGmnjJFoZCx+uGw7q0gOQ==
X-Received: by 2002:a05:6a00:3a06:b0:736:5c8e:baaa with SMTP id
 d2e1a72fcca58-7403a75b4c4mr6766778b3a.2.1746054396900; 
 Wed, 30 Apr 2025 16:06:36 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74039a30e2fsm2323287b3a.103.2025.04.30.16.06.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 16:06:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/6] accel/tcg: Use vaddr in cpu_loop.h
Date: Wed, 30 Apr 2025 16:06:31 -0700
Message-ID: <20250430230631.2571291-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250430230631.2571291-1-richard.henderson@linaro.org>
References: <20250430230631.2571291-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Use vaddr instead of abi_ptr or target_ulong for a guest address.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/user/cpu_loop.h | 12 +++++-------
 accel/tcg/user-exec.c   |  2 +-
 linux-user/signal.c     |  4 ++--
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/include/user/cpu_loop.h b/include/user/cpu_loop.h
index 589c66543f..ad8a1d711f 100644
--- a/include/user/cpu_loop.h
+++ b/include/user/cpu_loop.h
@@ -20,11 +20,9 @@
 #ifndef USER_CPU_LOOP_H
 #define USER_CPU_LOOP_H
 
-#include "exec/abi_ptr.h"
+#include "exec/vaddr.h"
 #include "exec/mmu-access-type.h"
-#include "exec/log.h"
-#include "exec/target_long.h"
-#include "special-errno.h"
+
 
 /**
  * adjust_signal_pc:
@@ -46,7 +44,7 @@ MMUAccessType adjust_signal_pc(uintptr_t *pc, bool is_write);
  * Return true if the write fault has been handled, and should be re-tried.
  */
 bool handle_sigsegv_accerr_write(CPUState *cpu, sigset_t *old_set,
-                                 uintptr_t host_pc, abi_ptr guest_addr);
+                                 uintptr_t host_pc, vaddr guest_addr);
 
 /**
  * cpu_loop_exit_sigsegv:
@@ -59,7 +57,7 @@ bool handle_sigsegv_accerr_write(CPUState *cpu, sigset_t *old_set,
  * Use the TCGCPUOps hook to record cpu state, do guest operating system
  * specific things to raise SIGSEGV, and jump to the main cpu loop.
  */
-G_NORETURN void cpu_loop_exit_sigsegv(CPUState *cpu, target_ulong addr,
+G_NORETURN void cpu_loop_exit_sigsegv(CPUState *cpu, vaddr addr,
                                       MMUAccessType access_type,
                                       bool maperr, uintptr_t ra);
 
@@ -73,7 +71,7 @@ G_NORETURN void cpu_loop_exit_sigsegv(CPUState *cpu, target_ulong addr,
  * Use the TCGCPUOps hook to record cpu state, do guest operating system
  * specific things to raise SIGBUS, and jump to the main cpu loop.
  */
-G_NORETURN void cpu_loop_exit_sigbus(CPUState *cpu, target_ulong addr,
+G_NORETURN void cpu_loop_exit_sigbus(CPUState *cpu, vaddr addr,
                                      MMUAccessType access_type,
                                      uintptr_t ra);
 
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 68e01fc584..e1f4c4eacf 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -126,7 +126,7 @@ MMUAccessType adjust_signal_pc(uintptr_t *pc, bool is_write)
  * guest, we'd end up in an infinite loop of retrying the faulting access.
  */
 bool handle_sigsegv_accerr_write(CPUState *cpu, sigset_t *old_set,
-                                 uintptr_t host_pc, abi_ptr guest_addr)
+                                 uintptr_t host_pc, vaddr guest_addr)
 {
     switch (page_unprotect(cpu, guest_addr, host_pc)) {
     case 0:
diff --git a/linux-user/signal.c b/linux-user/signal.c
index 4dafc2c3a2..cd0e7398aa 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -750,7 +750,7 @@ void force_sigsegv(int oldsig)
 }
 #endif
 
-void cpu_loop_exit_sigsegv(CPUState *cpu, target_ulong addr,
+void cpu_loop_exit_sigsegv(CPUState *cpu, vaddr addr,
                            MMUAccessType access_type, bool maperr, uintptr_t ra)
 {
     const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
@@ -766,7 +766,7 @@ void cpu_loop_exit_sigsegv(CPUState *cpu, target_ulong addr,
     cpu_loop_exit_restore(cpu, ra);
 }
 
-void cpu_loop_exit_sigbus(CPUState *cpu, target_ulong addr,
+void cpu_loop_exit_sigbus(CPUState *cpu, vaddr addr,
                           MMUAccessType access_type, uintptr_t ra)
 {
     const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
-- 
2.43.0


