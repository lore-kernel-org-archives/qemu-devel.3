Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0473CC021B3
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 23:14:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlFjg-0000Fq-60; Thu, 20 Feb 2025 18:13:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlFje-0000Fh-Kd
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 18:13:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlFjc-0001uJ-O4
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 18:13:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740093215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DbHBeGluvHfdJl4pa/Yu3eMwPAhxZL8jYTsEYKTo90Q=;
 b=MtxQLMQ2Km8HTjvtmUyneI6YN4gPoznV26GX8LXoTnOuO+fwsXM0lSTShKlHSq57Rzc6fK
 d/C4hHbzWXFKEBlTV/biN0c8l36xuZG5mI++7Fu8HEqqoJnSIqWvcZtMBcsiz7PqrtbokK
 0e+6/OV7N9wlX3YHshUeuS4rxDhWmlE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-W50cVARTNXGSKJcoscH7ow-1; Thu, 20 Feb 2025 18:13:31 -0500
X-MC-Unique: W50cVARTNXGSKJcoscH7ow-1
X-Mimecast-MFC-AGG-ID: W50cVARTNXGSKJcoscH7ow_1740093211
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5e067bbd3bcso1710773a12.3
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 15:13:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740093210; x=1740698010;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DbHBeGluvHfdJl4pa/Yu3eMwPAhxZL8jYTsEYKTo90Q=;
 b=D7648jwdLYWxVvLMOdR3wSQ0B1ppjndrW+IVBpCdVj4MC3GtIl+tELAYCyDBQDsZja
 oWTfkpOCpU0NWPM8sWsSxemz8rvuXnVwtH1dpLjcfsZl2G640gnwfpoBxkPjdtfuKh14
 fLso5K6paB2Ax2S0kjIyDkBxsKBGr8f4cHRQ/B2UcuAaIyB4/OVX1inud5/lo1mNG9MJ
 RYDyhw5nmxMhuz9nhwlYgePi4AZHUuAVtUQBsfL8o823mG/C1Nj7fZNAAkMnSLe8Ugts
 FQpUT7sbTIXvPJhWHi/xriLrpbZ2HUkOkjXGFRnomu3rqmqfg0aj0iNtgtT0nDuRS0Pc
 Fz0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1g4eNwG6E5bLT+0YJ3zqspwrU7yhWfpq9qigK20LHqfFXPMQqFUW16rZWcus0gN+gibUPpEUMU8BH@nongnu.org
X-Gm-Message-State: AOJu0YwDSkf+IZagKb9IJgw4Vp2DQckXcEpMcrvyPnI975fVMIfGS1bx
 YR0ItKbnFUimvIYLXkeNX9mEkgIYk1w4pOIPlNHjyn1Bynfed9s9rqTqoV51IbNgF7YEYvoGF3s
 Dy8Wm8v2Ob6dsZG5dUZ/r5w+RgbvMPJ3jYC/BVrgvZO15rpCxsiap
X-Gm-Gg: ASbGncu2PlHciWa1UwnQL8acx6/v3nzVnK0UBdF6EaVRfPFrP8taGLu+RYbco/VOhRA
 BOo3orWanKaOpYjb7jB2DOu7VMi5Pf60gK5ke+6yTgDUhveTmS+nz1U19I40SFK8093mHmdq2Q5
 T5nof30TIOmnwV4ZyPfBG+Pe9ke2P0xS9orYPZRTr9jHaZi1+DlOnn8yaV05g+Q8ZqrX8cM0377
 q2Sq3zVFuhVXcT53RFu6R3RGtHr6PycPysqFHzlqMA9/q86fYyTk4R0X39SpVgLlHUnvg==
X-Received: by 2002:a05:6402:101a:b0:5e0:40e9:2383 with SMTP id
 4fb4d7f45d1cf-5e0b722a4b5mr506330a12.24.1740093210648; 
 Thu, 20 Feb 2025 15:13:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHa2YwiZ6dleSw/9fAsKpoVymdpGWrl5qdOakhCf8tzKa8bFdi+U8rzVSaIXG5uDlbc0LwXMA==
X-Received: by 2002:a05:6402:101a:b0:5e0:40e9:2383 with SMTP id
 4fb4d7f45d1cf-5e0b722a4b5mr506321a12.24.1740093210245; 
 Thu, 20 Feb 2025 15:13:30 -0800 (PST)
Received: from redhat.com ([2.55.163.174]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dece1b4e3bsm12697400a12.11.2025.02.20.15.13.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 15:13:28 -0800 (PST)
Date: Thu, 20 Feb 2025 18:13:24 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: oenhan@gmail.com
Cc: sgarzare@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Huaitong Han <hanht2@chinatelecom.cn>,
 Zhiyuan Yuan <yuanzhiyuan@chinatelecom.cn>
Subject: Re: [PATCH v2] vhost: Don't set vring call if guest notifier is
 disabled
Message-ID: <20250220181246-mutt-send-email-mst@kernel.org>
References: <20250219015235.130194-1-hanht2@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219015235.130194-1-hanht2@chinatelecom.cn>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Feb 19, 2025 at 09:52:35AM +0800, oenhan@gmail.com wrote:
> From: Huaitong Han <hanht2@chinatelecom.cn>
> 
> The vring call fd is set even when the guest does not use MSIX (e.g., virtio
> PMD). This results in unnecessary CPU overhead for handling virtio interrupts.
> The previous patch only optimized the condition when query_queue_notifier was
> enabled and the vector was unset. However, if query_queue_notifier is disabled,
> the vring call FD should also be unset to avoid this inefficiency.
> 
> Fixes: 96a3d98d2c ("vhost: don't set vring call if no vector")
> 
> Reported-by: Zhiyuan Yuan <yuanzhiyuan@chinatelecom.cn>
> Signed-off-by: Huaitong Han <hanht2@chinatelecom.cn>


Fails make check:


https://gitlab.com/mstredhat/qemu/-/jobs/9201935243

how was this tested? Pls include data on testing in the commit log.

> ---
> v2: - add Fixes tag
>     - cc qemu-stable@nongnu.org
> 
>  hw/virtio/vhost.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 6aa72fd434..d17e7cc6fe 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1342,8 +1342,8 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
>      }
>  
>      if (k->query_guest_notifiers &&
> -        k->query_guest_notifiers(qbus->parent) &&
> -        virtio_queue_vector(vdev, idx) == VIRTIO_NO_VECTOR) {
> +        (!k->query_guest_notifiers(qbus->parent) ||
> +            virtio_queue_vector(vdev, idx) == VIRTIO_NO_VECTOR)) {
>          file.fd = -1;
>          r = dev->vhost_ops->vhost_set_vring_call(dev, &file);
>          if (r) {
> -- 
> 2.43.5


