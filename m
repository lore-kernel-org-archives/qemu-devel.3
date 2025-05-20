Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9264EC54799
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 11:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHLCG-0008AT-ES; Tue, 20 May 2025 07:31:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uHLCF-0008AE-0g
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:31:47 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uHLCC-0001IA-Kk
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:31:46 -0400
Received: from DESKTOP-TUU1E5L.fritz.box (unknown [172.201.77.43])
 by linux.microsoft.com (Postfix) with ESMTPSA id 3F6A120277DE;
 Tue, 20 May 2025 04:31:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3F6A120277DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1747740702;
 bh=FY/9PE7gpu6Y+lOrFYEDXYlsu+sMvVNQC4SrgpOJyJw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DELX3bUHjw+AEPUNDrOARzHSPzzaHrufdDLx+s7WEonDP4IBYfNp/lxWzVQDiWwEN
 d4Oes2QEF4GPsU/z7rnhr3mopY+0a9U3Spx8bVcGMyBKd7rbuLabld0LHMm6NyoI3h
 O9TavWwY46QcQHdy2o5R56RisaDcexZpUI7NUiF8=
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
Subject: [RFC PATCH 10/25] accel/mshv: Add ioeventfd support
Date: Tue, 20 May 2025 13:30:03 +0200
Message-Id: <20250520113018.49569-11-magnuskulke@linux.microsoft.com>
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

Implement ioeventfd registration in the MSHV accelerator backend to
handle guest-triggered events. This enables integration with QEMU's
eventfd-based I/O mechanism.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/mshv/mshv-all.c   | 115 ++++++++++++++++++++++++++++++++++++++++
 accel/mshv/trace-events |   3 ++
 include/system/mshv.h   |   8 +++
 3 files changed, 126 insertions(+)

diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 95f1008a48..e4085b216d 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -239,11 +239,126 @@ static void mem_region_del(MemoryListener *listener,
     memory_region_unref(section->mr);
 }
 
+typedef enum {
+    DATAMATCH_NONE,
+    DATAMATCH_U32,
+    DATAMATCH_U64,
+} DatamatchTag;
+
+typedef struct {
+    DatamatchTag tag;
+    union {
+        uint32_t u32;
+        uint64_t u64;
+    } value;
+} Datamatch;
+
+/* flags: determine whether to de/assign */
+static int ioeventfd(int vm_fd, int event_fd, uint64_t addr, Datamatch dm,
+                     uint32_t flags)
+{
+    mshv_user_ioeventfd args = {0};
+    args.fd = event_fd;
+    args.addr = addr;
+    args.flags = flags;
+
+    if (dm.tag == DATAMATCH_NONE) {
+        args.datamatch = 0;
+    } else {
+        flags |= BIT(MSHV_IOEVENTFD_BIT_DATAMATCH);
+        args.flags = flags;
+        if (dm.tag == DATAMATCH_U64) {
+            args.len = sizeof(uint64_t);
+            args.datamatch = dm.value.u64;
+        } else {
+            args.len = sizeof(uint32_t);
+            args.datamatch = dm.value.u32;
+        }
+    }
+
+    return ioctl(vm_fd, MSHV_IOEVENTFD, &args);
+}
+
+static int unregister_ioevent(int vm_fd, int event_fd, uint64_t mmio_addr)
+{
+    uint32_t flags = 0;
+    Datamatch dm = {0};
+
+    flags |= BIT(MSHV_IOEVENTFD_BIT_DEASSIGN);
+    dm.tag = DATAMATCH_NONE;
+
+    return ioeventfd(vm_fd, event_fd, mmio_addr, dm, flags);
+}
+
+static int register_ioevent(int vm_fd, int event_fd, uint64_t mmio_addr,
+                            uint64_t val, bool is_64bit, bool is_datamatch)
+{
+    uint32_t flags = 0;
+    Datamatch dm = {0};
+
+    if (!is_datamatch) {
+        dm.tag = DATAMATCH_NONE;
+    } else if (is_64bit) {
+        dm.tag = DATAMATCH_U64;
+        dm.value.u64 = val;
+    } else {
+        dm.tag = DATAMATCH_U32;
+        dm.value.u32 = val;
+    }
+
+    return ioeventfd(vm_fd, event_fd, mmio_addr, dm, flags);
+}
+
+static void mem_ioeventfd_add(MemoryListener *listener,
+                              MemoryRegionSection *section,
+                              bool match_data, uint64_t data,
+                              EventNotifier *e)
+{
+    int fd = event_notifier_get_fd(e);
+    int ret;
+    bool is_64 = int128_get64(section->size) == 8;
+    uint64_t addr = section->offset_within_address_space & 0xffffffff;
+
+    trace_mshv_mem_ioeventfd_add(addr, int128_get64(section->size), data);
+
+    ret = register_ioevent(mshv_state->vm, fd, addr, data, is_64, match_data);
+
+    if (ret < 0) {
+        error_report("Failed to register ioeventfd: %s (%d)", strerror(-ret),
+                     -ret);
+        abort();
+    }
+}
+
+static void mem_ioeventfd_del(MemoryListener *listener,
+                              MemoryRegionSection *section,
+                              bool match_data, uint64_t data,
+                              EventNotifier *e)
+{
+    int fd = event_notifier_get_fd(e);
+    int ret;
+    uint64_t addr = section->offset_within_address_space & 0xffffffff;
+
+    trace_mshv_mem_ioeventfd_del(section->offset_within_address_space,
+                                 int128_get64(section->size), data);
+
+    ret = unregister_ioevent(mshv_state->vm, fd, addr);
+    if (ret < 0) {
+        error_report("Failed to unregister ioeventfd: %s (%d)", strerror(-ret),
+                     -ret);
+        abort();
+    }
+}
+
 static MemoryListener mshv_memory_listener = {
     .name = "mshv",
     .priority = MEMORY_LISTENER_PRIORITY_ACCEL,
     .region_add = mem_region_add,
     .region_del = mem_region_del,
+#ifdef MSHV_USE_IOEVENTFD
+    .eventfd_add = mem_ioeventfd_add,
+    .eventfd_del = mem_ioeventfd_del,
+#endif
 };
 
 static MemoryListener mshv_io_listener = {
diff --git a/accel/mshv/trace-events b/accel/mshv/trace-events
index 63625192ec..5929cb45a5 100644
--- a/accel/mshv/trace-events
+++ b/accel/mshv/trace-events
@@ -1,4 +1,7 @@
 # See docs/devel/tracing.rst for syntax documentation.
 
 mshv_set_memory(bool add, uint64_t gpa, uint64_t size, uint64_t user_addr, bool readonly, int ret) "[add = %d] gpa = %lx size = %lx user = %lx readonly = %d result = %d"
+mshv_mem_ioeventfd_add(uint64_t addr, uint32_t size, uint32_t data) "addr %lx size %d data %x"
+mshv_mem_ioeventfd_del(uint64_t addr, uint32_t size, uint32_t data) "addr %lx size %d data %x"
+
 mshv_hvcall_args(const char* hvcall, uint16_t code, uint16_t in_sz) "built args for '%s' code: %d in_sz: %d"
diff --git a/include/system/mshv.h b/include/system/mshv.h
index bed28b48a9..c7ee4f0cc1 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -32,6 +32,14 @@
 #define CONFIG_MSHV_IS_POSSIBLE
 #endif
 
+/*
+ * Set to 0 if we do not want to use eventfd to optimize the MMIO events.
+ * Set to 1 so that mshv kernel driver receives doorbell when the VM access
+ * MMIO memory and then signal eventfd to notify the qemu device
+ * without extra switching to qemu to emulate mmio access.
+ */
+#define MSHV_USE_IOEVENTFD 1
+
 #define MSHV_PAGE_SHIFT 12
 
 
-- 
2.34.1


