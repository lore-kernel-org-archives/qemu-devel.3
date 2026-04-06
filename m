Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F05EF4EC9
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 09:53:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9gcg-0007cI-FV; Mon, 06 Apr 2026 05:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1w9gcN-0007Yg-Kv; Mon, 06 Apr 2026 05:51:41 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1w9gcJ-0002p7-FJ; Mon, 06 Apr 2026 05:51:38 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c08:7605:0:640:8d9a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 4E77E80632;
 Mon, 06 Apr 2026 12:51:27 +0300 (MSK)
Received: from [IPV6:2a02:6bf:803e:400:4f77:70a0:e2de:cae6] (unknown
 [2a02:6bf:803e:400:4f77:70a0:e2de:cae6])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id Npc8pe1K4eA0-Hz54dl3X; Mon, 06 Apr 2026 12:51:26 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1775469086;
 bh=Vw2y0jsc+BCixb/Wn6lFRJq4eTDaxiSplH1YrdvIHdA=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=SeYzyGW9iXivpwrtRv9D6dzl4Fuz8qumVJqMcSd99JR5p1bUQ1iJxbOy0fHZrIhnn
 FnVnmiOjHAHDekuAsyxiDxqpu82zSdktpg7GnK6CqBa6HzbSefu/qo5RBwyaBW/Nz5
 8pk7ZCmIzObA6izWsWUw9ADfYHb9KRlJ/9q+Bkpg=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <250aad49-9494-47d3-b0e1-2e4eec490ca3@yandex-team.ru>
Date: Mon, 6 Apr 2026 14:51:23 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] vhost-user-blk: fix compatibility with older qemu
 versions
To: qemu-devel@nongnu.org
Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Milan Zamazal <mzamazal@redhat.com>, Raphael Norwitz <rnorwitz@nvidia.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>,
 zhenwei pi <zhenwei.pi@linux.dev>, Hanna Reitz <hreitz@redhat.com>,
 virtio-fs@lists.linux.dev, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20260330095226.158386-1-dtalexundeer@yandex-team.ru>
Content-Language: en-US
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
In-Reply-To: <20260330095226.158386-1-dtalexundeer@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Ping :)

On 3/30/26 14:52, Alexandr Moshkov wrote:
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
> This is a small continuation of my series about inflight migration for vhost-user-blk.
>
> This series is designed to solve the problem of compatibility with older versions of qemu, where this feature has not yet been introduced (for example, if we want to downgrade versions due to some problems).
>
> In the current version for vhost-user-blk, this feature is enabled using the parameter and further migration of the inflight region will depend on whether the vhost-user has accepted the new protocol feature or not. This creates an inconvenient dependency, because there is no way to disable this feature without reconnecting to the backend.
> This series slightly changes the semantics of the introduced protocol feature VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT. Enabling this feature adds a new parameter for GET_VRING_BASE message - skip_drain, which allows to control drain in-flight requests on the backend.
>
> Thus, user can enable or disable inflight-migration param for vhost-user-blk to maintain compatibility with older versions of QEMU.
>
> Alexandr Moshkov (5):
>    vhost-user.rst: fix typo
>    vhost-user-blk: make inflight-migration prop mutable
>    vhost-user: add skip_drain param to do_vhost_virtqueue_stop
>    vhost-user-blk: move inflight_needed higher
>    vhost-user: add skip_drain param to GET_VRING_BASE
>
>   backends/cryptodev-vhost.c     |  2 +-
>   backends/vhost-user.c          |  2 +-
>   docs/interop/vhost-user.rst    |  8 +++----
>   hw/block/vhost-user-blk.c      | 43 +++++++++++++++++++++++++++-------
>   hw/net/vhost_net.c             |  9 +++----
>   hw/scsi/vhost-scsi-common.c    |  2 +-
>   hw/virtio/vdpa-dev.c           |  2 +-
>   hw/virtio/vhost-user-base.c    |  2 +-
>   hw/virtio/vhost-user-fs.c      |  2 +-
>   hw/virtio/vhost-user-scmi.c    |  2 +-
>   hw/virtio/vhost-user.c         |  3 +--
>   hw/virtio/vhost-vsock-common.c |  2 +-
>   hw/virtio/vhost.c              | 29 ++++++++++++++++-------
>   include/hw/virtio/vhost-user.h |  1 -
>   include/hw/virtio/vhost.h      |  7 ++++--
>   15 files changed, 76 insertions(+), 40 deletions(-)
>

