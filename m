Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB85D1170E
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 16:41:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQTQh-0000xJ-9y; Tue, 02 Dec 2025 11:40:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQTQW-0000wM-Iq
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:40:32 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQTQT-0001kv-3D
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:40:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764693628; x=1796229628;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=/C7u1XHqkgv5wmurxvpA9yZisW+DTSvc6nN/Z0y4L4g=;
 b=HE5sCjDK4J10hBGLRwgI4ms2JGDOMEdk3mvnK8Bsp436Wgs4PDb35Rbh
 vOt7zdDn8aeg+SbteLZtL3+Q3Rk/XtUembe4TtOlxX5qYtaMchtmq+ZVI
 iwf+V29E1RuBRHCqtun3HHHGaOcjzDJxhapio/ANn756n5aWRWO0Xdggx
 MRrEcyBExID4futmlIC4UYqD5M52DDTm9OfpeUajbnir6NkXG7+jEysHe
 taV4X+ehNhR7+TSQ3qyr3iB3SAnzJ+dC+XD5o6TQNixBTOVOnySfk6CwG
 Wt6laHkYpplh2N3OSEmRSb761YGzZ5MCN6JnCjdq1+laVbe1+Cc5N7D65 w==;
X-CSE-ConnectionGUID: Ebya+j3YSwm5lTroyeXPsQ==
X-CSE-MsgGUID: dAmsqptGT5KrZKr/ZlNAEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="66555284"
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; d="scan'208";a="66555284"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2025 08:40:26 -0800
X-CSE-ConnectionGUID: ZrL74tyoS+ymLDS+SWv9hg==
X-CSE-MsgGUID: /5Om67y9SOWwkjO+rK0Y7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; d="scan'208";a="231751183"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 02 Dec 2025 08:40:23 -0800
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
Subject: [RFC 00/10] qom: Support marking object properties as deprecated
Date: Wed,  3 Dec 2025 01:04:52 +0800
Message-Id: <20251202170502.3228625-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
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

Hi,

This RFC is the follow-up work of v2.6 & v2.7 machines' removal [*], and
tries to introduce a general way to provide deprecation hint for
external user.

Its core idea is to detect external property settings (as well as
specific internal property settings, such as the compat property).

I think deprecated properties and internal-only properties are quite
similar, as both require consideration of external property usage. But
the former only triggers a warning, while the latter stops all external
access attempts.

For simplicity, this RFC series only considers deprecated properties.


Brief Introduction
==================

Now the common (but a bit fragmented) way to mark a property deprecated
is to add the warning in its accssors, or just document the deprecation
in docs/about/deprecated.rst without any hint when someone touches that
property.

Ideally, it's better to provide some hints to external user when he
tries to set the property via command line or HMP.

But this is pretty inconvenient (even impossible) for such qdev
properties, which are defined via DEFINE_PROP_* macros in the Property
array. For qdev properties, their accessors are provided by pre-defined
PropertyInfo, so that it's possible to modify PropertyInfo for a single
"deprecated" property.

Then it's necessary to introduce property flags to mark some properties
as deprecated, and to check the property flags when set the property,
thereby to print a deprecation warning.

This not only benefits traditional qdev properties but also helps the
deprecation of generic objects.

Note, internal attempt (except the compat case) should not trigger the
deprecation warning but external user should see the deprecation
information.

I think the most complex part is identifying the paths for property
settings (both external command-line options and internal specific
configurations). This series currently covers the following scenarios
(which I consider to be particularly important):

External cases:

 1) External global properties:
    * -global command line option.
    * -cpu command line features.
    * suger properties from object_compat_props[2]

 2) External ("TYPE_USER_CREATABLE") object:
    * -object command line used for external ("TYPE_USER_CREATABLE")
      object.

 3) External device:
    * -device command line - parsed based on keyval or json.

 4) External machine options:
    * -machine command line - parsed based on keyval.

 5) External accelerator options:
    * -accel command line.

 6) HMP command:
    * "qom-set" command.


Internal cases:
 1) internal global properties:
    * compat properties from object_compat_props[0,1].

 2) Internal machine options:
    * Builtin default machine options string:
      MachineClass::default_machine_opts - parsed based on keyval, too.


In fact, there are still some special device command lines that haven't
been considered yet. But I believe the remaining cases can be gradually
expanded?

If this approach is feasible, it's possible to further introduce an
"internal" flag to prevent external access to compat property.


[*]: hw/i386/pc: Remove deprecated 2.6 and 2.7 PC machines
     https://lore.kernel.org/qemu-devel/20251202162835.3227894-1-zhao1.liu@intel.com/

Thanks and Best Regards,
Zhao
---
Zhao Liu (10):
  qom: Rename ObjectPropertyFlags to ObjectPropertyAccessorFlags
  qom: Add basic object property deprecation hint support
  qom: Check property deprecation flag for global property
  qom: Check property deprecation flag for properities from qdict
  system/vl: Check property deprecation flag for properities of
    accelerator
  qom/qom-hmp-cmd: Check property deprecation flag for "qom-set" command
  hw/core/qdev-properties: Allow to mark qdev property as deprecated
  target/i386: Deprecate fill-mtrr-mask property
  target/i386: Deprecate cpuid-0xb property
  hw/intc/ioapic: Deprecate version property

 docs/about/deprecated.rst    |  31 +++++++++
 hw/core/qdev-properties.c    |  24 +++----
 hw/intc/ioapic.c             |   3 +-
 include/hw/qdev-properties.h |  18 ++++++
 include/qom/object.h         | 120 +++++++++++++++++++++++++++++++----
 qom/object.c                 | 101 ++++++++++++++++++++++-------
 qom/object_interfaces.c      |   2 +-
 qom/qom-hmp-cmds.c           |   2 +-
 system/vl.c                  |   2 +-
 target/i386/cpu.c            |   4 +-
 10 files changed, 253 insertions(+), 54 deletions(-)

-- 
2.34.1


