Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE1F8C531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 12:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnEst-0005G3-CR; Fri, 24 Jul 2026 08:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wnEsc-00051f-F7; Fri, 24 Jul 2026 08:19:56 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wnEsX-00040P-DN; Fri, 24 Jul 2026 08:19:53 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66OCJ2go066350
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 24 Jul 2026 21:19:02 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=rTqZxBKubC3XWdeFXRGXQBsS8KUymZGaXsJKhcNTDkw=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1784895542; v=1;
 b=IGxpr3i/b2G2uzoBtK8rMeu6dAPbx5mmtVF9gjZyK0ta/GLSxlIHLXo6Wi4pZA5I
 yokFk/K12m84qZU9ezgrUBG7x2vLkloUpyreI/W6fX7Wigarj//Mp3FqVqFljwi4
 PJLtV68yi4idWdHK6O+KemeulRh1kM9cxuMugoUMXOVuRwb7JdvpZv76swsp9H9p
 CPwM5fwQUghJsvLFZ4NicGnu83gDqwXmn3kTKryws4MKj9z/glhSXQ4ZQXkbqPPI
 FrTZCU9ioCKixPqdx7JCQGIXOIO2b7UgAIqYwmLRcpThvvs0qGZs6vB2+3rjbBg2
 CtfrOjqzMchNA4MEmM0Y9w==
Message-ID: <f9125d0a-3258-46f4-93f6-0761a4acdc66@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 24 Jul 2026 21:19:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 09/15] hw/virtio/vhost-shadow-virtqueue: specified
 vring placement
To: Connor Kite <connorkite@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Haixu Cui <quic_haixcui@quicinc.com>,
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
 Alyssa Ross <hi@alyssa.is>, Demi Marie Obenour <demiobenour@gmail.com>
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-9-6b97c439eb28@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260723-vhost-user-isolated-memory-v1-9-6b97c439eb28@gmail.com>
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

On 2026/07/24 7:30, Connor Kite wrote:
> By default svq vrings are placed in an anonymous memory map. As svqs
> will be leveraged to enable memory isolation in vhost-user, it is useful
> to be able to place the vrings in a shared isolation memory region.
> 
> Adds the option to specify vring placement by providing a vring base
> address before starting the svq.
> 
> Signed-off-by: Connor Kite <connorkite@gmail.com>
> ---
>   hw/virtio/vhost-shadow-virtqueue.c | 22 +++++++++++++++-------
>   hw/virtio/vhost-shadow-virtqueue.h |  3 +++
>   2 files changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
> index eb86c1ee37..9e3c359f50 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.c
> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> @@ -857,14 +857,21 @@ void vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
>   
>       svq->vring.num = virtio_queue_get_num(vdev, virtio_get_queue_index(vq));
>       svq->num_free = svq->vring.num;
> -    svq->vring.desc = mmap(NULL, vhost_svq_driver_area_size(svq),
> -                           PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS,
> -                           -1, 0);
>       desc_size = sizeof(vring_desc_t) * svq->vring.num;
> -    svq->vring.avail = (void *)((char *)svq->vring.desc + desc_size);
> -    svq->vring.used = mmap(NULL, vhost_svq_device_area_size(svq),
> -                           PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS,
> -                           -1, 0);
> +    if (svq->base_addr == NULL) {
> +        svq->vring.desc = mmap(NULL, vhost_svq_driver_area_size(svq),
> +                            PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS,
> +                            -1, 0);
> +        svq->vring.avail = (void *)((char *)svq->vring.desc + desc_size);
> +        svq->vring.used = mmap(NULL, vhost_svq_device_area_size(svq),
> +                            PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS,
> +                            -1, 0);
> +    } else {
> +        svq->vring.desc = (void *) svq->base_addr;

Nit: please remove the whitespace between (void *) and svq->base_addr.

> +        svq->vring.avail = (void *)((char *)svq->vring.desc + desc_size);
> +        svq->vring.used = (void *)((char *)svq->base_addr +
> +                          vhost_svq_driver_area_size(svq));
> +    }

Unmapping svq here can lead to use-after-unmapping because the ring is 
not stopped yet. do_vhost_dev_stop() calls do_vhost_virtqueue_stop() 
only after calling hdev->vhost_ops->vhost_dev_start(hdev, false).

>       svq->desc_state = g_new0(SVQDescState, svq->vring.num);
>       if (virtio_vdev_has_feature(svq->vdev, VIRTIO_F_IN_ORDER)) {
>           svq->batch_last.id = VIRTIO_RING_NOT_IN_BATCH;
> @@ -929,6 +936,7 @@ VhostShadowVirtqueue *vhost_svq_new(const VhostShadowVirtqueueOps *ops,
>       event_notifier_init_fd(&svq->svq_kick, VHOST_FILE_UNBIND);
>       svq->ops = ops;
>       svq->ops_opaque = ops_opaque;
> +    svq->base_addr = NULL;
>       return svq;
>   }
>   
> diff --git a/hw/virtio/vhost-shadow-virtqueue.h b/hw/virtio/vhost-shadow-virtqueue.h
> index ccfeee36d7..39f69e6455 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.h
> +++ b/hw/virtio/vhost-shadow-virtqueue.h
> @@ -148,6 +148,9 @@ typedef struct VhostShadowVirtqueue {
>   
>       /* Size of SVQ vring free descriptors */
>       uint16_t num_free;
> +
> +    /* Location assigned to vrings if not in default anon memory map*/

Nit: here please add a whitespace before */

Regards,
Akihiko Odaki

> +    hwaddr *base_addr;
>   } VhostShadowVirtqueue;
>   
>   bool vhost_svq_valid_features(uint64_t features, Error **errp);
> 


