Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5881CCE8D4C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 05:56:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srA9X-00086K-Tl; Thu, 19 Sep 2024 01:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1srA96-000662-6p; Thu, 19 Sep 2024 01:56:05 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1srA91-0007Mi-S2; Thu, 19 Sep 2024 01:56:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726725360; x=1758261360;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/cMy+TVZMq4kWR7qIMuMwsU4jrTnlPcE1TIfBgg13Sg=;
 b=coOZlHToYav7NVHETyTa3qsLidXC0fUSlNZLk5CO2JyIt0tXMdy7BkB7
 FgppIQEv9C4stryVp7tohkkNuNP23fiIAp9zVgIWt9LaPIERKl2iGzvsj
 ZicewfCfgizAYR6CBE2tbINe+8KYHiX+w8Slw+JKFdoNVlGz98CJp9sZw
 na1+AaGqgQut6NUqZygvCaLZiDLRiXbxGZG0+zjbpBQSb4GHN7ecNnwGn
 Rj1zYZwxkDd5R3vgdNb7ypD/1vQjz5hMQNfTurH9Uwe6Ib3DuHzXK2obo
 veyVbvOMa6i5vFG3sF4fDEe1N7qabUDHPzlyGWB2PfY/v3uR0l3IX7xkv w==;
X-CSE-ConnectionGUID: iym3Q09aS8GbFELNU1eSdg==
X-CSE-MsgGUID: LSIAwqsfRKireGxmpQ6Isg==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="25813476"
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="25813476"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2024 22:55:43 -0700
X-CSE-ConnectionGUID: HLpTBuCBQpubXQuDEb2ZXA==
X-CSE-MsgGUID: hbxUqHsUT/+8D401YpRrJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="69418634"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa006.fm.intel.com with ESMTP; 18 Sep 2024 22:55:37 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC v2 02/12] qdev: Introduce new device category to cover basic
 topology device
Date: Thu, 19 Sep 2024 14:11:18 +0800
Message-Id: <20240919061128.769139-3-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919061128.769139-1-zhao1.liu@intel.com>
References: <20240919061128.769139-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Topology devices are used to define CPUs and need to be created and
realized earlier than current qemu_create_cli_devices().

Use this new catogory to identify such special devices, which allows
to create them earlier in subsequent change.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/cpu/cpu-topology.c  | 2 +-
 include/hw/qdev-core.h | 1 +
 system/qdev-monitor.c  | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/cpu/cpu-topology.c b/hw/cpu/cpu-topology.c
index 3e8982ff7e6c..ce3da844a7d8 100644
--- a/hw/cpu/cpu-topology.c
+++ b/hw/cpu/cpu-topology.c
@@ -164,7 +164,7 @@ static void cpu_topo_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
     CPUTopoClass *tc = CPU_TOPO_CLASS(oc);
 
-    set_bit(DEVICE_CATEGORY_CPU, dc->categories);
+    set_bit(DEVICE_CATEGORY_CPU_DEF, dc->categories);
     dc->realize = cpu_topo_realize;
 
     /*
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 77223b28c788..ddcaa329e3ec 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -86,6 +86,7 @@ typedef enum DeviceCategory {
     DEVICE_CATEGORY_SOUND,
     DEVICE_CATEGORY_MISC,
     DEVICE_CATEGORY_CPU,
+    DEVICE_CATEGORY_CPU_DEF,
     DEVICE_CATEGORY_WATCHDOG,
     DEVICE_CATEGORY_MAX
 } DeviceCategory;
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index fe120353fedc..07863d4e650a 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -179,6 +179,7 @@ static void qdev_print_devinfos(bool show_no_user)
         [DEVICE_CATEGORY_SOUND]   = "Sound",
         [DEVICE_CATEGORY_MISC]    = "Misc",
         [DEVICE_CATEGORY_CPU]     = "CPU",
+        [DEVICE_CATEGORY_CPU_DEF] = "CPU Definition",
         [DEVICE_CATEGORY_WATCHDOG]= "Watchdog",
         [DEVICE_CATEGORY_MAX]     = "Uncategorized",
     };
-- 
2.34.1


