Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1800C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 20:51:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBhJB-0004oP-07; Mon, 27 May 2024 16:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sBhJ9-0004oG-IA
 for qemu-devel@nongnu.org; Mon, 27 May 2024 16:51:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sBhJ7-0007yO-Cm
 for qemu-devel@nongnu.org; Mon, 27 May 2024 16:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716843060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ajf4u0txmh4j/zmp2TyFtJysYzehrfivsWnTj1vvqbA=;
 b=CaLXfCgVypB6VBgCSTSlCiS21amhvxM3OukZ6SnaKr3Gj1E4kPVhEJFzmeueiyOqYhsoGK
 B6IvvcV17zZKkQ2MzOS4AHCkdo5FFFHUtK7bzm9bHA9Tf/EAUZQdSXZOgXVhDVLNAmrVxH
 6q+pGFAeOWyy0OvdbdC3cbAG0HOFTjk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-pXTeBaprNViIEGQmJ0cdkQ-1; Mon, 27 May 2024 16:50:59 -0400
X-MC-Unique: pXTeBaprNViIEGQmJ0cdkQ-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-43fb05ee915so9931cf.2
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 13:50:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716843058; x=1717447858;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ajf4u0txmh4j/zmp2TyFtJysYzehrfivsWnTj1vvqbA=;
 b=Mk40yf80+Al4l3449QJVvkZ1LTKWZqPvfiDyOtI1KDffuMqznS5BLOjiOSVA7d95es
 RX97UMogmcGPenTcW65z/J5a273la8wO/xwOhmsP3sll7WMV1YggBztlURwFGy6SvCfB
 SKZEphI1dER9uI6EuOz4J6w8lnnaR9OO32DtLsuwVrh8QGv3VolsWToXAmE3KW4bPSoh
 76CbCWS8EKp2DS/Y+JkEFbpgXXzfyi0I2GDLC91qhAaV9CaFzw4w7zL7PvPwObgbZYz5
 MaUw7/1hCiccI0Ao29Yqp+BBxAVD6W3S0i/ZNGjZDPzsr1+1QprO6yTE3lVHDFqZpZDh
 DmXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUb+PDRU92HKE2GJZgFjdIVFxu4PF0BdM+aT9M+V2+uosZKcBgEVb9RW0GyQjrCav7Ko75cB9iWmuzDBda5KzNMBSPjNc8=
X-Gm-Message-State: AOJu0Yygjk/fH030gZyRV5thuVH4VRQXvkk1WxvZpLcbl9djpyPnJYxo
 qy0QaSPnZcdEci6oP0tu4lVsqdM29B3+UiFhKKVv7xTlmT7u53tsQcJzq1zFZV1dSqHo9UzDxFO
 QWxw1D8cv4sRS5QsVI86zSsndgl8V8C1fWO2+GRPgLe3pYgmNgmJs
X-Received: by 2002:ac8:590c:0:b0:439:a36f:eaeb with SMTP id
 d75a77b69052e-43fb0d79eefmr103798471cf.0.1716843058107; 
 Mon, 27 May 2024 13:50:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9/xmoV51LNJT9cDY4XsfvW8h908ZeKOddHPFXXkXWLjeZIl2hLDSqdpPiwVDHkBw/2WP6VA==
X-Received: by 2002:ac8:590c:0:b0:439:a36f:eaeb with SMTP id
 d75a77b69052e-43fb0d79eefmr103798231cf.0.1716843057325; 
 Mon, 27 May 2024 13:50:57 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43fb18b0cc9sm36888651cf.69.2024.05.27.13.50.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 13:50:56 -0700 (PDT)
Date: Mon, 27 May 2024 16:50:54 -0400
From: Peter Xu <peterx@redhat.com>
To: Yuan Liu <yuan1.liu@intel.com>
Cc: farosas@suse.de, qemu-devel@nongnu.org, nanhai.zou@intel.com
Subject: Re: [PATCH v6 2/7] migration/multifd: put IOV initialization into
 compression method
Message-ID: <ZlTyLrRrSYkHjutG@x1n>
References: <20240505165751.2392198-1-yuan1.liu@intel.com>
 <20240505165751.2392198-3-yuan1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240505165751.2392198-3-yuan1.liu@intel.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, May 06, 2024 at 12:57:46AM +0800, Yuan Liu wrote:
> Different compression methods may require different numbers of IOVs.
> Based on streaming compression of zlib and zstd, all pages will be
> compressed to a data block, so two IOVs are needed for packet header
> and compressed data block.
> 
> Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
> ---
>  migration/multifd-zlib.c |  7 +++++++
>  migration/multifd-zstd.c |  8 +++++++-
>  migration/multifd.c      | 22 ++++++++++++----------
>  3 files changed, 26 insertions(+), 11 deletions(-)
> 
> diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
> index 737a9645d2..2ced69487e 100644
> --- a/migration/multifd-zlib.c
> +++ b/migration/multifd-zlib.c
> @@ -70,6 +70,10 @@ static int zlib_send_setup(MultiFDSendParams *p, Error **errp)
>          goto err_free_zbuff;
>      }
>      p->compress_data = z;
> +
> +    /* Needs 2 IOVs, one for packet header and one for compressed data */
> +    p->iov = g_new0(struct iovec, 2);
> +
>      return 0;
>  
>  err_free_zbuff:
> @@ -101,6 +105,9 @@ static void zlib_send_cleanup(MultiFDSendParams *p, Error **errp)
>      z->buf = NULL;
>      g_free(p->compress_data);
>      p->compress_data = NULL;
> +
> +    g_free(p->iov);
> +    p->iov = NULL;
>  }
>  
>  /**
> diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
> index 256858df0a..ca17b7e310 100644
> --- a/migration/multifd-zstd.c
> +++ b/migration/multifd-zstd.c
> @@ -52,7 +52,6 @@ static int zstd_send_setup(MultiFDSendParams *p, Error **errp)
>      struct zstd_data *z = g_new0(struct zstd_data, 1);
>      int res;
>  
> -    p->compress_data = z;
>      z->zcs = ZSTD_createCStream();
>      if (!z->zcs) {
>          g_free(z);
> @@ -77,6 +76,10 @@ static int zstd_send_setup(MultiFDSendParams *p, Error **errp)
>          error_setg(errp, "multifd %u: out of memory for zbuff", p->id);
>          return -1;
>      }
> +    p->compress_data = z;
> +
> +    /* Needs 2 IOVs, one for packet header and one for compressed data */
> +    p->iov = g_new0(struct iovec, 2);
>      return 0;
>  }
>  
> @@ -98,6 +101,9 @@ static void zstd_send_cleanup(MultiFDSendParams *p, Error **errp)
>      z->zbuff = NULL;
>      g_free(p->compress_data);
>      p->compress_data = NULL;
> +
> +    g_free(p->iov);
> +    p->iov = NULL;
>  }
>  
>  /**
> diff --git a/migration/multifd.c b/migration/multifd.c
> index f317bff077..d82885fdbb 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -137,6 +137,13 @@ static int nocomp_send_setup(MultiFDSendParams *p, Error **errp)
>          p->write_flags |= QIO_CHANNEL_WRITE_FLAG_ZERO_COPY;
>      }
>  
> +    if (multifd_use_packets()) {
> +        /* We need one extra place for the packet header */
> +        p->iov = g_new0(struct iovec, p->page_count + 1);
> +    } else {
> +        p->iov = g_new0(struct iovec, p->page_count);
> +    }
> +
>      return 0;
>  }
>  
> @@ -150,6 +157,8 @@ static int nocomp_send_setup(MultiFDSendParams *p, Error **errp)
>   */
>  static void nocomp_send_cleanup(MultiFDSendParams *p, Error **errp)
>  {
> +    g_free(p->iov);
> +    p->iov = NULL;
>      return;
>  }
>  
> @@ -228,6 +237,7 @@ static int nocomp_send_prepare(MultiFDSendParams *p, Error **errp)
>   */
>  static int nocomp_recv_setup(MultiFDRecvParams *p, Error **errp)
>  {
> +    p->iov = g_new0(struct iovec, p->page_count);
>      return 0;
>  }
>  
> @@ -240,6 +250,8 @@ static int nocomp_recv_setup(MultiFDRecvParams *p, Error **errp)
>   */
>  static void nocomp_recv_cleanup(MultiFDRecvParams *p)
>  {
> +    g_free(p->iov);
> +    p->iov = NULL;
>  }

Are recv_setup()/recv_cleanup() for zstd/zlib missing?

If the iov will be managed by the compressors, I'm wondering whether we
should start assert(p->iov) after send|recv_setup(), and assert(!p->iov)
after send|recv_cleanup().  That'll guard all these.

>  
>  /**
> @@ -783,8 +795,6 @@ static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
>      p->packet_len = 0;
>      g_free(p->packet);
>      p->packet = NULL;
> -    g_free(p->iov);
> -    p->iov = NULL;
>      multifd_send_state->ops->send_cleanup(p, errp);
>  
>      return *errp == NULL;
> @@ -1179,11 +1189,6 @@ bool multifd_send_setup(void)
>              p->packet = g_malloc0(p->packet_len);
>              p->packet->magic = cpu_to_be32(MULTIFD_MAGIC);
>              p->packet->version = cpu_to_be32(MULTIFD_VERSION);
> -
> -            /* We need one extra place for the packet header */
> -            p->iov = g_new0(struct iovec, page_count + 1);
> -        } else {
> -            p->iov = g_new0(struct iovec, page_count);
>          }
>          p->name = g_strdup_printf("multifdsend_%d", i);
>          p->page_size = qemu_target_page_size();
> @@ -1353,8 +1358,6 @@ static void multifd_recv_cleanup_channel(MultiFDRecvParams *p)
>      p->packet_len = 0;
>      g_free(p->packet);
>      p->packet = NULL;
> -    g_free(p->iov);
> -    p->iov = NULL;
>      g_free(p->normal);
>      p->normal = NULL;
>      g_free(p->zero);
> @@ -1602,7 +1605,6 @@ int multifd_recv_setup(Error **errp)
>              p->packet = g_malloc0(p->packet_len);
>          }
>          p->name = g_strdup_printf("multifdrecv_%d", i);
> -        p->iov = g_new0(struct iovec, page_count);
>          p->normal = g_new0(ram_addr_t, page_count);
>          p->zero = g_new0(ram_addr_t, page_count);
>          p->page_count = page_count;
> -- 
> 2.39.3
> 

-- 
Peter Xu


