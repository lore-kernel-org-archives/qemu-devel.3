Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C9B8C0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 02:42:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thJkD-0000Gx-5Q; Sun, 09 Feb 2025 21:41:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1thJkB-0000Gc-C4; Sun, 09 Feb 2025 21:41:55 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1thJk9-00089w-M0; Sun, 09 Feb 2025 21:41:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739155314; x=1770691314;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pIZ3Unj7TN3jHMZoZ5QYTyTSJp+DifzMWzG6gsybVVE=;
 b=gkjqxY5kmDEiUhOmd7H8hyEemce/ssF1ha3eaQYCf8yQ9NZTq/9deV+/
 F/YGJ4AatIKU3iy88hQ6jjGGMrOxOTvVysFogh5NP4BizS2rUHGkI70t4
 w8entrEPFiy94kxaDhCrFTe3tD+3bdsfnKrBtW18mSd9axNO25eSmCcV4
 excyQpxvAxf9NZ25Y8TfO96QmVcPizvyrqQCbrXXxnnIjjPB6oo8/jAHs
 Ndfh8B/+/O2Wrl32fdmAbjl+bXke/BY6FE3RbnJbg/4dvaHd1ekRgkwfL
 TCvA9hxwHc6QPOZ4wGvh7rnXZ2g7+0oWAokVKGPjK/VvKH1EtHEsA3hdT A==;
X-CSE-ConnectionGUID: fFEcetATSySGyeoE7VWsyw==
X-CSE-MsgGUID: PQjKO4OxQISp96PrNJ6Tcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="50351292"
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; d="scan'208";a="50351292"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2025 18:41:53 -0800
X-CSE-ConnectionGUID: yv3nxVWkQzi+YYTiKopJRQ==
X-CSE-MsgGUID: aTSZAACBSOK1GH+2ce/gag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="142938265"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 09 Feb 2025 18:41:50 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 10/10] i386: enable rust hpet for pc when rust is enabled
Date: Mon, 10 Feb 2025 11:00:51 +0800
Message-Id: <20250210030051.2562726-11-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250210030051.2562726-1-zhao1.liu@intel.com>
References: <20250210030051.2562726-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.405,
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

Add HPET configuration in PC's Kconfig options, and select HPET device
(Rust version) if Rust is supported.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since RFC:
 * Fix rust hpet not being optional.
 * Fix bios-tables-test missing rust hpet.
---
 configs/devices/i386-softmmu/default.mak | 1 +
 hw/i386/fw_cfg.c                         | 2 +-
 hw/i386/pc.c                             | 2 +-
 hw/timer/Kconfig                         | 6 +++++-
 rust/hw/Kconfig                          | 1 +
 rust/hw/timer/Kconfig                    | 2 ++
 tests/qtest/meson.build                  | 3 ++-
 7 files changed, 13 insertions(+), 4 deletions(-)
 create mode 100644 rust/hw/timer/Kconfig

diff --git a/configs/devices/i386-softmmu/default.mak b/configs/devices/i386-softmmu/default.mak
index 4faf2f0315e2..9ef343cace06 100644
--- a/configs/devices/i386-softmmu/default.mak
+++ b/configs/devices/i386-softmmu/default.mak
@@ -6,6 +6,7 @@
 #CONFIG_APPLESMC=n
 #CONFIG_FDC=n
 #CONFIG_HPET=n
+#CONFIG_X_HPET_RUST=n
 #CONFIG_HYPERV=n
 #CONFIG_ISA_DEBUG=n
 #CONFIG_ISA_IPMI_BT=n
diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index 546de63123e6..a7d69a49edbf 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -147,7 +147,7 @@ FWCfgState *fw_cfg_arch_create(MachineState *ms,
 #endif
     fw_cfg_add_i32(fw_cfg, FW_CFG_IRQ0_OVERRIDE, 1);
 
-#ifdef CONFIG_HPET
+#if defined(CONFIG_HPET) || defined(CONFIG_X_HPET_RUST)
     PCMachineState *pcms =
         (PCMachineState *)object_dynamic_cast(OBJECT(ms), TYPE_PC_MACHINE);
     if (pcms && pcms->hpet_enabled) {
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index b46975c8a4db..04554817e021 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1701,7 +1701,7 @@ static void pc_machine_initfn(Object *obj)
     pcms->sata_enabled = true;
     pcms->i8042_enabled = true;
     pcms->max_fw_size = 8 * MiB;
-#ifdef CONFIG_HPET
+#if defined(CONFIG_HPET) || defined(CONFIG_X_HPET_RUST)
     pcms->hpet_enabled = true;
 #endif
     pcms->fd_bootchk = true;
diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
index c96fd5d97ae8..c051597180f4 100644
--- a/hw/timer/Kconfig
+++ b/hw/timer/Kconfig
@@ -11,7 +11,11 @@ config A9_GTIMER
 
 config HPET
     bool
-    default y if PC
+    default y if PC && !HAVE_RUST
+
+config X_HPET_RUST
+    bool
+    default y if PC && HAVE_RUST
 
 config I8254
     bool
diff --git a/rust/hw/Kconfig b/rust/hw/Kconfig
index 4d934f30afe1..36f92ec02874 100644
--- a/rust/hw/Kconfig
+++ b/rust/hw/Kconfig
@@ -1,2 +1,3 @@
 # devices Kconfig
 source char/Kconfig
+source timer/Kconfig
diff --git a/rust/hw/timer/Kconfig b/rust/hw/timer/Kconfig
new file mode 100644
index 000000000000..afd980335037
--- /dev/null
+++ b/rust/hw/timer/Kconfig
@@ -0,0 +1,2 @@
+config X_HPET_RUST
+    bool
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 5e062c752a7e..34c59107cf4f 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -103,7 +103,8 @@ qtests_i386 = \
    config_all_devices.has_key('CONFIG_VIRTIO_PCI') and                                      \
    slirp.found() ? ['virtio-net-failover'] : []) +                                          \
   (unpack_edk2_blobs and                                                                    \
-   config_all_devices.has_key('CONFIG_HPET') and                                            \
+   (config_all_devices.has_key('CONFIG_HPET') or                                            \
+    config_all_devices.has_key('CONFIG_X_HPET_RUST')) and                                   \
    config_all_devices.has_key('CONFIG_PARALLEL') ? ['bios-tables-test'] : []) +             \
   qtests_pci +                                                                              \
   qtests_cxl +                                                                              \
-- 
2.34.1


