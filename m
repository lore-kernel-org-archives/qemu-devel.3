Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E7FC5DF93
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:11:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxPxM-0004Kd-Mn; Fri, 21 Aug 2026 10:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wxPxL-0004KS-42
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 10:10:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wxPxH-0000tf-FF
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 10:10:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787321446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ing1BRa21JFlzyyqgKKOQM0dS+KtO4rqUttbyUEPN48=;
 b=CX3EgbqK/9ufBKSld4ag1V9apoO1godW/F/IACptNgjNjSj0lJM7voNS2OLFtx4jET82qm
 Q9Cwec66SwAJpAIkV0GGkxVaMxjj5xasJoBtJ2xzziwcatJkU6xH+Fjw8FdrQhWoewA5z1
 HiBjjEDqpHZShCOpnIaEP3hxLCLblfA=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-Jdu_Y85gNvyLPKIDWMnVGQ-1; Fri, 21 Aug 2026 10:10:44 -0400
X-MC-Unique: Jdu_Y85gNvyLPKIDWMnVGQ-1
X-Mimecast-MFC-AGG-ID: Jdu_Y85gNvyLPKIDWMnVGQ_1787321444
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-4519fdc5145so1664083fac.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 07:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787321444; x=1787926244; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ing1BRa21JFlzyyqgKKOQM0dS+KtO4rqUttbyUEPN48=;
 b=R1dOEPcmpKwcPVrLqF0/7KpKEqqwYBmJ8Bs/EfxJ3E+xEKFEYc2MFmSNzxmLD6M86A
 /iYzTAPriT2jDs3faX1B0YqMU56BpqqxBU5SQSIi0UZiOOiuLkIGac+rLcmg+prkk/Ga
 RhBTJK6CEZXqzdrKEfE1KwKEJ372Y/APHrahWDCUNDaPx8PXmvYJSOMV8/wRwe/Zt+8S
 gVCH3Cs36B9Y/VnAO5+rrOkx+Oys2HgamicYb8DywmnY16Vey0NaMNEUTMoVxvuJgR0Z
 QrB0ef9nxGakxZw0prnLPGEZkETTZT1TIQ+vEspjZBO5grBgrdLUu3wLrInZBhHNHIET
 qMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787321444; x=1787926244;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ing1BRa21JFlzyyqgKKOQM0dS+KtO4rqUttbyUEPN48=;
 b=DeJOK601XjEdnzVODaQ5jw0HaiKwdHo+mc2jC9eE/8LOV5KZAAvFvnABbi5UlKIvA+
 Eju1znvz8S+u5k5FudSfTBuWppiKv6kFmxE0cUZPqll+SWiUJW14kFMZK7Mf3hvz1yWD
 FClX9X25/GtX6Bem05aCnRrdMqC+5+0i06hPFOiislxdAmRFOxlvLpPn0at9rSMllIsW
 5qqDgh8BplxLW7EZhuVhSZrmJsPv0QNB4g16HtBUQbfTJOF//5WV+ErLI0HzBftFtPQ/
 LvQiTN2uwQ2PC27kLnR2X2oWF0LTs4MF+oZoPOPgwR/59tBo3QCqskhHwg4Krxrwp3He
 jbQg==
X-Gm-Message-State: AOJu0YwxVGYfDZmFR8lnNxyekESLRRbqR2g5o166ZqY2/zjxx8C2kzfz
 89uVcmRoweDJHU4FrqOgbpToF50mewpgiQ2hsJ6WpJSY/Q0/UGihbrHmgzKj7TyXyIGP08hNbRI
 pD2V9uyH3duIrjlS2H5fKfa6eaAwlyyQQ7xZemY7FETv/4TuVtueALEZR
X-Gm-Gg: AR+sD12pTHgASuB2g3NVJeaKjaVKSuglNzy1PIbPogRJ2Nqet/AI3fILTUgIhs2iwZ4
 CxBuFGZLb+yCkkGop5k74REn+wT5gWuSsNoPLJWvTwb8KZLf6vHnz4bFwebueS0idAA8NWN90jC
 WHJhZ1LQs7qViBZ24gX54R8fCmAZ6K0476lBG/d/KacnqTfnuA06CzhKcTTz4gEYUJj+CSGa9OH
 aECVGcz9JvES6BHIJ+tkeu1DOAL6sxV/oPm1ZzHd5kyA4iqXgpTbzW53SB61jR90Suk+uAgH4yq
 dNXxeHMHLFIzKZgWAuqQUlXOC+SkUBAg7IWQFu85XNBfb2ff/1JGIC+dj/1A4ty9bQ68TiWl
X-Received: by 2002:a05:6820:28c5:b0:6b1:4fa4:76c5 with SMTP id
 006d021491bc7-6b1591d560bmr6074278eaf.4.1787321443697; 
 Fri, 21 Aug 2026 07:10:43 -0700 (PDT)
X-Received: by 2002:a05:6820:28c5:b0:6b1:4fa4:76c5 with SMTP id
 006d021491bc7-6b1591d560bmr6074222eaf.4.1787321443132; 
 Fri, 21 Aug 2026 07:10:43 -0700 (PDT)
Received: from x1.local ([2605:8d80:6d68:fe45:30f9:c4fc:ce4b:4f74])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b13cbd4f12sm8823654eaf.6.2026.08.21.07.10.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 07:10:42 -0700 (PDT)
Date: Fri, 21 Aug 2026 10:10:40 -0400
From: Peter Xu <peterx@redhat.com>
To: Yanfei Xu <yanfei.xu@bytedance.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, lizhijian@fujitsu.com,
 jinpu.wang@cloud.ionos.com, isyanfei.xu@gmail.com
Subject: Re: [PATCH v2 3/3] migration/rdma: Retry control sends on full queue
Message-ID: <aohcYFgiDXpCWAlg@x1.local>
References: <20260821133559.3815727-1-yanfei.xu@bytedance.com>
 <20260821133559.3815727-4-yanfei.xu@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260821133559.3815727-4-yanfei.xu@bytedance.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

On Fri, Aug 21, 2026 at 09:35:59PM +0800, Yanfei Xu wrote:
> RAM writes and control messages share the send queue. If outstanding
> writes fill it, RDMA writes drain a completion and retry, but control
> sends fail the migration.
> 
> Move send posting and queue-full handling into a common helper. On
> ENOMEM, drain one outstanding RDMA write and retry the failed request
> once. If no write is outstanding, or the retry still fails, propagate
> the error.
> 
> Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>

In general looks good, thanks,

Reviewed-by: Peter Xu <peterx@redhat.com>

I have nitpicks though, you can keep the R-b if you agree and would also
like to respin with that.  See below.

> ---
>  migration/rdma.c       | 78 +++++++++++++++++++++++++++---------------
>  migration/trace-events |  2 +-
>  2 files changed, 51 insertions(+), 29 deletions(-)
> 
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 6e8436ccc1..ee6da4f137 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -1530,6 +1530,52 @@ err_block_for_wrid:
>      return -1;
>  }
>  
> +/*
> + * Post a send work request, draining an outstanding RDMA write if the send
> + * queue is full.
> + */
> +static int qemu_rdma_post_send(RDMAContext *rdma,
> +                               struct ibv_send_wr *send_wr,
> +                               Error **errp)

Good to have errp and mask libibverb's weird positive returns.. but then
since we're at it anyway, better if we switch retval to bool too.  It's
pretty much QEMU standard now to do this by default in new fn()s:

  bool fn(..., Error **errp);

> +{
> +    struct ibv_send_wr *bad_wr;
> +    uint64_t wr_id = send_wr->wr_id & RDMA_WRID_TYPE_MASK;
> +    const char *wr_desc;
> +    int ret;
> +
> +    switch (wr_id) {
> +    case RDMA_WRID_RDMA_WRITE:
> +        wr_desc = "RDMA write";
> +        break;
> +    case RDMA_WRID_SEND_CONTROL:
> +        wr_desc = "control send";
> +        break;
> +    default:
> +        wr_desc = "send work request";
> +        break;

Do we have other possibility?  I thought it should be either WRITE or SEND,
if so, we could g_assert_not_reached().

> +    }
> +
> +    ret = ibv_post_send(rdma->qp, send_wr, &bad_wr);
> +    if (ret == ENOMEM && rdma->nb_sent) {
> +        trace_qemu_rdma_post_send_queue_full(send_wr->wr_id, rdma->nb_sent);
> +        ret = qemu_rdma_block_for_wrid(rdma, RDMA_WRID_RDMA_WRITE, NULL);
> +        if (ret < 0) {
> +            error_setg(errp, "rdma migration: failed to make room for %s",
> +                       wr_desc);
> +            return -1;
> +        }
> +        ret = ibv_post_send(rdma->qp, send_wr, &bad_wr);

Yes, RDMA is almost single-threaded.. one retry would be enough, agreed.

Thanks,

> +    }
> +
> +    if (ret > 0) {
> +        error_setg_errno(errp, ret, "rdma migration: post %s failed",
> +                         wr_desc);
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
>  /*
>   * Post a SEND message work request for the control channel
>   * containing some data and block until the post completes.
> @@ -1540,7 +1586,6 @@ static int qemu_rdma_post_send_control(RDMAContext *rdma, uint8_t *buf,
>  {
>      int ret;
>      RDMAWorkRequestData *wr = &rdma->wr_data[RDMA_WRID_CONTROL];
> -    struct ibv_send_wr *bad_wr;
>      struct ibv_sge sge = {
>                             .addr = (uintptr_t)(wr->control),
>                             .length = head->len + sizeof(RDMAControlHeader),
> @@ -1572,11 +1617,8 @@ static int qemu_rdma_post_send_control(RDMAContext *rdma, uint8_t *buf,
>          memcpy(wr->control + sizeof(RDMAControlHeader), buf, head->len);
>      }
>  
> -
> -    ret = ibv_post_send(rdma->qp, &send_wr, &bad_wr);
> -
> -    if (ret > 0) {
> -        error_setg(errp, "Failed to use post IB SEND for control");
> +    ret = qemu_rdma_post_send(rdma, &send_wr, errp);
> +    if (ret < 0) {
>          return -1;
>      }
>  
> @@ -1836,7 +1878,6 @@ static int qemu_rdma_write_one(RDMAContext *rdma,
>  {
>      struct ibv_sge sge;
>      struct ibv_send_wr send_wr = { 0 };
> -    struct ibv_send_wr *bad_wr;
>      int reg_result_idx, ret, count = 0;
>      uint64_t chunk, chunks;
>      uint64_t chunk_size = migrate_rdma_chunk_size();
> @@ -1850,7 +1891,6 @@ static int qemu_rdma_write_one(RDMAContext *rdma,
>                                 .repeat = 1,
>                               };
>  
> -retry:
>      sge.addr = (uintptr_t)(block->local_host_addr +
>                              (current_addr - block->offset));
>      sge.length = length;
> @@ -2020,26 +2060,8 @@ retry:
>      trace_qemu_rdma_write_one_post(chunk, sge.addr, send_wr.wr.rdma.remote_addr,
>                                     sge.length);
>  
> -    /*
> -     * ibv_post_send() does not return negative error numbers,
> -     * per the specification they are positive - no idea why.
> -     */
> -    ret = ibv_post_send(rdma->qp, &send_wr, &bad_wr);
> -
> -    if (ret == ENOMEM) {
> -        trace_qemu_rdma_write_one_queue_full();
> -        ret = qemu_rdma_block_for_wrid(rdma, RDMA_WRID_RDMA_WRITE, NULL);
> -        if (ret < 0) {
> -            error_setg(errp, "rdma migration: failed to make "
> -                         "room in full send queue!");
> -            return -1;
> -        }
> -
> -        goto retry;
> -
> -    } else if (ret > 0) {
> -        error_setg_errno(errp, ret,
> -                         "rdma migration: post rdma write failed");
> +    ret = qemu_rdma_post_send(rdma, &send_wr, errp);
> +    if (ret < 0) {
>          return -1;
>      }
>  
> diff --git a/migration/trace-events b/migration/trace-events
> index af0e784535..bc0c167a1a 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -251,7 +251,7 @@ qemu_rdma_unregister_waiting_complete(uint64_t chunk) "Unregister for chunk: %"
>  qemu_rdma_write_flush(int sent) "sent total: %d"
>  qemu_rdma_write_one_block(int count, int block, uint64_t chunk, uint64_t current, uint64_t len, int nb_sent, int nb_chunks) "(%d) Not clobbering: block: %d chunk %" PRIu64 " current %" PRIu64 " len %" PRIu64 " %d %d"
>  qemu_rdma_write_one_post(uint64_t chunk, long addr, long remote, uint32_t len) "Posting chunk: %" PRIu64 ", addr: 0x%lx remote: 0x%lx, bytes %" PRIu32
> -qemu_rdma_write_one_queue_full(void) ""
> +qemu_rdma_post_send_queue_full(uint64_t wr_id, int sent) "send queue full, wr_id=%" PRIu64 ", outstanding writes=%d"
>  qemu_rdma_write_one_recvregres(int mykey, int theirkey, uint64_t chunk) "Received registration result: my key: 0x%x their key 0x%x, chunk %" PRIu64
>  qemu_rdma_write_one_sendreg(uint64_t chunk, int len, int index, int64_t offset) "Sending registration request chunk %" PRIu64 " for %d bytes, index: %d, offset: %" PRId64
>  qemu_rdma_write_one_top(uint64_t chunks, uint64_t size) "Writing %" PRIu64 " chunks, (%" PRIu64 " MB)"
> -- 
> 2.20.1
> 

-- 
Peter Xu


