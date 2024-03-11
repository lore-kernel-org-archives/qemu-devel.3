Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68A3C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 03:29:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjWJN-0002Vw-T3; Sun, 10 Mar 2024 23:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjWJM-0002Kd-M9; Sun, 10 Mar 2024 23:26:48 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjWJK-00084P-Td; Sun, 10 Mar 2024 23:26:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710127607; x=1741663607;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ptTuy2ckiHWNEI7SVUGTBp2K5fyc5nf3WiWP/pqmio0=;
 b=KPQnVflc96/GzjCWQURLWNKGvP+GJQc2f2subItWCeJ2Ise0x5CEGWdr
 Vk3iIWlcaU9usqUXeKqRjC17nLwoaEO0Ym6HSQNpKWbQVVmcN+DacN4ed
 OBMcJ/m1eC0y8b2fGVPz4lUJ9MkRKLSmyvHBkyB6uT89q/d+FlqAJVxMl
 1vUj3vZJMMtcerfVJHxA6o4tQYB+4UGCsORjMl8xT8PDvcvQq7VgvAQdh
 5TunE73e7pVhimBgrlXPCz7fVSSvM/v1r49NziddDVePRtznKf3BDzDxV
 UyS/2v7vnSi85xNNcVtzJ+vDIwEfK1lRfNB9TR0QjH02hE7vehwvgUdiG g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="22229850"
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; d="scan'208";a="22229850"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2024 20:26:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; d="scan'208";a="15594090"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 10 Mar 2024 20:26:00 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 27/29] migration/option: Fix missing ERRP_GUARD() for
 error_prepend()
Date: Mon, 11 Mar 2024 11:38:20 +0800
Message-Id: <20240311033822.3142585-28-zhao1.liu@linux.intel.com>
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

The migrate_params_check() passes @errp to error_prepend() without
ERRP_GUARD(), and it could be called from migration_object_init(),
where the passed @errp points to @error_fatal.

Therefore, the error message echoed in error_prepend() will be lost
because of the above issue.

To fix this, add missing ERRP_GUARD() at the beginning of this function.

[1]: Issue description in the commit message of commit ae7c80a7bd73
     ("error: New macro ERRP_GUARD()").

Cc: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Acked-by: Peter Xu <peterx@redhat.com>
---
 migration/options.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/migration/options.c b/migration/options.c
index 40eb9309401c..caff0a271dff 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1085,6 +1085,8 @@ void migrate_params_init(MigrationParameters *params)
  */
 bool migrate_params_check(MigrationParameters *params, Error **errp)
 {
+    ERRP_GUARD();
+
     if (params->has_compress_level &&
         (params->compress_level > 9)) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "compress_level",
-- 
2.34.1


