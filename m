Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD0FDC5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 05:30:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvpvG-0001Pq-I6; Mon, 17 Aug 2026 01:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1wvpvC-0001N7-Mh; Mon, 17 Aug 2026 01:30:06 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1wvpvA-00015G-Au; Mon, 17 Aug 2026 01:30:06 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id D58E4C04A2;
 Mon, 17 Aug 2026 08:29:55 +0300 (MSK)
Received: from [IPV6:2a02:6bf:803e:400:858:d814:19c7:79ca] (unknown
 [2a02:6bf:803e:400:858:d814:19c7:79ca])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id nTMCnA8aW8c0-cKeONhQM; Mon, 17 Aug 2026 08:29:55 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1786944595;
 bh=uak8v+oR1lACOzz5qOYMjrD0NnnFEPKnkFKzUNy8KQM=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=zJCRxF795D+pyOmzrDbOPhzokn04TXBYL+OXG95k1CWXuFDb6J9Zk8n14PLsIbGe0
 298Ng9z/FsC0j0d/aFzmtTzuPbMc8xN5QkxeOjzbIwqLCDrP0jDTi0MGAAMT05+9Ao
 yRAJ02zLvlRowYDw0/fos184t6a5sBNnr98HrKFI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <c6841f52-4d74-4343-b958-067b110fb532@yandex-team.ru>
Date: Mon, 17 Aug 2026 10:29:49 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/6] vhost-user-blk: allow toggling inflight-migration
 at runtime
To: qemu-devel@nongnu.org
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, zhenwei pi <zhenwei.pi@linux.dev>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, Jason Wang
 <jasowangio@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Milan Zamazal <mzamazal@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fam Zheng <fam@euphon.net>,
 virtio-fs@lists.linux.dev,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Raphael Norwitz <rnorwitz@nvidia.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>
References: <20260803072853.2920007-1-dtalexundeer@yandex-team.ru>
Content-Language: en-US
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
In-Reply-To: <20260803072853.2920007-1-dtalexundeer@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

Greetings! Ping.

On 8/3/26 12:28, Alexandr Moshkov wrote:
> v5 -> v6:
> - block changing inflight-migration property while VM is not running
> - remove checking runstate in vhost_user_blk_stop() since it's not necessary
> - updated cover letter: changed subject and description to focus on
>    runtime toggling of inflight-migration rather than cross-version
>    migration compatibility
>
> v4 -> v5:
> - introduce protocol feature VHOST_USER_PROTOCOL_F_GET_VRING_BASE_SKIP_DRAIN
>    to guard the new message, instead of reusing the existing
>    VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INLIFGHT. Update docs.
> - improved commit messages.
>
> v3 -> v4:
> - add new protocol message GET_VRING_BASE_SKIP_DRAIN instead of parameter to GET_VRING_BASE message. This new message can be send instead of GET_VRING_BASE, allowing back-end to suspend inflight I/O immediately instead of waiting and completing them.
> - rebase to newer master
>
> v2 -> v3:
> - fix complile problems
> - add assert check in do_vhost_virtio_stop
> - make inflight-migration property mutable
>
> v1 -> v2:
> - reorganize commits: make refactor commits first, then core semantic change
> - add additional pre_save check for inflight migration possibility
>
> ---
>
> This is v6 of the series previously sent as:
> "[PATCH v5 0/6] vhost-user-blk: add compatibility with older qemu versions"
>
> This series allows the inflight-migration property of vhost-user-blk to
> be toggled at runtime via qom-set without restarting the VM or
> reconnecting to the back-end.
>
> Currently, the inflight migration behaviour is controlled by
> VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT, which is negotiated once
> at connection time. Once negotiated, the back-end always uses suspend
> semantics on GET_VRING_BASE -- there is no way for the front-end to
> request normal drain behaviour on a per-call basis. This makes it
> impossible to disable inflight-migration at runtime.
>
> To solve this, the series introduces a new protocol message
> VHOST_USER_GET_VRING_BASE_SKIP_DRAIN (id=45) guarded by a new protocol
> feature VHOST_USER_PROTOCOL_F_GET_VRING_BASE_SKIP_DRAIN. The message
> instructs the back-end to suspend in-flight I/O immediately rather than
> draining it. This gives the front-end explicit per-call control:
> GET_VRING_BASE for normal drain, GET_VRING_BASE_SKIP_DRAIN when
> inflight-migration is enabled.
>
> In vhost-user-blk, GET_VRING_BASE_SKIP_DRAIN is sent whenever
> inflight-migration is on. The inflight-migration
> property can only be changed while the VM is running, so its value at
> stop time reliably reflects the user's intent.
>
> Alexandr Moshkov (6):
>    vhost-user: add skip_drain param to do_vhost_virtqueue_stop
>    vhost-user: add GET_VRING_BASE_SKIP_DRAIN message
>    vhost-user: use skip_drain with GET_VRING_BASE_SKIP_DRAIN message
>    vhost-user-blk: make inflight-migration prop mutable on running vm
>    vhost-user-blk: move inflight_needed higher
>    vhost-user-blk: use GET_VRING_BASE_SKIP_DRAIN when inflight-migration
>      is on
>
>   backends/cryptodev-vhost.c        |  2 +-
>   backends/vhost-user.c             |  2 +-
>   docs/interop/vhost-user.rst       | 88 +++++++++++++++++++------------
>   hw/block/vhost-user-blk.c         | 60 ++++++++++++++++++---
>   hw/net/vhost_net.c                |  9 ++--
>   hw/scsi/vhost-scsi-common.c       |  2 +-
>   hw/virtio/vdpa-dev.c              |  2 +-
>   hw/virtio/vhost-user-base.c       |  2 +-
>   hw/virtio/vhost-user-fs.c         |  2 +-
>   hw/virtio/vhost-user-scmi.c       |  2 +-
>   hw/virtio/vhost-user.c            | 47 ++++++++++++++---
>   hw/virtio/vhost-vsock-common.c    |  2 +-
>   hw/virtio/vhost.c                 | 34 ++++++++----
>   include/hw/virtio/vhost-backend.h |  1 +
>   include/hw/virtio/vhost-user.h    |  2 +-
>   include/hw/virtio/vhost.h         |  7 ++-
>   16 files changed, 189 insertions(+), 75 deletions(-)
>

