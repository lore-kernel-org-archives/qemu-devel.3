Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD37C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 09:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhnlP-0007Ph-4K; Wed, 06 Mar 2024 04:40:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rhnlN-0007PD-FZ
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 04:40:37 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rhnlL-00020k-LV
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 04:40:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709718036; x=1741254036;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aeA2s9T7ZHBvx6ENH8YGd6wH3Oj/Qq+YESJhKmgsOC0=;
 b=M0z6+Zwp4M9LsnA985kbkwOqYqcq7lizTBCBOpzoBkRNS+YAXziITbEV
 r8Jmlve9AWQTufldn4LBOy2buGJB+dk2EodmaQJOB4N1xiQMd6zg0GEWC
 sBc705DRnjCTE7zxJGHt9J7oK0Y+R0SePhFn1APrmtj1Y2zTqmTN8rcbB
 W95QbLc1yMjtqSvseBGoO+mnsuOZGIKAChfukvnUNQmnF+22B+qHA2TSu
 3LkWKURBBwCW9Ne89yOmHs07r5txJVf4FiBqU5TbxTXgcSSh1VB52ZsU8
 rHkTkB5sRm7xVkX/c0uRQlGgn/7F4kCyF3680TC6Dkf8QxqjJD236UNjv A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="14897814"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; d="scan'208";a="14897814"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2024 01:40:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; d="scan'208";a="32854129"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa002.fm.intel.com with ESMTP; 06 Mar 2024 01:40:30 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org
Cc: Xiaoling Song <xiaoling.song@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 devel@lists.libvirt.org
Subject: [PATCH 02/14] hw/core/machine-smp: Deprecate unsupported
 "parameter=1" SMP configurations
Date: Wed,  6 Mar 2024 17:53:55 +0800
Message-Id: <20240306095407.3058909-3-zhao1.liu@linux.intel.com>
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

Currentlt, it was allowed for users to specify the unsupported
topology parameter as "1". For example, x86 PC machine doesn't
support drawer/book/cluster topology levels, but user could specify
"-smp drawers=1,books=1,clusters=1".

This is meaningless and confusing, so that the support for this kind of
configurations is marked depresated since 9.0. And report warning
message for such case like:

qemu-system-x86_64: warning: Deprecated CPU topology (considered invalid):
                    Unsupported clusters parameter mustn't be specified as 1
qemu-system-x86_64: warning: Deprecated CPU topology (considered invalid):
                    Unsupported books parameter mustn't be specified as 1
qemu-system-x86_64: warning: Deprecated CPU topology (considered invalid):
                    Unsupported drawers parameter mustn't be specified as 1

Users have to ensure that all the topology members described with -smp
are supported by the target machine.

Cc: devel@lists.libvirt.org
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 docs/about/deprecated.rst | 14 +++++++++
 hw/core/machine-smp.c     | 63 +++++++++++++++++++++++++++++----------
 2 files changed, 61 insertions(+), 16 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 872974640252..2e782e83e952 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -47,6 +47,20 @@ as short-form boolean values, and passed to plugins as ``arg_name=on``.
 However, short-form booleans are deprecated and full explicit ``arg_name=on``
 form is preferred.
 
+``-smp`` (Unsopported "parameter=1" SMP configurations) (since 9.0)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Specified CPU topology parameters must be supported by the machine.
+
+In the SMP configuration, users should provide the CPU topology parameters that
+are supported by the target machine.
+
+However, historically it was allowed for users to specify the unsupported
+topology parameter as "1", which is meaningless. So support for this kind of
+configurations (e.g. -smp drawers=1,books=1,clusters=1 for x86 PC machine) is
+marked depresated since 9.0, users have to ensure that all the topology members
+described with -smp are supported by the target machine.
+
 QEMU Machine Protocol (QMP) commands
 ------------------------------------
 
diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
index 96533886b14e..50a5a40dbc3d 100644
--- a/hw/core/machine-smp.c
+++ b/hw/core/machine-smp.c
@@ -112,30 +112,61 @@ void machine_parse_smp_config(MachineState *ms,
 
     /*
      * If not supported by the machine, a topology parameter must be
-     * omitted or specified equal to 1.
+     * omitted.
      */
-    if (!mc->smp_props.dies_supported && dies > 1) {
-        error_setg(errp, "dies not supported by this machine's CPU topology");
-        return;
-    }
-    if (!mc->smp_props.clusters_supported && clusters > 1) {
-        error_setg(errp, "clusters not supported by this machine's CPU topology");
-        return;
+    if (!mc->smp_props.clusters_supported && config->has_clusters) {
+        if (config->clusters > 1) {
+            error_setg(errp, "clusters not supported by this "
+                       "machine's CPU topology");
+            return;
+        } else {
+            /* Here clusters only equals 1 since we've checked zero case. */
+            warn_report("Deprecated CPU topology (considered invalid): "
+                        "Unsupported clusters parameter mustn't be "
+                        "specified as 1");
+        }
     }
+    clusters = clusters > 0 ? clusters : 1;
 
+    if (!mc->smp_props.dies_supported && config->has_dies) {
+        if (config->dies > 1) {
+            error_setg(errp, "dies not supported by this "
+                       "machine's CPU topology");
+            return;
+        } else {
+            /* Here dies only equals 1 since we've checked zero case. */
+            warn_report("Deprecated CPU topology (considered invalid): "
+                        "Unsupported dies parameter mustn't be "
+                        "specified as 1");
+        }
+    }
     dies = dies > 0 ? dies : 1;
-    clusters = clusters > 0 ? clusters : 1;
 
-    if (!mc->smp_props.books_supported && books > 1) {
-        error_setg(errp, "books not supported by this machine's CPU topology");
-        return;
+    if (!mc->smp_props.books_supported && config->has_books) {
+        if (config->books > 1) {
+            error_setg(errp, "books not supported by this "
+                       "machine's CPU topology");
+            return;
+        } else {
+            /* Here books only equals 1 since we've checked zero case. */
+            warn_report("Deprecated CPU topology (considered invalid): "
+                        "Unsupported books parameter mustn't be "
+                        "specified as 1");
+        }
     }
     books = books > 0 ? books : 1;
 
-    if (!mc->smp_props.drawers_supported && drawers > 1) {
-        error_setg(errp,
-                   "drawers not supported by this machine's CPU topology");
-        return;
+    if (!mc->smp_props.drawers_supported && config->has_drawers) {
+        if (config->drawers > 1) {
+            error_setg(errp, "drawers not supported by this "
+                       "machine's CPU topology");
+            return;
+        } else {
+            /* Here drawers only equals 1 since we've checked zero case. */
+            warn_report("Deprecated CPU topology (considered invalid): "
+                        "Unsupported drawers parameter mustn't be "
+                        "specified as 1");
+        }
     }
     drawers = drawers > 0 ? drawers : 1;
 
-- 
2.34.1


