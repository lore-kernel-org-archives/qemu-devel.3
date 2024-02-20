Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E80E8C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 09:13:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcMB0-0001Dh-6m; Tue, 20 Feb 2024 04:12:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rcMAy-00012Z-2d; Tue, 20 Feb 2024 04:12:32 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rcMAw-0003Tv-0l; Tue, 20 Feb 2024 04:12:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708420350; x=1739956350;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=L0AbdOq+EtfWgzb7EW1UTRtjP/6zXcB3r698FBuEvgE=;
 b=GotJBlCOWiDbORUrFW9FJJP0MFSK+B1f7F/ibCay2WDFrsCEYfL7Lu5Q
 Se71/DNobx7db5OmZ4L0NsuLWLnY4VFS13qRPSd7cNZ6MSn+QhfoGAnbD
 MXm8Je/oAlVQuC6zHwsKn43f+y1c8syzoXjAEnbx65JU/GWMx8Dg3ygRx
 lgdj8WuCplKH+7UXhD8PhWiyXy0A26GZeyOgkdfSL/oYx5TXcO2WP+XjA
 ca87IWVT/J7yFJH22wkwuSonvWg3z0wjd+d5EzCIAmHkkV/hLpHj/aQ5z
 QdCxAx6DWBH7zcQKoyS0t5dlRcsjaYbWR1AeE94/eVgOtPHf6vvVaPVBl A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2375048"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="2375048"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2024 01:12:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="5013156"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa007.jf.intel.com with ESMTP; 20 Feb 2024 01:12:23 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 8/8] qemu-options: Add the cache topology description of -smp
Date: Tue, 20 Feb 2024 17:25:04 +0800
Message-Id: <20240220092504.726064-9-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220092504.726064-1-zhao1.liu@linux.intel.com>
References: <20240220092504.726064-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.17;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
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

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 qemu-options.hx | 54 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 47 insertions(+), 7 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 70eaf3256685..85c78c99a3b0 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -281,7 +281,9 @@ ERST
 
 DEF("smp", HAS_ARG, QEMU_OPTION_smp,
     "-smp [[cpus=]n][,maxcpus=maxcpus][,drawers=drawers][,books=books][,sockets=sockets]\n"
-    "               [,dies=dies][,clusters=clusters][,cores=cores][,threads=threads]\n"
+    "               [,dies=dies][,clusters=clusters][,modules=modules][,cores=cores]\n"
+    "               [,threads=threads][,l1d-cache=level][,l1i-cache=level][,l2-cache=level]\n"
+    "               [,l3-cache=level]\n"
     "                set the number of initial CPUs to 'n' [default=1]\n"
     "                maxcpus= maximum number of total CPUs, including\n"
     "                offline CPUs for hotplug, etc\n"
@@ -290,9 +292,14 @@ DEF("smp", HAS_ARG, QEMU_OPTION_smp,
     "                sockets= number of sockets in one book\n"
     "                dies= number of dies in one socket\n"
     "                clusters= number of clusters in one die\n"
-    "                cores= number of cores in one cluster\n"
+    "                modules= number of modules in one cluster\n"
+    "                cores= number of cores in one module\n"
     "                threads= number of threads in one core\n"
-    "Note: Different machines may have different subsets of the CPU topology\n"
+    "                l1d-cache= topology level of L1 D-cache\n"
+    "                l1i-cache= topology level of L1 I-cache\n"
+    "                l2-cache= topology level of L2 cache\n"
+    "                l3-cache= topology level of L3 cache\n"
+    "Note: Different machines may have different subsets of the CPU and cache topology\n"
     "      parameters supported, so the actual meaning of the supported parameters\n"
     "      will vary accordingly. For example, for a machine type that supports a\n"
     "      three-level CPU hierarchy of sockets/cores/threads, the parameters will\n"
@@ -306,7 +313,7 @@ DEF("smp", HAS_ARG, QEMU_OPTION_smp,
     "      must be set as 1 in the purpose of correct parsing.\n",
     QEMU_ARCH_ALL)
 SRST
-``-smp [[cpus=]n][,maxcpus=maxcpus][,sockets=sockets][,dies=dies][,clusters=clusters][,cores=cores][,threads=threads]``
+``-smp [[cpus=]n][,maxcpus=maxcpus][,drawers=drawers][,books=books][,sockets=sockets][,dies=dies][,clusters=clusters][,modules=modules][,cores=cores][,threads=threads][,l1d-cache=level][,l1i-cache=level][,l2-cache=level][,l3-cache=level]``
     Simulate a SMP system with '\ ``n``\ ' CPUs initially present on
     the machine type board. On boards supporting CPU hotplug, the optional
     '\ ``maxcpus``\ ' parameter can be set to enable further CPUs to be
@@ -320,15 +327,34 @@ SRST
     Both parameters are subject to an upper limit that is determined by
     the specific machine type chosen.
 
+    CPU topology parameters include '\ ``drawers``\ ', '\ ``books``\ ',
+    '\ ``sockets``\ ', '\ ``dies``\ ', '\ ``clusters``\ ', '\ ``modules``\ ',
+    '\ ``cores``\ ' and '\ ``threads``\ '. These CPU parameters accept only
+    integers and are used to specify the number of specific topology domains
+    under the corresponding topology level.
+
     To control reporting of CPU topology information, values of the topology
     parameters can be specified. Machines may only support a subset of the
-    parameters and different machines may have different subsets supported
-    which vary depending on capacity of the corresponding CPU targets. So
-    for a particular machine type board, an expected topology hierarchy can
+    CPU topology parameters and different machines may have different subsets
+    supported which vary depending on capacity of the corresponding CPU targets.
+    So for a particular machine type board, an expected topology hierarchy can
     be defined through the supported sub-option. Unsupported parameters can
     also be provided in addition to the sub-option, but their values must be
     set as 1 in the purpose of correct parsing.
 
+    Cache topology parameters include '\ ``l1d-cache``\ ', '\ ``l1i-cache``\ ',
+    '\ ``l2-cache``\ ' and '\ ``l3-cache``\ '. These cache topology parameters
+    accept the strings of CPU topology levels (such as '\ ``drawer``\ ', '\ ``book``\ ',
+    '\ ``socket``\ ', '\ ``die``\ ', '\ ``cluster``\ ', '\ ``module``\ ',
+    '\ ``core``\ ' or '\ ``thread``\ '). Exactly which topology level strings
+    could be accepted as the parameter depends on the machine's support for the
+    corresponding CPU topology level.
+
+    Machines may also only support a subset of the cache topology parameters.
+    Unsupported cache topology parameters will be omitted, and correspondingly,
+    the target CPU's cache topology will use the its default cache topology
+    setting.
+
     Either the initial CPU count, or at least one of the topology parameters
     must be specified. The specified parameters must be greater than zero,
     explicit configuration like "cpus=0" is not allowed. Values for any
@@ -354,6 +380,20 @@ SRST
 
         -smp 32,sockets=2,dies=2,modules=2,cores=2,threads=2,maxcpus=32
 
+    The following sub-option defines a CPU topology hierarchy (2 sockets
+    totally on the machine, 2 dies per socket, 2 modules per die, 2 cores per
+    module, 2 threads per core) with 3-level cache topology hierarchy (L1
+    D-cache per core, L1 I-cache per core, L2 cache per core and L3 cache per
+    die) for PC machines which support sockets/dies/modules/cores/threads.
+    Some members of the CPU topology option can be omitted but their values
+    will be automatically computed. Some members of the cache topology
+    option can also be omitted and target CPU will use the default topology.:
+
+    ::
+
+        -smp 32,sockets=2,dies=2,modules=2,cores=2,threads=2,maxcpus=32,\
+             l1d-cache=core,l1i-cache=core,l2-cache=core,l3-cache=die
+
     The following sub-option defines a CPU topology hierarchy (2 sockets
     totally on the machine, 2 clusters per socket, 2 cores per cluster,
     2 threads per core) for ARM virt machines which support sockets/clusters
-- 
2.34.1


