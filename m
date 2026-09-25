Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80AEFC9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 09:40:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA2Ob-0000Q2-4M; Fri, 25 Sep 2026 05:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xA2OT-0000Ow-Qa
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 05:39:03 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xA2OS-0006Ef-Eq
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 05:39:01 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C35486022F;
 Fri, 25 Sep 2026 09:38:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0FBE1F000FF;
 Fri, 25 Sep 2026 09:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790329139;
 bh=ECyzsDtcDEjajNrCXxTfs09UvMY1Lp8zlSn++FOVyE4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=JQ4Hg4IUriKQEViNP/Mg8ThD/YBIizn9pebLsh+LLRJRQzdqdHZrh7JcOKVWwUgxO
 1MAp70iE4EKrZ8hW+QkAXqGVWebl7Vjjw4VeMXat8KZUdrPP0yBsMe11qGETA8aR8T
 apXPl1QJ89H1o5Pnikb4tEfSNLQozQUYvoqNV7VQ3OTn9Z1DkD3ZcU2+Mhed449vJw
 Ab+ky4CEfcXSFlLqE8kkfcIvy/FrtyRtqlhek2FdNn/O7O/uVTDOw9ru+B04PF+PHa
 XwryZ7XIjqdLlgdoNLeP2AYvQBraMcggjxfBT4nMisNlk9bEUqpopBDnzILwRvM01+
 +jyWKQqgYv2zQ==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 6/8] accel/tcg: Set CF_NOIRQ during cpu_exec_step_atomic
Date: Fri, 25 Sep 2026 11:38:42 +0200
Message-ID: <20260925093844.5685-7-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260925093844.5685-1-deller@kernel.org>
References: <20260925093844.5685-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Do not go through the effort of grabbing the exclusive lock
only to check for interrupts and exit without making progress.

Cc: qemu-stable@nongnu.org
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 accel/tcg/cpu-exec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 5226cfb765..f4428e9f7b 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -566,7 +566,8 @@ void cpu_exec_step_atomic(CPUState *cpu)
         /* Execute in a serial context. */
         s.cflags &= ~CF_PARALLEL;
         /* After 1 insn, return and release the exclusive lock. */
-        s.cflags |= CF_NO_GOTO_TB | CF_NO_GOTO_PTR | 1;
+        s.cflags |= CF_NO_GOTO_TB | CF_NO_GOTO_PTR | CF_NOIRQ | 1;
+
         /*
          * No need to check_for_breakpoints here.
          * We only arrive in cpu_exec_step_atomic after beginning execution
-- 
2.54.0


