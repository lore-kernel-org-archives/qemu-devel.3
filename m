Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4342C3DA41
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 04:37:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRP3s-0005fe-SO; Wed, 10 Jul 2024 00:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sRP3q-0005cf-SX; Wed, 10 Jul 2024 00:36:10 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sRP3n-0006sb-BR; Wed, 10 Jul 2024 00:36:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720586167; x=1752122167;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=PibKnXq9Pq/c31n0bxDbMaIs/xxPngjdmk6sa7uOb+M=;
 b=PNR8O2C+RRsR0rGfo1/PTbXkEbki8HKZS0F8kXaK42MVvFJGTZVo08A8
 roTknVBtK/djTSB7N5SrqYtv4l/Kz0GjbUo6GBma+QtGxC4g10tsuokPV
 NyEehUKFfNt6meXP5trGqkcB4TGvB1/rbQtQY5ZEXyaDej40doCnl9ZBn
 laItybsiqOwluuA7FnzMP+KKLDviQdpqut0h/q26etv7Tzlj4rTC2KKri
 LpGgXXdmcLxWtz2iMsvo2uNENXj1MZacgqaaQOPRSjFXXkB8DSpfMZNvI
 ZG6zpYqM5o2xBWZetOEF1koloMeEb05MwIBrzj+47wtHkO0kvruoRjM5D g==;
X-CSE-ConnectionGUID: XjmujolvREKUrI/PnxFGRw==
X-CSE-MsgGUID: eAblcny/Rtm+9inTddTCiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="28473753"
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; d="scan'208";a="28473753"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2024 21:35:56 -0700
X-CSE-ConnectionGUID: xL+EWwXbRIeKbL4iBoT2oQ==
X-CSE-MsgGUID: SL/LYDmCRTOQF7RGGpwW5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; d="scan'208";a="79238097"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 09 Jul 2024 21:35:51 -0700
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
 Zhenyu Wang <zhenyu.z.wang@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Yuan Yao <yuan.yao@intel.com>, Xiong Zhang <xiong.y.zhang@intel.com>,
 Mingwei Zhang <mizhang@google.com>, Jim Mattson <jmattson@google.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 0/5] accel/kvm: Support KVM PMU filter
Date: Wed, 10 Jul 2024 12:51:12 +0800
Message-Id: <20240710045117.3164577-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

Hi QEMU maintainers, arm and PMU folks,

I picked up Shaoqing's previous work [1] on the KVM PMU filter for arm,
and now is trying to support this feature for x86 with a JSON-compatible
API.

While arm and x86 use different KVM ioctls to configure the PMU filter,
considering they all have similar inputs (PMU event + action), it is
still possible to abstract a generic, cross-architecture kvm-pmu-filter
object and provide users with a sufficiently generic or near-consistent
QAPI interface.

That's what I did in this series, a new kvm-pmu-filter object, with the
API like:

-object '{"qom-type":"kvm-pmu-filter","id":"f0","events":[{"action":"allow","format":"raw","code":"0xc4"}]}'

For i386, this object is inserted into kvm accelerator and is extended
to support fixed-counter and more formats ("x86-default" and
"x86-masked-entry"):

-accel kvm,pmu-filter=f0 \
-object pmu='{"qom-type":"kvm-pmu-filter","id":"f0","x86-fixed-counter":{"action":"allow","bitmap":"0x0"},"events":[{"action":"allow","format":"x86-masked-entry","select":"0xc4","mask":"0xff","match":"0","exclude":true},{"action":"allow","format":"x86-masked-entry","select":"0xc5","mask":"0xff","match":"0","exclude":true}]}'

This object can still be added as the property to the arch CPU if it is
desired as a per CPU feature (as Shaoqin did for arm before).

Welcome your feedback and comments!


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

In Shaoqin's previous implementation [1], KVM PMU filter is made as a
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


[1]: https://lore.kernel.org/qemu-devel/20240409024940.180107-1-shahuang@redhat.com/

Thanks and Best Regards,
Zhao
---
Zhao Liu (5):
  qapi/qom: Introduce kvm-pmu-filter object
  i386/kvm: Support initial KVM PMU filter
  i386/kvm: Support event with select&umask format in KVM PMU filter
  i386/kvm: Support event with masked entry format in KVM PMU filter
  i386/kvm: Support fixed counter in KVM PMU filter

 MAINTAINERS                |   1 +
 accel/kvm/kvm-pmu.c        | 367 +++++++++++++++++++++++++++++++++++++
 accel/kvm/meson.build      |   1 +
 include/sysemu/kvm-pmu.h   |  43 +++++
 include/sysemu/kvm_int.h   |   2 +
 qapi/kvm.json              | 255 ++++++++++++++++++++++++++
 qapi/meson.build           |   1 +
 qapi/qapi-schema.json      |   1 +
 qapi/qom.json              |   3 +
 target/i386/kvm/kvm.c      | 211 +++++++++++++++++++++
 target/i386/kvm/kvm_i386.h |   1 +
 11 files changed, 886 insertions(+)
 create mode 100644 accel/kvm/kvm-pmu.c
 create mode 100644 include/sysemu/kvm-pmu.h
 create mode 100644 qapi/kvm.json

-- 
2.34.1


