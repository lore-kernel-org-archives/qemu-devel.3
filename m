Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 470B7FF8864
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 21:03:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHT5b-0000TV-Q8; Mon, 27 Apr 2026 17:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wHT5X-0000Iz-I3
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 17:01:55 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wHT5U-0003WD-4y
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 17:01:54 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0339B408CB;
 Mon, 27 Apr 2026 21:01:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7473BC19425;
 Mon, 27 Apr 2026 21:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777323709;
 bh=wru9oPkln2hoGe2ulS/uGq6EqHcd0/+fKmWJSpYsnvo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EPKto8VZATcgZ61gkvS4qHCc4MS1W35efLQlYTLi74TNeJR79+/ML+EUwTOZ23lGg
 5dMOplWwUut7qfw5RYZrTZsxyR+HbdVNxURB4XZSfH5aEl283NtZvPMfQAbjvjsc+o
 C2r1OjwEjYeqxswavHIjbLqCEsEsk2RWyHwhYbDnzuQZL7O3tjmf2UEy4e324Zh9nI
 4HgJ8HjUwz1af35OgscWvcEexkb2IgfLPrNs/wxdUbBh87RS9nFCH1+u5KfJ2UPTxU
 2U8AnJNtFdWdFHSruOD2RXeR76EsnJoggyf9U5Btgc74uXmGDDXXezxYQ/HrD1H8Af
 5c+L+C+mPehLw==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Helge Deller <deller@gmx.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL v2 07/15] linux-user/strace: Use pointer type for read and
 write values
Date: Mon, 27 Apr 2026 23:01:25 +0200
Message-ID: <20260427210133.6016-8-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427210133.6016-1-deller@kernel.org>
References: <20260427210133.6016-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
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

From: Alistair Francis <alistair.francis@wdc.com>

The stack pointer is being truncated as 32-bits for qemu-riscv64, so
let's use %p to print the syscall pointer argument.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3238
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/strace.list | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/strace.list b/linux-user/strace.list
index 35f001fecd..6162a407f9 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1114,7 +1114,7 @@
 { TARGET_NR_quotactl, "quotactl" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_read
-{ TARGET_NR_read, "read" , "%s(%d,%#x,%d)", NULL, NULL },
+{ TARGET_NR_read, "read" , "%s(%d,%p,%d)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_readahead
 { TARGET_NR_readahead, "readahead" , NULL, NULL, NULL },
@@ -1674,7 +1674,7 @@
                      print_syscall_ret_waitpid },
 #endif
 #ifdef TARGET_NR_write
-{ TARGET_NR_write, "write" , "%s(%d,%#x,%d)", NULL, NULL },
+{ TARGET_NR_write, "write" , "%s(%d,%p,%d)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_writev
 { TARGET_NR_writev, "writev" , "%s(%d,%p,%#x)", NULL, NULL },
-- 
2.53.0


