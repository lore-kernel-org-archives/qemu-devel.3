Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3216606A325
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 08:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=NKz5jKpg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUJw4-0002ct-Kt; Fri, 20 Nov 2026 03:25:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xUJvm-0002cV-PI; Fri, 20 Nov 2026 03:25:15 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xUJve-0005U5-ME; Fri, 20 Nov 2026 03:25:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795163102; bh=pTl2Q+YC9kEPcHJRueMMBVixBpyOs8I5AyfwFNU6l0c=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=NKz5jKpgMNMrLg+3Oz8nU59fSH4hBQO8Rdpu7zgipZxPKpD2W7zM1uB3cXxovkiDr
 YzRPYHxJ9U/2yyEi8EDIYWKtmuBWWodTjK2d1KePhx7dg4jm1KhvNir30UM45t+hwR
 o874tIl3VMywNVfiNyeIb5hBQMtLe/371V0/fkuCP7tFAFENORHpy0eRSUyW7aGb+q
 K+DCjk+rPD0dfhkMkoH4Il033ouoeWP6pUkZXDVmOw1XGVxe7IgidgUI37ObLQ+4gQ
 NZmBhdtG+LIpJ1LVt2A503ZGc0kqUIFREDlKN1oxa0w9oGbeiJMZ+FvWUcyISzManX
 efXKjzGt24cQQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AD62D1E8334;
 Fri, 20 Nov 2026 11:25:02 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9B8F1461F11;
 Fri, 20 Nov 2026 11:25:02 +0300 (MSK)
Message-ID: <a16d5437-dd54-49dc-b53a-c8756afab274@tls.msk.ru>
Date: Fri, 20 Nov 2026 11:25:02 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-crypto: clean up every data queue
To: GuoHan Zhao <zhaoguohan@kylinos.cn>, qemu-devel@nongnu.org
Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Stable <qemu-stable@nongnu.org>
References: <20260728111217.573046-1-zhaoguohan@kylinos.cn>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20260728111217.573046-1-zhaoguohan@kylinos.cn>
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

On 7/28/26 14:12, GuoHan Zhao wrote:
> realize() creates max_queues data queues and one BH for each of them.
> unrealize() decides how many to tear down from multiqueue, but nothing ever
> sets that field, so it only deletes the first queue and BH.
> 
> It does not matter how many queues the guest used here.  unrealize() must
> undo all the allocations made by realize(), so loop over max_queues.
> 
> Fixes: 20cb2ffd5ff3 ("virtio-crypto: using bh to handle dataq's requests")
> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
> ---
>   hw/virtio/virtio-crypto.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

Hi!

Is it a qemu-stable material?

I found this change while trying to pick up a subsequent fix in this area --

  902c849979c hw/virtio/virtio-crypto: Drain in-flight operations before unrealizing (CVE-2026-50625)

which touches the same place, and wonder if I should pick this one too?

Thanks,

/mjt

> diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
> index 79e2acb56cc4..85c7279aae27 100644
> --- a/hw/virtio/virtio-crypto.c
> +++ b/hw/virtio/virtio-crypto.c
> @@ -1114,10 +1114,9 @@ static void virtio_crypto_device_unrealize(DeviceState *dev)
>       VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>       VirtIOCrypto *vcrypto = VIRTIO_CRYPTO(dev);
>       VirtIOCryptoQueue *q;
> -    int i, max_queues;
> +    int i;
>   
> -    max_queues = vcrypto->multiqueue ? vcrypto->max_queues : 1;
> -    for (i = 0; i < max_queues; i++) {
> +    for (i = 0; i < vcrypto->max_queues; i++) {
>           virtio_delete_queue(vcrypto->vqs[i].dataq);
>           q = &vcrypto->vqs[i];
>           qemu_bh_delete(q->dataq_bh);


