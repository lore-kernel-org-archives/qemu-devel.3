Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02790606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 19:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XAzApeNy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xX1Nb-0001kg-Fn; Fri, 27 Nov 2026 14:13:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xX1NX-0001jG-Fu; Fri, 27 Nov 2026 14:13:03 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xX1NU-0005r0-H9; Fri, 27 Nov 2026 14:13:03 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7EF0D60D27;
 Fri, 27 Nov 2026 19:12:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30EFF1F000C1;
 Fri, 27 Nov 2026 19:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795806778;
 bh=lmlpJhMwl6wlGT0M6hE6nj8NniBYUJFqAq3ZbWlo3sw=;
 h=From:To:Cc:Subject:Date;
 b=XAzApeNyoK1z5EKPmLZTdtwVxd5d5TW69oJ77O2SCmlrWUqPqXWQkc1RuqD8xaiTw
 0qFQyDtqK3nDVtIRH3iQYEExfm4dDcLLOXUmuEx/t8I1Z+NSGbXitm2I8HVeau5H33
 vYqOK1m9tAGcE4xGmjHGHZNDlkzwQH5zQ7eJKHlN406Y6elCz4VcRWJ+mVNrpufqP+
 012ZWa1bXiqTllpPVZCMGe1tQxnTxDTeUzytA+UJak9P6s3g7yTAC4vyNyThC9itSz
 /fF4e5/dGkP7L/9VDJ/2Z8F86SWXLhPHylAtwa/a7MBgtvbz53V7lNyZxRxyGZ/Dm9
 zKSr2LldV3bZA==
From: Niklas Cassel <cassel@kernel.org>
To: John Snow <jsnow@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 00/13] hw/ide: add missing features required for SATA
Date: Fri, 27 Nov 2026 20:12:35 +0100
Message-ID: <20261127191250.3298004-1-cassel@kernel.org>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=cassel@kernel.org;
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

This series implements mandatory features that should be implemented by
a SATA disk:

-Sense data reporting
-General Purpose Logging
-NCQ Command Error log
-SATA NCQ Send and Receive log
-Serial ATA page of the IDENTIFY DEVICE data log

All these features are added so that we eventually can add ZAC (Zoned
device ATA Command set) support, which requires all this to e.g. report
sense data unaligned write command when not writing at the write pointer.

However, all patches in this series are unrelated to ZAC and can be
accepted as is. E.g. this series adds a range check and reports sense data
LOGICAL BLOCK ADDRESS OUT OF RANGE, if the user tries to read or write an
LBA outside the LBA range.


Kind regards,
Niklas


Niklas Cassel (13):
  hw/ide: report the SMART state in IDENTIFY DEVICE
  hw/ide/ahci: stop processing commands after a fatal error
  hw/ide/ahci: clear a stale error status when an NCQ command is queued
  hw/ide/ahci: complete unsupported NCQ commands
  hw/ide: add General Purpose Logging (GPL) feature set support
  hw/ide: add the IDENTIFY DEVICE data log
  hw/ide/ahci: add RECEIVE FPDMA QUEUED support
  hw/ide: add Sense Data Reporting feature set support
  hw/ide: implement the NCQ Command Error log (10h)
  tests/qtest/libqos: skip some checks for commands expected to fail
  hw/ide: report out-of-range accesses as ILLEGAL REQUEST
  hw/ide/ahci: check the LBA range of NCQ commands
  hw/ide: report ACS-6 compliance behind AHCI

 hw/ide/ahci-internal.h    |   8 +
 hw/ide/ahci.c             | 219 ++++++++++--
 hw/ide/core.c             | 689 ++++++++++++++++++++++++++++++++++---
 hw/ide/ide-internal.h     |  44 ++-
 hw/ide/trace-events       |   2 +
 include/hw/ide/ide-dev.h  |  22 ++
 tests/qtest/ahci-test.c   | 708 ++++++++++++++++++++++++++++++++++++++
 tests/qtest/ide-test.c    |   5 +
 tests/qtest/libqos/ahci.c |  40 ++-
 tests/qtest/libqos/ahci.h |  18 +-
 10 files changed, 1682 insertions(+), 73 deletions(-)


base-commit: 29760efaf96bbe5928f8111881eddbf5ac06439e
-- 
2.56.1


