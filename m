Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B02C5472E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 02:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1simC4-0000Yi-Km; Mon, 26 Aug 2024 22:44:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tjeznach@rivosinc.com>)
 id 1simC3-0000Xe-DA
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 22:44:27 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tjeznach@rivosinc.com>)
 id 1simC0-0006IV-Kj
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 22:44:27 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2d3c5f769d6so3332540a91.3
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 19:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724726662; x=1725331462;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nhuh+6yzzlz/odGaFP7ttp56YwlRDh0kVuawuw+tXEQ=;
 b=FcojsfIkcfRmkhi1xvA/Fz1fwlQAmrDyJy9Yja7oSB4/wiF5OfrN5m2dMw/cKaXaCz
 VOps0lv+fJYQ+MBs5eM48iUzhIpFZQ2nmu9VHWYq9H3WU/WVTn+wS8mWM3K33NP3NUz3
 pk3hcixKjSvULDg7sChMsew+fdl/bRHGDmm/fQg3CZUu6g9zllYB5Ln2ph982oI5Pb+D
 //0nciFPzdtrel1PzQLgtM3wRb6HuM5Lb5zPY/cikz6c3ry7q18Su1krIfpJm1t6mkWc
 7EZ3ehZGxIYl2GDing2Xt3Df9+QQKpokcAhlHhGWtQcZbtZZSRnVoJIvaQrxZ+wTrKue
 iwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724726662; x=1725331462;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nhuh+6yzzlz/odGaFP7ttp56YwlRDh0kVuawuw+tXEQ=;
 b=KvKcs8khYQpca6NiafwG+/KeZgx0pUODT0EkI6Ey1UEXTwyq1gmyGTbZ76/2/jAkoy
 ftsjoNSodUuaxKwOxPNUYTVfz5h49g049zpulxkMZ18XCKFUxOrFtarCFuUJ8XFs2YLk
 IYXGUqvVG6qLMivtXU5KPLK2ZHy1Q1OZALDlzIsmRyffnuRMv0IZGY8nRp1a6xYMXI/p
 OG7hbNNDJJYlowsk2LyvEwCjhE7tY+yuJxoCJgJ/55JNkjpHFTJyjF2XSmgdU53/F6Yl
 DNEsgumPAkCJtxSjXjFjvLK01iYk1/RATRmdxst1iuVh+EUcaC1RDPBQT24JLsOujBs0
 L1Rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSjCjjkIWkHIFr7uyLwgFBMvJHX/OpwuclCQeQ4tUH6GKOPsZqQJ3l6LbbNoANuvhvdU4g30FHyGn9@nongnu.org
X-Gm-Message-State: AOJu0YwQ3aHoUO2DhVOJNQhduZj7DRqSeqCIUoXwuq4nFlcNmKVE6BU5
 fnyY10ttIRJ2SPVRP74UBqINnqTDQ6jh8M7c7Sy8ArNwWMMVidNLt1j8YLZ/jk3bTtgq7JWTENm
 +4jHElxlHt5Sh0/8lmYnYzu662N/K1Lgp473IKw==
X-Google-Smtp-Source: AGHT+IG4zoBz/Kq5bz79I8ttKIuNGhDag4dbZvDXqo25qO1R8kglNR5HhkmYg5yFtL2JMUIOul6GTcwhEvUg0jS+2LM=
X-Received: by 2002:a17:90a:6406:b0:2c9:923e:faf1 with SMTP id
 98e67ed59e1d1-2d646bce1c5mr11706257a91.18.1724726662218; Mon, 26 Aug 2024
 19:44:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240801154334.1009852-1-dbarboza@ventanamicro.com>
 <20240801154334.1009852-9-dbarboza@ventanamicro.com>
 <922b33c4-d01a-44d1-a2b8-ef7cb1b1d30a@sifive.com>
 <c2af15b8-fc22-4154-97e6-6f38b33796b7@ventanamicro.com>
In-Reply-To: <c2af15b8-fc22-4154-97e6-6f38b33796b7@ventanamicro.com>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Mon, 26 Aug 2024 19:44:11 -0700
Message-ID: <CAH2o1u6g+MBVJYikAkEnWOWQ-v3WGPdVrS0_tn9JY5b=MrD0BA@mail.gmail.com>
Subject: Re: [PATCH for-9.2 v6 08/12] hw/riscv/riscv-iommu: add Address
 Translation Cache (IOATC)
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Jason Chien <jason.chien@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 alistair.francis@wdc.com, bmeng@tinylab.org, liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, frank.chang@sifive.com, 
 ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=tjeznach@rivosinc.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Aug 23, 2024 at 10:18=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
>
>
> On 8/20/24 12:27 PM, Jason Chien wrote:
> > Hi Daniel,
> >
> > On 2024/8/1 =E4=B8=8B=E5=8D=88 11:43, Daniel Henrique Barboza wrote:
> >> From: Tomasz Jeznach <tjeznach@rivosinc.com>
> >>
> >> The RISC-V IOMMU spec predicts that the IOMMU can use translation cach=
es
> >> to hold entries from the DDT. This includes implementation for all cac=
he
> >> commands that are marked as 'not implemented'.
> >>
> >> There are some artifacts included in the cache that predicts s-stage a=
nd
> >> g-stage elements, although we don't support it yet. We'll introduce th=
em
> >> next.
> >>
> >> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> >> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> >> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> >> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> >> ---
> >>   hw/riscv/riscv-iommu.c | 199 +++++++++++++++++++++++++++++++++++++++=
+-
> >>   hw/riscv/riscv-iommu.h |   3 +
> >>   2 files changed, 198 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> >> index ebe3a53a04..3816e6a493 100644
> >> --- a/hw/riscv/riscv-iommu.c
> >> +++ b/hw/riscv/riscv-iommu.c
> >> @@ -65,6 +65,16 @@ struct RISCVIOMMUContext {
> >>       uint64_t msiptp;            /* MSI redirection page table pointe=
r */
> >>   };
> >> +/* Address translation cache entry */
> >> +struct RISCVIOMMUEntry {
> >> +    uint64_t iova:44;           /* IOVA Page Number */
> >> +    uint64_t pscid:20;          /* Process Soft-Context identifier */
> >> +    uint64_t phys:44;           /* Physical Page Number */
> >> +    uint64_t gscid:16;          /* Guest Soft-Context identifier */
> >> +    uint64_t perm:2;            /* IOMMU_RW flags */
> >> +    uint64_t __rfu:2;
> >> +};
> >> +
> >>   /* IOMMU index for transactions without process_id specified. */
> >>   #define RISCV_IOMMU_NOPROCID 0
> >> @@ -1138,13 +1148,130 @@ static AddressSpace *riscv_iommu_space(RISCVI=
OMMUState *s, uint32_t devid)
> >>       return &as->iova_as;
> >>   }
> >> +/* Translation Object cache support */
> >> +static gboolean __iot_equal(gconstpointer v1, gconstpointer v2)
> >> +{
> >> +    RISCVIOMMUEntry *t1 =3D (RISCVIOMMUEntry *) v1;
> >> +    RISCVIOMMUEntry *t2 =3D (RISCVIOMMUEntry *) v2;
> >> +    return t1->gscid =3D=3D t2->gscid && t1->pscid =3D=3D t2->pscid &=
&
> >> +           t1->iova =3D=3D t2->iova;
> >> +}
> >> +
> >> +static guint __iot_hash(gconstpointer v)
> >> +{
> >> +    RISCVIOMMUEntry *t =3D (RISCVIOMMUEntry *) v;
> >> +    return (guint)t->iova;
> >> +}
> >> +
> >> +/* GV: 1 PSCV: 1 AV: 1 */
> >> +static void __iot_inval_pscid_iova(gpointer key, gpointer value, gpoi=
nter data)
> >> +{
> >> +    RISCVIOMMUEntry *iot =3D (RISCVIOMMUEntry *) value;
> >> +    RISCVIOMMUEntry *arg =3D (RISCVIOMMUEntry *) data;
> >> +    if (iot->gscid =3D=3D arg->gscid &&
> >> +        iot->pscid =3D=3D arg->pscid &&
> >> +        iot->iova =3D=3D arg->iova) {
> >> +        iot->perm =3D IOMMU_NONE;
> >> +    }
> >> +}
> >> +
> >> +/* GV: 1 PSCV: 1 AV: 0 */
> >> +static void __iot_inval_pscid(gpointer key, gpointer value, gpointer =
data)
> >> +{
> >> +    RISCVIOMMUEntry *iot =3D (RISCVIOMMUEntry *) value;
> >> +    RISCVIOMMUEntry *arg =3D (RISCVIOMMUEntry *) data;
> >> +    if (iot->gscid =3D=3D arg->gscid &&
> >> +        iot->pscid =3D=3D arg->pscid) {
> >> +        iot->perm =3D IOMMU_NONE;
> >> +    }
> >> +}
> >> +
> >> +/* GV: 1 GVMA: 1 */
> >> +static void __iot_inval_gscid_gpa(gpointer key, gpointer value, gpoin=
ter data)
> >> +{
> >> +    RISCVIOMMUEntry *iot =3D (RISCVIOMMUEntry *) value;
> >> +    RISCVIOMMUEntry *arg =3D (RISCVIOMMUEntry *) data;
> >> +    if (iot->gscid =3D=3D arg->gscid) {
> >> +        /* simplified cache, no GPA matching */
> >> +        iot->perm =3D IOMMU_NONE;
> >> +    }
> >> +}
> >> +
> >> +/* GV: 1 GVMA: 0 */
> >> +static void __iot_inval_gscid(gpointer key, gpointer value, gpointer =
data)
> >> +{
> >> +    RISCVIOMMUEntry *iot =3D (RISCVIOMMUEntry *) value;
> >> +    RISCVIOMMUEntry *arg =3D (RISCVIOMMUEntry *) data;
> >> +    if (iot->gscid =3D=3D arg->gscid) {
> >> +        iot->perm =3D IOMMU_NONE;
> >> +    }
> >> +}
> >> +
> >> +/* GV: 0 */
> >> +static void __iot_inval_all(gpointer key, gpointer value, gpointer da=
ta)
> >> +{
> >> +    RISCVIOMMUEntry *iot =3D (RISCVIOMMUEntry *) value;
> >> +    iot->perm =3D IOMMU_NONE;
> >> +}
> >> +
> >> +/* caller should keep ref-count for iot_cache object */
> >> +static RISCVIOMMUEntry *riscv_iommu_iot_lookup(RISCVIOMMUContext *ctx=
,
> >> +    GHashTable *iot_cache, hwaddr iova)
> >> +{
> >> +    RISCVIOMMUEntry key =3D {
> >> +        .gscid =3D get_field(ctx->gatp, RISCV_IOMMU_DC_IOHGATP_GSCID)=
,
> >> +        .pscid =3D get_field(ctx->ta, RISCV_IOMMU_DC_TA_PSCID),
> >> +        .iova  =3D PPN_DOWN(iova),
> >> +    };
> >> +    return g_hash_table_lookup(iot_cache, &key);
> >> +}
> >> +
> >> +/* caller should keep ref-count for iot_cache object */
> >> +static void riscv_iommu_iot_update(RISCVIOMMUState *s,
> >> +    GHashTable *iot_cache, RISCVIOMMUEntry *iot)
> >> +{
> >> +    if (!s->iot_limit) {
> >> +        return;
> >> +    }
> >> +
> >> +    qemu_mutex_lock(&s->iot_lock);
> >> +    if (g_hash_table_size(s->iot_cache) >=3D s->iot_limit) {
> >> +        iot_cache =3D g_hash_table_new_full(__iot_hash, __iot_equal,
> >> +                                          g_free, NULL);
> >> +        g_hash_table_unref(qatomic_xchg(&s->iot_cache, iot_cache));
> >> +    }
> >> +    g_hash_table_add(iot_cache, iot);
> >> +    qemu_mutex_unlock(&s->iot_lock);
> >> +}
> >> +
> >> +static void riscv_iommu_iot_inval(RISCVIOMMUState *s, GHFunc func,
> >> +    uint32_t gscid, uint32_t pscid, hwaddr iova)
> >> +{
> >> +    GHashTable *iot_cache;
> >> +    RISCVIOMMUEntry key =3D {
> >> +        .gscid =3D gscid,
> >> +        .pscid =3D pscid,
> >> +        .iova  =3D PPN_DOWN(iova),
> >> +    };
> >> +
> >> +    iot_cache =3D g_hash_table_ref(s->iot_cache);
> >> +    qemu_mutex_lock(&s->iot_lock);
> >> +    g_hash_table_foreach(iot_cache, func, &key);
> >> +    qemu_mutex_unlock(&s->iot_lock);
> >> +    g_hash_table_unref(iot_cache);
> >> +}
> >> +
> >>   static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUConte=
xt *ctx,
> >> -    IOMMUTLBEntry *iotlb)
> >> +    IOMMUTLBEntry *iotlb, bool enable_cache)
> >>   {
> >> +    RISCVIOMMUEntry *iot;
> >> +    IOMMUAccessFlags perm;
> >>       bool enable_pid;
> >>       bool enable_pri;
> >> +    GHashTable *iot_cache;
> >>       int fault;
> >> +    iot_cache =3D g_hash_table_ref(s->iot_cache);
> >>       /*
> >>        * TC[32] is reserved for custom extensions, used here to tempor=
arily
> >>        * enable automatic page-request generation for ATS queries.
> >> @@ -1152,9 +1279,39 @@ static int riscv_iommu_translate(RISCVIOMMUStat=
e *s, RISCVIOMMUContext *ctx,
> >>       enable_pri =3D (iotlb->perm =3D=3D IOMMU_NONE) && (ctx->tc & BIT=
_ULL(32));
> >>       enable_pid =3D (ctx->tc & RISCV_IOMMU_DC_TC_PDTV);
> >> +    qemu_mutex_lock(&s->iot_lock);
> >> +    iot =3D riscv_iommu_iot_lookup(ctx, iot_cache, iotlb->iova);
> >> +    qemu_mutex_unlock(&s->iot_lock);
> >> +    perm =3D iot ? iot->perm : IOMMU_NONE;
> >> +    if (perm !=3D IOMMU_NONE) {
> >> +        iotlb->translated_addr =3D PPN_PHYS(iot->phys);
> >> +        iotlb->addr_mask =3D ~TARGET_PAGE_MASK;
> >> +        iotlb->perm =3D perm;
> >> +        fault =3D 0;
> >> +        goto done;
> >> +    }
> >> +
> >>       /* Translate using device directory / page table information. */
> >>       fault =3D riscv_iommu_spa_fetch(s, ctx, iotlb);
> >> +    if (!fault && iotlb->target_as =3D=3D &s->trap_as) {
> >> +        /* Do not cache trapped MSI translations */
> >> +        goto done;
> >> +    }
> >> +
> >> +    if (!fault && iotlb->translated_addr !=3D iotlb->iova && enable_c=
ache) {
> > Shouldn't addresses which don't need to be translated also be cached?
>
> I think it doesn't hurt to cache these addresses too. Just updated the ch=
eck to:
>
>      if (!fault && enable_cache) {
>
>

Note: It was an implementation choice to not cache identity-mapped
translations, as allowed by the specification, to avoid translation
cache evictions for other devices sharing the IOMMU hardware model.
Unless there is a strong reason to enable IOATC here, I'd suggest not
caching such entries.

Thanks,
- Tomasz

>
> Thanks,
>
> Daniel
>
>
> >> +        iot =3D g_new0(RISCVIOMMUEntry, 1);
> >> +        iot->iova =3D PPN_DOWN(iotlb->iova);
> >> +        iot->phys =3D PPN_DOWN(iotlb->translated_addr);
> >> +        iot->gscid =3D get_field(ctx->gatp, RISCV_IOMMU_DC_IOHGATP_GS=
CID);
> >> +        iot->pscid =3D get_field(ctx->ta, RISCV_IOMMU_DC_TA_PSCID);
> >> +        iot->perm =3D iotlb->perm;
> >> +        riscv_iommu_iot_update(s, iot_cache, iot);
> >> +    }
> >> +
> >> +done:
> >> +    g_hash_table_unref(iot_cache);
> >> +
> >>       if (enable_pri && fault) {
> >>           struct riscv_iommu_pq_record pr =3D {0};
> >>           if (enable_pid) {
> >> @@ -1294,13 +1451,40 @@ static void riscv_iommu_process_cq_tail(RISCVI=
OMMUState *s)
> >>               if (cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_PSCV) {
> >>                   /* illegal command arguments IOTINVAL.GVMA & PSCV =
=3D=3D 1 */
> >>                   goto cmd_ill;
> >> +            } else if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_GV)) {
> >> +                /* invalidate all cache mappings */
> >> +                func =3D __iot_inval_all;
> >> +            } else if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_AV)) {
> >> +                /* invalidate cache matching GSCID */
> >> +                func =3D __iot_inval_gscid;
> >> +            } else {
> >> +                /* invalidate cache matching GSCID and ADDR (GPA) */
> >> +                func =3D __iot_inval_gscid_gpa;
> >>               }
> >> -            /* translation cache not implemented yet */
> >> +            riscv_iommu_iot_inval(s, func,
> >> +                get_field(cmd.dword0, RISCV_IOMMU_CMD_IOTINVAL_GSCID)=
, 0,
> >> +                cmd.dword1 & TARGET_PAGE_MASK);
> >>               break;
> >>           case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IOTINVAL_FUNC_VMA,
> >>                                RISCV_IOMMU_CMD_IOTINVAL_OPCODE):
> >> -            /* translation cache not implemented yet */
> >> +            if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_GV)) {
> >> +                /* invalidate all cache mappings, simplified model */
> >> +                func =3D __iot_inval_all;
> >> +            } else if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_PSCV))=
 {
> >> +                /* invalidate cache matching GSCID, simplified model =
*/
> >> +                func =3D __iot_inval_gscid;
> >> +            } else if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_AV)) {
> >> +                /* invalidate cache matching GSCID and PSCID */
> >> +                func =3D __iot_inval_pscid;
> >> +            } else {
> >> +                /* invalidate cache matching GSCID and PSCID and ADDR=
 (IOVA) */
> >> +                func =3D __iot_inval_pscid_iova;
> >> +            }
> >> +            riscv_iommu_iot_inval(s, func,
> >> +                get_field(cmd.dword0, RISCV_IOMMU_CMD_IOTINVAL_GSCID)=
,
> >> +                get_field(cmd.dword0, RISCV_IOMMU_CMD_IOTINVAL_PSCID)=
,
> >> +                cmd.dword1 & TARGET_PAGE_MASK);
> >>               break;
> >>           case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IODIR_FUNC_INVAL_DDT,
> >> @@ -1824,6 +2008,10 @@ static void riscv_iommu_realize(DeviceState *de=
v, Error **errp)
> >>                                            g_free, NULL);
> >>       qemu_mutex_init(&s->ctx_lock);
> >> +    s->iot_cache =3D g_hash_table_new_full(__iot_hash, __iot_equal,
> >> +                                         g_free, NULL);
> >> +    qemu_mutex_init(&s->iot_lock);
> >> +
> >>       s->iommus.le_next =3D NULL;
> >>       s->iommus.le_prev =3D NULL;
> >>       QLIST_INIT(&s->spaces);
> >> @@ -1836,6 +2024,7 @@ static void riscv_iommu_unrealize(DeviceState *d=
ev)
> >>       RISCVIOMMUState *s =3D RISCV_IOMMU(dev);
> >>       qemu_mutex_destroy(&s->core_lock);
> >> +    g_hash_table_unref(s->iot_cache);
> >>       g_hash_table_unref(s->ctx_cache);
> >>   }
> >> @@ -1843,6 +2032,8 @@ static Property riscv_iommu_properties[] =3D {
> >>       DEFINE_PROP_UINT32("version", RISCVIOMMUState, version,
> >>           RISCV_IOMMU_SPEC_DOT_VER),
> >>       DEFINE_PROP_UINT32("bus", RISCVIOMMUState, bus, 0x0),
> >> +    DEFINE_PROP_UINT32("ioatc-limit", RISCVIOMMUState, iot_limit,
> >> +        LIMIT_CACHE_IOT),
> >>       DEFINE_PROP_BOOL("intremap", RISCVIOMMUState, enable_msi, TRUE),
> >>       DEFINE_PROP_BOOL("off", RISCVIOMMUState, enable_off, TRUE),
> >>       DEFINE_PROP_BOOL("s-stage", RISCVIOMMUState, enable_s_stage, TRU=
E),
> >> @@ -1897,7 +2088,7 @@ static IOMMUTLBEntry riscv_iommu_memory_region_t=
ranslate(
> >>           /* Translation disabled or invalid. */
> >>           iotlb.addr_mask =3D 0;
> >>           iotlb.perm =3D IOMMU_NONE;
> >> -    } else if (riscv_iommu_translate(as->iommu, ctx, &iotlb)) {
> >> +    } else if (riscv_iommu_translate(as->iommu, ctx, &iotlb, true)) {
> >>           /* Translation disabled or fault reported. */
> >>           iotlb.addr_mask =3D 0;
> >>           iotlb.perm =3D IOMMU_NONE;
> >> diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
> >> index 6d76cb9b1a..c917b6219a 100644
> >> --- a/hw/riscv/riscv-iommu.h
> >> +++ b/hw/riscv/riscv-iommu.h
> >> @@ -75,6 +75,9 @@ struct RISCVIOMMUState {
> >>       GHashTable *ctx_cache;          /* Device translation Context Ca=
che */
> >>       QemuMutex ctx_lock;      /* Device translation Cache update lock=
 */
> >> +    GHashTable *iot_cache;          /* IO Translated Address Cache */
> >> +    QemuMutex iot_lock;      /* IO TLB Cache update lock */
> >> +    unsigned iot_limit;             /* IO Translation Cache size limi=
t */
> >>       /* MMIO Hardware Interface */
> >>       MemoryRegion regs_mr;

