Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B89DCD13D2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 18:22:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI9Xl-0002dR-7l; Wed, 29 Apr 2026 14:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wI9Xa-0002c2-1N
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:21:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wI9XW-0003hR-0H
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:21:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777486897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ICx7Yu2R3hEom1UEL7bRmS06S+s93ZJE8NPHznBOMk4=;
 b=F1msbSbVma3nfeW2jhHyfSYqMtiRcqfAaTfneR2NrYUqQPOaJvxbgDGU+URRQ83cUTicJ9
 eIsoGyVvlF7hmjhrURdT5qwJzrKwlVQiw0s2BcRlllaVmwcB9b+gC25K7tTXXtighPemF3
 rEjbAqIvNObINE2mJ1p5Zab0GWo0lh4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-EXoNP6YKMoKH8GvonJV72Q-1; Wed,
 29 Apr 2026 14:21:33 -0400
X-MC-Unique: EXoNP6YKMoKH8GvonJV72Q-1
X-Mimecast-MFC-AGG-ID: EXoNP6YKMoKH8GvonJV72Q_1777486892
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99B62195609D; Wed, 29 Apr 2026 18:21:31 +0000 (UTC)
Received: from localhost (unknown [10.44.33.46])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BA729180058B; Wed, 29 Apr 2026 18:21:29 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>, Hanna Reitz <hreitz@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: [PULL 0/3] Block patches
Date: Wed, 29 Apr 2026 14:21:24 -0400
Message-ID: <20260429182127.219776-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit 759c456b1d22fe4083c8b384da27d3f56fd53f82:

  Merge tag 'linux-user-next-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2026-04-27 12:57:33 -0400)

are available in the Git repository at:

  https://gitlab.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 9fea80ddf0f58fed94f7e6d7d5c9e0ccf5cff44a:

  qapi/iothread: introduce poll-weight parameter for aio-poll (2026-04-29 11:31:44 -0400)

----------------------------------------------------------------
Pull request

- Jaehoon Kim's AioContext polling CPU efficiency optimizations

----------------------------------------------------------------

Jaehoon Kim (3):
  aio-poll: avoid unnecessary polling time computation
  aio-poll: refine iothread polling using weighted handler intervals
  qapi/iothread: introduce poll-weight parameter for aio-poll

 qapi/misc.json                    |   6 ++
 qapi/qom.json                     |  10 +-
 include/qemu/aio.h                |   7 +-
 include/system/iothread.h         |  18 ++++
 util/aio-posix.h                  |   2 +-
 iothread.c                        |  47 +++++++---
 monitor/hmp-cmds.c                |   1 +
 tests/unit/test-nested-aio-poll.c |   2 +-
 util/aio-posix.c                  | 148 ++++++++++++++++++------------
 util/aio-win32.c                  |   3 +-
 util/async.c                      |   2 +
 qemu-options.hx                   |   8 +-
 12 files changed, 176 insertions(+), 78 deletions(-)

-- 
2.54.0


