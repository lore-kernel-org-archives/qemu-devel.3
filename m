Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D08E4C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 16:23:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udtI4-00039C-CK; Mon, 21 Jul 2025 12:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtHp-00034s-Ez
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:22:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtHn-0001Ky-5Q
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:22:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753114960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AeI5pPzMF5j2/CQxCt0/BdQpkIH04YcaUedMX7GT1zo=;
 b=aykiqtTnqnERaT944xGIwrrZQKKS0Rk2uqv0Zcyu7N67wl5sL3VXLTb4tvKyP31hS9Y5WI
 2owYH1zSLTPjPMMBYO2hPAve8G0b1as7AE+NKZ5NZzTxex3RsQArCS8BCVd7chPSRcNXUs
 nprWojCFEImxvCqOebVC5O3HTY1bzK0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-DfZ30EUPM3KBvpOPyqLnlg-1; Mon,
 21 Jul 2025 12:22:38 -0400
X-MC-Unique: DfZ30EUPM3KBvpOPyqLnlg-1
X-Mimecast-MFC-AGG-ID: DfZ30EUPM3KBvpOPyqLnlg_1753114957
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3BBBC1800297; Mon, 21 Jul 2025 16:22:37 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8C9E2195608D; Mon, 21 Jul 2025 16:22:35 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 00/50] ppc queue
Date: Mon, 21 Jul 2025 18:21:43 +0200
Message-ID: <20250721162233.686837-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
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

The following changes since commit e82989544e38062beeeaad88c175afbeed0400f8:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2025-07-18 14:10:02 -0400)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-ppc-20250721

for you to fetch changes up to df3614b7983e0629b0d422259968985ca0117bfa:

  ppc/xive2: Enable lower level contexts on VP push (2025-07-21 08:03:53 +0200)

----------------------------------------------------------------
ppc/xive queue:

* Various bug fixes around lost interrupts particularly.
* Major group interrupt work, in particular around redistributing
  interrupts. Upstream group support is not in a complete or usable
  state as it is.
* Significant context push/pull improvements, particularly pool and
  phys context handling was quite incomplete beyond trivial OPAL
  case that pushes at boot.
* Improved tracing and checking for unimp and guest error situations.
* Various other missing feature support.

----------------------------------------------------------------
Glenn Miles (12):
      ppc/xive2: Fix calculation of END queue sizes
      ppc/xive2: Use fair irq target search algorithm
      ppc/xive2: Fix irq preempted by lower priority group irq
      ppc/xive2: Fix treatment of PIPR in CPPR update
      pnv/xive2: Support ESB Escalation
      ppc/xive2: add interrupt priority configuration flags
      ppc/xive2: Support redistribution of group interrupts
      ppc/xive: Add more interrupt notification tracing
      ppc/xive2: Improve pool regs variable name
      ppc/xive2: Implement "Ack OS IRQ to even report line" TIMA op
      ppc/xive2: Redistribute group interrupt precluded by CPPR update
      ppc/xive2: redistribute irqs for pool and phys ctx pull

Michael Kowal (4):
      ppc/xive2: Remote VSDs need to match on forwarding address
      ppc/xive2: Reset Generation Flipped bit on END Cache Watch
      pnv/xive2: Print value in invalid register write logging
      pnv/xive2: Permit valid writes to VC/PC Flush Control registers

Nicholas Piggin (34):
      ppc/xive: Fix xive trace event output
      ppc/xive: Report access size in XIVE TM operation error logs
      ppc/xive2: fix context push calculation of IPB priority
      ppc/xive: Fix PHYS NSR ring matching
      ppc/xive2: Do not present group interrupt on OS-push if precluded by CPPR
      ppc/xive2: Set CPPR delivery should account for group priority
      ppc/xive: tctx_notify should clear the precluded interrupt
      ppc/xive: Explicitly zero NSR after accepting
      ppc/xive: Move NSR decoding into helper functions
      ppc/xive: Fix pulling pool and phys contexts
      pnv/xive2: VC_ENDC_WATCH_SPEC regs should read back WATCH_FULL
      ppc/xive: Change presenter .match_nvt to match not present
      ppc/xive2: Redistribute group interrupt preempted by higher priority interrupt
      ppc/xive: Add xive_tctx_pipr_present() to present new interrupt
      ppc/xive: Fix high prio group interrupt being preempted by low prio VP
      ppc/xive: Split xive recompute from IPB function
      ppc/xive: tctx signaling registers rework
      ppc/xive: tctx_accept only lower irq line if an interrupt was presented
      ppc/xive: Add xive_tctx_pipr_set() helper function
      ppc/xive2: split tctx presentation processing from set CPPR
      ppc/xive2: Consolidate presentation processing in context push
      ppc/xive2: Avoid needless interrupt re-check on CPPR set
      ppc/xive: Assert group interrupts were redistributed
      ppc/xive2: implement NVP context save restore for POOL ring
      ppc/xive2: Prevent pulling of pool context losing phys interrupt
      ppc/xive: Redistribute phys after pulling of pool context
      ppc/xive: Check TIMA operations validity
      ppc/xive2: Implement pool context push TIMA op
      ppc/xive2: redistribute group interrupts on context push
      ppc/xive2: Implement set_os_pending TIMA op
      ppc/xive2: Implement POOL LGS push TIMA op
      ppc/xive2: Implement PHYS ring VP push TIMA op
      ppc/xive: Split need_resend into restore_nvp
      ppc/xive2: Enable lower level contexts on VP push

 hw/intc/pnv_xive2_regs.h    |   1 +
 include/hw/ppc/xive.h       |  66 +++-
 include/hw/ppc/xive2.h      |  22 +-
 include/hw/ppc/xive2_regs.h |  22 +-
 hw/intc/pnv_xive.c          |  16 +-
 hw/intc/pnv_xive2.c         | 140 ++++++---
 hw/intc/spapr_xive.c        |  18 +-
 hw/intc/xive.c              | 555 ++++++++++++++++++++++------------
 hw/intc/xive2.c             | 717 +++++++++++++++++++++++++++++++++-----------
 hw/ppc/pnv.c                |  48 +--
 hw/ppc/spapr.c              |  21 +-
 hw/intc/trace-events        |  12 +-
 12 files changed, 1146 insertions(+), 492 deletions(-)


