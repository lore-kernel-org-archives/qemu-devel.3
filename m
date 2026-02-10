Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A8BEE9462B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 02:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpdxH-00061C-Ix; Mon, 09 Feb 2026 21:58:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vpdxF-00060X-7K
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:58:21 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vpdxC-00045e-5A
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:58:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770692298; x=1802228298;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=MBWhbuEMR6Y77nJEzexrdp7Mno+tXNDIxsjfWWTPNCA=;
 b=oBucaVKZ8IMTYPUYwh05viocavydC7ia5NEeTXwo4PYQyBl5Pzeky/0a
 zIWQx6NT1NO/4bXG/uJx7XS2oI6TmYvFNFq65J9vdJo2oC8w3pp0qYaLA
 C10/p0ytAz0ZekjL7J3+HMdp5QeDP5IKQtBBOjbuFbdDLLaMPl8rNYJyj
 Pm5CozswYjPZdrMEIqwBQiQ8vB7fQ5LukuCuFPimYymNW+WFAjwINfNI5
 iBNxPzd3j0PTORSOKFQtUD2fJoXnT1dXsMHVXIURQYJYx7LeKxEMfzYmh
 LAl6d/lpXeaMiCkUpDoMQsQ0Be6KJm5Qk5u6EQpk3XHF7/LtI75dXkdT/ Q==;
X-CSE-ConnectionGUID: NZcmfSwmTKGj5igw4OC2pQ==
X-CSE-MsgGUID: gReANuMnT524cAVk9OIwHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71854202"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="71854202"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 18:58:14 -0800
X-CSE-ConnectionGUID: Oj5cZtgsT8eulW6/KvlAhA==
X-CSE-MsgGUID: 4rbwkhmQRP6Werqvt4M86A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211800388"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 09 Feb 2026 18:58:09 -0800
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
Subject: [PATCH v2 00/21] qom: introduce property flags to track external user
 input
Date: Tue, 10 Feb 2026 11:23:27 +0800
Message-Id: <20260210032348.987549-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi,

This is the v2 trying to introduce property flags to detect user's
property setting (from CLI/QMP/HMP). I dropped RFC tag since previous
RFC v1 [1].

Though this work the follow-up of v2.6 & v2.7 machines' removal [2],
now it is decoupled from [2] totally since v2 doesn't detect compat
property and only focuses on external user setting, so this series is
based on master branch at the commit 28a6ca268c2c ("Merge tag 'single-
binary-20260203' of https://github.com/philmd/qemu into staging"). And
you can also find the code here:

https://gitlab.com/zhao.liu/qemu/-/tree/prop-flags-v2.3-02-08-2026

This series introduces 3 property flags:
 * USER_SET:
   Any external user property setting (from CLI/HMP/QMP) is marked as
   USER_SET.
 * DEPRECATED:
   Once a property is marked as DEPRECATED, any external user property
   setting will trigger a warning.
 * INTERNAL:
   Once a  property is marked as INTERNAL, any external user property
   setting will cause an error.

More details or document for these 3 flags, you can refer patch 7.


Compared with RFC v1, v2 mainly:
 * introduce USER_SET property flag to identify all user's setting.
   - patch 7 for document.
 * construct DEPRECATED & INTERNAL flag on USER_SET.
   - patch 7 for document.
 * cover more comprehensive user set cases.
   - patch 8-13.
 * provide examples about new flags (USER_SET/DEPRECATED/INTELNAL).
   - patch 15/16/17 are examples for DEPRECATED flag.
   - patch 18 is the example for INTERNAL flag.
   - patch 20 is the example for USER_SET flag.

I think v2 should now cover "nearly" all cases (patch 8-13) where users
set properties: one approach is to trace the call chain of
object_property_set().

Even if there are cases that were missed, they can be easily addressed
based on this series:

  object_property_set(obj, ...);
  /* Insert this call after object_property_set(). */
  object_property_set_flags(obj, ..., OBJ_PROP_FLAG_USER_SET, ...);

[1]: RFC v1:
     https://lore.kernel.org/qemu-devel/20251202170502.3228625-1-zhao1.liu@intel.com/
[2]: hw/i386/pc: Remove deprecated 2.6 and 2.7 PC machines
     https://lore.kernel.org/qemu-devel/20260108033051.777361-1-zhao1.liu@intel.com/

Thanks and Best Regards,
Zhao
---
Zhao Liu (21):
  qom/object: use BIT macro for ObjectPropertyFlags
  qom/object: cache ObjectPropertyFlags in ObjectProperty
  qom/object: factor out object_class_property_try_add()
  qom/object: add flags argument in object_{class_}property_try_add()
  qom/object: rename object_{class_}property_try_add() to
    object_{class_}property_add_full()
  qom/object: add helpers to set/get/clear property flags
  qom/object: introduce user interaction flags for properties
  qom/object: add from_user argument in object_property_parse()
  qom/object: mark global property set from CLI as USER_SET
  qom/qom-hmp-cmd: mark properties set from HMP (non-JSON) "qom-set" as
    USER_SET
  qom/qom-qmp-cmd: mark properties set from QMP/HMP (JSON) "qom-set" as
    USER_SET
  qom/object_interfaces: mark properties set from qdict & keyval as
    USER_SET
  system/vl: mark property set in object_parse_property_opt() as
    USER_SET
  hw/core/qdev-properties: allow qdev properties accept flags
  target/i386: deprecate fill-mtrr-mask property
  target/i386: deprecate cpuid-0xb property
  hw/intc/ioapic: deprecate version property
  target/i386: mark x-consistent-cache property as internal-only
  target/i386: remove redundant validation for lbr-fmt property
  target/i386: detect user provided lbr-fmt via property flag
  hw/core/qdev-properties: support valid default value for
    DEFINE_PROP_UINT64_CHECKMASK

 docs/about/deprecated.rst         |  31 +++++
 hw/core/qdev-properties.c         |  29 ++--
 hw/i386/sgx.c                     |   2 +-
 hw/intc/ioapic.c                  |   3 +-
 include/hw/core/qdev-properties.h |  38 +++---
 include/qom/object.h              | 215 +++++++++++++++++++++++++++---
 qom/object.c                      | 177 ++++++++++++++++++++----
 qom/object_interfaces.c           |   5 +
 qom/qom-hmp-cmds.c                |   2 +-
 qom/qom-qmp-cmds.c                |   7 +-
 system/vl.c                       |   6 +-
 target/i386/cpu.c                 |  28 ++--
 12 files changed, 448 insertions(+), 95 deletions(-)

-- 
2.34.1


