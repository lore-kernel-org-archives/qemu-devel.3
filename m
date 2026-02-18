Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B115E9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 20:29:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsoAP-00078l-0N; Wed, 18 Feb 2026 15:29:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vsoA3-00074W-Uj
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 15:28:40 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vsoA0-0007rf-KD
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 15:28:39 -0500
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id BFED4C0389;
 Wed, 18 Feb 2026 23:28:32 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:53d::1:1b])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id VShB144A8iE0-8Ro9CTG8; Wed, 18 Feb 2026 23:28:32 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1771446512;
 bh=2VjwvsKxmodtxPSsUhAKD1FyIkn2fmBwJ9pblPRFGIc=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=lXXghrW6mxDSvRdmHzCMFDxr2UbQLEcJjCwdDGMCbWaTjEYQjgyqa2e2ZhEZ3DCp5
 P8sdnfN58ZfMFhYv0pXuyVpgGNiF+QdXm60hC9ORy0ehxK8pqEPYiuItmOm+XMSADE
 ugmnJmguNWt+y2Qq5fHL6QRZ4vRfAr6uvAGJIzc8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, bchaney@akamai.com, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, davydov-max@yandex-team.ru,
 vsementsov@yandex-team.ru
Subject: [PATCH v3 00/12] net: refactoring and fixes
Date: Wed, 18 Feb 2026 23:28:16 +0300
Message-ID: <20260218202829.1322088-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Here are some refactoring and fixes, mostly in net/tap.c I'm making on
my way to implementing TAP fd migration (through UNIX domain socket).

v3:

01: fix checking, switch to int type for queues
08: drop MAX_TAP_QUEUES constant
09,10: prefer int type for queues


Vladimir Sementsov-Ogievskiy (12):
  net/af-xdp: fix type overflow
  net/tap: net_init_tap_one(): add return value
  net/tap: net_init_tap(): drop extra vhostfdname variable
  net/tap: net_init_tap(): refactor parameter checking
  net/tap: net_init_tap(): common fail label
  net/tap: net_init_tap_one() refactor to get vhostfd param
  net/tap: net_init_tap_one(): drop model parameter
  net: introduce net_parse_fds()
  net/tap: move fds parameters handling to separate functions
  net/tap: fix vhostfds/vhostfd parameters API
  net/tap: net_init_tap(): merge fd=, fds= and helper= cases into one
  net/tap: net_init_tap(): relax QEMU hubs check

 net/af-xdp.c |  44 ++-----
 net/tap.c    | 319 +++++++++++++++++++++------------------------------
 net/util.c   |  50 ++++++++
 net/util.h   |  14 +++
 4 files changed, 201 insertions(+), 226 deletions(-)

-- 
2.52.0


