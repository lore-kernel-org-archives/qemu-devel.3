Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B58CEC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 16:28:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfMit-0003sZ-HE; Wed, 28 Feb 2024 11:23:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rfMis-0003rX-6J; Wed, 28 Feb 2024 11:23:58 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rfMiq-0000mI-Bz; Wed, 28 Feb 2024 11:23:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709137436; x=1740673436;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=k9iYhMvDZgDUYC+uUV1HBSQug6hcI5PYy6xahfkmyYw=;
 b=TEZuipusTDaIAsRMvb8LvO5T/LULaQSI/ohB00wYt40YTlBxK7mCSTrp
 +YBr2wNx6WQ8IHbTXc7ds7zHTH9ABTE4uXG97g8JnlIUM7E5XnudQ1Rot
 1jxZ2PZwPWaz7ZU1jnI3dRKwuuRfmVnki6Kl7cuLR03kDnmSWysmrG8q8
 DZGfJQH+rOeQhEeX43rsJhtGWnomvUDiLW7DjoYFnyaNkMy5BNkCxQF5b
 r273mE7E8nXOPEMEoFC1gpm28yjbizYXXBflstTzk2zQ0j9UUMFB+d9VM
 uJNgBvNL/lrS38iJvZOKQBm68YaYkN820dqPLPdDnNNQDcKt0tnm3gDRa w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="28982423"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; d="scan'208";a="28982423"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2024 08:23:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; d="scan'208";a="12144821"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa004.jf.intel.com with ESMTP; 28 Feb 2024 08:23:50 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 02/16] backends/iommufd: Fix missing ERRP_GUARD() for
 error_prepend()
Date: Thu, 29 Feb 2024 00:37:09 +0800
Message-Id: <20240228163723.1775791-3-zhao1.liu@linux.intel.com>
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

The iommufd_backend_set_fd() passes @errp to error_prepend(), to avoid
the above issue, add missing ERRP_GUARD() at the beginning of this
function.

[1]: Issue description in the commit message of commit ae7c80a7bd73
     ("error: New macro ERRP_GUARD()").

Cc: Yi Liu <yi.l.liu@intel.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 backends/iommufd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index 1ef683c7b080..62a79fa6b049 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -43,6 +43,7 @@ static void iommufd_backend_finalize(Object *obj)
 
 static void iommufd_backend_set_fd(Object *obj, const char *str, Error **errp)
 {
+    ERRP_GUARD();
     IOMMUFDBackend *be = IOMMUFD_BACKEND(obj);
     int fd = -1;
 
-- 
2.34.1


