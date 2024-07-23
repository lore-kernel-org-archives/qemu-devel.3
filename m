Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90214C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 16:03:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWHyB-0006kS-NE; Tue, 23 Jul 2024 12:02:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sWHy8-0006Mg-E5
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 12:02:28 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sWHy4-0002v7-MK
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 12:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721750545; x=1753286545;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=5MU7eevRpBh53dsFKEvgnt26B1zkUlmoov6+FqAv3AE=;
 b=FW2YntFV11LC8P+ZhziaX71uClchW78lHAmYF0BCUbjgql+asE51j27v
 n+wYLY//otnptKcKN9lij+/Kr0roCvW6d/W1l+Bau6okzo8+7Bo8L1Bwc
 KVmK7GvCHAiniwcNJsyf0qRpZ2hYbnu/G0m8gKcZmt6VeorSLOgfZ5yDP
 diIviY3SlCDmCb1Wa4PbOiGb97JEqcoJwlkleM66n+urUFRmL0SIa8WdE
 7LVmQJWWdNUUv7YvKGtO67tHet4XrZpI68vPf5B8z0ZEK8Mjx3+rtcX+p
 kXv/zrl+OBZ0dZ9RM/kzPVK9jFCej60bT/C526/IsKk1801Z9bnr9rjoy A==;
X-CSE-ConnectionGUID: jUAxvXrVSzeBQOGt/1jmWg==
X-CSE-MsgGUID: FFxpH+gCSFGdM1FmLNspzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="29976271"
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; d="scan'208";a="29976271"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2024 09:02:21 -0700
X-CSE-ConnectionGUID: rXClp3zfTGq8951o0WZXxA==
X-CSE-MsgGUID: BtksmpK5SHe9ANujf6rF3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; d="scan'208";a="51993759"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 23 Jul 2024 09:02:19 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2] hw/nubus/nubus-virtio-mmio: Fix missing ERRP_GUARD() in
 nubus_virtio_mmio_realize()
Date: Wed, 24 Jul 2024 00:18:02 +0800
Message-Id: <20240723161802.1377985-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

According to the comment in qapi/error.h, dereferencing @errp requires
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

In nubus_virtio_mmio_realize(), @errp is dereferenced without
ERRP_GUARD().

Although nubus_virtio_mmio_realize() - as a DeviceClass.realize()
method - is never passed a null @errp argument, it should follow the
rules on @errp usage.  Add the ERRP_GUARD() there.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
v2: Used Markus' words in commit message and added his r/b tag.
---
 hw/nubus/nubus-virtio-mmio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/nubus/nubus-virtio-mmio.c b/hw/nubus/nubus-virtio-mmio.c
index 58a63c84d0be..a5558d3ec28b 100644
--- a/hw/nubus/nubus-virtio-mmio.c
+++ b/hw/nubus/nubus-virtio-mmio.c
@@ -23,6 +23,7 @@ static void nubus_virtio_mmio_set_input_irq(void *opaque, int n, int level)
 
 static void nubus_virtio_mmio_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_GUARD();
     NubusVirtioMMIODeviceClass *nvmdc = NUBUS_VIRTIO_MMIO_GET_CLASS(dev);
     NubusVirtioMMIO *s = NUBUS_VIRTIO_MMIO(dev);
     NubusDevice *nd = NUBUS_DEVICE(dev);
-- 
2.34.1


