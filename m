Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47FEDC88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 14:30:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7D83-0001ns-Fk; Thu, 17 Sep 2026 10:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x7D81-0001n3-D0
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 10:30:21 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x7D7y-0007er-Sg
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 10:30:21 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id 5FEFDC0979;
 Thu, 17 Sep 2026 17:30:14 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:b33::1:33])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id DUXfb20WRqM0-9CQsYln6; Thu, 17 Sep 2026 17:30:13 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1789655413;
 bh=LBCUvQgTMQdWiu++SoO1945KeAicjc0KWoOpOmvdT60=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=xhULgVmpaaR/ci5A48fQcHJp6P+8fHrHNTWAluFVsQumRzQD4Oy//Fyi/CGmY/zNh
 z6RJFinG7StwXLjePKEXzB9D2RyA95Ego4IxGdk7wKEUxTmY7X7ohE+1ARyzyAfmwa
 B3X+2h+p+Uaac4CNgvqaAgSU8YU0MjkZHeq4f7zQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com,
	qemu-devel@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PATCH 0/8] vhost-user: refactoring, prepare for fd-migration
Date: Thu, 17 Sep 2026 17:30:03 +0300
Message-ID: <20260917143011.881361-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

For future vhost-user-blk local migration feature (with passing open
file descriptors) we'll need to deal with these memory region.
Let's do a bit of refactoring in advance.

Based-on: <20260916182917.820031-1-vsementsov@yandex-team.ru>
  "[PATCH 0/2] vhost-user: drop support for postcopy+CONFIGURE_MEM_SLOTS"

Vladimir Sementsov-Ogievskiy (8):
  vhost-user: inline scrub_shadow_regions() into the only caller
  vhost-user: introduce send_add_rem_mem_reg()
  vhost-user: store into shadow_regions only regions we sent to backend
  vhost-user: add send_add_region() and send_remove_region() helpers
  vhost-user: vhost_user_add_remove_regions(): drop extra reg variable
  vhost-user: move to QLIST for shadow_regions
  vhost-user: vhost_user_add_remove_regions(): final cosmetics
  vhost-user: stop store userspace_addr for shadow when GPA negotiated

 hw/virtio/vhost-user.c | 327 +++++++++++++++++++----------------------
 1 file changed, 151 insertions(+), 176 deletions(-)

-- 
2.43.0


