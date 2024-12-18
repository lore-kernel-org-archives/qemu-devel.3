Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A8ACE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 21:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO1Fl-0000jE-QS; Wed, 18 Dec 2024 16:06:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <git@zabka.it>) id 1tNzpQ-0002Rn-43
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 14:35:29 -0500
Received: from out-170.mta0.migadu.com ([91.218.175.170])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <git@zabka.it>) id 1tNzpN-0004pD-WF
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 14:35:27 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zabka.it; s=key1;
 t=1734550518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=5IHdsE4vyhVCTmft2b7H4Lze6ALZhpG3BZSBWwvudSU=;
 b=eo6JJ82+o4QWs8b/sLjnIs9doZMywE9OEdwq9lOVgYgrKm79vaA/cuz4uC5kOlyvofJ4sD
 ExTtt8RFkZhQn4om1GC29N7jPe7DIkCYkSEeJxxJzTbQnvYEFWWWbSG3dDaY8bbQKd8X/C
 ulKbkL7DMrcG3lxHTkfsOS85gtsyjuU=
From: Stefan Zabka <git@zabka.it>
To: qemu-devel@nongnu.org
Cc: Stefan Zabka <git@zabka.it>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] physmem: allow cpu_memory_rw_debug to write to MMIO devices
Date: Wed, 18 Dec 2024 20:31:53 +0100
Message-ID: <20241218193153.151578-1-git@zabka.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=91.218.175.170; envelope-from=git@zabka.it;
 helo=out-170.mta0.migadu.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 18 Dec 2024 16:06:44 -0500
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
 system/physmem.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index dc1db3a384..53cdccefcb 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3556,6 +3556,7 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
     hwaddr phys_addr;
     vaddr l, page;
     uint8_t *buf = ptr;
+    bool is_memcpy_access;
 
     cpu_synchronize_state(cpu);
     while (len > 0) {
@@ -3574,11 +3575,24 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
             l = len;
         phys_addr += (addr & ~TARGET_PAGE_MASK);
         if (is_write) {
-            res = address_space_write_rom(cpu->cpu_ases[asidx].as, phys_addr,
-                                          attrs, buf, l);
+            /* if ram/rom region we access the memory
+              via memcpy instead of via the cpu */
+            hwaddr mr_len, addr1;
+            AddressSpace *as = cpu->cpu_ases[asidx].as;
+            MemoryRegion *mr = address_space_translate(as, phys_addr, &addr1, &mr_len, is_write, attrs);
+
+            is_memcpy_access = memory_region_is_ram(mr) || memory_region_is_romd(mr);
+            if(!is_memcpy_access) {
+                l = memory_access_size(mr, l, addr1);
+            }
+        } else {
+            is_memcpy_access = false;
+        }
+
+        if (is_write && is_memcpy_access) {
+            res = address_space_write_rom(cpu->cpu_ases[asidx].as, phys_addr, attrs, buf, l);
         } else {
-            res = address_space_read(cpu->cpu_ases[asidx].as, phys_addr,
-                                     attrs, buf, l);
+            res = address_space_rw(cpu->cpu_ases[asidx].as, phys_addr, attrs, buf, l, is_write);
         }
         if (res != MEMTX_OK) {
             return -1;
-- 
2.47.1


