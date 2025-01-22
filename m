Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE20C02182
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 08:47:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taWNS-0002rr-Ea; Wed, 22 Jan 2025 03:46:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taWNP-0002pI-5V; Wed, 22 Jan 2025 03:46:19 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taWNH-0002xI-Nf; Wed, 22 Jan 2025 03:46:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737535572; x=1769071572;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=/qineeskdRgbE6vyAA/6OrXfiv6ADTg5jvwZfxbwbN8=;
 b=G1wENBvoDmAMy2uvldHdgGQCKwHhHw3/YuQYzo0kofUE5l7tJxMZCvII
 2VQTfaiISRrWZqOfIpLYZQbIA8VIm1GzNdNO8yRTLI+SQpk+uOCF/a97s
 Q6bmqT5bwgSqo5cDqfLC3l2DE3Y2llT/3MLkk6UqNYTKdeAADqLP2W3CD
 MmLX4YSYT0krA1Fflkmqp/Xz+JphNE3K2FzsIQYd6TC/lnSvjCY18s8Ph
 sIGi3Ba6KHE9guSHVFzw4pxoULzRwwYH89QjelOALG5jf5fTBNUnA1t4t
 wxK2/+3ZD7h4X4T+F5fpu+9lzupffMDd03/sZpj20lz+26kLiIVdH2TvQ Q==;
X-CSE-ConnectionGUID: 0ge5V8toTmO62OJQizLaKQ==
X-CSE-MsgGUID: TbLMGnZ+S42zR/PY9jVF2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="60451538"
X-IronPort-AV: E=Sophos;i="6.13,224,1732608000"; d="scan'208";a="60451538"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2025 00:46:07 -0800
X-CSE-ConnectionGUID: jZTTLQ1qSGSsEYjLO0x7Lw==
X-CSE-MsgGUID: S3odIcLiQFWXMDZ8Y+AHMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="112049608"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 22 Jan 2025 00:46:03 -0800
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
Subject: [RFC v2 0/5] accel/kvm: Support KVM PMU filter
Date: Wed, 22 Jan 2025 17:05:12 +0800
Message-Id: <20250122090517.294083-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi folks,

Sorry for the long wait, but RFC v2 is here at last.

Compared with v1 [1], v2 mianly makes `action` as a global parameter,
and all events (and fixed counters) are based on a unified action.

Learned from the discussion with Shaoqin in v1, current pmu-filter QOM
design could meet the requirements from the ARM KVM side.


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

-object '{"qom-type":"kvm-pmu-filter","id":"f0","action":"allow","events":[{"format":"raw","code":"0xc4"}]}'

For i386, this object is inserted into kvm accelerator and is extended
to support fixed-counter and more formats ("x86-default" and
"x86-masked-entry"):

-accel kvm,pmu-filter=f0 \
-object pmu='{"qom-type":"kvm-pmu-filter","id":"f0","action":"allow","x86-fixed-counter":{"bitmap":"0x0"},"events":[{"format":"x86-masked-entry","select":"0xc4","mask":"0xff","match":"0","exclude":true},{"format":"x86-masked-entry","select":"0xc5","mask":"0xff","match":"0","exclude":true}]}'

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

* x86-default format (i386 specific)

  x86 commonly uses select&umask to identify PMU events, and this format
  is used to support the select&umask. Then QEMU will encode select and
  umask into a raw format code.

* x86-masked-entry (i386 specific)

  This is a special format that x86's KVM_SET_PMU_EVENT_FILTER supports.


Hexadecimal value string
------------------------

In practice, the values associated with PMU events (code for arm, select&
umask for x86) are often expressed in hexadecimal. Further, from linux
perf related information (tools/perf/pmu-events/arch/*/*/*.json), x86/
arm64/riscv/nds32/powerpc all prefer the hexadecimal numbers and only
s390 uses decimal value.

Therefore, it is necessary to support hexadecimal in order to honor PMU
conventions.

However, unfortunately, standard JSON (RFC 8259) does not support
hexadecimal numbers. So I can only consider using the numeric string in
the QAPI and then parsing it to a number.

To achieve this, I defined two versions of PMU-related structures in
kvm.json:
 * a native version that accepts numeric values, which is used for
   QEMU's internal code processing,

 * and a variant version that accepts numeric string, which is used to
   receive user input.

kvm-pmu-filter object will take care of converting the string version
of the event/counter information into the numeric version.

The related implementation can be found in patch 1.


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

[1]: https://lore.kernel.org/qemu-devel/20240710045117.3164577-1-zhao1.liu@intel.com/
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

 MAINTAINERS              |   1 +
 accel/kvm/kvm-pmu.c      | 386 +++++++++++++++++++++++++++++++++++++++
 accel/kvm/meson.build    |   1 +
 include/system/kvm-pmu.h |  44 +++++
 include/system/kvm_int.h |   2 +
 qapi/kvm.json            | 246 +++++++++++++++++++++++++
 qapi/meson.build         |   1 +
 qapi/qapi-schema.json    |   1 +
 qapi/qom.json            |   3 +
 target/i386/kvm/kvm.c    | 176 ++++++++++++++++++
 10 files changed, 861 insertions(+)
 create mode 100644 accel/kvm/kvm-pmu.c
 create mode 100644 include/system/kvm-pmu.h
 create mode 100644 qapi/kvm.json

-- 
2.34.1


