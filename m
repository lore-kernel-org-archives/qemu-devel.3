Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2063CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 05:46:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAihV-0003IU-Hu; Mon, 20 Oct 2025 01:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vAihO-0003Fq-54
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 01:44:54 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vAihL-0007ti-S5
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 01:44:49 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id C2A80807BB;
 Mon, 20 Oct 2025 08:44:37 +0300 (MSK)
Received: from dtalexundeer-nx.yandex-team.ru (unknown
 [2a02:6bf:803e:400:cd4:cafc:37a3:de4])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id TiN4Nb4FbmI0-m7kHZoz4; Mon, 20 Oct 2025 08:44:37 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760939077;
 bh=uOg/6TfaArQwoomphYHbobxb61e9PvCzzjvhJyJo4HE=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=yNwYxDayPPUSeIyVWc83XbY53GYm4v/o3UYMIdPpG17afFoAVKuaihbd+uE5n7MSD
 1j0degqsI4rGJSbypHMlM8pX3sjrvUQu+TBgOB/q5Jjalgsjrgz4rITMF4PpkY46af
 357zXbRV3+gfRUsTKAsygQbpmZg6FgpHfPb+URhY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: Raphael Norwitz <raphael@enfabrica.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: [PATCH 0/2] vhost-user-blk: support inflight migration
Date: Mon, 20 Oct 2025 10:44:12 +0500
Message-Id: <20251020054413.2614932-1-dtalexundeer@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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

Hi!

During inter-host migration, waiting for disk requests to be drained
in the vhost-user backend can incur significant downtime.

This can be avoided if QEMU migrates the inflight region in vhost-user-blk. 
Thus, during the qemu migration, the vhost-user backend can cancel all inflight requests and
then, after migration, they will be executed on another host. 

At first, I tried to implement migration for all vhost-user devices that support inflight at once, 
but this would require a lot of changes both in vhost-user-blk (to transfer it to the base class) and 
in the vhost-user-base base class (inflight implementation and remodeling + a large refactor).

Therefore, for now I decided to leave this idea for later and 
implement the migration of the inflight region first for vhost-user-blk.

Alexandr Moshkov (2):
  vhost: support inflight save/load
  vhost-user-blk: support inflight migration

 hw/block/vhost-user-blk.c | 52 ++++++++++++++++++++++++++++++++++++
 hw/virtio/vhost.c         | 56 +++++++++++++++++++++++++++++++++++++++
 include/hw/virtio/vhost.h |  2 ++
 migration/options.c       |  7 +++++
 migration/options.h       |  1 +
 qapi/migration.json       |  9 +++++--
 6 files changed, 125 insertions(+), 2 deletions(-)

-- 
2.34.1


