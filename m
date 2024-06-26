Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D8CC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 11:22:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMQj8-0006ON-54; Wed, 26 Jun 2024 07:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sMQj5-0006N9-0G
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:22:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sMQj3-0008Og-DT
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:22:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719400928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dmH6KlfR1UXPMPBwi7it0oifJs4psMRc9Y3kX3/JiLA=;
 b=bDO8KmU/xAGxiU5cXkX1wme9r94h7Flkle8DJTDGJ+5zmy2zMFsNvBHlcAC0lKp9qUHRY3
 7hpF3ifOvhgnBLTVAE1/aVv4SA9Jm79wvD/QzYRnQonDG/1QU2Y6eXm22XFu0p2UpCdhva
 KSqN6I3uELypGGLmSLbiR+Wb5mOD2xo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-9oy_S9xlPayfsguREdsZ0Q-1; Wed, 26 Jun 2024 07:22:06 -0400
X-MC-Unique: 9oy_S9xlPayfsguREdsZ0Q-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a7293303840so3423766b.3
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 04:22:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719400925; x=1720005725;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dmH6KlfR1UXPMPBwi7it0oifJs4psMRc9Y3kX3/JiLA=;
 b=t4FNCmjgH5t52iCYU+d4bcQWeBmR3ol9QWskk0fYaIj8bflBKmhccCd8kKAG3MgP0F
 hFZ1QtmIIUuqeYZg3khQoSpV8WiXKkrROzab/Gq3mdrhX+ZvKHlX76MVUEDAdTr88TNF
 FWwqA/dcSmn5SzdL5td+wzc6BQAiLQQiY6L/gYOprK61YuB0x2N/D2UWtKmQdj/za7H5
 keJVTuj/KLapEweTzqTDGUsQLMrVMK4ozuVmbEjnPRVaoDworVAvrxvkKpXwVhDKS0Y6
 orvz4AdWE2ag9GduTSaYd0Grl8S5ChHLVtrtMNwXbp37nDJPEdQDAxPq1hgnGbHK95lN
 +UOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEAm6hmMpsyOd1x1TTW/KZeMFFrH9VocVARjTmu+WA4pHzO3UHb1U/oOw2dTzrbLI+WBwX+Nc0fJ1eWzJq9zNB/Cg9mzM=
X-Gm-Message-State: AOJu0Yy4QaeAHM298obV/EFnF1EgXYdscxrb0WYX9J2c8xANvTiFVWez
 6Qmz7q+BFzZw33X28fdm7w5Jfkk5rA9sSTiTLUM/l+rQNzdsUIn06CWzggbit6YHsNcXwKlzIsQ
 kBtQC3BcWCZjvdirfwhy+so6SLkPXAuY42YWRay4dGtpmDVnIGz/q
X-Received: by 2002:a17:907:a709:b0:a72:8a0b:9ba5 with SMTP id
 a640c23a62f3a-a728a0ba5f6mr154240466b.54.1719400925408; 
 Wed, 26 Jun 2024 04:22:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnQYx1dMgnGabIrZZWyhDTdfzKIxkESpYeLMln3wM3Mkl/l85SahlPBHA3rNdjkQLpfPe/hw==
X-Received: by 2002:a17:907:a709:b0:a72:8a0b:9ba5 with SMTP id
 a640c23a62f3a-a728a0ba5f6mr154236166b.54.1719400924610; 
 Wed, 26 Jun 2024 04:22:04 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:342:f1b5:a48c:a59a:c1d6:8d0a])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7243b778bcsm421147866b.94.2024.06.26.04.22.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 04:22:04 -0700 (PDT)
Date: Wed, 26 Jun 2024 07:21:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH 06/14] hw/virtio: Free vqs before vhost_dev_cleanup()
Message-ID: <20240626072105-mutt-send-email-mst@kernel.org>
References: <20240626-san-v1-0-f3cc42302189@daynix.com>
 <20240626-san-v1-6-f3cc42302189@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626-san-v1-6-f3cc42302189@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jun 26, 2024 at 08:06:29PM +0900, Akihiko Odaki wrote:
> This suppresses LeakSanitizer warnings.
> 

more specifically, is there a leak here this fixes?
or a false positive warning?

> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  hw/virtio/vhost-user-base.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
> index a83167191ee6..124ef536206f 100644
> --- a/hw/virtio/vhost-user-base.c
> +++ b/hw/virtio/vhost-user-base.c
> @@ -223,6 +223,7 @@ static void vub_disconnect(DeviceState *dev)
>  {
>      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>      VHostUserBase *vub = VHOST_USER_BASE(vdev);
> +    struct vhost_virtqueue *vhost_vqs = vub->vhost_dev.vqs;
>  
>      if (!vub->connected) {
>          return;
> @@ -231,6 +232,7 @@ static void vub_disconnect(DeviceState *dev)
>  
>      vub_stop(vdev);
>      vhost_dev_cleanup(&vub->vhost_dev);
> +    g_free(vhost_vqs);
>  


code does not match $subj

>      /* Re-instate the event handler for new connections */
>      qemu_chr_fe_set_handlers(&vub->chardev,
> 
> -- 
> 2.45.2


