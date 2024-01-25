Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B2F2C47DDF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 03:37:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSqSy-0005tP-On; Wed, 24 Jan 2024 22:31:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rSqSa-0005Ho-7A
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 22:31:24 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rSqSW-0001E0-IT
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 22:31:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706153480; x=1737689480;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=X8zT+hRGFWRLG2SSYKlzsvTGhWc+CZMy8l1V5tc6R5U=;
 b=MYrXbv71wHeAfpnKa/QxH4tsdjGJsZx24KMseYzo1M7xLiIx8WVuPJov
 UFoF38mo+mypq9CAkuYZcv0EU56CkohVUN9Y8Yhteh70VHq3oR5w8JjRw
 HZ+sLqzHqEkWFxTS9xiopOMd9fvW7x7WbeRGxlreEzbCs3JuDXMIPsVel
 5YLz6bmd4vCPT32V3js6St+6dzCiyCJD77RbmBIaC+GrmRjxybkV+C62J
 y4wDtWuvuNJxMv2gqznuGoEW/b6u2L6wdGr+nlXlsaOqxZXIJeqqJ0fei
 082tysLkYKaq8XJfEncEWI5NaQg7oNiUpM4mhH9XJwz4Ys4RbvatIwbFu w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="9430045"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9430045"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2024 19:28:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2086124"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa005.jf.intel.com with ESMTP; 24 Jan 2024 19:28:12 -0800
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
Subject: [PATCH v4 51/66] i386/tdx: handle TDG.VP.VMCALL<MapGPA> hypercall
Date: Wed, 24 Jan 2024 22:23:13 -0500
Message-Id: <20240125032328.2522472-52-xiaoyao.li@intel.com>
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

From: Isaku Yamahata <isaku.yamahata@intel.com>

MapGPA is a hypercall to convert GPA from/to private GPA to/from shared GPA.
As the conversion function is already implemented as kvm_convert_memory,
wire it to TDX hypercall exit.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 accel/kvm/kvm-all.c   |  2 +-
 include/sysemu/kvm.h  |  2 ++
 target/i386/kvm/tdx.c | 54 +++++++++++++++++++++++++++++++++++++++++++
 target/i386/kvm/tdx.h |  1 +
 4 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index eb8b3925dbe1..04309a8623d9 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2920,7 +2920,7 @@ static void kvm_eat_signals(CPUState *cpu)
     } while (sigismember(&chkset, SIG_IPI));
 }
 
-static int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
+int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
 {
     MemoryRegionSection section;
     ram_addr_t offset;
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 2f6592859ac6..e0061848b053 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -544,4 +544,6 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp);
 
 int kvm_set_memory_attributes_private(hwaddr start, hwaddr size);
 int kvm_set_memory_attributes_shared(hwaddr start, hwaddr size);
+
+int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private);
 #endif
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index d27e775eec5d..f1c60274c448 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -884,6 +884,58 @@ static hwaddr tdx_shared_bit(X86CPU *cpu)
     return (cpu->phys_bits > 48) ? BIT_ULL(51) : BIT_ULL(47);
 }
 
+/* 64MB at most in one call. What value is appropriate? */
+#define TDX_MAP_GPA_MAX_LEN     (64 * 1024 * 1024)
+
+static int tdx_handle_map_gpa(X86CPU *cpu, struct kvm_tdx_vmcall *vmcall)
+{
+    hwaddr shared_bit = tdx_shared_bit(cpu);
+    hwaddr gpa = vmcall->in_r12 & ~shared_bit;
+    bool private = !(vmcall->in_r12 & shared_bit);
+    hwaddr size = vmcall->in_r13;
+    bool retry = false;
+    int ret = 0;
+
+    vmcall->status_code = TDG_VP_VMCALL_INVALID_OPERAND;
+
+    if (!QEMU_IS_ALIGNED(gpa, 4096) || !QEMU_IS_ALIGNED(size, 4096)) {
+        vmcall->status_code = TDG_VP_VMCALL_ALIGN_ERROR;
+        return 0;
+    }
+
+    /* Overflow case. */
+    if (gpa + size < gpa) {
+        return 0;
+    }
+    if (gpa >= (1ULL << cpu->phys_bits) ||
+        gpa + size >= (1ULL << cpu->phys_bits)) {
+        return 0;
+    }
+
+    if (size > TDX_MAP_GPA_MAX_LEN) {
+        retry = true;
+        size = TDX_MAP_GPA_MAX_LEN;
+    }
+
+    if (size > 0) {
+        ret = kvm_convert_memory(gpa, size, private);
+    }
+
+    if (!ret) {
+        if (retry) {
+            vmcall->status_code = TDG_VP_VMCALL_RETRY;
+            vmcall->out_r11 = gpa + size;
+            if (!private) {
+                vmcall->out_r11 |= shared_bit;
+            }
+        } else {
+            vmcall->status_code = TDG_VP_VMCALL_SUCCESS;
+        }
+    }
+
+    return 0;
+}
+
 static void tdx_get_quote_completion(struct tdx_generate_quote_task *task)
 {
     int ret;
@@ -1056,6 +1108,8 @@ static int tdx_handle_vmcall(X86CPU *cpu, struct kvm_tdx_vmcall *vmcall)
     }
 
     switch (vmcall->subfunction) {
+    case TDG_VP_VMCALL_MAP_GPA:
+        return tdx_handle_map_gpa(cpu, vmcall);
     case TDG_VP_VMCALL_GET_QUOTE:
         return tdx_handle_get_quote(cpu, vmcall);
     case TDG_VP_VMCALL_SETUP_EVENT_NOTIFY_INTERRUPT:
diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
index c6e4c275262d..cedc7d7e226f 100644
--- a/target/i386/kvm/tdx.h
+++ b/target/i386/kvm/tdx.h
@@ -18,6 +18,7 @@ typedef struct TdxGuestClass {
     ConfidentialGuestSupportClass parent_class;
 } TdxGuestClass;
 
+#define TDG_VP_VMCALL_MAP_GPA                           0x10001ULL
 #define TDG_VP_VMCALL_GET_QUOTE                         0x10002ULL
 #define TDG_VP_VMCALL_SETUP_EVENT_NOTIFY_INTERRUPT      0x10004ULL
 
-- 
2.34.1


