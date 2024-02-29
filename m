Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F1CDC54E41
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 14:29:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfhMM-0006SR-EK; Thu, 29 Feb 2024 09:26:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rfhMC-00069f-Q9; Thu, 29 Feb 2024 09:25:57 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rfhMB-0005Zy-4C; Thu, 29 Feb 2024 09:25:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709216755; x=1740752755;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tQ5IiIRAKEqm+pxP3vIA++0AE538b0btx11JF7Z59QU=;
 b=JHUHqXTtXKqYiyJQ3XsgzQjT0n/MNu1hRTIkBBq81eLN6Nfm/4xEDV00
 qW60kgUGAZuzSuibuDFzqwVpkYPe6H0oBLiPFdkFKzFwLFMvqPZlTbPxC
 I+nccMV22oyTtBaQsY6KTBPIdIRChKyRCU5yCQd18pjLHn+HBVwL/GlBK
 rLnfG6oqCg7SS9TXg9M1TJLW/Kjmf1JLqJLuHHgAyLX4NBXtIcsNUdW+b
 QNcba6xFkfX72jCtTEhHsU4EVEy2co3WMrZPmyEautbz6lTh8LnaAzFl8
 OZSpRIMblarNJZ1hN52VSPYQSa8OE2jpbYIoSqcK3RtAmKdDJvrbT8n7a w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14322777"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; d="scan'208";a="14322777"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Feb 2024 06:25:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="7793838"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa010.fm.intel.com with ESMTP; 29 Feb 2024 06:25:50 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 07/17] hw/vfio/helpers: Fix missing ERRP_GUARD() for
 error_prepend()
Date: Thu, 29 Feb 2024 22:39:04 +0800
Message-Id: <20240229143914.1977550-8-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229143914.1977550-1-zhao1.liu@linux.intel.com>
References: <20240229143914.1977550-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.11;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
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

In hw/vfio/helpers.c, there're 3 functions passing @errp to
error_prepend() without ERRP_GUARD():
 - vfio_set_irq_signaling()
 - vfio_device_get_name()
 - vfio_device_set_fd()

As the widely used helpers, their @errp parameters are so widely sourced
that it is necessary to protect them with ERRP_GUARD().

To avoid the issue like [1] said, add missing ERRP_GUARD() at their
beginning.

[1]: Issue description in the commit message of commit ae7c80a7bd73
     ("error: New macro ERRP_GUARD()").

Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: "Cédric Le Goater" <clg@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
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


