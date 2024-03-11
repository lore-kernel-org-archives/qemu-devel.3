Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B13C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 03:28:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjWHW-0005ZC-VV; Sun, 10 Mar 2024 23:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjWHV-0005Yo-TL; Sun, 10 Mar 2024 23:24:53 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjWHU-0007rZ-7b; Sun, 10 Mar 2024 23:24:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710127492; x=1741663492;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Df8TZAiYBeLcQdJvojI1ZKKv4azS1j0SO2PFl2TxogE=;
 b=K6bM2Kz7eZsM83IaZTznFuzrnP6Mef06H7QopGDVja4iZ9ByPivy0/zA
 oTp3Qo8PHsp/IOLlvCF5zFeKKGRDd1yfuweB3eQA/bOgmp29JmqwI/lke
 6aIsnRZle6pncrPKuA0txUgy5ZbIz0vlhBRL6IynpjXLrxhHxfaMjRpsE
 vYKZaOXSrOp/uk6rSSH6kSZ9nw5RxlPU3QucGREXrd+gURUCxysSiDUwT
 dU4AqPewHpS7MkAl2IrSxhg57G5resg2UBV4GUzK32A9cwIiL1GbSAFKh
 FvNZ7IJDfrASaHyQq/A4gCRbsgR9zWp03M1sJIeSkyCWnG4lcTrx7ZGzn A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="22229589"
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; d="scan'208";a="22229589"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2024 20:24:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; d="scan'208";a="15593723"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 10 Mar 2024 20:24:47 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>
Subject: [PATCH v2 03/29] block: Fix missing ERRP_GUARD() for error_prepend()
Date: Mon, 11 Mar 2024 11:37:56 +0800
Message-Id: <20240311033822.3142585-4-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311033822.3142585-1-zhao1.liu@linux.intel.com>
References: <20240311033822.3142585-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.10;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.945,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

ERRP_GUARD() could avoid the case when @errp is &error_fatal, the user
can't see this additional information, because exit() happens in
error_setg earlier than information is added [1].

In block.c, there are 4 functions passing @errp to error_prepend()
without ERRP_GUARD():
 - bdrv_co_create_opts_simple()
 - parse_json_filename()
 - bdrv_open_backing_file()
 - bdrv_append_temp_snapshot()

bdrv_co_create_opts_simple(), is an implementation of
BlockDriver.bdrv_co_create_opts(). There are too many possible callers
to check the impact of this defect; it may or may not be harmless. Thus
it is necessary to protect @errp with ERRP_GUARD().

Though the @errp parameters passed to parse_json_filename(),
bdrv_open_backing_file() and bdrv_append_temp_snapshot() points to their
callers' local_err, to follow the requirement of @errp, also add missing
ERRP_GUARD() at their beginning.

[1]: Issue description in the commit message of commit ae7c80a7bd73
     ("error: New macro ERRP_GUARD()").

Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Hanna Reitz <hreitz@redhat.com>
Cc: qemu-block@nongnu.org
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
v2:
 * Use Markus' sentence to polish commit message. (Markus)
 * Fix typo. (Eric)
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


