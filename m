Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42AE1C53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 14:50:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp5aK-0004Uy-Kw; Wed, 29 Jul 2026 10:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wp5Zf-0004GW-AK; Wed, 29 Jul 2026 10:48:03 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wp5Zb-0000Pj-7M; Wed, 29 Jul 2026 10:47:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785336475; x=1816872475;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vbh6j/yVXhjUgJsuEkmBoPmh0Q2oLphjP1TzurM+BmM=;
 b=FkqVOPOJuuZsRtqkTm5M0rNQK6gMbDGNTV7Tl9Pu4JaZi+P3B7COlfez
 vwoX1yN9uSj+tduUUbk1R9sTBuc1KidvNW/IxbQETsdNifcwFSiyJuvkV
 b5VcHbDfbBcBQmRwYiWpN/1hZH6ozudMxWB8nq2vqScGfA4Jfcg5WsxqG
 +DwFqxkFc6x9AaEfKKn1NMrTEjuHJjz7gLnwa+2waKapYlXrf9nSdnEES
 Q8h1fKAv1FAo0Z7FQIA06vYGXDhgYDQqur6Kt4UvORO4TpEz3w43vScJX
 HXBe/DtXsJiYW86OA6wZH+c71iH87+fxDB2OZZiLd6o5E/Jc1wG6d/VG1 g==;
X-CSE-ConnectionGUID: I4eLWUTcS/mibUi1kU5W3A==
X-CSE-MsgGUID: gf2ln6PYSMyk96SeKfcsrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="86133634"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; d="scan'208";a="86133634"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2026 07:47:54 -0700
X-CSE-ConnectionGUID: d0yMF8R2RsqTRxp/mGLOKw==
X-CSE-MsgGUID: t6i3EbevR36Zs68m4BAXkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; d="scan'208";a="258788811"
Received: from junjie-desk-dev.bj.intel.com (HELO
 junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2026 07:47:52 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: jic23@kernel.org, linux-cxl@vger.kernel.org, philmd@oss.qualcomm.com,
 qemu-stable@nongnu.org
Subject: [PATCH v3 5/7] hw/cxl: discard in-flight sanitize state on mailbox
 teardown
Date: Wed, 29 Jul 2026 22:46:43 +0800
Message-ID: <20260729144645.1552511-6-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729144645.1552511-1-junjie.cao@intel.com>
References: <20260729144645.1552511-1-junjie.cao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Per CXL r4.0 Section 8.2.9.4, "Background commands do not continue to
execute across Conventional Resets."  If a Media Operations sanitize is
in progress when the device is reset, the background timer is cancelled
and freed via cxl_destroy_cci(), but the per-operation state
(media_op_sanitize) is heap-allocated separately and would be leaked.

Free it from cxl_destroy_mailbox_t3(): the timer that advances the
operation lives in the CCI torn down there, so the operation can never
complete once the mailbox is gone; preserving the heap state has no
benefit and would leak it the next time media_op_sanitize is assigned.
Routing the discard through the mailbox teardown also covers device
unrealize, where ct3_exit() previously leaked an in-flight sanitize.

The completion path in __do_sanitize() frees the same state; factor the
free into a cxl_discard_media_op_sanitize() helper used by both places,
so the whole media_op_sanitize lifecycle now stays within
cxl-mailbox-utils.c.

Note that Section 8.2.10.9.5.1 additionally requires a device whose
Sanitize was interrupted by reset to remain in the Media Disabled state
until a successful Sanitize completes.  That latch is not modelled here
(reset re-enables media via memdev_reg_init_common()) and is left for
future work; this patch only addresses the resource leak.

Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 hw/cxl/cxl-mailbox-utils.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index bc00fec9f8..cbd6ebf9fe 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2636,6 +2636,12 @@ static int sanitize_range(CXLType3Dev *ct3d, uint64_t dpa_addr, size_t length,
     return address_space_set(as, dpa_addr, fill_value, length, mem_attrs);
 }
 
+static void cxl_discard_media_op_sanitize(CXLType3Dev *ct3d)
+{
+    g_free(ct3d->media_op_sanitize);
+    ct3d->media_op_sanitize = NULL;
+}
+
 /* Perform the actual device zeroing */
 static void __do_sanitize(CXLType3Dev *ct3d)
 {
@@ -2653,8 +2659,7 @@ static void __do_sanitize(CXLType3Dev *ct3d)
         }
     }
 exit:
-    g_free(ct3d->media_op_sanitize);
-    ct3d->media_op_sanitize = NULL;
+    cxl_discard_media_op_sanitize(ct3d);
     return;
 }
 
@@ -4848,6 +4853,12 @@ void cxl_destroy_mailbox_t3(CXLType3Dev *ct3d)
     if (ct3d->cci.initialized) {
         cxl_destroy_cci(&ct3d->cci);
     }
+    /*
+     * An in-flight Media Operations sanitize is only advanced by this CCI's
+     * background timer; with the CCI gone the operation can never complete,
+     * so its state would otherwise be leaked (CXL r4.0 Section 8.2.9.4).
+     */
+    cxl_discard_media_op_sanitize(ct3d);
 }
 
 static const struct cxl_cmd cxl_cmd_set_t3_ld[256][256] = {
-- 
2.43.0


