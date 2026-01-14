Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 811E5D39008
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 19:17:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg6Lz-00066r-1K; Wed, 14 Jan 2026 14:16:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vg6LC-0005rz-16
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 14:15:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vg6LA-0004Cx-6z
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 14:15:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768418132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fGwiQyMImMK5t0E73Nd6t81Pb4HhuJdGOtopX5erycw=;
 b=VtGmN9GYAuZURcInOhNqZ9u2yTAlHS89TT3+yGQM50SkzowlzE3xU8Ks7ZCDm4EH8hrUR3
 aepuErQqRt6cRjCVG66N5fcNhQmtGCJgP4vIRen3DdGmk6Rr/9BF5v25nbOBbzX8HQQB1u
 1rxvyEOzjA4xzMfglgAS9mNuvic5ptI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-AUlys6fKMe-jE8cwJpMCgw-1; Wed, 14 Jan 2026 14:15:30 -0500
X-MC-Unique: AUlys6fKMe-jE8cwJpMCgw-1
X-Mimecast-MFC-AGG-ID: AUlys6fKMe-jE8cwJpMCgw_1768418130
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8c53919fbfcso40576285a.2
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 11:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768418130; x=1769022930; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fGwiQyMImMK5t0E73Nd6t81Pb4HhuJdGOtopX5erycw=;
 b=iVGp16hQC7oQBjpJSnFcIdoRWSnfhHuCryclgqFco21HnCBAFcL45YeK9Q05njLqz8
 cOmggRCWT17aPGKlJQWCW6UQvoEaWtP1/WNxJT4lF3wA4WCod/w5X+dVLq9hBRwxi8Eu
 LwE34PTLoZ/+EPfcGyprHz9g0ItdinyUshgswU1h0cv1IyDAls2vW6mmr13X26rfnwtS
 mjxem65UNeICQmMLQsCHKr/ztlJddhXjyvwEh58PYGA+L7Wsj7gzw/He5t8T+r6LwtbF
 KyImXLYqJOKm0AoFHGw69YJvPxzjm0ybqUfKp87QJEaLgUK5/To/nrIgjjeVFyE6uhfI
 sUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768418130; x=1769022930;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fGwiQyMImMK5t0E73Nd6t81Pb4HhuJdGOtopX5erycw=;
 b=os2QbprZz/zHt858ngAWpaCJI1wLYmuiHhUiUBbtIff4YyqpfTOIKXyLne6lfEc2Nm
 q/cpjV3s3tPPKYnvAH1Ly1CTwBw6hi6qmPvE0fM1mc1cDRvYqzdh0X1eUm14cJ9faFT2
 0epU+A6Y7diy5fgSoKO5cv3q7xIcm6EOXmJV4tbf7V6j7od4fW2nEz0U9b4lKWQxRzHy
 AYdM5lgOYXOwpJt1z040eCVh8lbyD/1iPzLUAVPM2voifIkjZkqGvc3XtzGROEL6mg0B
 riRsSBT1i2G7H8in6sFYw21b7YQ+cexks4dY1Bko3U/W9NA7e6veL+yfO+znQUOWFoDe
 MFUQ==
X-Gm-Message-State: AOJu0YzGDnGiNCjnS0OIsNJPILnvoWx63f4oBv1U+EVKFpxQkHkLZxzp
 VEejNTVGnEFy9YsAwg2ZURwfe0UVTk8UHKMOEnA+Ln5uquOvTQ8d/07YnMOi3lXEdYIab/TUmri
 4h6RQKi/xJ1/JI/oyjX+Tg4WzDrt98ugaTAS3cxm5LOg4QzlePQiG2WLR
X-Gm-Gg: AY/fxX5HZoL4RHBl0WzTOyWE7iCelcQ3UsSHukPvX+XwyaXTgtTQtZX/35FAvJ6Xtkz
 1XCBbigv9hs5NSCO+MOURI3DelbwzxUUWz//CmwQmc5mTf3IvA7CgRQ4jObg6DvjWZtkXBbJ75V
 AIS3pQUEM44yf/RKdwhWogM3bV/JNM2q66qsDHgCqNtRHZuqwwY6THu4bsNOWncCZ/fLCMOrUH0
 BGeCzxZJzPgqUbkQ9P6RRBxpuSKGWtknKgszioNn7RF/ZjmmOiK6t86d8AigksXLeEjV1WvHGAZ
 CAKDyAcKxIgj1QHWAc/5kVAPCRtC2PHCiZFfkcvKDIX7PmIq+i0YXnEMY1OiVzRT9u8UFYP0pgi
 joCo=
X-Received: by 2002:a05:620a:2544:b0:8b2:64b1:692c with SMTP id
 af79cd13be357-8c5316a3e7amr451783585a.29.1768418130047; 
 Wed, 14 Jan 2026 11:15:30 -0800 (PST)
X-Received: by 2002:a05:620a:2544:b0:8b2:64b1:692c with SMTP id
 af79cd13be357-8c5316a3e7amr451776785a.29.1768418129383; 
 Wed, 14 Jan 2026 11:15:29 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c530a6c843sm233589185a.6.2026.01.14.11.15.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 11:15:28 -0800 (PST)
Date: Wed, 14 Jan 2026 14:15:27 -0500
From: Peter Xu <peterx@redhat.com>
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Cc: qemu-devel@nongnu.org, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, mzamazal@redhat.com,
 Fabiano Rosas <farosas@suse.de>, qemu-block@nongnu.org,
 virtio-fs@lists.linux.dev,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v6 4/5] vhost: add vmstate for inflight region with inner
 buffer
Message-ID: <aWfrT6JOMm9MGoIw@x1.local>
References: <20260113095813.134810-1-dtalexundeer@yandex-team.ru>
 <20260113095813.134810-5-dtalexundeer@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260113095813.134810-5-dtalexundeer@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Jan 13, 2026 at 02:58:17PM +0500, Alexandr Moshkov wrote:
> Prepare for future inflight region migration for vhost-user-blk.
> We need to migrate size, queue_size, and inner buffer.
> 
> So firstly it migrate size and queue_size fields, then allocate memory for buffer with
> migrated size, then migrate inner buffer itself.
> 
> Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> ---
>  hw/virtio/vhost.c         | 57 +++++++++++++++++++++++++++++++++++++++
>  include/hw/virtio/vhost.h |  6 +++++
>  2 files changed, 63 insertions(+)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index c46203eb9c..f655c53b67 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -2028,6 +2028,63 @@ const VMStateDescription vmstate_backend_transfer_vhost_inflight = {
>      }
>  };
>  
> +static int vhost_inflight_buffer_pre_load(void *opaque, Error **errp)
> +{
> +    info_report("vhost_inflight_region_buffer_pre_load");
> +    struct vhost_inflight *inflight = opaque;
> +
> +    int fd = -1;
> +    void *addr = qemu_memfd_alloc("vhost-inflight", inflight->size,
> +                                  F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL,
> +                                  &fd, errp);
> +    if (*errp) {
> +        return -ENOMEM;
> +    }
> +
> +    inflight->offset = 0;
> +    inflight->addr = addr;
> +    inflight->fd = fd;
> +
> +    return 0;
> +}
> +
> +const VMStateDescription vmstate_vhost_inflight_region_buffer = {
> +    .name = "vhost-inflight-region/buffer",
> +    .pre_load_errp = vhost_inflight_buffer_pre_load,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_VBUFFER_UINT64(addr, struct vhost_inflight, 0, NULL, size),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static int vhost_inflight_region_post_load(void *opaque,
> +                                           int version_id,
> +                                           Error **errp)
> +{
> +    struct vhost_inflight *inflight = opaque;
> +
> +    if (inflight->addr == NULL) {

IIUC this can never happen because pre_load() must trigger before
post_load(), and when reaching post_load() it means pre_load() must have
succeeded..

So, IIUC we can drop this post_load() completely (or assert addr in
pre_load instead).

> +        error_setg(errp, "inflight buffer subsection has not been loaded");
> +        return -EINVAL;
> +    }
> +
> +    return 0;
> +}
> +
> +const VMStateDescription vmstate_vhost_inflight_region = {
> +    .name = "vhost-inflight-region",
> +    .post_load_errp = vhost_inflight_region_post_load,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT64(size, struct vhost_inflight),
> +        VMSTATE_UINT16(queue_size, struct vhost_inflight),
> +        VMSTATE_END_OF_LIST()
> +    },
> +    .subsections = (const VMStateDescription * const []) {
> +        &vmstate_vhost_inflight_region_buffer,
> +        NULL
> +    }
> +};
> +
>  const VMStateDescription vmstate_vhost_virtqueue = {
>      .name = "vhost-virtqueue",
>      .fields = (const VMStateField[]) {
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index 13ca2c319f..dd552de91f 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -596,6 +596,12 @@ extern const VMStateDescription vmstate_backend_transfer_vhost_inflight;
>                             vmstate_backend_transfer_vhost_inflight, \
>                             struct vhost_inflight)
>  
> +extern const VMStateDescription vmstate_vhost_inflight_region;
> +#define VMSTATE_VHOST_INFLIGHT_REGION(_field, _state) \
> +    VMSTATE_STRUCT_POINTER(_field, _state, \
> +                           vmstate_vhost_inflight_region, \
> +                           struct vhost_inflight)
> +
>  extern const VMStateDescription vmstate_vhost_dev;
>  #define VMSTATE_BACKEND_TRANSFER_VHOST(_field, _state) \
>      VMSTATE_STRUCT(_field, _state, 0, vmstate_vhost_dev, struct vhost_dev)
> -- 
> 2.34.1
> 

-- 
Peter Xu


