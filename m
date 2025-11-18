Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1695BCEE352
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 20:25:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLSFV-0005Tz-O8; Tue, 18 Nov 2025 15:24:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vLSFR-0005SO-Tb
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 15:24:21 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vLSFP-0001g6-79
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 15:24:21 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1a8f:0:640:2fa2:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id A52BB8294D;
 Tue, 18 Nov 2025 23:24:14 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:d96::1:10] (unknown
 [2a02:6bf:8080:d96::1:10])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id DOc5b42FNW20-D3JoF5WH; Tue, 18 Nov 2025 23:24:14 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1763497454;
 bh=HK4dH7YVztP4yRLAT1rK9MoOa+eM+hWHOkPAj7of9ps=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=dFjo1C2AAgAGA3Wxmzj9MxgX+c/JmQruALKD0wgdp09tu852Qeda0RO4tcljgnTor
 KQ+Fr0PngUPeH9NDQlD12lB1VOzUoMqrRShsCfoBzo1HY8lulyxaunxJeJypURSMFA
 oPp31TPbv0lfNW6sBUsiK0ItErtP27Zr3FdutK7o=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <cf0f69b9-4b2b-4c09-a32b-ad86bbe04f6d@yandex-team.ru>
Date: Tue, 18 Nov 2025 23:24:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] vhost-user-blk: support inflight migration
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>, qemu-devel@nongnu.org
Cc: Raphael Norwitz <raphael@enfabrica.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20251110103937.1944486-1-dtalexundeer@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20251110103937.1944486-1-dtalexundeer@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Add Daniel

On 10.11.25 13:39, Alexandr Moshkov wrote:
> v3:
> - use pre_load_errp instead of pre_load in vhost.c
> - change vhost-user-blk property to
>    "skip-get-vring-base-inflight-migration"
> - refactor vhost-user-blk.c, by moving vhost_user_blk_inflight_needed() higher
> 
> v2:
> - rewrite migration using VMSD instead of qemufile API
> - add vhost-user-blk parameter instead of migration capability
> 
> I don't know if VMSD was used cleanly in migration implementation, so
> feel free for comments.
> 
> Based on Vladimir's work:
> [PATCH v2 00/25] vhost-user-blk: live-backend local migration
>    which was based on:
>      - [PATCH v4 0/7] chardev: postpone connect
>        (which in turn is based on [PATCH 0/2] remove deprecated 'reconnect' options)
>      - [PATCH v3 00/23] vhost refactoring and fixes
>      - [PATCH v8 14/19] migration: introduce .pre_incoming() vmsd handler
> 

Hi!

On my series about backend-transfer migration, the final consensus (or at least,
I hope that it's a consensus:) is that using device properties to control migration
channel content is wrong. And we should instead use migration parameters.

(discussion here: https://lore.kernel.org/qemu-devel/29aa1d66-9fa7-4e44-b0e3-2ca26e77accf@yandex-team.ru/ )

So the API for backend-transfer features is a migration parameter

     backend-transfer = [ list of QOM paths of devices, for which we want to enable backend-transfer ]

and user don't have to change device properties in runtime to setup the following migration.

So I assume, similar practice should be applied here: don't use device
properties to control migration.

So, should it be a parameter like

     migrate-inflight-region = [ list of QOM paths of vhost-user devices ]

?


> Based-on: <20250924133309.334631-1-vsementsov@yandex-team.ru>
> Based-on: <20251015212051.1156334-1-vsementsov@yandex-team.ru>
> Based-on: <20251015145808.1112843-1-vsementsov@yandex-team.ru>
> Based-on: <20251015132136.1083972-15-vsementsov@yandex-team.ru>
> Based-on: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
> 
> ---
> 
> Hi!
> 
> During inter-host migration, waiting for disk requests to be drained
> in the vhost-user backend can incur significant downtime.
> 
> This can be avoided if QEMU migrates the inflight region in vhost-user-blk.
> Thus, during the qemu migration, the vhost-user backend can cancel all inflight requests and
> then, after migration, they will be executed on another host.
> 
> At first, I tried to implement migration for all vhost-user devices that support inflight at once,
> but this would require a lot of changes both in vhost-user-blk (to transfer it to the base class) and
> in the vhost-user-base base class (inflight implementation and remodeling + a large refactor).
> 
> Therefore, for now I decided to leave this idea for later and
> implement the migration of the inflight region first for vhost-user-blk.
> 
> Alexandr Moshkov (3):
>    vmstate: introduce VMSTATE_VBUFFER_UINT64
>    vhost: add vmstate for inflight region with inner buffer
>    vhost-user-blk: support inter-host inflight migration
> 
>   hw/block/vhost-user-blk.c          | 29 +++++++++++++++++++++
>   hw/virtio/vhost.c                  | 42 ++++++++++++++++++++++++++++++
>   include/hw/virtio/vhost-user-blk.h |  1 +
>   include/hw/virtio/vhost.h          |  6 +++++
>   include/migration/vmstate.h        | 10 +++++++
>   5 files changed, 88 insertions(+)
> 


-- 
Best regards,
Vladimir

