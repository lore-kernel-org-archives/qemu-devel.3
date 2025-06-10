Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C39C5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 16:59:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP29V-0007YJ-UZ; Tue, 10 Jun 2025 12:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uP22D-0000wc-PR
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 12:41:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uP227-0006Uc-VL
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 12:41:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749573665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/l1nu3eIkA8q1+141NllUUiIrxxn5cUe0PTOoycycI0=;
 b=Jh6ENB+kjsbV/AibqNAMPjDtkUT7B6z9IZKy+EGQDBsndc2cIg4xPGNtGbvRDQYRdIGbQs
 rbE//IuaDdRzWsCgVckvgHJzedANjKAd5rYBQvKsv/u2YyZRzbSxqpTsrFBi6S2ReQWc9l
 G1kD6UHifsZm9hyfVgqfdo1sFkxm6UA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-VfBSVSZFNDyrSBoljajIfA-1; Tue, 10 Jun 2025 12:41:04 -0400
X-MC-Unique: VfBSVSZFNDyrSBoljajIfA-1
X-Mimecast-MFC-AGG-ID: VfBSVSZFNDyrSBoljajIfA_1749573663
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a3696a0d3aso2383791f8f.2
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 09:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749573663; x=1750178463;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/l1nu3eIkA8q1+141NllUUiIrxxn5cUe0PTOoycycI0=;
 b=l226RwPKnhxTH7dg1DNJx5Z3OKpciKyRMurA4kzx0idd44yToWAHdtmY9MQqUwuRly
 U/fQjl6DKcXt0Dp3Z1HuCRBfD1S/ZWryw1jZn8rywWCtIq9A0IOIAM5KzoNhdvWlLl0n
 V0BxBqD+aMKWME5Z3cdfHn87F4VzSKl1JE/y0rm2mTbyy7xXmbT8bWBfSCvz3ZSwFHRB
 JTFjoSK6CMh5dPm0lwXEOaYVeAAX6L3c1LDE5TQPARxxsYA99ai/NoO+Qg83bT3rkFvT
 53HyvcgOmlIB1pQp40qdIAEV9mdKYS/Whh1Vidkt4G0I0DmSwUen/bwVKH+jTwZeDfnr
 mLYg==
X-Gm-Message-State: AOJu0YxxyF79XnWkrt74EaunDlcO73gLy3XVlxrbEeN+0nCRVM0uwJ0F
 8jJxz1VQhA3/pDzMXvrMIsmkl8Ap/JC2gW3DaUAU65fk0TdSiNO9LKIbYvG90/FbiIFRsH2TYbk
 iSIwI3CnJXGscq9R9wa7SntsuBtiYHdyUDxPdTOpR3cQ0qhvnuwh+akhS
X-Gm-Gg: ASbGncssXWPXcrmNNNDhSanfe51t6f1oKWzdkIK/M3H5o4p9V+2QdYhRBeinR3BCsWX
 WZNu53YmH6dxDvIiLH+4uOrXp77mVlLkYJPwYrjqUT22GLe+DJJgQEoS0nuRNRUZOKAGvFwFMbz
 ZZIh00I5Ack8FctvAsegGLwBAD02Cl/qmo9ChYxguWx9705ZgD6w+xPH+ZiSF1Wkb65yUQtXBCY
 L4mQN2y02gqxpnc1jkurGIS/plnY18vFWtWLS9XsMbkrN4X6GDjHwxMI/WHhsInTuBT/38erHaN
 m8gHKYrLkXZ50Jys
X-Received: by 2002:a05:6000:1207:b0:3a5:34da:542f with SMTP id
 ffacd0b85a97d-3a534da5596mr9610885f8f.43.1749573663279; 
 Tue, 10 Jun 2025 09:41:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWulD7kabhvRzfbjbgjl9CRbahdfyWKpNtYz9ieTboda8K3ovVQ8x2kaMyzpangzoI2LcIXQ==
X-Received: by 2002:a05:6000:1207:b0:3a5:34da:542f with SMTP id
 ffacd0b85a97d-3a534da5596mr9610867f8f.43.1749573662887; 
 Tue, 10 Jun 2025 09:41:02 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a5323b33c3sm12886120f8f.34.2025.06.10.09.41.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 09:41:02 -0700 (PDT)
Date: Tue, 10 Jun 2025 12:41:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH] virtio: avoid cost of -ftrivial-auto-var-init in hot path
Message-ID: <20250610123707-mutt-send-email-mst@kernel.org>
References: <20250604191843.399309-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250604191843.399309-1-stefanha@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Jun 04, 2025 at 03:18:43PM -0400, Stefan Hajnoczi wrote:
> Since commit 7ff9ff039380 ("meson: mitigate against use of uninitialize
> stack for exploits") the -ftrivial-auto-var-init=zero compiler option is
> used to zero local variables. While this reduces security risks
> associated with uninitialized stack data, it introduced a measurable
> bottleneck in the virtqueue_split_pop() and virtqueue_packed_pop()
> functions.
> 
> These virtqueue functions are in the hot path. They are called for each
> element (request) that is popped from a VIRTIO device's virtqueue. Using
> __attribute__((uninitialized)) on large stack variables in these
> functions improves fio randread bs=4k iodepth=64 performance from 304k
> to 332k IOPS (+9%).

I ask however whether it is always not worth it for all users.
It does reduce chances of leaking stack info, does it not?

Maybe we can start with a tri-state Kconfig knob to select between
performance/balanced/paranoid for this and similar variables?


> This issue was found using perf-top(1). virtqueue_split_pop() was one of
> the top CPU consumers and the "annotate" feature showed that the memory
> zeroing instructions at the beginning of the functions were hot.
> 
> Fixes: 7ff9ff039380 ("meson: mitigate against use of uninitialize stack for exploits")
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  include/qemu/compiler.h | 12 ++++++++++++
>  hw/virtio/virtio.c      |  8 ++++----
>  2 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
> index 496dac5ac1..fabd540b02 100644
> --- a/include/qemu/compiler.h
> +++ b/include/qemu/compiler.h
> @@ -207,6 +207,18 @@
>  # define QEMU_USED
>  #endif
>  
> +/*
> + * Disable -ftrivial-auto-var-init on a local variable. Use this in rare cases
> + * when the compiler zeroes a large on-stack variable and this causes a
> + * performance bottleneck. Only use it when performance data indicates this is
> + * necessary since security risks increase with uninitialized stack variables.
> + */
> +#if __has_attribute(uninitialized)
> +# define QEMU_UNINITIALIZED __attribute__((uninitialized))
> +#else
> +# define QEMU_UNINITIALIZED
> +#endif
> +
>  /*
>   * http://clang.llvm.org/docs/ThreadSafetyAnalysis.html
>   *
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 5534251e01..82a285a31d 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -1689,8 +1689,8 @@ static void *virtqueue_split_pop(VirtQueue *vq, size_t sz)
>      VirtIODevice *vdev = vq->vdev;
>      VirtQueueElement *elem = NULL;
>      unsigned out_num, in_num, elem_entries;
> -    hwaddr addr[VIRTQUEUE_MAX_SIZE];
> -    struct iovec iov[VIRTQUEUE_MAX_SIZE];
> +    hwaddr QEMU_UNINITIALIZED addr[VIRTQUEUE_MAX_SIZE];
> +    struct iovec QEMU_UNINITIALIZED iov[VIRTQUEUE_MAX_SIZE];
>      VRingDesc desc;
>      int rc;
>  
> @@ -1836,8 +1836,8 @@ static void *virtqueue_packed_pop(VirtQueue *vq, size_t sz)
>      VirtIODevice *vdev = vq->vdev;
>      VirtQueueElement *elem = NULL;
>      unsigned out_num, in_num, elem_entries;
> -    hwaddr addr[VIRTQUEUE_MAX_SIZE];
> -    struct iovec iov[VIRTQUEUE_MAX_SIZE];
> +    hwaddr QEMU_UNINITIALIZED addr[VIRTQUEUE_MAX_SIZE];
> +    struct iovec QEMU_UNINITIALIZED iov[VIRTQUEUE_MAX_SIZE];
>      VRingPackedDesc desc;
>      uint16_t id;
>      int rc;
> -- 
> 2.49.0


