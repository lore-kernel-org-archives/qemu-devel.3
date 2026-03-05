Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C1AF30922
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 09:46:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy5H8-0000Rh-Km; Thu, 05 Mar 2026 04:45:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vy5Gw-0000O7-E1; Thu, 05 Mar 2026 04:45:35 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vy5Gu-0004gw-1P; Thu, 05 Mar 2026 04:45:34 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:a189:0:640:4da6:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 1BA8FC01B0;
 Thu, 05 Mar 2026 12:45:28 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b93::1:1] (unknown [2a02:6bf:8080:b93::1:1])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id PjllvG0At8c0-zpk0k6zx; Thu, 05 Mar 2026 12:45:27 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1772703927;
 bh=nRbzsVLviU62jAx81Tto2IrgtyHPLrPaIaiRveKh32I=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=qy8OV1T8ATGZ2sCpdBeR8OEoCFSeuWwkxPPNCfhn/FKwjn2OaMzIA6xr1KEQda/gw
 pdlErkv7wR0cEBc4yEuJSsg2BTwgH3YRlXrCcGT2meknJOBdkUoDLAUsdX6PzDIV2s
 mfFT1meB8Z315LMTD/iivs7YVJVTROSZyyCijQtY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <55b17e00-88cd-44f5-b6c1-2d45db4665ad@yandex-team.ru>
Date: Thu, 5 Mar 2026 12:45:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] vhost-user-blk: make inflight migration throught
 skip_drain
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>, qemu-devel@nongnu.org
Cc: Raphael Norwitz <rnorwitz@nvidia.com>, virtio-fs@lists.linux.dev,
 Milan Zamazal <mzamazal@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, "Gonglei (Arei)"
 <arei.gonglei@huawei.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>, Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org
References: <20260224075055.863068-1-dtalexundeer@yandex-team.ru>
 <20260224075055.863068-5-dtalexundeer@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260224075055.863068-5-dtalexundeer@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 24.02.26 10:50, Alexandr Moshkov wrote:
> Use skip_drain on GET_VRING_BASE to suspend in-flight I/O requests, and
> then migrate them throught inflight subsection.
> 
> Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> ---
>   hw/block/vhost-user-blk.c | 25 ++++++++++++++-----------
>   1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index 3421145f23..4e606fd0fc 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -130,6 +130,17 @@ const VhostDevConfigOps blk_ops = {
>       .vhost_dev_config_notifier = vhost_user_blk_handle_config_change,
>   };
>   
> +static bool vhost_user_blk_inflight_needed(void *opaque)
> +{
> +    struct VHostUserBlk *s = opaque;
> +
> +    bool inflight_migration = virtio_has_feature(s->dev.protocol_features,
> +                               VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT);
> +
> +    return inflight_migration && s->inflight_migration;
> +}

hmm, unrelated code movement

> +
> +
>   static int vhost_user_blk_start(VirtIODevice *vdev, Error **errp)
>   {
>       VHostUserBlk *s = VHOST_USER_BLK(vdev);
> @@ -221,11 +232,13 @@ static int vhost_user_blk_stop(VirtIODevice *vdev)
>           return 0;
>       }
>   
> +    bool skip_drain = vhost_user_blk_inflight_needed(s);
> +
>       force_stop = s->skip_get_vring_base_on_force_shutdown &&
>                    qemu_force_shutdown_requested();
>   
>       ret = force_stop ? vhost_dev_force_stop(&s->dev, vdev, true) :
> -                       vhost_dev_stop(&s->dev, vdev, true, false);
> +                       vhost_dev_stop(&s->dev, vdev, true, skip_drain);
>   
>       if (k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false) < 0) {
>           error_report("vhost guest notifier cleanup failed: %d", ret);
> @@ -568,16 +581,6 @@ static struct vhost_dev *vhost_user_blk_get_vhost(VirtIODevice *vdev)
>       return &s->dev;
>   }
>   
> -static bool vhost_user_blk_inflight_needed(void *opaque)
> -{
> -    struct VHostUserBlk *s = opaque;
> -
> -    bool inflight_migration = virtio_has_feature(s->dev.protocol_features,
> -                               VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT);
> -
> -    return inflight_migration;
> -}
> -
>   static const VMStateDescription vmstate_vhost_user_blk_inflight = {
>       .name = "vhost-user-blk/inflight",
>       .version_id = 1,


-- 
Best regards,
Vladimir

