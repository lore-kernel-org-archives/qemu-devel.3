Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98404606A32C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 10:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex-team.ru header.i=@yandex-team.ru header.a=rsa-sha256 header.s=default header.b=y29J/V1H
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOYB9-0004FR-Cx; Wed, 04 Nov 2026 05:25:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1xOYB7-0004Eg-Hy; Wed, 04 Nov 2026 05:25:13 -0500
Received: from forwardcorp2d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df02])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1xOYB5-0006Qq-DH; Wed, 04 Nov 2026 05:25:13 -0500
Received: from mail-nwsmtp-smtp-corp-main-56
 (mail-nwsmtp-smtp-corp-main-56.yp-c.yandex.net)
 by forwardcorp2d.mail.yandex.net (postfix) with ESMTPS id B310B802FF;
 Wed, 04 Nov 2026 13:25:03 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b97::1:12]
 by mail-nwsmtp-smtp-corp-main-56 with ESMTPSA id 2PJhkV5Zf8c0-ic7bMf4o;
 Wed, 04 Nov 2026 13:25:03 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1793787903;
 bh=2BM8zOmRvYZWqXrWgo4CpCm4y2yPn2Ql4pXPTNgFXgI=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=y29J/V1H7fGWznySXKdlDpdze+W1WY2LcduUJhX0kuCr6zC2DIHgso7s/KDiqVLAf
 pNpATQXcErYpbZuVWpzlx3GrE2OCdqIoNssqlJ+qPBq0AtdOOeBaRHwxn8SBSNSB5X
 tnZJbbNujGNlYCz+blvQkUcmMLJXOMjSlDxYYvs0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <58fd2af2-a389-49e2-8a84-328de180e6b1@yandex-team.ru>
Date: Wed, 4 Nov 2026 13:25:02 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for 11.2 v2] vhost: only use config notifier when
 exists/initialized
To: Eric Farman <farman@linux.ibm.com>, "'Michael S . Tsirkin'"
 <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Konstantin Shkolnyy <kshk@linux.ibm.com>
References: <20261103172732.837511-1-farman@linux.ibm.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20261103172732.837511-1-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df02;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp2d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 03.11.26 20:27, Eric Farman wrote:
> Commit e3b12d0c55e4 ("util/event_notifier: more strict API") added an
> assert for an uninitialized file descriptor in event_notifier_get_fd(),
> but it presumes that such a thing always exists.
> 
> On s390x, where a config notifier does not exist, this is a breaking
> change for any vhost-backed device such as virtio-net. To remedy this,
> move the acquisition of the file descriptor within the guard against
> vhost_set_config_call and expand the guard to ensure the notifier is
> initialized before being used.
> 
> Fixes: e3b12d0c55e4 ("util/event_notifier: more strict API")
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>


> ---
>   hw/virtio/vhost.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index b25919c5c7d..189ac541178 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -2119,8 +2119,9 @@ static void vhost_start_config_intr(struct vhost_dev *dev)
>           virtio_config_get_guest_notifier(dev->vdev);
>   
>       assert(dev->vhost_ops);
> -    int fd = event_notifier_get_fd(config_notifier);
> -    if (dev->vhost_ops->vhost_set_config_call) {
> +    if (dev->vhost_ops->vhost_set_config_call &&
> +        event_notifier_initialized(config_notifier)) {
> +        int fd = event_notifier_get_fd(config_notifier);
>           r = dev->vhost_ops->vhost_set_config_call(dev, fd);
>           if (!r) {
>               event_notifier_set(config_notifier);


-- 
Best regards,
Vladimir

