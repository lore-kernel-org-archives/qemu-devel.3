Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E813BEB48EC
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 09:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqSdb-0001a2-0k; Thu, 12 Feb 2026 04:05:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vqSdY-0001Zf-ED
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 04:05:24 -0500
Received: from smtppost.atos.net ([193.56.114.177] helo=smarthost2.atos.net)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vqSdV-0003Rj-Ns
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 04:05:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1770887122; x=1802423122;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=j5BM0t45UF/8Nf3Su3qANVl7QZoLAfxVdqeWOZF9qcw=;
 b=DEGJtvpNvjRj3vvHdSbJbnWe5fPelQC+/Kjyu1b7AG4tr1mJZ2u+690V
 Qfu4XZqHPqu7qWkkmfqWpf9UfWwuhAQqIWZhh/Y8ITO2/FUHKy4SFlnLh
 /4/A2/fzxY/pHYhfLpgHhJlW3kmfMUm2EDzwLfHU92Pk3Wo2QzDP/+hcx
 0X9OJf2J+t4SWTEcnh2GZHQ1i5fCyTDTxNUZm29g4D0yVvfvYty5zRE1w
 Oc4UaqjdYpSU1vah093pAXRvkOZBPNLGdqDtLsy1Iwi57s2yoxZiII4Zk
 OD9CMy2dU/FSYYY6eFKXydHrGkPvm/18XQzHuSKFxjFxu4DajdtyJSVgs A==;
X-CSE-ConnectionGUID: pQOF7xX8SoGeJbNON1yy1g==
X-CSE-MsgGUID: /71zuc69QXi2KOik0+AzDw==
X-IronPort-AV: E=Sophos;i="6.21,286,1763420400"; d="scan'208";a="826674689"
X-MGA-submission: =?us-ascii?q?MDHTw/TgxxQQ+jCXasUA/FvJ4PAyiAQ8oa2Uzq?=
 =?us-ascii?q?ErKtiLM2zKwy62KrsjH5aVo+Ty1+migP+cKATHsMr2aCbHjMGXrLChr6?=
 =?us-ascii?q?amzYrkBeSSf6rt7cyPrrr782b0783vfp0kFw56r+Lw8sL+N8uKAVpU5s?=
 =?us-ascii?q?by?=
Received: from smtp0.atos-infogerance.fr ([193.56.241.18])
 by smarthost2.atos.net with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 12 Feb 2026 10:05:19 +0100
Received: from smtp-hub.atos-infogerance.fr (smtp-hub.atos-infogerance.fr
 [193.56.47.18])
 by smtp0.atos-infogerance.fr (8.15.2/8.15.2) with ESMTPS id 61C95GrR021213
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
 Thu, 12 Feb 2026 10:05:17 +0100
Received: from rocky.hd2c.dom ([129.181.244.14])
 by smtp-hub.atos-infogerance.fr (envelope-from
 clement.mathieu--drif@eviden.com) (8.15.2/8.15.2) with ESMTP id
 61C95GER001461; Thu, 12 Feb 2026 10:05:16 +0100
Received: from openbmc (unknown [10.22.85.22])
 by rocky.hd2c.dom (Postfix) with ESMTP id B066A256CA5;
 Thu, 12 Feb 2026 10:05:16 +0100 (CET)
Received: from [127.0.0.1] (host.containers.internal [10.88.0.1])
 by openbmc (Postfix) with ESMTP id E380C8104811;
 Thu, 12 Feb 2026 09:05:15 +0000 (UTC)
Message-ID: <02bb4c9d859caec478e36d3c6cde6561ba3032ca.camel@eviden.com>
Subject: Re: [RFC PATCH 05/14] intel_iommu: Change pasid property from bool
 to uint8
From: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Cc: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com"	 <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"	
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com"	 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com"
 <skolothumtho@nvidia.com>, "joao.m.martins@oracle.com"	
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L"	 <yi.l.liu@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
Date: Thu, 12 Feb 2026 10:04:55 +0100
In-Reply-To: <IA3PR11MB913635BBC7B506CD40FADD779260A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260205031133.74357-1-zhenzhong.duan@intel.com>
 <20260205031133.74357-6-zhenzhong.duan@intel.com>
 <4ecdbe5bb0b3a945b3534e8535186280aa8f4f66.camel@eviden.com>
 <IA3PR11MB913635BBC7B506CD40FADD779260A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
MIME-Version: 1.0
Received-SPF: pass client-ip=193.56.114.177;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.atos.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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


On Thu, 2026-02-12 at 08:16 +0000, Duan, Zhenzhong wrote:
>=20
>=20
>=20
> > -----Original Message-----
> > From: Clement Mathieu--Drif <[clement.mathieu--drif@eviden.com](mailto:=
clement.mathieu--drif@eviden.com)>
> > Subject: Re: [RFC PATCH 05/14] intel_iommu: Change pasid property from =
bool to
> > uint8
> >=20
> >=20
> > On Wed, 2026-02-04 at 22:11 -0500, Zhenzhong Duan wrote:
> >=20
> > > 'x-pasid-mode' is a bool property, we need an extra 'pss' property to
> > > represent PASID size supported. Because there is no any device in QEM=
U
> > > supporting pasid capability yet, no guest could use the pasid feature
> > > until now, 'x-pasid-mode' takes no effect.
> > >=20
> > > So instead of an extra 'pss' property we can use a single 'pasid'
> > > property of uint8 type to represent if pasid is supported and the PAS=
ID
> > > bits size. A value of N > 0 means pasid is supported and N - 1 is the
> > > value in PSS field in ECAP register.
> > >=20
> > > Signed-off-by: Zhenzhong Duan
> >=20
> > <[[zhenzhong.duan@intel.com](mailto:zhenzhong.duan@intel.com)](mailto:[=
zhenzhong.duan@intel.com](mailto:zhenzhong.duan@intel.com))>
> >=20
> > > ---
> > > =C2=A0hw/i386/intel_iommu_internal.h | 1 -
> > > =C2=A0include/hw/i386/intel_iommu.h=C2=A0 | 2 +-
> > > =C2=A0hw/i386/intel_iommu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 4 ++--
> > > =C2=A03 files changed, 3 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_int=
ernal.h
> > > index a2ca79f925..71cb3b662e 100644
> > > --- a/hw/i386/intel_iommu_internal.h
> > > +++ b/hw/i386/intel_iommu_internal.h
> > > @@ -194,7 +194,6 @@
> > > =C2=A0#define VTD_ECAP_PRS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1ULL << 29)
> > > =C2=A0#define VTD_ECAP_MHMV=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (15ULL << 20)
> > > =C2=A0#define VTD_ECAP_SRS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1ULL << 31)
> > > -#define VTD_ECAP_PSS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (7ULL << 35) /* limit: MemTxAttr=
s::pid */
> > > =C2=A0#define VTD_ECAP_PASID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1ULL << 40)
> > > =C2=A0#define VTD_ECAP_SMTS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1ULL << 43)
> > > =C2=A0#define VTD_ECAP_SSTS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1ULL << 46)
> > > diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_io=
mmu.h
> > > index 6c61fd39c7..5e5779e460 100644
> > > --- a/include/hw/i386/intel_iommu.h
> > > +++ b/include/hw/i386/intel_iommu.h
> > > @@ -315,7 +315,7 @@ struct IntelIOMMUState {
> > > =C2=A0=C2=A0=C2=A0=C2=A0 bool buggy_eim;=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Fo=
rce buggy EIM unless eim=3Doff */
> > > =C2=A0=C2=A0=C2=A0=C2=A0 uint8_t aw_bits;=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Host/IOV=
A address width (in bits) */
> > > =C2=A0=C2=A0=C2=A0=C2=A0 bool dma_drain;=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Wh=
ether DMA r/w draining enabled */
> > > -=C2=A0=C2=A0=C2=A0 bool pasid;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 /* Whether to support PASID */
> > > +=C2=A0=C2=A0=C2=A0 uint8_t pasid;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* PA=
SID supported in bits, 0 if not */
> > > =C2=A0=C2=A0=C2=A0=C2=A0 bool fs1gp;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 /* First Stage 1-GByte Page Support */
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0 /* Transient Mapping, Reserved(0) since VTD =
spec revision 3.2 */
> > > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > > index e8a6f50a5a..916eb0af5a 100644
> > > --- a/hw/i386/intel_iommu.c
> > > +++ b/hw/i386/intel_iommu.c
> > > @@ -4151,7 +4151,7 @@ static const Property vtd_properties[] =3D {
> > > =C2=A0=C2=A0=C2=A0=C2=A0 DEFINE_PROP_BOOL("x-scalable-mode", IntelIOM=
MUState, scalable_mode,
> >=20
> > FALSE),
> >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0 DEFINE_PROP_BOOL("x-flts", IntelIOMMUState, =
fsts, FALSE),
> > > =C2=A0=C2=A0=C2=A0=C2=A0 DEFINE_PROP_BOOL("snoop-control", IntelIOMMU=
State, snoop_control,
> >=20
> > false),
> >=20
> > > -=C2=A0=C2=A0=C2=A0 DEFINE_PROP_BOOL("x-pasid-mode", IntelIOMMUState,=
 pasid, false),
> > > +=C2=A0=C2=A0=C2=A0 DEFINE_PROP_UINT8("pasid", IntelIOMMUState, pasid=
, 0),
> > > =C2=A0=C2=A0=C2=A0=C2=A0 DEFINE_PROP_BOOL("dma-drain", IntelIOMMUStat=
e, dma_drain, true),
> > > =C2=A0=C2=A0=C2=A0=C2=A0 DEFINE_PROP_BOOL("stale-tm", IntelIOMMUState=
, stale_tm, false),
> > > =C2=A0=C2=A0=C2=A0=C2=A0 DEFINE_PROP_BOOL("fs1gp", IntelIOMMUState, f=
s1gp, true),
> > > @@ -4981,7 +4981,7 @@ static void vtd_cap_init(IntelIOMMUState *s)
> > > =C2=A0=C2=A0=C2=A0=C2=A0 }
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0 if (s->pasid) {
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->ecap |=3D VTD_ECAP_PAS=
ID | VTD_ECAP_PSS;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->ecap =3D VTD_ECAP_PASI=
D | deposit64(s->ecap, 35, 5, s->pasid - 1);
> >=20
> >=20
> > I think this is a bit dangerous, the MemTxAttrs only allow up to 8 bits=
.
> > We have a comment next to the definition of VTD_ECAP_PSS about this.
>=20
>=20
> Could you elaborate what dangerous do you see if s->pasid > 8? =20
> MemTxAttrs only allow up to 8bits, then Max PASID Width in emulated devic=
e's =20
> PASID capability Register is no more than 8. Emulated device should never=
 send =20
> a Request-with-pasid with pasid > 255.
>=20
> Hard code VTD_ECAP_PSS to 8 bits will make us not able to utilize the ful=
l pasid =20
> space of passthrough device if it has larger Max PASID Width value in pas=
id capability.
>=20

The previous approach was to make sure that the kernel never allocates a to=
o large pasid =20
by limiting the width in the iommu instead of doint it in the devices. Your=
 patch seems to =20
reverse the problem. Is it something we are ready to accept?

> Thanks =20
> Zhenzhong

