Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477ADC54E41
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 14:29:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfhMt-0007S7-L6; Thu, 29 Feb 2024 09:26:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rfhMk-00075j-Kn; Thu, 29 Feb 2024 09:26:31 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rfhMi-0005c2-R1; Thu, 29 Feb 2024 09:26:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709216789; x=1740752789;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xzkP10xeaHsq8UV5Wca3B+v53CNbpWYjrVZWa4XoviU=;
 b=XMPQ0Gd7N6G9WZXsIGsADM3FZUUyE5Otp2looK5fWcbWY8JDYOWNdXeL
 WWcZFj6gyhQLAjRBe+aIMhKrMVNPs2LoalijBMs8Pw/plUf55K5sSp+9h
 hEMBvvulXcqwlK42baDNn3Gdk5UsVfLEEMY/u+kR165vbkAA5UJ1Dg9n9
 0909KAi6NYcE/95TMSZzAMHUDuVENZWWiuNkA5cDrwFw+UeDVb+BE/E9a
 q40SzVt50q4YPEEgcMTG9xwh8t/npgS3wzFtErdmBBJe2rsuphA25W7KP
 5pNXeIsTtTeMj548Kq/jfjpyJpT8VsLTij6m01Od7o0ru4iU//wV+Qwhy Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14322833"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; d="scan'208";a="14322833"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Feb 2024 06:26:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="7793885"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa010.fm.intel.com with ESMTP; 29 Feb 2024 06:26:05 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 13/17] hw/virtio/vhost: Fix missing ERRP_GUARD() for
 error_prepend()
Date: Thu, 29 Feb 2024 22:39:10 +0800
Message-Id: <20240229143914.1977550-14-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229143914.1977550-1-zhao1.liu@linux.intel.com>
References: <20240229143914.1977550-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
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

In hw/virtio/vhost.c, there're 2 functions passing @errp to
error_prepend() without ERRP_GUARD():
- vhost_save_backend_state()
- vhost_load_backend_state()

Their @errp both points to callers' @local_err. However, as the APIs
defined in include/hw/virtio/vhost.h, it is necessary to protect their
@errp with ERRP_GUARD().

To follow the requirement of @errp, add missing ERRP_GUARD() at their
beginning.

[1]: Issue description in the commit message of commit ae7c80a7bd73
     ("error: New macro ERRP_GUARD()").

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/virtio/vhost.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 2c9ac794680e..2e4e040db87a 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -2199,6 +2199,7 @@ int vhost_check_device_state(struct vhost_dev *dev, Error **errp)
 
 int vhost_save_backend_state(struct vhost_dev *dev, QEMUFile *f, Error **errp)
 {
+    ERRP_GUARD();
     /* Maximum chunk size in which to transfer the state */
     const size_t chunk_size = 1 * 1024 * 1024;
     g_autofree void *transfer_buf = NULL;
@@ -2291,6 +2292,7 @@ fail:
 
 int vhost_load_backend_state(struct vhost_dev *dev, QEMUFile *f, Error **errp)
 {
+    ERRP_GUARD();
     size_t transfer_buf_size = 0;
     g_autofree void *transfer_buf = NULL;
     g_autoptr(GError) g_err = NULL;
-- 
2.34.1


