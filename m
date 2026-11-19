Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA78606A332
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 23:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TtNPPnhc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUBcc-0001jD-AU; Thu, 19 Nov 2026 18:32:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xUBcS-0001ie-Tj
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 18:32:44 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xUBcP-0007aW-A5
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 18:32:44 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3478C60E04;
 Thu, 19 Nov 2026 23:32:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729631F000C4;
 Thu, 19 Nov 2026 23:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795131158;
 bh=bQo47EZlWoIpodpsjFrowNNVy6VHDsab3fGqkNNHFlI=;
 h=From:To:Cc:Subject:Date;
 b=TtNPPnhc5KBgCO6IXZzpXcAjQSrXzmoiM+9rGV68QKB1IFioHvRpVBAPSWxt8jFnj
 HySHEPml3W5P1tK00Pp1lDC1OasTIbopNr0mRWGMKpTcPe9U3o+ijsFLwh3UG3bNNH
 3N+gF4QM7lquEwgcf5b2XfmWBX+08VXoPtpV0+/BQ+W58jAXT6KngzsjBaxEvMCKqD
 8Z+pEmeYz/69VtayBRG5JwnFvplpQScGCxZZgo8rVA+tasx8BkhmR6DmMDbDVgQYL4
 UkSy5DLSnfuekOZVXWk6428PFo4fiPIu9/8Zx3VWIbTVdWRgezaAVMNq3dLvEg+Pbz
 jQuaIWbu2jgZQ==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Helge Deller <deller@gmx.de>,
 Fam Zheng <fam@euphon.net>, BALATON Zoltan <balaton@eik.bme.hu>,
 Keith Monahan <keith@techtravels.org>
Subject: [PATCH v3 0/6] nc53c710 rewrite
Date: Fri, 20 Nov 2026 00:32:29 +0100
Message-ID: <20261119233235.32808-1-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Helge Deller <deller@gmx.de>

This is the third attempt to replace the existing 53c710 driver by
a new driver based on the code of the lsi53c895a.c.
Patch #1 is not meant to be reviewed, as it basically just replaces
the existing driver by a new one.
But patch #2 implements the proposed changes to use a common header
for both drivers, as suggested by BALATON Zoltan.

Note that the ncr53c710 driver is currently only used by the HPPA 715 machine,
and this patch should not have any effect on any other platform or machine. On
the 715, this driver has been sucessfully tested with Linux, HP-UX and NetBSD.

Please review.
It would be great if this series can be included for qemu v11.2, as the current
driver does not work stable for any guest OS.

Keith Monahan (6):
  hw/scsi/ncr53c710: rewrite the 53C710 SCRIPTS engine
  hw/scsi: share NCR/LSI definitions in lsi_scsi.h
  hw/scsi/lasi_ncr710: map the full LASI SCSI module page
  hw/scsi/ncr53c710: move to COMMAND on CLEAR ACK after MESSAGE REJECT
  hw/scsi/scsi-disk: add quirk_mode_page_no_flexible_disk, use it on the
    715
  hw/scsi/ncr53c710: Comment cleanup, reduce verbosity, repetition

 MAINTAINERS            |    1 +
 hw/hppa/machine.c      |   10 +
 hw/scsi/lasi_ncr710.c  |  129 +-
 hw/scsi/lasi_ncr710.h  |   28 +-
 hw/scsi/lsi53c895a.c   |   79 +-
 hw/scsi/lsi_scsi.h     |   98 ++
 hw/scsi/ncr53c710.c    | 2957 +++++++++++++++-------------------------
 hw/scsi/ncr53c710.h    |  282 ++--
 hw/scsi/scsi-disk.c    |   13 +
 hw/scsi/trace-events   |   43 +-
 include/hw/scsi/scsi.h |    1 +
 11 files changed, 1426 insertions(+), 2215 deletions(-)
 create mode 100644 hw/scsi/lsi_scsi.h

-- 
2.54.0


