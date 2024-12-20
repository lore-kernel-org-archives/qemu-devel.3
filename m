Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E67E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 20:01:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOjAl-00030D-8x; Fri, 20 Dec 2024 15:00:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <git@zabka.it>) id 1tOjAc-0002zl-Ae
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 15:00:29 -0500
Received: from out-181.mta1.migadu.com ([95.215.58.181])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <git@zabka.it>) id 1tOjAY-0007YV-6h
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 15:00:21 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zabka.it; s=key1;
 t=1734724814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=OjaYxAUwgyfdD+Xfgs2+sV3Nc5IIljcSjw6TPoGngUk=;
 b=ppd+cplc+rST5LwoZ4zM1y9EZYuEef/b9LM9rEszolmeGuUzD9Iqu1K5dbDBVZwjGTriul
 81oPIdCMF/x27DCYylQovHAy9fHO6hjHLdtlYO0zaOv7qHTJRwZWFU5pdyFuw8j5xuPe/p
 MsM8xwIqfcGC6IbBqzfg9kq8mLJB+Tc=
From: Stefan Zabka <git@zabka.it>
To: qemu-devel@nongnu.org
Cc: Stefan Zabka <git@zabka.it>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2] physmem: allow cpu_memory_rw_debug to write to MMIO devices
Date: Fri, 20 Dec 2024 20:49:41 +0100
Message-ID: <20241220195923.314208-1-git@zabka.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=95.215.58.181; envelope-from=git@zabka.it;
 helo=out-181.mta1.migadu.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/213
Signed-off-by: Stefan Zabka <git@zabka.it>
---
Addressed initial review by David Hildenbrand
The other change made more sense to me, so I'd like to write a test
to verify that an AddressSpace like
0x00..0x0F MMIO Device A
0x10..0x1F ROM
0x20..0x2F MMIO Device B

and a debug write from 0x00-0x2F still writes to MMIO Device B
and that there isn't an early exit in address_space_rw
when it encounters a ROM region.

How would I go about doing that?
---
 system/physmem.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index dc1db3a384..623f41ae06 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3573,12 +3573,13 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
         if (l > len)
             l = len;
         phys_addr += (addr & ~TARGET_PAGE_MASK);
-        if (is_write) {
-            res = address_space_write_rom(cpu->cpu_ases[asidx].as, phys_addr,
-                                          attrs, buf, l);
-        } else {
-            res = address_space_read(cpu->cpu_ases[asidx].as, phys_addr,
-                                     attrs, buf, l);
+        res = address_space_rw(cpu->cpu_ases[asidx].as, phys_addr,
+                                   attrs, buf, l, is_write);
+        if (res != MEMTX_OK && is_write) {
+            /* Fallback since it might be a ROM region*/
+            /* TODO verify that this works as expected*/
+            res = address_space_write_rom(cpu->cpu_ases[asidx].as,
+                                          phys_addr, attrs, buf, l);
         }
         if (res != MEMTX_OK) {
             return -1;
-- 
2.47.1


