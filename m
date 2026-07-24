Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB07C531FC
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 09:49:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnCWD-0003TK-1q; Fri, 24 Jul 2026 05:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnCWB-0003TB-N5
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 05:48:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnCWA-0005B1-58
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 05:48:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784886512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lye0uSP0lGb3OjfxvYX+ADbIclougKZytkoLCvARVzo=;
 b=T2Hd742QL0KScf0Sj39MmVDBrWHdWuItrUxwzpffQ4fJwig90H5hwPL0O4O/xx9CZi1E2q
 LLs/nlBF4ZYEg9ygwwr7+cMg8u5YFSq/g28IwgNKTTHi+L7+Kg14oKIKrT9y7Y65br54ie
 AKKSCNvDwzHRSzmG55xDcdWPouCERDk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-geWHzxr5N5Wy-DKmKxGPpA-1; Fri, 24 Jul 2026 05:48:31 -0400
X-MC-Unique: geWHzxr5N5Wy-DKmKxGPpA-1
X-Mimecast-MFC-AGG-ID: geWHzxr5N5Wy-DKmKxGPpA_1784886510
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47f8158485eso236154f8f.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 02:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784886510; x=1785491310; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Lye0uSP0lGb3OjfxvYX+ADbIclougKZytkoLCvARVzo=;
 b=VodYURzekuNCZHSDQ25alfv08C30A2cLTT6ZcReWXdlKrGHy+pTTsvYR+1JAcMI3eq
 jvueov9axY5koyevx09SVInYZu6sdn9ASUgVu6B/6M3phBOJRfwUCNchJhJfnGqS1WGm
 45hDB1HWnH7uJKO7KSUseLw22h3yXs4Yeu0B90QdVmGo6TDtKfnz/fZATKP2VLGODg7X
 7eNhd7rcY/DE4FdaOwO0kpiNvnb8RWNdiLcqbtdX5OiEG7cSG7pGf4Kgkh9Crym82hre
 DWuR9cTRB2N5qmGh+56HeBzTPs2dnixcMnTdCkjBL02+BHtYZl1IslFDtiSC6hHrAvGo
 vrPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784886510; x=1785491310;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Lye0uSP0lGb3OjfxvYX+ADbIclougKZytkoLCvARVzo=;
 b=IcC/zx3JibZDQvcfGBVair4o1k4g22Eav/XqmPVLcaCXKf+M1kAMzxCoisOOn03ghe
 bUl4rflPv3nPZ7HwwO9AOhn8r+81i1hxiWvTFFhKFeTqCGEWw5xEwqVO8O1dg7FKmUlv
 oMwW6IVmEDXI9xkFL2oQFlCYLcQErTkdo5R82zud1J39+5RPKK21vElSoZkYkPuyeJ1k
 o6/XQzKt7zVLX/y9yOZZzgIJy/3u4enDzGnRpq/32X+Au8HrGFrLzzB3YdtW101Gz6m0
 3/BBCxsEBgrogmoN0LqOfU1RUVT8sdIn5w7xePBdxHuDrapxEedw8uncbxhA+rEmENtI
 uwzQ==
X-Gm-Message-State: AOJu0YxU5NONcuXL3IcUw/oPrWqAUSnshNnTzVNTwo3o5mHihG3cfRxF
 zU2scEcW/MBVBaMnXOTcxmWORaDPqe6wtNNo2Nu5GvZT5AcdfKR23DpBN90csgckThRk5Mmz0OT
 ChbmbrdT4tDCognKj2dUPLhUKvWZwfklKIiQBoyb3JHmFM5lNzkVBsqzhHBVyyLD+
X-Gm-Gg: AR+sD11lgu2XRx6k6S6bTXbhbXVVPQ2t2coySFLyc8VrQ5ADYSWt+w1+N26J03EHrWw
 fYNcRZV5HYnA/A4MWYvi3B5Dsz4krvioDDFOM1L0sxQgVjweO0Jec9biG+aPHRXee9bE1BYRU41
 Jx84ADlVX7DnJnvF+HWv51KKIGCmcly9KPRYladXbTF8Z2KUF9Di+ovvYjrOJIDaK7UliSBxvS2
 X0YrUfUrtAc1kenXBjtCZQmUQfvQ5q4G7T/5iCK5q7K5GCsMD6Gpl7KpB9b0Za8xqxvbQdt5onA
 9q8FkRveJIhMoJkCwsmc+NCjH0y6a/XcOV6bRy2yqlRZbZ5ASZgS05bR/TBpOunYU53roxJqoa0
 AoXZOqLhwePcm4F6LsL2A8w==
X-Received: by 2002:a05:6000:2212:b0:47f:9ac6:c9bc with SMTP id
 ffacd0b85a97d-47f9ac6cb55mr1147489f8f.2.1784886509769; 
 Fri, 24 Jul 2026 02:48:29 -0700 (PDT)
X-Received: by 2002:a05:6000:2212:b0:47f:9ac6:c9bc with SMTP id
 ffacd0b85a97d-47f9ac6cb55mr1147441f8f.2.1784886509191; 
 Fri, 24 Jul 2026 02:48:29 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c52fa9sm24509592f8f.20.2026.07.24.02.48.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 02:48:28 -0700 (PDT)
Date: Fri, 24 Jul 2026 05:48:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Weimin Xiong <xiongwm2026@163.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, virtualization@lists.linux.dev,
 Xiong Weimin <xiongweimin@kylinos.cn>
Subject: Re: [PATCH 2/3] hw/virtio: Implement vhost_log_start and
 vhost_log_stop
Message-ID: <20260724054712-mutt-send-email-mst@kernel.org>
References: <20260724093759.810108-1-xiongwm2026@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724093759.810108-1-xiongwm2026@163.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.951,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jul 24, 2026 at 05:37:58PM +0800, Weimin Xiong wrote:
> From: Xiong Weimin <xiongweimin@kylinos.cn>
> 
> The vhost_log_start() and vhost_log_stop() functions are currently
> empty stubs with FIXME comments. Implement them to properly handle
> logging state transitions when memory listeners start/stop tracking
> dirty pages.
> 
> This is needed for proper dirty page logging during live migration.

Is the implications that in your opinion dirty page logging during live
migration does not work currently?

> Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
> ---
>  hw/virtio/vhost.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 1234567890ab..fedcba098765 4321006
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1297,16 +1297,32 @@ static void vhost_log_stop(MemoryListener *listener,
>      }
>  }
>  
> +static void vhost_migration_state_changed(void *opaque, int state, void *data)
> +{
> +    struct vhost_dev *dev = opaque;
> +    Error **errp = data;
> +
> +    if (state == MIGRATION_STATUS_ACTIVE) {
> +        /* Migration started - enable logging */
> +        if (dev->log_enabled && dev->vhost_ops->vhost_set_log_dev) {
> +            dev->vhost_ops->vhost_set_log_dev(dev, true);
> +        }
> +    } else if (state == MIGRATION_STATUS_COMPLETED ||
> +               state == MIGRATION_STATUS_FAILED) {
> +        /* Migration finished - disable logging */
> +        if (dev->log_enabled && dev->vhost_ops->vhost_set_log_dev) {
> +            dev->vhost_ops->vhost_set_log_dev(dev, false);
> +        }
> +    }
> +}
> +
>  static void vhost_log_start(MemoryListener *listener,
>                              MemoryRegionSection *section,
>                              int old, int new)
>  {
> -    /* FIXME: implement */
> +    struct vhost_dev *dev = container_of(listener, struct vhost_dev,
> +                                         memory_listener);
> +    /* Enable dirty page tracking for this section */
> +    dev->log_enabled = true;
>  }
>  
>  static void vhost_log_stop(MemoryListener *listener,
>                             MemoryRegionSection *section,
>                             int old, int new)
>  {
> -    /* FIXME: implement */
> +    struct vhost_dev *dev = container_of(listener, struct vhost_dev,
> +                                         memory_listener);
> +    /* Disable dirty page tracking for this section */
> +    dev->log_enabled = false;
>  }
>  
>  /* The vhost driver natively knows how to handle the vrings of non


