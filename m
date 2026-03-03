Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE5FEC1459
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 14:42:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxQvb-0002rb-EQ; Tue, 03 Mar 2026 09:40:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1vxQvW-0002jk-NH; Tue, 03 Mar 2026 09:40:47 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1vxQvU-0002VR-5n; Tue, 03 Mar 2026 09:40:45 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id D7CD648842;
 Tue, 03 Mar 2026 15:40:28 +0100 (CET)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, wangxinxin.wang@huawei.com,
 qemu-stable@nongnu.org
Subject: [PATCH] target/i386: only migrate error code if actually set
Date: Tue,  3 Mar 2026 15:39:55 +0100
Message-ID: <20260303144024.366764-1-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1772548803706
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: 26
X-Spam_score: 2.6
X-Spam_bar: ++
X-Spam_report: (2.6 / 5.0 requ) BAYES_00=-1.9, HEXHASH_WORD=2.999,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

If cpu->env.has_error_code is true, backwards migration of a VM from
a QEMU binary with commit 27535e9cca to a QEMU binary without commit
27535e9cca will fail:

> kvm: error while loading state for instance 0x0 of device 'cpu'

This happens even if error_code == 0. Fix it by only sending the
error code if it is actually set.

Cc: qemu-stable@nongnu.org
Fixes: 27535e9cca ("target/i386: Add support for save/load of exception error code")
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 target/i386/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/machine.c b/target/i386/machine.c
index c913961281..b47b14d819 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -466,7 +466,7 @@ static bool cpu_errcode_needed(void *opaque)
 {
     X86CPU *cpu = opaque;
 
-    return cpu->env.has_error_code != 0;
+    return cpu->env.has_error_code != 0 && cpu->env.error_code != 0;
 }
 
 static const VMStateDescription vmstate_error_code = {
-- 
2.47.3



