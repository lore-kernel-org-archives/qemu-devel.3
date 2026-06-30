Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E218AC43602
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 06:05:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weRbE-00071s-Kh; Tue, 30 Jun 2026 02:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanlonglong@kylinos.cn>)
 id 1weRb7-00071d-OF
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 02:05:31 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanlonglong@kylinos.cn>)
 id 1weRam-0001De-VM
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 02:05:14 -0400
X-UUID: 99b1e000744911f1aa26b74ffac11d73-20260630
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:c2f5cc1c-eb7e-4c27-ba3b-7e33c14e590c, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:0ab084570f260200e1dc96be464139ed,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
 DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
 :0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 99b1e000744911f1aa26b74ffac11d73-20260630
X-User: yanlonglong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <yanlonglong@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1763697287; Tue, 30 Jun 2026 14:04:48 +0800
From: longlong yan <yanlonglong@kylinos.cn>
To: qemu-devel@nongnu.org
Cc: longlong yan <yanlonglong@kylinos.cn>
Subject: [PATCH] tests/tcg/i386/test-flags: Check mmap() return value
Date: Tue, 30 Jun 2026 14:04:29 +0800
Message-ID: <20260630060429.588-1-yanlonglong@kylinos.cn>
X-Mailer: git-send-email 2.47.1.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=124.126.103.232;
 envelope-from=yanlonglong@kylinos.cn; helo=mailgw.kylinos.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

test-flags.c calls mmap() to allocate a page but does not check
whether it succeeded.  If the allocation fails, the following
*mprotect()* and *asm* block dereference the invalid pointer and
produce a confusing failure.

Add an assertion to fail early with a clear message.

Fixes: e7bbb7cb71b3 ("target/i386: introduce flags writeback mechanism")
Signed-off-by: longlong yan <yanlonglong@kylinos.cn>
---
 tests/tcg/i386/test-flags.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/tcg/i386/test-flags.c b/tests/tcg/i386/test-flags.c
index c379e29627..4ecf7053e2 100644
--- a/tests/tcg/i386/test-flags.c
+++ b/tests/tcg/i386/test-flags.c
@@ -21,6 +21,7 @@ int main()
 
     /* fault in the page then protect it */
     addr = mmap (NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANON, -1, 0);
+    assert(addr != MAP_FAILED);
     *addr = 0x1234;
     mprotect(addr, 4096, PROT_READ);
 
-- 
2.43.0


