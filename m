Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C75CD98F7
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 14:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZrJ6-0007di-Ea; Wed, 17 Jun 2026 10:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wZrJ5-0007cv-AC
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:31:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wZrJ3-00080P-KF
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:31:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781706713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=63AVX9elybGqlyEe7A6i6EhwT3SY8xT2KmCtYBxb3S4=;
 b=bpFMxbU/qUiizfDpnWzGPCb6wKY6s80z5FiojelEuBozAupem2xiZkpknH3UiqpcEdkEvg
 TRnCZMMly8xSJqPjEDrAWN1kpxJSGu/DQ9zRrnK0Pmbu+SEUlxpcjWD+FnmCCxZcKhJmCX
 paMg2dYLbg486dovKT//O/r9l0IeWlo=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-uiOrzR57O8a9O71uxBrKzw-1; Wed, 17 Jun 2026 10:31:51 -0400
X-MC-Unique: uiOrzR57O8a9O71uxBrKzw-1
X-Mimecast-MFC-AGG-ID: uiOrzR57O8a9O71uxBrKzw_1781706711
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-726eb357779so194802137.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 07:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781706711; x=1782311511; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=63AVX9elybGqlyEe7A6i6EhwT3SY8xT2KmCtYBxb3S4=;
 b=ccYHIbTHoo10fEtBZoPPmeBGXa50sLagYTP768IABz7ibT3h2AT6s3W0CsoIKgbBwr
 H5mM3w4ue0FQUNVVIJj1v3YoIZHY3Nqn2+G5ePIS+PBczU9/Vt9+wFxAT7hc4ZT0i1r7
 Iej4TafrkR6fzHLHWKXItVxNEwFpSqCVt3zT5MurqdCtal2bKVB8ucbTLC+NKipV1oBX
 wvamkCIJjx7pvhT1/8xfgd3hi5hkInPXFBtOen2ahBQvlovvFfRY+GMY/gMzdJWxNn0+
 yZ19Pr8dP80nsyefcC7VV0D4NnMsYe+U29FD7MRXyWwJo1l6zVCae35R0gn8i5idbt5m
 LRhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781706711; x=1782311511;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=63AVX9elybGqlyEe7A6i6EhwT3SY8xT2KmCtYBxb3S4=;
 b=kSzbNDgtl4LzD92zOp5nheuJfft/9iWwfzf4gAiKxhAZkXtG5Zibxrc0vH+fYZIMLH
 cGquDHHdrcCk3O55RjvHyG27np4yjQ04LUUXcX1QWxsBRF6mXvDMYysmU1c7E2JL0tkk
 unabPDtcSM+ecpJRELo7oVyE9qFv1hJnJF72MdcSGoNaj0D6hMiv7dJzLge0CntozEqz
 VAa3dJhnMIlSa/ml8uhCabwPFuyhnDdgVtgdNRqCIMEcqZuHilw0DsBaUbtmhpjPkrsu
 snLShp70+nVAez7dxfV/TU6Urh7lTBHvtWpZLZx3F+2avWmdvCRw7HZ79znV8QH7bGpm
 kRAQ==
X-Gm-Message-State: AOJu0YwWVXB1wibYACu97xifdBR/0MC3WKV6FT2bKCY/0Ow+U+uLrby7
 QbVbbaaN7tBu3WRlexUmJ5YiFc8yNJShBncYhtexMDP/N2hCNhIORQZgVO2NiBNriV37q2D6531
 ggrPE8W/eZUb6ZlK3R4nHSnukiC8fht39P2YMKNDGIKlTWb6rmLD0ivsF
X-Gm-Gg: AfdE7cmQ5p8/nQ4DpAkmrG/lawzneDgUc9nVQwmV8fQHxDMVCjI6qbfxkNYAFtCV7El
 k5oiPX0B6ixgmJs5nNqA4KL7phWm2aawlObJVeP+M/Am9Yd43eRSeQlHdTlPBhqz03qAsP3zY+g
 nW1/VBY5E69TuJH9MsIwQEKww8TTUH8jGGfEy0se+zMpFoSBn18Beozlyw1quJpXwWIQTvz9JOT
 6u2G65AuDtg2EzATuoBqbg0DdOPbQfV3z9t9C8odl4ZW6mwUV4jSR6hmlrxW1YmUrU3BeFD42BU
 fU1G7UL0ixowDxK9KIEGFzDd/KcCBzYZHzCJOO6/vDut5jDOyUKMStyvM4yhAhdlSHRxa39B6IB
 G4VI=
X-Received: by 2002:a05:6102:38c8:b0:660:d26b:506e with SMTP id
 ada2fe7eead31-7245d531807mr2969197137.1.1781706711270; 
 Wed, 17 Jun 2026 07:31:51 -0700 (PDT)
X-Received: by 2002:a05:6102:38c8:b0:660:d26b:506e with SMTP id
 ada2fe7eead31-7245d531807mr2969090137.1.1781706710611; 
 Wed, 17 Jun 2026 07:31:50 -0700 (PDT)
Received: from x1.local ([174.91.116.48]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-91619ed8c83sm1739043285a.5.2026.06.17.07.31.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 07:31:50 -0700 (PDT)
Date: Wed, 17 Jun 2026 10:31:02 -0400
From: Peter Xu <peterx@redhat.com>
To: Bin Guo <guobin@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, lizhijian@fujitsu.com, farosas@suse.de,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH v2 1/2] migration/rdma: honor blocking mode in
 QIOChannelRDMA readv
Message-ID: <ajKvputk1JI0tPAY@x1.local>
References: <20260617064332.75618-1-guobin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260617064332.75618-1-guobin@linux.alibaba.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jun 17, 2026 at 02:43:31PM +0800, Bin Guo wrote:
> QIOChannelRDMA's readv already blocks inside qemu_rdma_exchange_recv()
> when waiting for the next RDMA SEND message.  What it did not do was
> keep blocking when the bytes from a single receive were insufficient
> to satisfy the full request -- it returned partial data (or EAGAIN)
> instead of waiting for more.

Sorry if I wasn't clear when commenting, but what I meant is, this is
correct behavior for blocking/nonblocking.

If io_readv() reads partial, IIUC returning how much it reads is the
correct behavior.  You can refer to qio_channel_socket_readv().

Here, RDMA doesn't respect blocking is because it _always_ blocks.  That
is, qemu_rdma_exchange_recv() always will block even if blocking=false.

I believe it will normally stop working when it's used in a coroutine,
because normally we rely on non-blocking to allow it fallback to caller
then things like qio_channel_wait_cond() will yield if it's coroutine.

I recall RDMA still works only because it has some internal hack to yield,
maybe that's qemu_rdma_wait_comp_channel(), but I really don't know RDMA
well, at least so far.. maybe I should try to improve at some point.
Before that, it would be good Zhijian can have another look on this.

Let me loop in Dan too.

Thanks,

> 
> Loop on qemu_rdma_exchange_recv() when the channel is blocking and
> the receive buffer cannot satisfy the request.  This matches the
> behaviour of other QIOChannel implementations, which block until
> the full request is satisfied (or an error occurs).
> 
> Also remove the stale XXX comments about unimplemented blocking support.
> 
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
> ---
>  migration/rdma.c | 46 +++++++++++++++++++++-------------------------
>  1 file changed, 21 insertions(+), 25 deletions(-)
> 
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 3e37a1d440..201cb9eb12 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -388,7 +388,7 @@ struct QIOChannelRDMA {
>      QIOChannel parent;
>      RDMAContext *rdmain;
>      RDMAContext *rdmaout;
> -    bool blocking; /* XXX we don't actually honour this yet */
> +    bool blocking;
>  };
>  
>  /*
> @@ -2710,32 +2710,29 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *ioc,
>              break;
>          }
>  
> -
> -        /* We've got nothing at all, so lets wait for
> -         * more to arrive
> -         */
> -        ret = qemu_rdma_exchange_recv(rdma, &head, RDMA_CONTROL_QEMU_FILE,
> -                                      errp);
> -
> -        if (ret < 0) {
> -            rdma->errored = true;
> -            return -1;
> -        }
> -
>          /*
> -         * SEND was received with new bytes, now try again.
> +         * We've got nothing at all, so lets wait for
> +         * more to arrive.
>           */
> -        len = qemu_rdma_fill(rdma, data, want, 0);
> -        done += len;
> -        want -= len;
> -
> -        /* Still didn't get enough, so lets just return */
> -        if (want) {
> -            if (done == 0) {
> -                return QIO_CHANNEL_ERR_BLOCK;
> -            } else {
> -                break;
> +        do {
> +            ret = qemu_rdma_exchange_recv(rdma, &head,
> +                                          RDMA_CONTROL_QEMU_FILE, errp);
> +            if (ret < 0) {
> +                rdma->errored = true;
> +                return -1;
>              }
> +
> +            /*
> +             * SEND was received with new bytes, now try again.
> +             */
> +            len = qemu_rdma_fill(rdma, data, want, 0);
> +            done += len;
> +            want -= len;
> +            data += len;
> +        } while (want && rioc->blocking);
> +
> +        if (want && done == 0) {
> +            return QIO_CHANNEL_ERR_BLOCK;
>          }
>      }
>      return done;
> @@ -2771,7 +2768,6 @@ static int qio_channel_rdma_set_blocking(QIOChannel *ioc,
>                                           Error **errp)
>  {
>      QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(ioc);
> -    /* XXX we should make readv/writev actually honour this :-) */
>      rioc->blocking = blocking;
>      return 0;
>  }
> -- 
> 2.50.1 (Apple Git-155)
> 

-- 
Peter Xu


