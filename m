Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A7CC02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 14:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYQTC-0004Jg-GL; Thu, 16 Jan 2025 09:03:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+cabf69696ff47aa9dee2+7816+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1tYQT0-0004ID-Pb
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 09:03:27 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+cabf69696ff47aa9dee2+7816+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1tYQSw-0008AW-He
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 09:03:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=2hzkk/wFSYMvPROnyoi5otvp0+90Pj7TiuP+ZDQ69LY=; b=MFFmPb0LzkCU2Bpv8ua3i/kQKQ
 deYfg8DVqK4/46ITR0O8DVahkQhyZHTJhmb9GcVe46s4miMAo11quTQcFVt4ymGxN2kNeAhviV44x
 WHWZoBJqEi6wokX48ZpUYan+ompPaZ89YwJ9PoaCRAtdA9ApuUiSV5lwN0jvE105R80KfqsyzgLoN
 4fafeOOh1RuobUCIjoA0LjEJrhGvizAlOCtsBAM5SDa3cIEB7IEWc503Qt4lqSYv/+4bK4eiJiBCw
 A5NKB7YGMnzkNwp5d95b7PCEM+lO0JH+oUaEqsaP+whY3MslnOAH4RTT/5jZXQEip5wag967qL6+a
 7kniHBDg==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
 id 1tYQSq-0000000Ezl2-2UcR; Thu, 16 Jan 2025 14:03:16 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat
 Linux)) id 1tYQSq-0000000AJgl-1MjU; Thu, 16 Jan 2025 14:03:16 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Cornelia Huck <cohuck@redhat.com>,
 Peter Hilber <quic_philber@quicinc.com>,
 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>, paul <paul@xen.org>
Subject: [PATCH v7 0/3] hw/acpi: Add vmclock device
Date: Thu, 16 Jan 2025 13:59:40 +0000
Message-ID: <20250116140315.2455143-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+cabf69696ff47aa9dee2+7816+infradead.org+dwmw2@casper.srs.infradead.org;
 helo=casper.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

(Posting one last time with the header commits split out).

The vmclock device addresses the problem of live migration with
precision clocks. The tolerances of a hardware counter (e.g. TSC) are
typically around ±50PPM. A guest will use NTP/PTP/PPS to discipline that
counter against an external source of 'real' time, and track the precise
frequency of the counter as it changes with environmental conditions.

When a guest is live migrated, anything it knows about the frequency of
the underlying counter becomes invalid. It may move from a host where
the counter running at -50PPM of its nominal frequency, to a host where
it runs at +50PPM. There will also be a step change in the value of the
counter, as the correctness of its absolute value at migration is
limited by the accuracy of the source and destination host's time
synchronization.

The device exposes a shared memory region to guests, which can be mapped
all the way to userspace. In the first phase, this merely advertises a
'disruption_marker', which indicates that the guest should throw away any
NTP synchronization it thinks it has, and start again.

Because the region can be exposed all the way to userspace, applications
can still use time from a fast vDSO 'system call', and check the
disruption marker to be sure that their timestamp is indeed truthful.

The structure also allows for the precise time, as known by the host, to
be exposed directly to guests so that they don't have to wait for NTP to
resync from scratch.

The values and fields are based on the nascent virtio-rtc specification,
and the intent is that a version (hopefully precisely this version) of
this structure will be included as an optional part of that spec. In the
meantime, a simple ACPI device along the lines of VMGENID is perfectly
sufficient and is compatible with what's being shipped in certain
commercial hypervisors.

Linux guest support was merged into the 6.13-rc1 kernel:
https://git.kernel.org/torvalds/c/205032724226

---
v7:
 • Split update-kernel-headers.sh and the addition of the new header
   file into separate commits, add MAINTAINERS entry.

v6:
 • Rebase for DEFINE_PROP_END_OF_LIST removal and sysemu→system
   rename.

v5:
 • Trivial simplification to AML generation.
 • Import vmclock-abi.h from Linux now the guest support is merged.

v4:
 • Trivial checkpatch fixes and comment improvements.

v3:
 • Add comment that vmclock-abi.h will come from the Linux kernel
   headers once it gets merged there.

v2:
 • Change esterror/maxerror fields to nanoseconds.
 • Change to officially assigned AMZNC10C ACPI HID.
 • Fix little-endian handling of fields in update.

David Woodhouse (3):
      linux-headers: Add vmclock-abi.h
      linux-headers: Update to Linux 6.13-rc7
      hw/acpi: Add vmclock device

 MAINTAINERS                                  |   5 +
 hw/acpi/Kconfig                              |   5 +
 hw/acpi/meson.build                          |   1 +
 hw/acpi/vmclock.c                            | 179 ++++++++++++++++++++++++++
 hw/i386/Kconfig                              |   1 +
 hw/i386/acpi-build.c                         |  10 +-
 include/hw/acpi/vmclock.h                    |  34 +++++
 include/standard-headers/linux/vmclock-abi.h | 182 +++++++++++++++++++++++++++
 linux-headers/linux/iommufd.h                |  31 +++--
 linux-headers/linux/stddef.h                 |  13 +-
 scripts/update-linux-headers.sh              |   1 +
 11 files changed, 447 insertions(+), 15 deletions(-)



