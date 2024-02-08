Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F55C4829B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 03:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXujT-0005xY-OV; Wed, 07 Feb 2024 22:05:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXujN-0005xG-FN
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:05:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXujL-0004IH-Jm
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:05:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707361538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a/kk9ED0hp2bNq45sK/1IjSd9mSuqonRqlMm1eHzFT0=;
 b=YcWvus429cWOWOBlEdVg7n9h2hkIkyudcvBxgd4Ef15/8qJRD2pTna8333eW5AJcTpb+1A
 rj6HwYW5WsmPVTgAXEd35uRPyBahUfbEjAiXLFhWK/43d+G+C20qr4bh/SYy/1kaEu09mG
 v8XEGKyv5YzKEhd4x6nZNlR6rU/IAuw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-cWyNToBZObyLGfxmDb0-Tw-1; Wed,
 07 Feb 2024 22:05:37 -0500
X-MC-Unique: cWyNToBZObyLGfxmDb0-Tw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7B81D3C0F189;
 Thu,  8 Feb 2024 03:05:36 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 20A35492BC7;
 Thu,  8 Feb 2024 03:05:33 +0000 (UTC)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 William Roche <william.roche@oracle.com>
Subject: [PULL 01/34] migration: prevent migration when VM has poisoned memory
Date: Thu,  8 Feb 2024 11:04:55 +0800
Message-ID: <20240208030528.368214-2-peterx@redhat.com>
In-Reply-To: <20240208030528.368214-1-peterx@redhat.com>
References: <20240208030528.368214-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: William Roche <william.roche@oracle.com>

A memory page poisoned from the hypervisor level is no longer readable.
The migration of a VM will crash Qemu when it tries to read the
memory address space and stumbles on the poisoned page with a similar
stack trace:

Program terminated with signal SIGBUS, Bus error.
#0  _mm256_loadu_si256
#1  buffer_zero_avx2
#2  select_accel_fn
#3  buffer_is_zero
#4  save_zero_page
#5  ram_save_target_page_legacy
#6  ram_save_host_page
#7  ram_find_and_save_block
#8  ram_save_iterate
#9  qemu_savevm_state_iterate
#10 migration_iteration_run
#11 migration_thread
#12 qemu_thread_start

To avoid this VM crash during the migration, prevent the migration
when a known hardware poison exists on the VM.

Signed-off-by: William Roche <william.roche@oracle.com>
Link: https://lore.kernel.org/r/20240130190640.139364-2-william.roche@oracle.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/sysemu/kvm.h   |  6 ++++++
 accel/kvm/kvm-all.c    | 10 ++++++++++
 accel/stubs/kvm-stub.c |  5 +++++
 migration/migration.c  |  7 +++++++
 4 files changed, 28 insertions(+)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index d614878164..fad9a7e8ff 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -538,4 +538,10 @@ bool kvm_arch_cpu_check_are_resettable(void);
 bool kvm_dirty_ring_enabled(void);
 
 uint32_t kvm_dirty_ring_size(void);
+
+/**
+ * kvm_hwpoisoned_mem - indicate if there is any hwpoisoned page
+ * reported for the VM.
+ */
+bool kvm_hwpoisoned_mem(void);
 #endif
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 49e755ec4a..a8cecd040e 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1119,6 +1119,11 @@ int kvm_vm_check_extension(KVMState *s, unsigned int extension)
     return ret;
 }
 
+/*
+ * We track the poisoned pages to be able to:
+ * - replace them on VM reset
+ * - block a migration for a VM with a poisoned page
+ */
 typedef struct HWPoisonPage {
     ram_addr_t ram_addr;
     QLIST_ENTRY(HWPoisonPage) list;
@@ -1152,6 +1157,11 @@ void kvm_hwpoison_page_add(ram_addr_t ram_addr)
     QLIST_INSERT_HEAD(&hwpoison_page_list, page, list);
 }
 
+bool kvm_hwpoisoned_mem(void)
+{
+    return !QLIST_EMPTY(&hwpoison_page_list);
+}
+
 static uint32_t adjust_ioeventfd_endianness(uint32_t val, uint32_t size)
 {
 #if HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index 1b37d9a302..ca38172884 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -124,3 +124,8 @@ uint32_t kvm_dirty_ring_size(void)
 {
     return 0;
 }
+
+bool kvm_hwpoisoned_mem(void)
+{
+    return false;
+}
diff --git a/migration/migration.c b/migration/migration.c
index d5f705ceef..b574e66f7b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -67,6 +67,7 @@
 #include "options.h"
 #include "sysemu/dirtylimit.h"
 #include "qemu/sockets.h"
+#include "sysemu/kvm.h"
 
 static NotifierList migration_state_notifiers =
     NOTIFIER_LIST_INITIALIZER(migration_state_notifiers);
@@ -1906,6 +1907,12 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
         return false;
     }
 
+    if (kvm_hwpoisoned_mem()) {
+        error_setg(errp, "Can't migrate this vm with hardware poisoned memory, "
+                   "please reboot the vm and try again");
+        return false;
+    }
+
     if (migration_is_blocked(errp)) {
         return false;
     }
-- 
2.43.0


