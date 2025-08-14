Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44894CA0EE9
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 16:07:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umaT4-0001hB-ID; Thu, 14 Aug 2025 12:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1umaT1-0001fj-0g
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 12:06:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1umaSx-0005ie-1I
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 12:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755187567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7wx95xwBs/QHhcEcsb93kYLg5jcv8SjsfPmxmP8LWe4=;
 b=LDKiQbPX7BTVmcEi7+vrlvN0uDxN9g2MPmgI+i34YsXRjbTEy09P0zT09T3VC2RUhnIGeU
 rdO4BebeFAOW7d/RQS6XQt6xMfK4lOEhvMnXEc8EIy/8KSvOypzpvUeayaMQm0nBJu5lJg
 IvvrMrrzrBAHfrVGQuY4k9rxs2XySL8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-386-nveYjMG-OFOVZI0RYdAjSQ-1; Thu,
 14 Aug 2025 12:06:06 -0400
X-MC-Unique: nveYjMG-OFOVZI0RYdAjSQ-1
X-Mimecast-MFC-AGG-ID: nveYjMG-OFOVZI0RYdAjSQ_1755187565
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7861D1800286
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 16:06:05 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 70A7C180044F; Thu, 14 Aug 2025 16:06:03 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, mtosatti@redhat.com
Subject: [PATCH v4 0/8] Reinvent BQL-free PIO/MMIO
Date: Thu, 14 Aug 2025 18:05:52 +0200
Message-ID: <20250814160600.2327672-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


v4:
  * improoved doc comment for  memory_region_enable_lockless_io()
  * add additional helper to set interrupt to pair with new cpu_test_interrupt()
    and use it tree wide to set interrutps
  * merge 'cpu_test_interrupt()/cpu_set_interrupt()' with patches
    that use them (v3 6-7,9/10).
  * pick up acks
v3:
  * hpet: replace explicit atomics with use seqlock API  (PeterX)
  * introduce cpu_test_interrupt() (Paolo)
    and use it tree wide for checking interrupts
  * don't take BQL for setting exit_request, use qatomic_set() instead. (Paolo)
  * after above change, relace conditional BQL with unconditional
    to simlify things a bit (Paolo)
  * drop not needed barriers (Paolo)
  * minor tcg:cpu_handle_interrupt() cleanup

v2:
  * Make both read and write pathes BQL-less (Gerd)
  * Refactor HPET to handle lock-less access correctly
    when stopping/starting counter in parallel. (Peter Maydell)
  * Publish kvm-unit-tests HPET bench/torture test [1] to verify
    HPET lock-less handling

When booting WS2025 with following CLI
 1)   -M q35,hpet=off -cpu host -enable-kvm -smp 240,sockets=4
the guest boots very slow and is sluggish after boot
or it's stuck on boot at spinning circle (most of the time).

pref shows that VM is experiencing heavy BQL contention on IO path
which happens to be ACPI PM timer read access. A variation with
HPET enabled moves contention to HPET timer read access.
And it only gets worse with increasing number of VCPUs.

Series prevents large VM vCPUs contending on BQL due to PM|HPET timer
access and lets Windows to move on with boot process.

Testing lock-less IO with HPET micro benchmark [2] shows approx 80%
better performance than the current BLQ locked path.
[chart https://ibb.co/MJY9999 shows much better scaling of lock-less
IO compared to BQL one.]

In my tests, with CLI WS2025 guest wasn't able to boot within 30min
on both hosts
  * 32 core 2NUMA nodes
  * 448 cores 8NUMA nodes
With ACPI PM timer in BQL-free read mode, guest boots within approx:
 * 2min
 * 1min
respectively.

With HPET enabled boot time shrinks ~2x
 * 4m13 -> 2m21
 * 2m19 -> 1m15
respectively.

2) "[kvm-unit-tests PATCH v4 0/5] x86: add HPET counter tests"
    https://lore.kernel.org/kvm/20250725095429.1691734-1-imammedo@redhat.com/T/#t
PS:
Using hv-time=on cpu option helps a lot (when it works) and
lets [1] guest boot fine in ~1-2min. Series doesn't make
a significant impact in this case.

PS2:
Tested series with a bunch of different guests:
 RHEL-[6..10]x64, WS2012R2, WS2016, WS2022, WS2025

PS3:
 dropped mention of https://bugzilla.redhat.com/show_bug.cgi?id=1322713
 as it's not reproducible with current software stack or even with
 the same qemu/seabios as reported (kernel versions mentioned in
 the report were interim ones and no longer available,
 so I've used nearest released at the time for testing) 

git tree: https://gitlab.com/imammedo/qemu lockless_io_v4

CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Peter Xu <peterx@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>
CC: mtosatti@redhat.com 

Igor Mammedov (8):
  memory: reintroduce BQL-free fine-grained PIO/MMIO
  acpi: mark PMTIMER as unlocked
  hpet: switch to fain-grained device locking
  hpet: move out main counter read into a separate block
  hpet: make main counter read lock-less
  add cpu_test_interrupt()/cpu_set_interrupt() helpers and use them tree
    wide
  kvm: i386: irqchip: take BQL only if there is an interrupt
  tcg: move interrupt caching and single step masking closer to user

 include/hw/core/cpu.h               | 25 ++++++++++++++++
 include/system/memory.h             | 12 ++++++++
 accel/tcg/cpu-exec.c                | 25 +++++++---------
 accel/tcg/tcg-accel-ops.c           |  2 +-
 accel/tcg/user-exec.c               |  2 +-
 hw/acpi/core.c                      |  1 +
 hw/intc/s390_flic.c                 |  2 +-
 hw/openrisc/cputimer.c              |  2 +-
 hw/timer/hpet.c                     | 38 +++++++++++++++++++-----
 system/cpus.c                       |  2 +-
 system/memory.c                     | 15 ++++++++++
 system/physmem.c                    |  2 +-
 target/alpha/cpu.c                  |  8 ++---
 target/arm/cpu.c                    | 20 ++++++-------
 target/arm/helper.c                 | 18 +++++------
 target/arm/hvf/hvf.c                |  6 ++--
 target/avr/cpu.c                    |  2 +-
 target/hppa/cpu.c                   |  2 +-
 target/i386/hvf/hvf.c               |  4 +--
 target/i386/hvf/x86hvf.c            | 21 +++++++------
 target/i386/kvm/kvm.c               | 46 ++++++++++++++---------------
 target/i386/nvmm/nvmm-all.c         | 24 +++++++--------
 target/i386/tcg/system/seg_helper.c |  2 +-
 target/i386/tcg/system/svm_helper.c |  2 +-
 target/i386/whpx/whpx-all.c         | 34 ++++++++++-----------
 target/loongarch/cpu.c              |  2 +-
 target/m68k/cpu.c                   |  2 +-
 target/microblaze/cpu.c             |  2 +-
 target/mips/cpu.c                   |  6 ++--
 target/mips/kvm.c                   |  2 +-
 target/openrisc/cpu.c               |  3 +-
 target/ppc/cpu_init.c               |  2 +-
 target/ppc/kvm.c                    |  2 +-
 target/rx/cpu.c                     |  3 +-
 target/rx/helper.c                  |  2 +-
 target/s390x/cpu-system.c           |  2 +-
 target/sh4/cpu.c                    |  2 +-
 target/sh4/helper.c                 |  2 +-
 target/sparc/cpu.c                  |  2 +-
 target/sparc/int64_helper.c         |  4 +--
 40 files changed, 211 insertions(+), 144 deletions(-)

-- 
2.47.1


