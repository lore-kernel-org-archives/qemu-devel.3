Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF081E63F2A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 05:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrr1q-0006Zo-Tq; Mon, 16 Feb 2026 00:20:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vrr1f-0006Wx-Ue
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 00:20:04 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vrr1c-0007rN-LI
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 00:20:03 -0500
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 247848071D;
 Mon, 16 Feb 2026 08:19:51 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:450::1:4] (unknown [2a02:6bf:8080:450::1:4])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id oJQpBH2AqeA0-0pEWlNCe; Mon, 16 Feb 2026 08:19:50 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1771219190;
 bh=ZrSugMTzKsvqfg/kO+r/chza9zRkC3Bd5tCyunVmQhM=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=i0aB2WFOPWBxEyrfVvqDBa6dQZ64XJuHCR8NN3tmleTqmewirbNNwdbYTRaMOzC4v
 rnjrJDDgLspAx5mqWs+nwWM2s+a/P/5XWWgsnC1wKtr1FZ5DtjIeDoPkimfn70g1G9
 fKxRPr19rpmaX1mMr7ViDvOxf5QYzKiepTssMCqg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <a2b1a1c4-49e9-4d39-901d-da106475982f@yandex-team.ru>
Date: Mon, 16 Feb 2026 08:19:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] vhost: fix vhost_inflight_buffer_pre_load
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "yc-core @ yandex-team . ru" <yc-core@yandex-team.ru>
References: <20260213100647.432974-1-dtalexundeer@yandex-team.ru>
 <20260213100647.432974-2-dtalexundeer@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260213100647.432974-2-dtalexundeer@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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

On 13.02.26 13:06, Alexandr Moshkov wrote:
> While I was rebasing my series about inflight migration, I missed a
> small issue in vhost_inflight_buffer_preload in
> 
> 3a80ff0 ("vhost: add vmstate for inflight region with inner buffer")
> 
> * return wrong type in function
> * missed ERRP_GUARD
> 
> so fixed it in this patch.
> 
> Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> ---
>   hw/virtio/vhost.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 52801c1796..56eb1c4a02 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1920,6 +1920,7 @@ void vhost_get_features_ex(struct vhost_dev *hdev,
>   
>   static bool vhost_inflight_buffer_pre_load(void *opaque, Error **errp)
>   {
> +    ERRP_GUARD();
>       struct vhost_inflight *inflight = opaque;
>   
>       int fd = -1;
> @@ -1927,7 +1928,7 @@ static bool vhost_inflight_buffer_pre_load(void *opaque, Error **errp)
>                                     F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL,
>                                     &fd, errp);
>       if (*errp) {
> -        return -ENOMEM;
> +        return false;
>       }


Instead of ERRP_GUARD, it's better just not dereference errp. We may check for addr instead:

if (!addr) {
    return false;
}

>   
>       inflight->offset = 0;


-- 
Best regards,
Vladimir

