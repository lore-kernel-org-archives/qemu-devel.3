Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BC4CA5FCB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 11:05:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCEaj-0004j2-OS; Thu, 01 Oct 2026 07:04:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xCEaf-0004ia-RY
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 07:04:42 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xCEac-0004Ha-QZ
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 07:04:41 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 691B46tW084462
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 1 Oct 2026 20:04:06 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=4gMEjU4VU9WIavYm62i32O9RYsIN7EbuwC3Dhs61zt4=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1790852646; v=1;
 b=XmPpj/noNkIAGkR4gGF0bKJmligVPxfqst4b36LLmcP30WlcDAZqRM1rwc/ndA6g
 ACDbLubMbA+eK5dMAs+bPw13VvcC/Rnc1gD6XaFK6lVekep7RWHgLfi9gU19juFM
 m1IlM1AcrvXceGut/Sc6NjacdAvtEjzEqOwd7QxtFpI3Ye4hQ8Hl/PrMnB1K+Sus
 vkA0UM7EAc+KYjWwsHZfCzEZUUs5uoKT2memsfe4V0oY/p8gzxYV0/evS4TSOXi2
 r+aZA1MMGqTgMd1+J9uDhGCgnTUavqW08YMv6WIhw7pXeiX4Sw8TBp1lDqmIv+1n
 uFMgvIuJdIPeto/SvFFCWg==
Message-ID: <44332097-63da-40e8-9908-d0535b7bf8e8@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 1 Oct 2026 20:04:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 15/18] vhost: release ownership in vhost_dev_cleanup()
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-devel@nongnu.org
Cc: den@openvz.org, dwmw2@infradead.org, peterx@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, vsementsov@yandex-team.ru, farosas@suse.de,
 mark.kanda@oracle.com, dongli.zhang@oracle.com,
 maciej.szmigiero@oracle.com, philmd@oss.qualcomm.com,
 bchaney@akamai.com, clg@redhat.com
References: <20261001-up-vsock-vhost-v5-v10-0-8c094843e98b@virtuozzo.com>
 <20261001-up-vsock-vhost-v5-v10-15-8c094843e98b@virtuozzo.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20261001-up-vsock-vhost-v5-v10-15-8c094843e98b@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026/10/01 17:25, Andrey Drobyshev wrote:
> vhost_dev_cleanup() closes the backend FD, but that doesn't release the
> device ownership taken with VHOST_SET_OWNER if the same file is open
> elsewhere.  That's the case on a CPR target: the source keeps the FD,
> so if the target fails after SET_OWNER, either inside vhost_dev_init()
> or later in its caller, the ownership stays with the target.  Once the
> source is resumed it can't take the device back, SET_OWNER fails with
> EBUSY.
> 
> Issue VHOST_RESET_OWNER in vhost_dev_cleanup() as the common teardown
> for all those paths.  That's safe in any case: the kernel refuses it
> from a non-owner, and an owner is about to close the FD anyway.

There is one minor counterexample: if a second netdev receives a 
duplicate of an already-used vhost-net FD, initialization fails with 
EBUSY, but cleanup then resets the first device.

Regards,
Akihiko Odaki

> 
> Reported-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   hw/virtio/vhost.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index c01ccc800cb..0bc6a0b6b00 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1864,6 +1864,13 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
>       g_free(hdev->mem);
>       g_free(hdev->mem_sections);
>       if (hdev->vhost_ops) {
> +        /*
> +         * Issue RESET_OWNER to drop device ownership.  Needed e.g. for
> +         * failing CPR target, so the source can re-acquire it.
> +         * Should be a no-op for non-owner, and harmless for an owner who's
> +         * about to close the device backend.
> +         */
> +        vhost_dev_reset_owner(hdev);
>           hdev->vhost_ops->vhost_cleanup(hdev);
>       }
>       assert(!hdev->log);
> 


