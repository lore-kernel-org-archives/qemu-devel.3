Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D2EC28B28
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Mar 2025 06:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttKtS-00073j-3M; Sat, 15 Mar 2025 02:21:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttKsQ-0004fk-Lx; Sat, 15 Mar 2025 02:20:09 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttKsM-0003MY-S1; Sat, 15 Mar 2025 02:20:06 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B310AFF9E0;
 Sat, 15 Mar 2025 09:17:07 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8A7671CAC49;
 Sat, 15 Mar 2025 09:18:01 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 5B9DC558D7; Sat, 15 Mar 2025 09:18:01 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 David Hildenbrand <david@redhat.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.3 20/51] physmem: replace assertion with error
Date: Sat, 15 Mar 2025 09:17:26 +0300
Message-Id: <20250315061801.622606-20-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.3-20250315091645@cover.tls.msk.ru>
References: <qemu-stable-9.2.3-20250315091645@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Paolo Bonzini <pbonzini@redhat.com>

It is possible to start QEMU with a confidential-guest-support object
even in TCG mode.  While there is already a check in qemu_machine_creation_done:

    if (machine->cgs && !machine->cgs->ready) {
        error_setg(errp, "accelerator does not support confidential guest %s",
                   object_get_typename(OBJECT(machine->cgs)));
        exit(1);
    }

the creation of RAMBlocks happens earlier, in qemu_init_board(), if
the command line does not override the default memory backend with
-M memdev.  Then the RAMBlock will try to use guest_memfd (because
machine_require_guest_memfd correctly returns true; at least correctly
according to the current implementation) and trigger the assertion
failure for kvm_enabled().  This happend with a command line as
simple as the following:

    qemu-system-x86_64 -m 512 -nographic -object sev-snp-guest,reduced-phys-bits=48,id=sev0 \
       -M q35,kernel-irqchip=split,confidential-guest-support=sev0
    qemu-system-x86_64: ../system/physmem.c:1871: ram_block_add: Assertion `kvm_enabled()' failed.

Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20250217120812.396522-1-pbonzini@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 6debfb2cb1795427d2dc6a741c7430a233c76695)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/system/physmem.c b/system/physmem.c
index 75389064a8..83013b59f7 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1868,7 +1868,11 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
     if (new_block->flags & RAM_GUEST_MEMFD) {
         int ret;
 
-        assert(kvm_enabled());
+        if (!kvm_enabled()) {
+            error_setg(errp, "cannot set up private guest memory for %s: KVM required",
+                       object_get_typename(OBJECT(current_machine->cgs)));
+            goto out_free;
+        }
         assert(new_block->guest_memfd < 0);
 
         ret = ram_block_discard_require(true);
-- 
2.39.5


