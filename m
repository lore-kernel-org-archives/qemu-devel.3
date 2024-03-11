Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 773FAC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 03:29:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjWI5-0005jR-PM; Sun, 10 Mar 2024 23:25:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjWI0-0005g4-Sw; Sun, 10 Mar 2024 23:25:24 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjWHz-0007rZ-B3; Sun, 10 Mar 2024 23:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710127523; x=1741663523;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ixEs9dOFZnglqkPxeEdB/M9zEvYnvOWu4quv6IO1YXs=;
 b=YEyIpfvg1T1NDbRxM/IiMXoMXmyvv5LOs7hNgmBUx5ErrnmTL4EKq9PQ
 BXchLRmIWWtXGd3G2WxoEyncpmWwjIbuwhVxhmEiMWUvoJzHTW3+F2a+N
 NaMYDvhiP5WFEdXgppjeh2phxuKd7tR3OnJymKIZUHI9O+Dt5f75lY1fD
 vysa5zRUJL6hCgfLyujUnyLeeGwn8thp5MqwfxNeUOHE+ofRtGQ/prFZC
 ZZC/Sfqau5IzOuwYpzHyukrsgWb01nCxjWfYacftvxyEFe4tkTw0WtJKf
 M99U/h8GPvpHBW/O/xaArswcIPvLJKJuqDS7SrWNKWUCxtVuaNh1RUXjX g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="22229667"
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; d="scan'208";a="22229667"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2024 20:25:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; d="scan'208";a="15593830"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 10 Mar 2024 20:25:17 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Subject: [PATCH v2 12/29] block/vmdk: Fix missing ERRP_GUARD() for
 error_prepend()
Date: Mon, 11 Mar 2024 11:38:05 +0800
Message-Id: <20240311033822.3142585-13-zhao1.liu@linux.intel.com>
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

The vmdk_parse_extents() passes @errp to error_prepend(), and its @errp
is from vmdk_open().

Though, vmdk_open(), as a BlockDriver.bdrv_open(), gets the @errp
parameter which is pointer of its caller's local_err, to follow the
requirement of @errp, add missing ERRP_GUARD() at the beginning of this
function.

[1]: Issue description in the commit message of commit ae7c80a7bd73
     ("error: New macro ERRP_GUARD()").

Cc: Fam Zheng <fam@euphon.net>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Hanna Reitz <hreitz@redhat.com>
Cc: qemu-block@nongnu.org
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 block/vmdk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/vmdk.c b/block/vmdk.c
index bf78e1238351..3b82979fdf42 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1147,6 +1147,7 @@ static int GRAPH_RDLOCK
 vmdk_parse_extents(const char *desc, BlockDriverState *bs, QDict *options,
                    Error **errp)
 {
+    ERRP_GUARD();
     int ret;
     int matches;
     char access[11];
-- 
2.34.1


