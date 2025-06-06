Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A7A7C5B559
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 09:30:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNTNE-0005qH-0P; Fri, 06 Jun 2025 05:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uNTN3-0005n9-Br; Fri, 06 Jun 2025 05:28:18 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uNTMw-0001AE-40; Fri, 06 Jun 2025 05:28:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749202091; x=1780738091;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2ePIszT8vhUK6g6wYVAlRimUVB4HDL6I8i1MCH7XmJE=;
 b=mXothN+uN6KilGLRnetdrFcxAfcymwC+OlLKXvKJryYea022bvtOzZGz
 P4I95krVbwvJaC6rCB1a+wZyJeenIfcq1DtP0TJGLRpOoCqLNgxIYPM/B
 VrDsOmsaEugy+t+ZBe7Fcaex8gB/JTL9X/lXyk6TRcaiJlZBPfx0wMZhE
 +RC7Vt1TA71OZ45aKq+zmwTn0uN2cElEI5JYNLS5U80jon1RGgkYlFScP
 jBNfBg6U/53Vf5DSri1Hq3x5Hj7OJvPPk66fAbuh/30PQGVqbxvYZxL/7
 BmwJYrtHd3Uz6WxxBV+hKc7+0klXgJLQdXcW+yqW0cP73DrRZK5z9SPYW Q==;
X-CSE-ConnectionGUID: V8dck0uLSH2FPAM4F9D3aw==
X-CSE-MsgGUID: 73C6WmPgR9q6+6Y/4f+R5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="55154640"
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; d="scan'208";a="55154640"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2025 02:28:03 -0700
X-CSE-ConnectionGUID: zBWB2QWuRxmXX5DQK84FSQ==
X-CSE-MsgGUID: CuSblt6HR3mqDKjBqDsTQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; d="scan'208";a="145706189"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2025 02:27:59 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: chao.p.peng@intel.com, david@redhat.com, armbru@redhat.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org (open list:ASPEED BMCs)
Subject: [PATCH v4 3/5] hw/gpio/aspeed: Fix definition of AspeedGPIOClass
Date: Fri,  6 Jun 2025 17:24:04 +0800
Message-Id: <20250606092406.229833-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250606092406.229833-1-zhenzhong.duan@intel.com>
References: <20250606092406.229833-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
This isn't catastrophic only because sizeof(SysBusDevice) >
sizeof(SysBusDeviceClass).

Fixes: 4b7f956862dc ("hw/gpio: Add basic Aspeed GPIO model for AST2400 and AST2500")
Closes: https://lists.gnu.org/archive/html/qemu-devel/2025-06/msg00586.html
Suggested-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


