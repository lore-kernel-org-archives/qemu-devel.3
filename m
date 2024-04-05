Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A18ACD1292
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 03:41:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsaRy-0004Il-M6; Thu, 04 Apr 2024 23:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1rsaRw-0004IQ-SG
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 23:41:08 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1rsaRt-0006qR-3C
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 23:41:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712288465; x=1743824465;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=bNLmOuVKMamvgqvlsglFuX7TC5Vq/hPotWq9my/FRI4=;
 b=aGEQQl9TJ5qM2PUoArD8P84kZ46nMHlozPzql57dFCKYKf0ESldY4Uku
 5P5ikzO3nNM1R2JFXpGAPO7ca971yfoUoy5vlUa96/G6KtqFkmy62wnSo
 XC3gNuH9ELeyzC/4TDqhdmPFGyhTjFoisjd16+at/VQf9Trk9DLJabNaY
 LkVQzI06j5jUsmSCLWoLUc87V+EVEQe+cMtY1RiNzdhVJY9pr/NAbRvOB
 WnH8p5o3cvNFSZiCyGhh0/R/IdEvixUiOZtQdAmjh3yOgO3om7o6d47Uz
 K5yHxVuBbSfqgW3epJnbA/mAmYCR0vPX/+BScQUwiTE/AKbDAAU7VIL9L Q==;
X-CSE-ConnectionGUID: ajia8E3mSrCQJPjt80bgzw==
X-CSE-MsgGUID: QNKU4XouQomx4hpn8SDqpA==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="18215006"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; d="scan'208";a="18215006"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Apr 2024 20:41:01 -0700
X-CSE-ConnectionGUID: /djk+Q75Ry61Gc0WGCbGQQ==
X-CSE-MsgGUID: iNYBkm2jTLSZvz1WVL3gdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; d="scan'208";a="23704774"
Received: from tdx-lm.sh.intel.com ([10.239.53.27])
 by orviesa005.jf.intel.com with ESMTP; 04 Apr 2024 20:40:59 -0700
From: Wei Wang <wei.w.wang@intel.com>
To: peterx@redhat.com,
	lei4.wang@intel.com,
	farosas@suse.de
Cc: qemu-devel@nongnu.org,
	Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH v2] migration/postcopy: ensure preempt channel is ready before
 loading states
Date: Fri,  5 Apr 2024 11:40:56 +0800
Message-Id: <20240405034056.23933-1-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.11; envelope-from=wei.w.wang@intel.com;
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
the main thread in the case that the channel create event hasn't been
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
index 388d7af7cd..63f9991a8a 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2342,6 +2342,23 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
 
     QEMUFile *packf = qemu_file_new_input(QIO_CHANNEL(bioc));
 
+    /*
+     * Before loading the guest states, ensure that the preempt channel has
+     * been ready to use, as some of the states (e.g. via virtio_load) might
+     * trigger page faults that will be handled through the preempt channel.
+     * So yield to the main thread in the case that the channel create event
+     * hasn't been dispatched.
+     */
+    do {
+        if (!migrate_postcopy_preempt() || !qemu_in_coroutine() ||
+            mis->postcopy_qemufile_dst) {
+            break;
+        }
+
+        aio_co_schedule(qemu_get_current_aio_context(), qemu_coroutine_self());
+        qemu_coroutine_yield();
+    } while (1);
+
     ret = qemu_loadvm_state_main(packf, mis);
     trace_loadvm_handle_cmd_packaged_main(ret);
     qemu_fclose(packf);
-- 
2.27.0


