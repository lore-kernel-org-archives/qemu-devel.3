Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A44EDCC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 20:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHRez-0002fS-2G; Thu, 15 Oct 2026 16:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xHReu-0002er-BI
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 16:02:36 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xHRer-0003B0-F0
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 16:02:35 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3DF5E4055C;
 Thu, 15 Oct 2026 20:02:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2240B1F000C4;
 Thu, 15 Oct 2026 20:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792094550;
 bh=jUjGQqH28MHGAQPP9ihzH7f2ErPHcmQ31HIqPq4JFhE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=UX5VRSTdmBnM+RMlhcr4ilevPFhbzSnzvdkq/+PP0GZKpt0wGNVVGbm6+3ihqlei8
 nRz6sato7S1AjaJdL/KwRpC9JfsQWTTqm8PWkny4kdRWfxAxARJa6cItmeJWw8Swkk
 a4NpPztfDDuKgkaYSBS1RKV6bd2FvyYUVPYNSwMp5fn15OZQp1tuTr95HZl6hE+Tbe
 eQVEbazsSLFVcE30CLobY5NSNc81VnEMuxQmDKILfUyPJssxZ6rfS43fIiKaZA4TWH
 SpQepaAI6WUEMqjMJSaeMbyL+th9f9HJmBH8pJ4CP6oHBvKj8CcQCpii1x+ZJQOnkv
 Wo88uk2Rvm9bw==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Andreas Schwab <schwab@suse.de>, wangyang <wangyang25@otcaix.iscas.ac.cn>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 1/2] linux-user: don't print core dump message by default
Date: Thu, 15 Oct 2026 22:02:24 +0200
Message-ID: <20261015200225.6314-2-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261015200225.6314-1-deller@kernel.org>
References: <20261015200225.6314-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

From: Andreas Schwab <schwab@suse.de>

When the target binary is killed by a signal with core dump print a
message to the guest_errors log instead of stderr.  This avoids breaking
various testsuites due to the extra output produced by the emulation.

Signed-off-by: Andreas Schwab <schwab@suse.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/signal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index f0a22577e5..cabcc2bb28 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -839,8 +839,8 @@ void dump_core_and_abort(CPUArchState *env, int target_sig)
         getrlimit(RLIMIT_CORE, &nodump);
         nodump.rlim_cur=0;
         setrlimit(RLIMIT_CORE, &nodump);
-        (void) fprintf(stderr, "qemu: uncaught target signal %d (%s) - %s\n",
-            target_sig, strsignal(host_sig), "core dumped" );
+        qemu_log_mask(LOG_GUEST_ERROR, "qemu: uncaught target signal %d (%s) - %s\n",
+                      target_sig, strsignal(host_sig), "core dumped" );
     }
 
     preexit_cleanup(env, 128 + target_sig);
-- 
2.54.0


