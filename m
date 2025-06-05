Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB677C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 08:36:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN63P-0001SA-Io; Thu, 05 Jun 2025 04:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uN63H-0001R0-2y
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 04:34:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uN63E-0006e8-ED
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 04:34:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749112455;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=01E7vXHsd8DJFiPRdr2AncfqlZyUgCRn4a6z6Rjb2AQ=;
 b=Xyy0wcU4JyMMO99ijVpB7JrXot9KlvUv13D3E0rwuHUjCxf9NkbZlvKP5jbT3pt7INvHqO
 +Pp2s/wZKNmJcDvLx1gG9D0NR4GH7YLvGjdhID3qYglHVqRDnRf078/Ct28xVq3YNghZgB
 1KkL6WNDYnkyUO6+60Lmi5EyuJXVoOg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-_WjjoJnIOkOiWtWY2sgoOg-1; Thu,
 05 Jun 2025 04:34:08 -0400
X-MC-Unique: _WjjoJnIOkOiWtWY2sgoOg-1
X-Mimecast-MFC-AGG-ID: _WjjoJnIOkOiWtWY2sgoOg_1749112448
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D178618004A3; Thu,  5 Jun 2025 08:34:07 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.159])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 953FA30002C0; Thu,  5 Jun 2025 08:34:05 +0000 (UTC)
Date: Thu, 5 Jun 2025 09:34:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio: avoid cost of -ftrivial-auto-var-init in hot path
Message-ID: <aEFWeZUlqqRvHsJT@redhat.com>
References: <20250604191843.399309-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250604191843.399309-1-stefanha@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
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

IIUC, the 'hwaddr addr' variable is 8k in size, and the 'struct iovec iov'
array is 16k in size, so we have 24k on the stack that we're clearing and
then later writing the real value. Makes sense that this would have a
perf impact in a hotpath.

> This issue was found using perf-top(1). virtqueue_split_pop() was one of
> the top CPU consumers and the "annotate" feature showed that the memory
> zeroing instructions at the beginning of the functions were hot.

When you say you found it with 'perf-top' was that just discovered by
accident, or was this usage of perf-top in response to users reporting
a performance degradation vs earlier QEMU ?

> 
> Fixes: 7ff9ff039380 ("meson: mitigate against use of uninitialize stack for exploits")
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  include/qemu/compiler.h | 12 ++++++++++++
>  hw/virtio/virtio.c      |  8 ++++----
>  2 files changed, 16 insertions(+), 4 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


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

For the benefit of other reviewers, this attribute is specifically
intended for this very purpose:

[quote "info gcc"]
  ‘uninitialized’
     This attribute, attached to a variable with automatic storage,
     means that the variable should not be automatically initialized by
     the compiler when the option ‘-ftrivial-auto-var-init’ presents.

     With the option ‘-ftrivial-auto-var-init’, all the automatic
     variables that do not have explicit initializers will be
     initialized by the compiler.  These additional compiler
     initializations might incur run-time overhead, sometimes
     dramatically.  This attribute can be used to mark some variables to
     be excluded from such automatic initialization in order to reduce
     runtime overhead.

     This attribute has no effect when the option
     ‘-ftrivial-auto-var-init’ is not present.
[/quote]

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
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


