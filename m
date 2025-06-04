Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EEDBC61CE7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 11:59:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMmks-0005D4-0n; Wed, 04 Jun 2025 07:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uMmkq-0005Cl-N8; Wed, 04 Jun 2025 07:58:00 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uMmko-0000nv-Pp; Wed, 04 Jun 2025 07:58:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749038279; x=1780574279;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IjSCOf7F/bOSAtnrMFcFxs/bciMfBh4IH76ect/nfBs=;
 b=VCUMfYB/eZ35ySCWAXYCTqemqOhDZpDOyCRrcNYCCgMLH4WC067au2Ll
 Z+GdznJcVNTHV6aU+L20lEe6NXYyYInrEfUWpw13oqKDIKe55aqk4Zw5u
 B1NqIHD+mL/UyRX0otvd1H8jiSSOeS6ReznISiSNQ7zYfGhIdZdGif4nH
 F421UWWic2RDVkskbpgtm0g4Ji0Zr6Q6LbYwik+MRoZiAvpw85+hoD9rc
 o5vl9239vEORz9M7YPmTvkK/ZHiA0MIul8QwxiDTI6YN7yBQ9ihfhjDqA
 O56Us9V4/6/y1AfqwFCFpobKeHtW5AxpUbM7OguIGs8xsht/HnJTALQaP g==;
X-CSE-ConnectionGUID: iqWeSYXGQlCXBVIozUAjoA==
X-CSE-MsgGUID: Lhwj6X2mRu6+gTRbaZJSXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="54915371"
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; d="scan'208";a="54915371"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2025 04:57:56 -0700
X-CSE-ConnectionGUID: jfduiF5jR6S5bzOkGEIZEQ==
X-CSE-MsgGUID: xIsgy2K3TUGO776OgypQ8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; d="scan'208";a="150048307"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2025 04:57:53 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: chao.p.peng@intel.com, david@redhat.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org (open list:ASPEED BMCs)
Subject: [PATCH v2 3/5] hw/gpio/aspeed: Fix definition of AspeedGPIOClass
Date: Wed,  4 Jun 2025 19:53:58 +0800
Message-Id: <20250604115400.98905-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250604115400.98905-1-zhenzhong.duan@intel.com>
References: <20250604115400.98905-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

AspeedGPIOClass's parent is SysBusDeviceClass rather than SysBusDevice.

Fixes: 4b7f956862dc ("hw/gpio: Add basic Aspeed GPIO model for AST2400 and AST2500")
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/gpio/aspeed_gpio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/gpio/aspeed_gpio.h b/include/hw/gpio/aspeed_gpio.h
index e1e6c54333..e6b2fe71b5 100644
--- a/include/hw/gpio/aspeed_gpio.h
+++ b/include/hw/gpio/aspeed_gpio.h
@@ -70,7 +70,7 @@ typedef struct AspeedGPIOReg {
 } AspeedGPIOReg;
 
 struct AspeedGPIOClass {
-    SysBusDevice parent_obj;
+    SysBusDeviceClass parent_class;
     const GPIOSetProperties *props;
     uint32_t nr_gpio_pins;
     uint32_t nr_gpio_sets;
-- 
2.34.1


