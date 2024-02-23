Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17983C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 08:45:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdRA8-0003pM-CV; Fri, 23 Feb 2024 03:44:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rdRA0-0003la-KT; Fri, 23 Feb 2024 03:44:02 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rdR9x-0000Bk-Of; Fri, 23 Feb 2024 03:43:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708677838; x=1740213838;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6V97dsmp4JAIBUgFfbzez7o/O5Yd5Mg3yF5DrdVp9Q8=;
 b=LYrd125rsjKyo0dRsUoemLhJvyaK3IWVEPDBc2rHoGT41XIGRwguXNGk
 Taw62Er00YbS6vD9IjBJkScFRxptQS2lyZPjq0V8mVEi9gX9fRsT9Kn/J
 O2XVmx4CaULHmjncOxu2g8MlFDP1leLcloei0xe5PNpf0ZCKzCVjJha6I
 +3puC3k2ls1oRCMqBgqaRn9150dAh2BfgXwP9WlAi3sv85WkMS4pV6//8
 fLtQEYkyyZya/yPSWrrI6JAUJ8a0SMnmpHuJr4N918ysvwqmWeNQRrwQy
 CFht5ncR+2bQNw1n65xlJjhCxt05gcbeNeeq2MASiG68HWcnEYNfzNabn A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="28413893"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; d="scan'208";a="28413893"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Feb 2024 00:43:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5731867"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 23 Feb 2024 00:43:44 -0800
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
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-trivial@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 6/7] hw/vfio/iommufd: Fix missing ERRP_GUARD() in
 iommufd_cdev_getfd()
Date: Fri, 23 Feb 2024 16:56:52 +0800
Message-Id: <20240223085653.1255438-7-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223085653.1255438-1-zhao1.liu@linux.intel.com>
References: <20240223085653.1255438-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.7;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.002,
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
...
* ERRP_GUARD() lifts these restrictions.
*
* To use ERRP_GUARD(), add it right at the beginning of the function.
* @errp can then be used without worrying about the argument being
* NULL or &error_fatal.
*
* Using it when it's not needed is safe, but please avoid cluttering
* the source with useless code.

But in iommufd_cdev_getfd(), @errp is dereferenced without ERRP_GUARD():

if (*errp) {
    error_prepend(errp, VFIO_MSG_PREFIX, path);
}

Currently, since vfio_attach_device() - the caller of
iommufd_cdev_getfd() - is always called in DeviceClass.realize() context
and doesn't get the NULL @errp parameter, iommufd_cdev_getfd()
hasn't triggered the bug that dereferencing the NULL @errp.

To follow the requirement of @errp, add missing ERRP_GUARD() in
iommufd_cdev_getfd().

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
Suggested by credit:
 Markus: Referred his explanation about ERRP_GUARD().
---
v2:
 * Add the @errp dereference code in commit message to make review
   easier. (Markus)
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


