Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD14EC83F04
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:36:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWenl-0003y7-IG; Tue, 01 Jul 2025 13:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uWenj-0003np-Mp
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:29:47 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uWeng-0006ln-5d
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:29:47 -0400
Received: from localhost.localdomain (unknown [167.220.208.67])
 by linux.microsoft.com (Postfix) with ESMTPSA id 6F53C2112236;
 Tue,  1 Jul 2025 10:29:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6F53C2112236
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1751390983;
 bh=Y4vhPW1L/apWF7A2PygowCDp5jO99b8a9HgfYCjLboI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hycZXmQZF60SDp6nNrn1MYE18EJXtTfFFU1NarpNWbg/EuM1KC/ZhBIzdniwggSjb
 gwM7RytFV6O74eg37fLRDjm83RSdohXNxDZLe0Q2gaJwVGadaD7qNoqbkgqQ3mVLtK
 SjxAYfdzQx6gKJmawKtjpV3wltEo50cWmZ0S2Z08=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, Thomas Huth <thuth@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <liuwe@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 10/27] accel/mshv: Add ioeventfd support
Date: Tue,  1 Jul 2025 19:28:17 +0200
Message-Id: <20250701172834.44849-11-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250701172834.44849-1-magnuskulke@linux.microsoft.com>
References: <20250701172834.44849-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
 accel/mshv/mshv-all.c   | 116 ++++++++++++++++++++++++++++++++++++++++
 accel/mshv/trace-events |   3 ++
 include/system/mshv.h   |   8 +++
 3 files changed, 127 insertions(+)

diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 712e651627..2ae9d1cffa 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -7,6 +7,7 @@
  *  Ziqiao Zhou       <ziqiaozhou@microsoft.com>
  *  Magnus Kulke      <magnuskulke@microsoft.com>
  *  Jinank Jain       <jinankjain@microsoft.com>
+ *  Wei Liu           <liuwe@microsoft.com>
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
@@ -236,11 +237,126 @@ static void mem_region_del(MemoryListener *listener,
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
+    uint64_t addr = section->offset_within_address_space;
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
+    uint64_t addr = section->offset_within_address_space;
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
index 9a3af6b8be..b49a5b1702 100644
--- a/accel/mshv/trace-events
+++ b/accel/mshv/trace-events
@@ -1,6 +1,9 @@
 # See docs/devel/tracing.rst for syntax documentation.
 
 mshv_set_memory(bool add, uint64_t gpa, uint64_t size, uint64_t user_addr, bool readonly, int ret) "[add = %d] gpa = %lx size = %lx user = %lx readonly = %d result = %d"
+mshv_mem_ioeventfd_add(uint64_t addr, uint32_t size, uint32_t data) "addr %lx size %d data %x"
+mshv_mem_ioeventfd_del(uint64_t addr, uint32_t size, uint32_t data) "addr %lx size %d data %x"
+
 mshv_hvcall_args(const char* hvcall, uint16_t code, uint16_t in_sz) "built args for '%s' code: %d in_sz: %d"
 
 mshv_set_msi_routing(uint32_t gsi, uint64_t addr, uint32_t data) "gsi=%d addr=%lx data=%x"
diff --git a/include/system/mshv.h b/include/system/mshv.h
index 3624d9477f..c2b0414c85 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -30,6 +30,14 @@
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
 
 #ifdef CONFIG_MSHV_IS_POSSIBLE
-- 
2.34.1


