Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67403C61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 21:28:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOk11-0008VW-KD; Mon, 09 Jun 2025 17:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1uOk10-0008Ux-1I; Mon, 09 Jun 2025 17:26:46 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1uOk0x-0007cQ-KJ; Mon, 09 Jun 2025 17:26:45 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c37:722f:0:640:94d5:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id EC6D760D30;
 Tue, 10 Jun 2025 00:26:35 +0300 (MSK)
Received: from d-tatianin-lin.yandex-team.ru (unknown
 [2a02:6bf:8080:771::1:29])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id VQpuLN5FZuQ0-tCaKmGl5; Tue, 10 Jun 2025 00:26:35 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1749504395;
 bh=hdfKMyqKQMYAGJgcTZvDW1R5XBlNV2C6b1gVDwnYSSs=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=zM/wYAMT2NNZ1lLGSyW7p7g0nekmZmwxX+BKbR3I1s7wF6H9j/VxtuAqUysH+zF5o
 a0rFzo3zjPrQa7r54dqBYVyLP5ZfrIotUUiNkFYUk6m4trO9czc+uczDpVdmdo4+/2
 2i3I2cQZF8iGuv6NxZuOQhBV9verVwfgjfjPMNP0=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Subject: [PATCH 0/3] vhost-user-blk: add an option to skip GET_VRING_BASE for
 force shutdown
Date: Tue, 10 Jun 2025 00:25:44 +0300
Message-Id: <20250609212547.2859224-1-d-tatianin@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

This series aims to address SIGTERM/QMP quit() being a bit too graceful in
respect to devices. Both of the aforementioned ways to stop QEMU completely
bypass the guest OS so in that sense they're basically equal to pulling the
power plug on a computer, yet the device shutdown code still tries to do
everything as graceful as possible, draining all in-flight requests etc.
I explain one of the use problems/use cases below.

If we have a server running disk requests that is for whatever reason
hanging or not able to process any more IO requests but still has some
in-flight requests previously issued by the guest OS, QEMU will still
try to drain the vring before shutting down even if it was explicitly
asked to do a "force shutdown" via SIGTERM or QMP quit. This is not
useful since the guest is no longer running at this point since it was
killed by QEMU earlier in the process. At this point, we don't care
about whatever in-flight IO it might have pending, we just want QEMU
to shut down.

Add an option called "skip-get-vring-base-on-force-shutdown" to allow
SIGTERM/QMP quit() to actually act like a "force shutdown" at least
for vhost-user-blk devices since those require the drain operation
to shut down gracefully unlike, for example, network devices.

Daniil Tatianin (3):
  softmmu/runstate: add a way to detect force shutdowns
  vhost: add a helper for force stopping a device
  vhost-user-blk: add an option to skip GET_VRING_BASE for force
    shutdown

 hw/block/vhost-user-blk.c          |  9 +++++-
 hw/virtio/vhost.c                  | 52 ++++++++++++++++++++++--------
 include/hw/virtio/vhost-user-blk.h |  2 ++
 include/hw/virtio/vhost.h          | 15 +++++++++
 include/system/runstate.h          |  1 +
 system/runstate.c                  | 10 ++++++
 6 files changed, 75 insertions(+), 14 deletions(-)

-- 
2.34.1


