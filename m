Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA75FD3B7F3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 20:48:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT4ce-00049Z-H5; Tue, 09 Dec 2025 15:47:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vT4cc-000496-Sv
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 15:47:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vT4cb-0002Fl-7N
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 15:47:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765313263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lsJ0gRmrsTAhefHx3sWOjQ6vWt+RlN6/TnsAlicPJT0=;
 b=dzz1rdgDhGTnlAJYVKaUHcL5VL78fB7T2PVZUY6QDEyueiBgFRsOGD0MtdYIPr6TZFXqp8
 uE1ZT/Q9MvhPKFSQfFM4k/oXSgoT5NKkAc0xmpvVe8DIA6XHnZa7H1mCA9Ee7KRQ3bXo7j
 GqNzhuYCpRGEOF3pQ6gx6uzpSogRaFM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-x2EpOacaM0eYEWS43pM6Tg-1; Tue, 09 Dec 2025 15:47:37 -0500
X-MC-Unique: x2EpOacaM0eYEWS43pM6Tg-1
X-Mimecast-MFC-AGG-ID: x2EpOacaM0eYEWS43pM6Tg_1765313256
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8b2e2342803so1383549485a.3
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 12:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765313256; x=1765918056; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lsJ0gRmrsTAhefHx3sWOjQ6vWt+RlN6/TnsAlicPJT0=;
 b=Y/YiVAk1PTwLxDjyKGiMqNPGbNa321PV1vf3uxCXMMH9Gk8bX2ydn0CHDfFeulyZGM
 bgSni9fFsOD4aXyAteC3MLl2Sbtep/R1YHqNkrJzvf1Nd3KItNmoAkyqHcpXOm2AB83R
 GsYGhUrj0IIfBgsS2gJ/GZtbf4MFlQIkrgM+r5Q0cDYXKEkAFg56thzRsjhYZyKoS3uU
 dINYABR5QlrHnN1uJv4XX/qIrsWG0LfeJ31zaecx/YAJMP65+4ALgDJ3Lswo/ZomBPPI
 qrla7POcKvVgrQMUTStoFHlZTEuvq62rKKjfVwzt9LrIyVTpXhaFmaXtV+DyK3WGzrIo
 x9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765313256; x=1765918056;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lsJ0gRmrsTAhefHx3sWOjQ6vWt+RlN6/TnsAlicPJT0=;
 b=dn9lDyEi6vkO9pP7GZghPRJuMCP32vb0ST3OkaE5OQmyAdVIJCoWEkoqs05T4+or37
 xIKxyfILJfjbZcIXqZXAJzyt2hiw5JBuA6eTcsu8Mto6zkU6eAD43mb1jB4HbzBqa1jK
 WkvWy25BjogF1oIsmnCpqMCujQlZHt7Exq5paKmCYSRVvoGW/eGcKwVKfD7opJiimeAZ
 qvMQqIJvMBZ9GfMnL9Osd/+7glS4vTEGKo8SK+33IPlRZN9OJKccOVbaqc6+KJ4AVbBe
 XQPB25/bfdc8ny1cg8JvZNmOpGAZo53beGAejrr4TyVumUg+mMMUa1vJJam3uzyt2J+h
 sgYg==
X-Gm-Message-State: AOJu0YzRcyY+ygVwV1bp0zUy16i1L6OK4h7WwgRt4CF8Kd/NTnEr1mYQ
 SnYuyfLldiQ7/ft0OAgOOE9/TQuGeyjZ6CO3iNOWmuPWNsPb+Y9KPvMlY+Y/gsT6MZ8sKZc99lt
 4e8aDv13c5tD9HIeozIwTbeRaQnDRStZpJsgCpE1QGbI01mWO3MKsrDQS
X-Gm-Gg: ASbGnctYmnqJnYWjs1hpkS9E81capZVpDOeuP6ZIUewIhn4oBJyw1X1l2LXXBUaTvDz
 53DW+mS5XNJnQUNpJo9LY/ibCBR7oKmOfoMJ40wBcL/Fs15jVBUPOyWRgk8Jj7tgO37w7BMgSL2
 vTmbUIaYt222cw+Bp8Zeuu1hqeGtyAFQJT4AhN4WiUeWDLNoXNQ81FIrfI09RmgBQVnD6oIi5pN
 fhsoNxsM/6aoht4ZLo5oaCJ2poxfXzixB1Y9lx/FSQ3CuO9PlXiu5pfE4gJMbcN8fVhzRhvL0Ju
 9U9/ugBRkzgoeoV4u6Q1osyLhJn+E/BLIR7QZj8pamrbEi4TbgM01nLD715ATtvFa5ZKGa4KvDs
 KKE0=
X-Received: by 2002:a05:620a:461e:b0:8a3:1b83:1025 with SMTP id
 af79cd13be357-8ba39f53438mr63242685a.73.1765313256565; 
 Tue, 09 Dec 2025 12:47:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH86txVxEk/WFDkxz60kdt9b+evqGM8WnIP2OAk404+NZfPgwJOTIxsSCCHrJCybxU6FeQLtw==
X-Received: by 2002:a05:620a:461e:b0:8a3:1b83:1025 with SMTP id
 af79cd13be357-8ba39f53438mr63237985a.73.1765313256056; 
 Tue, 09 Dec 2025 12:47:36 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b6252b5235sm1359353085a.18.2025.12.09.12.47.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 12:47:35 -0800 (PST)
Date: Tue, 9 Dec 2025 15:47:34 -0500
From: Peter Xu <peterx@redhat.com>
To: Chuang Xu <xuchuangxclwt@bytedance.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, sgarzare@redhat.com,
 richard.henderson@linaro.org, pbonzini@redhat.com, david@kernel.org,
 philmd@linaro.org, farosas@suse.de, Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC v1 1/2] vhost: eliminate duplicate dirty_bitmap sync when
 log shared by multiple devices
Message-ID: <aTiK5opcOOrsFem9@x1.local>
References: <20251208120952.37563-1-xuchuangxclwt@bytedance.com>
 <20251208120952.37563-2-xuchuangxclwt@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251208120952.37563-2-xuchuangxclwt@bytedance.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Mon, Dec 08, 2025 at 08:09:51PM +0800, Chuang Xu wrote:
> From: xuchuangxclwt <xuchuangxclwt@bytedance.com>
> 
> Although logs can now be shared among multiple vhost devices,
> live migration still performs repeated vhost_log_sync for each
> vhost device during bitmap_sync, which increases the time required
> for bitmap_sync and makes it more difficult for dirty pages to converge.
> 
> Attempt to eliminate these duplicate sync.
> 
> Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>

It looks reasonable from migration POV, but I don't know the details.

Please remember to copy Jason (I added for this email) when repost.

Thanks,

> ---
>  hw/virtio/vhost.c         | 30 ++++++++++++++++++++++--------
>  include/hw/virtio/vhost.h |  1 +
>  2 files changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 266a11514a..d397ca327f 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -268,14 +268,6 @@ static int vhost_sync_dirty_bitmap(struct vhost_dev *dev,
>      return 0;
>  }
>  
> -static void vhost_log_sync(MemoryListener *listener,
> -                          MemoryRegionSection *section)
> -{
> -    struct vhost_dev *dev = container_of(listener, struct vhost_dev,
> -                                         memory_listener);
> -    vhost_sync_dirty_bitmap(dev, section, 0x0, ~0x0ULL);
> -}
> -
>  static void vhost_log_sync_range(struct vhost_dev *dev,
>                                   hwaddr first, hwaddr last)
>  {
> @@ -287,6 +279,27 @@ static void vhost_log_sync_range(struct vhost_dev *dev,
>      }
>  }
>  
> +static void vhost_log_sync(MemoryListener *listener,
> +                          MemoryRegionSection *section)
> +{
> +    struct vhost_dev *dev = container_of(listener, struct vhost_dev,
> +                                         memory_listener);
> +    struct vhost_log *log = dev->log;
> +
> +    if (log && log->refcnt > 1) {
> +        /*
> +         * When multiple devices use same log, we implement the logic of
> +         * vhost_log_sync just like what we do in vhost_log_put.
> +         */
> +        log->sync_cnt = (log->sync_cnt + 1) % log->refcnt;
> +        if (!log->sync_cnt) {
> +            vhost_log_sync_range(dev, 0, dev->log_size * VHOST_LOG_CHUNK - 1);
> +        }
> +    } else {
> +        vhost_sync_dirty_bitmap(dev, section, 0x0, ~0x0ULL);
> +    }
> +}
> +
>  static uint64_t vhost_get_log_size(struct vhost_dev *dev)
>  {
>      uint64_t log_size = 0;
> @@ -383,6 +396,7 @@ static struct vhost_log *vhost_log_get(VhostBackendType backend_type,
>          ++log->refcnt;
>      }
>  
> +    log->sync_cnt = 0;
>      return log;
>  }
>  
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index 08bbb4dfe9..43bf1c2150 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -50,6 +50,7 @@ typedef unsigned long vhost_log_chunk_t;
>  struct vhost_log {
>      unsigned long long size;
>      int refcnt;
> +    int sync_cnt;
>      int fd;
>      vhost_log_chunk_t *log;
>  };
> -- 
> 2.20.1
> 

-- 
Peter Xu


