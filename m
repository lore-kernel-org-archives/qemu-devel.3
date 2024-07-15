Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF1CC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 09:44:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTIFk-0002Gr-VT; Mon, 15 Jul 2024 05:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTIFj-0002FA-Dn
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 05:44:15 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTIFg-0005Pt-Mk
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 05:44:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721036652; x=1752572652;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=kdXjqi13CCe9SdliRbBIpnfNqhqkl6WeICywifF1dCI=;
 b=SQvu4KkHq/UnxSEz6fDVN+6SougkPZghncyMBZKERHLl+WCsv4jetn6d
 e1FbDzpNpebGblVv2VbwrkgamAHBgmLPikyZ5aReFDHQqntDZ5YrOr9mA
 aUbX93JDH+RU3+5pzhDgADoCowG4cB+Tn55FGK9KIBUYnIngv6XABZmJh
 j8fNW2D/tK03CFwQmlTFwm/BKOfbFVtRNxOoHeW4HoK18h5oWOkjs2VEf
 ik5zJHzXFwQETwXsJLOdVTGXP2NRPIW9l3qopvOG0b2lH3U//BcrNK5AF
 VV+4BNyURey26z3nFLI46cCEHvI/4ZlVnYYakPc7Qx21/4JpaDqpSUiFg A==;
X-CSE-ConnectionGUID: x766oiNuTdeyTAHJBH1AbQ==
X-CSE-MsgGUID: o5xPw17+Q/SKex5383hByg==
X-IronPort-AV: E=McAfee;i="6700,10204,11133"; a="35837073"
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; d="scan'208";a="35837073"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2024 02:44:09 -0700
X-CSE-ConnectionGUID: zahehWo1RLqTTaf3Hv4vmg==
X-CSE-MsgGUID: GlMW/VGvSR+eSVXRjM7u8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; d="scan'208";a="53854606"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 15 Jul 2024 02:44:08 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/nubus/nubus-virtio-mmio: Fix missing ERRP_GUARD() in
 nubus_virtio_mmio_realize()
Date: Mon, 15 Jul 2024 17:59:37 +0800
Message-Id: <20240715095939.72492-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

But in nubus_virtio_mmio_realize(), @errp is dereferenced without
ERRP_GUARD().

Although nubus_virtio_mmio_realize() - as a DeviceClass.realize()
method - doesn't get the NULL @errp parameter, it hasn't triggered the
bug that dereferencing the NULL @errp. It's still necessary to follow
the requirement of @errp, so add missing ERRP_GUARD() in
nubus_virtio_mmio_realize().

Cc: Laurent Vivier <laurent@vivier.eu>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
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


