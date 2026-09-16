Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 293F9C88E7F
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 18:30:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6uO1-0006A4-HY; Wed, 16 Sep 2026 14:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x6uNs-00068h-SM
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 14:29:33 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x6uNo-0008Mb-W2
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 14:29:27 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c16:1d84:0:640:ba03:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 952AD81134;
 Wed, 16 Sep 2026 21:29:20 +0300 (MSK)
Received: from i115954770.. (185.215.60.179.mosline.ru [185.215.60.179])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id JTaLWK3cWGk0-aPXsdyvS; Wed, 16 Sep 2026 21:29:20 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1789583360;
 bh=Eq93ZJIiRUFx9CoCqGUWrmrnpAbSSmIen03nC4h7w3U=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=JyiyrwPnAuVpv9UyXMs0BJvXZkM6CEl8882QujLM0tNN57KwhLnsZD1ynLKp1NUo8
 PcfjpxKuPl3PCOaCU0GqHagINjaVgRfadYoxYTj7qE45PQ2XLQUmX3yl0fcCudN1xe
 WVM53eQzRAMqnKHs2ogAaKp83KH6YdnC++uKvl+M=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 qemu-devel@nongnu.org, vsementsov@yandex-team.ru
Subject: [PATCH 0/2] vhost-user: drop support for postcopy+CONFIGURE_MEM_SLOTS
Date: Wed, 16 Sep 2026 21:29:15 +0300
Message-ID: <20260916182917.820031-1-vsementsov@yandex-team.ru>
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

Hi all!

The combination of postcopy and CONFIGURE_MEM_SLOTS is neither properly
documented nor correctly implemented, see details in 01. I suggest to
drop it for now, and document that fact.

Vladimir Sementsov-Ogievskiy (2):
  vhost-user: drop postcopy support for CONFIGURE_MEM_SLOTS case
  vhost-user: drop extra "else" in vhost_user_set_mem_table_postcopy()

 docs/interop/vhost-user.rst |  30 +++-
 hw/virtio/vhost-user.c      | 296 +++++++++++-------------------------
 2 files changed, 116 insertions(+), 210 deletions(-)

-- 
2.43.0


