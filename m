Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4416D1170E
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 16:41:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQTR9-0001Ox-SH; Tue, 02 Dec 2025 11:41:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQTR2-0001Co-FG
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:41:05 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQTR0-0002FS-Q7
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:41:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764693662; x=1796229662;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qOKjCAtqtAm/6XWCHVrwryYKG3D/GYbe6E3AbYog1nQ=;
 b=CN6LOUoYMmJCRxzx45we1NZ+uNT33qJ72Ev0ZY8X8JJ/809CxVMs9+PL
 QosQAu1UO/Crgq1hEWZ/eHMf+d0X7rUXEjo+RmTyKXMRbk49TUc5d0IRM
 b+pZO0riYi8G5PQCcRFEA6J7XtyW+q/HZ8tAPX3ovKxlNI1StqabhQDTj
 vvPoCMXyuX0Pb08guk78IhiHdrV8KoRsvuLjNCBhCxDq1nIUdrb/smAT9
 k1Vc4Jn2qKJ5mMKckNg0eUr/yu3tSfEqbbiNKWKCmZLLJb5Xhos27RirW
 JJGiS0VpswE+qSqT24cySL+imD0nY+8ibjoDgihX3kU9L5V4uL8VifI1K A==;
X-CSE-ConnectionGUID: y0sapYteT9uWWtV3i0i9ig==
X-CSE-MsgGUID: poifVCYFTCu308oq9SFLAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="66555413"
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; d="scan'208";a="66555413"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2025 08:41:01 -0800
X-CSE-ConnectionGUID: s8q5CRv2Rau/r0OjKyOOuQ==
X-CSE-MsgGUID: y77f/wUfQbKBVPnI+znA6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; d="scan'208";a="231751459"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 02 Dec 2025 08:40:59 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, devel@lists.libvirt.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 10/10] hw/intc/ioapic: Deprecate version property
Date: Wed,  3 Dec 2025 01:05:02 +0800
Message-Id: <20251202170502.3228625-11-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251202170502.3228625-1-zhao1.liu@intel.com>
References: <20251202170502.3228625-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
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

"version" was previously set to "0x11" for v2.7 x86 machines, but v2.7
machines have been removed. And since v2.8, all x86 machines are using
IOAPIC with "0x20" version. So it should be not needed to configure the
version back to "0x11" again.

Considerring it may have external use, so deprecate it before removal.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 docs/about/deprecated.rst | 13 +++++++++++++
 hw/intc/ioapic.c          |  3 ++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 741c1a71728b..076940ad0826 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -522,6 +522,19 @@ It was implemented as a no-op instruction in TCG up to QEMU 9.0, but
 only with ``-cpu max`` (which does not guarantee migration compatibility
 across versions).
 
+
+Global options
+--------------
+
+``-device -global ioapic.version=version_id`` (since 11.0)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
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
index 38e438464861..45fdfb56636b 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -483,7 +483,8 @@ static void ioapic_unrealize(DeviceState *dev)
 }
 
 static const Property ioapic_properties[] = {
-    DEFINE_PROP_UINT8("version", IOAPICCommonState, version, IOAPIC_VER_DEF),
+    DEFINE_PROP_UINT8_DEPRECATED("version", IOAPICCommonState,
+                                  version, IOAPIC_VER_DEF),
 };
 
 static void ioapic_class_init(ObjectClass *klass, const void *data)
-- 
2.34.1


