Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A4E5D74EE2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 15:16:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjIob-0008Qe-87; Fri, 23 Jan 2026 10:11:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vjInE-0006zN-IF
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:09:49 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vjInC-0002x1-81
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:09:48 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 455FE41A91;
 Fri, 23 Jan 2026 15:09:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46884C4CEF1;
 Fri, 23 Jan 2026 15:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769180977;
 bh=DlSqLgtimjfKvyVcT07zv7elOVvb+6g7blAygq3vfJk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jaK5n2B0fQYoaweHCW2xG1F2FnlqXdJ3WqgSYcxjTGFfn6eg9HQNL7PP9CoKgGjqj
 uAXpDiHEYHa1LoIde3yoem1K6fSnKIHmaphNx9XJv8ILQKXt9BijZnZFGixfTQDhwl
 k2kP701oAtYkydX4ncoK034fcFSu4zj3PVky68szuJjRLnUAlJHIBZUNh/koDevu+p
 XV/WCNWXausVRNyYXAU3N82rNM7UCjKc064irZGxwaFjAMJwpmUvzs2tazbOC65hsY
 H9oFnWA4Z4Tlz28Xlejc2I9Kmq75ci2sRhNvT8yF2kCSYwyFGLSldQ2v+LrTbJlCIf
 P4ht6AVEyCCrw==
From: deller@kernel.org
To: Laurent Vivier <laurent@vivier.eu>,
	qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH 1/3] linux-user: strace: Fix 5th argument of futex syscall
Date: Fri, 23 Jan 2026 16:07:58 +0100
Message-ID: <20260123150921.17891-2-deller@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123150921.17891-1-deller@kernel.org>
References: <20260123150921.17891-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.079,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The 5th argument isn't printed, but instead the 4th argument is shown twice.
Fix this, and print the FUTEX_BITSET_MATCH_ANY string constant instead of -1
if the op is FUTEX_WAIT_BITSET or FUTEX_WAKE_BITSET.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/strace.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 18bc6c800c..ca67cfd09d 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -4150,7 +4150,12 @@ print_futex(CPUArchState *cpu_env, const struct syscallname *name,
             break;
     }
     print_pointer(arg4, 0);
-    print_raw_param("%d", arg4, 1);
+    if ((op == FUTEX_WAIT_BITSET || (op == FUTEX_WAKE_BITSET)) &&
+        (arg5 == FUTEX_BITSET_MATCH_ANY)) {
+        qemu_log("FUTEX_BITSET_MATCH_ANY");
+    } else {
+        print_raw_param("%#x", arg5, 1);
+    }
     print_syscall_epilogue(name);
 }
 #endif
-- 
2.52.0


