Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 082A4C369CB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 06:25:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9eP5-0002KD-5u; Tue, 29 Apr 2025 02:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1u9eOp-0002Fs-RT
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 02:25:04 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1u9eOl-0006mz-E9
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 02:24:57 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2540543FAD;
 Tue, 29 Apr 2025 06:24:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A8BC4CEE3;
 Tue, 29 Apr 2025 06:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1745907893;
 bh=idVj8BJYs1Aw6SHVsrP3TsDm5Ni1zLsu+rVHmdH+T8Y=;
 h=Date:From:To:Cc:Subject:From;
 b=YTQ1ugM/wUtnj780ut7zFmKfKYGM/dnBu/DCsxUBcI9q4ogyomT+mH2QD6pnpm3Ys
 k75PAF8cTcIK1Bj3z06GmML6ll2TR89iQ8NuqOOH3YzTFQIPqKPBjNnfbZfXhhv1yM
 mfyQ2DLUGCaOAQUeguwBQyDCOXixP2z5JJs6V+2eqGF/qlE9CcSCPDfU3JkgxIcNT0
 L/FVJZLdcG6vh9/Vu6DeJhDQqpYgy+B4v26rrthamORAKLmW8Jilk7NNIrSosmMibQ
 AEhgW2d1Gs+npGHjE1dXvAVihqMxVNvyZJi9TagFqV80mF8mDN1JQDBxr1r8TGAfbu
 jrOkf8+TP3s4Q==
Date: Tue, 29 Apr 2025 06:24:51 +0000
From: Wei Liu <wei.liu@kernel.org>
To: qemu-devel@nongnu.org
Cc: Wei Liu <wei.liu@kernel.org>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH] target/i386/hvf: fix a compilation error
Message-ID: <aBBws1ikCDfyC0RI@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=wei.liu@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Include exec/target_page.h to fix the following build error.

x86_64-softmmu.a.p/target_i386_hvf_hvf.c.o -c ../target/i386/hvf/hvf.c
../target/i386/hvf/hvf.c:139:49: error: use of undeclared identifier 'TARGET_PAGE_SIZE'
  139 |             uint64_t dirty_page_start = gpa & ~(TARGET_PAGE_SIZE - 1u);
      |                                                 ^
../target/i386/hvf/hvf.c:141:45: error: use of undeclared identifier 'TARGET_PAGE_SIZE'
  141 |             hv_vm_protect(dirty_page_start, TARGET_PAGE_SIZE,
      |                                             ^

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
I suspect 58d00538ceeef990 and its follow-up patches caused this issue but I
unfortunately don't have cycles to investigate further.
---
 target/i386/hvf/hvf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 23ebf2550a..99e37a33e5 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -76,6 +76,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/accel.h"
 #include "target/i386/cpu.h"
+#include "exec/target_page.h"
 
 static Error *invtsc_mig_blocker;
 
-- 
2.39.5 (Apple Git-154)


