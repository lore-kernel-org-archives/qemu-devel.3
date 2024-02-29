Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C37C54E41
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 14:26:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfhMB-00067g-RJ; Thu, 29 Feb 2024 09:25:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rfhM1-0005w7-94; Thu, 29 Feb 2024 09:25:47 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rfhLy-0005Qn-J7; Thu, 29 Feb 2024 09:25:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709216742; x=1740752742;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PVIcgcS+qmBfDxKXsQgehBX6G6DcMEFwCkNyJ4e5d10=;
 b=RP7xos8PdLKR8vnKDcAuSL1J4Fw+L4xyXCw7dDM4Ttd01mIgxcsLh0xs
 ZEjZv/WV2fFNzsbL5pCHzY2LCZWbhSJ6voORmxr2dYnK06WNU2jdNTSMU
 +b1QCv/e+Gjf1xW29SvgTwpWMSTuaOTnEkJwXCIu2uUKrKWmtTxrx2d68
 G+KD4/3EckLlxe7CkUxnYMBHQKpvH6ocOiMstDzecsDgKAB4gKWFZoAAp
 dTYP3yKoGlMBBhWaHrBcpgheMqcg7ALrXhR2g2ihGXLeD1Hg8lxGIW1e6
 6DxfGCgeM2PfAjSafC2F2PuWp+KVxFFLfUTEgo07W/at/HWbKkrhbUpUd A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14322730"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; d="scan'208";a="14322730"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Feb 2024 06:25:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="7793798"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa010.fm.intel.com with ESMTP; 29 Feb 2024 06:25:36 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH 02/17] hw/net/xen_nic: Fix missing ERRP_GUARD() for
 error_prepend()
Date: Thu, 29 Feb 2024 22:38:59 +0800
Message-Id: <20240229143914.1977550-3-zhao1.liu@linux.intel.com>
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

The xen_netdev_connect() passes @errp to error_prepend(), and its @errp
parameter is from xen_device_frontend_changed().

Though its @errp points to @local_err of xen_device_frontend_changed(),
to follow the requirement of @errp, add missing ERRP_GUARD() at the
beginning of this function.

[1]: Issue description in the commit message of commit ae7c80a7bd73
     ("error: New macro ERRP_GUARD()").

Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Paul Durrant <paul@xen.org>
Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/net/xen_nic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/net/xen_nic.c b/hw/net/xen_nic.c
index 453fdb981983..89487b49baf9 100644
--- a/hw/net/xen_nic.c
+++ b/hw/net/xen_nic.c
@@ -351,6 +351,7 @@ static bool net_event(void *_xendev)
 
 static bool xen_netdev_connect(XenDevice *xendev, Error **errp)
 {
+    ERRP_GUARD();
     XenNetDev *netdev = XEN_NET_DEVICE(xendev);
     unsigned int port, rx_copy;
 
-- 
2.34.1


