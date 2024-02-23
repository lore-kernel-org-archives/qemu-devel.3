Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A2DC5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 08:44:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdRA6-0003o5-22; Fri, 23 Feb 2024 03:44:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rdRA0-0003lb-RG; Fri, 23 Feb 2024 03:44:02 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rdR9z-0000BO-7B; Fri, 23 Feb 2024 03:44:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708677839; x=1740213839;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MdIfh/jYydArR3D22MnTaJm9imdQCnDqtGGlbaFl++w=;
 b=JUCrwAi9HXFCrFIz9r7w0S/eZ3/WNjN+rEZE1zrp/wNGnZuACQ3u3lu9
 vzUEZeQklvzHG8TFgFhXEPqHwvmxox3OAHanNxY1mEbzQQ/uJAnHQjUoR
 74KDJZsGygFQjX/LBYUnwXzF9aPAy+G4zMx2N/Pqs0qcKYaM2wlvX1cFu
 uTugGlgPv6dCErZZ1PncweFQeGdsxICjbXjEj0hF75hJRXGTYnL4jwsFU
 OlRzEn9Mk25fb2V5HlYbiEMa1QTo5RL82SPvy2BQ+b08bBRHheQJGsZ/F
 Q20iWGNVGy3hq7OUHl2g/V9mvjEwVMPsce5mkXitw+HHBmVdbLYuDvNlz w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="28413916"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; d="scan'208";a="28413916"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Feb 2024 00:43:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5731881"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 23 Feb 2024 00:43:48 -0800
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
Subject: [PATCH v2 7/7] hw/intc: Check @errp to handle the error of
 IOAPICCommonClass.realize()
Date: Fri, 23 Feb 2024 16:56:53 +0800
Message-Id: <20240223085653.1255438-8-zhao1.liu@linux.intel.com>
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

IOAPICCommonClass implements its own private realize(), and this private
realize() allows error.

Since IOAPICCommonClass.realize() returns void, to check the error,
dereference @errp with ERRP_GUARD().

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
v2:
 * Add the missing ERRP_GUARD(). (Markus)
 * Move this single patch into @errp fixing series. (Micheal)
---
 hw/intc/ioapic_common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/intc/ioapic_common.c b/hw/intc/ioapic_common.c
index cb9bf6214608..efbe6958c8d7 100644
--- a/hw/intc/ioapic_common.c
+++ b/hw/intc/ioapic_common.c
@@ -152,6 +152,7 @@ static int ioapic_dispatch_post_load(void *opaque, int version_id)
 
 static void ioapic_common_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_GUARD();
     IOAPICCommonState *s = IOAPIC_COMMON(dev);
     IOAPICCommonClass *info;
 
@@ -162,6 +163,9 @@ static void ioapic_common_realize(DeviceState *dev, Error **errp)
 
     info = IOAPIC_COMMON_GET_CLASS(s);
     info->realize(dev, errp);
+    if (*errp) {
+        return;
+    }
 
     sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->io_memory);
     ioapic_no++;
-- 
2.34.1


