Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A84C5DF86
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 12:44:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwfdq-00088C-N7; Wed, 19 Aug 2026 08:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1wwezf-0003Kg-9G
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 08:02:07 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1wwezc-0006Xv-5C
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 08:02:06 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c160d8760e0so10134266b.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 05:02:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787140921; cv=none;
 d=google.com; s=arc-20260327;
 b=q/L0Orake70P4L6uFzfJnNfxVJjsETm7NoLx4oHBLmoCaM08ztKfX1vi/jbIBRuKwS
 nq9GWRjHgQyC6gZzy6dm3JaRTvzCv/56e9rLLCQQBugpugD08CTTWfpMhI/ycHi6hFZ9
 6A0Kx/llp6sX2jSDHySFmcGrBVrCqsfFdMTHwr0MVW0qQqoUFwF3TpLXnxqxOECtmq9+
 5pNbq1Ydsb8hURdcTob0cUP42ZZe7/yyFK2bqwndxQrfKUL3/AoUm9rQBR4H2JwRZRQG
 ecJ6JhW8jznG0ny87SSY/1BJyuXPPxW1X2ibVtl1RQu99moltgJhhYPtPbg7Kcy8MNTe
 FmYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xN7cIkk56lRWMjrGsDHNwU4teSbRJ1nJ+ouKvSEV2u8=;
 fh=QWNbaIaVQQou6IzIMV0ib5reMaT/Wr3DV7egi1JIcps=;
 b=Rk3hyBKcN//IMLuLprlhhXtM0UJe6y0Wifpr7dqev+0OezkvbETOU7YJGCC88it8xo
 nEWGEdauntwbdv1kEnpj2qJB70NPJplLq/NZXe1EoTCfOzbvJVc471jYlO/Ot9Qhu5+I
 rP0MTJ+4Fw5NQRRJeTG8/6mdy9FhXgXhe0Xt8+Wz+NhP69y3v20/J8IkkDWuwqkuxXQx
 pG4Ekdo2cDcCfNca8QcUMDz4YTPkrABj620paU5EAf2GJ80rQ98u7R1032HvVlhYxZGi
 43ckOtuuAXxVMxipEN8lmwek8oBEG6bxS+rNEQGnuyKN0c14ujqYl24z+lYxbGN8Y/tc
 yQbQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google; t=1787140921; x=1787745721; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xN7cIkk56lRWMjrGsDHNwU4teSbRJ1nJ+ouKvSEV2u8=;
 b=EO71uTNNBolH6SPYzdhrsNzA7WwNvi+wV0SGoc11Qn9CYiCDuEBjWf4A2kirHbjtes
 eFTjgZzR55JnI+V9trcFB2hpkSwWomlcmWXxQ2A7xgGnwNyIsy42/fy0x1gkdzacNRMB
 BMVBdVadu5i/X7XjqSGq4X23dr0e7AGtEXtOOD56soqF5BjO/2ACh5pfUX9gXWWRjjUv
 b349zA5HLzLJsSW0GizBtIOZW8af5zSxMiwypRzTeGN4c5KVuR/aWAR9k0lh9sQGNKqK
 KaX1dOeXlwd7qDhrPlyOeKgYC4OPlFzi3mLbjbYA2Qm6O3mxp4IUjFpTQ+tMi2zi4kLm
 EWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787140921; x=1787745721;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xN7cIkk56lRWMjrGsDHNwU4teSbRJ1nJ+ouKvSEV2u8=;
 b=NzVmqbLXurWLOpuvMzjtcoIEC2nGhDR6am8xT8Mt0ZEneXqWWokZ3qy1/8ZtR2sJwO
 uCkETGqzE+mTYwVW3hl0WUJ8IJAJeFTTcC9bRCMZo0pfNb85/NyJ2UGQ2LxOwXYN41XD
 N1llhJ0NzYN2uKSaRgLIdpGix4iajvmNEjnUEzmIp3r6Lxy7h3ryoJBljF5OPDvCOfvc
 CB+PxSwhbtrfCXdHx8Ve/WSR5d/I3FepK8sdnlLRoPGZ9vUeHt9HravSviFGH3EOC70y
 SZjE5bDWn556LZK3Vyu7h9YhouFZ/nfrWIc5LV8P/H/mH0WrOavq/g07S9vyJlgabjaJ
 5u4g==
X-Gm-Message-State: AOJu0YylLN1imXKJfIj3nDr/g4XeUXvtfTb6mqMR751bXeqgJ0aIGcN5
 uaC68JI07Qpz7+5dyLz5NlUFBQEyTi9HvHJtUHl8nvGewjVx5WV6xxtA0poukNnCq76B64lBaQZ
 d7gjRlrDnBCabeRD7o5HtwULNqJO/vi1xl3kqUb2gfHBRcOoTXexqtjg=
X-Gm-Gg: AR+sD109IbdNIlX8v7sQspt4LCkQ2fS4WMJci//dxHz5Nb8rWGQb80DbslKLR3h6PkV
 XttDqvqpEVap4b0NJ88ALx8LdLQP2mATEAIj43xz9MbivInySp4SyahPgT6TWGL1v9sosvSDYrw
 jJGcrxf+xU1S+W+Dvi7XMaYkbxhk2eVHu7vJdocmVZBMuNdrU8mRGlnAXQYdHacfeWwVm0dAAk2
 Dx7BumLTDKof8bbnWSLd2soXEl48ipkBJSKqyXJXKPrDK2eis5fuY3CHUTGvHfwt9exBOsWInL7
 vAAsYuFEdpvIB5M0snDaK9RGKVRWFIwbktzKlw02fKGk
X-Received: by 2002:a17:906:7949:b0:c20:38e2:b355 with SMTP id
 a640c23a62f3a-c242e6d4981mr137806766b.4.1787140920916; Wed, 19 Aug 2026
 05:02:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260817202424.2901438-1-peterx@redhat.com>
 <20260817202424.2901438-3-peterx@redhat.com>
 <CAMGffEkDar1xw3easr03h0fB0O-Au5VdoJnfyrjiEVgkWmkT3g@mail.gmail.com>
In-Reply-To: <CAMGffEkDar1xw3easr03h0fB0O-Au5VdoJnfyrjiEVgkWmkT3g@mail.gmail.com>
From: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date: Wed, 19 Aug 2026 14:01:49 +0200
X-Gm-Features: AcwNN1V8pPTqGoY5_7C0K7cSyDPiZGNyDZR7UYUZ9qCBkNHnFyzoqhdomm6i1RA
Message-ID: <CAMGffEmbQ3jzC2L=Wp72vh6rM6pW602u5iFmzqdVbDsTh-H6xA@mail.gmail.com>
Subject: Re: [PATCH 02/10] migration/rdma: Remove unregister code
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@fujitsu.com>, 
 Samuel Zhang <guoqing.zhang@amd.com>, Fabiano Rosas <farosas@suse.de>, 
 Juraj Marcin <jmarcin@redhat.com>, Yanfei Xu <yanfei.xu@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:20::633;
 envelope-from=jinpu.wang@ionos.com; helo=mail-ej1-x633.google.com
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

On Wed, Aug 19, 2026 at 12:52=E2=80=AFPM Jinpu Wang <jinpu.wang@cloud.ionos=
.com> wrote:
>
> On Mon, Aug 17, 2026 at 10:24=E2=80=AFPM Peter Xu <peterx@redhat.com> wro=
te:
> >
> > The unregister code was there since the first commit RDMA migration was
> > merged, but it was never functioning.  Remove the dead code.
> >
> > Since the two control messages are the last ones, we don't even need to
> > worry about compatibility of legacy RDMA control commands, we can direc=
tly
> > remove the messages too.
> >
> > As a side effect, this patch closes a report by removing the code
> > completely.
> >
> > Reported-by: Tristan (@TristanInSec)
> > Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4003
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> Hi Peter, hi Yanfei,
>
> The change looks fine, and I have also tested to ensure it doesn't
> break compatibility with older versions. As already discussed,
> removing this code could result in more MRs being used during
> migration; however, once the migration is complete, they will be
> unregistered, so there is no leak.
>
> Reviewed-by: Jinpu Wang <jinpu.wang@cloud.ionos.com>
> > ---
> >  migration/rdma.c       | 133 -----------------------------------------
> >  migration/trace-events |   7 ---
> >  2 files changed, 140 deletions(-)
> >
> > diff --git a/migration/rdma.c b/migration/rdma.c
> > index 62a509b236..eae4afd6df 100644
> > --- a/migration/rdma.c
> > +++ b/migration/rdma.c
> > @@ -142,8 +142,6 @@ enum {
> >      RDMA_CONTROL_REGISTER_REQUEST,    /* dynamic page registration */
> >      RDMA_CONTROL_REGISTER_RESULT,     /* key to use after registration=
 */
> >      RDMA_CONTROL_REGISTER_FINISHED,   /* current iteration finished */
> > -    RDMA_CONTROL_UNREGISTER_REQUEST,  /* dynamic UN-registration */
> > -    RDMA_CONTROL_UNREGISTER_FINISHED, /* unpinning finished */
> >      RDMA_CONTROL_NUM,
> >  };
> >
> > @@ -232,8 +230,6 @@ static const char *control_desc(unsigned int rdma_c=
ontrol)
> >          [RDMA_CONTROL_REGISTER_REQUEST] =3D "REGISTER REQUEST",
> >          [RDMA_CONTROL_REGISTER_RESULT] =3D "REGISTER RESULT",
> >          [RDMA_CONTROL_REGISTER_FINISHED] =3D "REGISTER FINISHED",
> > -        [RDMA_CONTROL_UNREGISTER_REQUEST] =3D "UNREGISTER REQUEST",
> > -        [RDMA_CONTROL_UNREGISTER_FINISHED] =3D "UNREGISTER FINISHED",
> >      };
> >
> >      if (rdma_control >=3D RDMA_CONTROL_NUM) {
> > @@ -370,9 +366,6 @@ typedef struct RDMAContext {
> >      int total_registrations;
> >      int total_writes;
> >
> > -    int unregister_current, unregister_next;
> > -    uint64_t unregistrations[RDMA_SIGNALED_SEND_MAX];
> > -
> >      GHashTable *blockmap;
> >
> >      /* the RDMAContext for return path */
> > @@ -1186,91 +1179,6 @@ static int qemu_rdma_reg_control(RDMAContext *rd=
ma, int idx)
> >      return -1;
> >  }
> >
> > -/*
> > - * Perform a non-optimized memory unregistration after every transfer
> > - * for demonstration purposes, only if pin-all is not requested.
> > - *
> > - * Potential optimizations:
> > - * 1. Start a new thread to run this function continuously
> > -        - for bit clearing
> > -        - and for receipt of unregister messages
> > - * 2. Use an LRU.
> > - * 3. Use workload hints.
> > - */
> > -static int qemu_rdma_unregister_waiting(RDMAContext *rdma)
> > -{
> > -    Error *err =3D NULL;
> > -
> > -    while (rdma->unregistrations[rdma->unregister_current]) {
> > -        int ret;
> > -        uint64_t wr_id =3D rdma->unregistrations[rdma->unregister_curr=
ent];
> > -        uint64_t chunk =3D
> > -            (wr_id & RDMA_WRID_CHUNK_MASK) >> RDMA_WRID_CHUNK_SHIFT;
> > -        uint64_t index =3D
> > -            (wr_id & RDMA_WRID_BLOCK_MASK) >> RDMA_WRID_BLOCK_SHIFT;
> > -        RDMALocalBlock *block =3D
> > -            &(rdma->local_ram_blocks.block[index]);
> > -        RDMARegister reg =3D { .current_index =3D index };
> > -        RDMAControlHeader resp =3D { .type =3D RDMA_CONTROL_UNREGISTER=
_FINISHED,
> > -                                 };
> > -        RDMAControlHeader head =3D { .len =3D sizeof(RDMARegister),
> > -                                   .type =3D RDMA_CONTROL_UNREGISTER_R=
EQUEST,
> > -                                   .repeat =3D 1,
> > -                                 };
> > -
> > -        trace_qemu_rdma_unregister_waiting_proc(chunk,
> > -                                                rdma->unregister_curre=
nt);
> > -
> > -        rdma->unregistrations[rdma->unregister_current] =3D 0;
> > -        rdma->unregister_current++;
> > -
> > -        if (rdma->unregister_current =3D=3D RDMA_SIGNALED_SEND_MAX) {
> > -            rdma->unregister_current =3D 0;
> > -        }
> > -
> > -
> > -        /*
> > -         * Unregistration is speculative (because migration is single-=
threaded
> > -         * and we cannot break the protocol's inifinband message order=
ing).
> > -         * Thus, if the memory is currently being used for transmissio=
n,
> > -         * then abort the attempt to unregister and try again
> > -         * later the next time a completion is received for this memor=
y.
> > -         */
> > -        clear_bit(chunk, block->unregister_bitmap);
> > -
> > -        if (test_bit(chunk, block->transit_bitmap)) {
> > -            trace_qemu_rdma_unregister_waiting_inflight(chunk);
> > -            continue;
> > -        }
> > -
> > -        trace_qemu_rdma_unregister_waiting_send(chunk);
> > -
> > -        ret =3D ibv_dereg_mr(block->pmr[chunk]);
> > -        block->pmr[chunk] =3D NULL;
> > -        block->remote_keys[chunk] =3D 0;
> > -
> > -        if (ret !=3D 0) {
> > -            error_report("unregistration chunk failed: %s",
> > -                         strerror(ret));
> > -            return -1;
> > -        }
> > -        rdma->total_registrations--;
> > -
> > -        reg.key.chunk =3D chunk;
> > -        register_to_network(rdma, &reg);
> > -        ret =3D qemu_rdma_exchange_send(rdma, &head, (uint8_t *) &reg,
> > -                                      &resp, NULL, NULL, &err);
> > -        if (ret < 0) {
> > -            error_report_err(err);
> > -            return -1;
> > -        }
> > -
> > -        trace_qemu_rdma_unregister_waiting_complete(chunk);
> > -    }
> > -
> > -    return 0;
> > -}
> > -
> >  static uint64_t qemu_rdma_make_wrid(uint64_t wr_id, uint64_t index,
> >                                           uint64_t chunk)
> >  {
> > @@ -2757,8 +2665,6 @@ static int qemu_rdma_drain_cq(RDMAContext *rdma)
> >          }
> >      }
> >
> > -    qemu_rdma_unregister_waiting(rdma);
> > -
> >      return 0;
> >  }
> >
> > @@ -3336,10 +3242,6 @@ int rdma_registration_handle(QEMUFile *f)
> >                                 .type =3D RDMA_CONTROL_REGISTER_RESULT,
> >                                 .repeat =3D 0,
> >                               };
> > -    RDMAControlHeader unreg_resp =3D { .len =3D 0,
> > -                               .type =3D RDMA_CONTROL_UNREGISTER_FINIS=
HED,
> > -                               .repeat =3D 0,
> > -                             };
> >      RDMAControlHeader blocks =3D { .type =3D RDMA_CONTROL_RAM_BLOCKS_R=
ESULT,
> >                                   .repeat =3D 1 };
> >      QIOChannelRDMA *rioc;
> > @@ -3552,41 +3454,6 @@ int rdma_registration_handle(QEMUFile *f)
> >              ret =3D qemu_rdma_post_send_control(rdma,
> >                              (uint8_t *) results, &reg_resp, &err);
> >
> > -            if (ret < 0) {
> > -                error_report_err(err);
> > -                goto err;
> > -            }
> > -            break;
> > -        case RDMA_CONTROL_UNREGISTER_REQUEST:
> > -            trace_rdma_registration_handle_unregister(head.repeat);
> > -            unreg_resp.repeat =3D head.repeat;
> > -            registers =3D (RDMARegister *) rdma->wr_data[idx].control_=
curr;
> > -
> > -            for (int count =3D 0; count < head.repeat; count++) {
> > -                reg =3D &registers[count];
> > -                network_to_register(reg);
> > -
> > -                trace_rdma_registration_handle_unregister_loop(count,
> > -                           reg->current_index, reg->key.chunk);
> > -
> > -                block =3D &(rdma->local_ram_blocks.block[reg->current_=
index]);
> > -
> > -                ret =3D ibv_dereg_mr(block->pmr[reg->key.chunk]);
> > -                block->pmr[reg->key.chunk] =3D NULL;
> > -
> > -                if (ret !=3D 0) {
> > -                    error_report("rdma unregistration chunk failed: %s=
",
> > -                                 strerror(errno));
> > -                    goto err;
> > -                }
> > -
> > -                rdma->total_registrations--;
> > -
> > -                trace_rdma_registration_handle_unregister_success(reg-=
>key.chunk);
> > -            }
> > -
> > -            ret =3D qemu_rdma_post_send_control(rdma, NULL, &unreg_res=
p, &err);
> > -
> >              if (ret < 0) {
> >                  error_report_err(err);
> >                  goto err;
> > diff --git a/migration/trace-events b/migration/trace-events
> > index af0e784535..d1fe8f1382 100644
> > --- a/migration/trace-events
> > +++ b/migration/trace-events
> > @@ -244,10 +244,6 @@ qemu_rdma_advise_mr(const char *name, uint32_t len=
, uint64_t addr, const char *r
> >  qemu_rdma_resolve_host_trying(const char *host, const char *ip) "Tryin=
g %s =3D> %s"
> >  qemu_rdma_signal_unregister_append(uint64_t chunk, int pos) "Appending=
 unregister chunk %" PRIu64 " at position %d"
> >  qemu_rdma_signal_unregister_already(uint64_t chunk) "Unregister chunk =
%" PRIu64 " already in queue"
Not related to this change. Above 2 functions are not used, we might
want to remove them.


> > -qemu_rdma_unregister_waiting_inflight(uint64_t chunk) "Cannot unregist=
er inflight chunk: %" PRIu64
> > -qemu_rdma_unregister_waiting_proc(uint64_t chunk, int pos) "Processing=
 unregister for chunk: %" PRIu64 " at position %d"
> > -qemu_rdma_unregister_waiting_send(uint64_t chunk) "Sending unregister =
for chunk: %" PRIu64
> > -qemu_rdma_unregister_waiting_complete(uint64_t chunk) "Unregister for =
chunk: %" PRIu64 " complete."
> >  qemu_rdma_write_flush(int sent) "sent total: %d"
> >  qemu_rdma_write_one_block(int count, int block, uint64_t chunk, uint64=
_t current, uint64_t len, int nb_sent, int nb_chunks) "(%d) Not clobbering:=
 block: %d chunk %" PRIu64 " current %" PRIu64 " len %" PRIu64 " %d %d"
> >  qemu_rdma_write_one_post(uint64_t chunk, long addr, long remote, uint3=
2_t len) "Posting chunk: %" PRIu64 ", addr: 0x%lx remote: 0x%lx, bytes %" P=
RIu32
> > @@ -266,9 +262,6 @@ rdma_registration_handle_ram_blocks_loop(const char=
 *name, uint64_t offset, uint
> >  rdma_registration_handle_register(int requests) "%d requests"
> >  rdma_registration_handle_register_loop(int req, int index, uint64_t ad=
dr, uint64_t chunks) "Registration request (%d): index %d, current_addr %" =
PRIu64 " chunks: %" PRIu64
> >  rdma_registration_handle_register_rkey(int rkey) "0x%x"
> > -rdma_registration_handle_unregister(int requests) "%d requests"
> > -rdma_registration_handle_unregister_loop(int count, int index, uint64_=
t chunk) "Unregistration request (%d): index %d, chunk %" PRIu64
> > -rdma_registration_handle_unregister_success(uint64_t chunk) "%" PRIu64
> >  rdma_registration_handle_wait(void) ""
> >  rdma_registration_start(uint64_t flags) "%" PRIu64
> >  rdma_registration_stop(uint64_t flags) "%" PRIu64
> > --
> > 2.54.0
> >

