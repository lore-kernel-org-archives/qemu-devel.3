Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC080C624D3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 15:28:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1QP4-0007Q3-Q2; Tue, 01 Sep 2026 11:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1x1QP3-0007Pq-Iy
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 11:28:01 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1x1QP1-0001VR-IW
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 11:28:01 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6a63fc1f481so323270a12.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 08:27:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788276476; cv=none;
 d=google.com; s=arc-20260327;
 b=lj/gaZuMKBwPfJ9AJKP143OUMoyPJNaSotO9sz5bJXn5AR6Dn/jFl65O3Uzsg1y5NQ
 z5Tc/YPQvmDjE1JRWsMqXCvLqcIyY2c50owWXKEqlmZSzsBigbR9zS8I/qHMU0QHGz/w
 /mDetmE0o0vfI57Xu294nB16H58Y9zfljZj7/NF+6LbrOxYWKMD+Co0+4SEW60YOADMt
 JKnq4er0JwVK9S3tQyhc4lWl9BRwH3FI6NyUIeKW/WTyQRnvGU3SFZzT99XxNJupoJCr
 o09j/TmnxmpTe4qk7wBBAkkuryOa4R7PtkjYKxmLD/aMvzVOTNnrpTN6Tl7hWDDv96s8
 VPkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=L0T5cGffwb4WyfyQGCSyB+aFuvtIoaqFeJ1j7y4ruLo=;
 fh=+xxEUy9FJ+CZAB7XtA50nI6rSHzay7r77rFZhazA3AA=;
 b=aUN/Pc/6xy2mJdzzxychK2Up1KMh10Me73g/cEXDMTStiWff/xBKDTE7T6lapAMcgM
 H83uvL1nq8scXJXM92biUq3eTMSxJxRRfMMAznfc135fUe+0K1iyLZ5eFX6jXhlNAtiS
 eT10pauGAZ6IqiARdXJDu9WcJjqwyH2Np8NZDgVA8A+iUtg6dKQ+Te0udYf3UMn39j1x
 M+SzmiU1WtPqYNOlpsr0ynh3TXWiYwYDqtYCswP/w6S27DINxBwXYft0dvuv8UoEW4xi
 ll7v5daMQm5QsgeVionFakJfWAIqlR3ervfyyEe2KBXJCcmdjBVxCfSDKDlLPrX7V7At
 IDnQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google; t=1788276476; x=1788881276; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=L0T5cGffwb4WyfyQGCSyB+aFuvtIoaqFeJ1j7y4ruLo=;
 b=ew3OXPad2NIcwS8aU5Ds4J/sOaACLgPT8BWZAmF++Mn+SREsS7YgRm4sGuYJFGqpUs
 gUqnywUZ/jsIt5kHawXL2Az6bu4EDSD6ZzbVam2ZPLt1NgnQGLc74xxx6PlDWkhbIMyM
 pzlITeDwnGRZ1hO/qNquNRFesC1umaWi8+nl7t5qa35o+zd/WdDUBDM9z7jOX+6r1oAv
 9dIEjMqDUEenmTqs4IhSqSzzeiF/46I3eKh0K7Oqy8uNA2S23XEPTzWtab2bR3o8WFv7
 f/P9Z1Mzvh7/b24fZ7a8Qz8rxFFzTvsbpwOkW1hDPq8OaJ4wVPDWB9Qkgfzb1SlvDNdj
 tjMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788276476; x=1788881276;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L0T5cGffwb4WyfyQGCSyB+aFuvtIoaqFeJ1j7y4ruLo=;
 b=a71vfRSGqDbyAPbfjveQSqREsHo2wYDqxsrF14kTXkvkVI3aYFa88Uq22Zgdx45PLw
 A7cZENzNY7sO9lj3/a7tVqSH9cgPl6Zt0AtjEULGDPNwE/dFkSSJFquQ5l+lvmZokp+x
 5RORB/Da7hCclgHDFPxixpSILq6tgXoT+Obopl3IHxQLVlQOsBNAPwQS55g+3rY7KqbT
 MWMbIX7j5v9EePVR3qNBIFfZqmfM3s5XW38KAhS4knf+jZYvi8vZzlHz2o0XLC7G+BAF
 op3ca8LBb4wRMCbxc4Zu2TC8QwLk5E/K1pqWknEHLjFUAwgXL/QJYX+cdhiXdQbIfv7z
 Ob4A==
X-Gm-Message-State: AFuF++kZoNHGlNf+worNXSMJxLYMhOYBpWYOo8W3t6vOT1nL4PUPZfPT
 9BLlh65R48VjVRaM6QXOvUOFc/mH3oHK2i2x3/LQUp8pmel5zTjuupq2YHktpSkIzRNR/KZK3b/
 Ze9Rn7HcYmsyZIE5ted6XxcJix2oj/cgNUIhnxKYGVg==
X-Gm-Gg: AR+sD11RucJxjOfn13NPInHTRE+rhWANOq+DcKQ7HKl5l3scvQfHjEy1AinIhaHUPQl
 uquJl85Cojs7eVpOmFeqSkYiIFjJ7InmD0r+QQTWbktnnhQK16P7G11zKeWwpN7riBhRVjoOagQ
 2cw8NcibJiyanqHn9bch4yfuKn61H4wPl8zIURdPnpNyEv6oGfQifw0hOPpmRFtsRGNNUgVYmlU
 5hU1wFOBuMoK5yiWDEmURHQnhzOvN1HjSBek93T8qEJ8HUmbM4zCozfkuAEUOR3eRdLOWJxTMtV
 JrWh7WYJbpUOYe9tHP9n4zMYLHvDJalPYmt8lrcsSGmxSchcquxAyiV9TRJnIbOYqUHlnKFISR9
 5Eg==
X-Received: by 2002:a17:907:6d19:b0:c12:6db4:4bf4 with SMTP id
 a640c23a62f3a-c2556639587mr1221223566b.0.1788276476011; Tue, 01 Sep 2026
 08:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260823021657.2824542-1-yanfei.xu@bytedance.com>
 <20260823021657.2824542-4-yanfei.xu@bytedance.com>
In-Reply-To: <20260823021657.2824542-4-yanfei.xu@bytedance.com>
From: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date: Tue, 1 Sep 2026 17:27:44 +0200
X-Gm-Features: AcwNN1WljaNO4--Qt4Diquq-kBGTFLJ1j2fCEf4OXFjtwIt2M4ug7Qw_5UcnVgc
Message-ID: <CAMGffE=6T_yGA7eiGCGf-m-CsijTM5AVtq9zPqvGspt=ivBHzA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] migration/rdma: Retry control sends on full queue
To: Yanfei Xu <yanfei.xu@bytedance.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de, 
 lizhijian@fujitsu.com, isyanfei.xu@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:20::536;
 envelope-from=jinpu.wang@ionos.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Sun, Aug 23, 2026 at 4:18=E2=80=AFAM Yanfei Xu <yanfei.xu@bytedance.com>=
 wrote:
>
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
> Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  migration/rdma.c       | 75 ++++++++++++++++++++++++++----------------
>  migration/trace-events |  2 +-
>  2 files changed, 48 insertions(+), 29 deletions(-)
>
> diff --git a/migration/rdma.c b/migration/rdma.c
> index b79f4263f7..b7580ab54f 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -1553,6 +1553,51 @@ err_block_for_wrid:
>      return -1;
>  }
>
> +/*
> + * Post a send work request, draining an outstanding RDMA write if the s=
end
> + * queue is full.
> + */
> +static bool qemu_rdma_post_send(RDMAContext *rdma,
> +                               struct ibv_send_wr *send_wr,
> +                               Error **errp)
> +{
> +    struct ibv_send_wr *bad_wr;
> +    uint64_t wr_id =3D send_wr->wr_id & RDMA_WRID_TYPE_MASK;
> +    const char *wr_desc;
> +    int ret;
> +
> +    switch (wr_id) {
> +    case RDMA_WRID_RDMA_WRITE:
> +        wr_desc =3D "RDMA write";
> +        break;
> +    case RDMA_WRID_SEND_CONTROL:
> +        wr_desc =3D "control send";
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    ret =3D ibv_post_send(rdma->qp, send_wr, &bad_wr);
> +    if (ret =3D=3D ENOMEM && rdma->nb_sent) {
> +        trace_qemu_rdma_post_send_queue_full(send_wr->wr_id, rdma->nb_se=
nt);
> +        ret =3D qemu_rdma_block_for_wrid(rdma, RDMA_WRID_RDMA_WRITE, NUL=
L);
> +        if (ret < 0) {
> +            error_setg(errp, "rdma migration: failed to make room for %s=
",
> +                       wr_desc);
> +            return false;
> +        }
> +        ret =3D ibv_post_send(rdma->qp, send_wr, &bad_wr);
> +    }
> +
> +    if (ret > 0) {
> +        error_setg_errno(errp, ret, "rdma migration: post %s failed",
> +                         wr_desc);
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
>  /*
>   * Post a SEND message work request for the control channel
>   * containing some data and block until the post completes.
> @@ -1563,7 +1608,6 @@ static int qemu_rdma_post_send_control(RDMAContext =
*rdma, uint8_t *buf,
>  {
>      int ret;
>      RDMAWorkRequestData *wr =3D &rdma->wr_data[RDMA_WRID_CONTROL];
> -    struct ibv_send_wr *bad_wr;
>      struct ibv_sge sge =3D {
>                             .addr =3D (uintptr_t)(wr->control),
>                             .length =3D head->len + sizeof(RDMAControlHea=
der),
> @@ -1595,11 +1639,7 @@ static int qemu_rdma_post_send_control(RDMAContext=
 *rdma, uint8_t *buf,
>          memcpy(wr->control + sizeof(RDMAControlHeader), buf, head->len);
>      }
>
> -
> -    ret =3D ibv_post_send(rdma->qp, &send_wr, &bad_wr);
> -
> -    if (ret > 0) {
> -        error_setg(errp, "Failed to use post IB SEND for control");
> +    if (!qemu_rdma_post_send(rdma, &send_wr, errp)) {
>          return -1;
>      }
>
> @@ -1859,7 +1899,6 @@ static int qemu_rdma_write_one(RDMAContext *rdma,
>  {
>      struct ibv_sge sge;
>      struct ibv_send_wr send_wr =3D { 0 };
> -    struct ibv_send_wr *bad_wr;
>      int reg_result_idx, ret;
>      uint64_t chunk, chunks;
>      uint64_t chunk_size =3D migrate_rdma_chunk_size();
> @@ -1873,7 +1912,6 @@ static int qemu_rdma_write_one(RDMAContext *rdma,
>                                 .repeat =3D 1,
>                               };
>
> -retry:
>      sge.addr =3D (uintptr_t)(block->local_host_addr +
>                              (current_addr - block->offset));
>      sge.length =3D length;
> @@ -2026,26 +2064,7 @@ retry:
>      trace_qemu_rdma_write_one_post(chunk, sge.addr, send_wr.wr.rdma.remo=
te_addr,
>                                     sge.length);
>
> -    /*
> -     * ibv_post_send() does not return negative error numbers,
> -     * per the specification they are positive - no idea why.
> -     */
> -    ret =3D ibv_post_send(rdma->qp, &send_wr, &bad_wr);
> -
> -    if (ret =3D=3D ENOMEM) {
> -        trace_qemu_rdma_write_one_queue_full();
> -        ret =3D qemu_rdma_block_for_wrid(rdma, RDMA_WRID_RDMA_WRITE, NUL=
L);
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
> +    if (!qemu_rdma_post_send(rdma, &send_wr, errp)) {
>          return -1;
>      }
>
> diff --git a/migration/trace-events b/migration/trace-events
> index bcc102e323..7197c9dc6d 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -250,7 +250,7 @@ qemu_rdma_unregister_waiting_send(uint64_t chunk) "Se=
nding unregister for chunk:
>  qemu_rdma_unregister_waiting_complete(uint64_t chunk) "Unregister for ch=
unk: %" PRIu64 " complete."
>  qemu_rdma_write_flush(int sent) "sent total: %d"
>  qemu_rdma_write_one_post(uint64_t chunk, long addr, long remote, uint32_=
t len) "Posting chunk: %" PRIu64 ", addr: 0x%lx remote: 0x%lx, bytes %" PRI=
u32
> -qemu_rdma_write_one_queue_full(void) ""
> +qemu_rdma_post_send_queue_full(uint64_t wr_id, int sent) "send queue ful=
l, wr_id=3D%" PRIu64 ", outstanding writes=3D%d"
>  qemu_rdma_write_one_recvregres(int mykey, int theirkey, uint64_t chunk) =
"Received registration result: my key: 0x%x their key 0x%x, chunk %" PRIu64
>  qemu_rdma_write_one_sendreg(uint64_t chunk, int len, int index, int64_t =
offset) "Sending registration request chunk %" PRIu64 " for %d bytes, index=
: %d, offset: %" PRId64
>  qemu_rdma_write_one_top(uint64_t chunks, uint64_t size) "Writing %" PRIu=
64 " chunks, (%" PRIu64 " MB)"
> --
> 2.20.1

