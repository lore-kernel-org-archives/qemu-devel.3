Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3140EC5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 09:41:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhnlL-0007PC-Ig; Wed, 06 Mar 2024 04:40:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rhnlJ-0007OS-6t
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 04:40:33 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rhnlH-0001xp-Dd
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 04:40:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709718031; x=1741254031;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IfvbKnZ8U91lJU/dyibC1pSk1jQ3WaOU4RwX+q9xdr8=;
 b=TzjxxhVEawjpmViczxgS9MhaeXiPHfElRnr0so1pVweptpJK3gLzI5qV
 QgRPWx9ZzdMpW0SrRDmcrLr3Bfl7AwjeCrAGp9kGKt2rEvHCZv16wnHfF
 ToofmSJSWaJna0tZBwiEQbHKmn3KULyseavjRP4NZWeHgQCC18BGIcIpg
 jI9r9pgayIgqkqBtETiMogJijDMN/bJMvCIpJwZO9mUEmL8Ir7MLHEoOA
 XVnIU0bmDZOBg4WN+mNuuJnl9ynFG8dHNRKfXAPG9OAjUdZ+iXTujqVXB
 LHXML8y7+ext2DqVroSf4umG2D6vloUIjaQvd5XadERCoMoRkejj3dnjA Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="14897805"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; d="scan'208";a="14897805"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2024 01:40:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; d="scan'208";a="32854124"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa002.fm.intel.com with ESMTP; 06 Mar 2024 01:40:27 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org
Cc: Xiaoling Song <xiaoling.song@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 devel@lists.libvirt.org, Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH 01/14] hw/core/machine-smp: Remove deprecated "parameter=0"
 SMP configurations
Date: Wed,  6 Mar 2024 17:53:54 +0800
Message-Id: <20240306095407.3058909-2-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240306095407.3058909-1-zhao1.liu@linux.intel.com>
References: <20240306095407.3058909-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.11;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
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

The "parameter=0" SMP configurations have been marked as deprecated
since v6.2.

For these cases, -smp currently returns the warning and adjusts the
zeroed parameters to 1 by default.

Remove the above compatibility logic in v9.0, and return error directly
if any -smp parameter is set as 0.

Cc: devel@lists.libvirt.org
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
---
 docs/about/deprecated.rst       | 16 ----------------
 docs/about/removed-features.rst | 15 +++++++++++++++
 hw/core/machine-smp.c           |  5 +++--
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 36bd3e15ef06..872974640252 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -36,22 +36,6 @@ and will cause a warning.
 The replacement for the ``nodelay`` short-form boolean option is ``nodelay=on``
 rather than ``delay=off``.
 
-``-smp`` ("parameter=0" SMP configurations) (since 6.2)
-'''''''''''''''''''''''''''''''''''''''''''''''''''''''
-
-Specified CPU topology parameters must be greater than zero.
-
-In the SMP configuration, users should either provide a CPU topology
-parameter with a reasonable value (greater than zero) or just omit it
-and QEMU will compute the missing value.
-
-However, historically it was implicitly allowed for users to provide
-a parameter with zero value, which is meaningless and could also possibly
-cause unexpected results in the -smp parsing. So support for this kind of
-configurations (e.g. -smp 8,sockets=0) is deprecated since 6.2 and will
-be removed in the near future, users have to ensure that all the topology
-members described with -smp are greater than zero.
-
 Plugin argument passing through ``arg=<string>`` (since 6.1)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 417a0e4fa1d9..f9cf874f7b1f 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -489,6 +489,21 @@ The ``-singlestep`` option has been turned into an accelerator property,
 and given a name that better reflects what it actually does.
 Use ``-accel tcg,one-insn-per-tb=on`` instead.
 
+``-smp`` ("parameter=0" SMP configurations) (removed in 9.0)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Specified CPU topology parameters must be greater than zero.
+
+In the SMP configuration, users should either provide a CPU topology
+parameter with a reasonable value (greater than zero) or just omit it
+and QEMU will compute the missing value.
+
+However, historically it was implicitly allowed for users to provide
+a parameter with zero value, which is meaningless and could also possibly
+cause unexpected results in the -smp parsing. So support for this kind of
+configurations (e.g. -smp 8,sockets=0) is removed since 9.0, users have
+to ensure that all the topology members described with -smp are greater
+than zero.
 
 User-mode emulator command line arguments
 -----------------------------------------
diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
index 25019c91ee36..96533886b14e 100644
--- a/hw/core/machine-smp.c
+++ b/hw/core/machine-smp.c
@@ -105,8 +105,9 @@ void machine_parse_smp_config(MachineState *ms,
         (config->has_cores && config->cores == 0) ||
         (config->has_threads && config->threads == 0) ||
         (config->has_maxcpus && config->maxcpus == 0)) {
-        warn_report("Deprecated CPU topology (considered invalid): "
-                    "CPU topology parameters must be greater than zero");
+        error_setg(errp, "Invalid CPU topology: "
+                   "CPU topology parameters must be greater than zero");
+        return;
     }
 
     /*
-- 
2.34.1


