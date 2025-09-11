Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B4ACAC58E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 16:52:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwkVz-00034a-70; Thu, 11 Sep 2025 12:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uwkVu-0002r5-SH
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 12:51:14 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uwkVq-0004AL-4E
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 12:51:14 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 68988804C1;
 Thu, 11 Sep 2025 19:51:04 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b3c::1:2f])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 2pOVKM0Fka60-kxGeePqP; Thu, 11 Sep 2025 19:51:03 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757609463;
 bh=GzL92SZeaNaN99sYKC4gp2JvMT9krinCiyqAlO6f45s=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=Xe0y1RH25OH0WDEPThd4aQxE191R6Crjw00I901xIVWb0mYII0mioMm3VMSgkPJgY
 2n/Z56Xzx4CwUa3AWWw6cqMVcAafU41YyXWNqNgjlPsIAELGuWUaH2T7HpJuKF4+qS
 MTCM7c5Jz2AthLUmlvCUaYcT7R1l8peLnfbjcqyA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 steven.sistare@oracle.com, yc-core@yandex-team.ru,
 davydov-max@yandex-team.ru
Subject: [PATCH v4 0/8] TAP initialization refactoring
Date: Thu, 11 Sep 2025 19:50:53 +0300
Message-ID: <20250911165101.1637608-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Here is the simple and independent part of v3. The long tail
of the series I'll rework and send in separate.

v4: - finally, use bool reaturn value to add to errp functions
    - rework tap_set_sndbuf

Vladimir Sementsov-Ogievskiy (8):
  net/tap: net_init_tap_one(): add return value
  net/tap: rework tap_set_sndbuf()
  net/tap: net_init_tap_one(): drop extra error propagation
  net/tap: launch_script(): add return value
  net/tap: net_init_tap_one(): move parameter checking earlier
  net/tap: net_init_tap(): refactor parameter checking
  net/tap: net_init_tap(): drop extra variable vhostfdname
  net/tap: move local variables related to the latter case to else
    branch

 net/tap-bsd.c     |   3 +-
 net/tap-linux.c   |  19 ++----
 net/tap-solaris.c |   3 +-
 net/tap-stub.c    |   3 +-
 net/tap.c         | 146 +++++++++++++++++++++-------------------------
 net/tap_int.h     |   4 +-
 6 files changed, 80 insertions(+), 98 deletions(-)

-- 
2.48.1


