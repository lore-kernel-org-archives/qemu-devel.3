Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A47CCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 09:25:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHeBD-0005oS-Ev; Fri, 16 Oct 2026 05:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daejun7.park@samsung.com>)
 id 1xHeB5-0005nw-TM
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:24:41 -0400
Received: from mailout1.samsung.com ([203.254.224.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daejun7.park@samsung.com>)
 id 1xHeB2-0004cS-BZ
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:24:39 -0400
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20261016092425epoutp010d9f8bc68fdacd103db5b438fb94b8ce~e_EJsKCK50523405234epoutp01v
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 09:24:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20261016092425epoutp010d9f8bc68fdacd103db5b438fb94b8ce~e_EJsKCK50523405234epoutp01v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1792142665;
 bh=Q8z30ThILf3z5sZb5cYHWaLVlH0oHhHC8PlCYQ4ofWc=;
 h=Subject:Reply-To:From:To:CC:Date:References:From;
 b=SXN04qzUNvosX18nqiocT1Q0WaDZ2Ctfsmg7HzporipC5sizCpRPa/HqHSP0hFzJ5
 IlYzSAeq3Q7jxB64YExPWSe28IDj+Pxulvj3d5GKEQSbNivf8G2PYtJlMJe73+jy53
 rpstmGAiKEHN5Byhxb9i2w5TYUVWpYpB3CpEDUHM=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTPS id
 20261016092425epcas2p25c1cfac165f4d08a403b886d5b011dce~e_EI4BH0O0311903119epcas2p27;
 Fri, 16 Oct 2026 09:24:25 +0000 (GMT)
Received: from epcas2p1.samsung.com (unknown [182.195.38.204]) by
 epsnrtp04.localdomain (Postfix) with ESMTP id 4j5ff05hv8z6B9mF; Fri, 16 Oct
 2026 09:24:24 +0000 (GMT)
Mime-Version: 1.0
Subject: [PATCH v2 0/6] Support for Zoned UFS
From: Daejun Park <daejun7.park@samsung.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Jeuk Kim <jeuk20.kim@samsung.com>, "farosas@suse.de" <farosas@suse.de>,
 "lvivier@redhat.com" <lvivier@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "hreitz@redhat.com" <hreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>, "pierrick.bouvier@oss.qualcomm.com"
 <pierrick.bouvier@oss.qualcomm.com>, Daejun Park <daejun7.park@samsung.com>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20261016092423epcms2p83f80a8dd8f7c1ddc3a94541e0771c306@epcms2p8>
Date: Fri, 16 Oct 2026 18:24:23 +0900
X-CMS-MailID: 20261016092423epcms2p83f80a8dd8f7c1ddc3a94541e0771c306
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261016092423epcms2p83f80a8dd8f7c1ddc3a94541e0771c306
References: <CGME20261016092423epcms2p83f80a8dd8f7c1ddc3a94541e0771c306@epcms2p8>
Received-SPF: pass client-ip=203.254.224.24;
 envelope-from=daejun7.park@samsung.com; helo=mailout1.samsung.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: daejun7.park@samsung.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This series lets a ufs-lu be a host-managed zoned block device (ZBC)
with zoned=on, so that the zoned storage stack, for example f2fs on
host-managed zones, can be tested on UFS without zoned UFS hardware.
Patches 1-3 fix the command path that the zoned code relies on and can
be merged first; patch 4 documents zoned logical units, patch 5 adds
them and patch 6 the tests.

Not modelled: persistent zone state, conventional and gap zones, and the
zoned UFS descriptor bits.

Tested with the UFS qtests (also under ASan and UBSan) and with Linux
7.3-rc7 and android17-6.18 guests, legacy doorbell and MCQ: fio
--zonemode=zbd with verification, blkzone, and f2fs on android17-6.18.

Changes in v2:
- Drop the hw/scsi patch: scsi-hd stays TYPE_DISK and ufs-lu reports
  TYPE_ZBC itself. With v1's TYPE_ZBC scsi-hd, MODE SENSE failed and the
  guest never sent a flush.
- New patches 1-3: a crash on commands without a PRDT, SYNCHRONIZE
  CACHE(16), and PRDTs longer than the CDB transfer length.
- Fix v1's REPORT ZONES buffer overflow, NULL zone dereference past the
  last zone, division by zero with zoned.zone_size=0, and its zone state
  handling.
- Move the write pointer back when a write fails or is aborted, reject
  UNMAP, drop zoned.zone_capacity.
- Add trace events, tests and documentation.
- Jeuk's Reviewed-by on v1 is not carried over, since both patches
  changed substantially.
- Link to v1: https://lore.kernel.org/qemu-devel/20231208060902epcms2p3810b29fefbddaf16a7f3f2758cf218ba@epcms2p3

---
Daejun Park (6):
      hw/ufs: Fail SCSI commands that move data without a PRDT
      hw/ufs: Pass SYNCHRONIZE CACHE(16) to scsi-hd as SYNCHRONIZE CACHE(10)
      hw/ufs: Limit data transfers to the transfer length of the CDB
      docs/system: Document zoned UFS logical units
      hw/ufs: Support for Zoned UFS
      tests/qtest: Add tests for Zoned UFS

 docs/system/devices/ufs.rst |   55 +++
 hw/ufs/lu.c                 |  886 ++++++++++++++++++++++++++++++++-
 hw/ufs/trace-events         |    6 +
 hw/ufs/ufs.h                |   36 ++
 include/block/ufs.h         |   27 +
 tests/qtest/ufs-test.c      | 1146 +++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 2151 insertions(+), 5 deletions(-)
---
base-commit: 7e8d3c7fc460fe7cd28a3e423d7466fa292bc269
change-id: 20261016-zoned-ufs-0a6c741446a9

Best regards,
-- 
Daejun Park <daejun7.park@samsung.com>

