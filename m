Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 576B6FEC0F7
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 18:57:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w56vf-0004h3-Pl; Tue, 24 Mar 2026 14:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w56vd-0004gW-B0
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 14:56:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w56vb-0006fF-MF
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 14:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774378593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=cYgem9In47JR8ofzsY52qtoXm5fvJETaTnvFEJHGZkk=;
 b=e5M7CVm8IKJc5LQoP+KZ84UIFej9VKf1H8atwx7bf6oUkEMFvm6G6NNI4+I5Iv6Jkocfld
 /26bUrRbcsXWPeDa8EPMyBpyL2+w63yOTNPRqBgZxPF8b68WGpCzxPl2okJfaH0cqjXrst
 tO2v2RT8t7h1v45ILAxMCwZNOokm8DA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-5RDR4bXwPg6qBl8vOkFyrw-1; Tue,
 24 Mar 2026 14:56:31 -0400
X-MC-Unique: 5RDR4bXwPg6qBl8vOkFyrw-1
X-Mimecast-MFC-AGG-ID: 5RDR4bXwPg6qBl8vOkFyrw_1774378590
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A4F6D19560A1; Tue, 24 Mar 2026 18:56:30 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.33.246])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DCC5E3000223; Tue, 24 Mar 2026 18:56:28 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 0/4] Block layer patches
Date: Tue, 24 Mar 2026 19:56:15 +0100
Message-ID: <20260324185619.296946-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit fa4b2e31e649ba6fdb3eb2dd43952aad4a3bd675:

  Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging (2026-03-24 10:41:21 +0000)

are available in the Git repository at:

  https://gitlab.com/kmwolf/qemu.git tags/for-upstream

for you to fetch changes up to cf9cdaea6e24d13dfdf8402f6829d2ca4dca864b:

  io-uring: Resubmit tails of short writes (2026-03-24 19:55:09 +0100)

----------------------------------------------------------------
Block layer patches

- linux-aio/io-uring: Resubmit tails of short reads/writes
- curl: Fix memory leak

----------------------------------------------------------------
GuoHan Zhao (1):
      block/curl: free s->password in cleanup paths

Hanna Czenczek (3):
      linux-aio: Put all parameters into qemu_laiocb
      linux-aio: Resubmit tails of short reads/writes
      io-uring: Resubmit tails of short writes

 block/curl.c       |  2 ++
 block/io_uring.c   | 82 +++++++++++++++++++++++++++-----------------------
 block/linux-aio.c  | 88 +++++++++++++++++++++++++++++++++++++++++++-----------
 block/trace-events |  2 +-
 4 files changed, 119 insertions(+), 55 deletions(-)


