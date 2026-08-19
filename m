Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D53C5DF6D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 13:21:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwgEA-0007tN-88; Wed, 19 Aug 2026 09:21:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1wwgE9-0007t8-9N
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 09:21:09 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1wwgE6-0005Js-Jl
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 09:21:09 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c1676648c1eso7173066b.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 06:21:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787145665; cv=none;
 d=google.com; s=arc-20260327;
 b=Kp6KOWr9nY6BZlM6smCrs0AXZdLwwATOWbR+rlWBOY7FgdsA4CySmdvDeg6o/Lkida
 /rKp7kakwaXkbbkDHzcuvp9TsOFkUTHZQak1tSr0yQ2RedC7qNxsXd/5fhCJzs4cWxpI
 fD2LHKI5M+CszZ0BplnZ976ow9bSP7/W22eSgMeGneR5fKyA9RbDJaOKSRl9wSQqIV75
 e6kAT9+VW9wcZ+ZsrBS1eOfz5H7mY0sMK19IlbXibl/42pi1lBjEH40QXITdbxP7MF/Q
 mzMwnI/fk3S8792zUXo0A7e/0duMFsYL0x2qjrMjy/+2KXZvXexDaxhVrM0XlluVLcYK
 atNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XFxrQZkplw8hC1uMkwihxdzhfdC8dm5TmDizcKIb9BI=;
 fh=QWNbaIaVQQou6IzIMV0ib5reMaT/Wr3DV7egi1JIcps=;
 b=VK8BPBtF75/2mjSCkd4qYsf+xvgMBCQyPWGzqUF/efPyYU+tQlFkhHLk+Wjp+0dI5r
 r29csudhYh1Pb352AEbwQix4pZ/9c1ZwWzcrOlgxf9TlqnX91EQG1/0EF8FAHqmNAieL
 4ZIfDz2FoZnDwo3os5SbsxycytPwtnA8ypOi5TTyT0F30MJ1T+OGJ3z9XPngCR6fmhVq
 5ilInqDIXMtKEnlI0pUcWYZeVx8Z1YEgjAsG3Rp83Q/wddSBpTIajQUpjysQ9tIESR+B
 Uc3oj4YZbXRnaUgaZC8uT8TiZnhHLU/B3wcJK4J/mRBdmmxfYaICykOKRWqAHG4G7UWl
 JoYQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google; t=1787145665; x=1787750465; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XFxrQZkplw8hC1uMkwihxdzhfdC8dm5TmDizcKIb9BI=;
 b=frYQ4V+UAbs5j428VVM/5wABbFzfvdLpM8O8j58OrSbwyRXO3Z5g5hAumtzRob1I9M
 5FhizqxAL8kXlNGiXwoJ7o6koevBxpnvcAAtY8cZ3nNBIunWa3IsxW6Q4Mzkx2AE1T9v
 ftxIKkkZQCfXf3zguTAUacX3dNjQ8H/OySHu71DTgArzR9RrYJBvOW6EHzzrebNuhw+Q
 EpAK1b4i1b1TA2lsedL3ccg4jqH49PDTHMs426XH8d95/VuH6I2mz8vpklZTIvDGtLtG
 ZXKeXvMhTN49mvpL4St8Ct2rS+GXiZ+AxSIYuTufb4K9kl0dK2hsRv78AsyFHGhZTi9I
 RiQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787145665; x=1787750465;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XFxrQZkplw8hC1uMkwihxdzhfdC8dm5TmDizcKIb9BI=;
 b=eOTpav3seGlziJ9dPNzNVeBINhUG8skJgnRWSOLlqDOaSuDPkWJRsdKwNsQrm7eEUO
 Ggp3Nurm7odlieQ7T00O+hnZ7gNsH8RGVkR3OYHaVLQhKhGkfTMXpEE4T1kMqQyBfFjO
 mE36qEGrlz3jvjzrsncej8zZi1KwCNNivsJkWhDquKLeam3lh2H7fmM++dt8k4m/VMOh
 n0j9dGq6aBi/jhOV8xobURh6mNQIAR+ndFTNT3JZObgo3jbOSdoWckvqy4gTkiMn4ief
 mdsTMuPtsAUVoVlm5B4wfw3cg8Yb6by09MFcIdx4+ryFiG30r6Xij7kWloqQTsBBOsu8
 qq/Q==
X-Gm-Message-State: AOJu0Yz3/aT44bQtgSQ8pVJr37OCNpMmyRHZ2t29GSZXehRhWViJM36X
 dyG/vSLT6SAxjJEdT2eD/UZMvUZSY6l5DGZr1rkLvTrcY7f7XcLKih4vlK2ZmV5ATmAyD3rYPAT
 OrMi/sP3YK1fDxWHNYBYhWBU1pLoMvwRcr3qYG4ozvg==
X-Gm-Gg: AR+sD10+uOI5ly83p2Zq7LfBi0OtXP2PsHKIKRU/biATHiGiO7JVhdMVS58HX91diat
 4ZZNRU2mSw6xSceL8yVTLmsdaOpBKkew5KtN9RNjgM3kdHXpIVuXehQpJvtwBelZUMVP7MwpA1a
 EFrDx+8H/+0Cd1lmbcmZfskiGXuGEePsa48R7Gvzcc/GvNOplyu/3G453YwLdy7Faw5RvkSJdZc
 2uqZdYEj67Heok+cocLWtsUmqVHvfvfeVc2vzhotql4BvLX1fA1Rl9qiKd494T1o8tbVpDKyV/7
 4MlGNFPV3FyIFOf0AI8PM42wqg+qUC2OrGTur82ojmkE
X-Received: by 2002:a17:906:9f85:b0:c15:de99:8060 with SMTP id
 a640c23a62f3a-c23e81ec35fmr186515866b.0.1787145664588; Wed, 19 Aug 2026
 06:21:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260817202424.2901438-1-peterx@redhat.com>
 <20260817202424.2901438-3-peterx@redhat.com>
 <CAMGffEkDar1xw3easr03h0fB0O-Au5VdoJnfyrjiEVgkWmkT3g@mail.gmail.com>
 <CAMGffEmbQ3jzC2L=Wp72vh6rM6pW602u5iFmzqdVbDsTh-H6xA@mail.gmail.com>
 <aoWl9fhT71wXjvtb@x1.local>
In-Reply-To: <aoWl9fhT71wXjvtb@x1.local>
From: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date: Wed, 19 Aug 2026 15:20:53 +0200
X-Gm-Features: AcwNN1W9Dl26kJ93rvK1xoCu2Veq5uI1XZUi9ypCYM-Xwghua0tbBX4TWRVT5mc
Message-ID: <CAMGffEn0QN-NdFPn6B59vUbTKowUqJm8sYEBj-ixOO+f0bJVAQ@mail.gmail.com>
Subject: Re: [PATCH 02/10] migration/rdma: Remove unregister code
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@fujitsu.com>, 
 Samuel Zhang <guoqing.zhang@amd.com>, Fabiano Rosas <farosas@suse.de>, 
 Juraj Marcin <jmarcin@redhat.com>, Yanfei Xu <yanfei.xu@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:20::62e;
 envelope-from=jinpu.wang@ionos.com; helo=mail-ej1-x62e.google.com
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

On Wed, Aug 19, 2026 at 2:48=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Aug 19, 2026 at 02:01:49PM +0200, Jinpu Wang wrote:
> > On Wed, Aug 19, 2026 at 12:52=E2=80=AFPM Jinpu Wang <jinpu.wang@cloud.i=
onos.com> wrote:
> > >
> > > On Mon, Aug 17, 2026 at 10:24=E2=80=AFPM Peter Xu <peterx@redhat.com>=
 wrote:
> > > >
> > > > The unregister code was there since the first commit RDMA migration=
 was
> > > > merged, but it was never functioning.  Remove the dead code.
> > > >
> > > > Since the two control messages are the last ones, we don't even nee=
d to
> > > > worry about compatibility of legacy RDMA control commands, we can d=
irectly
> > > > remove the messages too.
> > > >
> > > > As a side effect, this patch closes a report by removing the code
> > > > completely.
> > > >
> > > > Reported-by: Tristan (@TristanInSec)
> > > > Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4003
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > Hi Peter, hi Yanfei,
>
> Hi, Jinpu,
>
> > >
> > > The change looks fine, and I have also tested to ensure it doesn't
> > > break compatibility with older versions. As already discussed,
> > > removing this code could result in more MRs being used during
> > > migration; however, once the migration is complete, they will be
> > > unregistered, so there is no leak.
>
> Could you help explain why removing this code could result in more MRs
> being used?  I didn't see these two control messages used, so I expect th=
e
> behavior should be exactly the same before/after this patch, with either =
a
> new or old QEMU binary.
You are right,  write of rdma->unregistrations[...] =3D <wr_id> (which
is what the historical qemu_rdma_signal_unregister() used to do, which
was removed 4 years ago in 246683c22f21 ("migration: remove unreachble
RDMA code in save_hook impl") )

I was under impression, ibv_dereg_mr is call less with the change, I
missed the fact above.
>
> > >
> > > Reviewed-by: Jinpu Wang <jinpu.wang@cloud.ionos.com>
> > > > ---
> > > >  migration/rdma.c       | 133 -------------------------------------=
----
> > > >  migration/trace-events |   7 ---
> > > >  2 files changed, 140 deletions(-)
> > > >
> > > > diff --git a/migration/rdma.c b/migration/rdma.c
> > > > index 62a509b236..eae4afd6df 100644
> > > > --- a/migration/rdma.c
> > > > +++ b/migration/rdma.c
> > > > @@ -142,8 +142,6 @@ enum {
> > > >      RDMA_CONTROL_REGISTER_REQUEST,    /* dynamic page registration=
 */
> > > >      RDMA_CONTROL_REGISTER_RESULT,     /* key to use after registra=
tion */
> > > >      RDMA_CONTROL_REGISTER_FINISHED,   /* current iteration finishe=
d */
> > > > -    RDMA_CONTROL_UNREGISTER_REQUEST,  /* dynamic UN-registration *=
/
> > > > -    RDMA_CONTROL_UNREGISTER_FINISHED, /* unpinning finished */
> > > >      RDMA_CONTROL_NUM,
> > > >  };
> > > >
> > > > @@ -232,8 +230,6 @@ static const char *control_desc(unsigned int rd=
ma_control)
> > > >          [RDMA_CONTROL_REGISTER_REQUEST] =3D "REGISTER REQUEST",
> > > >          [RDMA_CONTROL_REGISTER_RESULT] =3D "REGISTER RESULT",
> > > >          [RDMA_CONTROL_REGISTER_FINISHED] =3D "REGISTER FINISHED",
> > > > -        [RDMA_CONTROL_UNREGISTER_REQUEST] =3D "UNREGISTER REQUEST"=
,
> > > > -        [RDMA_CONTROL_UNREGISTER_FINISHED] =3D "UNREGISTER FINISHE=
D",
> > > >      };
> > > >
> > > >      if (rdma_control >=3D RDMA_CONTROL_NUM) {
> > > > @@ -370,9 +366,6 @@ typedef struct RDMAContext {
> > > >      int total_registrations;
> > > >      int total_writes;
> > > >
> > > > -    int unregister_current, unregister_next;
> > > > -    uint64_t unregistrations[RDMA_SIGNALED_SEND_MAX];
> > > > -
> > > >      GHashTable *blockmap;
> > > >
> > > >      /* the RDMAContext for return path */
> > > > @@ -1186,91 +1179,6 @@ static int qemu_rdma_reg_control(RDMAContext=
 *rdma, int idx)
> > > >      return -1;
> > > >  }
> > > >
> > > > -/*
> > > > - * Perform a non-optimized memory unregistration after every trans=
fer
> > > > - * for demonstration purposes, only if pin-all is not requested.
> > > > - *
> > > > - * Potential optimizations:
> > > > - * 1. Start a new thread to run this function continuously
> > > > -        - for bit clearing
> > > > -        - and for receipt of unregister messages
> > > > - * 2. Use an LRU.
> > > > - * 3. Use workload hints.
> > > > - */
> > > > -static int qemu_rdma_unregister_waiting(RDMAContext *rdma)
> > > > -{
> > > > -    Error *err =3D NULL;
> > > > -
> > > > -    while (rdma->unregistrations[rdma->unregister_current]) {
> > > > -        int ret;
> > > > -        uint64_t wr_id =3D rdma->unregistrations[rdma->unregister_=
current];
> > > > -        uint64_t chunk =3D
> > > > -            (wr_id & RDMA_WRID_CHUNK_MASK) >> RDMA_WRID_CHUNK_SHIF=
T;
> > > > -        uint64_t index =3D
> > > > -            (wr_id & RDMA_WRID_BLOCK_MASK) >> RDMA_WRID_BLOCK_SHIF=
T;
> > > > -        RDMALocalBlock *block =3D
> > > > -            &(rdma->local_ram_blocks.block[index]);
> > > > -        RDMARegister reg =3D { .current_index =3D index };
> > > > -        RDMAControlHeader resp =3D { .type =3D RDMA_CONTROL_UNREGI=
STER_FINISHED,
> > > > -                                 };
> > > > -        RDMAControlHeader head =3D { .len =3D sizeof(RDMARegister)=
,
> > > > -                                   .type =3D RDMA_CONTROL_UNREGIST=
ER_REQUEST,
> > > > -                                   .repeat =3D 1,
> > > > -                                 };
> > > > -
> > > > -        trace_qemu_rdma_unregister_waiting_proc(chunk,
> > > > -                                                rdma->unregister_c=
urrent);
> > > > -
> > > > -        rdma->unregistrations[rdma->unregister_current] =3D 0;
> > > > -        rdma->unregister_current++;
> > > > -
> > > > -        if (rdma->unregister_current =3D=3D RDMA_SIGNALED_SEND_MAX=
) {
> > > > -            rdma->unregister_current =3D 0;
> > > > -        }
> > > > -
> > > > -
> > > > -        /*
> > > > -         * Unregistration is speculative (because migration is sin=
gle-threaded
> > > > -         * and we cannot break the protocol's inifinband message o=
rdering).
> > > > -         * Thus, if the memory is currently being used for transmi=
ssion,
> > > > -         * then abort the attempt to unregister and try again
> > > > -         * later the next time a completion is received for this m=
emory.
> > > > -         */
> > > > -        clear_bit(chunk, block->unregister_bitmap);
> > > > -
> > > > -        if (test_bit(chunk, block->transit_bitmap)) {
> > > > -            trace_qemu_rdma_unregister_waiting_inflight(chunk);
> > > > -            continue;
> > > > -        }
> > > > -
> > > > -        trace_qemu_rdma_unregister_waiting_send(chunk);
> > > > -
> > > > -        ret =3D ibv_dereg_mr(block->pmr[chunk]);
> > > > -        block->pmr[chunk] =3D NULL;
> > > > -        block->remote_keys[chunk] =3D 0;
> > > > -
> > > > -        if (ret !=3D 0) {
> > > > -            error_report("unregistration chunk failed: %s",
> > > > -                         strerror(ret));
> > > > -            return -1;
> > > > -        }
> > > > -        rdma->total_registrations--;
> > > > -
> > > > -        reg.key.chunk =3D chunk;
> > > > -        register_to_network(rdma, &reg);
> > > > -        ret =3D qemu_rdma_exchange_send(rdma, &head, (uint8_t *) &=
reg,
> > > > -                                      &resp, NULL, NULL, &err);
> > > > -        if (ret < 0) {
> > > > -            error_report_err(err);
> > > > -            return -1;
> > > > -        }
> > > > -
> > > > -        trace_qemu_rdma_unregister_waiting_complete(chunk);
> > > > -    }
> > > > -
> > > > -    return 0;
> > > > -}
> > > > -
> > > >  static uint64_t qemu_rdma_make_wrid(uint64_t wr_id, uint64_t index=
,
> > > >                                           uint64_t chunk)
> > > >  {
> > > > @@ -2757,8 +2665,6 @@ static int qemu_rdma_drain_cq(RDMAContext *rd=
ma)
> > > >          }
> > > >      }
> > > >
> > > > -    qemu_rdma_unregister_waiting(rdma);
> > > > -
> > > >      return 0;
> > > >  }
> > > >
> > > > @@ -3336,10 +3242,6 @@ int rdma_registration_handle(QEMUFile *f)
> > > >                                 .type =3D RDMA_CONTROL_REGISTER_RES=
ULT,
> > > >                                 .repeat =3D 0,
> > > >                               };
> > > > -    RDMAControlHeader unreg_resp =3D { .len =3D 0,
> > > > -                               .type =3D RDMA_CONTROL_UNREGISTER_F=
INISHED,
> > > > -                               .repeat =3D 0,
> > > > -                             };
> > > >      RDMAControlHeader blocks =3D { .type =3D RDMA_CONTROL_RAM_BLOC=
KS_RESULT,
> > > >                                   .repeat =3D 1 };
> > > >      QIOChannelRDMA *rioc;
> > > > @@ -3552,41 +3454,6 @@ int rdma_registration_handle(QEMUFile *f)
> > > >              ret =3D qemu_rdma_post_send_control(rdma,
> > > >                              (uint8_t *) results, &reg_resp, &err);
> > > >
> > > > -            if (ret < 0) {
> > > > -                error_report_err(err);
> > > > -                goto err;
> > > > -            }
> > > > -            break;
> > > > -        case RDMA_CONTROL_UNREGISTER_REQUEST:
> > > > -            trace_rdma_registration_handle_unregister(head.repeat)=
;
> > > > -            unreg_resp.repeat =3D head.repeat;
> > > > -            registers =3D (RDMARegister *) rdma->wr_data[idx].cont=
rol_curr;
> > > > -
> > > > -            for (int count =3D 0; count < head.repeat; count++) {
> > > > -                reg =3D &registers[count];
> > > > -                network_to_register(reg);
> > > > -
> > > > -                trace_rdma_registration_handle_unregister_loop(cou=
nt,
> > > > -                           reg->current_index, reg->key.chunk);
> > > > -
> > > > -                block =3D &(rdma->local_ram_blocks.block[reg->curr=
ent_index]);
> > > > -
> > > > -                ret =3D ibv_dereg_mr(block->pmr[reg->key.chunk]);
> > > > -                block->pmr[reg->key.chunk] =3D NULL;
> > > > -
> > > > -                if (ret !=3D 0) {
> > > > -                    error_report("rdma unregistration chunk failed=
: %s",
> > > > -                                 strerror(errno));
> > > > -                    goto err;
> > > > -                }
> > > > -
> > > > -                rdma->total_registrations--;
> > > > -
> > > > -                trace_rdma_registration_handle_unregister_success(=
reg->key.chunk);
> > > > -            }
> > > > -
> > > > -            ret =3D qemu_rdma_post_send_control(rdma, NULL, &unreg=
_resp, &err);
> > > > -
> > > >              if (ret < 0) {
> > > >                  error_report_err(err);
> > > >                  goto err;
> > > > diff --git a/migration/trace-events b/migration/trace-events
> > > > index af0e784535..d1fe8f1382 100644
> > > > --- a/migration/trace-events
> > > > +++ b/migration/trace-events
> > > > @@ -244,10 +244,6 @@ qemu_rdma_advise_mr(const char *name, uint32_t=
 len, uint64_t addr, const char *r
> > > >  qemu_rdma_resolve_host_trying(const char *host, const char *ip) "T=
rying %s =3D> %s"
> > > >  qemu_rdma_signal_unregister_append(uint64_t chunk, int pos) "Appen=
ding unregister chunk %" PRIu64 " at position %d"
> > > >  qemu_rdma_signal_unregister_already(uint64_t chunk) "Unregister ch=
unk %" PRIu64 " already in queue"
> > Not related to this change. Above 2 functions are not used, we might
> > want to remove them.
>
> True, I'll drop them altogether.
>
> Thanks,
>
> >
> > > > -qemu_rdma_unregister_waiting_inflight(uint64_t chunk) "Cannot unre=
gister inflight chunk: %" PRIu64
> > > > -qemu_rdma_unregister_waiting_proc(uint64_t chunk, int pos) "Proces=
sing unregister for chunk: %" PRIu64 " at position %d"
> > > > -qemu_rdma_unregister_waiting_send(uint64_t chunk) "Sending unregis=
ter for chunk: %" PRIu64
> > > > -qemu_rdma_unregister_waiting_complete(uint64_t chunk) "Unregister =
for chunk: %" PRIu64 " complete."
> > > >  qemu_rdma_write_flush(int sent) "sent total: %d"
> > > >  qemu_rdma_write_one_block(int count, int block, uint64_t chunk, ui=
nt64_t current, uint64_t len, int nb_sent, int nb_chunks) "(%d) Not clobber=
ing: block: %d chunk %" PRIu64 " current %" PRIu64 " len %" PRIu64 " %d %d"
> > > >  qemu_rdma_write_one_post(uint64_t chunk, long addr, long remote, u=
int32_t len) "Posting chunk: %" PRIu64 ", addr: 0x%lx remote: 0x%lx, bytes =
%" PRIu32
> > > > @@ -266,9 +262,6 @@ rdma_registration_handle_ram_blocks_loop(const =
char *name, uint64_t offset, uint
> > > >  rdma_registration_handle_register(int requests) "%d requests"
> > > >  rdma_registration_handle_register_loop(int req, int index, uint64_=
t addr, uint64_t chunks) "Registration request (%d): index %d, current_addr=
 %" PRIu64 " chunks: %" PRIu64
> > > >  rdma_registration_handle_register_rkey(int rkey) "0x%x"
> > > > -rdma_registration_handle_unregister(int requests) "%d requests"
> > > > -rdma_registration_handle_unregister_loop(int count, int index, uin=
t64_t chunk) "Unregistration request (%d): index %d, chunk %" PRIu64
> > > > -rdma_registration_handle_unregister_success(uint64_t chunk) "%" PR=
Iu64
> > > >  rdma_registration_handle_wait(void) ""
> > > >  rdma_registration_start(uint64_t flags) "%" PRIu64
> > > >  rdma_registration_stop(uint64_t flags) "%" PRIu64
> > > > --
> > > > 2.54.0
> > > >
> >
>
> --
> Peter Xu
>

