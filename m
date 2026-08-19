Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE00C5DF6D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 12:48:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwfiI-0006MP-8I; Wed, 19 Aug 2026 08:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwfiC-0006J4-8J
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 08:48:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwfi9-0006rf-Q0
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 08:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787143684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QRoxYzRxqCMQQHt3Ahk5ajkosk/UJ6bR4GTZBB8PYxY=;
 b=ABPeW33fnSezHgEEylOa9LU45IqgTpqc+V9urmOA68SeljoP7ORgqXOqqLiCFKt3lH7AWp
 YkVyV14+vnXO5aNP4i7OnYmx7NbOKWRXKo7hQjSvADbor13n41+ZmojCWm6PKg2Q3/e88l
 eQxQcjl3LLkmbxG08v+fcpWkck9jf7o=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-_YvlvyJHO6GiC7QOR2kqfQ-1; Wed, 19 Aug 2026 08:48:02 -0400
X-MC-Unique: _YvlvyJHO6GiC7QOR2kqfQ-1
X-Mimecast-MFC-AGG-ID: _YvlvyJHO6GiC7QOR2kqfQ_1787143682
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-934979ee9f1so123305785a.2
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 05:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787143682; x=1787748482; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QRoxYzRxqCMQQHt3Ahk5ajkosk/UJ6bR4GTZBB8PYxY=;
 b=dDz/qjHQqdWukoNa28bTwnxEq0ry64JbL0csbX4WPbijfLp2YlV6t3uvcynwa/APA2
 dkl2TiiT3/a+8APCoj9O4hV9/+QfYzno06dNxjezMrZCtuv19KHUG8Dz43dyTGyrwUYj
 EM5QyADcgGpUvqkmEasv5M0kpfqn2Rk61yeHcEjXSIVmkHXdWwBtkf25TqRktUgYcm7+
 VRQWCgPfaEGFjrkahlQy8gqWys46+XE6Ki0xdNuYqkfuh5Bvr6hM9k+XgONPngPU+pe6
 m/xpbEj4AYzJdPED5deXeCNoyiOs37/D5LhAhc8upLJohYNl8ccHPfDPXzrEPmqjnMGR
 /T/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787143682; x=1787748482;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QRoxYzRxqCMQQHt3Ahk5ajkosk/UJ6bR4GTZBB8PYxY=;
 b=YorLhlB6s5oaoqmn9uyNK2bJ7zdNx4mQNmtorOCitqemRAEcEVegk4QJt4fawHFEXv
 xAmZpF+sygXhsWewuJbtTYD5PTEshi3Ba3PcSsppw9ymDf9lmLY0QMue2GCSHYPh0syc
 XzZ/zj0oU5ztQwp3qT1Yk0rNLbE2a8vwPyderQZw/LWHd4eTDtpSQ8wksYCoXQc4OuAV
 2kq3P+U89lmHMnD7vJtFolqaWFANJvnPhn9NTpV+DeR/4ExwcUwSUhhvwkkCF53U81VU
 k8ZzHFHPqxgjZkZTnG4GG0oXgQw7e1otEED9k6FF1J7iJjCA27YqjwM7i6tpsSOH9tTs
 J4KQ==
X-Gm-Message-State: AOJu0YzIG0MpNw8hBItCv5+S2Bn1nPrcM6gxurS4tnG0Dp4BFgqN7qUI
 5GlrGu9sTxrqdF5mdIHnZS84RN6daWonYZ6rU93Li2G7XFEYMpFMvodcKd40MpZ4tBp40lV6XGm
 s1ela/vvrQ6U9fnnMtjlzlaWQ8mhGcR3nyJgdgtAEFLYeHM8a3IIxhEeXNOpMMekj
X-Gm-Gg: AR+sD12/3DzSKIQmBgzFxuYpWuRl8PRJrs2v65Qc5zubcqXKG0vkxo/khUCI299OvCR
 sR5b3Wcc1BOmcAElfpPbHbSfTsZ4svP4chyXt5rmXQFwGjQtQeL4VOjVGEp+7cuz02WYQ7pDf/2
 IK/hziZqVeR0HnUWXtkcP2sRHaPz6Ys+7uUaoKQ9epcUwyyrgqKDf5uShf4SymdqZAlpTkQCXkL
 lHZnPmJCQimDLoUWWG4QYBJJKPewD87RnZGFN9ICqu9gKyA1J+IMpb8YLYcX55TV9958Sr1l/NL
 SW8DpY9KITt8WPD8pc+nDfc3I2ypK/JwaAbKt86PcBZIazehq3meV/Dg3Nh9bPjSbj3u
X-Received: by 2002:a05:620a:bc6:b0:92e:6533:26eb with SMTP id
 af79cd13be357-9371e2cfc78mr388158385a.6.1787143682016; 
 Wed, 19 Aug 2026 05:48:02 -0700 (PDT)
X-Received: by 2002:a05:620a:bc6:b0:92e:6533:26eb with SMTP id
 af79cd13be357-9371e2cfc78mr388151685a.6.1787143681322; 
 Wed, 19 Aug 2026 05:48:01 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-937204afbadsm128902585a.17.2026.08.19.05.48.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 05:48:00 -0700 (PDT)
Date: Wed, 19 Aug 2026 08:47:49 -0400
From: Peter Xu <peterx@redhat.com>
To: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@fujitsu.com>,
 Samuel Zhang <guoqing.zhang@amd.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 Yanfei Xu <yanfei.xu@bytedance.com>
Subject: Re: [PATCH 02/10] migration/rdma: Remove unregister code
Message-ID: <aoWl9fhT71wXjvtb@x1.local>
References: <20260817202424.2901438-1-peterx@redhat.com>
 <20260817202424.2901438-3-peterx@redhat.com>
 <CAMGffEkDar1xw3easr03h0fB0O-Au5VdoJnfyrjiEVgkWmkT3g@mail.gmail.com>
 <CAMGffEmbQ3jzC2L=Wp72vh6rM6pW602u5iFmzqdVbDsTh-H6xA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMGffEmbQ3jzC2L=Wp72vh6rM6pW602u5iFmzqdVbDsTh-H6xA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Aug 19, 2026 at 02:01:49PM +0200, Jinpu Wang wrote:
> On Wed, Aug 19, 2026 at 12:52 PM Jinpu Wang <jinpu.wang@cloud.ionos.com> wrote:
> >
> > On Mon, Aug 17, 2026 at 10:24 PM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > The unregister code was there since the first commit RDMA migration was
> > > merged, but it was never functioning.  Remove the dead code.
> > >
> > > Since the two control messages are the last ones, we don't even need to
> > > worry about compatibility of legacy RDMA control commands, we can directly
> > > remove the messages too.
> > >
> > > As a side effect, this patch closes a report by removing the code
> > > completely.
> > >
> > > Reported-by: Tristan (@TristanInSec)
> > > Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4003
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > Hi Peter, hi Yanfei,

Hi, Jinpu,

> >
> > The change looks fine, and I have also tested to ensure it doesn't
> > break compatibility with older versions. As already discussed,
> > removing this code could result in more MRs being used during
> > migration; however, once the migration is complete, they will be
> > unregistered, so there is no leak.

Could you help explain why removing this code could result in more MRs
being used?  I didn't see these two control messages used, so I expect the
behavior should be exactly the same before/after this patch, with either a
new or old QEMU binary.

> >
> > Reviewed-by: Jinpu Wang <jinpu.wang@cloud.ionos.com>
> > > ---
> > >  migration/rdma.c       | 133 -----------------------------------------
> > >  migration/trace-events |   7 ---
> > >  2 files changed, 140 deletions(-)
> > >
> > > diff --git a/migration/rdma.c b/migration/rdma.c
> > > index 62a509b236..eae4afd6df 100644
> > > --- a/migration/rdma.c
> > > +++ b/migration/rdma.c
> > > @@ -142,8 +142,6 @@ enum {
> > >      RDMA_CONTROL_REGISTER_REQUEST,    /* dynamic page registration */
> > >      RDMA_CONTROL_REGISTER_RESULT,     /* key to use after registration */
> > >      RDMA_CONTROL_REGISTER_FINISHED,   /* current iteration finished */
> > > -    RDMA_CONTROL_UNREGISTER_REQUEST,  /* dynamic UN-registration */
> > > -    RDMA_CONTROL_UNREGISTER_FINISHED, /* unpinning finished */
> > >      RDMA_CONTROL_NUM,
> > >  };
> > >
> > > @@ -232,8 +230,6 @@ static const char *control_desc(unsigned int rdma_control)
> > >          [RDMA_CONTROL_REGISTER_REQUEST] = "REGISTER REQUEST",
> > >          [RDMA_CONTROL_REGISTER_RESULT] = "REGISTER RESULT",
> > >          [RDMA_CONTROL_REGISTER_FINISHED] = "REGISTER FINISHED",
> > > -        [RDMA_CONTROL_UNREGISTER_REQUEST] = "UNREGISTER REQUEST",
> > > -        [RDMA_CONTROL_UNREGISTER_FINISHED] = "UNREGISTER FINISHED",
> > >      };
> > >
> > >      if (rdma_control >= RDMA_CONTROL_NUM) {
> > > @@ -370,9 +366,6 @@ typedef struct RDMAContext {
> > >      int total_registrations;
> > >      int total_writes;
> > >
> > > -    int unregister_current, unregister_next;
> > > -    uint64_t unregistrations[RDMA_SIGNALED_SEND_MAX];
> > > -
> > >      GHashTable *blockmap;
> > >
> > >      /* the RDMAContext for return path */
> > > @@ -1186,91 +1179,6 @@ static int qemu_rdma_reg_control(RDMAContext *rdma, int idx)
> > >      return -1;
> > >  }
> > >
> > > -/*
> > > - * Perform a non-optimized memory unregistration after every transfer
> > > - * for demonstration purposes, only if pin-all is not requested.
> > > - *
> > > - * Potential optimizations:
> > > - * 1. Start a new thread to run this function continuously
> > > -        - for bit clearing
> > > -        - and for receipt of unregister messages
> > > - * 2. Use an LRU.
> > > - * 3. Use workload hints.
> > > - */
> > > -static int qemu_rdma_unregister_waiting(RDMAContext *rdma)
> > > -{
> > > -    Error *err = NULL;
> > > -
> > > -    while (rdma->unregistrations[rdma->unregister_current]) {
> > > -        int ret;
> > > -        uint64_t wr_id = rdma->unregistrations[rdma->unregister_current];
> > > -        uint64_t chunk =
> > > -            (wr_id & RDMA_WRID_CHUNK_MASK) >> RDMA_WRID_CHUNK_SHIFT;
> > > -        uint64_t index =
> > > -            (wr_id & RDMA_WRID_BLOCK_MASK) >> RDMA_WRID_BLOCK_SHIFT;
> > > -        RDMALocalBlock *block =
> > > -            &(rdma->local_ram_blocks.block[index]);
> > > -        RDMARegister reg = { .current_index = index };
> > > -        RDMAControlHeader resp = { .type = RDMA_CONTROL_UNREGISTER_FINISHED,
> > > -                                 };
> > > -        RDMAControlHeader head = { .len = sizeof(RDMARegister),
> > > -                                   .type = RDMA_CONTROL_UNREGISTER_REQUEST,
> > > -                                   .repeat = 1,
> > > -                                 };
> > > -
> > > -        trace_qemu_rdma_unregister_waiting_proc(chunk,
> > > -                                                rdma->unregister_current);
> > > -
> > > -        rdma->unregistrations[rdma->unregister_current] = 0;
> > > -        rdma->unregister_current++;
> > > -
> > > -        if (rdma->unregister_current == RDMA_SIGNALED_SEND_MAX) {
> > > -            rdma->unregister_current = 0;
> > > -        }
> > > -
> > > -
> > > -        /*
> > > -         * Unregistration is speculative (because migration is single-threaded
> > > -         * and we cannot break the protocol's inifinband message ordering).
> > > -         * Thus, if the memory is currently being used for transmission,
> > > -         * then abort the attempt to unregister and try again
> > > -         * later the next time a completion is received for this memory.
> > > -         */
> > > -        clear_bit(chunk, block->unregister_bitmap);
> > > -
> > > -        if (test_bit(chunk, block->transit_bitmap)) {
> > > -            trace_qemu_rdma_unregister_waiting_inflight(chunk);
> > > -            continue;
> > > -        }
> > > -
> > > -        trace_qemu_rdma_unregister_waiting_send(chunk);
> > > -
> > > -        ret = ibv_dereg_mr(block->pmr[chunk]);
> > > -        block->pmr[chunk] = NULL;
> > > -        block->remote_keys[chunk] = 0;
> > > -
> > > -        if (ret != 0) {
> > > -            error_report("unregistration chunk failed: %s",
> > > -                         strerror(ret));
> > > -            return -1;
> > > -        }
> > > -        rdma->total_registrations--;
> > > -
> > > -        reg.key.chunk = chunk;
> > > -        register_to_network(rdma, &reg);
> > > -        ret = qemu_rdma_exchange_send(rdma, &head, (uint8_t *) &reg,
> > > -                                      &resp, NULL, NULL, &err);
> > > -        if (ret < 0) {
> > > -            error_report_err(err);
> > > -            return -1;
> > > -        }
> > > -
> > > -        trace_qemu_rdma_unregister_waiting_complete(chunk);
> > > -    }
> > > -
> > > -    return 0;
> > > -}
> > > -
> > >  static uint64_t qemu_rdma_make_wrid(uint64_t wr_id, uint64_t index,
> > >                                           uint64_t chunk)
> > >  {
> > > @@ -2757,8 +2665,6 @@ static int qemu_rdma_drain_cq(RDMAContext *rdma)
> > >          }
> > >      }
> > >
> > > -    qemu_rdma_unregister_waiting(rdma);
> > > -
> > >      return 0;
> > >  }
> > >
> > > @@ -3336,10 +3242,6 @@ int rdma_registration_handle(QEMUFile *f)
> > >                                 .type = RDMA_CONTROL_REGISTER_RESULT,
> > >                                 .repeat = 0,
> > >                               };
> > > -    RDMAControlHeader unreg_resp = { .len = 0,
> > > -                               .type = RDMA_CONTROL_UNREGISTER_FINISHED,
> > > -                               .repeat = 0,
> > > -                             };
> > >      RDMAControlHeader blocks = { .type = RDMA_CONTROL_RAM_BLOCKS_RESULT,
> > >                                   .repeat = 1 };
> > >      QIOChannelRDMA *rioc;
> > > @@ -3552,41 +3454,6 @@ int rdma_registration_handle(QEMUFile *f)
> > >              ret = qemu_rdma_post_send_control(rdma,
> > >                              (uint8_t *) results, &reg_resp, &err);
> > >
> > > -            if (ret < 0) {
> > > -                error_report_err(err);
> > > -                goto err;
> > > -            }
> > > -            break;
> > > -        case RDMA_CONTROL_UNREGISTER_REQUEST:
> > > -            trace_rdma_registration_handle_unregister(head.repeat);
> > > -            unreg_resp.repeat = head.repeat;
> > > -            registers = (RDMARegister *) rdma->wr_data[idx].control_curr;
> > > -
> > > -            for (int count = 0; count < head.repeat; count++) {
> > > -                reg = &registers[count];
> > > -                network_to_register(reg);
> > > -
> > > -                trace_rdma_registration_handle_unregister_loop(count,
> > > -                           reg->current_index, reg->key.chunk);
> > > -
> > > -                block = &(rdma->local_ram_blocks.block[reg->current_index]);
> > > -
> > > -                ret = ibv_dereg_mr(block->pmr[reg->key.chunk]);
> > > -                block->pmr[reg->key.chunk] = NULL;
> > > -
> > > -                if (ret != 0) {
> > > -                    error_report("rdma unregistration chunk failed: %s",
> > > -                                 strerror(errno));
> > > -                    goto err;
> > > -                }
> > > -
> > > -                rdma->total_registrations--;
> > > -
> > > -                trace_rdma_registration_handle_unregister_success(reg->key.chunk);
> > > -            }
> > > -
> > > -            ret = qemu_rdma_post_send_control(rdma, NULL, &unreg_resp, &err);
> > > -
> > >              if (ret < 0) {
> > >                  error_report_err(err);
> > >                  goto err;
> > > diff --git a/migration/trace-events b/migration/trace-events
> > > index af0e784535..d1fe8f1382 100644
> > > --- a/migration/trace-events
> > > +++ b/migration/trace-events
> > > @@ -244,10 +244,6 @@ qemu_rdma_advise_mr(const char *name, uint32_t len, uint64_t addr, const char *r
> > >  qemu_rdma_resolve_host_trying(const char *host, const char *ip) "Trying %s => %s"
> > >  qemu_rdma_signal_unregister_append(uint64_t chunk, int pos) "Appending unregister chunk %" PRIu64 " at position %d"
> > >  qemu_rdma_signal_unregister_already(uint64_t chunk) "Unregister chunk %" PRIu64 " already in queue"
> Not related to this change. Above 2 functions are not used, we might
> want to remove them.

True, I'll drop them altogether.

Thanks,

> 
> > > -qemu_rdma_unregister_waiting_inflight(uint64_t chunk) "Cannot unregister inflight chunk: %" PRIu64
> > > -qemu_rdma_unregister_waiting_proc(uint64_t chunk, int pos) "Processing unregister for chunk: %" PRIu64 " at position %d"
> > > -qemu_rdma_unregister_waiting_send(uint64_t chunk) "Sending unregister for chunk: %" PRIu64
> > > -qemu_rdma_unregister_waiting_complete(uint64_t chunk) "Unregister for chunk: %" PRIu64 " complete."
> > >  qemu_rdma_write_flush(int sent) "sent total: %d"
> > >  qemu_rdma_write_one_block(int count, int block, uint64_t chunk, uint64_t current, uint64_t len, int nb_sent, int nb_chunks) "(%d) Not clobbering: block: %d chunk %" PRIu64 " current %" PRIu64 " len %" PRIu64 " %d %d"
> > >  qemu_rdma_write_one_post(uint64_t chunk, long addr, long remote, uint32_t len) "Posting chunk: %" PRIu64 ", addr: 0x%lx remote: 0x%lx, bytes %" PRIu32
> > > @@ -266,9 +262,6 @@ rdma_registration_handle_ram_blocks_loop(const char *name, uint64_t offset, uint
> > >  rdma_registration_handle_register(int requests) "%d requests"
> > >  rdma_registration_handle_register_loop(int req, int index, uint64_t addr, uint64_t chunks) "Registration request (%d): index %d, current_addr %" PRIu64 " chunks: %" PRIu64
> > >  rdma_registration_handle_register_rkey(int rkey) "0x%x"
> > > -rdma_registration_handle_unregister(int requests) "%d requests"
> > > -rdma_registration_handle_unregister_loop(int count, int index, uint64_t chunk) "Unregistration request (%d): index %d, chunk %" PRIu64
> > > -rdma_registration_handle_unregister_success(uint64_t chunk) "%" PRIu64
> > >  rdma_registration_handle_wait(void) ""
> > >  rdma_registration_start(uint64_t flags) "%" PRIu64
> > >  rdma_registration_stop(uint64_t flags) "%" PRIu64
> > > --
> > > 2.54.0
> > >
> 

-- 
Peter Xu


