Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F7CDCD37AC
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 18:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNE0M-0004dY-On; Wed, 13 May 2026 14:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mateusz.nowicki@posteo.net>)
 id 1wNE0H-0004Yo-1p
 for qemu-devel@nongnu.org; Wed, 13 May 2026 14:08:18 -0400
Received: from mout01.posteo.de ([185.67.36.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mateusz.nowicki@posteo.net>)
 id 1wNE0D-0003ks-O3
 for qemu-devel@nongnu.org; Wed, 13 May 2026 14:08:16 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id C18C5240027
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 20:08:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
 t=1778695690; bh=GTusH1tc26aqGRrhbCqyd/ioHVLpuAr3GS4t/8553a4=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
 Content-Transfer-Encoding:From;
 b=PInn0boEcw8GrXTO+7W66RTInFYEkXJm6ZUKpc1KZaNSB6gFkqk2W15gpyvPIJIJ4
 hH4x3s7RdCbXU4V/wpaabzd4AbB6UPvnyvEv0cuYayItpcTUi2Wc/Kn5EJcq2nBgrc
 ez59BtuhF7bEAGyWHPuitkzBfKaKMls0eS2t+rpmNSIBARptMR6eRr6HB4F6h5o1ao
 JD50HLefbPtJ+3hhti+ylJHLbf27vr+E6H9CqdfsJTJu3yZ8WUz2nRJkM4fv86/c8Z
 pIdkIizK/75Ho0nblyIGdSfzDMtLJ376Cmn1+DSgtzaJfPLSRprfA/M88r9VqnY5DJ
 z9jqXuLkC649g==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4gG1fL2msQz9rxB;
 Wed, 13 May 2026 20:08:10 +0200 (CEST)
From: Mateusz Nowicki <mateusz.nowicki@posteo.net>
To: qemu-devel@nongnu.org
Cc: Mateusz Nowicki <mateusz.nowicki@posteo.net>
Subject: [PATCH v2 0/2] hw/nvme: add monitor commands for inspecting state
Date: Wed, 13 May 2026 18:08:10 +0000
Message-ID: <cover.1778694320.git.mateusz.nowicki@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.67.36.65;
 envelope-from=mateusz.nowicki@posteo.net; helo=mout01.posteo.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add two HMP commands for inspecting emulated NVMe controllers from
the QEMU monitor without attaching gdb to the QEMU process:

  - 'info nvme'        - per-controller summary (PCI, identify
                         fields, CC/CSTS/AQA, queue counts)
  - 'info nvme-queues' - per-queue listing of admin and I/O SQ/CQ
                         (size, head/tail, PRP1, doorbell offset,
                         phase tag)

Useful for verifying queue setup, doorbell rings, AERs held in the
admin SQ and similar driver/controller interaction details from a
running QEMU monitor.

Changes in v2:
  - hw/nvme/meson.build: add the missing trailing newline (Markus).
  - Pick up Acked-by tags from Dr. David Alan Gilbert and Markus
    Armbruster on both patches.

v1: https://lore.kernel.org/qemu-devel/cover.1778409416.git.mateusz.nowicki@posteo.net/

Mateusz Nowicki (2):
  hw/nvme: add 'info nvme' HMP command
  hw/nvme: add 'info nvme-queues' HMP command

 hmp-commands-info.hx |  28 +++++++++
 hw/nvme/meson.build  |   2 +-
 hw/nvme/monitor.c    | 139 +++++++++++++++++++++++++++++++++++++++++++
 qapi/machine.json    |  34 +++++++++++
 4 files changed, 202 insertions(+), 1 deletion(-)
 create mode 100644 hw/nvme/monitor.c

-- 
2.53.0


