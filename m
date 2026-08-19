Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4003EC5DF88
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 12:43:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwfdk-0007zs-Rb; Wed, 19 Aug 2026 08:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1wwduk-0003Rg-5g
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 06:52:58 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1wwduh-0005Yx-QF
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 06:52:57 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c160875e029so10041666b.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 03:52:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787136774; cv=none;
 d=google.com; s=arc-20260327;
 b=T3BXcqINpaHIISRCRU1Qy5+iJ2YdTn1zHgaZUghUq9it0laRry+P4P/5N42JC2eAS9
 sQf0nBgGW/dR+TWDjRXvAxck9ExpvEqAPj3u4UXly36wO1vqUJados31VbYRrMVHDJdm
 UiSk37Lrpr9VRci5mdi1UXBgVpcfKxdI9Zjy+SDqnhEMsNF8dp/EQjVWBMwmtRCU2jRy
 d5TdaV+553GgSWmh/hw1g5V5AJ4yikB8HN7cLXZF78oukiHttq+dCvxW9FadYFUQ+UXI
 SbkAesIBPI6kU8Ju9jqWze+IVMohPhVGDjJjXy6P1i82ZWvdg/7YfNGsQ27OuUSgSD2t
 KNUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TUIYKp09R6/BBSwGKg0LjQ8ZoHzOAkFoePrXLYRdWgc=;
 fh=QWNbaIaVQQou6IzIMV0ib5reMaT/Wr3DV7egi1JIcps=;
 b=e6wEjGy/YuWo3fxSwUoeYjkEfPsH0CNE0a0VhuX3qY9GDelASOOMi4KaGrnLtojmsy
 4NR5cETk4X+mEYeEQrmWt9w1LVmfXYpFcCGrq+ugvmODXzD6gbq2HNE+fss3fu/PG1PO
 gUZZUoSDg9rgK28a/fjIdeXGLHu3uJYuTq+H/6CqdXOsxtsoHpHUxMxjt2q0ZU5QoId8
 U9ATlGSOIu3nR5cafH9CDnZLmGasbPlRKAXPf/XzAFcWqcnBC+hAEfVjEILFeSAxmDBW
 Py8b6J2Z45ARHb+IWA9IJXyc7lP3Mnw2bxS79yJX3gnkobOqXosdAe9vNoUnDAeuOflS
 rqEQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google; t=1787136774; x=1787741574; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TUIYKp09R6/BBSwGKg0LjQ8ZoHzOAkFoePrXLYRdWgc=;
 b=fR5B95LzDomRcT9aa6EvbiWvg6+8GoPHEekhbIcK8PlSs0+94d60OLMBTd8/67Sz13
 4Vz88Opmaoy5sBQKwOFJS8qqCO5vejEriIHrYPLoVrqaQwj9euPxfYUUfCyly4zOzBDs
 nfNPd4PbDggJgXR0mpKF+9kg+iPndS3JnLTJQK/PT0sPOceFVHK7mnR/B2+qh1bkDwgv
 uIhcAR0CBtHCuXSugggOsYuDVg6Kpn503fwn+2r0FvH/sEjwcVLtuCqqw0rD0BYFZIHv
 nkj/48J6z1K90Vfb+BMJu+MaaWKXg5OjI/V5K1B8KgPVEO61M4g4BVswAAMqDOKtSt2l
 LnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787136774; x=1787741574;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TUIYKp09R6/BBSwGKg0LjQ8ZoHzOAkFoePrXLYRdWgc=;
 b=AJ1n7sUpFq3LtecPgiHo7/v3QZPYc7VtL8RYkhEfmZXuxTS6ry+Csqzx+6QH/JXsP8
 kU/ox15kKKzJW+DpcVKezVpFwLtS/+rGuXyLQXb+JSzo6Ow5QYuHwo256ZEczR8XYlBe
 7vT79VccjtpLRyTuwGXZyt9Yz2ZP2gwcP4Ec12SX371JoY1zvrTJeGwDtA3M0PxlZ2Gn
 U2CtrwupE99MMivKRZ1UHzKi68UbH646DvHiuXGIsfK1IBZQ87esbO5Q5Rt5A5F9/v3a
 d/j30TemG+0caLM336DJU8+Gxb8mr+xHZ1VhyTadLltnOjEhAJ/hSj6HJrIZNFO2XF2z
 BnzA==
X-Gm-Message-State: AOJu0YyyIgRAKIuqk2OFC+EpeDuYjyzZembCQoQwesROzrZprQERvS3y
 rn9//2C6LhRe6yH5bCd5NRZBlF7V7YGNj16wr+xaaPzB/P+opQpRi4DTDZ5liGELnCcfIi9me+n
 Q+rZZn2Ystjggv7NSyEv/8DMIywiguKJxObSQ/LUxNQ==
X-Gm-Gg: AR+sD10FW9XPjmJw4dL9HTJlIdk50aKtL13KxBs0qRuZs3hstjQE7UgpzHZESp1eK8e
 ffo3V3HXYZUr3QKlNA/nbGYRipFwMI2fI5LJXICQWNADPUFsQ0TN1JGvaths7vnT75M16fzo9yD
 Gwy/hANoir85ajV6CqGA7Rch0axg5MaCGMIECZ1/VasRU4fG0RpmRsefTRQtoqVt6eGAUyq/HGu
 aokv48rrJ+xiK7NEawxygRP34Q4BlOTDu7ZWUZt7dLWkrCNo/Wx0UXX18ly/xL4IF1p+juOgGCM
 OPjeqFbrYXTFS0VndMlQ+WysulHr2GpFgoZp4JS6MeAD
X-Received: by 2002:a17:907:97d0:b0:c16:604a:b2bd with SMTP id
 a640c23a62f3a-c242e25f3c9mr122179966b.3.1787136773699; Wed, 19 Aug 2026
 03:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260817202424.2901438-1-peterx@redhat.com>
 <20260817202424.2901438-3-peterx@redhat.com>
In-Reply-To: <20260817202424.2901438-3-peterx@redhat.com>
From: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date: Wed, 19 Aug 2026 12:52:40 +0200
X-Gm-Features: AcwNN1XiYh5-9o1vnu02VNU-KGi-TdSmAKlEk4fzZa_li0WHxjs-uZaNMSEHpO4
Message-ID: <CAMGffEkDar1xw3easr03h0fB0O-Au5VdoJnfyrjiEVgkWmkT3g@mail.gmail.com>
Subject: Re: [PATCH 02/10] migration/rdma: Remove unregister code
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@fujitsu.com>, 
 Samuel Zhang <guoqing.zhang@amd.com>, Fabiano Rosas <farosas@suse.de>, 
 Juraj Marcin <jmarcin@redhat.com>, Yanfei Xu <yanfei.xu@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:20::632;
 envelope-from=jinpu.wang@ionos.com; helo=mail-ej1-x632.google.com
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
> The unregister code was there since the first commit RDMA migration was
> merged, but it was never functioning.  Remove the dead code.
>
> Since the two control messages are the last ones, we don't even need to
> worry about compatibility of legacy RDMA control commands, we can directl=
y
> remove the messages too.
>
> As a side effect, this patch closes a report by removing the code
> completely.
>
> Reported-by: Tristan (@TristanInSec)
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4003
> Signed-off-by: Peter Xu <peterx@redhat.com>
Hi Peter, hi Yanfei,

The change looks fine, and I have also tested to ensure it doesn't
break compatibility with older versions. As already discussed,
removing this code could result in more MRs being used during
migration; however, once the migration is complete, they will be
unregistered, so there is no leak.

Reviewed-by: Jinpu Wang <jinpu.wang@cloud.ionos.com>
> ---
>  migration/rdma.c       | 133 -----------------------------------------
>  migration/trace-events |   7 ---
>  2 files changed, 140 deletions(-)
>
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 62a509b236..eae4afd6df 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -142,8 +142,6 @@ enum {
>      RDMA_CONTROL_REGISTER_REQUEST,    /* dynamic page registration */
>      RDMA_CONTROL_REGISTER_RESULT,     /* key to use after registration *=
/
>      RDMA_CONTROL_REGISTER_FINISHED,   /* current iteration finished */
> -    RDMA_CONTROL_UNREGISTER_REQUEST,  /* dynamic UN-registration */
> -    RDMA_CONTROL_UNREGISTER_FINISHED, /* unpinning finished */
>      RDMA_CONTROL_NUM,
>  };
>
> @@ -232,8 +230,6 @@ static const char *control_desc(unsigned int rdma_con=
trol)
>          [RDMA_CONTROL_REGISTER_REQUEST] =3D "REGISTER REQUEST",
>          [RDMA_CONTROL_REGISTER_RESULT] =3D "REGISTER RESULT",
>          [RDMA_CONTROL_REGISTER_FINISHED] =3D "REGISTER FINISHED",
> -        [RDMA_CONTROL_UNREGISTER_REQUEST] =3D "UNREGISTER REQUEST",
> -        [RDMA_CONTROL_UNREGISTER_FINISHED] =3D "UNREGISTER FINISHED",
>      };
>
>      if (rdma_control >=3D RDMA_CONTROL_NUM) {
> @@ -370,9 +366,6 @@ typedef struct RDMAContext {
>      int total_registrations;
>      int total_writes;
>
> -    int unregister_current, unregister_next;
> -    uint64_t unregistrations[RDMA_SIGNALED_SEND_MAX];
> -
>      GHashTable *blockmap;
>
>      /* the RDMAContext for return path */
> @@ -1186,91 +1179,6 @@ static int qemu_rdma_reg_control(RDMAContext *rdma=
, int idx)
>      return -1;
>  }
>
> -/*
> - * Perform a non-optimized memory unregistration after every transfer
> - * for demonstration purposes, only if pin-all is not requested.
> - *
> - * Potential optimizations:
> - * 1. Start a new thread to run this function continuously
> -        - for bit clearing
> -        - and for receipt of unregister messages
> - * 2. Use an LRU.
> - * 3. Use workload hints.
> - */
> -static int qemu_rdma_unregister_waiting(RDMAContext *rdma)
> -{
> -    Error *err =3D NULL;
> -
> -    while (rdma->unregistrations[rdma->unregister_current]) {
> -        int ret;
> -        uint64_t wr_id =3D rdma->unregistrations[rdma->unregister_curren=
t];
> -        uint64_t chunk =3D
> -            (wr_id & RDMA_WRID_CHUNK_MASK) >> RDMA_WRID_CHUNK_SHIFT;
> -        uint64_t index =3D
> -            (wr_id & RDMA_WRID_BLOCK_MASK) >> RDMA_WRID_BLOCK_SHIFT;
> -        RDMALocalBlock *block =3D
> -            &(rdma->local_ram_blocks.block[index]);
> -        RDMARegister reg =3D { .current_index =3D index };
> -        RDMAControlHeader resp =3D { .type =3D RDMA_CONTROL_UNREGISTER_F=
INISHED,
> -                                 };
> -        RDMAControlHeader head =3D { .len =3D sizeof(RDMARegister),
> -                                   .type =3D RDMA_CONTROL_UNREGISTER_REQ=
UEST,
> -                                   .repeat =3D 1,
> -                                 };
> -
> -        trace_qemu_rdma_unregister_waiting_proc(chunk,
> -                                                rdma->unregister_current=
);
> -
> -        rdma->unregistrations[rdma->unregister_current] =3D 0;
> -        rdma->unregister_current++;
> -
> -        if (rdma->unregister_current =3D=3D RDMA_SIGNALED_SEND_MAX) {
> -            rdma->unregister_current =3D 0;
> -        }
> -
> -
> -        /*
> -         * Unregistration is speculative (because migration is single-th=
readed
> -         * and we cannot break the protocol's inifinband message orderin=
g).
> -         * Thus, if the memory is currently being used for transmission,
> -         * then abort the attempt to unregister and try again
> -         * later the next time a completion is received for this memory.
> -         */
> -        clear_bit(chunk, block->unregister_bitmap);
> -
> -        if (test_bit(chunk, block->transit_bitmap)) {
> -            trace_qemu_rdma_unregister_waiting_inflight(chunk);
> -            continue;
> -        }
> -
> -        trace_qemu_rdma_unregister_waiting_send(chunk);
> -
> -        ret =3D ibv_dereg_mr(block->pmr[chunk]);
> -        block->pmr[chunk] =3D NULL;
> -        block->remote_keys[chunk] =3D 0;
> -
> -        if (ret !=3D 0) {
> -            error_report("unregistration chunk failed: %s",
> -                         strerror(ret));
> -            return -1;
> -        }
> -        rdma->total_registrations--;
> -
> -        reg.key.chunk =3D chunk;
> -        register_to_network(rdma, &reg);
> -        ret =3D qemu_rdma_exchange_send(rdma, &head, (uint8_t *) &reg,
> -                                      &resp, NULL, NULL, &err);
> -        if (ret < 0) {
> -            error_report_err(err);
> -            return -1;
> -        }
> -
> -        trace_qemu_rdma_unregister_waiting_complete(chunk);
> -    }
> -
> -    return 0;
> -}
> -
>  static uint64_t qemu_rdma_make_wrid(uint64_t wr_id, uint64_t index,
>                                           uint64_t chunk)
>  {
> @@ -2757,8 +2665,6 @@ static int qemu_rdma_drain_cq(RDMAContext *rdma)
>          }
>      }
>
> -    qemu_rdma_unregister_waiting(rdma);
> -
>      return 0;
>  }
>
> @@ -3336,10 +3242,6 @@ int rdma_registration_handle(QEMUFile *f)
>                                 .type =3D RDMA_CONTROL_REGISTER_RESULT,
>                                 .repeat =3D 0,
>                               };
> -    RDMAControlHeader unreg_resp =3D { .len =3D 0,
> -                               .type =3D RDMA_CONTROL_UNREGISTER_FINISHE=
D,
> -                               .repeat =3D 0,
> -                             };
>      RDMAControlHeader blocks =3D { .type =3D RDMA_CONTROL_RAM_BLOCKS_RES=
ULT,
>                                   .repeat =3D 1 };
>      QIOChannelRDMA *rioc;
> @@ -3552,41 +3454,6 @@ int rdma_registration_handle(QEMUFile *f)
>              ret =3D qemu_rdma_post_send_control(rdma,
>                              (uint8_t *) results, &reg_resp, &err);
>
> -            if (ret < 0) {
> -                error_report_err(err);
> -                goto err;
> -            }
> -            break;
> -        case RDMA_CONTROL_UNREGISTER_REQUEST:
> -            trace_rdma_registration_handle_unregister(head.repeat);
> -            unreg_resp.repeat =3D head.repeat;
> -            registers =3D (RDMARegister *) rdma->wr_data[idx].control_cu=
rr;
> -
> -            for (int count =3D 0; count < head.repeat; count++) {
> -                reg =3D &registers[count];
> -                network_to_register(reg);
> -
> -                trace_rdma_registration_handle_unregister_loop(count,
> -                           reg->current_index, reg->key.chunk);
> -
> -                block =3D &(rdma->local_ram_blocks.block[reg->current_in=
dex]);
> -
> -                ret =3D ibv_dereg_mr(block->pmr[reg->key.chunk]);
> -                block->pmr[reg->key.chunk] =3D NULL;
> -
> -                if (ret !=3D 0) {
> -                    error_report("rdma unregistration chunk failed: %s",
> -                                 strerror(errno));
> -                    goto err;
> -                }
> -
> -                rdma->total_registrations--;
> -
> -                trace_rdma_registration_handle_unregister_success(reg->k=
ey.chunk);
> -            }
> -
> -            ret =3D qemu_rdma_post_send_control(rdma, NULL, &unreg_resp,=
 &err);
> -
>              if (ret < 0) {
>                  error_report_err(err);
>                  goto err;
> diff --git a/migration/trace-events b/migration/trace-events
> index af0e784535..d1fe8f1382 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -244,10 +244,6 @@ qemu_rdma_advise_mr(const char *name, uint32_t len, =
uint64_t addr, const char *r
>  qemu_rdma_resolve_host_trying(const char *host, const char *ip) "Trying =
%s =3D> %s"
>  qemu_rdma_signal_unregister_append(uint64_t chunk, int pos) "Appending u=
nregister chunk %" PRIu64 " at position %d"
>  qemu_rdma_signal_unregister_already(uint64_t chunk) "Unregister chunk %"=
 PRIu64 " already in queue"
> -qemu_rdma_unregister_waiting_inflight(uint64_t chunk) "Cannot unregister=
 inflight chunk: %" PRIu64
> -qemu_rdma_unregister_waiting_proc(uint64_t chunk, int pos) "Processing u=
nregister for chunk: %" PRIu64 " at position %d"
> -qemu_rdma_unregister_waiting_send(uint64_t chunk) "Sending unregister fo=
r chunk: %" PRIu64
> -qemu_rdma_unregister_waiting_complete(uint64_t chunk) "Unregister for ch=
unk: %" PRIu64 " complete."
>  qemu_rdma_write_flush(int sent) "sent total: %d"
>  qemu_rdma_write_one_block(int count, int block, uint64_t chunk, uint64_t=
 current, uint64_t len, int nb_sent, int nb_chunks) "(%d) Not clobbering: b=
lock: %d chunk %" PRIu64 " current %" PRIu64 " len %" PRIu64 " %d %d"
>  qemu_rdma_write_one_post(uint64_t chunk, long addr, long remote, uint32_=
t len) "Posting chunk: %" PRIu64 ", addr: 0x%lx remote: 0x%lx, bytes %" PRI=
u32
> @@ -266,9 +262,6 @@ rdma_registration_handle_ram_blocks_loop(const char *=
name, uint64_t offset, uint
>  rdma_registration_handle_register(int requests) "%d requests"
>  rdma_registration_handle_register_loop(int req, int index, uint64_t addr=
, uint64_t chunks) "Registration request (%d): index %d, current_addr %" PR=
Iu64 " chunks: %" PRIu64
>  rdma_registration_handle_register_rkey(int rkey) "0x%x"
> -rdma_registration_handle_unregister(int requests) "%d requests"
> -rdma_registration_handle_unregister_loop(int count, int index, uint64_t =
chunk) "Unregistration request (%d): index %d, chunk %" PRIu64
> -rdma_registration_handle_unregister_success(uint64_t chunk) "%" PRIu64
>  rdma_registration_handle_wait(void) ""
>  rdma_registration_start(uint64_t flags) "%" PRIu64
>  rdma_registration_stop(uint64_t flags) "%" PRIu64
> --
> 2.54.0
>

