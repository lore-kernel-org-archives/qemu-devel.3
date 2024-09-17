Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23AEDCAC594
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 18:15:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqchv-0005dj-4j; Tue, 17 Sep 2024 14:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sqchP-0003Qv-5l; Tue, 17 Sep 2024 14:13:16 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sqchM-0002vl-RT; Tue, 17 Sep 2024 14:13:14 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2F30A8FBFF;
 Tue, 17 Sep 2024 21:12:52 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9E2A113E75F;
 Tue, 17 Sep 2024 21:13:07 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Arman Nabiev <nabiev.arman13@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.3 71/82] target/ppc: Fix migration of CPUs with TLB_EMB
 TLB type
Date: Tue, 17 Sep 2024 21:12:45 +0300
Message-Id: <20240917181256.634732-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.0.3-20240917211142@cover.tls.msk.ru>
References: <qemu-stable-9.0.3-20240917211142@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Arman Nabiev <nabiev.arman13@gmail.com>

In vmstate_tlbemb a cut-and-paste error meant we gave
this vmstate subsection the same "cpu/tlb6xx" name as
the vmstate_tlb6xx subsection. This breaks migration load
for any CPU using the TLB_EMB CPU type, because when we
see the "tlb6xx" name in the incoming data we try to
interpret it as a vmstate_tlb6xx subsection, which it
isn't the right format for:

 $ qemu-system-ppc -drive
 if=none,format=qcow2,file=/home/petmay01/test-images/virt/dummy.qcow2
 -monitor stdio -M bamboo
 QEMU 9.0.92 monitor - type 'help' for more information
 (qemu) savevm foo
 (qemu) loadvm foo
 Missing section footer for cpu
 Error: Error -22 while loading VM state

Correct the incorrect vmstate section name. Since migration
for these CPU types was completely broken before, we don't
need to care that this is a migration compatibility break.

This affects the PPC 405, 440, 460 and e200 CPU families.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2522
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Arman Nabiev <nabiev.arman13@gmail.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
(cherry picked from commit 203beb6f047467a4abfc8267c234393cea3f471c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 203fe28e01..19763a7142 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -621,7 +621,7 @@ static bool tlbemb_needed(void *opaque)
 }
 
 static const VMStateDescription vmstate_tlbemb = {
-    .name = "cpu/tlb6xx",
+    .name = "cpu/tlbemb",
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = tlbemb_needed,
-- 
2.39.5


