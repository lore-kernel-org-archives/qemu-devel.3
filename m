Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F79CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 20:30:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG1B1-0003mk-5R; Mon, 03 Nov 2025 15:29:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vG1Ap-0003dw-IA
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 15:29:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vG1Ai-0007dG-Dx
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 15:29:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762201735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0XUARyoeMr/WblAxm6qKqDhZSxHc0wYCo4+p7f3O/Ig=;
 b=YPq1ymW0vfI9zJhRiDe+0wktQv9Nl+mX2/KrjNfE38RdgPVV8LeIYd6v9m39OKh31kh3kX
 EMi8AmsizL0ygNG000+9LsK8+0/8aQiPLcOdNbPLd6VtqHf+4sS2Zm7PcMiTekVgqdCjlD
 XGxtzEB4PVCd4JYFolNGJLImOpoUTJo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-SEV3c5hiNfe7LY0LtYYFhw-1; Mon,
 03 Nov 2025 15:28:54 -0500
X-MC-Unique: SEV3c5hiNfe7LY0LtYYFhw-1
X-Mimecast-MFC-AGG-ID: SEV3c5hiNfe7LY0LtYYFhw_1762201733
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2AA1D180035D; Mon,  3 Nov 2025 20:28:53 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.131])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F044030001A1; Mon,  3 Nov 2025 20:28:51 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	berrange@redhat.com,
	kwolf@redhat.com
Subject: [PATCH 0/8] Fix deadlock with bdrv_open of self-served NBD
Date: Mon,  3 Nov 2025 14:10:51 -0600
Message-ID: <20251103202849.3687643-10-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

https://gitlab.com/qemu-project/qemu/-/issues/3169 was an excellent
bug report of a deadlock scenario when qemu opens both the server and
client end of an NBD intermediary in a qcow2 backing chain.  It took
me quite a bit of time to understand why the deadlock was even
happening, and then some mental gymnastics on how best to break the
deadlock.  Ideally - we'd get rid of all nested event loops, and have
the main loop do EVERYTHING event-driven.  But that's a much bigger
code change to the entire code base of QEMU, so I went with the next
best thing of keeping the AioContext nested loop but ensuring that
accepting NBD clients is now properly part of the AioContext rather
than gated by only the main loop progress.

I have not researched how long the deadlock has been present, to
determine if it has ever worked before earlier refactorings when we
started using AioContext more heavily, or if it has always been broken
until now to try and connect QEMU as a client to a self-served NBD
server.  But either way, I think this series should be part of the
10.2 release; I'm awfully close to soft freeze, but I think this
counts as a bug fix worth having even if it doesn't make it in before
-rc1.

Eric Blake (8):
  qio: Add trace points to net_listener
  qio: Minor optimization when callback function is unchanged
  qio: Remember context of qio_net_listener_set_client_func_full
  qio: Factor out helpers qio_net_listener_[un]watch
  qio: Let listening sockets remember their owning QIONetListener
  qio: Hoist ref of listener outside loop
  qio: Use AioContext for default-context QIONetListener
  iotests: Add coverage of recent NBD qio deadlock fix

 include/io/channel-socket.h                   |   1 +
 include/io/net-listener.h                     |   1 +
 io/channel-socket.c                           |   1 +
 io/net-listener.c                             | 136 +++++++++++-------
 io/trace-events                               |   5 +
 tests/qemu-iotests/tests/nbd-in-qcow2-chain   |  84 +++++++++++
 .../qemu-iotests/tests/nbd-in-qcow2-chain.out |  56 ++++++++
 tests/qemu-iotests/tests/vvfat.out            |   0
 8 files changed, 236 insertions(+), 48 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/nbd-in-qcow2-chain
 create mode 100644 tests/qemu-iotests/tests/nbd-in-qcow2-chain.out
 mode change 100755 => 100644 tests/qemu-iotests/tests/vvfat.out

-- 
2.51.1


