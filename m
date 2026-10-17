Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E3D7CCF2C9
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:37:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIB5R-0005Kx-10; Sat, 17 Oct 2026 16:33:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xIB3M-0003Af-Ok
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 16:30:55 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xIB3F-0004PU-Eo
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 16:30:46 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EFC8041381;
 Sat, 17 Oct 2026 20:30:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C1A1F000C4;
 Sat, 17 Oct 2026 20:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792269035;
 bh=jUjGQqH28MHGAQPP9ihzH7f2ErPHcmQ31HIqPq4JFhE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RzHhpmxGltxzOwYPxP3tVBqXDZ8HNxoyQxNnIyS9i3rY9os0PvuCoJRpbX1zWDydn
 /QVrosy9wgRAADlvtipNDOVB28GpNgwKcHvaPOsK3q8NDVkKuFgTfpBYx4mf4Xv9pt
 3cQX4HY6+qUWp0RvbYkS47paB7sJ+1uueoiijGM47k8oGMnKgQ5fN3jz+aXFnpxJw0
 gKtfroTosMwlCyy0/PVCPLXVMbhQB44+T5XGHQJzS44OHN+CMkDLL9sGyTgRwH8SOg
 tCCuieiCRKDM+C09aPLlKUqtVGgqxh1VAT6A3TA29NOz6FDM4/g4qcTEDWzBAl5Bg8
 2ADHBXhhaBDhA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Andreas Schwab <schwab@suse.de>,
	Helge Deller <deller@gmx.de>
Subject: [PULL 1/1] linux-user: don't print core dump message by default
Date: Sat, 17 Oct 2026 22:30:31 +0200
Message-ID: <20261017203031.3107-2-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261017203031.3107-1-deller@kernel.org>
References: <20261017203031.3107-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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


