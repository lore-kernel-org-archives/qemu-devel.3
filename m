Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2757CD11704
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 16:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQSsG-0005Cl-Sh; Tue, 02 Dec 2025 11:05:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQSsD-00054U-NP; Tue, 02 Dec 2025 11:05:05 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQSsB-00066J-Nx; Tue, 02 Dec 2025 11:05:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764691504; x=1796227504;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XlIGSj5lhO4Iz2SQI4ugiBcfuTEO7n1T8R6MNiVxNhc=;
 b=MaPQfyZZTfGgprVFr5uSl/v0D5PTLN6jprJqeHcArru+5u9IRyi3MGA3
 kuu3YIPtFqfK/EtGp+9HQVLNeWtm3yY2so32KrZrUcZCYz5JSCWmVKHkR
 tOwSgR0C8PEu7AMu9VPQURShMItEnUmpKwZu0K/4QrLQK9UCw/anW2s+r
 X2hf1gYMOUJu/fyaU7N8L1+2T53IbPfosItiyU8sS/Ta0/qBhTUHLTHAs
 QauxqAlhgo88kd8mOl/WfynHf9+qZAVyatvOBlRqCvOOoeUY9QENC+4GG
 gLkF9p+nVRin3ip39HwRPUa5zDNHOL3BbjgzrCStT2Hco8jqw1N4cGl4C g==;
X-CSE-ConnectionGUID: +9eMkx7HSji108PC//hQyQ==
X-CSE-MsgGUID: yhCb/hq6Rrq2QqQfGOLViQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="92142399"
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; d="scan'208";a="92142399"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2025 08:05:02 -0800
X-CSE-ConnectionGUID: rtOdz7YASjSKQ1dh7A6/bg==
X-CSE-MsgGUID: DswU6ju5RweXLybViEBGvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; d="scan'208";a="199537043"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 02 Dec 2025 08:04:53 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org, kvm@vger.kernel.org,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yi Liu <yi.l.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Amit Shah <amit@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Yanan Wang <wangyanan55@huawei.com>, Helge Deller <deller@gmx.de>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Peter Krempa <pkrempa@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v5 06/28] docs/specs/acpi_cpu_hotplug: Remove legacy cpu
 hotplug descriptions
Date: Wed,  3 Dec 2025 00:28:13 +0800
Message-Id: <20251202162835.3227894-7-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251202162835.3227894-1-zhao1.liu@intel.com>
References: <20251202162835.3227894-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
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

Legacy cpu hotplug has been removed totally and machines start with
modern cpu hotplug interface directly.

Therefore, update the documentation to describe current QEMU cpu hotplug
logic.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since v4:
 * New patch.
---
 docs/specs/acpi_cpu_hotplug.rst | 28 +++-------------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/docs/specs/acpi_cpu_hotplug.rst b/docs/specs/acpi_cpu_hotplug.rst
index 351057c96761..f49678100044 100644
--- a/docs/specs/acpi_cpu_hotplug.rst
+++ b/docs/specs/acpi_cpu_hotplug.rst
@@ -8,22 +8,6 @@ ACPI BIOS GPE.2 handler is dedicated for notifying OS about CPU hot-add
 and hot-remove events.
 
 
-Legacy ACPI CPU hotplug interface registers
--------------------------------------------
-
-CPU present bitmap for:
-
-- ICH9-LPC (IO port 0x0cd8-0xcf7, 1-byte access)
-- PIIX-PM  (IO port 0xaf00-0xaf1f, 1-byte access)
-- One bit per CPU. Bit position reflects corresponding CPU APIC ID. Read-only.
-- The first DWORD in bitmap is used in write mode to switch from legacy
-  to modern CPU hotplug interface, write 0 into it to do switch.
-
-QEMU sets corresponding CPU bit on hot-add event and issues SCI
-with GPE.2 event set. CPU present map is read by ACPI BIOS GPE.2 handler
-to notify OS about CPU hot-add events. CPU hot-remove isn't supported.
-
-
 Modern ACPI CPU hotplug interface registers
 -------------------------------------------
 
@@ -189,20 +173,14 @@ Typical usecases
 (x86) Detecting and enabling modern CPU hotplug interface
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-QEMU starts with legacy CPU hotplug interface enabled. Detecting and
-switching to modern interface is based on the 2 legacy CPU hotplug features:
-
-#. Writes into CPU bitmap are ignored.
-#. CPU bitmap always has bit #0 set, corresponding to boot CPU.
-
-Use following steps to detect and enable modern CPU hotplug interface:
+QEMU starts with modern CPU hotplug interface enabled. Use following steps to
+detect modern CPU hotplug interface:
 
-#. Store 0x0 to the 'CPU selector' register, attempting to switch to modern mode
 #. Store 0x0 to the 'CPU selector' register, to ensure valid selector value
 #. Store 0x0 to the 'Command field' register
 #. Read the 'Command data 2' register.
    If read value is 0x0, the modern interface is enabled.
-   Otherwise legacy or no CPU hotplug interface available
+   Otherwise no CPU hotplug interface available
 
 Get a cpu with pending event
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- 
2.34.1


