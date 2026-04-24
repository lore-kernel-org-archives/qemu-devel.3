Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C80B2FE51EE
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 09:11:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGCYt-0001pf-V4; Fri, 24 Apr 2026 05:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wGCYZ-0001eA-N9
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 05:10:41 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wGCYW-0001GF-A2
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 05:10:39 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B62006001A;
 Fri, 24 Apr 2026 09:10:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9CBC19425;
 Fri, 24 Apr 2026 09:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777021834;
 bh=SegvZaw7YjJdggOrV+Jaj4XqLCnC1K8Pe7eNhQBc1fo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bT7Yp++ByQ046oVrHxYzzUwhrlEe0UO/v9tRpgdBW0gnA2vBFVn2nfyoLcDyN/y3k
 kZPnmeZe3i7CicRH8IXTh3kgHYA45cDyQ57s8LtkfWXR53KWSg4cuJgdPVhyy3hrc8
 czKoBDnwCMkU2nrOpXrdQrq+JBocyBXxXCBs9MRe2DthG3ktlbgzoZmmEx7O8oTvw9
 cCT130OXZm/mYqff15xgaT++ydJbLIMQ333rdrlGbYG7JzO/IK6F5QcwZMo27TrdfP
 64cctxyKptfIz8Yb13s9t8EcdR291a0TFrQ52uI+Zy35CST52+MDNXnKMFAE6QWJxH
 ilHzxihVcZB3A==
From: Helge Deller <deller@kernel.org>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 1/4] linux-user: Use int64_t in target__kernel_sock_timeval
Date: Fri, 24 Apr 2026 11:08:47 +0200
Message-ID: <20260424091024.23495-2-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424091024.23495-1-deller@kernel.org>
References: <20260424091024.23495-1-deller@kernel.org>
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

From: Helge Deller <deller@gmx.de>

The Linux kernel uses the __s64 type for the tv_sec and tv_usec members of
target__kernel_sock_timeval, so prefer the native type here as well.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/syscall_defs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 6967306be4..138ce6abb1 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -238,8 +238,8 @@ struct target_timeval {
 };
 
 struct target__kernel_sock_timeval {
-    abi_llong tv_sec;
-    abi_llong tv_usec;
+    int64_t tv_sec;
+    int64_t tv_usec;
 };
 #endif
 
-- 
2.53.0


