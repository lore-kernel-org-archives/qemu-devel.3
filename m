Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFEBCCFA13
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Nov 2025 23:19:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHs0B-0005T9-DK; Sat, 08 Nov 2025 18:05:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vHs02-0005Me-Eh
 for qemu-devel@nongnu.org; Sat, 08 Nov 2025 18:05:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vHs00-0001cb-2D
 for qemu-devel@nongnu.org; Sat, 08 Nov 2025 18:05:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762643131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CNKywIXsglt9/Z5uwcUvgJDkV2Nfoh+iqaZMPfeFy9g=;
 b=UilgvCzHYe3UZyzD36wFYbGhCrKOQ1s+Zn1yHoyI8zqfxQ1iHPyUoYNmP1m/vWBjQU6Hdh
 pGsJhtLXWwlIv3KYfXrgM5hTr/SDMy5fNi1v5IIRAxxdBLZR4xBI/rCvnDNafK7qiI0ZGv
 rej/PA4lgBdfw0Q7xIab1+/IXNpttQc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-204-Q58P6JgrO7iqMXeGH0jllQ-1; Sat,
 08 Nov 2025 18:05:30 -0500
X-MC-Unique: Q58P6JgrO7iqMXeGH0jllQ-1
X-Mimecast-MFC-AGG-ID: Q58P6JgrO7iqMXeGH0jllQ_1762643129
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 80906195608F; Sat,  8 Nov 2025 23:05:29 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A424819560B0; Sat,  8 Nov 2025 23:05:27 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	berrange@redhat.com,
	kwolf@redhat.com
Subject: [PATCH v2 00/12] Fix deadlock with bdrv_open of self-served NBD
Date: Sat,  8 Nov 2025 16:59:21 -0600
Message-ID: <20251108230525.3169174-14-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

v1 was here:
https://lore.kernel.org/qemu-devel/20251103202849.3687643-10-eblake@redhat.com/T/#t

In v2:
 - split or otherwise add a few patches
 - reorder latent bug fixes earlier in series
 - improved commit messages
 - improved consistency in trace naming, and make traces unconditional
 - rearrange contents of QIONetListener rather than adding field to
   QIOChannelSocket
 - add new opt-in API rather than retro-fitting existing
   qio_net_listener_set_client_func
 - use existing QIO aio functions rather than lower-level aio.h functions
 - further enhance iotest
See individual patches for more details on changes since v1.  The series
is different enough that I did not preserve any Reviewed-by tags from v1.

A deadlock fix counts as a bug fix, so even though this missed soft
freeze, I'm hoping we can get it in -rc1 or at the latest -rc2.  But
it's also not a new regression, but a long-standing issue; so if it
slides into 11.0 out of concerns of being too risky this close to
release, I understand.

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/12:[down] 'iotests: Drop execute permissions on vvfat.out'
002/12:[0027] [FC] 'qio: Add trace points to net_listener'
003/12:[down] 'qio: Unwatch before notify in QIONetListener'
004/12:[0026] [FC] 'qio: Remember context of qio_net_listener_set_client_func_full'
005/12:[0003] [FC] 'qio: Minor optimization when callback function is unchanged'
006/12:[0039] [FC] 'qio: Factor out helpers qio_net_listener_[un]watch'
007/12:[0002] [FC] 'qio: Hoist ref of listener outside loop'
	008/12:[down] 'qio: Provide accessor around QIONetListener->sioc'
009/12:[down] 'qio: Prepare NetListener to use AioContext'
010/12:[down] 'qio: Add QIONetListener API for using AioContext'
011/12:[down] 'nbd: Avoid deadlock in client connecting to same-process server'
012/12:[0035] [FC] 'iotests: Add coverage of recent NBD qio deadlock fix'

Eric Blake (12):
  iotests: Drop execute permissions on vvfat.out
  qio: Add trace points to net_listener
  qio: Unwatch before notify in QIONetListener
  qio: Remember context of qio_net_listener_set_client_func_full
  qio: Minor optimization when callback function is unchanged
  qio: Factor out helpers qio_net_listener_[un]watch
  qio: Hoist ref of listener outside loop
  qio: Provide accessor around QIONetListener->sioc
  qio: Prepare NetListener to use AioContext
  qio: Add QIONetListener API for using AioContext
  nbd: Avoid deadlock in client connecting to same-process server
  iotests: Add coverage of recent NBD qio deadlock fix

 include/io/net-listener.h                     |  47 +++-
 blockdev-nbd.c                                |   4 +-
 chardev/char-socket.c                         |   3 +-
 io/net-listener.c                             | 233 ++++++++++++------
 migration/socket.c                            |   5 +-
 ui/vnc.c                                      |  36 ++-
 io/trace-events                               |   5 +
 tests/qemu-iotests/tests/nbd-in-qcow2-chain   |  94 +++++++
 .../qemu-iotests/tests/nbd-in-qcow2-chain.out |  75 ++++++
 tests/qemu-iotests/tests/vvfat.out            |   0
 10 files changed, 411 insertions(+), 91 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/nbd-in-qcow2-chain
 create mode 100644 tests/qemu-iotests/tests/nbd-in-qcow2-chain.out
 mode change 100755 => 100644 tests/qemu-iotests/tests/vvfat.out

-- 
2.51.1


