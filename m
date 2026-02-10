Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D955E9462C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 03:00:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpdyZ-0000Qi-F6; Mon, 09 Feb 2026 21:59:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vpdyS-0008CQ-0s
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:59:39 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vpdyQ-0004En-Cm
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:59:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770692374; x=1802228374;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9LTRFVx1MfhNyW7FER5k/YNTnETyxDx/pDfTCZ5rO5U=;
 b=M9h5yRoKs/g9ti0RY+ugkQMt7LEpIvNribS92GNBvgkDfk9VgR3mtPx8
 xMgCM8q5ZxccGEkGLZiFN2yCugZm/2HDI40A7o9Z7ANQAaPmtySxmMzd3
 E2dI39E63rBVA5EhXmlV6VAb8EsysPfaog/W1lELSODonsmWABxNxCVFD
 3ySvBZf5YbLamVdExpW7fY1aeQZOarXVLZYkSJhLtELCBh8cReqFDF+CB
 5/f/npN+Jm2AzWi6Y/CRAgSVu+P4o0SskoZ973Q3z3ojP8PFjcWjNpA2B
 z085p9XW3Q36XusIi7tW1gjlq87iB9rCH7VpSY0qx4Tpjuf33gb00Ke5g g==;
X-CSE-ConnectionGUID: l5vZ55brTf+gzS0uA4AlvQ==
X-CSE-MsgGUID: iKcqusXbTEihyEj6iXxwLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="75659982"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="75659982"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 18:59:33 -0800
X-CSE-ConnectionGUID: 2mxHVZ+lTdGgR7ljJFKiYg==
X-CSE-MsgGUID: 8aDixjShRO22WY9VDJIhhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211800737"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 09 Feb 2026 18:59:30 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zide Chen <zide.chen@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-devel@nongnu.org,
 devel@lists.libvirt.org
Subject: [PATCH v2 17/21] hw/intc/ioapic: deprecate version property
Date: Tue, 10 Feb 2026 11:23:44 +0800
Message-Id: <20260210032348.987549-18-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260210032348.987549-1-zhao1.liu@intel.com>
References: <20260210032348.987549-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

"version" was previously set to "0x11" for v2.7 x86 machines, but v2.7
machines have been deprecated and will be removed.

And since v2.8, all x86 machines are using IOAPIC with "0x20" version.
So it should be not needed to configure the version back to "0x11"
again.

Considerring it may have external use, so deprecate it before removal.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 docs/about/deprecated.rst | 13 +++++++++++++
 hw/intc/ioapic.c          |  3 ++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index fed939b7f042..dac1940636a6 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -483,6 +483,19 @@ It was implemented as a no-op instruction in TCG up to QEMU 9.0, but
 only with ``-cpu max`` (which does not guarantee migration compatibility
 across versions).
 
+
+Global options
+--------------
+
+``-global ioapic.version=version_id`` (since 11.0)
+''''''''''''''''''''''''''''''''''''''''''''''''''
+
+The ``version`` configures IOAPIC version for x86 machines. It was previously
+set to ``0x11`` for v2.7 machines, and since v2.8, the default version is
+bumped up to ``0x20``. The v2.7 machines have been removed, and ``0x11``
+version should be not needed. Deprecate this property to stop external use.
+
+
 Backwards compatibility
 -----------------------
 
diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index 98de6ca8108f..3bf21f421a71 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -483,7 +483,8 @@ static void ioapic_unrealize(DeviceState *dev)
 }
 
 static const Property ioapic_properties[] = {
-    DEFINE_PROP_UINT8("version", IOAPICCommonState, version, IOAPIC_VER_DEF),
+    DEFINE_PROP_UINT8("version", IOAPICCommonState, version, IOAPIC_VER_DEF,
+                      .flags = OBJ_PROP_FLAG_DEPRECATED),
 };
 
 static void ioapic_class_init(ObjectClass *klass, const void *data)
-- 
2.34.1


