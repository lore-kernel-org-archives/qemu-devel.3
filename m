Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F23D58CDC
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 07:42:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4Zv2-0001r2-9l; Mon, 23 Mar 2026 03:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1w4Zuv-0001qJ-37; Mon, 23 Mar 2026 03:41:41 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1w4Zur-0002zS-KV; Mon, 23 Mar 2026 03:41:39 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 1A800C015A;
 Mon, 23 Mar 2026 10:41:30 +0300 (MSK)
Received: from [IPV6:2a02:6bf:803e:400:96d8:c146:8b39:5d71] (unknown
 [2a02:6bf:803e:400:96d8:c146:8b39:5d71])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id QfMEt00AgmI0-dQqHGO8C; Mon, 23 Mar 2026 10:41:29 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1774251689;
 bh=EZm1NU2ucQ8gnEVcfRktWBEbQCWpytewWeeBhA/0LUg=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=Vl6ABMXJfQ2tun1+VXq+SkCENSX++x5tcvWJI3ZkMDFiXdQViYqkTXhKqqHuE3iZF
 nQqRp7cEzqsDrz4y9nZ/bdqsQq7ADQa+LlO/bJ4/Z1SWTsDeWmtoldtAw5RL0kNcNG
 Qj5x7Yhyqtzo3lmoBeBraj8ywuxKlaV0YNNmRB5c=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <964e04cf-d2bc-46b3-a3c2-d6eaf6cfecef@yandex-team.ru>
Date: Mon, 23 Mar 2026 12:41:26 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] vhost-user-blk: fix compatibility with older qemu
 versions
To: qemu-devel@nongnu.org
Cc: virtio-fs@lists.linux.dev, zhenwei pi <zhenwei.pi@linux.dev>,
 Hanna Reitz <hreitz@redhat.com>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Raphael Norwitz <rnorwitz@nvidia.com>, Milan Zamazal <mzamazal@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-block@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>
References: <20260311084728.751169-1-dtalexundeer@yandex-team.ru>
Content-Language: en-US
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
In-Reply-To: <20260311084728.751169-1-dtalexundeer@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

Ping)

On 3/11/26 13:47, Alexandr Moshkov wrote:
> v1 -> v2:
> - reorganize commits: make refactor commits first, then core semantic change
> - add additional pre_save check for inflight migration possibility
>
> ---
>
> This is a small continuation of my series about inflight migration for vhost-user-blk.
>
> This series is designed to solve the problem of compatibility with older versions of qemu, where this feature has not yet been introduced (for example, if we want to downgrade versions due to some problems).
>
> In the current version for vhost-user-blk, this feature is enabled using the parameter and further migration of the inflight region will depend on whether the vhost-user has accepted the new protocol feature or not. This creates an inconvenient dependency, because there is no way to disable this feature without reconnecting to the backend.
> This series slightly changes the semantics of the introduced protocol feature VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT. Enabling this feature adds a new parameter for GET_VRING_BASE message - skip_drain, which allows to control drain in-flight requests on the backend.
>
> Thus, user can enable or disable inflight-migration param for vhost-user-blk to maintain compatibility with older versions of QEMU.
>
> Alexandr Moshkov (4):
>    vhost-user.rst: fix typo
>    vhost-user: add skip_drain param to do_vhost_virtqueue_stop
>    vhost-user-blk: move inflight_needed higher
>    vhost-user: add skip_drain param to GET_VRING_BASE
>
>   backends/cryptodev-vhost.c     |  2 +-
>   backends/vhost-user.c          |  2 +-
>   docs/interop/vhost-user.rst    |  8 +++-----
>   hw/block/vhost-user-blk.c      | 32 +++++++++++++++++++++++++-------
>   hw/net/vhost_net.c             |  9 +++++----
>   hw/scsi/vhost-scsi-common.c    |  2 +-
>   hw/virtio/vdpa-dev.c           |  2 +-
>   hw/virtio/vhost-user-base.c    |  2 +-
>   hw/virtio/vhost-user-fs.c      |  2 +-
>   hw/virtio/vhost-user-scmi.c    |  2 +-
>   hw/virtio/vhost-user.c         |  3 +--
>   hw/virtio/vhost-vsock-common.c |  2 +-
>   hw/virtio/vhost.c              | 24 +++++++++++++++---------
>   include/hw/virtio/vhost-user.h |  1 -
>   include/hw/virtio/vhost.h      |  7 +++++--
>   15 files changed, 62 insertions(+), 38 deletions(-)
>

