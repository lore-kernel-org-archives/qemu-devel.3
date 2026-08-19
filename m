Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CED7C5DF87
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 12:43:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwfdq-00087j-FZ; Wed, 19 Aug 2026 08:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1wwedo-0007Gb-6D
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 07:39:32 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1wwedk-0008Sa-CD
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 07:39:31 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c15f025146dso10885566b.2
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 04:39:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787139566; cv=none;
 d=google.com; s=arc-20260327;
 b=pDrOoWY+MHLDY4c/TxB8e2c228hVA57H3cg6Xh2UkARtFBfzlbt7HpZ29O+/MdWruQ
 uMs7sHP9vyGC1RhOM+whY7CBxuU/eTt37mONdBAMwGVtkCRu+sEyiddG8R6RkzbbT9JX
 GepfTAiVxUdeI0JrudwmtbN4chGi3iMsd9GTaGMbPyLUtrFfsyVHDPeBR6H3LSVnI6LD
 iTwyeYyDybBjJvsj2IAZJUHjJGwEnA4mPxsuN3bXO5xP6tlmXzKrjGQZvswwN6JzOqeK
 Lt2V3l3AtMu7xQcyf32rJFc8BqF6YXGYfvOf9NB7ycFiEABdxwiPs8sunMa6o7Pscp8f
 75qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Gc8ncfJno1KdwpV4QvnsIkk9zOT4lH59QCT++zk4dwc=;
 fh=QWNbaIaVQQou6IzIMV0ib5reMaT/Wr3DV7egi1JIcps=;
 b=XmoxV3Ich6FD1HMCTsu68w+ROvRDDao//ic4R22+klNFXQxBNjiYJ/i1Yt5sB/t8jZ
 JeVVoV2H0LI6Q7OFR2++eqPM/A9aNnK26V3hMAuhviLHDy4eKtU5hS8CG3Ld9NKjBnQW
 VS1KxgUhym6ilY+CRnKIKUZZ4VJr89f9WL8ojiqRMqXh0x/UjWqu/mu1/cL2zWSR4nmE
 Yqp9EKPN9lBLGsmtmnb1S3VhUZKWoZtT+F4aMkrhBdjglYmd8VZbxWUn+9P7KpnS1gxG
 itNuBv660Yd0eqOX1w6iClWlPyvGbqMiGtUB0POkm7cE3D1ac5tV+jF795DsxAbS2Zta
 8NbQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google; t=1787139566; x=1787744366; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Gc8ncfJno1KdwpV4QvnsIkk9zOT4lH59QCT++zk4dwc=;
 b=ZzvPFysIrM+MPRSdiy0n2AyAU7nj6cRtUu0pSJKQS1v/GVqJha5x0MOsQlttNu0PCP
 7wEa0HRQlhCvf8suL1JkelmSRfh2Jq3p9ON8epiTY2oKXZnoRKQNLKsRL5V6A4ZQfrx4
 TDdKxnY+Q9j6VEhHpkt/AyUo43g1cf5oun+zKvpHRfT/qc+07CIusOdXdqDtKT5O0oEU
 CTfi4JJNqzeKLnsnUGURwJ+HmJuC2JAiV4U0W6eERuOyO4MAllUcAKuX9QRK6EBXn1Vu
 29Kq+98M9SbTZcx9kv/4lxxG0TlC6BuETZmG/QH2Eiv6LwXdDTWwtSBk7HIAkQ0kugGW
 MJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787139566; x=1787744366;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Gc8ncfJno1KdwpV4QvnsIkk9zOT4lH59QCT++zk4dwc=;
 b=k7y6dsSkQDrYaEnaVbUHg6FUSqrKOWSZRuu9RXZxtH4CmYO9Ewyfa34u2UQMC8oti6
 PNynCWe9a1Mv41SNbzKgPcUgqbHHJTcLTSZIdry6uX1ysi/jfoOKRUn/rO8T+uCmNOBc
 tzOKUDG2IfShynsbsUYksS03eylIYctrURgyqnSD9OYZqL95u0lByi+Oa/6yDUmZYUiU
 nNUmz/x+M+6fFS/UHb7puzX9yfNDjm0F4XyOOs2cdkHnDlGLFFh/tCiDpPqtYccCooAU
 Vj6HN/TQw6jyKI8Q69A3R3fj3qMEp43oy+Hzpg9urTeyOY6nVTw/KWg7IyNU6qOvxKgr
 m3/A==
X-Gm-Message-State: AOJu0Yyu07CG7O0u5m1YTsR2zp5Loeq7oFCDNLLoLZHxWhdagSz+oJp2
 FVtCXrZSk3ITnundmMuRvtoHoJ2aqrhZNouYVqR1Pd6TaJkwITY8/Ig3N+IVPfkBpsFSE7t0kJR
 7NGzlt2qjb6H9+2zlyHmfLTER8qkKw2evAxoQbKNVqQ==
X-Gm-Gg: AR+sD10tAHqyGBh6/k+GrLn+JjyYF6vvF8qoCm2jbc+YTeYtcJ6yU2H4zJ/O+TfnoKp
 qVupDYrk15Acwo2xX5OJzQZ6EcATsXtx7kNPfPlCEjpidDG6g3loeVMgOf/AEQewIlDiJwdy+Wp
 x1/22Nw8EvLeU9h9cCAa0DFH522r4UIq0V9gpgTSnsIgGx4kdXoXLoyJfJNylymqq4wuSIX841V
 6NLfm7otv6eK4xhW1rtVyF9wH40whAJ36CCZRAoVK2tmh/PQQlVxd9vILXRy3PuPH5wzP8M9KzU
 uZreEGF0Nhkc827iY4qDYJdBGmGM7GOR20k1ly3do88ZrUtk4URqXH0=
X-Received: by 2002:a17:907:6d21:b0:c21:7bf1:2c88 with SMTP id
 a640c23a62f3a-c242e204bddmr134323166b.2.1787139565947; Wed, 19 Aug 2026
 04:39:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260817202424.2901438-1-peterx@redhat.com>
 <20260817202424.2901438-4-peterx@redhat.com>
In-Reply-To: <20260817202424.2901438-4-peterx@redhat.com>
From: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date: Wed, 19 Aug 2026 13:39:14 +0200
X-Gm-Features: AcwNN1X49EYRsjftH7oFNnF4W3f2sAq__RPKDsDJuN_Rv30jZlup55M2HjECQg8
Message-ID: <CAMGffEnbc6Fc8EhOqiT=vz2B_8-LZ2Q1Lp4GwBUTnzS_REMnTA@mail.gmail.com>
Subject: Re: [PATCH 03/10] migration/rdma: Stick with rdma_ prefix for all
 tracepoints
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@fujitsu.com>, 
 Samuel Zhang <guoqing.zhang@amd.com>, Fabiano Rosas <farosas@suse.de>, 
 Juraj Marcin <jmarcin@redhat.com>, Yanfei Xu <yanfei.xu@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:20::62d;
 envelope-from=jinpu.wang@ionos.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 19 Aug 2026 08:43:31 -0400
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

On Mon, Aug 17, 2026 at 10:24=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote=
:
>
> There're a bunch of RDMA tracepoints that are prefixed with "rdma_*", mos=
t
> of the rest with "qemu_rdma_*".  Align them up.  The "qemu_" prefix isn't
> helping.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  migration/rdma.c       | 76 +++++++++++++++++++++---------------------
>  migration/trace-events | 76 +++++++++++++++++++++---------------------
>  2 files changed, 76 insertions(+), 76 deletions(-)
>
> diff --git a/migration/rdma.c b/migration/rdma.c
> index eae4afd6df..ffae0a887f 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -631,7 +631,7 @@ static void qemu_rdma_init_ram_blocks(RDMAContext *rd=
ma)
>      memset(local, 0, sizeof *local);
>      ret =3D foreach_not_ignored_block(qemu_rdma_init_one_block, rdma);
>      assert(!ret);
> -    trace_qemu_rdma_init_ram_blocks(local->nb_blocks);
> +    trace_rdma_init_ram_blocks(local->nb_blocks);
>      rdma->dest_blocks =3D g_new0(RDMADestBlock,
>                                 rdma->local_ram_blocks.nb_blocks);
>      local->init =3D true;
> @@ -734,11 +734,11 @@ static void qemu_rdma_dump_id(const char *who, stru=
ct ibv_context *verbs)
>      struct ibv_port_attr port;
>
>      if (ibv_query_port(verbs, 1, &port)) {
> -        trace_qemu_rdma_dump_id_failed(who);
> +        trace_rdma_dump_id_failed(who);
>          return;
>      }
>
> -    trace_qemu_rdma_dump_id(who,
> +    trace_rdma_dump_id(who,
>                  verbs->device->name,
>                  verbs->device->dev_name,
>                  verbs->device->dev_path,
> @@ -759,7 +759,7 @@ static void qemu_rdma_dump_gid(const char *who, struc=
t rdma_cm_id *id)
>      char dgid[33];
>      inet_ntop(AF_INET6, &id->route.addr.addr.ibaddr.sgid, sgid, sizeof s=
gid);
>      inet_ntop(AF_INET6, &id->route.addr.addr.ibaddr.dgid, dgid, sizeof d=
gid);
> -    trace_qemu_rdma_dump_gid(who, sgid, dgid);
> +    trace_rdma_dump_gid(who, sgid, dgid);
>  }
>
>  /*
> @@ -809,7 +809,7 @@ static int qemu_rdma_resolve_host(RDMAContext *rdma, =
Error **errp)
>
>          inet_ntop(e->ai_family,
>              &((struct sockaddr_in *) e->ai_dst_addr)->sin_addr, ip, size=
of ip);
> -        trace_qemu_rdma_resolve_host_trying(rdma->host, ip);
> +        trace_rdma_resolve_host_trying(rdma->host, ip);
>
>          ret =3D rdma_resolve_addr(rdma->cm_id, NULL, e->ai_dst_addr,
>                  RDMA_RESOLVE_TIMEOUT_MS);
> @@ -998,7 +998,7 @@ static void qemu_rdma_advise_prefetch_mr(struct ibv_p=
d *pd, uint64_t addr,
>      ret =3D ibv_advise_mr(pd, advice,
>                          IBV_ADVISE_MR_FLAG_FLUSH, &sg_list, 1);
>      /* ignore the error */
> -    trace_qemu_rdma_advise_mr(name, len, addr, strerror(ret));
> +    trace_rdma_advise_mr(name, len, addr, strerror(ret));
>  #endif
>  }
>
> @@ -1029,7 +1029,7 @@ static int qemu_rdma_reg_whole_ram_blocks(RDMAConte=
xt *rdma, Error **errp)
>                      ibv_reg_mr(rdma->pd,
>                                 local->block[i].local_host_addr,
>                                 local->block[i].length, access);
> -                trace_qemu_rdma_register_odp_mr(local->block[i].block_na=
me);
> +                trace_rdma_register_odp_mr(local->block[i].block_name);
>
>                  if (local->block[i].mr) {
>                      qemu_rdma_advise_prefetch_mr(rdma->pd,
> @@ -1125,7 +1125,7 @@ static int qemu_rdma_register_and_get_keys(RDMACont=
ext *rdma,
>          int access =3D rkey ? IBV_ACCESS_LOCAL_WRITE | IBV_ACCESS_REMOTE=
_WRITE :
>                       0;
>
> -        trace_qemu_rdma_register_and_get_keys(len, chunk_start);
> +        trace_rdma_register_and_get_keys(len, chunk_start);
>
>          block->pmr[chunk] =3D ibv_reg_mr(rdma->pd, chunk_start, len, acc=
ess);
>          /*
> @@ -1139,7 +1139,7 @@ static int qemu_rdma_register_and_get_keys(RDMACont=
ext *rdma,
>              access |=3D IBV_ACCESS_ON_DEMAND;
>              /* register ODP mr */
>              block->pmr[chunk] =3D ibv_reg_mr(rdma->pd, chunk_start, len,=
 access);
> -            trace_qemu_rdma_register_odp_mr(block->block_name);
> +            trace_rdma_register_odp_mr(block->block_name);
>
>              if (block->pmr[chunk]) {
>                  qemu_rdma_advise_prefetch_mr(rdma->pd, (uintptr_t)chunk_=
start,
> @@ -1221,7 +1221,7 @@ static int qemu_rdma_poll(RDMAContext *rdma, struct=
 ibv_cq *cq,
>
>      if (rdma->control_ready_expected &&
>          (wr_id >=3D RDMA_WRID_RECV_CONTROL)) {
> -        trace_qemu_rdma_poll_recv(wr_id - RDMA_WRID_RECV_CONTROL, wr_id,
> +        trace_rdma_poll_recv(wr_id - RDMA_WRID_RECV_CONTROL, wr_id,
>                                    rdma->nb_sent);
>          rdma->control_ready_expected =3D 0;
>      }
> @@ -1233,7 +1233,7 @@ static int qemu_rdma_poll(RDMAContext *rdma, struct=
 ibv_cq *cq,
>              (wc.wr_id & RDMA_WRID_BLOCK_MASK) >> RDMA_WRID_BLOCK_SHIFT;
>          RDMALocalBlock *block =3D &(rdma->local_ram_blocks.block[index])=
;
>
> -        trace_qemu_rdma_poll_write(wr_id, rdma->nb_sent,
> +        trace_rdma_poll_write(wr_id, rdma->nb_sent,
>                                     index, chunk, block->local_host_addr,
>                                     (void *)(uintptr_t)block->remote_host=
_addr);
>
> @@ -1243,7 +1243,7 @@ static int qemu_rdma_poll(RDMAContext *rdma, struct=
 ibv_cq *cq,
>              rdma->nb_sent--;
>          }
>      } else {
> -        trace_qemu_rdma_poll_other(wr_id, rdma->nb_sent);
> +        trace_rdma_poll_other(wr_id, rdma->nb_sent);
>      }
>
>      *wr_id_out =3D wc.wr_id;
> @@ -1378,7 +1378,7 @@ static int qemu_rdma_block_for_wrid(RDMAContext *rd=
ma,
>              break;
>          }
>          if (wr_id !=3D wrid_requested) {
> -            trace_qemu_rdma_block_for_wrid_miss(wrid_requested, wr_id);
> +            trace_rdma_block_for_wrid_miss(wrid_requested, wr_id);
>          }
>      }
>
> @@ -1415,7 +1415,7 @@ static int qemu_rdma_block_for_wrid(RDMAContext *rd=
ma,
>                  break;
>              }
>              if (wr_id !=3D wrid_requested) {
> -                trace_qemu_rdma_block_for_wrid_miss(wrid_requested, wr_i=
d);
> +                trace_rdma_block_for_wrid_miss(wrid_requested, wr_id);
>              }
>          }
>
> @@ -1463,7 +1463,7 @@ static int qemu_rdma_post_send_control(RDMAContext =
*rdma, uint8_t *buf,
>                                     .num_sge =3D 1,
>                                  };
>
> -    trace_qemu_rdma_post_send_control(control_desc(head->type));
> +    trace_rdma_post_send_control(control_desc(head->type));
>
>      /*
>       * We don't actually need to do a memcpy() in here if we used
> @@ -1546,10 +1546,10 @@ static int qemu_rdma_exchange_get_response(RDMACo=
ntext *rdma,
>      network_to_control((void *) rdma->wr_data[idx].control);
>      memcpy(head, rdma->wr_data[idx].control, sizeof(RDMAControlHeader));
>
> -    trace_qemu_rdma_exchange_get_response_start(control_desc(expecting))=
;
> +    trace_rdma_exchange_get_response_start(control_desc(expecting));
>
>      if (expecting =3D=3D RDMA_CONTROL_NONE) {
> -        trace_qemu_rdma_exchange_get_response_none(control_desc(head->ty=
pe),
> +        trace_rdma_exchange_get_response_none(control_desc(head->type),
>                                               head->type);
>      } else if (head->type !=3D expecting || head->type =3D=3D RDMA_CONTR=
OL_ERROR) {
>          error_setg(errp, "Was expecting a %s (%d) control message"
> @@ -1659,14 +1659,14 @@ static int qemu_rdma_exchange_send(RDMAContext *r=
dma, RDMAControlHeader *head,
>       */
>      if (resp) {
>          if (callback) {
> -            trace_qemu_rdma_exchange_send_issue_callback();
> +            trace_rdma_exchange_send_issue_callback();
>              ret =3D callback(rdma, errp);
>              if (ret < 0) {
>                  return -1;
>              }
>          }
>
> -        trace_qemu_rdma_exchange_send_waiting(control_desc(resp->type));
> +        trace_rdma_exchange_send_waiting(control_desc(resp->type));
>          ret =3D qemu_rdma_exchange_get_response(rdma, resp,
>                                                resp->type, RDMA_WRID_DATA=
,
>                                                errp);
> @@ -1679,7 +1679,7 @@ static int qemu_rdma_exchange_send(RDMAContext *rdm=
a, RDMAControlHeader *head,
>          if (resp_idx) {
>              *resp_idx =3D RDMA_WRID_DATA;
>          }
> -        trace_qemu_rdma_exchange_send_received(control_desc(resp->type))=
;
> +        trace_rdma_exchange_send_received(control_desc(resp->type));
>      }
>
>      rdma->control_ready_expected =3D 1;
> @@ -1782,7 +1782,7 @@ retry:
>          }
>      }
>
> -    trace_qemu_rdma_write_one_top(chunks + 1,
> +    trace_rdma_write_one_top(chunks + 1,
>                                    (chunks + 1) * chunk_size / 1024 / 102=
4);
>
>      chunk_end =3D ram_chunk_end(block, chunk + chunks);
> @@ -1790,7 +1790,7 @@ retry:
>
>      while (test_bit(chunk, block->transit_bitmap)) {
>          (void)count;
> -        trace_qemu_rdma_write_one_block(count++, current_index, chunk,
> +        trace_rdma_write_one_block(count++, current_index, chunk,
>                  sge.addr, length, rdma->nb_sent, block->nb_chunks);
>
>          ret =3D qemu_rdma_block_for_wrid(rdma, RDMA_WRID_RDMA_WRITE, NUL=
L);
> @@ -1823,7 +1823,7 @@ retry:
>                  head.len =3D sizeof(comp);
>                  head.type =3D RDMA_CONTROL_COMPRESS;
>
> -                trace_qemu_rdma_write_one_zero(chunk, sge.length,
> +                trace_rdma_write_one_zero(chunk, sge.length,
>                                                 current_index, current_ad=
dr);
>
>                  compress_to_network(rdma, &comp);
> @@ -1860,7 +1860,7 @@ retry:
>              }
>              reg.chunks =3D chunks;
>
> -            trace_qemu_rdma_write_one_sendreg(chunk, sge.length, current=
_index,
> +            trace_rdma_write_one_sendreg(chunk, sge.length, current_inde=
x,
>                                                current_addr);
>
>              register_to_network(rdma, &reg);
> @@ -1883,7 +1883,7 @@ retry:
>
>              network_to_result(reg_result);
>
> -            trace_qemu_rdma_write_one_recvregres(block->remote_keys[chun=
k],
> +            trace_rdma_write_one_recvregres(block->remote_keys[chunk],
>                                                   reg_result->rkey, chunk=
);
>
>              block->remote_keys[chunk] =3D reg_result->rkey;
> @@ -1926,7 +1926,7 @@ retry:
>      send_wr.wr.rdma.remote_addr =3D block->remote_host_addr +
>                                  (current_addr - block->offset);
>
> -    trace_qemu_rdma_write_one_post(chunk, sge.addr, send_wr.wr.rdma.remo=
te_addr,
> +    trace_rdma_write_one_post(chunk, sge.addr, send_wr.wr.rdma.remote_ad=
dr,
>                                     sge.length);
>
>      /*
> @@ -1936,7 +1936,7 @@ retry:
>      ret =3D ibv_post_send(rdma->qp, &send_wr, &bad_wr);
>
>      if (ret =3D=3D ENOMEM) {
> -        trace_qemu_rdma_write_one_queue_full();
> +        trace_rdma_write_one_queue_full();
>          ret =3D qemu_rdma_block_for_wrid(rdma, RDMA_WRID_RDMA_WRITE, NUL=
L);
>          if (ret < 0) {
>              error_setg(errp, "rdma migration: failed to make "
> @@ -1993,7 +1993,7 @@ static int qemu_rdma_write_flush(RDMAContext *rdma,=
 Error **errp)
>
>      if (ret =3D=3D 0) {
>          rdma->nb_sent++;
> -        trace_qemu_rdma_write_flush(rdma->nb_sent);
> +        trace_rdma_write_flush(rdma->nb_sent);
>      }
>
>      rdma->current_length =3D 0;
> @@ -2109,7 +2109,7 @@ static void qemu_rdma_cleanup(RDMAContext *rdma)
>          }
>
>          rdma_disconnect(rdma->cm_id);
> -        trace_qemu_rdma_cleanup_disconnect();
> +        trace_rdma_cleanup_disconnect();
>          rdma->connected =3D false;
>      }
>
> @@ -2292,7 +2292,7 @@ static int qemu_rdma_connect(RDMAContext *rdma, boo=
l return_path,
>       * on the source first requested the capability.
>       */
>      if (rdma->pin_all) {
> -        trace_qemu_rdma_connect_pin_all_requested();
> +        trace_rdma_connect_pin_all_requested();
>          cap.flags |=3D RDMA_CAPABILITY_PIN_ALL;
>      }
>
> @@ -2343,7 +2343,7 @@ static int qemu_rdma_connect(RDMAContext *rdma, boo=
l return_path,
>          rdma->pin_all =3D false;
>      }
>
> -    trace_qemu_rdma_connect_pin_all_outcome(rdma->pin_all);
> +    trace_rdma_connect_pin_all_outcome(rdma->pin_all);
>
>      rdma_ack_cm_event(cm_event);
>
> @@ -2412,7 +2412,7 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, E=
rror **errp)
>
>          inet_ntop(e->ai_family,
>              &((struct sockaddr_in *) e->ai_dst_addr)->sin_addr, ip, size=
of ip);
> -        trace_qemu_rdma_dest_init_trying(rdma->host, ip);
> +        trace_rdma_dest_init_trying(rdma->host, ip);
>          ret =3D rdma_bind_addr(listen_id, e->ai_dst_addr);
>          if (ret < 0) {
>              continue;
> @@ -2547,7 +2547,7 @@ static size_t qemu_rdma_fill(RDMAContext *rdma, uin=
t8_t *buf,
>      size_t len =3D 0;
>
>      if (rdma->wr_data[idx].control_len) {
> -        trace_qemu_rdma_fill(rdma->wr_data[idx].control_len, size);
> +        trace_rdma_fill(rdma->wr_data[idx].control_len, size);
>
>          len =3D MIN(size, rdma->wr_data[idx].control_len);
>          memcpy(buf, rdma->wr_data[idx].control_curr, len);
> @@ -2859,7 +2859,7 @@ static int qio_channel_rdma_close(QIOChannel *ioc,
>      RDMAContext *rdmain, *rdmaout;
>      struct rdma_close_rcu *rcu =3D g_new(struct rdma_close_rcu, 1);
>
> -    trace_qemu_rdma_close();
> +    trace_rdma_close();
>
>      rdmain =3D rioc->rdmain;
>      if (rdmain) {
> @@ -3132,11 +3132,11 @@ static int qemu_rdma_accept(RDMAContext *rdma)
>
>      rdma_ack_cm_event(cm_event);
>
> -    trace_qemu_rdma_accept_pin_state(rdma->pin_all);
> +    trace_rdma_accept_pin_state(rdma->pin_all);
>
>      caps_to_network(&cap);
>
> -    trace_qemu_rdma_accept_pin_verbsc(verbs);
> +    trace_rdma_accept_pin_verbsc(verbs);
>
>      if (!rdma->verbs) {
>          rdma->verbs =3D verbs;
> @@ -3727,13 +3727,13 @@ static void rdma_accept_incoming_migration(void *=
opaque)
>      RDMAContext *rdma =3D opaque;
>      QIOChannel *ioc;
>
> -    trace_qemu_rdma_accept_incoming_migration();
> +    trace_rdma_accept_incoming_migration();
>      if (qemu_rdma_accept(rdma) < 0) {
>          error_report("RDMA ERROR: Migration initialization failed");
>          return;
>      }
>
> -    trace_qemu_rdma_accept_incoming_migration_accepted();
> +    trace_rdma_accept_incoming_migration_accepted();
>
>      if (rdma->is_return_path) {
>          return;
> diff --git a/migration/trace-events b/migration/trace-events
> index d1fe8f1382..d0ad736c8c 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -214,44 +214,44 @@ migrate_global_state_post_load(const char *state) "=
loaded state: %s"
>  migrate_global_state_pre_save(const char *state) "saved state: %s"
>
>  # rdma.c
> -qemu_rdma_accept_incoming_migration(void) ""
> -qemu_rdma_accept_incoming_migration_accepted(void) ""
> -qemu_rdma_accept_pin_state(bool pin) "%d"
> -qemu_rdma_accept_pin_verbsc(void *verbs) "Verbs context after listen: %p=
"
> -qemu_rdma_block_for_wrid_miss(uint64_t wcomp, uint64_t req) "A Wanted wr=
id %" PRIu64 " but got %" PRIu64
> -qemu_rdma_cleanup_disconnect(void) ""
> -qemu_rdma_close(void) ""
> -qemu_rdma_connect_pin_all_requested(void) ""
> -qemu_rdma_connect_pin_all_outcome(bool pin) "%d"
> -qemu_rdma_dest_init_trying(const char *host, const char *ip) "%s =3D> %s=
"
> -qemu_rdma_dump_id_failed(const char *who) "%s RDMA Device opened, but ca=
n't query port information"
> -qemu_rdma_dump_id(const char *who, const char *name, const char *dev_nam=
e, const char *dev_path, const char *ibdev_path, int transport, const char =
*transport_name) "%s RDMA Device opened: kernel name %s uverbs device name =
%s, infiniband_verbs class device path %s, infiniband class device path %s,=
 transport: (%d) %s"
> -qemu_rdma_dump_gid(const char *who, const char *src, const char *dst) "%=
s Source GID: %s, Dest GID: %s"
> -qemu_rdma_exchange_get_response_start(const char *desc) "CONTROL: %s rec=
eiving..."
> -qemu_rdma_exchange_get_response_none(const char *desc, int type) "Surpri=
se: got %s (%d)"
> -qemu_rdma_exchange_send_issue_callback(void) ""
> -qemu_rdma_exchange_send_waiting(const char *desc) "Waiting for response =
%s"
> -qemu_rdma_exchange_send_received(const char *desc) "Response %s received=
."
> -qemu_rdma_fill(size_t control_len, size_t size) "RDMA %zd of %zd bytes a=
lready in buffer"
> -qemu_rdma_init_ram_blocks(int blocks) "Allocated %d local ram block stru=
ctures"
> -qemu_rdma_poll_recv(uint64_t comp, int64_t id, int sent) "completion %" =
PRIu64 " received (%" PRId64 ") left %d"
> -qemu_rdma_poll_write(uint64_t comp, int left, uint64_t block, uint64_t c=
hunk, void *local, void *remote) "completions %" PRIu64 " left %d, block %"=
 PRIu64 ", chunk: %" PRIu64 " %p %p"
> -qemu_rdma_poll_other(uint64_t comp, int left) "other completion %" PRIu6=
4 " received left %d"
> -qemu_rdma_post_send_control(const char *desc) "CONTROL: sending %s.."
> -qemu_rdma_register_and_get_keys(uint64_t len, void *start) "Registering =
%" PRIu64 " bytes @ %p"
> -qemu_rdma_register_odp_mr(const char *name) "Try to register On-Demand P=
aging memory region: %s"
> -qemu_rdma_advise_mr(const char *name, uint32_t len, uint64_t addr, const=
 char *res) "Try to advise block %s prefetch at %" PRIu32 "@0x%" PRIx64 ": =
%s"
> -qemu_rdma_resolve_host_trying(const char *host, const char *ip) "Trying =
%s =3D> %s"
> -qemu_rdma_signal_unregister_append(uint64_t chunk, int pos) "Appending u=
nregister chunk %" PRIu64 " at position %d"
> -qemu_rdma_signal_unregister_already(uint64_t chunk) "Unregister chunk %"=
 PRIu64 " already in queue"
> -qemu_rdma_write_flush(int sent) "sent total: %d"
> -qemu_rdma_write_one_block(int count, int block, uint64_t chunk, uint64_t=
 current, uint64_t len, int nb_sent, int nb_chunks) "(%d) Not clobbering: b=
lock: %d chunk %" PRIu64 " current %" PRIu64 " len %" PRIu64 " %d %d"
> -qemu_rdma_write_one_post(uint64_t chunk, long addr, long remote, uint32_=
t len) "Posting chunk: %" PRIu64 ", addr: 0x%lx remote: 0x%lx, bytes %" PRI=
u32
> -qemu_rdma_write_one_queue_full(void) ""
> -qemu_rdma_write_one_recvregres(int mykey, int theirkey, uint64_t chunk) =
"Received registration result: my key: 0x%x their key 0x%x, chunk %" PRIu64
> -qemu_rdma_write_one_sendreg(uint64_t chunk, int len, int index, int64_t =
offset) "Sending registration request chunk %" PRIu64 " for %d bytes, index=
: %d, offset: %" PRId64
> -qemu_rdma_write_one_top(uint64_t chunks, uint64_t size) "Writing %" PRIu=
64 " chunks, (%" PRIu64 " MB)"
> -qemu_rdma_write_one_zero(uint64_t chunk, int len, int index, int64_t off=
set) "Entire chunk is zero, sending compress: %" PRIu64 " for %d bytes, ind=
ex: %d, offset: %" PRId64
> +rdma_accept_incoming_migration(void) ""
> +rdma_accept_incoming_migration_accepted(void) ""
> +rdma_accept_pin_state(bool pin) "%d"
> +rdma_accept_pin_verbsc(void *verbs) "Verbs context after listen: %p"
> +rdma_block_for_wrid_miss(uint64_t wcomp, uint64_t req) "A Wanted wrid %"=
 PRIu64 " but got %" PRIu64
> +rdma_cleanup_disconnect(void) ""
> +rdma_close(void) ""
> +rdma_connect_pin_all_requested(void) ""
> +rdma_connect_pin_all_outcome(bool pin) "%d"
> +rdma_dest_init_trying(const char *host, const char *ip) "%s =3D> %s"
> +rdma_dump_id_failed(const char *who) "%s RDMA Device opened, but can't q=
uery port information"
> +rdma_dump_id(const char *who, const char *name, const char *dev_name, co=
nst char *dev_path, const char *ibdev_path, int transport, const char *tran=
sport_name) "%s RDMA Device opened: kernel name %s uverbs device name %s, i=
nfiniband_verbs class device path %s, infiniband class device path %s, tran=
sport: (%d) %s"
> +rdma_dump_gid(const char *who, const char *src, const char *dst) "%s Sou=
rce GID: %s, Dest GID: %s"
> +rdma_exchange_get_response_start(const char *desc) "CONTROL: %s receivin=
g..."
> +rdma_exchange_get_response_none(const char *desc, int type) "Surprise: g=
ot %s (%d)"
> +rdma_exchange_send_issue_callback(void) ""
> +rdma_exchange_send_waiting(const char *desc) "Waiting for response %s"
> +rdma_exchange_send_received(const char *desc) "Response %s received."
> +rdma_fill(size_t control_len, size_t size) "RDMA %zd of %zd bytes alread=
y in buffer"
> +rdma_init_ram_blocks(int blocks) "Allocated %d local ram block structure=
s"
> +rdma_poll_recv(uint64_t comp, int64_t id, int sent) "completion %" PRIu6=
4 " received (%" PRId64 ") left %d"
> +rdma_poll_write(uint64_t comp, int left, uint64_t block, uint64_t chunk,=
 void *local, void *remote) "completions %" PRIu64 " left %d, block %" PRIu=
64 ", chunk: %" PRIu64 " %p %p"
> +rdma_poll_other(uint64_t comp, int left) "other completion %" PRIu64 " r=
eceived left %d"
> +rdma_post_send_control(const char *desc) "CONTROL: sending %s.."
> +rdma_register_and_get_keys(uint64_t len, void *start) "Registering %" PR=
Iu64 " bytes @ %p"
> +rdma_register_odp_mr(const char *name) "Try to register On-Demand Paging=
 memory region: %s"
> +rdma_advise_mr(const char *name, uint32_t len, uint64_t addr, const char=
 *res) "Try to advise block %s prefetch at %" PRIu32 "@0x%" PRIx64 ": %s"
> +rdma_resolve_host_trying(const char *host, const char *ip) "Trying %s =
=3D> %s"
> +rdma_signal_unregister_append(uint64_t chunk, int pos) "Appending unregi=
ster chunk %" PRIu64 " at position %d"
> +rdma_signal_unregister_already(uint64_t chunk) "Unregister chunk %" PRIu=
64 " already in queue"
> +rdma_write_flush(int sent) "sent total: %d"
> +rdma_write_one_block(int count, int block, uint64_t chunk, uint64_t curr=
ent, uint64_t len, int nb_sent, int nb_chunks) "(%d) Not clobbering: block:=
 %d chunk %" PRIu64 " current %" PRIu64 " len %" PRIu64 " %d %d"
> +rdma_write_one_post(uint64_t chunk, long addr, long remote, uint32_t len=
) "Posting chunk: %" PRIu64 ", addr: 0x%lx remote: 0x%lx, bytes %" PRIu32
> +rdma_write_one_queue_full(void) ""
> +rdma_write_one_recvregres(int mykey, int theirkey, uint64_t chunk) "Rece=
ived registration result: my key: 0x%x their key 0x%x, chunk %" PRIu64
> +rdma_write_one_sendreg(uint64_t chunk, int len, int index, int64_t offse=
t) "Sending registration request chunk %" PRIu64 " for %d bytes, index: %d,=
 offset: %" PRId64
> +rdma_write_one_top(uint64_t chunks, uint64_t size) "Writing %" PRIu64 " =
chunks, (%" PRIu64 " MB)"
> +rdma_write_one_zero(uint64_t chunk, int len, int index, int64_t offset) =
"Entire chunk is zero, sending compress: %" PRIu64 " for %d bytes, index: %=
d, offset: %" PRId64
>  rdma_add_block(const char *block_name, int block, uint64_t addr, uint64_=
t offset, uint64_t len, uint64_t end, uint64_t bits, int chunks) "Added Blo=
ck: '%s':%d, addr: %" PRIu64 ", offset: %" PRIu64 " length: %" PRIu64 " end=
: %" PRIu64 " bits %" PRIu64 " chunks %d"
>  rdma_block_notification_handle(const char *name, int index) "%s at %d"
>  rdma_delete_block(void *block, uint64_t addr, uint64_t offset, uint64_t =
len, uint64_t end, uint64_t bits, int chunks) "Deleted Block: %p, addr: %" =
PRIu64 ", offset: %" PRIu64 " length: %" PRIu64 " end: %" PRIu64 " bits %" =
PRIu64 " chunks %d"
> --
> 2.54.0
>

