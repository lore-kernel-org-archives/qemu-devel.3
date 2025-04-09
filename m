Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1680AC36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 08:07:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2QS3-000550-Rj; Wed, 09 Apr 2025 04:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u2QRz-00054W-DF; Wed, 09 Apr 2025 04:06:26 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u2QRv-0000RP-PC; Wed, 09 Apr 2025 04:06:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744185979; x=1775721979;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=I2s1W4IyDTQ8AYD3sBlVOogfmldQt5VB0rUpFb6frYw=;
 b=G+OlVh5AV+bUAXg2VYSP3ZSECFqQP0fNyIAa0Ugp1m/mBQrQk7aXViUj
 qNxF1o38wzS+xmv9W3D49u+rxU8t6El0+pdwnTvcdCfXQPs8ZevAjUx4b
 H2VDFj6Yr7CCIxDR750mTVDd8cPdbG2y7Zjy1n3DdaWDtBp5faqUtXuUP
 94VFOYDzzc50MkHsQ9PImh7AW03vVcZsRQzesQmTwkZNYVka9lUU3j3PV
 N+F8Yh7CcMZ18dZL7EAWaguQ+ShlhelSkewMUKgNNNKXVhX0Y13gN3xIR
 RMR8l7CxLlctDppfpTwO/QEFfRZda8INgx6P6Y/Oad/4y+JENfwDQQ6a8 Q==;
X-CSE-ConnectionGUID: nU3KaSffR0+/Knntzjs0Tw==
X-CSE-MsgGUID: 2asOo9OgRI+2OLCx8LITOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45809982"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; d="scan'208";a="45809982"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2025 01:06:14 -0700
X-CSE-ConnectionGUID: fcVndc10Sea4PGTEMbFGbA==
X-CSE-MsgGUID: UhlfyyvqR0q34BJ/C4NDWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; d="scan'208";a="151702575"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 09 Apr 2025 01:06:07 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcelo Tosatti <mtosatti@redhat.com>, Shaoqin Huang <shahuang@redhat.com>,
 Eric Auger <eauger@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Sebastian Ott <sebott@redhat.com>, Gavin Shan <gshan@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Yi Lai <yi1.lai@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 0/5] accel/kvm: Support KVM PMU filter
Date: Wed,  9 Apr 2025 16:26:44 +0800
Message-Id: <20250409082649.14733-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.845,
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

Hi all,

Now I've converted the previous RFC (v2) to PATCH.

Compared with RFC v2 [1], this version mianly have the following
changes:
 * Make PMU related QAPIs accept decimal value instead of string.
 * Introduce a three-level QAPI section to organize KVM PMU stuff.
 * Fix QAPI related style issues.
 * Rename "x86-default" format to "x86-select-umask".

Current pmu-filter QOM design could meet the requirements of both x86
and ARM sides.


Background
==========

I picked up Shaoqing's previous work [2] on the KVM PMU filter for arm,
and now is trying to support this feature for x86 with a JSON-compatible
API.

While arm and x86 use different KVM ioctls to configure the PMU filter,
considering they all have similar inputs (PMU event + action), it is
still possible to abstract a generic, cross-architecture kvm-pmu-filter
object and provide users with a sufficiently generic or near-consistent
QAPI interface.

That's what I did in this series, a new kvm-pmu-filter object, with the
API like:

-object '{"qom-type":"kvm-pmu-filter","id":"f0","action":"allow","events":[{"format":"raw","code":196}]}'

For x86, this object is inserted into kvm accelerator and is extended
to support fixed-counter and more formats ("x86-default" and
"x86-masked-entry"):

-accel kvm,pmu-filter=f0 \
-object '{"qom-type":"kvm-pmu-filter","id":"f0","action":"allow","x86-fixed-counter":0,"events":[{"format":"x86-masked-entry","select":196,"mask":255,"match":0,"exclude":true},{"format":"x86-masked-entry","select":197,"mask":255,"match":0,"exclude":true}]}'

This object can still be added as the property to the arch CPU if it is
desired as a per CPU feature (as Shaoqin did for arm before).


Introduction
============


Formats supported in kvm-pmu-filter
-----------------------------------

This series supports 3 formats:

* raw format (general format).

  This format indicates the code that has been encoded to be able to
  index the PMU events, and which can be delivered directly to the KVM
  ioctl. For arm, this means the event code, and for i386, this means
  the raw event with the layout like:

      select high bit | umask | select low bits

* x86-select-umask format (i386 specific)

  x86 commonly uses select&umask to identify PMU events, and this format
  is used to support the select&umask. Then QEMU will encode select and
  umask into a raw format code.

* x86-masked-entry (i386 specific)

  This is a special format that x86's KVM_SET_PMU_EVENT_FILTER supports.


CPU property v.s. KVM property
------------------------------

In Shaoqin's previous implementation [2], KVM PMU filter is made as a
arm CPU property. This is because arm uses a per CPU ioctl
(KVM_SET_DEVICE_ATTR) to configure KVM PMU filter.

However, for x86, the dependent ioctl (KVM_SET_PMU_EVENT_FILTER) is per
VM. In the meantime, considering that for hybrid architecture, maybe in
the future there will be a new per vCPU ioctl, or there will be
practices to support filter fixed counter by configuring CPUIDs.

Based on the above thoughts, for x86, it is not appropriate to make the
current per-VM ioctl-based PMU filter a CPU property. Instead, I make it
a kvm property and configure it via "-accel kvm,pmu-filter=obj_id".

So in summary, it is feasible to use the KVM PMU filter as either a CPU
or a KVM property, depending on whether it is used as a CPU feature or a
VM feature.

The kvm-pmu-filter object, as an abstraction, is general enough to
support filter configurations for different scopes (per-CPU or per-VM).

[1]: https://lore.kernel.org/qemu-devel/20250122090517.294083-1-zhao1.liu@intel.com/
[2]: https://lore.kernel.org/qemu-devel/20240409024940.180107-1-shahuang@redhat.com/

Thanks and Best Regards,
Zhao
---
Zhao Liu (5):
  qapi/qom: Introduce kvm-pmu-filter object
  i386/kvm: Support basic KVM PMU filter
  i386/kvm: Support event with select & umask format in KVM PMU filter
  i386/kvm: Support event with masked entry format in KVM PMU filter
  i386/kvm: Support fixed counter in KVM PMU filter

 MAINTAINERS              |   2 +
 accel/kvm/kvm-pmu.c      | 177 +++++++++++++++++++++++++++++++++++++++
 accel/kvm/meson.build    |   1 +
 include/system/kvm-pmu.h |  51 +++++++++++
 include/system/kvm_int.h |   2 +
 qapi/accelerator.json    |  14 ++++
 qapi/kvm.json            | 130 ++++++++++++++++++++++++++++
 qapi/meson.build         |   1 +
 qapi/qapi-schema.json    |   1 +
 qapi/qom.json            |   3 +
 qemu-options.hx          |  67 ++++++++++++++-
 target/i386/kvm/kvm.c    | 176 ++++++++++++++++++++++++++++++++++++++
 12 files changed, 624 insertions(+), 1 deletion(-)
 create mode 100644 accel/kvm/kvm-pmu.c
 create mode 100644 include/system/kvm-pmu.h
 create mode 100644 qapi/accelerator.json
 create mode 100644 qapi/kvm.json

-- 
2.34.1


