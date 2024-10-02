Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 729BDCF6D36
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 15:19:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sw17o-0005lp-7Y; Wed, 02 Oct 2024 11:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sw17b-0005il-Cv; Wed, 02 Oct 2024 11:18:36 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sw17Y-0004pt-6h; Wed, 02 Oct 2024 11:18:35 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c23:1301:0:640:a2b5:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 0E8D860D23;
 Wed,  2 Oct 2024 18:18:27 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:8026::1:2f])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 7IdRVm1IaeA0-ecOR1ypf; Wed, 02 Oct 2024 18:18:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1727882306;
 bh=Qa4aPLQYtfBhWcdouKMnNYl5IyPzGybcF/dW9gmJfvY=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=qgttv2dn0OiD8YFxm0lyEVCJhO8Ozs+iDOzn82Z7k8wzRSDSA1wZlIsMpMEA/z86m
 Y9uMKw4WVi+m1l5rDGLfHE9zSEHG8x8US0AyocvV3V/pnqVqbrvLrIwd5qn2j08tPg
 p5byaMBd8hF72qObe6Fd3iT+Svk+YxteAgfczEP0=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, eblake@redhat.com, armbru@redhat.com,
 dave@treblig.org, hreitz@redhat.com, kwolf@redhat.com,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v3 0/2] throttling for BLOCK_IO_ERROR
Date: Wed,  2 Oct 2024 18:18:04 +0300
Message-Id: <20241002151806.592469-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Yandex-Filter: 1
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

v2: switch to qom-path as discriminator, for this, add patch 01.

Leonid Kaplan (1):
  block-backend: per-device throttling of BLOCK_IO_ERROR reports

Vladimir Sementsov-Ogievskiy (1):
  qapi: add qom-path to BLOCK_IO_ERROR event

 block/block-backend.c | 21 +++++++++++++++++----
 monitor/monitor.c     |  7 +++++--
 qapi/block-core.json  |  9 +++++++--
 3 files changed, 29 insertions(+), 8 deletions(-)

-- 
2.34.1


