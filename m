Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E517EC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:25:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwZj1-0003Nz-TH; Wed, 19 Aug 2026 02:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wwZiy-0003N8-1p; Wed, 19 Aug 2026 02:24:32 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wwZiv-0005ej-Hc; Wed, 19 Aug 2026 02:24:31 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 67J6NbTN005720
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 19 Aug 2026 15:23:37 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=T3tEXd0syhzyFAfdE1g8TCL6cqnp3afNMsnHjclz8LI=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1787120618; v=1;
 b=pV+sgUGc0ff9swG+SbMY62GQm5+qCGgN14aryaVuB0LxUdjd9ykRrX1f5T5m8pW7
 nCB3oBJ7A47QYwy2b9+UfAAqdalpK3XpDYfXKXYXIbRa/piXYGtPU+D03XOwKBa3
 LvIpxsjFVsR9bIrzWaVsBnmeCfeKUu7pxS0qkKTaGz3bwAyz26GPndUDHnkikbrl
 by4qdxISULmwztMSxeNBhC+CqBXUe/ASeeMKn2P1neLY8ACBd7A4PL2wOKK8J8o9
 DOuZ8NCcMvgTmnSc4iW6ks+VkFuLVHL7gQ7BlnZwVLbaWzATcuKLehpqzdpBRQM2
 eOmi+sZ6I2/QvQ9PwDuOGg==
Message-ID: <b6f79ec9-7842-47ff-b210-855036712547@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 19 Aug 2026 15:23:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 04/13] hw/virtio/vhost-shadow-virtqueue: used
 callback
To: Connor Kite <connorkite@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Raphael Norwitz <rnorwitz@nvidia.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org,
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Alyssa Ross <hi@alyssa.is>, Demi Marie Obenour <demiobenour@gmail.com>,
 20260817233147.2867623-1-connorkite@gmail.com
References: <20260817-vhost-user-isolated-memory-v2-0-948aae960abb@gmail.com>
 <20260817-vhost-user-isolated-memory-v2-4-948aae960abb@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260817-vhost-user-isolated-memory-v2-4-948aae960abb@gmail.com>
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

On 2026/08/18 14:12, Connor Kite wrote:
> Adds a callback to shadow virtqueues in order to enable
> non-default processing of used vring elements from the device.
> 
> Signed-off-by: Connor Kite <connorkite@gmail.com>
> ---
>   hw/virtio/vhost-shadow-virtqueue.c |  9 +++++++++
>   hw/virtio/vhost-shadow-virtqueue.h | 16 ++++++++++++++++
>   2 files changed, 25 insertions(+)
> 
> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
> index c8831d52be..496e7e58a3 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.c
> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> @@ -675,6 +675,15 @@ static void vhost_svq_flush(VhostShadowVirtqueue *svq,
>                   break;
>               }
>   
> +            if (svq->ops && svq->ops->used_callback) {
> +                int r = svq->ops->used_callback(svq, elem, svq->ops_opaque);
> +
> +                if (r < 0) {
> +                    /* VQ or handler is broken. Do not set guest notifier */

This comment is extraneous. It is obvious that event_notifier_set() 
below is not called, and it is same with the existing error path below.

What matters here is the difference with the existing error path. Why 
doesn't it call virtqueue_fill() nor virtqueue_flush()? They need to be 
addressed here.

Regards,
Akihiko Odaki

> +                    return;
> +                }
> +            }
> +
>               if (unlikely(i >= svq->vring.num)) {
>                   qemu_log_mask(LOG_GUEST_ERROR,
>                            "More than %u used buffers obtained in a %u size SVQ",
> diff --git a/hw/virtio/vhost-shadow-virtqueue.h b/hw/virtio/vhost-shadow-virtqueue.h
> index ec16a1e838..fd68319fb7 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.h
> +++ b/hw/virtio/vhost-shadow-virtqueue.h
> @@ -56,8 +56,24 @@ typedef int (*VirtQueueAvailCallback)(VhostShadowVirtqueue *svq,
>                                         VirtQueueElement *elem,
>                                         void *vq_callback_opaque);
>   
> +/**
> + * Callback to handle a used buffer
> + *
> + * @svq: Shadow virtqueue
> + * @elem: Element placed in the queue by the device
> + * @vq_callback_opaque: Used to pass arguments to callback
> + *
> + * Returns 0 if the vq is running as expected. Returns a negative errno on
> + * failure.  The callback should not add used elements to the vq shadowed
> + * by the svq as that is done separately after the callback returns.
> + */
> +typedef int (*VirtQueueUsedCallback)(VhostShadowVirtqueue *svq,
> +                                      VirtQueueElement *elem,
> +                                      void *vq_callback_opaque);
> +
>   typedef struct VhostShadowVirtqueueOps {
>       VirtQueueAvailCallback avail_handler;
> +    VirtQueueUsedCallback used_callback;
>   } VhostShadowVirtqueueOps;
>   
>   /* Shadow virtqueue to relay notifications */
> 


