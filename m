Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD69C5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 16:28:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfMix-0003z9-VQ; Wed, 28 Feb 2024 11:24:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rfMiw-0003vn-Bp; Wed, 28 Feb 2024 11:24:02 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rfMit-0000mI-Lx; Wed, 28 Feb 2024 11:24:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709137440; x=1740673440;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ScaB6SaBv2CqP5Ws6GB8REcTl3j7b3N6RkLZjBdmWdE=;
 b=YHkbNc6Mv46zUPX778EhHpHS/7HUkaFTgNlMOoFyxYdcytoZV+Ft9kmq
 /jh8L7FqqP6iJctpSA4RGBKWpygZZP+2NGocrAmfTfjrRmS6/PTX3UYv4
 GPtkgJFRGWICqJbcJ+RUHJ5x05pnp3CglVYZEOm5BhfrvxAr9O1Vz021W
 pUBtrh3fgA1Wn7K9z0RtYAKcXCdFyes1NbvKuOYCxfpYvlfOqW5Bs1XQx
 8HBIjDXuk//cWBRWzCbjYmBZljaq6fOA54Rvlu+AC0PuhjmL6QrMHVt9u
 oAcTYpXgDAYpcu9QDFun1FqBVHIf9n+SUBWee3kEjDAjB8pGy6bY/zLR7 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="28982439"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; d="scan'208";a="28982439"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2024 08:23:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; d="scan'208";a="12144863"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa004.jf.intel.com with ESMTP; 28 Feb 2024 08:23:53 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 03/16] block: Fix missing ERRP_GUARD() for error_prepend()
Date: Thu, 29 Feb 2024 00:37:10 +0800
Message-Id: <20240228163723.1775791-4-zhao1.liu@linux.intel.com>
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

In block.c, there're 4 functions passing @errp to error_prepend()
without ERRP_GUARD():
 - bdrv_co_create_opts_simple()
 - parse_json_filename()
 - bdrv_open_backing_file()
 - bdrv_append_temp_snapshot()

bdrv_co_create_opts_simple(), as an implementation of
BolckDriver.bdrv_co_create_opts(), its @errp parameter is so widely
sourced that it is necessary to protect it with ERRP_GUARD().

Though the @errp parameters passed to parse_json_filename(),
bdrv_open_backing_file() and bdrv_append_temp_snapshot() points to their
callers' local_err, to follow the requirement of @errp, also add missing
ERRP_GUARD() at their beginning.

[1]: Issue description in the commit message of commit ae7c80a7bd73
     ("error: New macro ERRP_GUARD()").

Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Hanna Reitz <hreitz@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 block.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block.c b/block.c
index 1ed9214f66ed..cf66c767a011 100644
--- a/block.c
+++ b/block.c
@@ -633,6 +633,7 @@ int coroutine_fn bdrv_co_create_opts_simple(BlockDriver *drv,
                                             QemuOpts *opts,
                                             Error **errp)
 {
+    ERRP_GUARD();
     BlockBackend *blk;
     QDict *options;
     int64_t size = 0;
@@ -1998,6 +1999,7 @@ fail_opts:
 
 static QDict *parse_json_filename(const char *filename, Error **errp)
 {
+    ERRP_GUARD();
     QObject *options_obj;
     QDict *options;
     int ret;
@@ -3585,6 +3587,7 @@ int bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
 int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
                            const char *bdref_key, Error **errp)
 {
+    ERRP_GUARD();
     char *backing_filename = NULL;
     char *bdref_key_dot;
     const char *reference = NULL;
@@ -3851,6 +3854,7 @@ static BlockDriverState *bdrv_append_temp_snapshot(BlockDriverState *bs,
                                                    QDict *snapshot_options,
                                                    Error **errp)
 {
+    ERRP_GUARD();
     g_autofree char *tmp_filename = NULL;
     int64_t total_size;
     QemuOpts *opts = NULL;
-- 
2.34.1


