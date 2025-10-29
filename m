Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56518CCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 12:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE4xb-0003Mu-FY; Wed, 29 Oct 2025 08:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vE4xG-00036S-GF
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 08:07:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vE4wz-0004vc-Mz
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 08:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761739601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=K3Gfvua3LOj+dpPWNmyb15ZTsvApu33scHVViwU9fEE=;
 b=VhzdjVwmZY9otmpbq8vpY5p50jXJlzg1gBQDXuW+BboXuLc3agMa+imFvoOzGONyQNAMzt
 I27jsOS4MUZsY6Lob+TyUaA6zGHyF3or4+UQwvhL5/MhmxrGE0+/jlRDPfpRkwPEdR0YgX
 1VCOhikZMv/EWgHd53sc1IinMmf0pK8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-1daE851hMD-3EzmgOW9-Xg-1; Wed,
 29 Oct 2025 08:06:39 -0400
X-MC-Unique: 1daE851hMD-3EzmgOW9-Xg-1
X-Mimecast-MFC-AGG-ID: 1daE851hMD-3EzmgOW9-Xg_1761739598
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C0FED1954112; Wed, 29 Oct 2025 12:06:38 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.33.204])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 65963180057C; Wed, 29 Oct 2025 12:06:37 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 00/18] Block layer patches
Date: Wed, 29 Oct 2025 13:06:16 +0100
Message-ID: <20251029120634.288467-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit bc831f37398b51dfe65d99a67bcff9352f84a9d2:

  Merge tag 'hw-misc-20251028' of https://github.com/philmd/qemu into staging (2025-10-28 11:48:05 +0100)

are available in the Git repository at:

  https://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 911992fd6ec7a84c7cc82831b4bcd8a2ca5ccc76:

  qemu-img info: Add cache mode option (2025-10-29 12:10:10 +0100)

----------------------------------------------------------------
Block layer patches

- Expose block limits in monitor and qemu-img info
- Resize: Refresh filter node size when its child was resized
- Support configuring stats-intervals in -device (instead of only -drive)
- luks: Fix QMP x-blockdev-amend crash and image creation with detached-header
- iotests: Several test case fixes
- Code cleanups

----------------------------------------------------------------
Bin Guo (1):
      block/monitor: Use hmp_handle_error to report error

Chandan Somani (1):
      block: enable stats-intervals for storage devices

Daniel P. Berrangé (2):
      block: remove 'detached-header' option from opts after use
      block: fix luks 'amend' when run in coroutine

Eric Blake (2):
      iotests: Adjust nbd expected outputs to match current behavior
      iotests: Adjust fuse-allow-other expected output

Fiona Ebner (5):
      include/block/block_int-common: document when resize callback is used
      block: make bdrv_co_parent_cb_resize() a proper IO API function
      block: implement 'resize' callback for child_of_bds class
      iotests: add test for resizing a node below filters
      iotests: add test for resizing a 'file' node below a 'raw' node

Kevin Wolf (4):
      block: Improve comments in BlockLimits
      block: Expose block limits for images in QMP
      qemu-img info: Optionally show block limits
      qemu-img info: Add cache mode option

Peter Maydell (1):
      MAINTAINERS: Mark VHDX block driver as "Odd Fixes"

Richard W.M. Jones (1):
      block/curl.c: Fix CURLOPT_VERBOSE parameter type

Thomas Huth (1):
      tests/qemu-iotests: Mark the 'inactive-node-nbd' as unsupported with -luks

 qapi/block-core.json                             | 66 +++++++++++++++++++++
 docs/tools/qemu-img.rst                          |  6 +-
 include/block/accounting.h                       |  5 +-
 include/block/block_int-common.h                 | 35 +++++++-----
 include/block/block_int-io.h                     |  6 ++
 include/block/qapi.h                             |  2 +-
 include/hw/block/block.h                         |  7 ++-
 block.c                                          | 12 ++++
 block/accounting.c                               | 17 +++++-
 block/crypto.c                                   | 32 ++++++++---
 block/curl.c                                     |  2 +-
 block/io.c                                       |  9 +--
 block/monitor/block-hmp-cmds.c                   | 45 ++++++++-------
 block/qapi.c                                     | 66 +++++++++++++++++++--
 blockdev.c                                       |  3 +-
 hw/block/block.c                                 |  7 ++-
 qemu-img.c                                       | 40 ++++++++++---
 MAINTAINERS                                      |  2 +-
 qemu-img-cmds.hx                                 |  4 +-
 tests/qemu-iotests/094.out                       |  2 +-
 tests/qemu-iotests/119.out                       |  2 +-
 tests/qemu-iotests/172.out                       | 38 ++++++++++++
 tests/qemu-iotests/184                           |  5 +-
 tests/qemu-iotests/184.out                       |  8 ---
 tests/qemu-iotests/267.out                       |  8 +--
 tests/qemu-iotests/common.filter                 |  3 +-
 tests/qemu-iotests/tests/fuse-allow-other.out    |  6 +-
 tests/qemu-iotests/tests/inactive-node-nbd       |  1 +
 tests/qemu-iotests/tests/resize-below-filter     | 73 ++++++++++++++++++++++++
 tests/qemu-iotests/tests/resize-below-filter.out |  5 ++
 tests/qemu-iotests/tests/resize-below-raw        | 53 +++++++++++++++++
 tests/qemu-iotests/tests/resize-below-raw.out    |  5 ++
 32 files changed, 479 insertions(+), 96 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/resize-below-filter
 create mode 100644 tests/qemu-iotests/tests/resize-below-filter.out
 create mode 100755 tests/qemu-iotests/tests/resize-below-raw
 create mode 100644 tests/qemu-iotests/tests/resize-below-raw.out


