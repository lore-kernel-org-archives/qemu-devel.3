Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA36CCD1A0
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 13:08:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1squPs-0000Vg-PR; Wed, 18 Sep 2024 09:08:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1squPq-0000OF-N9
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 09:08:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1squPo-0004Pj-LT
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 09:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726664894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5ehwJvytcPBUkUyoDO5hT69ggPEYh0bNJnJ7WrbfdSc=;
 b=f3w6+I0H1fo0Ch2QieDPaq6XkDptMqCkN6fZMTGq5RV+LCVaD3a6ke1WFuYwKhSUVdsume
 avyG3c4458vpBYclgvWjR+2p3Lz3WyxrLapKcYXE0uE79kDnHGlLAkOmU2+HzDLgahkGil
 aBElx0dE6TAQt7xpMfGHeS8Y6j72BCA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-0M7dCceRONS4ggmaoDgxLA-1; Wed, 18 Sep 2024 09:08:12 -0400
X-MC-Unique: 0M7dCceRONS4ggmaoDgxLA-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2f77be8ff40so41232811fa.0
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 06:08:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726664891; x=1727269691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5ehwJvytcPBUkUyoDO5hT69ggPEYh0bNJnJ7WrbfdSc=;
 b=u/SXPj9/Wv17EpD4BFUG76NMW/FQJZEnBqiCrPu5CWWgH/GNrPyda2KD+yPUW9mv/4
 HINyAzQpD1AgaBnyk4ufaGL1pDxL/kyGsKaSRACOSGiPflPnWwYBspxIHrUwFewJa2AU
 5BnyW//4+hnYTsqTfLiJ8IcpX/oiofBx6fTajNlmLMmrOcJoNQaQXplOHDaF0SxLEutm
 RuxhdSo8E9cOwuxVkfpfBUsa1ZoBB0ssjjEn+u0oVt0Tgq0Hj2ADQHN8BT+O/nLv/y71
 GAm8UEeOGoUEPO4cEiYOaQ61MO6qwsS7od7Ky8ZuA43e/RdE/tPLr0hpB0X2SqjqEf+h
 xbhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJ8shGoDfkOleJl/f72OqoTFr5Xum0nXv6Tsv0ZdiQuoVjltxY7mumcCXDUg9Omu22euuJmq+LZehL@nongnu.org
X-Gm-Message-State: AOJu0Yz5ADAE3bkxJej2pd2rSoYvvfVzv1Fb3rS67dKnTlXC7uAnIKha
 FKfo34TTeFy8nPVKGhQsiO6w9KXDt6MtSSqGsHGehFBfW3Z26FaZSPMeA7+6Bh+r+1d1LNKio70
 N6vcrhqa8Z7fO1B8yJTYvcFrf5ylYa9xYJrS5Sh33VaSu5hORJEGC
X-Received: by 2002:a05:651c:1541:b0:2f7:611c:a643 with SMTP id
 38308e7fff4ca-2f791b4d50fmr100039301fa.33.1726664890636; 
 Wed, 18 Sep 2024 06:08:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgqDSSP5XnHPNACUzwzb6D6hg2wE73ZMTPxkGO7TG/cP7RSupbK8t/3Tf/4I8Qnp3+yjJPaw==
X-Received: by 2002:a05:651c:1541:b0:2f7:611c:a643 with SMTP id
 38308e7fff4ca-2f791b4d50fmr100038971fa.33.1726664889997; 
 Wed, 18 Sep 2024 06:08:09 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e7054c568sm16379025e9.43.2024.09.18.06.08.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 06:08:09 -0700 (PDT)
Date: Wed, 18 Sep 2024 15:08:08 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: dave@treblig.org
Cc: mst@redhat.com, sgarzare@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH] vhost: Remove unused vhost_dev_{load|save}_inflight
Message-ID: <20240918150808.4e3d06fa@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240918121034.16417-1-dave@treblig.org>
References: <20240918121034.16417-1-dave@treblig.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, 18 Sep 2024 13:10:34 +0100
dave@treblig.org wrote:

> From: "Dr. David Alan Gilbert" <dave@treblig.org>
> 
> vhost_dev_load_inflight and vhost_dev_save_inflight have been
> unused since they were added in 2019 by:
> 
> 5ad204bf2a ("vhost-user: Support transferring inflight buffer between qemu and backend")
> 
> Remove them, and their helper vhost_dev_resize_inflight.
> 
> Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/virtio/vhost.c         | 56 ---------------------------------------
>  include/hw/virtio/vhost.h |  2 --
>  2 files changed, 58 deletions(-)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 7c5ef81b55..76f9b2aaad 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1930,62 +1930,6 @@ void vhost_dev_free_inflight(struct vhost_inflight *inflight)
>      }
>  }
>  
> -static int vhost_dev_resize_inflight(struct vhost_inflight *inflight,
> -                                     uint64_t new_size)
> -{
> -    Error *err = NULL;
> -    int fd = -1;
> -    void *addr = qemu_memfd_alloc("vhost-inflight", new_size,
> -                                  F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL,
> -                                  &fd, &err);
> -
> -    if (err) {
> -        error_report_err(err);
> -        return -ENOMEM;
> -    }
> -
> -    vhost_dev_free_inflight(inflight);
> -    inflight->offset = 0;
> -    inflight->addr = addr;
> -    inflight->fd = fd;
> -    inflight->size = new_size;
> -
> -    return 0;
> -}
> -
> -void vhost_dev_save_inflight(struct vhost_inflight *inflight, QEMUFile *f)
> -{
> -    if (inflight->addr) {
> -        qemu_put_be64(f, inflight->size);
> -        qemu_put_be16(f, inflight->queue_size);
> -        qemu_put_buffer(f, inflight->addr, inflight->size);
> -    } else {
> -        qemu_put_be64(f, 0);
> -    }
> -}
> -
> -int vhost_dev_load_inflight(struct vhost_inflight *inflight, QEMUFile *f)
> -{
> -    uint64_t size;
> -
> -    size = qemu_get_be64(f);
> -    if (!size) {
> -        return 0;
> -    }
> -
> -    if (inflight->size != size) {
> -        int ret = vhost_dev_resize_inflight(inflight, size);
> -        if (ret < 0) {
> -            return ret;
> -        }
> -    }
> -    inflight->queue_size = qemu_get_be16(f);
> -
> -    qemu_get_buffer(f, inflight->addr, size);
> -
> -    return 0;
> -}
> -
>  int vhost_dev_prepare_inflight(struct vhost_dev *hdev, VirtIODevice *vdev)
>  {
>      int r;
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index c75be46c06..461c168c37 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -338,8 +338,6 @@ void vhost_virtqueue_stop(struct vhost_dev *dev, struct VirtIODevice *vdev,
>  
>  void vhost_dev_reset_inflight(struct vhost_inflight *inflight);
>  void vhost_dev_free_inflight(struct vhost_inflight *inflight);
> -void vhost_dev_save_inflight(struct vhost_inflight *inflight, QEMUFile *f);
> -int vhost_dev_load_inflight(struct vhost_inflight *inflight, QEMUFile *f);
>  int vhost_dev_prepare_inflight(struct vhost_dev *hdev, VirtIODevice *vdev);
>  int vhost_dev_set_inflight(struct vhost_dev *dev,
>                             struct vhost_inflight *inflight);


