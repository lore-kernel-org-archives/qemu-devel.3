Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4042DC98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 21:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x986B-0004ti-MQ; Tue, 22 Sep 2026 17:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x9869-0004sh-NS; Tue, 22 Sep 2026 17:32:21 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x9866-0007EU-5o; Tue, 22 Sep 2026 17:32:21 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c23:1224:0:640:741a:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 490248084D;
 Wed, 23 Sep 2026 00:32:13 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:126::1:23])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id BWjvhxGXtiE0-V23VOwT4; Wed, 23 Sep 2026 00:32:12 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1790112732;
 bh=rzlCi/bswy0auYvCTQdGIyVbcHDWxeAd5Usx7R32CB4=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=TxWW0WMQL7ckT0aJaOQeyewCDs4dA41PThdpC8BdXF8CBLKUj8wje3r9q5EhnVTaZ
 cqm0XL5JuA8mFUGj9ty4ee6Ivowo9oGOB7wK/1tE7AxIiQjDAR6gJZoxBTn0A9K3By
 y9VwNLdn8x70k9FycOGa1DiWV3zKo7vtDnSoVmtM=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: eblake@redhat.com, armbru@redhat.com, th.huth+qemu@posteo.eu,
 philmd@oss.qualcomm.com, berrange@redhat.com, pbonzini@redhat.com,
 zhao1.liu@intel.com, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 qemu-stable@nongnu.org
Subject: [PATCH 0/3] virtio: two fixes
Date: Wed, 23 Sep 2026 00:32:07 +0300
Message-ID: <20260922213210.1429435-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi all! There two fixes for my old patches. I apologize if
this affected anyone.

Vladimir Sementsov-Ogievskiy (3):
  tests/funtional: add test_virtio_status.py
  qapi/virtio: Restore backend features in x-query-virtio-status
  qapi/monitor: Handle missing vhost-user protocol features

 MAINTAINERS                                   |  1 +
 hw/virtio/virtio-hmp-cmds.c                   |  6 +-
 hw/virtio/virtio-qmp.c                        |  2 +
 qapi/virtio.json                              |  5 +-
 tests/functional/qemu_test/testcase.py        |  9 +-
 tests/functional/x86_64/meson.build           |  2 +
 tests/functional/x86_64/test_virtio_status.py | 95 +++++++++++++++++++
 7 files changed, 112 insertions(+), 8 deletions(-)
 create mode 100755 tests/functional/x86_64/test_virtio_status.py

-- 
2.43.0


