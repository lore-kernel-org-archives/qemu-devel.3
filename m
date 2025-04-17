Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6635CC369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 18:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5UBR-0003oj-8M; Thu, 17 Apr 2025 14:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u5UBH-0003ip-EZ
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 14:41:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u5UBE-0002mk-VB
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 14:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744915302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vPnhjydzAeT6IKAZ+PbPO6c9xezPNa1amtRltp9JrWo=;
 b=ODKCPA6oHJHf2v6iw5YJYcB6BnBSNn1Zcc0naKIExmnzJg7yfvG6Uz5jf1PytLL8cjI2Hu
 qFpkViLcPd1Dzqr+XHU7xNrL4EhlfXRGafWTx45REte3qQIScfGx0Ik/UcADVmE+mtu9hz
 asnbm7qfrJJTAC9nai+mEsyEMSrA5uo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-_mfQsvm3P3K87cxggz8pIQ-1; Thu,
 17 Apr 2025 14:41:39 -0400
X-MC-Unique: _mfQsvm3P3K87cxggz8pIQ-1
X-Mimecast-MFC-AGG-ID: _mfQsvm3P3K87cxggz8pIQ_1744915298
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 29B241955D81; Thu, 17 Apr 2025 18:41:37 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.121])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E1C471955E96; Thu, 17 Apr 2025 18:41:35 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PATCH v2 00/11] Make blockdev-mirror dest sparse in more cases
Date: Thu, 17 Apr 2025 13:39:05 -0500
Message-ID: <20250417184133.105746-13-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

V1 was here: https://lists.gnu.org/archive/html/qemu-devel/2025-04/msg01654.html

In v2:
 - Rearrange and split several patches
 - Fewer changes to file-posix.c; instead,
 - New bdrv_co_is_all_zeroes() in io.c, which works on both file-posix and NBD
 - Clean up several corner cases spotted during review
 - Better iotest coverage, required pulling in Andrey's patch for disk_usage

Andrey Drobyshev (1):
  iotests/common.rc: add disk_usage function

Eric Blake (10):
  block: Expand block status mode from bool to enum
  file-posix: Handle zero block status hint better
  block: Let bdrv_co_is_zero_fast consolidate adjacent extents
  block: Add new bdrv_co_is_all_zeroes() function
  iotests: Improve iotest 194 to mirror data
  mirror: Minor refactoring
  mirror: Skip pre-zeroing destination if it is already zero
  mirror: Skip writing zeroes when target is already zero
  tests: Add iotest mirror-sparse for recent patches
  mirror: Allow QMP override to declare target already zero

 qapi/block-core.json                       |   8 +-
 block/coroutines.h                         |   4 +-
 include/block/block-common.h               |  26 ++++
 include/block/block-io.h                   |   2 +
 include/block/block_int-common.h           |  25 ++--
 include/block/block_int-global-state.h     |   3 +-
 include/block/block_int-io.h               |   4 +-
 block/io.c                                 | 120 ++++++++++++----
 block/blkdebug.c                           |   6 +-
 block/copy-before-write.c                  |   4 +-
 block/file-posix.c                         |   5 +-
 block/gluster.c                            |   4 +-
 block/iscsi.c                              |   6 +-
 block/mirror.c                             | 121 +++++++++++++---
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
 blockdev.c                                 |  18 ++-
 tests/unit/test-block-iothread.c           |   4 +-
 tests/qemu-iotests/common.rc               |   6 +
 tests/qemu-iotests/194                     |   1 +
 tests/qemu-iotests/250                     |   5 -
 tests/qemu-iotests/tests/mirror-sparse     | 109 +++++++++++++++
 tests/qemu-iotests/tests/mirror-sparse.out | 153 +++++++++++++++++++++
 35 files changed, 571 insertions(+), 125 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/mirror-sparse
 create mode 100644 tests/qemu-iotests/tests/mirror-sparse.out

-- 
2.49.0


