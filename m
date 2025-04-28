Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7718FC36005
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 10:32:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9Ll3-0006ig-8k; Mon, 28 Apr 2025 06:30:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1u9Ljv-0004DN-IA
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 06:29:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1u9Ljt-0003dD-0A
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 06:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745836166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iT9nqTQhwiTs/XfpG8t9+pzbZhZ0wqmcylIeL5XyJwo=;
 b=YfdIsgBGh6OITPCLI7d4ClfYqoAJR8BFLOp1yuVSkgL5CeQJwvmmr8eYDhmaf2sbYuQh3Y
 9CnSAR35vWXEVwClWfWKl/1ulEI4J9lCSOIVKvGf4WRHPIb3BDkIiC0cM2jXuXHhODj3KL
 du2Zwd5tmuU/L3ugJlnKPzggdIvOc6U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-cuhhO8nkP2m-W_I-D1P8Ig-1; Mon, 28 Apr 2025 06:29:24 -0400
X-MC-Unique: cuhhO8nkP2m-W_I-D1P8Ig-1
X-Mimecast-MFC-AGG-ID: cuhhO8nkP2m-W_I-D1P8Ig_1745836163
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43d5ca7c86aso26948755e9.0
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 03:29:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745836163; x=1746440963;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iT9nqTQhwiTs/XfpG8t9+pzbZhZ0wqmcylIeL5XyJwo=;
 b=XumSxph8G8h5t9NogZ10Y9ztH+Vxa1xPTabiD/9SzCWCAlRYrjVsywR3qrTayTNw1u
 YVyXjEiYPizSgO53X847nETIZNnuQ7F9NKyWRHUXAw8bJ8dbkkfnfBAYbb37SduTIQNz
 WtM0x0Ller/i98mR7NgR2izZajy8eIDMWQaFx4oyahD+Yr0kpb7s8h+MPcGD0j+m6cFN
 iiY+mKliXwPpGcDuFFAUtvckYbq4VDrMDdFooix9HGJcf4sMseB44BSWLn1s0mjQv+dw
 Ii7GEmTU1HuNKRKFa27S6HISGzboTwekiaL2cCnoKH/8AG5bubNxiEkAULFf+Oykfcs7
 ji0Q==
X-Gm-Message-State: AOJu0YzboibtLGgOChDSzq87+OWXH11tpaLFqaWLU53XtAbuJ2ppsJ/M
 JNeDIhDgVARixYP0tUAcwYwFKifPRVc8J6gm5r81JqW5mYVr9Z2J3UnLM34Md2oQ4pYHofoo12C
 Qv7u07t/QFvVN1ruzrzAoFivh3+p2dNOJSt6dVFYEGjC0Nf7aIloy
X-Gm-Gg: ASbGncvkSvv8TC8j35oPUUk4Z1IFt6q9sfYiwKm9iarBhoyeb0E+Eu3Tk/+PFRayQoG
 U4qUmc6K+n1Xmy/fBs5LLdP5AplfuoGxLzaL213Fxl5bJJhnevmBJmC48mVI//PxzUOBr5Z0IjJ
 RQPDVNjQ1w0f3Yy+D05qy68XCgNm1X3+Lf+ihODmTN6DNCU6ZMlTa8dnuxqCD4DUghCJwn2Pgqd
 R2HyXYNoV6PtcNKZpqpSjRBlMAkcWcprAnfbl0GMYybx82L768dwilLYSvWawquRDaaKf7nkUzb
X-Received: by 2002:a05:600c:4e16:b0:43b:ca39:6c75 with SMTP id
 5b1f17b1804b1-440a660a95dmr113161435e9.16.1745836162742; 
 Mon, 28 Apr 2025 03:29:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1eH1kd/pxn8wDNb2NfTDGeA24XGKMHGyCW5xwoMWIGrk5Kax6VA71CqZJwLzt3uNXkIQ+qQ==
X-Received: by 2002:a05:600c:4e16:b0:43b:ca39:6c75 with SMTP id
 5b1f17b1804b1-440a660a95dmr113161235e9.16.1745836162361; 
 Mon, 28 Apr 2025 03:29:22 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073c8d769sm10880370f8f.12.2025.04.28.03.29.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 03:29:21 -0700 (PDT)
Date: Mon, 28 Apr 2025 12:29:20 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Prasad Pandit <ppandit@redhat.com>, 
 Xiaohui Li <xiaohli@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration/postcopy: Spatial locality page hint for
 preempt mode
Message-ID: <ozfomusssu3gcy75kfagortacpazz3a2cicmoxkyltw4xeds54@2a4lsuw7hka7>
References: <20250424220705.195544-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424220705.195544-1-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.492,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URG_BIZ=0.573 autolearn=ham autolearn_force=no
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

Hi Peter

On 2025-04-24 18:07, Peter Xu wrote:
> The preempt mode postcopy has been introduced for a while.  From latency
> POV, it should always win the vanilla postcopy.
> 
> However there's one thing missing when preempt mode is enabled right now,
> which is the spatial locality hint when there're page requests from the
> destination side.
> 
> In vanilla postcopy, as long as a page request was unqueued, it will update
> the PSS of the precopy background stream, so that after a page request the
> background thread will move the pages after whatever was requested.  It's
> pretty much a natural behavior when there's only one channel anyway, and
> one scanner to send the pages.
> 
> Preempt mode didn't follow that, because preempt mode has its own channel
> and its own PSS (which doesn't linearly scan the guest memory, but
> dedicated to resolve page requested from destination).  So the page request
> process and the background migration process are completely separate.
> 
> This patch adds the hint explicitly for preempt mode.  With that, whenever
> the preempt mode receives a page request on the source, it will service the
> remote page fault in the return path, then it'll provide a hint to the
> background thread so that we'll start sending the pages right after the
> requested ones in the background, assuming the follow up pages have a
> higher chance to be accessed later.
> 
> NOTE: since the background migration thread and return path thread run
> completely concurrently, it doesn't always mean the hint will be applied
> every single time.  For example, it's possible that the return path thread
> receives multiple page requests in a row without the background thread
> getting the chance to consume one.  In such case, the preempt thread only
> provide the hint if the previous hint has been consumed.  After all,
> there's no point queuing hints when we only have one linear scanner.
> 
> This could measureably improve the simple sequential memory access pattern
> during postcopy (when preempt is on).  For random accesses, I can measure a
> slight increase of remote page fault latency from ~500us -> ~600us, that
> could be a trade-off to have such hint mechanism, and after all that's
> still greatly improved comparing to vanilla postcopy on random (~10ms).
> 
> The patch is verified by our QE team in a video streaming test case, to
> reduce the pause of the video from ~1min to a few seconds when switching
> over to postcopy with preempt mode.
> 
> Tested-by: Xiaohui Li <xiaohli@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/ram.c | 97 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 96 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 424df6d9f1..21d2f87ff1 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -91,6 +91,36 @@
>  
>  XBZRLECacheStats xbzrle_counters;
>  
> +/*
> + * This structure locates a specific location of a guest page.  In QEMU,
> + * it's described in a tuple of (ramblock, offset).
> + */
> +struct PageLocation {
> +    RAMBlock *block;
> +    unsigned long offset;
> +};
> +typedef struct PageLocation PageLocation;
> +
> +/**
> + * PageLocationHint: describes a hint to a page location
> + *
> + * @valid     set if the hint is vaild and to be consumed
> + * @location: the hint content
> + *
> + * In postcopy preempt mode, the urgent channel may provide hints to the
> + * background channel, so that QEMU source can try to migrate whatever is
> + * right after the requested urgent pages.
> + *
> + * This is based on the assumption that the VM (already running on the
> + * destination side) tends to access the memory with spatial locality.
> + * This is also the default behavior of vanilla postcopy (preempt off).
> + */
> +struct PageLocationHint {
> +    bool valid;
> +    PageLocation location;
> +};
> +typedef struct PageLocationHint PageLocationHint;
> +
>  /* used by the search for pages to send */
>  struct PageSearchStatus {
>      /* The migration channel used for a specific host page */
> @@ -395,6 +425,13 @@ struct RAMState {
>       * RAM migration.
>       */
>      unsigned int postcopy_bmap_sync_requested;
> +    /*
> +     * Page hint during postcopy when preempt mode is on.  Return path
> +     * thread sets it, while background migration thread consumes it.
> +     *
> +     * Protected by @bitmap_mutex.
> +     */
> +    PageLocationHint page_hint;
>  };
>  typedef struct RAMState RAMState;
>  
> @@ -2039,6 +2076,21 @@ static void pss_host_page_finish(PageSearchStatus *pss)
>      pss->host_page_start = pss->host_page_end = 0;
>  }
>  
> +static void ram_page_hint_update(RAMState *rs, PageSearchStatus *pss)
> +{
> +    PageLocationHint *hint = &rs->page_hint;
> +
> +    /* If there's a pending hint not consumed, don't bother */
> +    if (hint->valid) {
> +        return;
> +    }
> +
> +    /* Provide a hint to the background stream otherwise */
> +    hint->location.block = pss->block;
> +    hint->location.offset = pss->page;
> +    hint->valid = true;
> +}
> +
>  /*
>   * Send an urgent host page specified by `pss'.  Need to be called with
>   * bitmap_mutex held.
> @@ -2084,6 +2136,7 @@ out:
>      /* For urgent requests, flush immediately if sent */
>      if (sent) {
>          qemu_fflush(pss->pss_channel);
> +        ram_page_hint_update(rs, pss);
>      }
>      return ret;
>  }
> @@ -2171,6 +2224,30 @@ static int ram_save_host_page(RAMState *rs, PageSearchStatus *pss)
>      return (res < 0 ? res : pages);
>  }
>  
> +static bool ram_page_hint_valid(RAMState *rs)
> +{
> +    /* There's only page hint during postcopy preempt mode */
> +    if (!postcopy_preempt_active()) {
> +        return false;
> +    }
> +
> +    return rs->page_hint.valid;
> +}
> +
> +static void ram_page_hint_collect(RAMState *rs, RAMBlock **block,
> +                                  unsigned long *page)
> +{
> +    PageLocationHint *hint = &rs->page_hint;
> +
> +    assert(hint->valid);
> +
> +    *block = hint->location.block;
> +    *page = hint->location.offset;
> +
> +    /* Mark the hint consumed */
> +    hint->valid = false;
> +}
> +
>  /**
>   * ram_find_and_save_block: finds a dirty page and sends it to f
>   *
> @@ -2187,6 +2264,8 @@ static int ram_save_host_page(RAMState *rs, PageSearchStatus *pss)
>  static int ram_find_and_save_block(RAMState *rs)
>  {
>      PageSearchStatus *pss = &rs->pss[RAM_CHANNEL_PRECOPY];
> +    unsigned long next_page;
> +    RAMBlock *next_block;
>      int pages = 0;
>  
>      /* No dirty page as there is zero RAM */
> @@ -2206,7 +2285,14 @@ static int ram_find_and_save_block(RAMState *rs)
>          rs->last_page = 0;
>      }
>  
> -    pss_init(pss, rs->last_seen_block, rs->last_page);
> +    if (ram_page_hint_valid(rs)) {
> +        ram_page_hint_collect(rs, &next_block, &next_page);
> +    } else {
> +        next_block = rs->last_seen_block;
> +        next_page = rs->last_page;
> +    }
> +
> +    pss_init(pss, next_block, next_page);
>  
>      while (true){
>          if (!get_queued_page(rs, pss)) {
> @@ -2339,6 +2425,13 @@ static void ram_save_cleanup(void *opaque)
>      ram_state_cleanup(rsp);
>  }
>  
> +static void ram_page_hint_reset(PageLocationHint *hint)
> +{
> +    hint->location.block = NULL;
> +    hint->location.offset = 0;
> +    hint->valid = false;
> +}
> +
>  static void ram_state_reset(RAMState *rs)
>  {
>      int i;
> @@ -2351,6 +2444,8 @@ static void ram_state_reset(RAMState *rs)
>      rs->last_page = 0;
>      rs->last_version = ram_list.version;
>      rs->xbzrle_started = false;
> +
> +    ram_page_hint_reset(&rs->page_hint);
>  }
>  
>  #define MAX_WAIT 50 /* ms, half buffered_file limit */
> -- 
> 2.48.1
> 

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>


