Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1CA0C52D73
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 21:56:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scB6r-0003tT-NE; Thu, 08 Aug 2024 17:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1scB6p-0003sL-Fa
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 17:55:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1scB6n-0004al-SA
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 17:55:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723154142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WmV0DIaARy5CpaPdelt+DC3yDnRHJxMpX35lQcKTy08=;
 b=P8x8c2sCDqp3tdklU7WGsyubrzsegGPl/QClddqQTcHVn4UTecqV73+FeseXXmLF8bFH0v
 3IRkaLQa7qu6Vq/BvI+HMrS1BIndapdvrU68SdjiLplIFdndgzfGAz1JJRDVqn73Z/dGzH
 VW418BKfncXteoZFfdHWh2DaxAHtWik=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-l7lR1yobMCShhU1ZVoVBLA-1; Thu,
 08 Aug 2024 17:55:40 -0400
X-MC-Unique: l7lR1yobMCShhU1ZVoVBLA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9708D1944B2E
 for <qemu-devel@nongnu.org>; Thu,  8 Aug 2024 21:55:39 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0BD271956052
 for <qemu-devel@nongnu.org>; Thu,  8 Aug 2024 21:55:38 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/5] NBD: fix CVE-2024-7409 for 9.1
Date: Thu,  8 Aug 2024 16:53:38 -0500
Message-ID: <20240808215529.1065336-7-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 75c7f574035622798e9361a942bdfbb0af930f0e:

  Merge tag 'pull-hex-20240807' of https://github.com/quic/qemu into staging (2024-08-08 16:08:18 +1000)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2024-08-08

for you to fetch changes up to 3e7ef738c8462c45043a1d39f702a0990406a3b3:

  nbd/server: CVE-2024-7409: Close stray clients at server-stop (2024-08-08 16:34:04 -0500)

----------------------------------------------------------------
NBD patches for 2024-08-08

- plug CVE-2024-7409, a DoS attack exploiting nbd-server-stop

----------------------------------------------------------------
Eric Blake (5):
      nbd: Minor style and typo fixes
      nbd/server: Plumb in new args to nbd_client_add()
      nbd/server: CVE-2024-7409: Cap default max-connections to 100
      nbd/server: CVE-2024-7409: Drop non-negotiating clients
      nbd/server: CVE-2024-7409: Close stray clients at server-stop

 qapi/block-export.json         |  4 ++--
 include/block/nbd.h            | 18 +++++++++++++++-
 block/monitor/block-hmp-cmds.c |  3 ++-
 blockdev-nbd.c                 | 47 +++++++++++++++++++++++++++++++++++++++--
 nbd/server.c                   | 48 ++++++++++++++++++++++++++++++++++++++----
 qemu-nbd.c                     |  7 ++++--
 nbd/trace-events               |  1 +
 7 files changed, 116 insertions(+), 12 deletions(-)

-- 
2.46.0


