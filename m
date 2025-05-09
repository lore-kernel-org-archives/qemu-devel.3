Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C44C3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 20:44:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDUZZ-0004DY-6y; Fri, 09 May 2025 16:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uDUZX-0004Ct-3F
 for qemu-devel@nongnu.org; Fri, 09 May 2025 16:43:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uDUZV-0000gV-7l
 for qemu-devel@nongnu.org; Fri, 09 May 2025 16:43:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746823430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TDzs/SE5tSFtO131kRfytk5X0AenQ26s6wXUnV6+Kng=;
 b=aElP4LkqlJQQU5Rj2a0QdT4Zp7S/tXsy/jjdK5Jq7RhO2XTQRDIJxIPGSBGnIGh7ohMZJS
 +je9dubIVudSUAtGLLpArFE/gUJJunxhbSVDKMmb+Uj+xSF0Aws1KmMg85DGJfanmAfVdn
 2Qwrq1OsF5yTwpbg0QeXZmy6PEpPiA4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-287-ptnRCICwMAmQ0csWp_xOyw-1; Fri,
 09 May 2025 16:43:47 -0400
X-MC-Unique: ptnRCICwMAmQ0csWp_xOyw-1
X-Mimecast-MFC-AGG-ID: ptnRCICwMAmQ0csWp_xOyw_1746823426
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 596391800370; Fri,  9 May 2025 20:43:46 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.43])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7F8E930001A1; Fri,  9 May 2025 20:43:44 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, sunnyzhyy@qq.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru
Subject: [PATCH v4 00/13] Make blockdev-mirror dest sparse in more cases
Date: Fri,  9 May 2025 15:40:17 -0500
Message-ID: <20250509204341.3553601-15-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

v3 was here:
https://lists.gnu.org/archive/html/qemu-devel/2025-04/msg04525.html

In v4:
 - Rearrange series a bit to try and simplify logic for how zero
   bitmap is populated, when pre-zeroing is attempted, and how
   detect-zeroes=unmap interacts [Sunny]
 - Add a couple new patches to make this easier to follow
 - iotest tweaks [Stefan]

001/13:[----] [--] 'block: Expand block status mode from bool to flags'
002/13:[----] [--] 'file-posix, gluster: Handle zero block status hint better'
003/13:[----] [--] 'block: Let bdrv_co_is_zero_fast consolidate adjacent extents'
004/13:[----] [--] 'block: Add new bdrv_co_is_all_zeroes() function'
005/13:[----] [--] 'iotests: Improve iotest 194 to mirror data'
006/13:[----] [--] 'mirror: Minor refactoring'
007/13:[down] 'mirror: Pass full sync mode rather than bool to internals'
008/13:[0038] [FC] 'mirror: Allow QMP override to declare target already zero'
009/13:[down] 'mirror: Drop redundant zero_target parameter'
010/13:[0063] [FC] 'mirror: Skip pre-zeroing destination if it is already zero'
011/13:[0021] [FC] 'mirror: Skip writing zeroes when target is already zero'
012/13:[----] [--] 'iotests/common.rc: add disk_usage function'
013/13:[0013] [FC] 'tests: Add iotest mirror-sparse for recent patches'

Andrey Drobyshev (1):
  iotests/common.rc: add disk_usage function

Eric Blake (12):
  block: Expand block status mode from bool to flags
  file-posix, gluster: Handle zero block status hint better
  block: Let bdrv_co_is_zero_fast consolidate adjacent extents
  block: Add new bdrv_co_is_all_zeroes() function
  iotests: Improve iotest 194 to mirror data
  mirror: Minor refactoring
  mirror: Pass full sync mode rather than bool to internals
  mirror: Allow QMP override to declare target already zero
  mirror: Drop redundant zero_target parameter
  mirror: Skip pre-zeroing destination if it is already zero
  mirror: Skip writing zeroes when target is already zero
  tests: Add iotest mirror-sparse for recent patches

 qapi/block-core.json                       |   8 +-
 block/coroutines.h                         |   4 +-
 include/block/block-common.h               |  11 +
 include/block/block-io.h                   |   2 +
 include/block/block_int-common.h           |  27 +-
 include/block/block_int-global-state.h     |   4 +-
 include/block/block_int-io.h               |   4 +-
 block/io.c                                 | 126 +++++--
 block/blkdebug.c                           |   6 +-
 block/copy-before-write.c                  |   4 +-
 block/file-posix.c                         |   5 +-
 block/gluster.c                            |   4 +-
 block/iscsi.c                              |   6 +-
 block/mirror.c                             | 183 ++++++++---
 block/nbd.c                                |   4 +-
 block/null.c                               |   6 +-
 block/parallels.c                          |   6 +-
 block/qcow.c                               |   2 +-
 block/qcow2.c                              |   6 +-
 block/qed.c                                |   6 +-
 block/quorum.c                             |   4 +-
 block/raw-format.c                         |   4 +-
 block/rbd.c                                |   6 +-
 block/snapshot-access.c                    |   4 +-
 block/vdi.c                                |   4 +-
 block/vmdk.c                               |   2 +-
 block/vpc.c                                |   2 +-
 block/vvfat.c                              |   6 +-
 blockdev.c                                 |  27 +-
 tests/unit/test-block-iothread.c           |   2 +-
 tests/qemu-iotests/common.rc               |   6 +
 tests/qemu-iotests/194                     |   7 +-
 tests/qemu-iotests/194.out                 |   4 +-
 tests/qemu-iotests/250                     |   5 -
 tests/qemu-iotests/iotests.py              |  12 +-
 tests/qemu-iotests/tests/mirror-sparse     | 125 +++++++
 tests/qemu-iotests/tests/mirror-sparse.out | 365 +++++++++++++++++++++
 37 files changed, 850 insertions(+), 159 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/mirror-sparse
 create mode 100644 tests/qemu-iotests/tests/mirror-sparse.out

-- 
2.49.0


