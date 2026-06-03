Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CAD6CD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 16:19:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUoJI-0000x4-Th; Wed, 03 Jun 2026 12:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wUoJH-0000wg-AM
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 12:19:15 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wUoJF-0001Wu-O9
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 12:19:15 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-7e0fc8ead7eso55993987b3.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 09:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780503552; x=1781108352; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KVMvmK00Q9xMsDeutOKpOcwG6QqzsW3i/Df16sz/VME=;
 b=HsB1SFmQckZMFn/4sBoxXXQaU6tHtM9fYYJ6UpCqMayhl1tPnGeWvs6EqPmRMk4FKx
 hhiAnA/QBowj1F0TgK5iVa4MdgkPDXMxbFgnJj8nT12rRf2vtrRMpI+R1nzuSl4xAEzM
 rEeLsV467n7uONkKrmYe+QhKMKm/to6trEfHr6fpcOHWhcUJNlqZFtYSg9yq0lAlgrQs
 MF3hSQJVnHDzOhYmqzDvyom66EDaQq1BKTzV66A2K2LQkunNf5524la8BL5NQLvQu6Em
 dqEMMPboIqaAIgguwQNPnijc+/iHLgVcmRGgyLOVcEip/M7widWZSMpBQ4rxahpoNgQ0
 dxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780503552; x=1781108352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KVMvmK00Q9xMsDeutOKpOcwG6QqzsW3i/Df16sz/VME=;
 b=FDxXckRGe1Nm+IL8rkWaEp8qCBGsKDb2sxVJHeGWqKCmtnsGv2cYbZoleDKuv9AqVV
 uoRpWOhfK5gnF23iZSs5Adj5Dqy3IIPpaeaR2F8s3eM+c7GkKr+1zsp8tWqWYTKouPs5
 kJzaqClvKnlfCgPFSbxMRVlpf25VwVA9jEBTG7NXHXJ2rJ3DSRxy7XFironVo0iv7xvd
 xPuRTNYbTRWFg5H0A6TWL6Lkt/YVcfjY0qlAMRX8BueAXyj6J/jCbBMSmVxlVnPEQnos
 OTMOgAnWh04lDo/vcKGXDZ6aQFWkc7I0rSKiccUhCRtVExBj8gwZUS2KrlZ/26AfKL0j
 dZmw==
X-Gm-Message-State: AOJu0Yx1dL/fJNs16isZ0qp/qfvOTaNDFgpLnMLXPAAuKyWQSsOBd439
 nz1dgWHiDuOa057dECYxjGyQc3Qz9D/DmlRwMQcR8aNFJzbwh44yyP0mvc+tboCPZTk=
X-Gm-Gg: Acq92OEphPjvdPVGFrXxLnavC/M2uu+YClhl6ccSpdUy4bBymb7otIR43X/K5aXW07e
 WBIjTCUDBlT0DCcqOFaiFu4kKCDdXxb+zg07vv202fJ9pPZ38r2HSWhtBPhFBz+9UF2smwkgVDM
 k+4Hgy5KUhkmsOdmPljVZtAKpuoJ31dTGeCykJLtL1w8ooGmz6ytgS5cf+6jEs5ojEaZIbRTJtl
 zQ777pSK6cibRI6r91C00Y0wva1nt4YIRJ5Yo/lub3VyAQy5F96HkdLnmPNq5TfUxZWBL5mLY/1
 pr5GqigMkO/Paq5GXa1JZdUZVWRZEzy8eERlzrQhpKkx9FwzWb9C+PbGbFjV1HWMjl2GtLi5lHq
 sYRgVNaECQ7FVq+5/YLtRt9hPIUQ88lZKgKEmCVkrOV0zJDhKsFz4+IeYxaInRMmfJY57kkdQyz
 18E7n5Bxn/xkC0qQIytpMc9Tq/iSaV9t5C4w==
X-Received: by 2002:a05:690c:7202:b0:7bd:a4dc:c245 with SMTP id
 00721157ae682-7ea49d64503mr39418817b3.29.1780503552396; 
 Wed, 03 Jun 2026 09:19:12 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7ea24098d1csm19406007b3.46.2026.06.03.09.19.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 09:19:11 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>
Subject: [PATCH 3/4] linux-user/sparc: call block_signals() before
 set_sigmask() in setcontext
Date: Wed,  3 Jun 2026 12:18:51 -0400
Message-ID: <20260603161852.1831864-3-mattst88@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603161852.1831864-1-mattst88@gmail.com>
References: <20260603161852.1831864-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x112d.google.com
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

sparc64_set_context() emulates the kernel's `ta 0x6f` trap by calling
set_sigmask() to install the mask supplied via the user's ucontext_t.
The contract of set_sigmask() (see its comment in linux-user/signal.c)
is that the caller must have first called block_signals(), which sets
TaskState::signal_pending.

Without block_signals(), if a guest signal is pending-and-blocked at
the time setcontext is invoked and the new mask unblocks it,
signal_pending stays 0 and the post-trap process_pending_signals()
call in linux-user/sparc/cpu_loop.c never enters its while loop, so
the now-deliverable signal is left undelivered indefinitely.

This affects programs that use getcontext/setcontext to swap signal
masks, including libunwind's unw_resume() out of a signal handler:
without this fix, the test program below loops forever printing
"calling setcontext" instead of delivering the pending SIGUSR2.

  #define _GNU_SOURCE
  #include <ucontext.h>
  #include <signal.h>
  #include <stdio.h>
  #include <unistd.h>
  static int got;
  static void h(int s) { got = 1; }
  int main(void) {
      signal(SIGUSR2, h);
      sigset_t m; sigemptyset(&m); sigaddset(&m, SIGUSR2);
      sigprocmask(SIG_BLOCK, &m, NULL);
      kill(getpid(), SIGUSR2);
      ucontext_t uc;
      getcontext(&uc);
      if (got) return 0;
      uc.uc_sigmask.__val[0] = 0;
      setcontext(&uc);
      return 1;
  }

The 32-bit sparc do_sigreturn / do_rt_sigreturn paths already get
block_signals() from the rt_sigreturn syscall wrapper in
linux-user/syscall.c, so only sparc64_set_context (invoked directly
from cpu_loop) needs the addition.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 linux-user/sparc/signal.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git ./linux-user/sparc/signal.c ./linux-user/sparc/signal.c
index fda5508c48..ba692c3123 100644
--- ./linux-user/sparc/signal.c
+++ ./linux-user/sparc/signal.c
@@ -619,6 +619,15 @@ void sparc64_set_context(CPUSPARCState *env)
             }
         }
         target_to_host_sigset_internal(&set, &target_set);
+        /*
+         * set_sigmask() requires the caller to have first called
+         * block_signals() so that process_pending_signals() is guaranteed
+         * to run after the mask change.  Without this, a guest signal that
+         * is pending-and-blocked at setcontext time is left undelivered
+         * even after its mask bit is cleared, because signal_pending stays
+         * 0 and the post-trap process_pending_signals() loop never enters.
+         */
+        block_signals();
         set_sigmask(&set);
     }
     env->pc = pc;
-- 
2.53.0


