Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 342DAC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 16:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfMjN-0004Q4-5F; Wed, 28 Feb 2024 11:24:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rfMjL-0004OJ-KW; Wed, 28 Feb 2024 11:24:27 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rfMjK-0000sx-1T; Wed, 28 Feb 2024 11:24:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709137466; x=1740673466;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=se7iaBg2YM4bDU1t5iF+ZzwdJjnzwm4fgLQ2Wyzhwuw=;
 b=fLlY9V60XoY97Z0P/0LFl5zrFdms/IFU7sIsHh9Dztd/59Xgp99N4sfZ
 rU6xtecXRoH5AyUm9TR31lgel3ySDuiMp5qjYobr/2sgnaXydIuAYaZGQ
 3CnQ2EPnRRxH1/P4ro+YMWpdGDpqg3MmvsfKKMGycNm2WdiM7+DIyaG6z
 JgAblhc59fImAIZ2I4pKvSP3LrwqqGbYDietLhEUiablyFuT2usikrSTz
 Qfi/VPylQJB9UvmLDPF8sOlXzT0j4EZ3hndj7nnIpex8XdS6ExjuXF2fn
 CWT0M4UiU3aC1QMVE0QxpI3iKFmy+r21te8kmhvkSDZAoKtTQURQXL6/F g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="28982562"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; d="scan'208";a="28982562"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2024 08:24:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; d="scan'208";a="12145008"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa004.jf.intel.com with ESMTP; 28 Feb 2024 08:24:17 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Stefan Weil <sw@weilnetz.de>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 11/16] block/vdi: Fix missing ERRP_GUARD() for error_prepend()
Date: Thu, 29 Feb 2024 00:37:18 +0800
Message-Id: <20240228163723.1775791-12-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228163723.1775791-1-zhao1.liu@linux.intel.com>
References: <20240228163723.1775791-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.7;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The vdi_co_do_create() passes @errp to error_prepend() without
ERRP_GUARD(), and its @errp parameter is so widely sourced that it is
necessary to protect it with ERRP_GUARD().

To avoid the potential issues as [1] said, add missing ERRP_GUARD() at
the beginning of this function.

[1]: Issue description in the commit message of commit ae7c80a7bd73
     ("error: New macro ERRP_GUARD()").

Cc: Stefan Weil <sw@weilnetz.de>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Hanna Reitz <hreitz@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 block/vdi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/vdi.c b/block/vdi.c
index 3b57becb9fe0..6363da08cee9 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -738,6 +738,7 @@ static int coroutine_fn GRAPH_UNLOCKED
 vdi_co_do_create(BlockdevCreateOptions *create_options, size_t block_size,
                  Error **errp)
 {
+    ERRP_GUARD();
     BlockdevCreateOptionsVdi *vdi_opts;
     int ret = 0;
     uint64_t bytes = 0;
-- 
2.34.1


