Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2937CF9C74
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 10:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1st2OY-0002B4-UF; Tue, 24 Sep 2024 06:03:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1st2OT-0002A6-BF
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 06:03:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1st2OQ-00030F-O6
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 06:03:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727172216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=19fqvUIpG/96Z4atEJdayVh7MYUeWohJuGDm3Vbnbf4=;
 b=VOCs/g63h7DNRVKnuYyV80Nfxa04jEM8JYWWXdUuYbSxPXO/fH3/8FoMcoptgdFEjlHSvG
 KLD7aEsdi7W49n2P5giTDWJunXandgUpL2akZXjj3yvpha99n+NXNyWGMvUJuwP7Z/c/9s
 XdOjai/6tvCPsjSJmYcO9POsd+is8Qk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-EBMMurcuPO6p3inxxDxBvg-1; Tue,
 24 Sep 2024 06:03:34 -0400
X-MC-Unique: EBMMurcuPO6p3inxxDxBvg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8210618E68FF; Tue, 24 Sep 2024 10:03:33 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.22.16.106])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 55D121956052; Tue, 24 Sep 2024 10:03:31 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 0/6] Host Memory Backends and Memory devices queue 2024-09-24
Date: Tue, 24 Sep 2024 12:03:23 +0200
Message-ID: <20240924100329.248738-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi,

due to reset changes this contains a bit of churn that touches various
architectures, but it's all fairly minimal and straight-forward.

The following changes since commit 01dc65a3bc262ab1bec8fe89775e9bbfa627becb:

  Merge tag 'pull-target-arm-20240919' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-09-19 14:15:15 +0100)

are available in the Git repository at:

  https://github.com/davidhildenbrand/qemu.git tags/mem-2024-09-24

for you to fetch changes up to 78c8f780d3f0d6d17aa93d6f99ff72960080fdd7:

  hostmem: Apply merge property after the memory region is initialized (2024-09-24 11:33:35 +0200)

----------------------------------------------------------------
Hi,

"Host Memory Backends" and "Memory devices" queue ("mem"):
- Kconfig fix for virtio-based memory devices
- virtio-mem support for suspend+wake-up with plugged memory
- hostmem fix when specifying "merge=off"

----------------------------------------------------------------
Gavin Shan (1):
      hostmem: Apply merge property after the memory region is initialized

Juraj Marcin (4):
      reset: Use ResetType for qemu_devices_reset() and MachineClass::reset()
      reset: Add RESET_TYPE_WAKEUP
      virtio-mem: Use new Resettable framework instead of LegacyReset
      virtio-mem: Add support for suspend+wake-up with plugged memory

Paolo Bonzini (1):
      virtio: kconfig: memory devices are PCI only

 backends/hostmem.c             |  2 +-
 docs/devel/reset.rst           | 12 ++++++++++-
 hw/arm/aspeed.c                |  4 ++--
 hw/arm/mps2-tz.c               |  4 ++--
 hw/core/reset.c                |  5 +----
 hw/hppa/machine.c              |  4 ++--
 hw/i386/microvm.c              |  4 ++--
 hw/i386/pc.c                   |  6 +++---
 hw/ppc/pegasos2.c              |  4 ++--
 hw/ppc/pnv.c                   |  4 ++--
 hw/ppc/spapr.c                 |  6 +++---
 hw/s390x/s390-virtio-ccw.c     |  4 ++--
 hw/virtio/Kconfig              | 11 ++++++++++
 hw/virtio/virtio-mem.c         | 48 ++++++++++++++++++++++++++++++------------
 hw/virtio/virtio-qmp.c         |  3 +++
 include/hw/boards.h            |  3 ++-
 include/hw/resettable.h        |  2 ++
 include/hw/virtio/virtio-mem.h |  4 ++++
 include/sysemu/reset.h         |  5 +++--
 system/runstate.c              | 13 ++++++++++--
 20 files changed, 103 insertions(+), 45 deletions(-)
-- 
2.46.1


