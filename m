Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F2C1CDB462
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 22:58:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJgEE-0006WG-VL; Thu, 13 Nov 2025 17:55:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vJgEB-0006JB-AA
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 17:55:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vJgE8-0000iL-WA
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 17:55:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763074538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=inbSWSOHGeBpKBaikq2zS8RPho/TBUsVCjlvCcGRCXc=;
 b=fIQAdbksfzv+y8z7NrLKD/fA/Iql3H2DWKxmYECpXhQIf4PtkuaJ0jBCFuq8PSb10DkkUO
 +6lyo8leiVzpitvYnrM7Q401XPJbfl/0VsThLSkKxdP8lv6nMV/6rCbKQ4GCswAGiUtJ2n
 tnEzjDCVtm//Bv5JTWiK7eKRo0tV/30=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-CbO11KKjMnaoSEcd1MIq3Q-1; Thu,
 13 Nov 2025 17:55:36 -0500
X-MC-Unique: CbO11KKjMnaoSEcd1MIq3Q-1
X-Mimecast-MFC-AGG-ID: CbO11KKjMnaoSEcd1MIq3Q_1763074536
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C8F5D180035F
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 22:55:35 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.22])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 567EB19540E8
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 22:55:35 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL for-10.2 00/15] NBD patches for 2025-11-13
Date: Thu, 13 Nov 2025 16:54:56 -0600
Message-ID: <20251113225531.1077484-17-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
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

The following changes since commit 9febfa94b69b7146582c48a868bd2330ac45037f:

  Merge tag 'for-upstream' of https://repo.or.cz/qemu/kevin into staging (2025-11-12 11:47:42 +0100)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2025-11-13

for you to fetch changes up to 4c91719a6a78a1c24d8bb854f7594e767962d0d9:

  tests/qemu-iotest: fix iotest 024 with qed images (2025-11-13 16:43:21 -0600)

----------------------------------------------------------------
NBD patches for 2025-11-13

- Fix NBD client deadlock when connecting to same-process server
- Several iotests improvements

----------------------------------------------------------------
Alberto Garcia (1):
      tests/qemu-iotest: fix iotest 024 with qed images

Eric Blake (13):
      iotests: Drop execute permissions on vvfat.out
      qio: Add trace points to net_listener
      qio: Unwatch before notify in QIONetListener
      qio: Remember context of qio_net_listener_set_client_func_full
      qio: Protect NetListener callback with mutex
      qio: Minor optimization when callback function is unchanged
      qio: Factor out helpers qio_net_listener_[un]watch
      chardev: Reuse channel's cached local address
      qio: Provide accessor around QIONetListener->sioc
      qio: Prepare NetListener to use AioContext
      qio: Add QIONetListener API for using AioContext
      nbd: Avoid deadlock in client connecting to same-process server
      iotests: Add coverage of recent NBD qio deadlock fix

Thomas Huth (1):
      tests/qemu-iotests: Fix broken grep command in iotest 207

 include/io/channel-socket.h                     |   2 +-
 include/io/net-listener.h                       |  71 +++++-
 blockdev-nbd.c                                  |   4 +-
 chardev/char-socket.c                           |   2 +-
 io/net-listener.c                               | 300 ++++++++++++++++++------
 migration/socket.c                              |   4 +-
 ui/vnc.c                                        |  34 ++-
 io/trace-events                                 |   5 +
 tests/qemu-iotests/024                          |   2 +-
 tests/qemu-iotests/024.out                      |   3 +-
 tests/qemu-iotests/207                          |   2 +-
 tests/qemu-iotests/tests/nbd-in-qcow2-chain     |  94 ++++++++
 tests/qemu-iotests/tests/nbd-in-qcow2-chain.out |  75 ++++++
 tests/qemu-iotests/tests/vvfat.out              |   0
 14 files changed, 501 insertions(+), 97 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/nbd-in-qcow2-chain
 create mode 100644 tests/qemu-iotests/tests/nbd-in-qcow2-chain.out
 mode change 100755 => 100644 tests/qemu-iotests/tests/vvfat.out

-- 
2.51.1


