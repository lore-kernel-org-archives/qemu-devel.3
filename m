Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69A4606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 08:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=NINq8ZNY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUJjK-0000VX-Kf; Fri, 20 Nov 2026 03:12:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xUJjG-0000TN-Q1; Fri, 20 Nov 2026 03:12:18 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xUJjE-0003WN-HW; Fri, 20 Nov 2026 03:12:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795162332; bh=zkv+9cdD+MdzPp+oTG5JPQlCqcffWWNbckFWnFDwoeI=;
 h=Date:Subject:To:References:Cc:From:In-Reply-To;
 b=NINq8ZNY9byZoNRKhtYZ1AdK64sLHz404BwMZpQrLQdsdgJd4r9h8RLeDHtwjzRY0
 tEKeidSEXpq4/xsBsBLEMuD6uwd5pMwRNfuYPRMAYXabihuBUuLMHBUkro3c1nyLDq
 xgATB9+tBI1oRwMK7lChjdhITUgTWq8BDD2U/lwvNtiweq3sfnHqKAtbBbteki9fIb
 SoSE78D2wkK3hfmXjjCLHL8yQ8/EjumXvbqlw4HxxeWHyMfeeHa8bWIDkBNfUbW1rO
 hTRHqH1OaapSmjEW8DI5xVsdCTGroifQ8oe2aPeVzeVZZ88K2wRi5+TZD8MTjmA0DN
 r8eXoBElw+kxQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AD9A01E832A;
 Fri, 20 Nov 2026 11:12:12 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9AEFF461F02;
 Fri, 20 Nov 2026 11:12:12 +0300 (MSK)
Message-ID: <c50d636e-a719-4d1c-bb7d-3b2549bd5cfb@tls.msk.ru>
Date: Fri, 20 Nov 2026 11:12:12 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio: Reset free_head on shadow virtqueue start
To: lirongqing <lirongqing@baidu.com>, eperezma@redhat.com, mst@redhat.com,
 Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
References: <20261104020053.2548-1-lirongqing@baidu.com>
Content-Language: en-US, ru-RU
Cc: QEMU Stable <qemu-stable@nongnu.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20261104020053.2548-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/4/26 05:00, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> free_head tracks the index of the next free descriptor in the SVQ
> descriptor ring.  It is used by vhost_svq_vring_write_descs() to
> choose where to place new descriptors, and is updated as descriptors
> are allocated and recycled.
> 
> free_head is zero-initialized when the SVQ is created through
> vhost_svq_new() (g_new0), but it is not reset in vhost_svq_start().
> The start function already resets the rest of the ring state
> (shadow_avail_idx, shadow_used_idx, last_used, last_used_idx and
> num_free), yet free_head is left untouched.
> 
> Since an SVQ can be stopped and restarted on the same object, for
> example across vDPA device migration or control virtqueue processing,
> a stale free_head from the previous run survives into the new one.
> This causes new descriptors to be written at the wrong position of
> the SVQ descriptor ring, corrupting it.
> 
> Reset free_head to 0 in vhost_svq_start() so that descriptor
> allocation always begins from the head of a fresh ring.
> 
> Fixes: 100890f7cad5 ("vhost: Shadow virtqueue buffers forwarding")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>   hw/virtio/vhost-shadow-virtqueue.c | 1 +
>   1 file changed, 1 insertion(+)

That smells like a qemu-stable material, is it not?

Thanks,

/mjt

> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
> index c97bd9f..462c86d 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.c
> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> @@ -857,6 +857,7 @@ void vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
>       svq->shadow_used_idx = 0;
>       memset(&svq->batch_last, 0, sizeof(svq->batch_last));
>       svq->last_used = 0;
> +    svq->free_head = 0;
>       svq->last_used_idx = 0;
>       svq->vdev = vdev;
>       svq->vq = vq;


