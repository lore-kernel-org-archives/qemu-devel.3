Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C02CCD1A5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 05:57:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDGEL-0007yb-5r; Mon, 27 Oct 2025 01:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vDGEI-0007yP-JT
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 01:57:18 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vDGEF-0002kx-7l
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 01:57:18 -0400
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 59R5v1hS041967
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 27 Oct 2025 14:57:05 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=F7CpjYT/HngMjwg7+wZEmco+AYWuE4/x+3O2up+YASI=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1761544625; v=1;
 b=DyBCkPFoEEOc/R3Vt0Rw4AHM8V0MpJ7MMWs71saEvfz7a3ymLbqzUBMgLCenxp2s
 gaPRqS0xNSZgIF+VfVoq1URhw4zELQyDEwh6iW6urE3CH6eIjlGVHxpR3xCmHAYz
 Hd3jNxxkri0k0pUlcYSNrlXyasKj+AtchX5RZfbIIn5vaKI4Isv4tEd5Cc/w2JFR
 kMIEj1+G7HJOTsZLu7c6zIe8R5gqFDWVF/6KV1RYLG4aCJ7CPFgnNSqPR7VqN7Le
 7VirUKx3tUsMx9S05ZuApgb8Ldn7c12wDeLPfSZhEM1Uip4s5peXRwCZ3HRjDtma
 IjEBhNlnicnuWvbKWpuNUw==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 27 Oct 2025 14:56:53 +0900
Subject: [PATCH] memory: Make FlatView root references weak
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-root-v1-1-ddf92b9058be@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAKQJ/2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyMT3aL8/BLdFBNjQxNTg7TkpKQ0JaDSgqLUtMwKsDHRsbW1AL/RBsl
 WAAAA
X-Change-ID: 20251024-root-d431450fcbbf
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.15-dev-179e8
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

docs/devel/memory.rst says "memory_region_ref and memory_region_unref
are never called on aliases", but these functions are called for
FlatView roots, which can be aliases.

This causes object overwrite hazard in pci-bridge. Specifically,
pci_bridge_region_init() expects that there are no references to
w->alias_io after object_unparent() is called, allowing it to reuse the
associated storage. However, if a parent bus still holds a reference to
the existing object as a FlatView's root, the storage is still in use,
leading to an overwrite. This hazard can be confirmed by adding the
following code to pci_bridge_region_init():

PCIDevice *parent_dev = parent->parent_dev;
assert(!object_dynamic_cast(OBJECT(parent_dev), TYPE_PCI_BRIDGE) ||
       PCI_BRIDGE(parent_dev)->as_io.current_map->root != &w->alias_io);

This assertion fails when running:
meson test -C build qtest-x86_64/bios-tables-test \
    '--test-args=-p /x86_64/acpi/piix4/pci-hotplug/no_root_hotplug'

Make the references of FlatView roots "weak" (i.e., remove the
reference to a root automatically removed when it is finalized) to
avoid calling memory_region_ref and memory_region_unref and fix the
hazard with pci-bridge.

Alternative solutions (like removing the "never called on aliases"
statement or detailing the exception) were rejected because the alias
invariant is still relied upon in several parts of the codebase, and
updating existing code to align with a new condition is non-trivial.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 system/memory.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 8b84661ae36c..08fe5e791224 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -266,7 +266,6 @@ static FlatView *flatview_new(MemoryRegion *mr_root)
     view = g_new0(FlatView, 1);
     view->ref = 1;
     view->root = mr_root;
-    memory_region_ref(mr_root);
     trace_flatview_new(view, mr_root);
 
     return view;
@@ -301,7 +300,6 @@ static void flatview_destroy(FlatView *view)
         memory_region_unref(view->ranges[i].mr);
     }
     g_free(view->ranges);
-    memory_region_unref(view->root);
     g_free(view);
 }
 
@@ -1796,6 +1794,12 @@ void memory_region_init_iommu(void *_iommu_mr,
 static void memory_region_finalize(Object *obj)
 {
     MemoryRegion *mr = MEMORY_REGION(obj);
+    gpointer key;
+    gpointer value;
+
+    if (g_hash_table_steal_extended(flat_views, mr, &key, &value)) {
+        ((FlatView *)value)->root = NULL;
+    }
 
     /*
      * Each memory region (that can be freed) must have an owner, and it

---
base-commit: 36076d24f04ea9dc3357c0fbe7bb14917375819c
change-id: 20251024-root-d431450fcbbf

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


