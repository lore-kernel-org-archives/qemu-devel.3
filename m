Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F9EDC369A6
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 01:09:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u32s8-0006Kn-Vn; Thu, 10 Apr 2025 21:07:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u32rx-0006JF-Hi
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 21:07:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u32rv-0004HS-1Z
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 21:07:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744333659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4faTKVXahlYHxH7iEBWBsR4i+FLMgv9i32q1axtfMow=;
 b=aTh+LPllYLbZEcsS7zHE+PdkO2hLr6CZqcMZgjp/Wqa/BffidnBEW5yDTbHnwgjU1pAXBi
 vjUAIn/0D98+dlnNAHyMqNYCkNo0NSulOZzniQQMWPyPDjr1YJzAVU+df8jlGLVqDN3kGB
 8s9/P/Q8R8+GHxQDdEfc5VgqeHsKRzQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-a69O50y6MkWypZplNSsBLg-1; Thu,
 10 Apr 2025 21:07:36 -0400
X-MC-Unique: a69O50y6MkWypZplNSsBLg-1
X-Mimecast-MFC-AGG-ID: a69O50y6MkWypZplNSsBLg_1744333656
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 12DD01800361
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 01:07:36 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.21])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 934DB18009BC
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 01:07:34 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/6] Make blockdev-mirror dest sparse in more cases
Date: Thu, 10 Apr 2025 20:04:50 -0500
Message-ID: <20250411010732.358817-8-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.593,
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

When mirroring images, it makes sense for the destination to be sparse
even if it was not connected with "discard":"unmap"; the only time the
destination should be fully allocated is if the user pre-allocated it,
or if the source was not sparse.

Eric Blake (6):
  mirror: Skip pre-zeroing destination if it is already zero
  file-posix: Allow lseek at offset 0 when !want_zero
  mirror: Skip writing zeroes when target is already zero
  block: Expand block status mode from bool to enum
  file-posix: Recognize blockdev-create file as starting all zero
  tests: Add iotest mirror-sparse for recent patches

 block/coroutines.h                         |   4 +-
 include/block/block-common.h               |  26 ++++
 include/block/block_int-common.h           |  25 ++--
 include/block/block_int-io.h               |   4 +-
 block/io.c                                 |  51 +++----
 block/blkdebug.c                           |   6 +-
 block/copy-before-write.c                  |   4 +-
 block/file-posix.c                         |  94 +++++++++++--
 block/gluster.c                            |   4 +-
 block/iscsi.c                              |   6 +-
 block/mirror.c                             | 100 +++++++++++---
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
 tests/unit/test-block-iothread.c           |   2 +-
 tests/qemu-iotests/194                     |  15 +-
 tests/qemu-iotests/194.out                 |   4 +-
 tests/qemu-iotests/tests/mirror-sparse     | 100 ++++++++++++++
 tests/qemu-iotests/tests/mirror-sparse.out | 153 +++++++++++++++++++++
 30 files changed, 547 insertions(+), 113 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/mirror-sparse
 create mode 100644 tests/qemu-iotests/tests/mirror-sparse.out

-- 
2.49.0


