Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C38CCD1288
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 03:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq2yY-0005ay-Bd; Thu, 28 Mar 2024 23:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1rq2yW-0005am-Jx
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 23:32:16 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1rq2yT-0004Kb-Kp
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 23:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711683133; x=1743219133;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=J3VD/8BKIhUQIX2iZjySw1S5ebNY1ZfLZEv650rtTUA=;
 b=TN6UYWqtmjdwC4J3FA3oHMbx6UUm8RXMKL9TZv4Q4ZB7U+T5lF/EL/ko
 PqvNsFJHK8aQ85RnAdEq/O/85DjbpsxKLpGBdfHnxGHgDv8qGeRVk7QUU
 Ib8qWlcjpC5pTzR35vBVGsUt0/KdjjTyscsFlnX9pVAb6i9X7qdej+t4Q
 cInEVTZEyuuAtwDkP4Eovc4+nzl06t0ik3trRGORcRWpEl4POYsCZqhvP
 cjqFl/IAFA/jBqxOgLvx/8Lt8UlFQ7s2bTDRsGxCLTHb4TaHlDrTWC91q
 05tYA2AJdi3DGPJydUdYfHj8Ec+jYvV4pyHMm0dJHSvSKIGhUnxGT/bzj g==;
X-CSE-ConnectionGUID: 5Q0BvKqzSyi4tTvQqSRT5A==
X-CSE-MsgGUID: 8JzNI4CzSLC9d7qBHz7LQw==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="6808820"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="6808820"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2024 20:32:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; d="scan'208";a="17497149"
Received: from gnr-bkc.sh.intel.com ([10.239.48.132])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2024 20:32:08 -0700
From: Lei Wang <lei4.wang@intel.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, wei.w.wang@intel.com,
 lei4.wang@intel.com
Subject: [PATCH] migration: Yield coroutine when receiving
 MIG_CMD_POSTCOPY_LISTEN
Date: Thu, 28 Mar 2024 23:32:05 -0400
Message-Id: <20240329033205.26087-1-lei4.wang@intel.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21; envelope-from=lei4.wang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

When using the post-copy preemption feature to perform post-copy live
migration, the below scenario could lead to a deadlock and the migration
will never finish:

 - Source connect() the preemption channel in postcopy_start().
 - Source and the destination side TCP stack finished the 3-way handshake
   thus the connection is successful.
 - The destination side main thread is handling the loading of the bulk RAM
   pages thus it doesn't start to handle the pending connection event in the
   event loop. and doesn't post the semaphore postcopy_qemufile_dst_done for
   the preemption thread.
 - The source side sends non-iterative device states, such as the virtio
   states.
 - The destination main thread starts to receive the virtio states, this
   process may lead to a page fault (e.g., virtio_load()->vring_avail_idx()
   may trigger a page fault since the avail ring page may not be received
   yet).
 - The page request is sent back to the source side. Source sends the page
   content to the destination side preemption thread.
 - Since the event is not arrived and the semaphore
   postcopy_qemufile_dst_done is not posted, the preemption thread in
   destination side is blocked, and cannot handle receiving the page.
 - The QEMU main load thread on the destination side is stuck at the page
   fault, and cannot yield and handle the connect() event for the
   preemption channel to unblock the preemption thread.
 - The postcopy will stuck there forever since this is a deadlock.

The key point to reproduce this bug is that the source side is sending pages
at a rate faster than the destination handling, otherwise,
the qemu_get_be64() in ram_load_precopy() will have a chance to yield since
at that time there are no pending data in the buffer to get. This will make
this bug harder to be reproduced.

Fix this by yielding the load coroutine when receiving
MIG_CMD_POSTCOPY_LISTEN so the main event loop can handle the connection
event before loading the non-iterative devices state to avoid the deadlock
condition.

Signed-off-by: Lei Wang <lei4.wang@intel.com>
---
 migration/savevm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index e386c5267f..8fd4dc92f2 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2445,6 +2445,11 @@ static int loadvm_process_command(QEMUFile *f)
         return loadvm_postcopy_handle_advise(mis, len);
 
     case MIG_CMD_POSTCOPY_LISTEN:
+        if (migrate_postcopy_preempt() && qemu_in_coroutine()) {
+            aio_co_schedule(qemu_get_current_aio_context(),
+                            qemu_coroutine_self());
+            qemu_coroutine_yield();
+        }
         return loadvm_postcopy_handle_listen(mis);
 
     case MIG_CMD_POSTCOPY_RUN:
-- 
2.39.3


