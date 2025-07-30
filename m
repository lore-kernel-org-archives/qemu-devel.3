Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B31C83F26
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 14:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uh7U5-0003pX-C7; Wed, 30 Jul 2025 10:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uh663-0005cd-G2
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 08:39:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uh65x-0006ss-RZ
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 08:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753879183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ubrvtoVakg0lXeDVD8AC8D4MJCS5YYpgHzY8i4jJWTk=;
 b=K9M+KaH6B+h2kTQ6uMV93nbzaVYsrkpl01a9bjlgo6EXVja8ZrMp4HRQEG+KSS7aKQszQY
 RPf2OL1MaL59iucyCEsKD9jbApotzIjC+u5fObN0wZzPuBggsjTsF64tZ6zFlcb6nxMMnR
 8LTNJRc8L1EvfgSEc7oXTDX9GK4NZ28=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-330-u8acKRDnO96m2DuvIpkg5Q-1; Wed,
 30 Jul 2025 08:39:40 -0400
X-MC-Unique: u8acKRDnO96m2DuvIpkg5Q-1
X-Mimecast-MFC-AGG-ID: u8acKRDnO96m2DuvIpkg5Q_1753879179
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D4D219560B9; Wed, 30 Jul 2025 12:39:39 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0EDE430001BE; Wed, 30 Jul 2025 12:39:36 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peterx@redhat.com, mst@redhat.com,
 mtosatti@redhat.com, kraxel@redhat.com, peter.maydell@linaro.org
Subject: [PATCH v2 0/6] Reinvent BQL-free PIO/MMIO
Date: Wed, 30 Jul 2025 14:39:28 +0200
Message-ID: <20250730123934.1787379-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Testing lock-less IO with HPET micro benchmark [1] shows approx 80%
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

1) "[kvm-unit-tests PATCH v4 0/5] x86: add HPET counter tests"
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

Igor Mammedov (6):
  memory: reintroduce BQL-free fine-grained PIO/MMIO
  acpi: mark PMTIMER as unlocked
  hpet: switch to fain-grained device locking
  hpet: move out main counter read into a separate block
  hpet: make main counter read lock-less
  kvm: i386: irqchip: take BQL only if there is an interrupt

 include/system/memory.h | 10 +++++++
 hw/acpi/core.c          |  1 +
 hw/timer/hpet.c         | 64 +++++++++++++++++++++++++++++++++++------
 system/memory.c         |  6 ++++
 system/physmem.c        |  2 +-
 target/i386/kvm/kvm.c   | 58 +++++++++++++++++++++++--------------
 6 files changed, 111 insertions(+), 30 deletions(-)

-- 
2.47.1


