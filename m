Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30458D2CDF8
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 16:02:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3HKp-0005zr-Ud; Tue, 22 Oct 2024 12:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ziyao@disroot.org>)
 id 1t3HKg-0005jj-6E; Tue, 22 Oct 2024 12:02:11 -0400
Received: from layka.disroot.org ([178.21.23.139])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ziyao@disroot.org>)
 id 1t3HKd-000106-4X; Tue, 22 Oct 2024 12:02:05 -0400
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 9421B24FAE;
 Tue, 22 Oct 2024 18:02:00 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aY1oQLt8gFdS; Tue, 22 Oct 2024 18:01:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1729612919; bh=l0ePnwLASCVUiPVD33TQLa1lTQEWy0vwvUw5IfFEp8Y=;
 h=From:To:Cc:Subject:Date;
 b=h6fyUUpFSqpWdMPKEjoodkpLDg53XN7204jafZCJivC+eIL9Qj5YUzTWTPLKFHTTX
 7MXFrjb5La+cYoTCArGGFmhcVfKpOIzqPDZdIncGqQ3MyK+Q6kNVo7eWHe9MiyGS4o
 wXd5lc4bCg+xDxrcsaaVjnz3lJagk+Sgs6tj2cuUA40XXrVJFHet1luArNBiy1ISld
 80J+dby4lgpb3u54a/3lE8ng+S8CDrqR/RESSJbEGda1Rax4hldvZBnAWHh0b+Imuf
 eio4Y2ZiiFpJU03TU7nZ0KGqTx2pDWF33VRWutsKxlXjWaYDQzf0Ly24NBfrw1AwbG
 VVmXPPjX+lL5Q==
From: Yao Zi <ziyao@disroot.org>
To: Laurent Vivier <laurent@vivier.eu>,
	qemu-devel@nongnu.org
Cc: Yao Zi <ziyao@disroot.org>,
	qemu-stable@nongnu.org
Subject: [PATCH] linux-user/riscv: Fix definition of RISCV_HWPROBE_EXT_ZVFHMIN
Date: Tue, 22 Oct 2024 16:01:37 +0000
Message-ID: <20241022160136.21714-2-ziyao@disroot.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.21.23.139; envelope-from=ziyao@disroot.org;
 helo=layka.disroot.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Current definition yields a negative 32bits value, messing up hwprobe
result when Zvfhmin extension presents. Replace it by using a 1ULL bit
shift value as done in kernel upstream.

Link: https://github.com/torvalds/linux/commit/5ea6764d9095e234b024054f75ebbccc4f0eb146
Fixes: a3432cf227 ("linux-user/riscv: Sync hwprobe keys with Linux")
Cc: qemu-stable@nongnu.org
Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 linux-user/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1354e75694..ec1a77f23a 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8943,7 +8943,7 @@ static int do_getdents64(abi_long dirfd, abi_long arg2, abi_long count)
 #define     RISCV_HWPROBE_EXT_ZFHMIN        (1 << 28)
 #define     RISCV_HWPROBE_EXT_ZIHINTNTL     (1 << 29)
 #define     RISCV_HWPROBE_EXT_ZVFH          (1 << 30)
-#define     RISCV_HWPROBE_EXT_ZVFHMIN       (1 << 31)
+#define     RISCV_HWPROBE_EXT_ZVFHMIN       (1ULL << 31)
 #define     RISCV_HWPROBE_EXT_ZFA           (1ULL << 32)
 #define     RISCV_HWPROBE_EXT_ZTSO          (1ULL << 33)
 #define     RISCV_HWPROBE_EXT_ZACAS         (1ULL << 34)
-- 
2.46.2


