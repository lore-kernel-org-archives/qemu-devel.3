Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB1ACD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:05:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuGz-0005DI-6U; Tue, 12 May 2026 17:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuF4-0000VZ-BE; Tue, 12 May 2026 17:02:14 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuEz-0007DS-Hx; Tue, 12 May 2026 17:02:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619278; bh=xQ0tfYZJImVR/Vx9+Xggt87X5l9btilef0bKAkoTapc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=jVrJC0OmSFdBCNasa3yaCvwrnt5v1wuWfAWawT9YcAfynsW+NvDOEZpYsY/pevm7N
 OFhpwUM+G/3aoNiWsoLi25Go3lVxK+AKmukrhXuXynKO+f2Ez+TO0hqexG8/awi9PG
 5kad0RvrFEZTXVM351EprHVlKAc/nFoWlckv6cgjSR+TRjkNKj3LQcC8u21q9oGM2D
 deOn6/5mwIwnq0ekYELPIR3NXSf5eIYI9q7ekKh4P1uZDj7uswIlhAh4pYNxtGhHzA
 z3WMyDbspjS1IdlueRSfKZdyeh7zQJrgiVRd+3V1jMBZjVrE7s6RJxeYUl+FvYdZu6
 fNd/L/LmIGOvg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4C2661AA316;
 Tue, 12 May 2026 23:54:38 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 56C5F3ABC87;
 Tue, 12 May 2026 23:54:42 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Nutty Liu <nutty.liu@hotmail.com>, Helge Deller <deller@gmx.de>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 074/107] linux-user/strace: Use pointer type for read
 and write values
Date: Tue, 12 May 2026 23:54:01 +0300
Message-ID: <20260512205437.360850-74-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Alistair Francis <alistair.francis@wdc.com>

The stack pointer is being truncated as 32-bits for qemu-riscv64, so
let's use %p to print the syscall pointer argument.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3238
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit 1730e6f33f9732658b88c2e4eda257f50531ef0e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/strace.list b/linux-user/strace.list
index 51b5ead969..eb1a414004 100644
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
2.47.3


