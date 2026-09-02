Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD40C624D4
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 08:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1gdg-0005pa-SU; Wed, 02 Sep 2026 04:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x1gde-0005lv-OP; Wed, 02 Sep 2026 04:48:10 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x1gdb-0007AG-Bl; Wed, 02 Sep 2026 04:48:10 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 4A64380C51;
 Wed, 02 Sep 2026 11:48:00 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:b72::1:17])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id xlfWR5raWmI0-I4DcQUFt; Wed, 02 Sep 2026 11:47:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1788338879;
 bh=imXgeps+AHUZz2do61CQkE1oIGmgRyMVaLpkHfrDneg=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=cY8BBKP7wc1WGEXl7hY9IO6pYq6XgmwJiS2eZfKyAOI+dHHaRrq/jshve/QmP6Ay6
 6hOWaKqJ9oSgWCU7yrT7TN8xEtbZwhRq+nFYy0q3VV7TyBAe8+cDCFZ2WGWzQTCEVu
 7muCXAEOzpW00RvHXpY1jCYhr3XN9WbzIQ2ULUaU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	den@openvz.org,
	vsementsov@yandex-team.ru
Subject: [PULL 0/8] block: nbd patches
Date: Wed,  2 Sep 2026 11:47:46 +0300
Message-ID: <20260902084754.140103-1-vsementsov@yandex-team.ru>
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

The following changes since commit eb710c255642cd7dc947f25c9a06c9fc8191e98d:

  Merge tag 'firmware-20260901-pull-request' of https://gitlab.com/kraxel/qemu into staging (2026-09-01 10:38:45 +0100)

are available in the Git repository at:

  https://gitlab.com/vsementsov/qemu.git tags/pull-nbd-2026-09-02

for you to fetch changes up to 29ed9606ba15aa346eaec349d169f90eff56fd01:

  iotests/nbd-commands: cover the command flags and sparse replies (2026-09-02 11:39:46 +0300)

----------------------------------------------------------------
block: nbd patches

----------------------------------------------------------------

Denis V. Lunev (8):
  block/nbd: clear reply.cookie when the reply is rejected
  block/nbd: never index requests[] with an unchecked cookie
  block/nbd: clear reply.cookie under receive_mutex
  iotests: add coverage for NBD transmission commands
  nbd/server: accept NBD_CMD_CACHE above the maximum payload size
  iotests/nbd-commands: exercise the simple and structured reply modes
  iotests/nbd-commands: cover NBD_CMD_BLOCK_STATUS with a payload
  iotests/nbd-commands: cover the command flags and sparse replies

 block/nbd.c                               |  65 ++++--
 nbd/server.c                              |   4 +-
 tests/qemu-iotests/tests/nbd-commands     | 244 ++++++++++++++++++++++
 tests/qemu-iotests/tests/nbd-commands.out |   5 +
 4 files changed, 293 insertions(+), 25 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/nbd-commands
 create mode 100644 tests/qemu-iotests/tests/nbd-commands.out

-- 
2.43.0


