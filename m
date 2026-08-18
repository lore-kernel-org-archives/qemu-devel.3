Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6935C5DF74
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 13:43:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwJ33-0002Lq-R1; Tue, 18 Aug 2026 08:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wwJ31-0002LK-Nx; Tue, 18 Aug 2026 08:36:07 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wwJ2y-0006wR-Pu; Tue, 18 Aug 2026 08:36:07 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 67ICYwMb092544
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 18 Aug 2026 21:34:58 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=LUeb38oMvvESBEacWa+JwwNRjf77ZX6fuQUxFwXE74w=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1787056498; v=1;
 b=r3WyYSTkKKLZVNJZ9ziyNTDdeJ6W7AkVZk4NmAcdQvdNoGs0v1Ww3wrFvq1g+OXw
 lp9I0M+K/L22+958hR5B4b1PenmoJH0XlMt9ErdiGqWWVF18TA+e0y1xeQG8Rf5i
 mpERmlG6IhdSVuuOk7EThxUzCK/WNqxZkYADmAFuFh21q69bTIpIPLMsf0ZXvjmG
 RfsQWxce8YqXjbiN4ir3p4mpeE+PFC24sZbsSgF0DD3kPpxNsOZwS1BHcuK9/yp1
 Zg8en8zfNpbxippYicCFDglQ6N8MXcshEP9e0lBkwcsv0tGi/9Xo4JGZo26bup1u
 za3nLjpDg5DFJHlCK7RqSg==
Message-ID: <7b4d2e3d-4593-492c-887a-db560d590ac6@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 18 Aug 2026 21:34:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 09/13] hw/virtio/vhost-user: add shadow virtqueues
 and eventfd intercepts
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
 <20260817-vhost-user-isolated-memory-v2-9-948aae960abb@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260817-vhost-user-isolated-memory-v2-9-948aae960abb@gmail.com>
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
> Adds shadow virtqueues that will eventually be used to transfer data
> between device and host via bounce buffers when isolation mode is
> active.  The svqs are initalized, and eventfd assignments are
> intercepted so that notifications come to svqs first before
> the guest or backend receive them.
> 
> Signed-off-by: Connor Kite <connorkite@gmail.com>
> ---
>   hw/virtio/vhost-user.c | 136 ++++++++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 119 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index e1e5cba53d..ace328f5eb 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -18,6 +18,7 @@
>   #include "hw/virtio/vhost-backend.h"
>   #include "hw/virtio/virtio.h"
>   #include "hw/virtio/virtio-net.h"
> +#include "hw/virtio/vhost-shadow-virtqueue.h"
>   #include "hw/virtio/vhost-iova-tree.h"
>   #include "chardev/char-fe.h"
>   #include "io/channel-socket.h"
> @@ -331,6 +332,7 @@ typedef struct {
>       size_t size; /* size of the mapped shared memory */
>       int fd; /* descriptor of anonymous file backing shared iso region */
>       Int128 iso_iova_offset; /* translation from IOVA to hva of iso region */
> +    GPtrArray *shadow_vqs; /* shadow vqs with vrings in iso region*/

A whitespace problem remains here.

>   } IsolationModeCtx;
>   
>   struct vhost_user {
> @@ -1128,15 +1130,38 @@ static int vhost_user_set_mem_table_postcopy(struct vhost_dev *dev,
>       return 0;
>   }
>   
> -static void cleanup_isolation_regions(struct vhost_dev *dev)
> +static void vhost_user_svq_cleanup(struct vhost_user *u, bool reset)
> +{
> +    VhostShadowVirtqueue *svq;
> +    for (int i = 0; i < u->iso_mem_ctx.shadow_vqs->len; i++) {
> +        svq = g_ptr_array_index(u->iso_mem_ctx.shadow_vqs, i);
> +        vhost_svq_stop(svq);
> +        event_notifier_cleanup(&svq->hdev_call);
> +        event_notifier_cleanup(&svq->hdev_kick);
> +    }
> +
> +    if (!reset) {
> +        g_ptr_array_free(u->iso_mem_ctx.shadow_vqs, true);
> +    }
> +}
> +
> +static void cleanup_isolation_regions(struct vhost_dev *dev, bool reset)
>   {
>       struct vhost_user *u = dev->opaque;
>       if (u->iso_mem_ctx.shared_mem_addr) {

If vhost_dev_init() fails after vhost_user_init_svq(), shadow_vqs is 
present but shared_mem_addr is not because init_isolation_regions() is 
not called yet. shadow_vqs will be leaked then.

> +        vhost_user_svq_cleanup(u, reset);
>           vhost_iova_tree_delete(u->iso_mem_ctx.tree);
>           qemu_memfd_free(u->iso_mem_ctx.shared_mem_addr,
>                           u->iso_mem_ctx.size,
>                           u->iso_mem_ctx.fd);
> +
> +        GPtrArray *temp = u->iso_mem_ctx.shadow_vqs;

This is a mixed declaration prohibited in docs/devel/style.rst

>           memset(&u->iso_mem_ctx, 0, sizeof(IsolationModeCtx));
> +
> +        if (!reset) {

This condition is inverted. When reset is true, vhost_user_svq_cleanup() 
retains the array so the pointer to it should be kept.

> +            u->iso_mem_ctx.shadow_vqs = temp;
> +        }> +
>       }
>   }
>   
> @@ -1234,7 +1259,7 @@ static int init_isolation_regions(struct vhost_dev *dev,
>       msg->hdr.request = VHOST_USER_SET_MEM_TABLE;
>   
>       /* In case of reset, clear old regions */
> -    cleanup_isolation_regions(dev);
> +    cleanup_isolation_regions(dev, true);
>   
>       /* Gather information for bounce buffers to be mapped */
>       for (u_int32_t i = 0; i < nregions; i++) {
> @@ -1267,7 +1292,7 @@ static int init_isolation_regions(struct vhost_dev *dev,
>   
>       if (err) {
>           error_report_err(err);
> -        cleanup_isolation_regions(dev);
> +        cleanup_isolation_regions(dev, false);
>           return -1;
>       }
>   
> @@ -1295,7 +1320,7 @@ static int init_isolation_regions(struct vhost_dev *dev,
>                                     (hwaddr)u->iso_mem_ctx.shared_mem_addr);
>   
>       if (r != IOVA_OK) {
> -        cleanup_isolation_regions(dev);
> +        cleanup_isolation_regions(dev, false);
>           return r;
>       }
>   
> @@ -1310,7 +1335,7 @@ static int init_isolation_regions(struct vhost_dev *dev,
>                                             dev->mem->regions[i].guest_phys_addr);
>   
>           if (r != IOVA_OK) {
> -            cleanup_isolation_regions(dev);
> +            cleanup_isolation_regions(dev, false);
>               return r;
>           }
>       }
> @@ -1738,11 +1763,49 @@ static int vhost_set_vring_file(struct vhost_dev *dev,
>       return 0;
>   }
>   
> +static int vhost_user_get_vq_index(struct vhost_dev *dev, int idx)
> +{
> +    assert(idx >= dev->vq_index && idx < dev->vq_index + dev->nvqs);
> +
> +    return idx;
> +}
> +
>   static int vhost_user_set_vring_kick(struct vhost_dev *dev,
>                                        struct vhost_vring_file *file)
>   {
> -    int ret = vhost_set_vring_file(dev, VHOST_USER_SET_VRING_KICK, file);
> +    struct vhost_user *u = dev->opaque;
> +    int svq_idx = file->index - dev->vq_index;
> +    VhostShadowVirtqueue *svq = NULL;
> +    struct vhost_vring_file vr_file = *file;
> +    int ret;
> +
> +    vhost_user_get_vq_index(dev, file->index); /* bounds checking */
> +
> +    if (u->user->memory_isolation) {
> +        svq = g_ptr_array_index(u->iso_mem_ctx.shadow_vqs, svq_idx);
> +        vhost_svq_set_svq_kick_fd(svq, file->fd);

The svq->svq_kick EventNotifier is left set in the error paths.

Regards,
Akihiko Odaki

> +
> +        if (file->fd != -1) {
> +            if (!svq->hdev_kick.initialized) {
> +                ret = event_notifier_init(&svq->hdev_kick, 0);
> +                if (ret < 0) {
> +                    event_notifier_cleanup(&svq->hdev_kick);
> +                    error_report("Failed to create kick event notifier");
> +                    return ret;
> +                }
> +            }
> +
> +            vr_file.fd = event_notifier_get_fd(&svq->hdev_kick);
> +        } else {
> +            event_notifier_cleanup(&svq->hdev_kick);
> +        }
> +    }
> +
> +    ret = vhost_set_vring_file(dev, VHOST_USER_SET_VRING_KICK, &vr_file);
>       if (ret < 0) {
> +        if (svq != NULL) {
> +            event_notifier_cleanup(&svq->hdev_kick);
> +        }
>           return ret;
>       }
>   
> @@ -1750,15 +1813,18 @@ static int vhost_user_set_vring_kick(struct vhost_dev *dev,
>        * Inject a kick in case the back-end only starts vring processing upon
>        * receiving a kick. The spec suggests this to improve compatibility.
>        */
> -    if (file->fd != -1) {
> +    if (vr_file.fd != -1) {
>           uint64_t val = 1;
>           ssize_t nwritten;
>   
>           do {
> -            nwritten = write(file->fd, &val, sizeof(val));
> +            nwritten = write(vr_file.fd, &val, sizeof(val));
>           } while (nwritten < 0 && errno == EINTR);
>   
>           if (nwritten < 0 && errno != EAGAIN /* back-end can already read */) {
> +            if (svq != NULL) {
> +                event_notifier_cleanup(&svq->hdev_kick);
> +            }
>               return -errno;
>           }
>       }
> @@ -1769,7 +1835,35 @@ static int vhost_user_set_vring_kick(struct vhost_dev *dev,
>   static int vhost_user_set_vring_call(struct vhost_dev *dev,
>                                        struct vhost_vring_file *file)
>   {
> -    return vhost_set_vring_file(dev, VHOST_USER_SET_VRING_CALL, file);
> +    struct vhost_user *u = dev->opaque;
> +    int svq_idx = file->index - dev->vq_index;
> +    VhostShadowVirtqueue *svq = NULL;
> +    struct vhost_vring_file vr_file = *file;
> +    int ret;
> +
> +    vhost_user_get_vq_index(dev, file->index); /* bounds checking */
> +
> +    if (u->user->memory_isolation) {
> +        svq = g_ptr_array_index(u->iso_mem_ctx.shadow_vqs, svq_idx);
> +        vhost_svq_set_svq_call_fd(svq, file->fd);
> +
> +        if (file->fd != -1) {
> +            if (!svq->hdev_call.initialized) {
> +                ret = event_notifier_init(&svq->hdev_call, 0);
> +                if (ret < 0) {
> +                    event_notifier_cleanup(&svq->hdev_call);
> +                    error_report("Failed to create call event notifier");
> +                    return ret;
> +                }
> +            }
> +
> +            vr_file.fd = event_notifier_get_fd(&svq->hdev_call);
> +        } else {
> +            event_notifier_cleanup(&svq->hdev_call);
> +        }
> +    }
> +
> +    return vhost_set_vring_file(dev, VHOST_USER_SET_VRING_CALL, &vr_file);

Clean up svq->hdev_call when this fails.

>   }
>   
>   static int vhost_user_set_vring_err(struct vhost_dev *dev,
> @@ -2763,6 +2857,17 @@ static int vhost_user_postcopy_notifier(NotifierWithReturn *notifier,
>       return 0;
>   }
>   
> +static void vhost_user_init_svq(struct vhost_dev *dev, struct vhost_user *u)
> +{
> +    /*Modified from vhost-vdpa*/
> +    u->iso_mem_ctx.shadow_vqs = g_ptr_array_new_full(dev->nvqs, vhost_svq_free);
> +    for (int i = 0; i < dev->nvqs; i++) {
> +        VhostShadowVirtqueue *svq;
> +        svq = vhost_svq_new(NULL, NULL);
> +        g_ptr_array_add(u->iso_mem_ctx.shadow_vqs, svq);
> +    }
> +}
> +
>   static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
>                                      Error **errp)
>   {
> @@ -2907,6 +3012,10 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
>       u->postcopy_notifier.notify = vhost_user_postcopy_notifier;
>       postcopy_add_notifier(&u->postcopy_notifier);
>   
> +    if (vus->memory_isolation) {
> +        vhost_user_init_svq(dev, u);
> +    }
> +
>       return 0;
>   }
>   
> @@ -2935,20 +3044,13 @@ static int vhost_user_backend_cleanup(struct vhost_dev *dev)
>       g_free(u->region_rb_offset);
>       u->region_rb_offset = NULL;
>       u->region_rb_len = 0;
> -    cleanup_isolation_regions(dev);
> +    cleanup_isolation_regions(dev, false);
>       g_free(u);
>       dev->opaque = 0;
>   
>       return 0;
>   }
>   
> -static int vhost_user_get_vq_index(struct vhost_dev *dev, int idx)
> -{
> -    assert(idx >= dev->vq_index && idx < dev->vq_index + dev->nvqs);
> -
> -    return idx;
> -}
> -
>   static int vhost_user_memslots_limit(struct vhost_dev *dev)
>   {
>       struct vhost_user *u = dev->opaque;
> 


