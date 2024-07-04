Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83DD1C31D97
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 03:02:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPCiz-0004lZ-PH; Wed, 03 Jul 2024 23:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sPCii-0004SR-QD; Wed, 03 Jul 2024 23:01:23 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sPCih-00040P-0L; Wed, 03 Jul 2024 23:01:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720062075; x=1751598075;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7xazZwz0EnajiB5Y3BpYOkdjmqrqDIqJeO1R5Tf6FMU=;
 b=gDNXJcOXBOlqJKQ+bZ2X0cORPwvbXtvZItGOzBQlHABryeCmq3mtnCsO
 E8JQD/d1oxtW04nXKOFqlrCJEvr3KYbq+mpp14kKUQcx/Aw5XpphXQkyJ
 djwbWFXq4sqDpy+FR/Q7BluGsO/pBDbHfLe0Jfz3857KvCY8yf7vhwFLP
 jNDvD5PZK6hyBt1SPyuH6LYyQaE3IHj73sUUuBZAJ0nsqEEwF2tTSJ1UV
 0fMi3PBZEobxrobE+HIWPPv/JAGPqXm44IKJA7igMggnwYr0HdiofSpEe
 XpAPscunJpOcwVSc4fQEKDZQe49DxAZvf+30P18s8SM6N4zbiMAO+Eh4A w==;
X-CSE-ConnectionGUID: 6T0oVediSsW4lHPdbrQg8Q==
X-CSE-MsgGUID: RbKQ5RxzRpu5n4zLQZju7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="39838169"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; d="scan'208";a="39838169"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2024 20:01:13 -0700
X-CSE-ConnectionGUID: uK+DmRjmRO6RTIeeRo8L0Q==
X-CSE-MsgGUID: PAO0ufSFQueLjRECY+D3Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; d="scan'208";a="51052503"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa004.fm.intel.com with ESMTP; 03 Jul 2024 20:01:08 -0700
From: Zhao Liu <zhao1.liu@intel.com>
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
Subject: [PATCH 8/8] qemu-options: Add the description of smp-cache object
Date: Thu,  4 Jul 2024 11:16:03 +0800
Message-Id: <20240704031603.1744546-9-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240704031603.1744546-1-zhao1.liu@intel.com>
References: <20240704031603.1744546-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since RFC v2:
 * Rewrote the document of smp-cache object.

Changes since RFC v1:
 * Use "*_cache=topo_level" as -smp example as the original "level"
   term for a cache has a totally different meaning. (Jonathan)
---
 qemu-options.hx | 58 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index 8ca7f34ef0c8..4b84f4508a6e 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -159,6 +159,15 @@ SRST
         ::
 
             -machine cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=128G,cxl-fmw.0.interleave-granularity=512
+
+    ``smp-cache='id'``
+        Allows to configure cache property (now only the cache topology level).
+
+        For example:
+        ::
+
+            -object '{"qom-type":"smp-cache","id":"cache","caches":[{"name":"l1d","topo":"core"},{"name":"l1i","topo":"core"},{"name":"l2","topo":"module"},{"name":"l3","topo":"die"}]}'
+            -machine smp-cache=cache
 ERST
 
 DEF("M", HAS_ARG, QEMU_OPTION_M,
@@ -5871,6 +5880,55 @@ SRST
         ::
 
             (qemu) qom-set /objects/iothread1 poll-max-ns 100000
+
+    ``-object '{"qom-type":"smp-cache","id":id,"caches":[{"name":cache_name,"topo":cache_topo}]}'``
+        Create an smp-cache object that configures machine's cache
+        property. Currently, cache property only include cache topology
+        level.
+
+        This option must be written in JSON format to support JSON list.
+
+        The ``caches`` parameter accepts a list of cache property in JSON
+        format.
+
+        A list element requires the cache name to be specified in the
+        ``name`` parameter (currently ``l1d``, ``l1i``, ``l2`` and ``l3``
+        are supported). ``topo`` parameter accepts CPU topology levels
+        including ``thread``, ``core``, ``module``, ``cluster``, ``die``,
+        ``socket``, ``book``, ``drawer`` and ``default``. The ``topo``
+        parameter indicates CPUs winthin the same CPU topology container
+        are sharing the same cache.
+
+        Some machines may have their own cache topology model, and this
+        object may override the machine-specific cache topology setting
+        by specifying smp-cache object in the -machine. When specifying
+        the cache topology level of ``default``, it will honor the default
+        machine-specific cache topology setting. For other topology levels,
+        they will override the default setting.
+
+        An example list of caches to configure the cache model (l1d cache
+        per core, l1i cache per core, l2 cache per module and l3 cache per
+        socket) supported by PC machine might look like:
+
+        ::
+
+              {
+                "caches": [
+                   { "name": "l1d", "topo": "core" },
+                   { "name": "l1i", "topo": "core" },
+                   { "name": "l2", "topo": "module" },
+                   { "name": "l3", "topo": "socket" },
+                ]
+              }
+
+        An example smp-cache object would look like:()
+
+        .. parsed-literal::
+
+             # |qemu_system| \\
+                 ... \\
+                 -object '{"qom-type":"smp-cache","id":id,"caches":[{"name":cache_name,"topo":cache_topo}]}' \\
+                 ...
 ERST
 
 
-- 
2.34.1


