Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F54FCD1292
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 10:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsJys-0007ai-4V; Thu, 04 Apr 2024 06:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1rsJyq-0007aW-AE
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 06:06:00 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1rsJym-00020k-QS
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 06:06:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712225156; x=1743761156;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=qPJHs5IRDK5Kl7oXD7X7+rUG9w8UCl78b969bFHQ7Xc=;
 b=iIou6jotFC0Xh1wnaSUyG0lEAv8vlj2ASSYmt4AbwjwhYyRzo5caADy2
 kvuMLb/dmD78vDeDT4Cp4OqL9AcRbiDFOmRf0oKjOjCf8JoZIWGtN0aw+
 0B2dHkgS01NSPBubrBYmOsAqA8P5gBZaVpZRXcEb3oYIUscXMNwyd8yy7
 ZZO6QschxWmj2NbVfCLfOceGwN7Fu3PYl6XnjbHOm8b4UiJgGMncHB/46
 WcrZ8OVV0PDUciOwDqY8POCN1lXaPAbEI4awzfiBsjroXqGE9CJKl3wga
 6CFnT8ZUo37kRYmOJO7IDgXz7GEdfz4VX35HEUQ8EJ+/5JjHjA4rc+OU1 w==;
X-CSE-ConnectionGUID: RrT+JhT8SkSu6hI7MeBfxg==
X-CSE-MsgGUID: LvAcjFnNSmW7X2OMvlm59g==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7681737"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="7681737"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Apr 2024 03:05:53 -0700
X-CSE-ConnectionGUID: Lra+MaHMSVO98gFrPc/3Og==
X-CSE-MsgGUID: t93ka3axST2S4TBlLLdhyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; d="scan'208";a="18579623"
Received: from tdx-lm.sh.intel.com ([10.239.53.27])
 by orviesa010.jf.intel.com with ESMTP; 04 Apr 2024 03:05:53 -0700
From: Wei Wang <wei.w.wang@intel.com>
To: peterx@redhat.com,
	lei4.wang@intel.com,
	farosas@suse.de
Cc: qemu-devel@nongnu.org,
	Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH v1] migration/postcopy: ensure preempt channel is ready before
 loading states
Date: Thu,  4 Apr 2024 18:05:50 +0800
Message-Id: <20240404100550.17777-1-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=wei.w.wang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Before loading the guest states, ensure that the preempt channel has been
ready to use, as some of the states (e.g. via virtio_load) might trigger
page faults that will be handled through the preempt channel. So yield to
the main thread in the case that the channel create event has been
dispatched.

Originally-by: Lei Wang <lei4.wang@intel.com>
Link: https://lore.kernel.org/all/9aa5d1be-7801-40dd-83fd-f7e041ced249@intel.com/T/
Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Lei Wang <lei4.wang@intel.com>
Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 migration/savevm.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index 388d7af7cd..fbc9f2bdd4 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2342,6 +2342,23 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
 
     QEMUFile *packf = qemu_file_new_input(QIO_CHANNEL(bioc));
 
+    /*
+     * Before loading the guest states, ensure that the preempt channel has
+     * been ready to use, as some of the states (e.g. via virtio_load) might
+     * trigger page faults that will be handled through the preempt channel.
+     * So yield to the main thread in the case that the channel create event
+     * has been dispatched.
+     */
+    do {
+        if (!migrate_postcopy_preempt() || !qemu_in_coroutine() ||
+            mis->postcopy_qemufile_dst) {
+            break;
+        }
+
+        aio_co_schedule(qemu_get_current_aio_context(), qemu_coroutine_self());
+        qemu_coroutine_yield();
+    } while (!qemu_sem_timedwait(&mis->postcopy_qemufile_dst_done, 1));
+
     ret = qemu_loadvm_state_main(packf, mis);
     trace_loadvm_handle_cmd_packaged_main(ret);
     qemu_fclose(packf);
-- 
2.27.0


