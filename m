Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B90C55179
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 13:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqt5q-0005IR-Rf; Mon, 03 Aug 2026 09:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wqt5p-0005EF-09
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 09:52:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wqt5n-0007Kt-85
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 09:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785765153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YhLYm6/n2jN0v9pCPmHKplzUn4bx523AS/gbNEErh4I=;
 b=W55vyWJI5vocmfA/v6t6uOxGRZj6ieSN0B7qNMhExKCYNOEcrQYj1sHhzxRjrVs6bG5jHJ
 j3d9F2zy51mDtUr6ode7AvTfxPCF3Jxc3z97QBT8spj9twhRVEh/NACVBMEHfd42PGvp6Z
 HOvYkNWf3GLKgosEUe5SRV8fxZ1fmSk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-SrunmIshP0K5ZrC8SdFgeg-1; Mon, 03 Aug 2026 09:52:32 -0400
X-MC-Unique: SrunmIshP0K5ZrC8SdFgeg-1
X-Mimecast-MFC-AGG-ID: SrunmIshP0K5ZrC8SdFgeg_1785765151
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47fd63fb97fso2282390f8f.3
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 06:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785765151; x=1786369951; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YhLYm6/n2jN0v9pCPmHKplzUn4bx523AS/gbNEErh4I=;
 b=XKxg19+88VUabGsqU6z71v1iSNx70wY8QhJDwPB+mb8zTAXh8NL+ZgutmluJRdDUom
 ZaOVWIACjXLXCoq3S0VA5tC+SanNiJo6XRIsIeQzTkDF7J7GnS92yTEuHGmCX+/YuO9o
 sw4s9+/TC74J5e6HIQIb9XXmKhDAQqufSSo4zQ0htJ10UBF3YWFfeFDp7jUMd6C0LIUO
 osB1YWX6Hui1WDoVNbI/wbGIEHSmK2NgwPfaTlU+Q/YpO5VlIiRbIdd355HVOoaqWMuI
 zY6yAU/6mCa8AMx+HYg7JrrHSevTac+NYllStXPWvZEUnlNK03IXyS9pb7ZaqyQH2gDH
 GyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785765151; x=1786369951;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YhLYm6/n2jN0v9pCPmHKplzUn4bx523AS/gbNEErh4I=;
 b=rxReECGD+7f1TcGp243rON1D8wunXFcOwXcetokMtJ9EjBrchvO5hSzmEUOvntX5x8
 zFDQ2j/nfYbiz3nxBop1+9QGjjZ13vOWyo7ZEmUC0+LoGsdi258VkubJLa1GXmmR+cM+
 /q9P5SgVQKbZ9mj5jxHE5oYXxndM+prLX8lI4KRofmUKM65Htrs/zz3ehhPfMxUjtTzi
 P6SWUzd9+QOnD/5ksRJOxHfTndqhl19DtVze6P1TzFmOh6nmI2o7D8XxXQkAupBWdCpI
 I4u/jcP1yzV6tA8EapRi5bbXfskXbGLgjI34PFvd3USTYAmU8Ut1VpGXS1lSz8f9lXez
 pJGQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrWSXxRDd/RvHCx+DSppIrBkCLk5/70aDKYh7BWVfsoCDrPmqKhcul+oPlqUhiQ+F5ujg+lkF4MgxTX@nongnu.org
X-Gm-Message-State: AOJu0YydFBGjfwPlL2OkUHOWBJBsx46bDNkv4Qz+4KBLeDnwLXfBBpoA
 /uiePxQhKBeLZd75i/eaeKzZ5aQdvkyAKRRworirCiYOtVt5jFYGKiPv4ph8PQsYBkPzA//N+Vr
 f5idqK0ngYYuHJbxXb/RSgRaWc0dJ4+vvP+P4Fr1l4Tfg/PGqU811comf
X-Gm-Gg: AR+sD12Urn8b4fiOUFMeRf1bDv7VD3msngZEMJFfgIkfnLD8Yl+ZQd2tV6/ssZ05lEQ
 iWDZoR6/HaaUaMFM1h+S94f0O8WOTfB2ZVsNaOx6NHvo6luJ8SiM8zc7eC2FDG6VVM+hKPW0fc2
 XTLzoPWQWl9HrhgW1uABJDzWeFEa8KAjx1fA2VQm8hWJZR4rYTa1+NqlfZ1XQvsJuv95IHgXbn3
 8+bSjuma2gbTZEKeEPAs9wn2o0TjThLKzXdgkKm+85dcSPxZICPilrmDfreSHFqoN7BaEibHh+x
 XyJ/zIUYttAlm/r4v0wdOvCHxni/iZKk4bxbStNH/1T94JPYlqcvC7+WwV80Htmb5Q6yp1yMzJ4
 o/fuaeIZxfwaQVpCwU7cA3OQnt6zWgbHhWIL28i3cldiLEtoqTVm3sG9w/ICoEw3LQg7yihavj2
 0E71no44ktek+IGwFT6UY60U9DqK1j2g==
X-Received: by 2002:a05:6000:1a88:b0:47f:9486:810b with SMTP id
 ffacd0b85a97d-47fd729e718mr24219715f8f.7.1785765151264; 
 Mon, 03 Aug 2026 06:52:31 -0700 (PDT)
X-Received: by 2002:a05:6000:1a88:b0:47f:9486:810b with SMTP id
 ffacd0b85a97d-47fd729e718mr24219640f8f.7.1785765150764; 
 Mon, 03 Aug 2026 06:52:30 -0700 (PDT)
Received: from ?IPV6:2003:cf:d73d:549a:e584:7c7b:2611:32a1?
 (p200300cfd73d549ae5847c7b261132a1.dip0.t-ipconnect.de.
 [2003:cf:d73d:549a:e584:7c7b:2611:32a1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd458ab61sm33894944f8f.25.2026.08.03.06.52.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2026 06:52:30 -0700 (PDT)
Message-ID: <13594665-16ec-47e5-9075-f7bd5552b0a3@redhat.com>
Date: Mon, 3 Aug 2026 15:52:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 13/15] hw/virtio/vhost-user: add shadow virtqueues and
 eventfd intercepts
To: Connor Kite <connorkite@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Haixu Cui <quic_haixcui@quicinc.com>, Raphael Norwitz <rnorwitz@nvidia.com>,
 Kevin Wolf <kwolf@redhat.com>,
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
 Demi Marie Obenour <demiobenour@gmail.com>
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-13-6b97c439eb28@gmail.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20260723-vhost-user-isolated-memory-v1-13-6b97c439eb28@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.811,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 24.07.26 00:30, Connor Kite wrote:
> Adds shadow virtqueues that will eventually be used to transfer data
> between device and host via bounce buffers when isolation mode is
> active.  The svqs are initalized, and eventfd assignments are
> intercepted so that notifications come to svqs first before
> the guest or backend receive them.
>
> Signed-off-by: Connor Kite <connorkite@gmail.com>
> ---
>   hw/virtio/vhost-user.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 54 insertions(+)
>
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index acabfb7f1c..75858289a2 100644
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
> @@ -365,7 +366,9 @@ struct vhost_user {
>   
>       /* Isolated memory data*/
>       struct IsolationRegion iso_memory;
> +    GPtrArray *shadow_vqs;
>       VhostIOVATree *iso_iova_tree;
> +    bool svqs_allocated;
>   };
>   
>   struct scrub_regions {
> @@ -1693,6 +1696,24 @@ static int vhost_set_vring_file(struct vhost_dev *dev,
>   static int vhost_user_set_vring_kick(struct vhost_dev *dev,
>                                        struct vhost_vring_file *file)
>   {
> +    struct vhost_user *u = dev->opaque;
> +    int svq_idx = file->index - dev->vq_index;
> +    if (u->user->memory_isolation) {
> +        VhostShadowVirtqueue *svq = g_ptr_array_index(u->shadow_vqs,
> +                                                      svq_idx);

Bounds checking via `vhost_user_get_vq_index()` would be nice. (Same below.)

> +        vhost_svq_set_svq_kick_fd(svq, file->fd);
> +
> +        if (svq->hdev_kick.initialized == false) {
> +            int r = event_notifier_init(&svq->hdev_kick, 0);
> +            if (r) {
> +                error_report("Failed to create kick event notifier");
> +                return r;
> +            }
> +        }
> +
> +        file->fd = event_notifier_get_fd(&svq->hdev_kick);

What if `file->fd` was -1, i.e. `VHOST_FILE_UNBIND`? Should we put a 
real FD here then or just continue with -1?

> +    }
> +
>       int ret = vhost_set_vring_file(dev, VHOST_USER_SET_VRING_KICK, file);
>       if (ret < 0) {
>           return ret;
> @@ -1721,6 +1742,24 @@ static int vhost_user_set_vring_kick(struct vhost_dev *dev,
>   static int vhost_user_set_vring_call(struct vhost_dev *dev,
>                                        struct vhost_vring_file *file)
>   {
> +    struct vhost_user *u = dev->opaque;
> +    int svq_idx = file->index - dev->vq_index;
> +    if (u->user->memory_isolation) {
> +        VhostShadowVirtqueue *svq = g_ptr_array_index(u->shadow_vqs,
> +                                                      svq_idx);
> +        vhost_svq_set_svq_call_fd(svq, file->fd);
> +
> +        if (svq->hdev_call.initialized == false) {
> +            int r = event_notifier_init(&svq->hdev_call, 0);

Do we need to check if the call event FD is already active?

> +            if (r) {
> +                error_report("Failed to create call event notifier");
> +                return r;
> +            }
> +        }
> +
> +        file->fd = event_notifier_get_fd(&svq->hdev_call);
> +    }
> +
>       return vhost_set_vring_file(dev, VHOST_USER_SET_VRING_CALL, file);
>   }
>   
> @@ -2715,6 +2754,17 @@ static int vhost_user_postcopy_notifier(NotifierWithReturn *notifier,
>       return 0;
>   }
>   
> +static void vhost_user_init_svq(struct vhost_dev *dev, struct vhost_user *u)
> +{
> +    /*Modified from vhost-vdpa*/
> +    u->shadow_vqs = g_ptr_array_new_full(dev->nvqs, vhost_svq_free);
> +    for (int i = 0; i < dev->nvqs; i++) {
> +        VhostShadowVirtqueue *svq;
> +        svq = vhost_svq_new(NULL, NULL);

Patch 15 adds clean-up for this; I would squash it into here, as far as 
possible. Ideally, a patch series can be stopped at any step and not 
break anything, so if an allocation is added, the accompanying freeing 
should come with it.

Hanna

> +        g_ptr_array_add(u->shadow_vqs, svq);
> +    }
> +}
> +
>   static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
>                                      Error **errp)
>   {
> @@ -2859,6 +2909,10 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
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
>


