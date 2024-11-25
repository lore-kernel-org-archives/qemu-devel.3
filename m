Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E8C7D58090
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 12:50:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFYXM-0004vt-Oc; Mon, 25 Nov 2024 07:49:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1tFYX7-0004vA-Vy
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 07:49:42 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1tFYX4-00087N-1c
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 07:49:41 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5cffb4ff85eso6085122a12.2
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 04:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1732538975; x=1733143775; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+0fFi3W4xiYyYfhYRjD/OroqcNMi5B8MMgrXwsqk9xM=;
 b=XpY+ypmkNpimuSnz5ra//5YHb2UFmwxHIF7D8E1bYnrxwUVI3v3far4m8fSlIlbiys
 XNi/HcsXzW4CD71QdfkfSlWHIdPIDQ5yP1U/zbI+0zRoaLgumMEoQ+SANxySQSM1Oap3
 Cs+tDBF6/w1q9FIMnLqyoA+MvcG0Zt+jeOT6steK6J8au062s5zoF9SHVtzxodJUtlJy
 X+Pgn2mAAGoPhjTq8yz6RmDaveWitDkL5LTiSaF2fogMEFHg1zotxVyJjnY0pIjGetRZ
 7vbjTDbP3W8QhIQ64w/s9slaLdgZ0r+XYO5vEYmQuD/E8m6HaCkpKcatJCTwO63gE2oW
 yeUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732538975; x=1733143775;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+0fFi3W4xiYyYfhYRjD/OroqcNMi5B8MMgrXwsqk9xM=;
 b=b/pJZNBu9HLSvjyWBBmXli0dQp0I53yF7NtvrTwefTwNwjh3Bm7IpDiiq6BSAVBVR/
 J1o1AJkYPrELK2dyYFzlWSmKqazpKjCK0ACQ2RZ2ANUi5aILmVvX1HUxTTz+t3nCrqUu
 kQixliEnLfABqgUqCxIhm3kkmvv86pEXKR0sbYMXZm1v4C0JvGNXRQJCwDldOseae9lr
 on9ABA3iUTa+yhOfQ04vdJu3beqH9Z1U1qotBy8IXq0JUupbYBWryx0U022Yf8pF2u5m
 e682fpKF9C6gvTpFQxT5qqkQR4hFBuvdVSgYQuJS9QJdAvJhIVjp0LYYdQDhsbe+NS8Q
 PlcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+tNvrtbPAJys1+GyzjQDna8dgj9RI04H3zY5GMdNP8/C0U9SdPp47wNCNMfUKSHTc1XpqP2n0MxVT@nongnu.org
X-Gm-Message-State: AOJu0YwGgE4kWlx94Hn305msK8Lb1GVY01YuoB19LwtU2c0xmhCbYWOv
 Cwpwk2YOFm4TzFVN7t+QQd8vBjyIn8oAcrJzoqUGYEVF1hhXbNn2XMF+Cg9Lc2fVB9L3eSpuP8U
 4UJkNo09C8mAJ8O+1zyL3qTm/Y+rZO51WxWFUig==
X-Gm-Gg: ASbGncusr9cmATp8cYfAFekW35E4iNrEtANgANZc++Ss1lnR6hbVSdvfHlAeBh9guaA
 KEI05E8JYWpa0peAIw2ffQwMxOk+OJ3b6y5x7d+rxspEap5iIkreh7gzb+DqI+M6D9Q==
X-Google-Smtp-Source: AGHT+IH4NvgvYrHcfJD6sen0KK52aiyU3r6okXJFePFy511qghxUySE6N1eITZmtDeUFqRLqHXsxOupJcj663Lm2CG8=
X-Received: by 2002:a05:6402:2789:b0:5cf:a1c1:5289 with SMTP id
 4fb4d7f45d1cf-5d020695205mr11118864a12.21.1732538975402; Mon, 25 Nov 2024
 04:49:35 -0800 (PST)
MIME-Version: 1.0
References: <20241108110147.11178-1-jason.chien@sifive.com>
 <d7958a78-b2c3-484d-83ae-7ec933ffeee2@ventanamicro.com>
In-Reply-To: <d7958a78-b2c3-484d-83ae-7ec933ffeee2@ventanamicro.com>
From: Jason Chien <jason.chien@sifive.com>
Date: Mon, 25 Nov 2024 20:49:23 +0800
Message-ID: <CADr__8rwuiaeCXsGET9tBF7wnKZBY4NqK3xyepU=q8GbPkGvVQ@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv/riscv-iommu.c: Introduce a translation tag for
 the page table cache
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Tomasz Jeznach <tjeznach@rivosinc.com>, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: multipart/alternative; boundary="000000000000306bca0627bc2a62"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=jason.chien@sifive.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000306bca0627bc2a62
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tomasz, any thoughs?

Daniel Henrique Barboza <dbarboza@ventanamicro.com> =E6=96=BC 2024=E5=B9=B4=
11=E6=9C=8812=E6=97=A5 =E9=80=B1=E4=BA=8C
=E4=B8=8B=E5=8D=888:26=E5=AF=AB=E9=81=93=EF=BC=9A

>
> CCing Tomasz
>
> On 11/8/24 8:01 AM, Jason Chien wrote:
> > This commit introduces a translation tag to avoid invalidating an entry
> > that should not be invalidated when IOMMU executes invalidation command=
s.
> > E.g. IOTINVAL.VMA with GV=3D0, AV=3D0, PSCV=3D1 invalidates both a mapp=
ing
> > of single stage translation and a mapping of nested translation with
> > the same PSCID, but only the former one should be invalidated.
> >
> > Signed-off-by: Jason Chien <jason.chien@sifive.com>
> > ---
>
>
> LGTM but I would like to hear from Tomasz if adding this new abstraction =
is
> the best way to what seems to be a bug in riscv_iommu_process_cq_tail().
>
>
> Daniel
>
>
> >   hw/riscv/riscv-iommu.c | 205 ++++++++++++++++++++++++++++++----------=
-
> >   1 file changed, 153 insertions(+), 52 deletions(-)
> >
> > diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> > index ff9deefe37..ac6bbf91d6 100644
> > --- a/hw/riscv/riscv-iommu.c
> > +++ b/hw/riscv/riscv-iommu.c
> > @@ -64,8 +64,16 @@ struct RISCVIOMMUContext {
> >       uint64_t msiptp;            /* MSI redirection page table pointer
> */
> >   };
> >
> > +typedef enum RISCVIOMMUTransTag {
> > +    RISCV_IOMMU_TRANS_TAG_BY,  /* Bypass */
> > +    RISCV_IOMMU_TRANS_TAG_SS,  /* Single Stage */
> > +    RISCV_IOMMU_TRANS_TAG_VG,  /* G-stage only */
> > +    RISCV_IOMMU_TRANS_TAG_VN,  /* Nested translation */
> > +} RISCVIOMMUTransTag;
> > +
> >   /* Address translation cache entry */
> >   struct RISCVIOMMUEntry {
> > +    RISCVIOMMUTransTag tag;     /* Translation Tag */
> >       uint64_t iova:44;           /* IOVA Page Number */
> >       uint64_t pscid:20;          /* Process Soft-Context identifier */
> >       uint64_t phys:44;           /* Physical Page Number */
> > @@ -1228,7 +1236,7 @@ static gboolean
> riscv_iommu_iot_equal(gconstpointer v1, gconstpointer v2)
> >       RISCVIOMMUEntry *t1 =3D (RISCVIOMMUEntry *) v1;
> >       RISCVIOMMUEntry *t2 =3D (RISCVIOMMUEntry *) v2;
> >       return t1->gscid =3D=3D t2->gscid && t1->pscid =3D=3D t2->pscid &=
&
> > -           t1->iova =3D=3D t2->iova;
> > +           t1->iova =3D=3D t2->iova && t1->tag =3D=3D t2->tag;
> >   }
> >
> >   static guint riscv_iommu_iot_hash(gconstpointer v)
> > @@ -1237,67 +1245,115 @@ static guint riscv_iommu_iot_hash(gconstpointe=
r
> v)
> >       return (guint)t->iova;
> >   }
> >
> > -/* GV: 1 PSCV: 1 AV: 1 */
> > +/* GV: 0 AV: 0 PSCV: 0 GVMA: 0 */
> > +/* GV: 0 AV: 0 GVMA: 1 */
> > +static
> > +void riscv_iommu_iot_inval_all(gpointer key, gpointer value, gpointer
> data)
> > +{
> > +    RISCVIOMMUEntry *iot =3D (RISCVIOMMUEntry *) value;
> > +    RISCVIOMMUEntry *arg =3D (RISCVIOMMUEntry *) data;
> > +    if (iot->tag =3D=3D arg->tag) {
> > +        iot->perm =3D IOMMU_NONE;
> > +    }
> > +}
> > +
> > +/* GV: 0 AV: 0 PSCV: 1 GVMA: 0 */
> > +static
> > +void riscv_iommu_iot_inval_pscid(gpointer key, gpointer value, gpointe=
r
> data)
> > +{
> > +    RISCVIOMMUEntry *iot =3D (RISCVIOMMUEntry *) value;
> > +    RISCVIOMMUEntry *arg =3D (RISCVIOMMUEntry *) data;
> > +    if (iot->tag =3D=3D arg->tag &&
> > +        iot->pscid =3D=3D arg->pscid) {
> > +        iot->perm =3D IOMMU_NONE;
> > +    }
> > +}
> > +
> > +/* GV: 0 AV: 1 PSCV: 0 GVMA: 0 */
> > +static
> > +void riscv_iommu_iot_inval_iova(gpointer key, gpointer value, gpointer
> data)
> > +{
> > +    RISCVIOMMUEntry *iot =3D (RISCVIOMMUEntry *) value;
> > +    RISCVIOMMUEntry *arg =3D (RISCVIOMMUEntry *) data;
> > +    if (iot->tag =3D=3D arg->tag &&
> > +        iot->iova =3D=3D arg->iova) {
> > +        iot->perm =3D IOMMU_NONE;
> > +    }
> > +}
> > +
> > +/* GV: 0 AV: 1 PSCV: 1 GVMA: 0 */
> >   static void riscv_iommu_iot_inval_pscid_iova(gpointer key, gpointer
> value,
> >                                                gpointer data)
> >   {
> >       RISCVIOMMUEntry *iot =3D (RISCVIOMMUEntry *) value;
> >       RISCVIOMMUEntry *arg =3D (RISCVIOMMUEntry *) data;
> > -    if (iot->gscid =3D=3D arg->gscid &&
> > +    if (iot->tag =3D=3D arg->tag &&
> >           iot->pscid =3D=3D arg->pscid &&
> >           iot->iova =3D=3D arg->iova) {
> >           iot->perm =3D IOMMU_NONE;
> >       }
> >   }
> >
> > -/* GV: 1 PSCV: 1 AV: 0 */
> > -static void riscv_iommu_iot_inval_pscid(gpointer key, gpointer value,
> > -                                        gpointer data)
> > +/* GV: 1 AV: 0 PSCV: 0 GVMA: 0 */
> > +/* GV: 1 AV: 0 GVMA: 1 */
> > +static
> > +void riscv_iommu_iot_inval_gscid(gpointer key, gpointer value, gpointe=
r
> data)
> >   {
> >       RISCVIOMMUEntry *iot =3D (RISCVIOMMUEntry *) value;
> >       RISCVIOMMUEntry *arg =3D (RISCVIOMMUEntry *) data;
> > -    if (iot->gscid =3D=3D arg->gscid &&
> > -        iot->pscid =3D=3D arg->pscid) {
> > +    if (iot->tag =3D=3D arg->tag &&
> > +        iot->gscid =3D=3D arg->gscid) {
> >           iot->perm =3D IOMMU_NONE;
> >       }
> >   }
> >
> > -/* GV: 1 GVMA: 1 */
> > -static void riscv_iommu_iot_inval_gscid_gpa(gpointer key, gpointer
> value,
> > -                                            gpointer data)
> > +/* GV: 1 AV: 0 PSCV: 1 GVMA: 0 */
> > +static void riscv_iommu_iot_inval_gscid_pscid(gpointer key, gpointer
> value,
> > +                                              gpointer data)
> >   {
> >       RISCVIOMMUEntry *iot =3D (RISCVIOMMUEntry *) value;
> >       RISCVIOMMUEntry *arg =3D (RISCVIOMMUEntry *) data;
> > -    if (iot->gscid =3D=3D arg->gscid) {
> > -        /* simplified cache, no GPA matching */
> > +    if (iot->tag =3D=3D arg->tag &&
> > +        iot->gscid =3D=3D arg->gscid &&
> > +        iot->pscid =3D=3D arg->pscid) {
> >           iot->perm =3D IOMMU_NONE;
> >       }
> >   }
> >
> > -/* GV: 1 GVMA: 0 */
> > -static void riscv_iommu_iot_inval_gscid(gpointer key, gpointer value,
> > -                                        gpointer data)
> > +/* GV: 1 AV: 1 PSCV: 0 GVMA: 0 */
> > +/* GV: 1 AV: 1 GVMA: 1 */
> > +static void riscv_iommu_iot_inval_gscid_iova(gpointer key, gpointer
> value,
> > +                                             gpointer data)
> >   {
> >       RISCVIOMMUEntry *iot =3D (RISCVIOMMUEntry *) value;
> >       RISCVIOMMUEntry *arg =3D (RISCVIOMMUEntry *) data;
> > -    if (iot->gscid =3D=3D arg->gscid) {
> > +    if (iot->tag =3D=3D arg->tag &&
> > +        iot->gscid =3D=3D arg->gscid &&
> > +        iot->iova =3D=3D arg->iova) {
> >           iot->perm =3D IOMMU_NONE;
> >       }
> >   }
> >
> > -/* GV: 0 */
> > -static void riscv_iommu_iot_inval_all(gpointer key, gpointer value,
> > -                                      gpointer data)
> > +/* GV: 1 AV: 1 PSCV: 1 GVMA: 0 */
> > +static void riscv_iommu_iot_inval_gscid_pscid_iova(gpointer key,
> gpointer value,
> > +                                                   gpointer data)
> >   {
> >       RISCVIOMMUEntry *iot =3D (RISCVIOMMUEntry *) value;
> > -    iot->perm =3D IOMMU_NONE;
> > +    RISCVIOMMUEntry *arg =3D (RISCVIOMMUEntry *) data;
> > +    if (iot->tag =3D=3D arg->tag &&
> > +        iot->gscid =3D=3D arg->gscid &&
> > +        iot->pscid =3D=3D arg->pscid &&
> > +        iot->iova =3D=3D arg->iova) {
> > +        iot->perm =3D IOMMU_NONE;
> > +    }
> >   }
> >
> >   /* caller should keep ref-count for iot_cache object */
> >   static RISCVIOMMUEntry *riscv_iommu_iot_lookup(RISCVIOMMUContext *ctx=
,
> > -    GHashTable *iot_cache, hwaddr iova)
> > +    GHashTable *iot_cache, hwaddr iova, RISCVIOMMUTransTag transtag)
> >   {
> >       RISCVIOMMUEntry key =3D {
> > +        .tag   =3D transtag,
> >           .gscid =3D get_field(ctx->gatp, RISCV_IOMMU_DC_IOHGATP_GSCID)=
,
> >           .pscid =3D get_field(ctx->ta, RISCV_IOMMU_DC_TA_PSCID),
> >           .iova  =3D PPN_DOWN(iova),
> > @@ -1323,10 +1379,11 @@ static void
> riscv_iommu_iot_update(RISCVIOMMUState *s,
> >   }
> >
> >   static void riscv_iommu_iot_inval(RISCVIOMMUState *s, GHFunc func,
> > -    uint32_t gscid, uint32_t pscid, hwaddr iova)
> > +    uint32_t gscid, uint32_t pscid, hwaddr iova, RISCVIOMMUTransTag
> transtag)
> >   {
> >       GHashTable *iot_cache;
> >       RISCVIOMMUEntry key =3D {
> > +        .tag =3D transtag,
> >           .gscid =3D gscid,
> >           .pscid =3D pscid,
> >           .iova  =3D PPN_DOWN(iova),
> > @@ -1337,9 +1394,24 @@ static void riscv_iommu_iot_inval(RISCVIOMMUStat=
e
> *s, GHFunc func,
> >       g_hash_table_unref(iot_cache);
> >   }
> >
> > +static RISCVIOMMUTransTag riscv_iommu_get_transtag(RISCVIOMMUContext
> *ctx)
> > +{
> > +    uint64_t satp =3D get_field(ctx->satp, RISCV_IOMMU_ATP_MODE_FIELD)=
;
> > +    uint64_t gatp =3D get_field(ctx->gatp, RISCV_IOMMU_ATP_MODE_FIELD)=
;
> > +
> > +    if (satp =3D=3D RISCV_IOMMU_DC_FSC_MODE_BARE) {
> > +        return (gatp =3D=3D RISCV_IOMMU_DC_IOHGATP_MODE_BARE) ?
> > +            RISCV_IOMMU_TRANS_TAG_BY : RISCV_IOMMU_TRANS_TAG_VG;
> > +    } else {
> > +        return (gatp =3D=3D RISCV_IOMMU_DC_IOHGATP_MODE_BARE) ?
> > +            RISCV_IOMMU_TRANS_TAG_SS : RISCV_IOMMU_TRANS_TAG_VN;
> > +    }
> > +}
> > +
> >   static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContex=
t
> *ctx,
> >       IOMMUTLBEntry *iotlb, bool enable_cache)
> >   {
> > +    RISCVIOMMUTransTag transtag =3D riscv_iommu_get_transtag(ctx);
> >       RISCVIOMMUEntry *iot;
> >       IOMMUAccessFlags perm;
> >       bool enable_pid;
> > @@ -1365,7 +1437,7 @@ static int riscv_iommu_translate(RISCVIOMMUState
> *s, RISCVIOMMUContext *ctx,
> >           }
> >       }
> >
> > -    iot =3D riscv_iommu_iot_lookup(ctx, iot_cache, iotlb->iova);
> > +    iot =3D riscv_iommu_iot_lookup(ctx, iot_cache, iotlb->iova, transt=
ag);
> >       perm =3D iot ? iot->perm : IOMMU_NONE;
> >       if (perm !=3D IOMMU_NONE) {
> >           iotlb->translated_addr =3D PPN_PHYS(iot->phys);
> > @@ -1396,6 +1468,7 @@ static int riscv_iommu_translate(RISCVIOMMUState
> *s, RISCVIOMMUContext *ctx,
> >           iot->gscid =3D get_field(ctx->gatp,
> RISCV_IOMMU_DC_IOHGATP_GSCID);
> >           iot->pscid =3D get_field(ctx->ta, RISCV_IOMMU_DC_TA_PSCID);
> >           iot->perm =3D iotlb->perm;
> > +        iot->tag =3D transtag;
> >           riscv_iommu_iot_update(s, iot_cache, iot);
> >       }
> >
> > @@ -1603,44 +1676,72 @@ static void
> riscv_iommu_process_cq_tail(RISCVIOMMUState *s)
> >
> >           case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IOTINVAL_FUNC_GVMA,
> >                                RISCV_IOMMU_CMD_IOTINVAL_OPCODE):
> > -            if (cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_PSCV) {
> > +        {
> > +            bool gv =3D !!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_GV);
> > +            bool av =3D !!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_AV);
> > +            bool pscv =3D !!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_PSC=
V);
> > +            uint32_t gscid =3D get_field(cmd.dword0,
> > +                                       RISCV_IOMMU_CMD_IOTINVAL_GSCID)=
;
> > +            uint32_t pscid =3D get_field(cmd.dword0,
> > +                                       RISCV_IOMMU_CMD_IOTINVAL_PSCID)=
;
> > +            hwaddr iova =3D (cmd.dword1 << 2) & TARGET_PAGE_MASK;
> > +
> > +            if (pscv) {
> >                   /* illegal command arguments IOTINVAL.GVMA & PSCV =3D=
=3D 1
> */
> >                   goto cmd_ill;
> > -            } else if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_GV)) {
> > -                /* invalidate all cache mappings */
> > -                func =3D riscv_iommu_iot_inval_all;
> > -            } else if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_AV)) {
> > -                /* invalidate cache matching GSCID */
> > -                func =3D riscv_iommu_iot_inval_gscid;
> > -            } else {
> > -                /* invalidate cache matching GSCID and ADDR (GPA) */
> > -                func =3D riscv_iommu_iot_inval_gscid_gpa;
> >               }
> > -            riscv_iommu_iot_inval(s, func,
> > -                get_field(cmd.dword0, RISCV_IOMMU_CMD_IOTINVAL_GSCID),
> 0,
> > -                cmd.dword1 << 2 & TARGET_PAGE_MASK);
> > +
> > +            func =3D riscv_iommu_iot_inval_all;
> > +
> > +            if (gv) {
> > +                func =3D (av) ? riscv_iommu_iot_inval_gscid_iova :
> > +                              riscv_iommu_iot_inval_gscid;
> > +            }
> > +
> > +            riscv_iommu_iot_inval(
> > +                s, func, gscid, pscid, iova, RISCV_IOMMU_TRANS_TAG_VG)=
;
> > +
> > +            riscv_iommu_iot_inval(
> > +                s, func, gscid, pscid, iova, RISCV_IOMMU_TRANS_TAG_VN)=
;
> >               break;
> > +        }
> >
> >           case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IOTINVAL_FUNC_VMA,
> >                                RISCV_IOMMU_CMD_IOTINVAL_OPCODE):
> > -            if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_GV)) {
> > -                /* invalidate all cache mappings, simplified model */
> > -                func =3D riscv_iommu_iot_inval_all;
> > -            } else if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_PSCV)) =
{
> > -                /* invalidate cache matching GSCID, simplified model *=
/
> > -                func =3D riscv_iommu_iot_inval_gscid;
> > -            } else if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_AV)) {
> > -                /* invalidate cache matching GSCID and PSCID */
> > -                func =3D riscv_iommu_iot_inval_pscid;
> > +        {
> > +            bool gv =3D !!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_GV);
> > +            bool av =3D !!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_AV);
> > +            bool pscv =3D !!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_PSC=
V);
> > +            uint32_t gscid =3D get_field(cmd.dword0,
> > +                                       RISCV_IOMMU_CMD_IOTINVAL_GSCID)=
;
> > +            uint32_t pscid =3D get_field(cmd.dword0,
> > +                                       RISCV_IOMMU_CMD_IOTINVAL_PSCID)=
;
> > +            hwaddr iova =3D (cmd.dword1 << 2) & TARGET_PAGE_MASK;
> > +            RISCVIOMMUTransTag transtag;
> > +
> > +            if (gv) {
> > +                transtag =3D RISCV_IOMMU_TRANS_TAG_VN;
> > +                if (pscv) {
> > +                    func =3D (av) ?
> riscv_iommu_iot_inval_gscid_pscid_iova :
> > +                                  riscv_iommu_iot_inval_gscid_pscid;
> > +                } else {
> > +                    func =3D (av) ? riscv_iommu_iot_inval_gscid_iova :
> > +                                  riscv_iommu_iot_inval_gscid;
> > +                }
> >               } else {
> > -                /* invalidate cache matching GSCID and PSCID and ADDR
> (IOVA) */
> > -                func =3D riscv_iommu_iot_inval_pscid_iova;
> > +                transtag =3D RISCV_IOMMU_TRANS_TAG_SS;
> > +                if (pscv) {
> > +                    func =3D (av) ? riscv_iommu_iot_inval_pscid_iova :
> > +                                  riscv_iommu_iot_inval_pscid;
> > +                } else {
> > +                    func =3D (av) ? riscv_iommu_iot_inval_iova :
> > +                                  riscv_iommu_iot_inval_all;
> > +                }
> >               }
> > -            riscv_iommu_iot_inval(s, func,
> > -                get_field(cmd.dword0, RISCV_IOMMU_CMD_IOTINVAL_GSCID),
> > -                get_field(cmd.dword0, RISCV_IOMMU_CMD_IOTINVAL_PSCID),
> > -                cmd.dword1 << 2 & TARGET_PAGE_MASK);
> > +
> > +            riscv_iommu_iot_inval(s, func, gscid, pscid, iova,
> transtag);
> >               break;
> > +        }
> >
> >           case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IODIR_FUNC_INVAL_DDT,
> >                                RISCV_IOMMU_CMD_IODIR_OPCODE):
>
>

--000000000000306bca0627bc2a62
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Tomasz, any thoughs?</div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">Daniel Henrique Barboza &lt;<a href=
=3D"mailto:dbarboza@ventanamicro.com">dbarboza@ventanamicro.com</a>&gt; =E6=
=96=BC 2024=E5=B9=B411=E6=9C=8812=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=
=8D=888:26=E5=AF=AB=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex"><br>
CCing Tomasz<br>
<br>
On 11/8/24 8:01 AM, Jason Chien wrote:<br>
&gt; This commit introduces a translation tag to avoid invalidating an entr=
y<br>
&gt; that should not be invalidated when IOMMU executes invalidation comman=
ds.<br>
&gt; E.g. IOTINVAL.VMA with GV=3D0, AV=3D0, PSCV=3D1 invalidates both a map=
ping<br>
&gt; of single stage translation and a mapping of nested translation with<b=
r>
&gt; the same PSCID, but only the former one should be invalidated.<br>
&gt; <br>
&gt; Signed-off-by: Jason Chien &lt;<a href=3D"mailto:jason.chien@sifive.co=
m" target=3D"_blank">jason.chien@sifive.com</a>&gt;<br>
&gt; ---<br>
<br>
<br>
LGTM but I would like to hear from Tomasz if adding this new abstraction is=
<br>
the best way to what seems to be a bug in riscv_iommu_process_cq_tail().<br=
>
<br>
<br>
Daniel<br>
<br>
<br>
&gt;=C2=A0 =C2=A0hw/riscv/riscv-iommu.c | 205 +++++++++++++++++++++++++++++=
+-----------<br>
&gt;=C2=A0 =C2=A01 file changed, 153 insertions(+), 52 deletions(-)<br>
&gt; <br>
&gt; diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c<br>
&gt; index ff9deefe37..ac6bbf91d6 100644<br>
&gt; --- a/hw/riscv/riscv-iommu.c<br>
&gt; +++ b/hw/riscv/riscv-iommu.c<br>
&gt; @@ -64,8 +64,16 @@ struct RISCVIOMMUContext {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t msiptp;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 /* MSI redirection page table pointer */<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +typedef enum RISCVIOMMUTransTag {<br>
&gt; +=C2=A0 =C2=A0 RISCV_IOMMU_TRANS_TAG_BY,=C2=A0 /* Bypass */<br>
&gt; +=C2=A0 =C2=A0 RISCV_IOMMU_TRANS_TAG_SS,=C2=A0 /* Single Stage */<br>
&gt; +=C2=A0 =C2=A0 RISCV_IOMMU_TRANS_TAG_VG,=C2=A0 /* G-stage only */<br>
&gt; +=C2=A0 =C2=A0 RISCV_IOMMU_TRANS_TAG_VN,=C2=A0 /* Nested translation *=
/<br>
&gt; +} RISCVIOMMUTransTag;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0/* Address translation cache entry */<br>
&gt;=C2=A0 =C2=A0struct RISCVIOMMUEntry {<br>
&gt; +=C2=A0 =C2=A0 RISCVIOMMUTransTag tag;=C2=A0 =C2=A0 =C2=A0/* Translati=
on Tag */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t iova:44;=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0/* IOVA Page Number */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t pscid:20;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* Process Soft-Context identifier */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t phys:44;=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0/* Physical Page Number */<br>
&gt; @@ -1228,7 +1236,7 @@ static gboolean riscv_iommu_iot_equal(gconstpoin=
ter v1, gconstpointer v2)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0RISCVIOMMUEntry *t1 =3D (RISCVIOMMUEntry *) =
v1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0RISCVIOMMUEntry *t2 =3D (RISCVIOMMUEntry *) =
v2;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return t1-&gt;gscid =3D=3D t2-&gt;gscid &amp=
;&amp; t1-&gt;pscid =3D=3D t2-&gt;pscid &amp;&amp;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0t1-&gt;iova =3D=3D t2-&gt;io=
va;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0t1-&gt;iova =3D=3D t2-&gt;io=
va &amp;&amp; t1-&gt;tag =3D=3D t2-&gt;tag;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static guint riscv_iommu_iot_hash(gconstpointer v)<br>
&gt; @@ -1237,67 +1245,115 @@ static guint riscv_iommu_iot_hash(gconstpoint=
er v)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return (guint)t-&gt;iova;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -/* GV: 1 PSCV: 1 AV: 1 */<br>
&gt; +/* GV: 0 AV: 0 PSCV: 0 GVMA: 0 */<br>
&gt; +/* GV: 0 AV: 0 GVMA: 1 */<br>
&gt; +static<br>
&gt; +void riscv_iommu_iot_inval_all(gpointer key, gpointer value, gpointer=
 data)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 RISCVIOMMUEntry *iot =3D (RISCVIOMMUEntry *) value;<br>
&gt; +=C2=A0 =C2=A0 RISCVIOMMUEntry *arg =3D (RISCVIOMMUEntry *) data;<br>
&gt; +=C2=A0 =C2=A0 if (iot-&gt;tag =3D=3D arg-&gt;tag) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 iot-&gt;perm =3D IOMMU_NONE;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* GV: 0 AV: 0 PSCV: 1 GVMA: 0 */<br>
&gt; +static<br>
&gt; +void riscv_iommu_iot_inval_pscid(gpointer key, gpointer value, gpoint=
er data)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 RISCVIOMMUEntry *iot =3D (RISCVIOMMUEntry *) value;<br>
&gt; +=C2=A0 =C2=A0 RISCVIOMMUEntry *arg =3D (RISCVIOMMUEntry *) data;<br>
&gt; +=C2=A0 =C2=A0 if (iot-&gt;tag =3D=3D arg-&gt;tag &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 iot-&gt;pscid =3D=3D arg-&gt;pscid) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 iot-&gt;perm =3D IOMMU_NONE;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* GV: 0 AV: 1 PSCV: 0 GVMA: 0 */<br>
&gt; +static<br>
&gt; +void riscv_iommu_iot_inval_iova(gpointer key, gpointer value, gpointe=
r data)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 RISCVIOMMUEntry *iot =3D (RISCVIOMMUEntry *) value;<br>
&gt; +=C2=A0 =C2=A0 RISCVIOMMUEntry *arg =3D (RISCVIOMMUEntry *) data;<br>
&gt; +=C2=A0 =C2=A0 if (iot-&gt;tag =3D=3D arg-&gt;tag &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 iot-&gt;iova =3D=3D arg-&gt;iova) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 iot-&gt;perm =3D IOMMU_NONE;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* GV: 0 AV: 1 PSCV: 1 GVMA: 0 */<br>
&gt;=C2=A0 =C2=A0static void riscv_iommu_iot_inval_pscid_iova(gpointer key,=
 gpointer value,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 gpointer data)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0RISCVIOMMUEntry *iot =3D (RISCVIOMMUEntry *)=
 value;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0RISCVIOMMUEntry *arg =3D (RISCVIOMMUEntry *)=
 data;<br>
&gt; -=C2=A0 =C2=A0 if (iot-&gt;gscid =3D=3D arg-&gt;gscid &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 if (iot-&gt;tag =3D=3D arg-&gt;tag &amp;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iot-&gt;pscid =3D=3D arg-&gt;p=
scid &amp;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iot-&gt;iova =3D=3D arg-&gt;io=
va) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iot-&gt;perm =3D IOMMU_NONE;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -/* GV: 1 PSCV: 1 AV: 0 */<br>
&gt; -static void riscv_iommu_iot_inval_pscid(gpointer key, gpointer value,=
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gpoi=
nter data)<br>
&gt; +/* GV: 1 AV: 0 PSCV: 0 GVMA: 0 */<br>
&gt; +/* GV: 1 AV: 0 GVMA: 1 */<br>
&gt; +static<br>
&gt; +void riscv_iommu_iot_inval_gscid(gpointer key, gpointer value, gpoint=
er data)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0RISCVIOMMUEntry *iot =3D (RISCVIOMMUEntry *)=
 value;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0RISCVIOMMUEntry *arg =3D (RISCVIOMMUEntry *)=
 data;<br>
&gt; -=C2=A0 =C2=A0 if (iot-&gt;gscid =3D=3D arg-&gt;gscid &amp;&amp;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 iot-&gt;pscid =3D=3D arg-&gt;pscid) {<br>
&gt; +=C2=A0 =C2=A0 if (iot-&gt;tag =3D=3D arg-&gt;tag &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 iot-&gt;gscid =3D=3D arg-&gt;gscid) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iot-&gt;perm =3D IOMMU_NONE;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -/* GV: 1 GVMA: 1 */<br>
&gt; -static void riscv_iommu_iot_inval_gscid_gpa(gpointer key, gpointer va=
lue,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 gpointer data)<br>
&gt; +/* GV: 1 AV: 0 PSCV: 1 GVMA: 0 */<br>
&gt; +static void riscv_iommu_iot_inval_gscid_pscid(gpointer key, gpointer =
value,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 gpointer data)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0RISCVIOMMUEntry *iot =3D (RISCVIOMMUEntry *)=
 value;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0RISCVIOMMUEntry *arg =3D (RISCVIOMMUEntry *)=
 data;<br>
&gt; -=C2=A0 =C2=A0 if (iot-&gt;gscid =3D=3D arg-&gt;gscid) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* simplified cache, no GPA matching */<b=
r>
&gt; +=C2=A0 =C2=A0 if (iot-&gt;tag =3D=3D arg-&gt;tag &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 iot-&gt;gscid =3D=3D arg-&gt;gscid &amp;&=
amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 iot-&gt;pscid =3D=3D arg-&gt;pscid) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iot-&gt;perm =3D IOMMU_NONE;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -/* GV: 1 GVMA: 0 */<br>
&gt; -static void riscv_iommu_iot_inval_gscid(gpointer key, gpointer value,=
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gpoi=
nter data)<br>
&gt; +/* GV: 1 AV: 1 PSCV: 0 GVMA: 0 */<br>
&gt; +/* GV: 1 AV: 1 GVMA: 1 */<br>
&gt; +static void riscv_iommu_iot_inval_gscid_iova(gpointer key, gpointer v=
alue,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0gpointer data)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0RISCVIOMMUEntry *iot =3D (RISCVIOMMUEntry *)=
 value;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0RISCVIOMMUEntry *arg =3D (RISCVIOMMUEntry *)=
 data;<br>
&gt; -=C2=A0 =C2=A0 if (iot-&gt;gscid =3D=3D arg-&gt;gscid) {<br>
&gt; +=C2=A0 =C2=A0 if (iot-&gt;tag =3D=3D arg-&gt;tag &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 iot-&gt;gscid =3D=3D arg-&gt;gscid &amp;&=
amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 iot-&gt;iova =3D=3D arg-&gt;iova) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iot-&gt;perm =3D IOMMU_NONE;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -/* GV: 0 */<br>
&gt; -static void riscv_iommu_iot_inval_all(gpointer key, gpointer value,<b=
r>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gpointer da=
ta)<br>
&gt; +/* GV: 1 AV: 1 PSCV: 1 GVMA: 0 */<br>
&gt; +static void riscv_iommu_iot_inval_gscid_pscid_iova(gpointer key, gpoi=
nter value,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gpointer data)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0RISCVIOMMUEntry *iot =3D (RISCVIOMMUEntry *)=
 value;<br>
&gt; -=C2=A0 =C2=A0 iot-&gt;perm =3D IOMMU_NONE;<br>
&gt; +=C2=A0 =C2=A0 RISCVIOMMUEntry *arg =3D (RISCVIOMMUEntry *) data;<br>
&gt; +=C2=A0 =C2=A0 if (iot-&gt;tag =3D=3D arg-&gt;tag &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 iot-&gt;gscid =3D=3D arg-&gt;gscid &amp;&=
amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 iot-&gt;pscid =3D=3D arg-&gt;pscid &amp;&=
amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 iot-&gt;iova =3D=3D arg-&gt;iova) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 iot-&gt;perm =3D IOMMU_NONE;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0/* caller should keep ref-count for iot_cache object */<br=
>
&gt;=C2=A0 =C2=A0static RISCVIOMMUEntry *riscv_iommu_iot_lookup(RISCVIOMMUC=
ontext *ctx,<br>
&gt; -=C2=A0 =C2=A0 GHashTable *iot_cache, hwaddr iova)<br>
&gt; +=C2=A0 =C2=A0 GHashTable *iot_cache, hwaddr iova, RISCVIOMMUTransTag =
transtag)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0RISCVIOMMUEntry key =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .tag=C2=A0 =C2=A0=3D transtag,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.gscid =3D get_field(ctx-&gt;g=
atp, RISCV_IOMMU_DC_IOHGATP_GSCID),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.pscid =3D get_field(ctx-&gt;t=
a, RISCV_IOMMU_DC_TA_PSCID),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.iova=C2=A0 =3D PPN_DOWN(iova)=
,<br>
&gt; @@ -1323,10 +1379,11 @@ static void riscv_iommu_iot_update(RISCVIOMMUS=
tate *s,<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static void riscv_iommu_iot_inval(RISCVIOMMUState *s, GHFu=
nc func,<br>
&gt; -=C2=A0 =C2=A0 uint32_t gscid, uint32_t pscid, hwaddr iova)<br>
&gt; +=C2=A0 =C2=A0 uint32_t gscid, uint32_t pscid, hwaddr iova, RISCVIOMMU=
TransTag transtag)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0GHashTable *iot_cache;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0RISCVIOMMUEntry key =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .tag =3D transtag,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.gscid =3D gscid,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.pscid =3D pscid,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.iova=C2=A0 =3D PPN_DOWN(iova)=
,<br>
&gt; @@ -1337,9 +1394,24 @@ static void riscv_iommu_iot_inval(RISCVIOMMUSta=
te *s, GHFunc func,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0g_hash_table_unref(iot_cache);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +static RISCVIOMMUTransTag riscv_iommu_get_transtag(RISCVIOMMUContext =
*ctx)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint64_t satp =3D get_field(ctx-&gt;satp, RISCV_IOMMU_A=
TP_MODE_FIELD);<br>
&gt; +=C2=A0 =C2=A0 uint64_t gatp =3D get_field(ctx-&gt;gatp, RISCV_IOMMU_A=
TP_MODE_FIELD);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (satp =3D=3D RISCV_IOMMU_DC_FSC_MODE_BARE) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return (gatp =3D=3D RISCV_IOMMU_DC_IOHGAT=
P_MODE_BARE) ?<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RISCV_IOMMU_TRANS_TAG_BY : =
RISCV_IOMMU_TRANS_TAG_VG;<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return (gatp =3D=3D RISCV_IOMMU_DC_IOHGAT=
P_MODE_BARE) ?<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RISCV_IOMMU_TRANS_TAG_SS : =
RISCV_IOMMU_TRANS_TAG_VN;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0static int riscv_iommu_translate(RISCVIOMMUState *s, RISCV=
IOMMUContext *ctx,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0IOMMUTLBEntry *iotlb, bool enable_cache)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; +=C2=A0 =C2=A0 RISCVIOMMUTransTag transtag =3D riscv_iommu_get_transta=
g(ctx);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0RISCVIOMMUEntry *iot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0IOMMUAccessFlags perm;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool enable_pid;<br>
&gt; @@ -1365,7 +1437,7 @@ static int riscv_iommu_translate(RISCVIOMMUState=
 *s, RISCVIOMMUContext *ctx,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 iot =3D riscv_iommu_iot_lookup(ctx, iot_cache, iotlb-&g=
t;iova);<br>
&gt; +=C2=A0 =C2=A0 iot =3D riscv_iommu_iot_lookup(ctx, iot_cache, iotlb-&g=
t;iova, transtag);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0perm =3D iot ? iot-&gt;perm : IOMMU_NONE;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (perm !=3D IOMMU_NONE) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iotlb-&gt;translated_addr =3D =
PPN_PHYS(iot-&gt;phys);<br>
&gt; @@ -1396,6 +1468,7 @@ static int riscv_iommu_translate(RISCVIOMMUState=
 *s, RISCVIOMMUContext *ctx,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iot-&gt;gscid =3D get_field(ct=
x-&gt;gatp, RISCV_IOMMU_DC_IOHGATP_GSCID);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iot-&gt;pscid =3D get_field(ct=
x-&gt;ta, RISCV_IOMMU_DC_TA_PSCID);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iot-&gt;perm =3D iotlb-&gt;per=
m;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 iot-&gt;tag =3D transtag;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0riscv_iommu_iot_update(s, iot_=
cache, iot);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -1603,44 +1676,72 @@ static void riscv_iommu_process_cq_tail(RISCVI=
OMMUState *s)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case RISCV_IOMMU_CMD(RISCV_IOM=
MU_CMD_IOTINVAL_FUNC_GVMA,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RISCV_IOMMU_CMD_IOTINVAL_OPCODE):=
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cmd.dword0 &amp; RISCV_=
IOMMU_CMD_IOTINVAL_PSCV) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool gv =3D !!(cmd.dword0 &=
amp; RISCV_IOMMU_CMD_IOTINVAL_GV);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool av =3D !!(cmd.dword0 &=
amp; RISCV_IOMMU_CMD_IOTINVAL_AV);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool pscv =3D !!(cmd.dword0=
 &amp; RISCV_IOMMU_CMD_IOTINVAL_PSCV);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t gscid =3D get_fiel=
d(cmd.dword0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RISCV=
_IOMMU_CMD_IOTINVAL_GSCID);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t pscid =3D get_fiel=
d(cmd.dword0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RISCV=
_IOMMU_CMD_IOTINVAL_PSCID);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hwaddr iova =3D (cmd.dword1=
 &lt;&lt; 2) &amp; TARGET_PAGE_MASK;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pscv) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*=
 illegal command arguments IOTINVAL.GVMA &amp; PSCV =3D=3D 1 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0go=
to cmd_ill;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (!(cmd.dword0 &am=
p; RISCV_IOMMU_CMD_IOTINVAL_GV)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* invalidate=
 all cache mappings */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 func =3D risc=
v_iommu_iot_inval_all;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (!(cmd.dword0 &am=
p; RISCV_IOMMU_CMD_IOTINVAL_AV)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* invalidate=
 cache matching GSCID */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 func =3D risc=
v_iommu_iot_inval_gscid;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* invalidate=
 cache matching GSCID and ADDR (GPA) */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 func =3D risc=
v_iommu_iot_inval_gscid_gpa;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 riscv_iommu_iot_inval(s, fu=
nc,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 get_field(cmd=
.dword0, RISCV_IOMMU_CMD_IOTINVAL_GSCID), 0,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd.dword1 &l=
t;&lt; 2 &amp; TARGET_PAGE_MASK);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 func =3D riscv_iommu_iot_in=
val_all;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (gv) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 func =3D (av)=
 ? riscv_iommu_iot_inval_gscid_iova :<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 riscv_iommu_iot_inval_gscid;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 riscv_iommu_iot_inval(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s, func, gsci=
d, pscid, iova, RISCV_IOMMU_TRANS_TAG_VG);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 riscv_iommu_iot_inval(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s, func, gsci=
d, pscid, iova, RISCV_IOMMU_TRANS_TAG_VN);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case RISCV_IOMMU_CMD(RISCV_IOM=
MU_CMD_IOTINVAL_FUNC_VMA,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RISCV_IOMMU_CMD_IOTINVAL_OPCODE):=
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(cmd.dword0 &amp; RISC=
V_IOMMU_CMD_IOTINVAL_GV)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* invalidate=
 all cache mappings, simplified model */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 func =3D risc=
v_iommu_iot_inval_all;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (!(cmd.dword0 &am=
p; RISCV_IOMMU_CMD_IOTINVAL_PSCV)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* invalidate=
 cache matching GSCID, simplified model */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 func =3D risc=
v_iommu_iot_inval_gscid;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (!(cmd.dword0 &am=
p; RISCV_IOMMU_CMD_IOTINVAL_AV)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* invalidate=
 cache matching GSCID and PSCID */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 func =3D risc=
v_iommu_iot_inval_pscid;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool gv =3D !!(cmd.dword0 &=
amp; RISCV_IOMMU_CMD_IOTINVAL_GV);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool av =3D !!(cmd.dword0 &=
amp; RISCV_IOMMU_CMD_IOTINVAL_AV);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool pscv =3D !!(cmd.dword0=
 &amp; RISCV_IOMMU_CMD_IOTINVAL_PSCV);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t gscid =3D get_fiel=
d(cmd.dword0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RISCV=
_IOMMU_CMD_IOTINVAL_GSCID);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t pscid =3D get_fiel=
d(cmd.dword0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RISCV=
_IOMMU_CMD_IOTINVAL_PSCID);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hwaddr iova =3D (cmd.dword1=
 &lt;&lt; 2) &amp; TARGET_PAGE_MASK;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RISCVIOMMUTransTag transtag=
;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (gv) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 transtag =3D =
RISCV_IOMMU_TRANS_TAG_VN;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pscv) {<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 func =3D (av) ? riscv_iommu_iot_inval_gscid_pscid_iova :<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 riscv_iommu_iot_inval_gsc=
id_pscid;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 func =3D (av) ? riscv_iommu_iot_inval_gscid_iova :<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 riscv_iommu_iot_inval_gsc=
id;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* invalidate=
 cache matching GSCID and PSCID and ADDR (IOVA) */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 func =3D risc=
v_iommu_iot_inval_pscid_iova;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 transtag =3D =
RISCV_IOMMU_TRANS_TAG_SS;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pscv) {<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 func =3D (av) ? riscv_iommu_iot_inval_pscid_iova :<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 riscv_iommu_iot_inval_psc=
id;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 func =3D (av) ? riscv_iommu_iot_inval_iova :<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 riscv_iommu_iot_inval_all=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 riscv_iommu_iot_inval(s, fu=
nc,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 get_field(cmd=
.dword0, RISCV_IOMMU_CMD_IOTINVAL_GSCID),<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 get_field(cmd=
.dword0, RISCV_IOMMU_CMD_IOTINVAL_PSCID),<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd.dword1 &l=
t;&lt; 2 &amp; TARGET_PAGE_MASK);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 riscv_iommu_iot_inval(s, fu=
nc, gscid, pscid, iova, transtag);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case RISCV_IOMMU_CMD(RISCV_IOM=
MU_CMD_IODIR_FUNC_INVAL_DDT,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RISCV_IOMMU_CMD_IODIR_OPCODE):<br=
>
<br>
</blockquote></div>

--000000000000306bca0627bc2a62--

