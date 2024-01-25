Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3206C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 03:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSqSM-0003OP-OD; Wed, 24 Jan 2024 22:31:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rSqS4-00031o-FC
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 22:30:55 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rSqS0-0001E0-Kb
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 22:30:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706153448; x=1737689448;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=O90Sz6D/CUBJHW4iQssE9lD+uGaFEj7py9EJ59KxMp8=;
 b=HQuRXcgd1vHUzz4TNNQ6D7I3xuHX1cuGDNsERgXjnSA6lGiEnITWgt6X
 oswy/8o0ZUJncK6GnOar5bZCGuVMnALQKjjEgOiQzyH3erDekxZ8Pxr2A
 02MGb2Nd3J1fZ8iYhHalXMt5r7S7T8RdDVse9zvz6apgbvMQ1o4uVYbbE
 LOe7EpCcMrMFqWr633fxJaEl5IvkVbzvyfUoGi33UmvyrFtEUuQatQnB1
 vTpD3w0QjzVsKT3BV4SrK5zbQdn4JtN6nxYo1A31SxDmv7hZ/gh9Vahpu
 jjkn+ygI8Pu0EtrfL5UzVoBDgHRrPvLVq8Rsb3lA8fMjvWjvrBQ2rIWax Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="9429749"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9429749"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2024 19:27:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2086065"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa005.jf.intel.com with ESMTP; 24 Jan 2024 19:27:39 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, xiaoyao.li@intel.com,
 Michael Roth <michael.roth@amd.com>,
 Sean Christopherson <seanjc@google.com>,
 Claudio Fontana <cfontana@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>
Subject: [PATCH v4 45/66] memory: Introduce
 memory_region_init_ram_guest_memfd()
Date: Wed, 24 Jan 2024 22:23:07 -0500
Message-Id: <20240125032328.2522472-46-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125032328.2522472-1-xiaoyao.li@intel.com>
References: <20240125032328.2522472-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Introduce memory_region_init_ram_guest_memfd() to allocate private
guset memfd on the MemoryRegion initialization. It's for the use case of
TDVF, which must be private on TDX case.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 include/exec/memory.h |  6 ++++++
 system/memory.c       | 27 +++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index f25959f6d30f..3a7f41b030e8 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1607,6 +1607,12 @@ bool memory_region_init_ram(MemoryRegion *mr,
                             uint64_t size,
                             Error **errp);
 
+bool memory_region_init_ram_guest_memfd(MemoryRegion *mr,
+                                        Object *owner,
+                                        const char *name,
+                                        uint64_t size,
+                                        Error **errp);
+
 /**
  * memory_region_init_rom: Initialize a ROM memory region.
  *
diff --git a/system/memory.c b/system/memory.c
index 74f647f2e56f..41049d3e4c9a 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3619,6 +3619,33 @@ bool memory_region_init_ram(MemoryRegion *mr,
     return true;
 }
 
+bool memory_region_init_ram_guest_memfd(MemoryRegion *mr,
+                                        Object *owner,
+                                        const char *name,
+                                        uint64_t size,
+                                        Error **errp)
+{
+    DeviceState *owner_dev;
+
+    if (!memory_region_init_ram_flags_nomigrate(mr, owner, name, size,
+                                                RAM_GUEST_MEMFD, errp)) {
+        return false;
+    }
+
+    memory_region_set_default_private(mr);
+
+    /* This will assert if owner is neither NULL nor a DeviceState.
+     * We only want the owner here for the purposes of defining a
+     * unique name for migration. TODO: Ideally we should implement
+     * a naming scheme for Objects which are not DeviceStates, in
+     * which case we can relax this restriction.
+     */
+    owner_dev = DEVICE(owner);
+    vmstate_register_ram(mr, owner_dev);
+
+    return true;
+}
+
 bool memory_region_init_rom(MemoryRegion *mr,
                             Object *owner,
                             const char *name,
-- 
2.34.1


