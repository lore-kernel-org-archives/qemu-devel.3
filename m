Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B23EC79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 07:53:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3U9q-0004gK-6E; Mon, 07 Sep 2026 03:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1x3U9p-0004gC-Bs
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 03:52:49 -0400
Received: from mail-ej2-x10.google.com ([2a00:1450:4864:34::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1x3U9n-0004dk-5a
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 03:52:49 -0400
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c253ef7ecb5so25498666b.2
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 00:52:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788767564; cv=none;
 d=google.com; s=arc-20260327;
 b=MnrowbKNd9r+tOVdQlTntGFsBBEGpqDDc+SQ8eNy4iD7hxxakNNhdNnXL4hc20qGdm
 ymaX67bb9IdK5DKMB2n1wPWNkjdKOuYUQqDfmzNkqUx0LL4rkCReaxAypYG37IprgfKa
 U9V11BGk3Zvo0DSFeAGrRLPkAW6DLrXvXa6DnNPXiFf4CwsA2dFH9fMqkcAf85DPoGdL
 UApF4Sqq1xW6rgO1FQqsY74OASXEYSnAdZQlfVwzg9Gre6RNprz9gWUcYVEQZoJgrXlm
 muBF/yg7H2/LMscipdgsqZn3+HS3ef08O3lK8rSrNawYrojri+XxdihR5o8U3gdO6Q1H
 e7Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=S09rRkCBjqJuI2wfyoEIaXFp5p81BmGD58En+8Ektek=;
 fh=CIQhae3Sc6nKqSNMvGJSSdU9VNGaXcRmmq+hB8BYfUY=;
 b=EOAeymmh28pWCqAfNgFh+YGGT4oGrH2pjcmnQaRNtqUKtrJtHSPlAO0wNA4vosmNhU
 wNS/lBhE1mb6LtD18rVhsH6YWQZe6NBbf3cb3dpkHSLXwsnw7xcJmcv3DgjSa3b9njZ0
 WR6xK8aSjh1MyNQHO+CN4Y+b+ax7SXzuzoLvdFQKAZyQGDxkFlZc3h8e+QAASDnxcNwr
 +5gebXMVTHxX7Exe2+mDWkzFdk8QAVwXlk1lptc+IQsV3RmuSpk9+Vr27vfyn+LpQ2/F
 FSGkjJdeHVDC3uaaQ/F5mVdPNQRHtayOfmaUX9HETSL6RLrQllQxE896ivif6cTUeNhB
 d7eA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google; t=1788767564; x=1789372364; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=S09rRkCBjqJuI2wfyoEIaXFp5p81BmGD58En+8Ektek=;
 b=LUnfmjdAta7gaLaz2pV+tZpLEShxmU0lH9BBSQyufzEn1iaRQYmg5SDPKSywzFfMtD
 rc+j5ZNo7G5bsCIe8uPHA3WyTt0n/HvQ5V9Y+o/gvFjwwzbR+PVNXXkSngJmEHgeHplx
 M/X2+bxjjvweS/4hGYnxJj+eNb2iDambemzR2wXcqn29oTI1Sy9yDqXVYBy1stGb/tA6
 xkb81MrPrUg3qB2XNmCCsmQQL9MnxYI9WMavYjPd8qGzfl65cQqMBtLZHKa2hdYc8q75
 Fs1GBjp7rY4KUS82NBC/bsX0RzU53/LlxdzUy1m/mgvCZxKSfxJINgFzUOtT10S7ktwO
 Wmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788767564; x=1789372364;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=S09rRkCBjqJuI2wfyoEIaXFp5p81BmGD58En+8Ektek=;
 b=YQB/+mqxTmVTiI69gFrlWrtB4KjII77PHpPUZbXXQnj2PAJwgSX/V8pRG/tGw9V4ND
 ftwyic4guGz0Wopyy4dHewFIv+knW8E4U8dWorCXjFGXhi4s10KbWJMLqKusaZDM0y6v
 iSEVEJSqMyF9KtLWlXQy0PE7ekmSAaVonQl4LhECbw3iuuems/IeGbRxMuN8kPpz4tW0
 mkYip6PWhavDabzwosV0+5vvFBFRvYv9uBW8FcDaVVZC5SlNwaEjtJ4PBUsCiulfymgg
 1K/+DC+uKcImc4yWcoYajvXx/AKmRrEAui0ebLceZxHjfCSbHLnFR3/bNa5g7jEoNXG4
 6HeQ==
X-Gm-Message-State: AFuF++meJX5wEjmK3l3D3GlD2ar+6XvmFjuuEfgdPp0cab2GNwwSPSgJ
 oacmgOw0wUF0BIN0mU9+dZkkqscu0WZJEx6OxsyE3wWFUh3a2Dfvs9uMuyzNnhO3qKDp58+6auM
 xZCF0xecJLVPz6f9ckMz10V9Fp4ut+ikfXH1efEH+pw==
X-Gm-Gg: AYBFou2/AWrDY0pZSl4IybAQO/xxHnZWCypiJuMP87t/e9iRTa/nZSlxaPy7aZlubez
 HOPzzHKSBaIRIEmdZl6WTkMBy30E877YSAGsACHWj2q0MAM0gV/VBkrQRqhcRCCLDxhuxRqg1Mw
 p91TRjBuwS+8yiFC+P24yT14eLcUTauINWssV5p2bqtwwi4EFNFwIfR1lSNDF2ivDbTIvKxK8Jn
 yvQGEOckIKoYETjpgFadgYo1NXpCFtJzZQNXo7h7IX9E35RT6OvkcPdQdOvvMpXJEMeG8xsQTnG
 LrdkwJdNKaqzswIM5V2eN1EcStsuTtbgj98yf8ilAw3UgtwivB2BC/c=
X-Received: by 2002:a17:907:7207:b0:c21:7bf1:2c88 with SMTP id
 a640c23a62f3a-c2625035993mr485082566b.2.1788767563965; Mon, 07 Sep 2026
 00:52:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260901160333.29859-1-jinpu.wang@ionos.com>
 <20260901160333.29859-2-jinpu.wang@ionos.com>
 <b3eb97b7-f6a8-4cd6-9ae7-de98fe854f5a@gmail.com>
In-Reply-To: <b3eb97b7-f6a8-4cd6-9ae7-de98fe854f5a@gmail.com>
From: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date: Mon, 7 Sep 2026 09:52:23 +0200
X-Gm-Features: AcwNN1Ue-8tBbx-7RB39O0t-Eq0pIAQJWfyOICuFKF8yJs2jtrm41d_-rXwcFXg
Message-ID: <CAMGffE=q0KMYfDeJ6o4sUV6cZwMfhmfShnbU8BOVptb-Fp+zUg@mail.gmail.com>
Subject: Re: [PATCH 1/2] migration/rdma: send small control messages inline
To: Yanfei Xu <isyanfei.xu@gmail.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Li Zhijian <lizhijian@fujitsu.com>,
 yanfei.xu@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:34::10;
 envelope-from=jinpu.wang@ionos.com; helo=mail-ej2-x10.google.com
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

Hi Yanfei,

You're right on both points, and I traced this through rdma-core to confirm=
.

On the QP-allocation failure: in the mlx5 provider,
mlx5_calc_send_wqe() computes the WQE size from the requested
max_inline_data and returns -EINVAL if it exceeds the device's max SQ
descriptor size.
I also checked whether we could query the device's max inline
capability up front instead of retrying blind =E2=80=94 we can't.That's
because the limit depends on the whole combination of requested QP
caps, not a fixed device constant =E2=80=94 so there's nothing to query in
advance.

On the SQ footprint point: agreed, it's a real per-QP memory cost
regardless of whether 512B is ever used.

Given all that, the fix has to be create-and-retry: request our size,
and on failure retry with a reduced value (or 0) until ibv_create_qp()
succeeds. I'll send a patch for that, along with shrinking the initial
request from 512 down to something closer to our real payload sizes
(max 40B).

Regards,
Jack

On Sat, Sep 5, 2026 at 8:11=E2=80=AFAM Yanfei Xu <isyanfei.xu@gmail.com> wr=
ote:
>
>
> On 2026/9/1 23:51, Jack Wang wrote:
> > From: Jack Wang <jinpu.wang@cloud.ionos.com>
> >
> > Control-channel sends (registration requests, ram block replies, etc.)
> > are tiny, but the HCA still does a separate memory read to fetch them
> > before sending. Ask the QP for a little inline send space at creation
> > time, and use it whenever a message is small enough to fit, so the
> > HCA can just copy the bytes straight out of the work request instead.
> >
> > Falls back to the old path if the provider grants less inline room
> > than we asked for, or none at all. No wire protocol change.
> >
> > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > ---
> >   migration/rdma.c | 22 ++++++++++++++++++++++
> >   1 file changed, 22 insertions(+)
> >
> > diff --git a/migration/rdma.c b/migration/rdma.c
> > index e976739fad3c..08f3b901be4a 100644
> > --- a/migration/rdma.c
> > +++ b/migration/rdma.c
> > @@ -66,6 +66,14 @@ static inline uint64_t rdma_merge_max(void)
> >   #define RDMA_CONTROL_MAX_BUFFER (512 * 1024)
> >   #define RDMA_CONTROL_MAX_COMMANDS_PER_MESSAGE 4096
> >
> > +/*
> > + * Requested max_inline_data for the QP: enough for a control header
> > + * plus the largest fixed-size control payload, so small control
> > + * messages can be sent inline instead of via a separate HCA-side
> > + * memory read.
> > + */
> > +#define RDMA_CONTROL_MAX_INLINE_DATA 512
> > +
> >   #define RDMA_CONTROL_VERSION_CURRENT 1
> >   /*
> >    * Capabilities for negotiation.
> > @@ -329,6 +337,7 @@ typedef struct RDMAContext {
> >       struct ibv_context          *verbs;
> >       struct rdma_event_channel   *channel;
> >       struct ibv_qp *qp;                      /* queue pair */
> > +    uint32_t max_inline_data;               /* max size for inline sen=
ds */
> >       struct ibv_comp_channel *recv_comp_channel;  /* recv completion c=
hannel */
> >       struct ibv_comp_channel *send_comp_channel;  /* send completion c=
hannel */
> >       struct ibv_pd *pd;                      /* protection domain */
> > @@ -936,6 +945,14 @@ static int qemu_rdma_alloc_qp(RDMAContext *rdma)
> >       attr.cap.max_recv_wr =3D 3;
> >       attr.cap.max_send_sge =3D 1;
> >       attr.cap.max_recv_sge =3D 1;
> > +    /*
> > +     * Ask for enough inline data to cover a control header plus the
> > +     * largest fixed-size control payload (RDMARegister/RDMACompress),
> > +     * so those sends can skip a local memory read on the HCA.  The
> > +     * provider may grant less (or none); qemu_rdma_post_send_control(=
)
>
> Seems it's actually opposite? From my understanding, QP allocation will
> failed if
> the required size is greater than provider's max inline cap.
>
> Then just sharing some my findings after learning about the inline
> feature: I
> found that requesting 512 bytes of inline data isn't free. Providers
> generally
> size the SQ for the worst-case WQE, so allowing a 512-byte inline
> payload may
> significantly increase both the maximum WQE size and the total SQ memory
> footprint.
>
> Regards,
> Yanfei
>
> > +     * checks the actual granted size before using IBV_SEND_INLINE.
> > +     */
> > +    attr.cap.max_inline_data =3D RDMA_CONTROL_MAX_INLINE_DATA;
> >       attr.send_cq =3D rdma->send_cq;
> >       attr.recv_cq =3D rdma->recv_cq;
> >       attr.qp_type =3D IBV_QPT_RC;
> > @@ -945,6 +962,7 @@ static int qemu_rdma_alloc_qp(RDMAContext *rdma)
> >       }
> >
> >       rdma->qp =3D rdma->cm_id->qp;
> > +    rdma->max_inline_data =3D attr.cap.max_inline_data;
> >       return 0;
> >   }
> >
> > @@ -1447,6 +1465,10 @@ static int qemu_rdma_post_send_control(RDMAConte=
xt *rdma, uint8_t *buf,
> >                                      .num_sge =3D 1,
> >                                   };
> >
> > +    if (sge.length <=3D rdma->max_inline_data) {
> > +        send_wr.send_flags |=3D IBV_SEND_INLINE;
> > +    }
> > +
> >       trace_rdma_post_send_control(control_desc(head->type));
> >
> >       /*

