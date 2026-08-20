Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 991DEC5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 19:40:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx8cI-0008MF-FY; Thu, 20 Aug 2026 15:39:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wx8cH-0008M6-31
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 15:39:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wx8cF-0007uF-Bj
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 15:39:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787254793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rudLtd0zR7uZ/Daq2SQBxk9mGzU6JQtbD2efOcpFZWM=;
 b=QnlWywfdTVX4fr0QARx/msaK+NoPPuBRGOQKEGcmrp5L0MqkamySxVBd5bbl5Mkm2RPVUy
 2AwtioAke/aIRlU9/jnB+Wy/tjiSabkuUiEBnnTfHtk5mJrGMsPxsP/73ORyBwdZqMIJwR
 8qpxqbhAAVIm0DGbZjD5TBSkA6aAQag=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-_FtPyhQTN6q9sJhXoJ_IJA-1; Thu, 20 Aug 2026 15:39:52 -0400
X-MC-Unique: _FtPyhQTN6q9sJhXoJ_IJA-1
X-Mimecast-MFC-AGG-ID: _FtPyhQTN6q9sJhXoJ_IJA_1787254792
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e62e3459fso22482785a.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 12:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787254792; x=1787859592; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rudLtd0zR7uZ/Daq2SQBxk9mGzU6JQtbD2efOcpFZWM=;
 b=PTileW/thB9oDwz4GQTQELIbJaTWQWxJiZ7oq6JYqjOWOZPukseaITvfROaHonPaZw
 2+oNuL9V0tPQRisCKICFQF5x2/NLZlwjtrHsR5rvPtzglcolYAtIB7b46YevPrnRnoB+
 So01uu4JmnEauxjCVG6RnVe4JMGLMm3iEkIK9Dj6xjc5IaJaJVxKSjHx/iZzMwnKyWND
 pt/sifScCkkfnPpYPudxvWhDVZXASDeK8LuFAaG5Jrz51z7k8V+6sHVCIeM0WRxvh8AA
 9TWVv2J3+wnDza00vlStbeRT1W2FdHKtjU5cvz0iQu443qegGNdFpDkv4KzyioDHAnwb
 UuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787254792; x=1787859592;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rudLtd0zR7uZ/Daq2SQBxk9mGzU6JQtbD2efOcpFZWM=;
 b=OPkkMI4fcJiteCpYBnHdX2cJRnDLyakLyVDU92KJlxFVyd4W8pholK/kUE+mYQrD02
 F2MgyP6stKXSCslWwg5S0hZOLw5e4uWTazLszWnDOHt+nRGUOAyvwNbLblpkRSnry0me
 dmsSiqDTlXVqPW/+PO0sYdGDqXEj9sJK7XgiISPHQP+HUeG60oDWYLXhpWKSIZuo/lXf
 PcEQ2L5m6mfuc9Owemmz0XkSwJ6z5FO3KAXBLulUor4hzyrQwBWFZw4bKIGWMtMOmcQu
 jf3HQ74GDtmTcdOI5dMfEQuVaQ4oGAlGScKl5fRwryP2bUeramLFrnT/sjiCQOUzT+03
 P7mg==
X-Gm-Message-State: AOJu0YxoNdKItuPw2GWOeOFXUgFeMyOLcKCL0RRe8/GRALEVDtz6KHq+
 h85shysdfjzTHuMOtYJk78iwF3n1+TRNpI7eAsB7xXt7nUD2qbQ9oqViNtr8UzNewkE1xsgii+V
 aJeIQ36gdi2TTp7e6mzDqwVecIQYYFGlcODcSFQUZxMaeEwkvi7M1d6CG
X-Gm-Gg: AR+sD13o6NxV1NaGAxL8rk7JsUu5jsP4LJGzw8aW67WqM+IBu+fIh7AiHq9svpvV5p1
 uYMREolyEMH1dEdWuaLdIaqH/hoOBDbQwJ1d3Fezeyd0XBxPnNP94LJS/E+q/sO93cBF2CPhozR
 fnIN2b09sqhUg7CaF2nxGRLaWvq2aEUAUCZ7QKDOM3j6+LGyaHBtV583usap0sO4Hodn775O/D3
 vAeP+RAH7ogaTu28fDS31Gvy6v1/Wu899gOAhxUb6KsaKTpkmOwBB8UZHkIuOQ3HD+KCZjyN+U4
 MAzn04nnE7Oe3RF/SIwB5n1SCjEXIi0sy0OcE6jui8C55clMlK8TIqDp7L9nEOndBuSa
X-Received: by 2002:ac8:6546:0:b0:51b:f857:cf82 with SMTP id
 d75a77b69052e-52df5694797mr9447701cf.8.1787254792004; 
 Thu, 20 Aug 2026 12:39:52 -0700 (PDT)
X-Received: by 2002:ac8:6546:0:b0:51b:f857:cf82 with SMTP id
 d75a77b69052e-52df5694797mr9447031cf.8.1787254791391; 
 Thu, 20 Aug 2026 12:39:51 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52dd8749329sm36597231cf.25.2026.08.20.12.39.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 12:39:50 -0700 (PDT)
Date: Thu, 20 Aug 2026 15:39:39 -0400
From: Peter Xu <peterx@redhat.com>
To: Yanfei Xu <yanfei.xu@bytedance.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, lizhijian@fujitsu.com,
 isyanfei.xu@gmail.com, jinpu.wang@cloud.ionos.com
Subject: Re: [RFC PATCH v1 2/2] migration/rdma: Allow multiple in-flight
 writes per chunk
Message-ID: <aodX-7MIcGXmHEpP@x1.local>
References: <20260820125833.1541756-1-yanfei.xu@bytedance.com>
 <20260820125833.1541756-3-yanfei.xu@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260820125833.1541756-3-yanfei.xu@bytedance.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
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

On Thu, Aug 20, 2026 at 08:58:33PM +0800, Yanfei Xu wrote:
> qemu_rdma_write_one() waits for an earlier write to the same
> registration chunk to complete.  This serializes disjoint dirty ranges
> in a chunk and leaves send queue capacity unused.
> 
> Remove the per-chunk wait and use the reference counts to track all
> outstanding writes.  The existing per-iteration drain remains the
> completion barrier.

I think this should work (by accident; will explain below), but I want to
raise the definition of iteration here, and it may or may not be what was
expected.

Migration core has this problem likely since 10+ years ago when it start to
have two definitions..

- Each time ram_save_iterate() is invoked: this is the "iteration" that
  RDMA is tracking, it does qemu_rdma_drain_cq() when finishing for each
  call (applies to complete() too)

- Each time migration RAM core syncs dirty info and re-scans the whole
  guest memories (all ramblocks)

For RDMA (and non-RDMA too), what matters is for each same page its new
version always lands *after* its old version.  IIUC, what it really needs
is defintion 2), not 1)..  See the call of multifd_ram_sync_per_round() of
find_dirty_block(), so it was called "a round" there, but I believe we
report such iteration count (in reality, "dirty-sync-count") in QMP
query-migrate with this concept.

I still think relying on the qemu_rdma_drain_cq() should be fine for now,
it's because currently we hold bitmap_mutex across the whole
ram_save_iterate() (NOTE: postcopy preempt may release it.. another thing
to discuss..), so bmap at least for precopy shouldn't be able to change, it
also means for each ram_save_iterate() we shouldn't be sending the same
page twice.  But I think it's risky relying on that fact, e.g. we already
have concurrent sync dirty bitmap, like cpu_throttle_dirty_sync_timer_tick,
so maybe it's better RDMA also flush its pages at definition 2) not 1).
IIUC, it'll also improve on performance because RDMA needs to flush less.

Maybe we should make it a generic API in find_dirty_block(), like
notifiers, so that multifd (and maybe RDMA too?) doesn't need to hard code
things like multifd_ram_flush_and_sync().

Thanks,

> 
> Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
> ---
>  migration/rdma.c       | 19 +------------------
>  migration/trace-events |  1 -
>  2 files changed, 1 insertion(+), 19 deletions(-)
> 
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 973a7a745a..63bc357657 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -1869,7 +1869,7 @@ static int qemu_rdma_write_one(RDMAContext *rdma,
>      struct ibv_sge sge;
>      struct ibv_send_wr send_wr = { 0 };
>      struct ibv_send_wr *bad_wr;
> -    int reg_result_idx, ret, count = 0;
> +    int reg_result_idx, ret;
>      uint64_t chunk, chunks;
>      uint64_t chunk_size = migrate_rdma_chunk_size();
>      uint8_t *chunk_start, *chunk_end;
> @@ -1910,23 +1910,6 @@ retry:
>  
>      chunk_end = ram_chunk_end(block, chunk + chunks);
>  
> -
> -    while (qemu_rdma_chunk_in_transit(block, chunk)) {
> -        (void)count;
> -        trace_qemu_rdma_write_one_block(count++, current_index, chunk,
> -                sge.addr, length, rdma->nb_sent, block->nb_chunks);
> -
> -        ret = qemu_rdma_block_for_wrid(rdma, RDMA_WRID_RDMA_WRITE, NULL);
> -
> -        if (ret < 0) {
> -            error_setg(errp, "Failed to Wait for previous write to complete "
> -                    "block %d chunk %" PRIu64
> -                    " current %" PRIu64 " len %" PRIu64 " %d",
> -                    current_index, chunk, sge.addr, length, rdma->nb_sent);
> -            return -1;
> -        }
> -    }
> -
>      if (!rdma->pin_all || !block->is_ram_block) {
>          if (!block->remote_keys[chunk]) {
>              /*
> diff --git a/migration/trace-events b/migration/trace-events
> index 172761be78..253ff71891 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -249,7 +249,6 @@ qemu_rdma_unregister_waiting_proc(uint64_t chunk, int pos) "Processing unregiste
>  qemu_rdma_unregister_waiting_send(uint64_t chunk) "Sending unregister for chunk: %" PRIu64
>  qemu_rdma_unregister_waiting_complete(uint64_t chunk) "Unregister for chunk: %" PRIu64 " complete."
>  qemu_rdma_write_flush(int sent) "sent total: %d"
> -qemu_rdma_write_one_block(int count, int block, uint64_t chunk, uint64_t current, uint64_t len, int nb_sent, int nb_chunks) "(%d) Not clobbering: block: %d chunk %" PRIu64 " current %" PRIu64 " len %" PRIu64 " %d %d"
>  qemu_rdma_write_one_post(uint64_t chunk, long addr, long remote, uint32_t len) "Posting chunk: %" PRIu64 ", addr: 0x%lx remote: 0x%lx, bytes %" PRIu32
>  qemu_rdma_write_one_queue_full(void) ""
>  qemu_rdma_write_one_recvregres(int mykey, int theirkey, uint64_t chunk) "Received registration result: my key: 0x%x their key 0x%x, chunk %" PRIu64
> -- 
> 2.20.1
> 

-- 
Peter Xu


