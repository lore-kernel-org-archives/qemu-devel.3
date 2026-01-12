Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B4BC9EC77
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 11:46:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfGMU-0007MW-3O; Mon, 12 Jan 2026 06:45:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vfGMN-0007L2-Lb; Mon, 12 Jan 2026 06:45:24 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vfGMK-0004gT-I4; Mon, 12 Jan 2026 06:45:23 -0500
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 44AE380806;
 Mon, 12 Jan 2026 14:45:14 +0300 (MSK)
Received: from dtalexundeer-nx.yandex.net (unknown
 [2a02:6bf:803e:400:6fcf:dbb2:9b0:d80b])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 6jQQPI5AAW20-ROb9ZhOA; Mon, 12 Jan 2026 14:45:13 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1768218313;
 bh=UpaZ5BcIl/WfSpr67EREABPsMtpTHl+GDdnFiXpoqJE=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=kh6X+9N0ppGhKpi35NGYbgvfS4w+kr9WMrBWK345Vq2qZmcP4zdumRTtHnvZDffFM
 C98UYWBytQTfSQoF1xsAuz2LHoEaM3f6ePLKuqvnWOHCvZvjsz/4FYE1zjJczepYj+
 mT7GqgFjKyYMQdg2PKVASnxrjcPm6k4bd38BuzLg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, mzamazal@redhat.com,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-block@nongnu.org, virtio-fs@lists.linux.dev,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: [PATCH v5 0/5] support inflight migration
Date: Mon, 12 Jan 2026 16:44:58 +0500
Message-Id: <20260112114503.1174330-1-dtalexundeer@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

v5:
Make protocol feature flag instead of GET_VRING_BASE msg parameter,
so all changes in other devices is no longer needed.
Now back-end may set this feature for QEMU. This feature must be set
with in-flight migration parameter in vhost-user-blk. 

v4:
While testing inflight migration, I notices a problem with the fact that
GET_VRING_BASE is needed during migration, so the back-end stops
dirtying pages and synchronizes `last_avail` counter with QEMU. So after
migration in-flight I/O requests will be looks like resubmited on destination vm.

However, in new logic, we no longer need to wait for in-flight requests
to be complete at GET_VRING_BASE message. So support new parameter
`should_drain` in the GET_VRING_BASE to allow back-end stop vrings
immediately without waiting for in-flight I/O requests to complete.

Also:
- modify vhost-user rst
- refactor on vhost-user-blk.c, now `should_drain` is based on
  device parameter `inflight-migration`

v3:
- use pre_load_errp instead of pre_load in vhost.c
- change vhost-user-blk property to
  "skip-get-vring-base-inflight-migration"
- refactor vhost-user-blk.c, by moving vhost_user_blk_inflight_needed() higher

v2:
- rewrite migration using VMSD instead of qemufile API
- add vhost-user-blk parameter instead of migration capability

I don't know if VMSD was used cleanly in migration implementation, so
feel free for comments.

Based on Vladimir's work:
[PATCH v2 00/25] vhost-user-blk: live-backend local migration
  which was based on:
    - [PATCH v4 0/7] chardev: postpone connect
      (which in turn is based on [PATCH 0/2] remove deprecated 'reconnect' options)
    - [PATCH v3 00/23] vhost refactoring and fixes
    - [PATCH v8 14/19] migration: introduce .pre_incoming() vmsd handler

Based-on: <20250924133309.334631-1-vsementsov@yandex-team.ru>
Based-on: <20251015212051.1156334-1-vsementsov@yandex-team.ru>
Based-on: <20251015145808.1112843-1-vsementsov@yandex-team.ru>
Based-on: <20251015132136.1083972-15-vsementsov@yandex-team.ru>
Based-on: <20251016114104.1384675-1-vsementsov@yandex-team.ru>

---

Hi!

During inter-host migration, waiting for disk requests to be drained
in the vhost-user backend can incur significant downtime.

This can be avoided if QEMU migrates the inflight region in
vhost-user-blk.
Thus, during the qemu migration, with protocol feature flag the vhost-user
back-end can immediately stop vrings, so all in-flight requests will be
migrated to another host.

At first, I tried to implement migration for all vhost-user devices that support inflight at once,
but this would require a lot of changes both in vhost-user-blk (to transfer it to the base class) and
in the vhost-user-base base class (inflight implementation and remodeling + a large refactor).

Therefore, for now I decided to leave this idea for later and
implement the migration of the inflight region first for vhost-user-blk.

Alexandr Moshkov (5):
  vhost-user.rst: specify vhost-user back-end action on GET_VRING_BASE
  vhost-user: introduce protocol feature for skip drain on
    GET_VRING_BASE
  vmstate: introduce VMSTATE_VBUFFER_UINT64
  vhost: add vmstate for inflight region with inner buffer
  vhost-user-blk: support inter-host inflight migration

 docs/interop/vhost-user.rst        | 49 ++++++++++++++++--------------
 hw/block/vhost-user-blk.c          | 28 +++++++++++++++++
 hw/virtio/vhost.c                  | 42 +++++++++++++++++++++++++
 include/hw/virtio/vhost-user-blk.h |  1 +
 include/hw/virtio/vhost-user.h     |  1 +
 include/hw/virtio/vhost.h          |  6 ++++
 include/migration/vmstate.h        | 10 ++++++
 7 files changed, 115 insertions(+), 22 deletions(-)

-- 
2.34.1


