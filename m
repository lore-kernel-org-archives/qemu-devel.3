Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A60CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 20:36:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6asN-0003zn-LF; Wed, 08 Oct 2025 16:35:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v6asI-0003zK-Jj
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 16:35:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v6as9-0002ij-8y
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 16:35:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759955687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RCFdrE0cFPLzs8ubnn+ZbBb5slz2oMxWGSZUeImve9E=;
 b=FIS1jj9ToOSeV4q9Kn4lzjbfpZhzg8mnvURnvMsGCLNxSsfr2qvXTl1xWCLFLK2DyJ0nT1
 sAMtGlTRADUqUKtv6FRJxRHtIoUKuY2RgnVBxOpDROIQ5A77BXnUWUSp9lacmfF6IRtcli
 WUTyVViFMl5enxUl4POYP3fIGhSVtmw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253--k5TVAMlMFKy87FYnwLLWg-1; Wed, 08 Oct 2025 16:34:46 -0400
X-MC-Unique: -k5TVAMlMFKy87FYnwLLWg-1
X-Mimecast-MFC-AGG-ID: -k5TVAMlMFKy87FYnwLLWg_1759955685
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-857003e911fso74882885a.3
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 13:34:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759955685; x=1760560485;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RCFdrE0cFPLzs8ubnn+ZbBb5slz2oMxWGSZUeImve9E=;
 b=C2PDZyo25rruaD8dmaQ3MDEjz/eJW0qqqp2pWeGZHNwUBfEqyrQ4/Fb7wue2GYWntt
 pdB/BY/cyzPmSwwfNk2M70LrC+iA1Hi1UwtWK2GXP6t/3CuCt0dGbP6AzDqlludTHVnW
 RC4krip/LWAFUMtzC1Kv8HEvnjcpcWiVemIQ06vBaQjXD2zq/AxEX5pfp5plPPYpF1od
 766QmrvWn2OflvMDfbtJH3M6APcxHRnceovGwJ8AbssqH54Ic1ZZb9VKc80z65v4QxJ+
 z9sR+m9ptg+I3QeyRwPXgoHxAnqQWLaTxYC2UEmLKCj50qzF2R+WOZAARmQGvOZb34+8
 0KWw==
X-Gm-Message-State: AOJu0YzhQFS5OcSPVBlqWrp6xWJiuKISmRku+w5wD/9ezSEy75Wq80hX
 FsozuQXte/CaTF+MZWMKcIO7GIV6m4SA369W3WdBCA1hgMgTwsDirW+SFy+/Oebd9s7oNKbHBEm
 n5Bys9N6ZH3V0R6vBl+HUL5YNoI5qEb2ri+6UPMHmj6XNl29U2pepIDJg
X-Gm-Gg: ASbGnctIyBSeIDG2NyK4AXULWrxRyoY+xIP8Dz4PODZllrQ/dma/OcQJ0qJncjv27AZ
 hkvTJQMMWTpmiKZzQnTSCB260ITNo79tCXAbjSaWNhaUWtaR5vgtebUMBWuwcm1xyFuf7NdX47/
 Zek2kmhLWMI2+7ng6kbPnat+D2J7J+mg+d3n+uCg6B9lCk5IB8GJVWq7OlkKFV1yv062LqxFLeW
 S91D9WhcFIVokfM0XddqZBeBgn3Pi5tMxTDrrgOrMQQrVQmLDmYbNcAh1gwZ0sfNhwOfggZjQKs
 2fjvRhkN3LlvIovRjU0aoQwK8u/ObudXGkypnw==
X-Received: by 2002:a05:620a:191c:b0:84f:4ae6:6128 with SMTP id
 af79cd13be357-883521db925mr733517085a.42.1759955684966; 
 Wed, 08 Oct 2025 13:34:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGABL4P3HpbQweVlyIrmFhI8ca71eHjb3vIf4cPJ5ZwmoTYpMcMHH5QmOFK+mVanPUUk7f4lw==
X-Received: by 2002:a05:620a:191c:b0:84f:4ae6:6128 with SMTP id
 af79cd13be357-883521db925mr733512085a.42.1759955684379; 
 Wed, 08 Oct 2025 13:34:44 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bdf52e64sm168187406d6.52.2025.10.08.13.34.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 13:34:43 -0700 (PDT)
Date: Wed, 8 Oct 2025 16:34:41 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dave@treblig.org>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Prasad Pandit <ppandit@redhat.com>, Zhang Chen <zhangckid@gmail.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH RFC 4/9] migration/rdma: Change io_create_watch() to
 return immediately
Message-ID: <aObK4dCldBXcGq2W@x1.local>
References: <20250827205949.364606-1-peterx@redhat.com>
 <20250827205949.364606-5-peterx@redhat.com>
 <87ms6uvxdq.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ms6uvxdq.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Sep 16, 2025 at 07:35:45PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > The old RDMA's io_create_watch() isn't really doing much work anyway.  For
> > G_IO_OUT, it already does return immediately.  For G_IO_IN, it will try to
> > detect some RDMA context length however normally nobody will be able to set
> > it at all.
> >
> > Simplify the code so that RDMA iochannels simply always rely on synchronous
> > reads and writes.  It is highly likely what 6ddd2d76ca6f86f was talking
> > about, that the async model isn't really working well.
> >
> > This helps because this is almost the only dependency that the migration
> > core would need a coroutine for rdma channels.
> >
> 
> I don't understand this. How does this code require a coroutine? Isn't
> the io_watch exactly the strategy used when there is no coroutine?

Good question.  I can't remember what I was picturing when writting it.

Here the rational should be, RDMA works slightly differently from other
iochannels, because its async model doesn't really work
asynchronously.. instead no matter whether the channel is in sync/async
mode, it always only work in a sync manner.

Here, when I was saying async I meant we currently set NONBLOCK always for
incoming main channel.

For non-RDMA channels, what happens with current master branch is when we
have nothing to read, we yield at qemu_fill_buffer().

For RDMA channels, what I see is it always polls on its own and it yields
at qemu_rdma_wait_comp_channel(). A sample stack:

#0  qemu_coroutine_yield
#1  0x0000562e46e51f77 in yield_until_fd_readable
#2  0x0000562e46927823 in qemu_rdma_wait_comp_channel
#3  0x0000562e46927b35 in qemu_rdma_block_for_wrid
#4  0x0000562e46927e6f in qemu_rdma_post_send_control
#5  0x0000562e4692857f in qemu_rdma_exchange_recv
#6  0x0000562e4692ab5e in qio_channel_rdma_readv
#7  0x0000562e46c1f2d7 in qio_channel_readv_full
#8  0x0000562e46c13a6e in qemu_fill_buffer
#9  0x0000562e46c14ba8 in qemu_peek_byte
#10 0x0000562e46c14c09 in qemu_get_byte
#11 0x0000562e46c14e2a in qemu_get_be32
#12 0x0000562e46c14e8a in qemu_get_be64
#13 0x0000562e46913f08 in ram_load_precopy
#14 0x0000562e46914448 in ram_load
#15 0x0000562e469186e3 in vmstate_load
#16 0x0000562e4691ce6d in qemu_loadvm_section_part_end
#17 0x0000562e4691d99b in qemu_loadvm_state_main
#18 0x0000562e4691db87 in qemu_loadvm_state
#19 0x0000562e468f2e87 in process_incoming_migration_co

AFAICT, this is the only channel that does explicit yields internally,
rather than relying on iochannel/qemufile framework, aka, qemu_fill_buffer().

IOW, I don't even know when RDMA's qemu_fill_buffer() internally will get a
retval of QIO_CHANNEL_ERR_BLOCK for its qio_channel_readv_full(), because
rdma's io_readv() ignors NONBLOCK always.. AFAIU.

Now, going back to this patch: since I never hit QIO_CHANNEL_ERR_BLOCK
before, I don't think I know when I'll need this patch, but I had this
patch to make sure after we switch to the thread model, we will never go
into qio_channel_wait(), because IIUC fundamentally it's broken.  After
this patch applied, it'll reliably retry immediately.  Again, I don't know
when it'll become useful, but I'm trying to make sure we stick with the
solo place (qemu_rdma_wait_comp_channel) for polling things.

So I plan to remove this sentence, which looks misleading.  Meanwhile I can
add some of above into it.

> 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/rdma.c | 69 +++---------------------------------------------
> >  1 file changed, 3 insertions(+), 66 deletions(-)
> >
> > diff --git a/migration/rdma.c b/migration/rdma.c
> > index ed4e20b988..bcd7aae2f2 100644
> > --- a/migration/rdma.c
> > +++ b/migration/rdma.c
> > @@ -2789,56 +2789,14 @@ static gboolean
> >  qio_channel_rdma_source_prepare(GSource *source,
> >                                  gint *timeout)
> >  {
> > -    QIOChannelRDMASource *rsource = (QIOChannelRDMASource *)source;
> > -    RDMAContext *rdma;
> > -    GIOCondition cond = 0;
> >      *timeout = -1;
> > -
> > -    RCU_READ_LOCK_GUARD();
> > -    if (rsource->condition == G_IO_IN) {
> > -        rdma = qatomic_rcu_read(&rsource->rioc->rdmain);
> > -    } else {
> > -        rdma = qatomic_rcu_read(&rsource->rioc->rdmaout);
> > -    }
> > -
> > -    if (!rdma) {
> > -        error_report("RDMAContext is NULL when prepare Gsource");
> > -        return FALSE;
> > -    }
> > -
> > -    if (rdma->wr_data[0].control_len) {
> > -        cond |= G_IO_IN;
> > -    }
> > -    cond |= G_IO_OUT;
> > -
> > -    return cond & rsource->condition;
> > +    return TRUE;
> >  }
> >  
> >  static gboolean
> >  qio_channel_rdma_source_check(GSource *source)
> >  {
> > -    QIOChannelRDMASource *rsource = (QIOChannelRDMASource *)source;
> > -    RDMAContext *rdma;
> > -    GIOCondition cond = 0;
> > -
> > -    RCU_READ_LOCK_GUARD();
> > -    if (rsource->condition == G_IO_IN) {
> > -        rdma = qatomic_rcu_read(&rsource->rioc->rdmain);
> > -    } else {
> > -        rdma = qatomic_rcu_read(&rsource->rioc->rdmaout);
> > -    }
> > -
> > -    if (!rdma) {
> > -        error_report("RDMAContext is NULL when check Gsource");
> > -        return FALSE;
> > -    }
> > -
> > -    if (rdma->wr_data[0].control_len) {
> > -        cond |= G_IO_IN;
> > -    }
> > -    cond |= G_IO_OUT;
> > -
> > -    return cond & rsource->condition;
> > +    return TRUE;
> 
> These are fine if we want the source to run as soon as possible, I
> think. But then...
> 
> >  }
> >  
> >  static gboolean
> > @@ -2848,29 +2806,8 @@ qio_channel_rdma_source_dispatch(GSource *source,
> >  {
> >      QIOChannelFunc func = (QIOChannelFunc)callback;
> >      QIOChannelRDMASource *rsource = (QIOChannelRDMASource *)source;
> > -    RDMAContext *rdma;
> > -    GIOCondition cond = 0;
> > -
> > -    RCU_READ_LOCK_GUARD();
> > -    if (rsource->condition == G_IO_IN) {
> > -        rdma = qatomic_rcu_read(&rsource->rioc->rdmain);
> > -    } else {
> > -        rdma = qatomic_rcu_read(&rsource->rioc->rdmaout);
> > -    }
> > -
> > -    if (!rdma) {
> > -        error_report("RDMAContext is NULL when dispatch Gsource");
> > -        return FALSE;
> > -    }
> > -
> > -    if (rdma->wr_data[0].control_len) {
> > -        cond |= G_IO_IN;
> > -    }
> > -    cond |= G_IO_OUT;
> >  
> > -    return (*func)(QIO_CHANNEL(rsource->rioc),
> > -                   (cond & rsource->condition),
> > -                   user_data);
> > +    return (*func)(QIO_CHANNEL(rsource->rioc), rsource->condition, user_data);
> 
> No idea who even calls g_source_set_callback() in this case. What is func?

In terms of qio_channel_wait(), func is qio_channel_wait_complete().

After this patch, qio_channel_wait_complete() will be invoked immediately,
hence qio_channel_wait() will reliably return immediately for rdma channels.

-- 
Peter Xu


