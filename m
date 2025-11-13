Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED0FCD4F26
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 01:17:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJLx1-0002HR-6G; Wed, 12 Nov 2025 20:16:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vJLwz-00029U-NP
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 20:16:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vJLwx-0005lQ-5H
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 20:16:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762996593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+O30LwMdH0WDLlpjubjxcO65FQQfeH67u64CSy4eQCQ=;
 b=Kog1Wbt1MrBjSBBWFgLyTXJlwn9uH6ox+TTWOkag3NM1FfXx0W8N/RqvSByT0dRmexenzD
 5Iy3B4yXWZx0Phj5WqmY7zvSzaUzzPoeMXZJnlz1U+Q9fp6mYk57xfZvj1TbXiH1hZBE7r
 Xhnl0crQktLCeGJZ0JYIVBW32gSZMEA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-ed7znSdCMlmcE-4JVQXvlA-1; Wed,
 12 Nov 2025 20:16:30 -0500
X-MC-Unique: ed7znSdCMlmcE-4JVQXvlA-1
X-Mimecast-MFC-AGG-ID: ed7znSdCMlmcE-4JVQXvlA_1762996589
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7A750195608E; Thu, 13 Nov 2025 01:16:29 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.87])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C2EFF1800451; Thu, 13 Nov 2025 01:16:27 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	kwolf@redhat.com,
	berrange@redhat.com
Subject: [PATCH v3 for-10.2 00/13] Fix deadlock with bdrv_open of self-served
 NBD
Date: Wed, 12 Nov 2025 19:11:25 -0600
Message-ID: <20251113011625.878876-15-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

v2 was here:
https://lists.nongnu.org/archive/html/qemu-devel/2025-11/msg01243.html

Since then:
 - drop patch 7/12; refcounting for GSource case is now unchanged
 - add a couple of patches: fix a chardev leaky abstraction, and add a
   mutex lock for cross-thread safety
 - improve commit messages to document why NBD is safe now, even without
   adding notify callbacks to AioContext

Now that the new behavior is opt-in rather than a change of defaults,
and only NBD opts in, it should still be safe to include in 10.2.
But the technical debt here means that we really should consider
improving the AioContext API for 11.0 to allow for a notify function
similar to what GSource provides.

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/13:[----] [--] 'iotests: Drop execute permissions on vvfat.out'
002/13:[----] [--] 'qio: Add trace points to net_listener'
003/13:[----] [--] 'qio: Unwatch before notify in QIONetListener'
004/13:[----] [--] 'qio: Remember context of qio_net_listener_set_client_func_full'
005/13:[down] 'qio: Protect NetListener callback with mutex'
006/13:[----] [-C] 'qio: Minor optimization when callback function is unchanged'
007/13:[0042] [FC] 'qio: Factor out helpers qio_net_listener_[un]watch'
008/13:[down] 'chardev: Reuse channel's cached local address'
009/13:[0053] [FC] 'qio: Provide accessor around QIONetListener->sioc'
010/13:[0013] [FC] 'qio: Prepare NetListener to use AioContext'
011/13:[0041] [FC] 'qio: Add QIONetListener API for using AioContext'
012/13:[----] [--] 'nbd: Avoid deadlock in client connecting to same-process server'
013/13:[----] [--] 'iotests: Add coverage of recent NBD qio deadlock fix'

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

 include/io/channel-socket.h                   |   2 +-
 include/io/net-listener.h                     |  71 ++++-
 blockdev-nbd.c                                |   4 +-
 chardev/char-socket.c                         |   2 +-
 io/net-listener.c                             | 300 +++++++++++++-----
 migration/socket.c                            |   4 +-
 ui/vnc.c                                      |  34 +-
 io/trace-events                               |   5 +
 tests/qemu-iotests/tests/nbd-in-qcow2-chain   |  94 ++++++
 .../qemu-iotests/tests/nbd-in-qcow2-chain.out |  75 +++++
 tests/qemu-iotests/tests/vvfat.out            |   0
 11 files changed, 498 insertions(+), 93 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/nbd-in-qcow2-chain
 create mode 100644 tests/qemu-iotests/tests/nbd-in-qcow2-chain.out
 mode change 100755 => 100644 tests/qemu-iotests/tests/vvfat.out

-- 
2.51.1


