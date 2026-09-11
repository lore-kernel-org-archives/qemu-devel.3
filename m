Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15076C88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 18:10:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x55gY-0005RL-75; Fri, 11 Sep 2026 14:09:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x55gP-0005On-8d
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 14:09:05 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x55gL-0000GW-I9
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 14:09:04 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id 90BA6C0B51;
 Fri, 11 Sep 2026 21:08:57 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:641::1:4])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id u8VTLcTagiE0-NTQ5ljrQ; Fri, 11 Sep 2026 21:08:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1789150137;
 bh=vGgUNYB1GLfdoLMGdiAY5GQvNYCpWeF+MgTaBiWlkq0=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=gCZqYHrv1/5mi9/g0a5Rkwk+TcyovC9vlqXHhor61CN+TQnvYa6PHIDRe5DnPdoOz
 s7SfvjgLTsT+LCik72G5FCseDntvCA7VSBG2J80WcS+EzjbHpZrCBtMTgV0f1odxam
 Ulj8ixfeqDRSHD57T2ZFMZCS4rdhhXRVT8p6Wh44=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, eperezma@redhat.com, sgarzare@redhat.com,
 mst@redhat.com, jag.raman@oracle.com, elena.ufimtseva@oracle.com,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 0/4] util/event_notifier: more strict API
Date: Fri, 11 Sep 2026 21:08:50 +0300
Message-ID: <20260911180854.123969-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Some callers explicitly set fd to -1, to mark event_notifier
"uninitialized". In the same time, we have .uninitialized
field in the notifier itself. Let's cleanup the mess.

Vladimir Sementsov-Ogievskiy (4):
  util/event_notifier: return -1 for uninitialized notifiers
  remote/iohub: stop  set event notifiers to -1
  vhost: stop set event notifier to -1
  util/event_notifier: assert that init_fd receives a valid fd

 hw/remote/iohub.c                  |  2 --
 hw/virtio/vhost-shadow-virtqueue.c | 32 +++++++++++++++++-------------
 include/qemu/event_notifier.h      |  1 +
 util/event_notifier-posix.c        |  5 +++--
 4 files changed, 22 insertions(+), 18 deletions(-)

-- 
2.43.0


