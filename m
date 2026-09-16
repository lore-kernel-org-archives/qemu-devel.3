Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A42C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:09:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6ld0-0003MG-B8; Wed, 16 Sep 2026 05:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6lcw-0002z3-Mx; Wed, 16 Sep 2026 05:08:26 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6lcu-0007P4-DJ; Wed, 16 Sep 2026 05:08:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789549560; bh=4/+oO+YNr9Z+nEWd5rHNTQ7uqZn1m8PE6IR4GevuM7Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Wtu/PiwHLmYXanWi4CcQDB4eM1g3AiJX+ewLGZDD7Ymqq24TMETo42DECUgu72riJ
 7eL4vFRHizCCicqdAKO0ruA14i6iq2KwA2dLHvbjsAYss0JDZLFWqrn6mPFRW07hpj
 /BchV3ANZPuMGIryGNb9gz3HRKJeFWjNLhLDvaiw4mGjhjzYMzX7yqkZCWWLICWzPk
 ymBO58RdkMmuaDQxoVVC0O/dpeS6++H8MV8BdcDL43XxrTAdXZO4c16yv+lCBbdkYU
 beyDnPp635eNzjbNqOVezA71z/FQa/ths/CUSTisX+m0H7tHqYky675W9pA/bayQ1v
 qSaXpJyKQTtsA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D41881D56CE;
 Wed, 16 Sep 2026 12:06:00 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7FDF8429E18;
 Wed, 16 Sep 2026 12:06:43 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 738925A78B; Wed, 16 Sep 2026 12:06:43 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Gautam Menghani <gautam@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Nikhil Kumar Singh <nikhilks@linux.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.5 25/57] ppc/xive: Trigger the pending interrupt for a
 guest after migration
Date: Wed, 16 Sep 2026 12:03:49 +0300
Message-ID: <20260916090516.677749-25-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.5-20260916120417@cover.tls.msk.ru>
References: <qemu-stable-11.0.5-20260916120417@cover.tls.msk.ru>
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

From: Gautam Menghani <gautam@linux.ibm.com>

When a KVM guest is migrated to another LPAR while a stress-ng workload
is running, lockups are seen when the guest resumes on the destination
LPAR. This root cause is that if there was a pending interrupt for a cpu
on the source machine but it was not presented yet when the migration
started, the interrupt is not retriggered on the destination LPAR. This
is evident when running 'info pic' on the destination LPAR:

$ virsh qemu-monitor-command --hmp migrate 'info pic' | grep -e OS -e MSI
CPU[0000]:   OS    00   ff  00    ff   ff  00  ff   ff  80000400
CPU[0001]:   OS    00   ff  00    ff   ff  00  ff   ff  80000401
CPU[0002]:   OS    00   ff  00    ff   ff  00  ff   ff  80000402
CPU[0003]:   OS    00   ff  00    ff   ff  00  ff   ff  80000403
CPU[0004]:   OS    00   ff  00    ff   ff  00  ff   ff  80000404
CPU[0005]:   OS    00   ff  00    ff   ff  00  ff   ff  80000405
CPU[0006]:   OS    80   ff  02    ff   ff  00  ff   06  80000406
CPU[0007]:   OS    00   ff  00    ff   ff  00  ff   ff  80000407
  00000000 MSI --    00000010   0/6   3071/16384 @3710000 ^1 [ 80000010 80000010 80000010 80000010 80000010 ^00000000 ]
  00000001 MSI --    00000010   1/6   1852/16384 @3980000 ^1 [ 80000010 80000033 80000033 80000033 80000033 ^00000000 ]
  00000002 MSI --    00000010   2/6   4424/16384 @40c0000 ^1 [ 80000020 80000020 80000020 80000010 80000010 ^00000000 ]
  00000003 MSI --    00000010   3/6   1913/16384 @4220000 ^1 [ 80000010 80000032 80000010 80000010 80000010 ^00000000 ]
  00000004 MSI --    00000010   4/6   2946/16384 @4360000 ^1 [ 80000010 80000010 80000010 80000010 80000010 ^00000000 ]
  00000005 MSI --    00000010   5/6   2313/16384 @44a0000 ^1 [ 80000010 80000010 80000010 80000010 80000010 ^00000000 ]
  00000006 MSI P-    00000010   6/6   5825/16384 @45f0000 ^1 [ 80000024 80000024 80000024 80000010 80000016 ^00000000 ]
  00000007 MSI --    00000010   7/6   2346/16384 @4760000 ^1 [ 80000032 80000032 80000010 80000032 80000032 ^00000000 ]

Fix this by calling xive_tctx_pipr_set() in
vmstate_xive_tctx_post_load(), which ends up calling qemu_irq_raise() to
present the interrupt. This fix is relevant only for setups where KVM
guests rely on emulated XIVE provided by QEMU, since the native XIVE
case is already handled.

Cc: qemu-stable@nongnu.org
Reported-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Reviewed-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260826060217.24978-1-gautam@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
(cherry picked from commit b78c6d5b1bf019ccb0803734754297ed440688d0)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index d702b58bd0a..52f1a880091 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1080,6 +1080,9 @@ static int vmstate_xive_tctx_post_load(void *opaque, int version_id)
             error_report_err(local_err);
             return ret;
         }
+    } else {
+        uint8_t pipr = tctx->regs[TM_QW1_OS + TM_PIPR];
+        xive_tctx_pipr_set(tctx, TM_QW1_OS, pipr, 0);
     }
 
     return 0;
-- 
2.47.3


