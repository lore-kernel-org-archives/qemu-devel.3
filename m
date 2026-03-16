Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D927AEFCBD5
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 07:14:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w226W-00080K-LO; Mon, 16 Mar 2026 03:11:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w225z-0007Xe-HO; Mon, 16 Mar 2026 03:10:36 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w225w-0007mS-JD; Mon, 16 Mar 2026 03:10:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773645002; bh=OypHeseeUnisNWsxoYu0ufPJCoq2DAtpiWgkXRZ3XeU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=u8tnG2D0CbZph5RLc+Zak+tr6iXLrxQ6N95WNzRUkOQf0Tei9uWrQMaLw6nRJodNU
 WuxsWWwotWtFYP8CeiNb5lyKwKk2Feee3efid5c+06dQ559z2J4vKvHtiqJZaIMkZB
 FMLIQWUPVLafo/S7EY4+c6mISUNsKvJK7ivlLwXzhz/UHNNlpfJRa8lnKOkIDF4KuC
 +SiPlcKbhA0Cs0Tp37QyzQOLeQhubfRJCsMeQJ3GjQC84fYZdwJvTd3vK/yks7wIA+
 9S1QB7X9AScFw/6nOQVJyeT87rvI11iVYLmoF1cfyPZYdbay8IUgdwBeiHOP4vfRde
 1dBis+t3C2QWg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E3513193C2A;
 Mon, 16 Mar 2026 10:10:02 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id ED5C7380052;
 Mon, 16 Mar 2026 10:10:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-trivial@nongnu.org
Subject: [PULL 08/14] linux-user/syscall.c: assume splice is always present
Date: Mon, 16 Mar 2026 10:09:56 +0300
Message-ID: <20260316071005.91624-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260316071005.91624-1-mjt@tls.msk.ru>
References: <20260316071005.91624-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

splice() &Co are defined since linux 2.6.17 (glibc 2.5).
Assume it is always present.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 linux-user/syscall.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 064bc604c9..87f9c22b68 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -13624,15 +13624,9 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
         return ret;
 #endif
 
-#ifdef CONFIG_SPLICE
-#ifdef TARGET_NR_tee
     case TARGET_NR_tee:
-        {
-            ret = get_errno(tee(arg1,arg2,arg3,arg4));
-        }
+        ret = get_errno(tee(arg1, arg2, arg3, arg4));
         return ret;
-#endif
-#ifdef TARGET_NR_splice
     case TARGET_NR_splice:
         {
             loff_t loff_in, loff_out;
@@ -13662,9 +13656,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
             }
         }
         return ret;
-#endif
-#ifdef TARGET_NR_vmsplice
-	case TARGET_NR_vmsplice:
+    case TARGET_NR_vmsplice:
         {
             struct iovec *vec = lock_iovec(VERIFY_READ, arg2, arg3, 1);
             if (vec != NULL) {
@@ -13675,8 +13667,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
             }
         }
         return ret;
-#endif
-#endif /* CONFIG_SPLICE */
+
 #ifdef CONFIG_EVENTFD
 #if defined(TARGET_NR_eventfd)
     case TARGET_NR_eventfd:
-- 
2.47.3


