Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE71C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 11:33:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHLCD-00089e-1v; Tue, 20 May 2025 07:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uHLCA-00088z-Mw
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:31:42 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uHLC7-0001HZ-K5
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:31:42 -0400
Received: from DESKTOP-TUU1E5L.fritz.box (unknown [172.201.77.43])
 by linux.microsoft.com (Postfix) with ESMTPSA id D119120277D6;
 Tue, 20 May 2025 04:31:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D119120277D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1747740698;
 bh=1nUtVlExxdhKd/HsSeA0eTTcYYMS+gfpzYc5w0MxzG0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nQEgqMa7ZNGjTo30jhc2EE20c8cjCsZdi8AGrh9UAfHxgDZZVdZRGDmNIKfysjh3R
 /q01aHqUVsDmxVKktwh8Gq0ds8GzJ9EEEoJxyRObiRJVt+0wkJXTCnm0MJ+8+gj5nS
 iOvzYltHUzycjNZdfHCvGJVgh69/x7LD9cVKoz98=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: magnuskulke@microsoft.com,
	qemu-devel@nongnu.org,
	liuwe@microsoft.com
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [RFC PATCH 09/25] accel/mshv: Register guest memory regions with
 hypervisor
Date: Tue, 20 May 2025 13:30:02 +0200
Message-Id: <20250520113018.49569-10-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
References: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Handle region_add events by invoking the MSHV memory registration
ioctl to map guest memory into the hypervisor partition. This allows
the guest to access memory through MSHV-managed mappings.

Note that this assumes the hypervisor will accept regions that overlap
in userspace_addr. Currently that's not the case, it will be addressed
in a later commit in the series.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/mshv/mem.c        | 116 ++++++++++++++++++++++++++++++++++++++--
 accel/mshv/trace-events |   1 +
 include/system/mshv.h   |  11 ++++
 3 files changed, 125 insertions(+), 3 deletions(-)

diff --git a/accel/mshv/mem.c b/accel/mshv/mem.c
index eddd83ae83..2bbeae4f4a 100644
--- a/accel/mshv/mem.c
+++ b/accel/mshv/mem.c
@@ -13,13 +13,123 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "hw/hyperv/linux-mshv.h"
 #include "system/address-spaces.h"
 #include "system/mshv.h"
+#include "exec/memattrs.h"
+#include <sys/ioctl.h>
+#include "trace.h"
+
+static int set_guest_memory(int vm_fd, const mshv_user_mem_region *region)
+{
+    int ret;
+
+    ret = ioctl(vm_fd, MSHV_SET_GUEST_MEMORY, region);
+    if (ret < 0) {
+        error_report("failed to set guest memory");
+        return -errno;
+    }
+
+    return 0;
+}
+
+static int map_or_unmap(int vm_fd, const MshvMemoryRegion *mr, bool add)
+{
+    struct mshv_user_mem_region region = {0};
+
+    region.guest_pfn = mr->guest_phys_addr >> MSHV_PAGE_SHIFT;
+    region.size = mr->memory_size;
+    region.userspace_addr = mr->userspace_addr;
+
+    if (!add) {
+        region.flags |= (1 << MSHV_SET_MEM_BIT_UNMAP);
+        return set_guest_memory(vm_fd, &region);
+    }
+
+    region.flags = (1 << MSHV_SET_MEM_BIT_EXECUTABLE);
+    if (!mr->readonly) {
+        region.flags |= (1 << MSHV_SET_MEM_BIT_WRITABLE);
+    }
+
+    return set_guest_memory(vm_fd, &region);
+}
+
+static int set_memory(const MshvMemoryRegion *mshv_mr, bool add)
+{
+    int ret = 0;
+
+    if (!mshv_mr) {
+        error_report("Invalid mshv_mr");
+        return -1;
+    }
+
+    trace_mshv_set_memory(add, mshv_mr->guest_phys_addr,
+                          mshv_mr->memory_size,
+                          mshv_mr->userspace_addr, mshv_mr->readonly,
+                          ret);
+    return map_or_unmap(mshv_state->vm, mshv_mr, add);
+}
+
+/*
+ * Calculate and align the start address and the size of the section.
+ * Return the size. If the size is 0, the aligned section is empty.
+ */
+static hwaddr align_section(MemoryRegionSection *section, hwaddr *start)
+{
+    hwaddr size = int128_get64(section->size);
+    hwaddr delta, aligned;
+
+    /*
+     * works in page size chunks, but the function may be called
+     * with sub-page size and unaligned start address. Pad the start
+     * address to next and truncate size to previous page boundary.
+     */
+    aligned = ROUND_UP(section->offset_within_address_space,
+                       qemu_real_host_page_size());
+    delta = aligned - section->offset_within_address_space;
+    *start = aligned;
+    if (delta > size) {
+        return 0;
+    }
+
+    return (size - delta) & qemu_real_host_page_mask();
+}
 
 void mshv_set_phys_mem(MshvMemoryListener *mml, MemoryRegionSection *section,
                        bool add)
 {
-	error_report("unimplemented");
-	abort();
-}
+    int ret = 0;
+    MemoryRegion *area = section->mr;
+    bool writable = !area->readonly && !area->rom_device;
+    hwaddr start_addr, mr_offset, size;
+    void *ram;
+    MshvMemoryRegion tmp, *mshv_mr = &tmp;
+
+    if (!memory_region_is_ram(area)) {
+        if (writable) {
+            return;
+        }
+    }
+
+    size = align_section(section, &start_addr);
+    if (!size) {
+        return;
+    }
+
+    mr_offset = section->offset_within_region + start_addr -
+                section->offset_within_address_space;
 
+    ram = memory_region_get_ram_ptr(area) + mr_offset;
+
+    memset(mshv_mr, 0, sizeof(*mshv_mr));
+    mshv_mr->guest_phys_addr = start_addr;
+    mshv_mr->memory_size = size;
+    mshv_mr->readonly = !writable;
+    mshv_mr->userspace_addr = (uint64_t)ram;
+
+    ret = set_memory(mshv_mr, add);
+    if (ret < 0) {
+        error_report("Failed to set memory region");
+        abort();
+    }
+}
diff --git a/accel/mshv/trace-events b/accel/mshv/trace-events
index f99e8c5a41..63625192ec 100644
--- a/accel/mshv/trace-events
+++ b/accel/mshv/trace-events
@@ -1,3 +1,4 @@
 # See docs/devel/tracing.rst for syntax documentation.
 
+mshv_set_memory(bool add, uint64_t gpa, uint64_t size, uint64_t user_addr, bool readonly, int ret) "[add = %d] gpa = %lx size = %lx user = %lx readonly = %d result = %d"
 mshv_hvcall_args(const char* hvcall, uint16_t code, uint16_t in_sz) "built args for '%s' code: %d in_sz: %d"
diff --git a/include/system/mshv.h b/include/system/mshv.h
index 398cda3254..bed28b48a9 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -32,6 +32,8 @@
 #define CONFIG_MSHV_IS_POSSIBLE
 #endif
 
+#define MSHV_PAGE_SHIFT 12
+
 
 #ifdef CONFIG_MSHV_IS_POSSIBLE
 extern bool mshv_allowed;
@@ -84,6 +86,15 @@ int mshv_hvcall(int mshv_fd, const struct mshv_root_hvcall *args);
 
 
 /* memory */
+typedef struct MshvMemoryRegion {
+    uint64_t guest_phys_addr;
+    uint64_t memory_size;
+    uint64_t userspace_addr;
+    bool readonly;
+} MshvMemoryRegion;
+
+int mshv_add_mem(int vm_fd, const MshvMemoryRegion *mr);
+int mshv_remove_mem(int vm_fd, const MshvMemoryRegion *mr);
 void mshv_set_phys_mem(MshvMemoryListener *mml, MemoryRegionSection *section,
                        bool add);
 /* interrupt */
-- 
2.34.1


