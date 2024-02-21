Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A908FC48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:38:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoco-0007B1-71; Wed, 21 Feb 2024 10:35:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rcoa2-0005LV-SN; Wed, 21 Feb 2024 10:32:19 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rcivf-0003QN-Kc; Wed, 21 Feb 2024 04:30:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708507816; x=1740043816;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZoOw7oZSsgWoryzBsNZfJlqiBLjXl5nzRum0ygARlNs=;
 b=fucxyC/kNOGG6zBZBp6QY7JL4y4k6Nc2z3CbbORIU6cMAiXjUsHnVk/c
 zusNW4sNfRmI7Mvi2QC14UziiPoxjAJL7o7krHuALJZ2wXBcSWJhzkJ3z
 OH5/3oWGQzGa8iE76rWradcmutHC0S6VkF4sO1qxbA9KHEqs2051u28/Z
 OBvfPDPpFbSZQrAA26QDckXXdFyDV/FqnpISc89zUU7aUukyjiS2nR/IC
 BVNnc3Is3tDXbT1fdQgUnAOTo+tFoguZ7yW/IAKczFOuxi+6kr8srJ4m0
 kOm80KH9sgQ7P3vQ6s2k4+vaeNLsbiCs9I0dVRC2utwUYvu5mJerGcOv3 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2795509"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="2795509"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Feb 2024 01:30:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="9720217"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa003.jf.intel.com with ESMTP; 21 Feb 2024 01:30:06 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, Laurent Vivier <laurent@vivier.eu>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-trivial@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 6/6] hw/vfio/iommufd: Fix missing ERRP_GUARD() in
 iommufd_cdev_getfd()
Date: Wed, 21 Feb 2024 17:43:17 +0800
Message-Id: <20240221094317.994454-7-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240221094317.994454-1-zhao1.liu@linux.intel.com>
References: <20240221094317.994454-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.15;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
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

As the comment in qapi/error, dereferencing @errp requires
ERRP_GUARD():

* = Why, when and how to use ERRP_GUARD() =
*
* Without ERRP_GUARD(), use of the @errp parameter is restricted:
* - It must not be dereferenced, because it may be null.
* - It should not be passed to error_prepend() or
*   error_append_hint(), because that doesn't work with &error_fatal.
* ERRP_GUARD() lifts these restrictions.
*
* To use ERRP_GUARD(), add it right at the beginning of the function.
* @errp can then be used without worrying about the argument being
* NULL or &error_fatal.
*
* Using it when it's not needed is safe, but please avoid cluttering
* the source with useless code.

Currently, since vfio_attach_device() - the caller of
iommufd_cdev_getfd() - is always called in DeviceClass.realize() context
and won't get the NULL errp parameter, iommufd_cdev_getfd()
doesn't trigger the dereference issue.

To follow the requirement of errp, add missing ERRP_GUARD() in
iommufd_cdev_getfd().

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Suggested by credit:
 Markus: Referred his explanation about ERRP_GUARD().
---
 hw/vfio/iommufd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 9bfddc136089..7baf49e6ee9e 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -116,6 +116,7 @@ static void iommufd_cdev_unbind_and_disconnect(VFIODevice *vbasedev)
 
 static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
 {
+    ERRP_GUARD();
     long int ret = -ENOTTY;
     char *path, *vfio_dev_path = NULL, *vfio_path = NULL;
     DIR *dir = NULL;
-- 
2.34.1


