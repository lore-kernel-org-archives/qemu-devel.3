Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B2DC7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 15:15:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSdRq-0002xK-Ty; Fri, 20 Jun 2025 11:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uSdRp-0002x6-FB
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 11:14:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uSdRn-00063t-IS
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 11:14:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750432470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zLCgUpy1c+pZNmitNXzxmNsmJgaxLDZlgno4bBUaD44=;
 b=WLkcz96uYo0Ke9VdTxfJPpilymSuz+Q0BmgJjcQ7DTsqvFuxrjv431OHHPJ4d3qpT9K4Az
 MtscGgQNxYBRWATrf1SxmGBmeMVwYG74d2EJ1o6rgpFapfCZOHYkps1H16F+ZcU5M6XTqc
 dJDEZ/4V88YwFcb5Voj0TLASRZNMVWI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-oUNObUurNrauQWrhuUSTxg-1; Fri,
 20 Jun 2025 11:14:26 -0400
X-MC-Unique: oUNObUurNrauQWrhuUSTxg-1
X-Mimecast-MFC-AGG-ID: oUNObUurNrauQWrhuUSTxg_1750432465
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B23A195609E; Fri, 20 Jun 2025 15:14:25 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BBDB01956094; Fri, 20 Jun 2025 15:14:21 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, mst@redhat.com, anisinha@redhat.com,
 elena.ufimtseva@oracle.com, jag.raman@oracle.com, pbonzini@redhat.com,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org
Subject: [PATCH 0/3] Reinvent BQL-free PIO/MMIO
Date: Fri, 20 Jun 2025 17:14:15 +0200
Message-ID: <20250620151418.1166195-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When booting WS2025 with following CLI
 1)   -M q35,hpet=off -cpu host -enable-kvm -smp 240,sockets=4
the guest boots very slow and is sluggish after boot
or it's stuck on boot at spinning circle.

pref shows that VM is experiencing heavy BQL contention on IO path
which happens to be ACPI PM timer read access. A variation with
HPET enabled moves contention to HPET timer read access.
And it only gets worse with increasing number of VCPUs.

Series prevents large VM vCPUs contending on BQL due to PM|HPET timer
access and lets it move on with boot process.

It's basically resurecting Jan's idea [2] of BQL-free IO access,
with a twist that whitelist reads access only to minimze chances
of [3] issues. If we hit issues later on, it might be better
to actually find a root cause and perhaps fix guest side if
possible. (so I tested series with a bucn of different guests
instead, RHEL-[6..10]x64, WS2012R2, WS2016, WS2022, WS2025)

In my tests, with [1] CLI WS2025 guest wasn't able to boot within 30min
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

Using hv-time=on cpu option helps a lot (when it works) and
lets [1] guest boot fine in ~1-2min (this series reduces
boot time on ~10% on top of hv-time improvements).

2) 196ea13104f (memory: Add global-locking property to memory regions)
  ... de7ea885c539 (kvm: Switch to unlocked MMIO)
3) https://bugzilla.redhat.com/show_bug.cgi?id=1322713
  1beb99f787 (Revert "acpi: mark PMTIMER as unlocked")

Igor Mammedov (3):
  memory: reintroduce BQL-free fine-grained PIO/MMIO
  acpi: mark PMTIMER as unlocked
  mark HPET as unlocked

 include/system/memory.h   | 10 +++++++++-
 hw/acpi/core.c            |  2 ++
 hw/remote/vfio-user-obj.c |  2 +-
 hw/timer/hpet.c           |  2 ++
 system/memory.c           |  5 +++++
 system/memory_ldst.c.inc  | 18 +++++++++---------
 system/physmem.c          |  9 +++++----
 7 files changed, 33 insertions(+), 15 deletions(-)

--
2.43.5


