Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5699CC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 03:27:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjWIv-00082B-MU; Sun, 10 Mar 2024 23:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjWIs-0007o8-PT; Sun, 10 Mar 2024 23:26:18 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjWIr-0008EJ-08; Sun, 10 Mar 2024 23:26:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710127577; x=1741663577;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IFz0JY+zc2MQkBUXwbMVKVIFtiFvbhCHaahl7QCHiEg=;
 b=Wvohpi1IgbzQEnt43nT0Zk+AXoO/q6arM3jDYXP7WYlTZAtrPWXsDpAW
 BQAz5vOMelP7Ax0geOKXhVTCFs97rEX8q+coxaec0n7pF4Qk/RQiaFMId
 vE+iT/e9zhOD1EGy3Txk30Nj/0/bADwDvo/78pLn19jpAmV2BklmhOxBv
 dx0d8yU0m5iRDhbuqrF+h/ZmZ61GD9HmPvK3XohqVqaoA8lNCt5lKSKiO
 CGorHwhSNVFfx4mSGjzPgj7GIC7p3QJYjwan7jTJOYvZWFgY9SYFfclpc
 SnTExDODQx9mVZ5uKuSkHTQDyJoioupY3WH+5Vea+XPpT6vMCi9JHb4Uk A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="22229761"
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; d="scan'208";a="22229761"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2024 20:25:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; d="scan'208";a="15594019"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 10 Mar 2024 20:25:41 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 20/29] hw/vfio/helpers: Fix missing ERRP_GUARD() for
 error_prepend()
Date: Mon, 11 Mar 2024 11:38:13 +0800
Message-Id: <20240311033822.3142585-21-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311033822.3142585-1-zhao1.liu@linux.intel.com>
References: <20240311033822.3142585-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

In hw/vfio/helpers.c, there are 3 functions passing @errp to
error_prepend() without ERRP_GUARD():
 - vfio_set_irq_signaling()
 - vfio_device_get_name()
 - vfio_device_set_fd()

There are too many possible callers to check the impact of this defect;
it may or may not be harmless. Thus it is necessary to protect their
@errp with ERRP_GUARD().

To avoid the issue like [1] said, add missing ERRP_GUARD() at their
beginning.

[1]: Issue description in the commit message of commit ae7c80a7bd73
     ("error: New macro ERRP_GUARD()").

Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: "Cédric Le Goater" <clg@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
v2: Use Markus' sentence to polish commit message. (Markus)
---
 hw/vfio/helpers.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index 678987080228..47b4096c05ee 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -110,6 +110,7 @@ static const char *index_to_str(VFIODevice *vbasedev, int index)
 int vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
                            int action, int fd, Error **errp)
 {
+    ERRP_GUARD();
     struct vfio_irq_set *irq_set;
     int argsz, ret = 0;
     const char *name;
@@ -613,6 +614,7 @@ bool vfio_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type)
 
 int vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
 {
+    ERRP_GUARD();
     struct stat st;
 
     if (vbasedev->fd < 0) {
@@ -644,6 +646,7 @@ int vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
 
 void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp)
 {
+    ERRP_GUARD();
     int fd = monitor_fd_param(monitor_cur(), str, errp);
 
     if (fd < 0) {
-- 
2.34.1


