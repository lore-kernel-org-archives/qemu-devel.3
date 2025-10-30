Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F245CCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 16:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEVj1-0001LX-0P; Thu, 30 Oct 2025 12:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vEVic-00018c-Hj
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 12:41:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vEViS-0003PR-Jo
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 12:41:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761842493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yKHN9IPd8PDlWxkU43GJFEFW4HMySwOIdN+Avigo3ag=;
 b=iSq1+4d1l/T4zMLUZtGw4IbaOPWPfYuGrpExeiVL++2dFavDS+INjxB2w1s5knPOUdd320
 mwnEEcYVgVMCB60r4uYTtp+ReT8tjrAlVWT4qETnVyAiSDtD2oAgwLH8Vd+dFjOU1NOs8h
 sl7eiAECWUctQLDgAKDGAkp3ZmrkGZc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-J0baYgviMxmhP13K1tOCFw-1; Thu, 30 Oct 2025 12:41:31 -0400
X-MC-Unique: J0baYgviMxmhP13K1tOCFw-1
X-Mimecast-MFC-AGG-ID: J0baYgviMxmhP13K1tOCFw_1761842491
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8a4ef35cc93so330837185a.3
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 09:41:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761842491; x=1762447291;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yKHN9IPd8PDlWxkU43GJFEFW4HMySwOIdN+Avigo3ag=;
 b=Kjo11aIVYnV/7aSxOquV1y611gx2cp+Fs9PH8cs4w/+AYBFprqi576XjaCWUiPIG8O
 NDJXv2KBvjHzkzicCvWB2uFOaJglEXbmvqRJ7JXpIz2y9ECvlsl+Q4lMycxNdN/UJ5F0
 bOZy925bX4AOGp8jFv+suHB/0mYgbDHLZwdvI3qjuoam0DhdK/K9FiBlyQQiq1GwQ8fb
 4qLbH0tovfScaEeLeH97dd5Zmcg2JMVyRx/lXAb3ipEwVmjoDqlTvmWABUM5EFI/3zKa
 nqjXp0+iKFI+nrWJw+sWmp/CaGIMCLvU7+yGjj676YXLa0YtOXFLlEJDBu23MZyFOZv4
 JHkQ==
X-Gm-Message-State: AOJu0Yzg1FWiKp6vXJtA3rvxqCMQAsjlhhd0LICrfdcy2KSBShT6mBRS
 DChPdwVb2x9CLJ80lkLrFoX9CE+JJJn+vXJycn0cr0uZrVxfpen0D5PinuhaWy8gYcX6L4jbLRL
 JMiYY8UlRt+CEqKHta9zECSO7+1kkxk/HrdS+EDkYT+igIbbzAkuQyWj1
X-Gm-Gg: ASbGnctHK2O7noxYC24IEZxwehE4jnFvohHPPLPIjhfMD6Vbmnro+CP9QTZZQB12ZhJ
 4CsyxB66HlEyJDrfJ0VxKwDPehmcUcqeWjyXuwvUz/zm3VDmSDU66VXVfjUDZmi6aclYyaKHKme
 z+0lEtEP7zz0jsqzSz5IpUu3RyAA9AgtIGHt7e/dbrJN+JIwzYYgeRFuqHRovfJuBDvpxaD3pIZ
 Zi5XOvA+itJfAR1cKD327EQ/PGK15VRV/C9z4WiCi/wXDJ4Ps/CXRbLo1miEjWdAMsJgb9hQw2B
 CLl8RLrjmsddeL/1VzQ1t3NrfBXSK5XDk6Pr37L5DlJzs4WXjCbmAhYoFODYr0HssiE=
X-Received: by 2002:a05:620a:31a1:b0:893:2ba8:eeb8 with SMTP id
 af79cd13be357-8ab9a629c4dmr10093885a.56.1761842490869; 
 Thu, 30 Oct 2025 09:41:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHl+WV93zuV5A0/noL87R5ulXdKAFCA4lhBB0WuSJA074MkoTLvGtl8HigZxgIdydd2rW+/fw==
X-Received: by 2002:a05:620a:31a1:b0:893:2ba8:eeb8 with SMTP id
 af79cd13be357-8ab9a629c4dmr10090085a.56.1761842490377; 
 Thu, 30 Oct 2025 09:41:30 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4eba37db728sm114514251cf.12.2025.10.30.09.41.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 09:41:29 -0700 (PDT)
Date: Thu, 30 Oct 2025 12:41:28 -0400
From: Peter Xu <peterx@redhat.com>
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Raphael Norwitz <raphael@enfabrica.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 2/3] vhost: add vmstate for inflight region with inner
 buffer
Message-ID: <aQOVOFe2TNxNZ8j8@x1.local>
References: <20251029093939.3251188-1-dtalexundeer@yandex-team.ru>
 <20251029093939.3251188-3-dtalexundeer@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251029093939.3251188-3-dtalexundeer@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Oct 29, 2025 at 02:39:41PM +0500, Alexandr Moshkov wrote:
> Prepare for future inflight region migration for vhost-user-blk.
> We need to migrate size, queue_size, and inner buffer.
> 
> So firstly it migrate size and queue_size fields, then allocate memory for buffer with
> migrated size, then migrate inner buffer itself.
> 
> Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> ---
>  hw/virtio/vhost.c         | 44 +++++++++++++++++++++++++++++++++++++++
>  include/hw/virtio/vhost.h |  6 ++++++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index c46203eb9c..f0c283f8f4 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -2028,6 +2028,50 @@ const VMStateDescription vmstate_backend_transfer_vhost_inflight = {
>      }
>  };
>  
> +static int vhost_inflight_buffer_pre_load(void *opaque)
> +{
> +    info_report("vhost_inflight_region_buffer_pre_load");
> +    struct vhost_inflight *inflight = opaque;
> +
> +    Error *err = NULL;
> +    int fd = -1;
> +    void *addr = qemu_memfd_alloc("vhost-inflight", inflight->size,
> +                                  F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL,
> +                                  &fd, &err);
> +    if (err) {
> +        error_report_err(err);
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
> +    .pre_load = vhost_inflight_buffer_pre_load,

vmsd is much better, thanks.

You can also use pre_load_errp() instead to avoid error_report_err().

> +    .fields = (const VMStateField[]) {
> +        VMSTATE_VBUFFER_UINT64(addr, struct vhost_inflight, 0, NULL, size),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +const VMStateDescription vmstate_vhost_inflight_region = {
> +    .name = "vhost-inflight-region",
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


