Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0646AC47DDB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 08:29:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVSQF-0005Rt-1i; Thu, 01 Feb 2024 03:27:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rVSPr-0005Hc-35; Thu, 01 Feb 2024 03:27:26 -0500
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rVSPp-0005Fp-8w; Thu, 01 Feb 2024 03:27:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706776041; x=1738312041;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dfciqPxL/AH0dsGMoETl0DkYoZU6V2u2WYz2kQeiFVs=;
 b=K2Jknt6jZZYH6ClPSp8iMrJuzgFVoqNlGGXOnoPnvMdDP8g20NbWsdwZ
 m1ENpCY82XcKyrx9c4rxLHADhVkiDXNu1wkmF+Q5oILrllFnMObAUKISF
 mlY7lATiLVkPl1HUuTtdI9YyT6oH+ucNTjtuBL+E9wHRGnM+87L6zCbAh
 IcLO1+dqgwOEsP08uiwiYMRZYSqNJwlf2tuLZPhzP/mQUAyD3AYXzjc0f
 NbzPJFGjoW0YJh3UDQjV7jD5djENAVODfONbvU8Ly3N2hPVv5IXKmm6L8
 QwxWXe+u5795c/P5Ij8x0++NT3JGU76FXNVSyMYwUvjd8L8utoQv+logd A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="468077718"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; d="scan'208";a="468077718"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Feb 2024 00:27:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="4348442"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 01 Feb 2024 00:27:13 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, qemu-trivial@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 2/4] hw/isa/pc87312: Consolidate the use of
 device_class_set_parent_realize()
Date: Thu,  1 Feb 2024 16:40:25 +0800
Message-Id: <20240201084027.345459-3-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201084027.345459-1-zhao1.liu@linux.intel.com>
References: <20240201084027.345459-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=134.134.136.31;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

Use device_class_set_parent_realize() to set parent realize() directly.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/isa/pc87312.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/isa/pc87312.c b/hw/isa/pc87312.c
index ee23f3e164df..64dd17b537f2 100644
--- a/hw/isa/pc87312.c
+++ b/hw/isa/pc87312.c
@@ -338,10 +338,10 @@ static void pc87312_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     ISASuperIOClass *sc = ISA_SUPERIO_CLASS(klass);
 
-    sc->parent_realize = dc->realize;
-    dc->realize = pc87312_realize;
     dc->reset = pc87312_reset;
     dc->vmsd = &vmstate_pc87312;
+    device_class_set_parent_realize(dc, pc87312_realize,
+                                    &sc->parent_realize);
     device_class_set_props(dc, pc87312_properties);
 
     sc->parallel = (ISASuperIOFuncs){
-- 
2.34.1


