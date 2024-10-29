Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B333ED5B170
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 08:44:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5hp6-0002yP-UG; Tue, 29 Oct 2024 04:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t5hp5-0002yF-G7
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 04:43:31 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t5hp2-00081u-V3
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 04:43:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730191409; x=1761727409;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=IV4WAegibAS+UAKVxOis9RjDvyidOF8SEP2kN4jecmA=;
 b=S8whtPY+EVoBHhAwETOS3xpLXiZlkaUkMCmlfNZAzJrxQYMPnkK+hWvL
 jQV3RfY7jz2xmkhrooZybtS5Qaqi903SyCiCIK5nChmioNf/RD3aBXUYY
 lIq/nYKp/60fbct50FHjQ1xtnGGzfxOnejLPX2e+q+WA/HlkQprlYd5Wo
 EnilS6IPQqwjFcvEjnwYG+i+5s3y+iUN+poSznaL8jmmk+/yosUY02r0l
 ATqOCWmKxaL4rAMhDRjYdSjbToUDyPtzFF6bPLOKmwLkK0oRBiaC2o5Dx
 jfjwSHcSMYua4MluAFOlHo9lNUInWA1jWP/eZ7h94Nw9v7jQyX3V/P/AS w==;
X-CSE-ConnectionGUID: dkc+k1IeSFGvKH5d2qWHpg==
X-CSE-MsgGUID: NVdPBQ7GSfCUx+/gTtPlRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29592765"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="29592765"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2024 01:43:24 -0700
X-CSE-ConnectionGUID: yV1aO2YDSs+pIKIvwD+Cvg==
X-CSE-MsgGUID: RNjehk3vSH6r0jKVRqNCig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; d="scan'208";a="85847097"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 29 Oct 2024 01:43:22 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 00/16] qom/object: Deprecate type_register()
Date: Tue, 29 Oct 2024 16:59:18 +0800
Message-Id: <20241029085934.2799066-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi maintainers,

This series is trying to deprecate type_register() and just keep
type_register_static() to register QOM type.

This series chosen to deprecate type_register() since changes required
to deprecate type_register() are smaller. (type_register_static() needs
1000+ LOC changes.)

The two main changes are patch 15 and 16, while the others are trivial
replacements.

This series is based on commit fdf250e5a37830 ("Merge tag
'pull-maintainer-oct-misc-241024-1' of https://gitlab.com/stsquad/qemu
into staging").


Introduction
============

The type_register() and type_register_static() have existed since the
birth of QOM (commit 2f28d2ff9dce ("qom: add the base Object class
(v2)")).

In the code implementation, type_register_static() has always been just
a wrapper around type_register(), and they are essentially the same.

The only difference between them is described in the documentation 
(include/qom/object.h):

* type_register_static()

> @info and all of the strings it points to should exist for the life time
> that the type is registered.

* type_register()

> Unlike type_register_static(), this call does not require @info or its
> string members to continue to exist after the call returns.

From the documentation, the difference between these two interfaces
arises from the lifetime of 2 cases:

1. the strings contained in the TypeInfo parameter.

The *_static variant requires the strings to have a long lifetime
(static).

I reviewed the discussions on the mailing list about the QOM v1 patch
[1], and I understand that the consideration for static is due to
Anthony's idea that in certain cases, the string field could be "const
char *", allowing the address to be directly copied to the created
Type/TypeImpl.

However, this consideration seems unnecessary in the merged v2 version,
as Anthony followed Paolo's suggestion to pass all string fields by
copying them via g_strdup() to the created TypeImple. This remains true
to this day.

[1]: https://lore.kernel.org/qemu-devel/4EF1EEA4.40209@us.ibm.com/


2. the function pointer and a special item called "class_data" in
TypeInfo

I suppose that there are currently no lifetime issues about these items
in QEMU, as neither type_register() nor type_register_static()
explicitly checks whether the parameters are static. If there were any
issues, they would likely be easily detected.

Furthermore, I haven't seen any preference for these items in the usage
of type_register() and type_register_static().


Based on points 1 and 2, I think it is sufficient to explain that
type_register() and type_register_static() are redundant in usage and do
not require distinction. Additionally, since they are consistent in the
code, it is safe to deprecate either one.

Since the changes required to deprecate type_register() are smaller,
choose to deprecate type_register() and delete the requirement about
string lifetime from the documentation.


Thanks and Best Regards,
Zhao
---
Zhao Liu (16):
  arm: Replace type_register() with type_register_static()
  hw/block: Replace type_register() with type_register_static()
  hw/net: Replace type_register() with type_register_static()
  ppc: Replace type_register() with type_register_static()
  hw/rtc: Replace type_register() with type_register_static()
  hw/scsi: Replace type_register() with type_register_static()
  hw/sensor: Replace type_register() with type_register_static()
  hw/usb: Replace type_register() with type_register_static()
  hw/virtio: Replace type_register() with type_register_static()
  i386: Replace type_register() with type_register_static()
  target/mips: Replace type_register() with type_register_static()
  target/sparc: Replace type_register() with type_register_static()
  target/xtensa: Replace type_register() with type_register_static()
  ui: Replace type_register() with type_register_static()
  script/codeconverter/qom_type_info: Deprecate MakeTypeRegisterStatic
    and MakeTypeRegisterNotStatic
  qom/object: Deprecate type_register()

 hw/arm/armsse.c                               |  2 +-
 hw/arm/smmuv3.c                               |  4 ++--
 hw/block/m25p80.c                             |  2 +-
 hw/net/e1000.c                                |  2 +-
 hw/net/eepro100.c                             |  2 +-
 hw/ppc/spapr.c                                |  2 +-
 hw/rtc/m48t59-isa.c                           |  2 +-
 hw/rtc/m48t59.c                               |  2 +-
 hw/scsi/megasas.c                             |  2 +-
 hw/scsi/mptsas.c                              |  2 +-
 hw/sensor/tmp421.c                            |  2 +-
 hw/usb/hcd-ehci-pci.c                         |  2 +-
 hw/usb/hcd-uhci.c                             |  2 +-
 hw/virtio/virtio-pci.c                        |  8 ++++----
 include/hw/i386/pc.h                          |  4 ++--
 include/qom/object.h                          | 14 -------------
 qom/object.c                                  |  7 +------
 .../codeconverter/qom_type_info.py            | 20 -------------------
 target/arm/cpu.c                              |  2 +-
 target/arm/cpu64.c                            |  2 +-
 target/i386/cpu.c                             |  2 +-
 target/mips/cpu.c                             |  2 +-
 target/ppc/kvm.c                              |  2 +-
 target/sparc/cpu.c                            |  2 +-
 target/xtensa/helper.c                        |  2 +-
 ui/console-vc.c                               |  2 +-
 ui/dbus.c                                     |  2 +-
 ui/gtk.c                                      |  2 +-
 ui/spice-app.c                                |  2 +-
 29 files changed, 32 insertions(+), 71 deletions(-)

-- 
2.34.1


