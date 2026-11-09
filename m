Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C15F606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 19:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fZnyGpsR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQUav-0001dt-6T; Mon, 09 Nov 2026 13:59:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xQUar-0001WR-5b
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 13:59:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xQUap-0006M4-BS
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 13:59:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794250786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OBhOYGW63+HK7TQ6MenaEpD8gvCGw1S/+JkFwZX0PFI=;
 b=fZnyGpsRVgKDomz4XtO8E7fHHaUZLCi+q2HAimLktX0iGkMd0/go2Ng6bYWRHZ45f3E4dU
 MPPhm3Er4iRjA4t3vxj15+SfHujIbSkcJRdcn+yVvinzK1yfLRPrN7EQwk1yfhCPQz6l9Q
 W2yRzi5pX0o/Y22MnU6Z3hgcO2D6bkQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-vpTCLsTbPRmlaLBpyEUBxQ-1; Mon,
 09 Nov 2026 13:59:42 -0500
X-MC-Unique: vpTCLsTbPRmlaLBpyEUBxQ-1
X-Mimecast-MFC-AGG-ID: vpTCLsTbPRmlaLBpyEUBxQ_1794250780
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F508195BDF0; Mon,  9 Nov 2026 18:59:40 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.81])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 779C61956087; Mon,  9 Nov 2026 18:59:37 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Alistair Francis <alistair.francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, John Snow <jsnow@redhat.com>
Subject: [PATCH 7/7] debug/mem: HACK add qemu_name_buffer
Date: Mon,  9 Nov 2026 13:59:07 -0500
Message-ID: <20261109185907.3220584-8-jsnow@redhat.com>
In-Reply-To: <20261109185907.3220584-1-jsnow@redhat.com>
References: <20261109185907.3220584-1-jsnow@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is a hack to allow us to name malloc'd buffers that are backed by
anonymous mmap allocations.

Quite useful in my debugging, probably not quite appropriate for
upstream unless we can figure out a more robust method for identifying
when we get an mmap'd page from malloc and adjusting the pointer
offset accordingly - I am currently subtracting a fixed 16 bytes
because that "works on my system", and I have no clue if that's
appropriate everywhere or not.

At least this way, my trick is published to the list for posterity.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 include/qemu/bitmap.h   |  6 ++++++
 include/qemu/mmap-vma.h |  3 +++
 hw/core/loader.c        |  3 +++
 hw/i386/x86-common.c    |  3 +++
 system/device_tree.c    |  2 ++
 system/physmem.c        |  8 ++++++--
 util/mmap-vma.c         | 23 +++++++++++++++++++++++
 7 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/include/qemu/bitmap.h b/include/qemu/bitmap.h
index 0044333cb51..6681c87737f 100644
--- a/include/qemu/bitmap.h
+++ b/include/qemu/bitmap.h
@@ -104,6 +104,12 @@ static inline unsigned long *bitmap_try_new(long nbits)
     return g_try_new0(unsigned long, nelem);
 }
 
+static inline size_t bitmap_size(long nbits)
+{
+    long nelem = BITS_TO_LONGS(nbits);
+    return sizeof(unsigned long) * nelem;
+}
+
 static inline unsigned long *bitmap_new(long nbits)
 {
     long nelem = BITS_TO_LONGS(nbits);
diff --git a/include/qemu/mmap-vma.h b/include/qemu/mmap-vma.h
index 763ea5a5cab..4646657022c 100644
--- a/include/qemu/mmap-vma.h
+++ b/include/qemu/mmap-vma.h
@@ -15,4 +15,7 @@
 int qemu_name_vma(void *ptr, size_t sz, const char *fmt, ...)
     G_GNUC_PRINTF(3, 4);
 
+int qemu_name_buffer(void *ptr, size_t sz, const char *fmt, ...)
+    G_GNUC_PRINTF(3, 4);
+
 #endif
diff --git a/hw/core/loader.c b/hw/core/loader.c
index 5cbfba0a86d..cc0e0d6979a 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -45,6 +45,7 @@
 #include "qemu/osdep.h"
 #include "qemu/datadir.h"
 #include "qemu/error-report.h"
+#include "qemu/mmap-vma.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine.h"
 #include "qapi/type-helpers.h"
@@ -1111,6 +1112,8 @@ ssize_t rom_add_file(const char *file, const char *fw_dir,
         goto err;
     }
 
+    qemu_name_buffer(rom->data, size, "%s", file);
+
     if (fw_dir) {
         rom->fw_dir  = g_strdup(fw_dir);
         rom->fw_file = g_strdup(file);
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index dcd4fa8eb79..608c4cf4202 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -25,6 +25,7 @@
 #include "qemu/cutils.h"
 #include "qemu/units.h"
 #include "qemu/datadir.h"
+#include "qemu/mmap-vma.h"
 #include "qapi/error.h"
 #include "system/numa.h"
 #include "system/system.h"
@@ -914,6 +915,8 @@ void x86_load_linux(X86MachineState *x86ms,
 
     setup  = g_malloc(setup_size);
     kernel = g_malloc(kernel_size);
+    qemu_name_buffer(kernel, kernel_size, "%s", kernel_filename);
+
     fseek(f, 0, SEEK_SET);
     if (fread(setup, 1, setup_size, f) != setup_size) {
         fprintf(stderr, "fread() failed\n");
diff --git a/system/device_tree.c b/system/device_tree.c
index 48365435ea0..816874fb299 100644
--- a/system/device_tree.c
+++ b/system/device_tree.c
@@ -27,6 +27,7 @@
 #include "hw/core/loader.h"
 #include "hw/core/boards.h"
 #include "qemu/config-file.h"
+#include "qemu/mmap-vma.h"
 #include "qapi/qapi-commands-machine.h"
 #include "qobject/qdict.h"
 
@@ -41,6 +42,7 @@ void *create_device_tree(int *sizep)
 
     *sizep = FDT_MAX_SIZE;
     fdt = g_malloc0(FDT_MAX_SIZE);
+    qemu_name_buffer(fdt, FDT_MAX_SIZE, "device_tree");
     ret = fdt_create(fdt, FDT_MAX_SIZE);
     if (ret < 0) {
         goto fail;
diff --git a/system/physmem.c b/system/physmem.c
index 202e3a5cd00..dc0e9540919 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -26,6 +26,7 @@
 #include "qemu/hbitmap.h"
 #include "qemu/madvise.h"
 #include "qemu/lockable.h"
+#include "qemu/mmap-vma.h"
 
 #ifdef CONFIG_TCG
 #include "accel/tcg/cpu-ops.h"
@@ -2105,7 +2106,7 @@ void qemu_ram_msync(RAMBlock *block, ram_addr_t start, ram_addr_t length)
 }
 
 /* Called with ram_list.mutex held */
-static void dirty_memory_extend(ram_addr_t new_ram_size)
+static void dirty_memory_extend(ram_addr_t new_ram_size, const char *nickname)
 {
     unsigned int old_num_blocks = ram_list.num_dirty_blocks;
     unsigned int new_num_blocks = DIV_ROUND_UP(new_ram_size,
@@ -2133,6 +2134,9 @@ static void dirty_memory_extend(ram_addr_t new_ram_size)
 
         for (j = old_num_blocks; j < new_num_blocks; j++) {
             new_blocks->blocks[j] = bitmap_new(DIRTY_MEMORY_BLOCK_SIZE);
+            qemu_name_buffer(new_blocks->blocks[j],
+                             bitmap_size(DIRTY_MEMORY_BLOCK_SIZE),
+                             "bitmap<%s>", nickname);
         }
 
         qatomic_rcu_set(&ram_list.dirty_memory[i], new_blocks);
@@ -2254,7 +2258,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
     }
 
     ram_size = (new_block->offset + new_block->max_length) >> TARGET_PAGE_BITS;
-    dirty_memory_extend(ram_size);
+    dirty_memory_extend(ram_size, new_block->mr->name);
     /* Keep the list sorted from biggest to smallest block.  Unlike QTAILQ,
      * QLIST (which has an RCU-friendly variant) does not have insertion at
      * tail, so save the last element in last_block.
diff --git a/util/mmap-vma.c b/util/mmap-vma.c
index 93ca7f608d7..9b1309df635 100644
--- a/util/mmap-vma.c
+++ b/util/mmap-vma.c
@@ -69,3 +69,26 @@ int qemu_name_vma(void *ptr, size_t sz, const char *fmt, ...)
     va_start(args, fmt);
     return qemu_vname_vma(ptr, sz, fmt, args);
 }
+
+G_GNUC_PRINTF(3, 4)
+int qemu_name_buffer(void *ptr, size_t sz, const char *fmt, ...)
+{
+    /*
+     * this is hacky as hell, but ptmalloc will occasionally use
+     * mmap() for large buffers - when it does so, you get a pointer
+     * to 16 bytes after the actual mmap. This function compensates
+     * for that to guess at what the real mmap allocation was.
+     *
+     * This can be used unconditionally whether or not the allocation
+     * was actually mmap'd - if it wasn't, this just fails. Yes, it's
+     * still very ugly.
+     */
+    va_list args;
+    size_t pagesz = qemu_real_host_page_size();
+
+    ptr = ptr - 0x10;
+    sz = ROUND_UP(sz + 0x10, pagesz);
+
+    va_start(args, fmt);
+    return qemu_vname_vma(ptr, sz, fmt, args);
+}
-- 
2.56.0


