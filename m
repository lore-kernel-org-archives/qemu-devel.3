Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC30C61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 14:49:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wysST-0003UH-I8; Tue, 25 Aug 2026 10:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wysSR-0003Ga-6T
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 10:48:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wysSO-0000Ha-VV
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 10:48:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787669336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GkvicXcmKvrN5l40d7S1Rnz5BJAWnqbzOWxB7ivEsfA=;
 b=ApmBuLgJFZKvhPgvSeJvDpfk1xzpm1zs7Tc9wOCidbifmUi2EXGRhGTPzpuPZVR4YlhMo0
 EAAG0M3kmS7dJNoR3rSJ6b0xbOgUF39wvK7fKZnHW4ESHwNgKU2trTa5pL+p6mmmcOjNYn
 f2aIy3EA93oGGsvoOIBJjn2sG9dmIa4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-JIJfu4iTM_-j8yeUB8uDHg-1; Tue, 25 Aug 2026 10:48:49 -0400
X-MC-Unique: JIJfu4iTM_-j8yeUB8uDHg-1
X-Mimecast-MFC-AGG-ID: JIJfu4iTM_-j8yeUB8uDHg_1787669329
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-c15e82278cbso336560766b.2
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 07:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787669328; x=1788274128; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GkvicXcmKvrN5l40d7S1Rnz5BJAWnqbzOWxB7ivEsfA=;
 b=cLmH51Cb+Sc7gAWkomPNjtKGejjXoaixeXH8FgjzofCN/AQCfM2+huZeDkz8Ne1WUA
 BX9+YJdSTw4JEE48WT55v12ILjgmhAtFZQ/Qfg7UUfQzpWvBM16UNEn5TT7XqQ3Kt39U
 PzG9541QpLTw0sSVfUW582BdiMIhbaXLM4qw+v0nodPqgWvRo9al2Fu1zGCOuviKW4/r
 SLc2TyUAyDeAY62M4Y01ABsJCYlDH+Mz+m398zC75MultvoBjwX2VZF1yGN/vhaRarQr
 eFQmUpL8FAPQ8YqLPu8Pgj00CjH8rXrdIuTkJ2vKNya8dj8/n2DNj3b3or+51VXdad67
 zEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787669328; x=1788274128;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GkvicXcmKvrN5l40d7S1Rnz5BJAWnqbzOWxB7ivEsfA=;
 b=bt/JvDCA77PnKwbjmiYRD4oYWGgK4Ajd0ls+r4B7rbH2PhAluU4KzWmwNTPkVhapfY
 tpYaKqoK51LcsO0b+5QDLLl2VuyOWopF8TPypfX/q8rZP+iuuB0x3PSB208Y8lV1S+s+
 R8uoxHxxf4Ts/Hoc/6vyhvTXCrNvPn2ImHDNRiU0N834TcJLPD5xoGnmB4aSEDiey4Au
 8SCgOgbgd6XkUfUXnCH4+UInBWTYW+90UmIPwjGIP+qpbIAbvNk+XhPwLeFD1g6EvMXX
 GxfMUwNDJe8sRZVskRs430YfUW7ju+pXN0QRbk/BUWjVSH1DgwecxVuxvP41xrRveyt3
 k8kw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqA6CERMWRTNGDTqK0nNKpUWDIf5mgU19m6Vhp/sOuiNHHaf8mLc4G/G4tfih25dwTMetfsEPw5Jr5w@nongnu.org
X-Gm-Message-State: AFuF++k3Z6Fu2YAJNTZEoErpZcVpaEdJKdZxMppcEqbRYAdUMtGW4fY3
 6wWhIzMovj4OYgFgOlVM4ge0iVuTD6+b3ty5sT1On/EbJkDFJIIIpNByXzdF+ezomLTOO+bA2Rq
 5Z8ti6JWyQsz0t9cMwXk9BY8peFrbTe6Wpd9mz+rVzjVM7kPxHMev7yWo
X-Gm-Gg: AR+sD12/y3Iu9Y+XC2WCwLV2PSLLXQsQxZRssD/3x6xKD3m9a9DRXyB/DemaqbkgHSi
 LtIaphT0whN9rdP6pE0AtWZTQyNyzCLADxB+j14sERLrru18noadqCh+m8IMCEG+Uy95ibjDsYG
 J0eleM1jwlv7kderSR/6SpKOq+O3KTd/G7hc4wpQvj9mAdHqRyp1rlTSNNqZDsYqW/QLSx8kBRt
 gtirW6tbTrk0ZxMtwuRj1QBIw/d8yjS1kpzn2iQHxkKmtbD79KpoiuucOT8aaH5D8Q7+Ox/iU6A
 Qf8ezkG8NVoWJ2aogG3OwDVllwbKj7H4ZNdmoEctXvaHHBHLZc0xwxC6lkKN2L1jdYyo6eJ9r20
 +FZJkHHIuw8esHXazAAxE8QW8go824s4rQH9ak4bmLI66WFlKIrFb6J2Po5cMFrqnPWI2s4X8tR
 7xLcPKplJ+Gl8ReEXw43NNQcPq/Ol6PQ==
X-Received: by 2002:a17:906:c147:b0:c25:4e5:fe33 with SMTP id
 a640c23a62f3a-c2504e60299mr210651366b.24.1787669328545; 
 Tue, 25 Aug 2026 07:48:48 -0700 (PDT)
X-Received: by 2002:a17:906:c147:b0:c25:4e5:fe33 with SMTP id
 a640c23a62f3a-c2504e60299mr210645666b.24.1787669328104; 
 Tue, 25 Aug 2026 07:48:48 -0700 (PDT)
Received: from ?IPV6:2003:cf:d70a:12bf:c327:80a0:6d65:31e3?
 (p200300cfd70a12bfc32780a06d6531e3.dip0.t-ipconnect.de.
 [2003:cf:d70a:12bf:c327:80a0:6d65:31e3])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2496295632sm2058227166b.18.2026.08.25.07.48.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2026 07:48:47 -0700 (PDT)
Message-ID: <e9c77c8b-af64-4c49-9328-17c6b8047ebd@redhat.com>
Date: Tue, 25 Aug 2026 16:48:44 +0200
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
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org,
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Alyssa Ross <hi@alyssa.is>,
 Demi Marie Obenour <demiobenour@gmail.com>,
 20260817233147.2867623-1-connorkite@gmail.com
References: <20260817-vhost-user-isolated-memory-v2-0-948aae960abb@gmail.com>
 <20260817-vhost-user-isolated-memory-v2-9-948aae960abb@gmail.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20260817-vhost-user-isolated-memory-v2-9-948aae960abb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 18.08.26 07:12, Connor Kite wrote:
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
>   } IsolationModeCtx;
>   
>   struct vhost_user {
> @@ -1128,15 +1130,38 @@ static int vhost_user_set_mem_table_postcopy(struct vhost_dev *dev,
>       return 0;
>   }
>   
> -static void cleanup_isolation_regions(struct vhost_dev *dev)
> +static void vhost_user_svq_cleanup(struct vhost_user *u, bool reset)

It would be nice if there were documentation on what `reset` is supposed 
to do, because as-is I am confused that…

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

…this function retains the array allocation when `reset` is true, but…

> +    }
> +}
> +
> +static void cleanup_isolation_regions(struct vhost_dev *dev, bool reset)
>   {
>       struct vhost_user *u = dev->opaque;
>       if (u->iso_mem_ctx.shared_mem_addr) {
> +        vhost_user_svq_cleanup(u, reset);
>           vhost_iova_tree_delete(u->iso_mem_ctx.tree);
>           qemu_memfd_free(u->iso_mem_ctx.shared_mem_addr,
>                           u->iso_mem_ctx.size,
>                           u->iso_mem_ctx.fd);
> +
> +        GPtrArray *temp = u->iso_mem_ctx.shadow_vqs;

(Please don’t mix declarations and code.)

>           memset(&u->iso_mem_ctx, 0, sizeof(IsolationModeCtx));
> +
> +        if (!reset) {
> +            u->iso_mem_ctx.shadow_vqs = temp;

…this function retains the array allocation only when `reset` is false.

> +        }
> +
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

Slight nudge: It would be less churn just to pull up the declaration, 
not the whole function.

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

I think it would be nicer to use the return value, i.e.

svq_idx = vhost_user_get_vq_index(dev, file->index) - dev_vq_index;

> +
> +    if (u->user->memory_isolation) {
> +        svq = g_ptr_array_index(u->iso_mem_ctx.shadow_vqs, svq_idx);
> +        vhost_svq_set_svq_kick_fd(svq, file->fd);
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

The same pattern exists below, too, which might be another case for a 
`fail` pattern.

Another note: What happens here if `file->fd == -1`? Should we then not 
rather do the opposite? (Which probably doesn’t really work) Or maybe 
rather clean up only at the end, when it’s no longer possible to run 
into an error, in case of `file->fd == -1`?

Hanna

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


