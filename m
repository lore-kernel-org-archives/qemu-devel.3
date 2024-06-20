Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A422BC2BA1A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 14:45:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKJ1n-0003Gw-W7; Thu, 20 Jun 2024 10:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sKJ1f-0003FS-Qa; Thu, 20 Jun 2024 10:44:35 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sKJ1d-00018g-0n; Thu, 20 Jun 2024 10:44:35 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:3196:0:640:fabe:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id F0B1C60C04;
 Thu, 20 Jun 2024 17:44:27 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b486::1:24])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 4iL0bh2RiW20-TzHVo3zW; Thu, 20 Jun 2024 17:44:27 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1718894667;
 bh=UdbdisZ9WwUO65X0/LqhqZDkOGv0k8ahCbAYlAg8+bc=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=j3/hn+6ixrlzT7QkqoMoaf7KjZ9De2yiRV6EkqesmL78+BeYLttoVEUEauw6yCO5g
 9shpV7KsOpEsZg2kEIWsFA16CdSrsijkNfX5+Y0bF/MUinA2yPw0of0cyd6iEng83k
 E670P7PLJyrIBPowJ9XAyiRB3OIJkU3A5nK4i34c=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PATCH 0/2] fix backup-discard-source test for XFS
Date: Thu, 20 Jun 2024 17:44:00 +0300
Message-Id: <20240620144402.65896-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi all!

As Kevin reported, the test doesn't work on XFS, as it rely on disk
usage.

Fix it, switching to dirty bitmap for guest write tracking.

Vladimir Sementsov-Ogievskiy (2):
  iotests/backup-discard-source: convert size variable to be int
  iotests/backup-discard-source: don't use actual-size

 .../qemu-iotests/tests/backup-discard-source  | 39 ++++++++++++-------
 1 file changed, 25 insertions(+), 14 deletions(-)

-- 
2.34.1


