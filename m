Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E7FFD4F04
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 16:28:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzzv7-0003JQ-7T; Tue, 10 Mar 2026 12:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vzzur-0003Dk-8G
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:26:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vzzun-0000nV-4E
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773159994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yRjI+8/0Ddh3wV8ss6XXj/Nih3a9YT9spj6FPcDnXCE=;
 b=bkktCBgSKHPizL6kMOfWt1vmdMX6Ff2Rs18cSyXNvlQIUdnFpTLw4jUfHDHpG9Qq5gbiyo
 sCPTUxCNA4KBgPFD8KxtGNUTkmo3871zShMfzb6KyrhbNUSYUkcdRxM+GCfU++M5NQrt1O
 90S8gzMCBX9lV5WGdUmMXWu7nHzWDdw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-140-aSvE0XEwPDeWy4a1l1z1zg-1; Tue,
 10 Mar 2026 12:26:31 -0400
X-MC-Unique: aSvE0XEwPDeWy4a1l1z1zg-1
X-Mimecast-MFC-AGG-ID: aSvE0XEwPDeWy4a1l1z1zg_1773159990
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 397681956066; Tue, 10 Mar 2026 16:26:30 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.224.112])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E0ECF1955D81; Tue, 10 Mar 2026 16:26:28 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 00/28] Block layer patches
Date: Tue, 10 Mar 2026 17:25:54 +0100
Message-ID: <20260310162622.333137-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit 31ee190665dd50054c39cef5ad740680aabda382:

  Merge tag 'hw-misc-20260309' of https://github.com/philmd/qemu into staging (2026-03-09 17:19:26 +0000)

are available in the Git repository at:

  https://gitlab.com/kmwolf/qemu.git tags/for-upstream

for you to fetch changes up to 7b13fc97d7235006d2ccc7a132ecb70802ba258f:

  block/curl: add support for S3 presigned URLs (2026-03-10 15:48:48 +0100)

----------------------------------------------------------------
Block layer patches

- export/fuse: Use coroutines and multi-threading
- curl: Add force-range option
- nfs: add support for libnfs v6

----------------------------------------------------------------
Antoine Damhet (2):
      qapi: block: Refactor HTTP(s) common arguments
      block/curl: add support for S3 presigned URLs

Hanna Czenczek (25):
      fuse: Copy write buffer content before polling
      fuse: Ensure init clean-up even with error_fatal
      fuse: Remove superfluous empty line
      fuse: Explicitly set inode ID to 1
      fuse: Change setup_... to mount_fuse_export()
      fuse: Destroy session on mount_fuse_export() fail
      fuse: Fix mount options
      fuse: Set direct_io and parallel_direct_writes
      fuse: Introduce fuse_{at,de}tach_handlers()
      fuse: Introduce fuse_{inc,dec}_in_flight()
      fuse: Add halted flag
      fuse: fuse_{read,write}: Rename length to blk_len
      iotests/308: Use conv=notrunc to test growability
      fuse: Explicitly handle non-grow post-EOF accesses
      block: Move qemu_fcntl_addfl() into osdep.c
      fuse: Drop permission changes in fuse_do_truncate
      fuse: Manually process requests (without libfuse)
      fuse: Reduce max read size
      fuse: Process requests in coroutines
      block/export: Add multi-threading interface
      iotests/307: Test multi-thread export interface
      fuse: Make shared export state atomic
      fuse: Implement multi-threading
      qapi/block-export: Document FUSE's multi-threading
      iotests/308: Add multi-threading sanity test

Peter Lieven (1):
      block/nfs: add support for libnfs v6

 qapi/block-core.json                          |   21 +-
 qapi/block-export.json                        |   41 +-
 docs/system/device-url-syntax.rst.inc         |    6 +
 include/block/export.h                        |   12 +-
 include/qemu/osdep.h                          |    1 +
 block/curl.c                                  |  104 +-
 block/export/export.c                         |   48 +-
 block/export/fuse.c                           | 1311 +++++++++++++++++++------
 block/export/vduse-blk.c                      |    7 +
 block/export/vhost-user-blk-server.c          |    8 +
 block/file-posix.c                            |   17 +-
 block/nfs.c                                   |   50 +-
 nbd/server.c                                  |    6 +
 util/osdep.c                                  |   18 +
 block/trace-events                            |    1 +
 meson.build                                   |    2 +-
 tests/qemu-iotests/307                        |   47 +
 tests/qemu-iotests/307.out                    |   18 +
 tests/qemu-iotests/308                        |   95 +-
 tests/qemu-iotests/308.out                    |   71 +-
 tests/qemu-iotests/tests/fuse-allow-other     |    3 +-
 tests/qemu-iotests/tests/fuse-allow-other.out |    9 +-
 22 files changed, 1506 insertions(+), 390 deletions(-)


