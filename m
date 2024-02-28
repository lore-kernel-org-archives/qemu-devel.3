Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1249BC54E4A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 16:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfMkP-0005dP-IA; Wed, 28 Feb 2024 11:25:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rfMjw-0005Ag-Iq; Wed, 28 Feb 2024 11:25:07 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rfMjp-0000uO-3v; Wed, 28 Feb 2024 11:25:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709137497; x=1740673497;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=F1IuRZawaJ2NHOUI3QO3od9jdb42E1bkkqWXt4qynek=;
 b=Yr2MHjt31e0PPo/mPj1/oZfIRMud2o18iJr2maeTNRLZ9LDQCgyStmO4
 n5XznHl/FiOOC+RLLOdm0BofRPZE+W7ago1eu0pf++61c92KIUH20qBCn
 6K/sA4rYq50WC6R1wNa2jV6NpM7iy6Ea1e3oJLHjUbWQPN2QK4eqfWJTL
 6vEgFE1Tx3AlCzQixj45WPn1sjhQRQGsx8N5aafqj4p6lrresnfK+ny7o
 nAfvhMgGQgyFsw48yITE88b4wzDdP2ARmhbkya8sR6H7et9nXKczQgy80
 Tybitb1grGoiwFdYjKIByuh66LHkAxQiRdr6Rncd1n6nw/dsm7AaS7184 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="28982649"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; d="scan'208";a="28982649"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2024 08:24:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; d="scan'208";a="12145073"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa004.jf.intel.com with ESMTP; 28 Feb 2024 08:24:30 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Paul Burton <paulburton@kernel.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Subject: [PATCH 15/16] hw/core/loader-fit: Fix missing ERRP_GUARD() for
 error_prepend()
Date: Thu, 29 Feb 2024 00:37:22 +0800
Message-Id: <20240228163723.1775791-16-zhao1.liu@linux.intel.com>
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

In hw/core/loader-fit.c, there're 2 functions passing @errp to
error_prepend() without ERRP_GUARD():
 - fit_load_kernel()
 - fit_load_fdt()

Their @errp parameters are both the pointers of the local @err virable
in load_fit().

Though they don't cause the issue like [1] said, to follow the
requirement of @errp, add missing ERRP_GUARD() at their beginning.

[1]: Issue description in the commit message of commit ae7c80a7bd73
     ("error: New macro ERRP_GUARD()").

Cc: Paul Burton <paulburton@kernel.org>
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/core/loader-fit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/core/loader-fit.c b/hw/core/loader-fit.c
index b7c7b3ba94d4..9f20007dbb51 100644
--- a/hw/core/loader-fit.c
+++ b/hw/core/loader-fit.c
@@ -120,6 +120,7 @@ static int fit_load_kernel(const struct fit_loader *ldr, const void *itb,
                            int cfg, void *opaque, hwaddr *pend,
                            Error **errp)
 {
+    ERRP_GUARD();
     const char *name;
     const void *data;
     const void *load_data;
@@ -178,6 +179,7 @@ static int fit_load_fdt(const struct fit_loader *ldr, const void *itb,
                         int cfg, void *opaque, const void *match_data,
                         hwaddr kernel_end, Error **errp)
 {
+    ERRP_GUARD();
     Error *err = NULL;
     const char *name;
     const void *data;
-- 
2.34.1


