Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 635CAC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 16:27:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfMjI-0004CT-Tc; Wed, 28 Feb 2024 11:24:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rfMjH-00046G-AQ; Wed, 28 Feb 2024 11:24:23 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rfMj2-0000pm-Oq; Wed, 28 Feb 2024 11:24:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709137449; x=1740673449;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nxRQf/+tArZDzcPHPsrl+p0ECgQSKCEQqDH1Za5Mhjg=;
 b=K+25loYKHaed5kwLQKiE3hXX0RQEjDPb/ajDzxS3bNmPr7uzFrsNiTU7
 aPgAukCE9+wNTkgj5R3hHuQp5m7fVTFeatk6sb/u8ovEx9FxBpNfGJnVz
 M516RIMm02GnqMhTSP0rdu28ss3I1xX8iZ3rCdviLLShF1l0c5K+0XTiz
 NArwfcFrImDhMONihh5eVMi33WwECEy8uw0TwU2ClznQbIOQZ3D8Ayy5e
 ojWv8/cQAEGIz8Vrx9wADW/wdyV8Hece1IS7WeOF+V/QOjsV3yat7Vtwl
 NQL089jcOmw1lrJ0bHzzZE7Ey2py7g8LoMX0ttcphcpk+ckon4fa5uoTM Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="28982478"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; d="scan'208";a="28982478"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2024 08:24:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; d="scan'208";a="12144933"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa004.jf.intel.com with ESMTP; 28 Feb 2024 08:24:03 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 06/16] block/nvme: Fix missing ERRP_GUARD() for error_prepend()
Date: Thu, 29 Feb 2024 00:37:13 +0800
Message-Id: <20240228163723.1775791-7-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228163723.1775791-1-zhao1.liu@linux.intel.com>
References: <20240228163723.1775791-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.7;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

As the comment in qapi/error, passing @errp to error_prepend() requires
ERRP_GUARD():

* = Why, when and how to use ERRP_GUARD() =
*
* Without ERRP_GUARD(), use of the @errp parameter is restricted:
...
* - It should not be passed to error_prepend(), error_vprepend() or
*   error_append_hint(), because that doesn't work with &error_fatal.
* ERRP_GUARD() lifts these restrictions.
*
* To use ERRP_GUARD(), add it right at the beginning of the function.
* @errp can then be used without worrying about the argument being
* NULL or &error_fatal.

ERRP_GUARD() could avoid the case when @errp is the pointer of
error_fatal, the user can't see this additional information, because
exit() happens in error_setg earlier than information is added [1].

In nvme.c, there're 3 functions passing @errp to error_prepend()
without ERRP_GUARD():
- nvme_init_queue()
- nvme_create_queue_pair()
- nvme_identify()

All these 3 functions take their @errp parameters from the
nvme_file_open(), which is a BlockDriver.bdrv_nvme() method and its
@errp points to its caller's local_err.

Though these 3 cases haven't trigger the issue like [1] said, to
follow the requirement of @errp, add missing ERRP_GUARD() at their
beginning.

[1]: Issue description in the commit message of commit ae7c80a7bd73
     ("error: New macro ERRP_GUARD()").

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Fam Zheng <fam@euphon.net>
Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Hanna Reitz <hreitz@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 block/nvme.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/nvme.c b/block/nvme.c
index 0a0a0a6b36cd..3a3c6da73d29 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -168,6 +168,7 @@ static QemuOptsList runtime_opts = {
 static bool nvme_init_queue(BDRVNVMeState *s, NVMeQueue *q,
                             unsigned nentries, size_t entry_bytes, Error **errp)
 {
+    ERRP_GUARD();
     size_t bytes;
     int r;
 
@@ -221,6 +222,7 @@ static NVMeQueuePair *nvme_create_queue_pair(BDRVNVMeState *s,
                                              unsigned idx, size_t size,
                                              Error **errp)
 {
+    ERRP_GUARD();
     int i, r;
     NVMeQueuePair *q;
     uint64_t prp_list_iova;
@@ -535,6 +537,7 @@ static int nvme_admin_cmd_sync(BlockDriverState *bs, NvmeCmd *cmd)
 /* Returns true on success, false on failure. */
 static bool nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
 {
+    ERRP_GUARD();
     BDRVNVMeState *s = bs->opaque;
     bool ret = false;
     QEMU_AUTO_VFREE union {
-- 
2.34.1


