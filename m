Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6145EDF04C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 07:48:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqRQy-0003JF-Jc; Thu, 12 Feb 2026 02:48:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vqRQu-0003Hi-T6
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 02:48:17 -0500
Received: from smtppost.atos.net ([193.56.114.177] helo=smarthost2.atos.net)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vqRQs-0005eU-Qe
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 02:48:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1770882495; x=1802418495;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=YZpqoQZYKUj1fzFZDV4/iwb1f0KnaO0vAyLx/fr3N4A=;
 b=hnRAY07NsvUDSHgVtVGhRkf96+fsqTEkdAGg7yb+Y28yQL85oofx50iJ
 bSPofpPh3hvC8fmAaoNDGXe5mzI7q7k2oM1LzeL+8NihzKFKqPbEF+Qfx
 ZDXutLFtnXt2+9jtLJAjt1ljLFrKSAR2WYs7AF0L9/SRu03HYy3g89Vq1
 Y139Ya8oL/fLVM2LDfBkKAf03Nfo2qydo7C/f/m2E14ByTYfQX2uLfMCO
 D9JwZ02ym27iWAdMqw68CG7ZuKFeFg3wrS9dYexQM1XPRqFQ9JGsdoGTm
 JLvZp2Bk2JyLo3AYTEwMOB8OXwYtMDCO5eoxSeUaXEG1wHeDIc7a3mJgp A==;
X-CSE-ConnectionGUID: /jnEhS8eRQSm15sOZTykDg==
X-CSE-MsgGUID: RqGu5D42Rqm7tUu+jjoufg==
X-IronPort-AV: E=Sophos;i="6.21,286,1763420400"; d="scan'208";a="826654235"
X-MGA-submission: =?us-ascii?q?MDFbfwqP3bZbX44YZINiWFw5xwsTK4kikQcf5o?=
 =?us-ascii?q?OiMA4SphJlmCH8vRxz1ww6XRH5SUp3bloXKCRJ1cFZ+9OyaEJkaFl88K?=
 =?us-ascii?q?vxwNCLM1A/auCOM0wu22SRlAfem8cs2FaH5cpPjc4zhJm2zWY6VE5dQH?=
 =?us-ascii?q?OF?=
Received: from smtp1.atos-infogerance.fr ([193.56.241.17])
 by smarthost2.atos.net with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 12 Feb 2026 08:48:14 +0100
Received: from smtp-hub.atos-infogerance.fr (smtp-hub.atos-infogerance.fr
 [193.56.47.18])
 by smtp1.atos-infogerance.fr (8.15.2/8.15.2) with ESMTPS id 61C7mDKL027029
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
 Thu, 12 Feb 2026 08:48:13 +0100
Received: from rocky.hd2c.dom ([129.181.244.14])
 by smtp-hub.atos-infogerance.fr (envelope-from
 clement.mathieu--drif@eviden.com) (8.15.2/8.15.2) with ESMTP id
 61C7mDQ3039045; Thu, 12 Feb 2026 08:48:13 +0100
Received: from openbmc (unknown [10.22.85.22])
 by rocky.hd2c.dom (Postfix) with ESMTP id CE67D256CA5;
 Thu, 12 Feb 2026 08:48:12 +0100 (CET)
Received: from [127.0.0.1] (host.containers.internal [10.88.0.1])
 by openbmc (Postfix) with ESMTP id 191E18104811;
 Thu, 12 Feb 2026 07:48:12 +0000 (UTC)
Message-ID: <4ecdbe5bb0b3a945b3534e8535186280aa8f4f66.camel@eviden.com>
Subject: Re: [RFC PATCH 05/14] intel_iommu: Change pasid property from bool
 to uint8
From: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, xudong.hao@intel.com
Date: Thu, 12 Feb 2026 08:47:51 +0100
In-Reply-To: <20260205031133.74357-6-zhenzhong.duan@intel.com>
References: <20260205031133.74357-1-zhenzhong.duan@intel.com>
 <20260205031133.74357-6-zhenzhong.duan@intel.com>
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


On Wed, 2026-02-04 at 22:11 -0500, Zhenzhong Duan wrote:
> 'x-pasid-mode' is a bool property, we need an extra 'pss' property to =
=20
> represent PASID size supported. Because there is no any device in QEMU =
=20
> supporting pasid capability yet, no guest could use the pasid feature =
=20
> until now, 'x-pasid-mode' takes no effect.
>=20
> So instead of an extra 'pss' property we can use a single 'pasid' =20
> property of uint8 type to represent if pasid is supported and the PASID =
=20
> bits size. A value of N > 0 means pasid is supported and N - 1 is the =
=20
> value in PSS field in ECAP register.
>=20
> Signed-off-by: Zhenzhong Duan <[zhenzhong.duan@intel.com](mailto:zhenzhon=
g.duan@intel.com)> =20
> --- =20
> =C2=A0hw/i386/intel_iommu_internal.h | 1 - =20
> =C2=A0include/hw/i386/intel_iommu.h=C2=A0 | 2 +- =20
> =C2=A0hw/i386/intel_iommu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 4 ++-- =20
> =C2=A03 files changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_interna=
l.h =20
> index a2ca79f925..71cb3b662e 100644 =20
> --- a/hw/i386/intel_iommu_internal.h =20
> +++ b/hw/i386/intel_iommu_internal.h =20
> @@ -194,7 +194,6 @@ =20
> =C2=A0#define VTD_ECAP_PRS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1ULL << 29) =20
> =C2=A0#define VTD_ECAP_MHMV=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (15ULL << 20) =20
> =C2=A0#define VTD_ECAP_SRS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1ULL << 31) =20
> -#define VTD_ECAP_PSS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (7ULL << 35) /* limit: MemTxAttrs::=
pid */ =20
> =C2=A0#define VTD_ECAP_PASID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1ULL << 40) =20
> =C2=A0#define VTD_ECAP_SMTS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1ULL << 43) =20
> =C2=A0#define VTD_ECAP_SSTS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1ULL << 46) =20
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.=
h =20
> index 6c61fd39c7..5e5779e460 100644 =20
> --- a/include/hw/i386/intel_iommu.h =20
> +++ b/include/hw/i386/intel_iommu.h =20
> @@ -315,7 +315,7 @@ struct IntelIOMMUState { =20
> =C2=A0=C2=A0=C2=A0=C2=A0 bool buggy_eim;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Force bu=
ggy EIM unless eim=3Doff */ =20
> =C2=A0=C2=A0=C2=A0=C2=A0 uint8_t aw_bits;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Host/IOVA a=
ddress width (in bits) */ =20
> =C2=A0=C2=A0=C2=A0=C2=A0 bool dma_drain;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Whether =
DMA r/w draining enabled */ =20
> -=C2=A0=C2=A0=C2=A0 bool pasid;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* Whether to support PASID */ =20
> +=C2=A0=C2=A0=C2=A0 uint8_t pasid;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* PASID su=
pported in bits, 0 if not */ =20
> =C2=A0=C2=A0=C2=A0=C2=A0 bool fs1gp;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 /* First Stage 1-GByte Page Support */ =20
> =C2=A0 =20
> =C2=A0=C2=A0=C2=A0=C2=A0 /* Transient Mapping, Reserved(0) since VTD spec=
 revision 3.2 */ =20
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c =20
> index e8a6f50a5a..916eb0af5a 100644 =20
> --- a/hw/i386/intel_iommu.c =20
> +++ b/hw/i386/intel_iommu.c =20
> @@ -4151,7 +4151,7 @@ static const Property vtd_properties[] =3D { =20
> =C2=A0=C2=A0=C2=A0=C2=A0 DEFINE_PROP_BOOL("x-scalable-mode", IntelIOMMUSt=
ate, scalable_mode, FALSE), =20
> =C2=A0=C2=A0=C2=A0=C2=A0 DEFINE_PROP_BOOL("x-flts", IntelIOMMUState, fsts=
, FALSE), =20
> =C2=A0=C2=A0=C2=A0=C2=A0 DEFINE_PROP_BOOL("snoop-control", IntelIOMMUStat=
e, snoop_control, false), =20
> -=C2=A0=C2=A0=C2=A0 DEFINE_PROP_BOOL("x-pasid-mode", IntelIOMMUState, pas=
id, false), =20
> +=C2=A0=C2=A0=C2=A0 DEFINE_PROP_UINT8("pasid", IntelIOMMUState, pasid, 0)=
, =20
> =C2=A0=C2=A0=C2=A0=C2=A0 DEFINE_PROP_BOOL("dma-drain", IntelIOMMUState, d=
ma_drain, true), =20
> =C2=A0=C2=A0=C2=A0=C2=A0 DEFINE_PROP_BOOL("stale-tm", IntelIOMMUState, st=
ale_tm, false), =20
> =C2=A0=C2=A0=C2=A0=C2=A0 DEFINE_PROP_BOOL("fs1gp", IntelIOMMUState, fs1gp=
, true), =20
> @@ -4981,7 +4981,7 @@ static void vtd_cap_init(IntelIOMMUState *s) =20
> =C2=A0=C2=A0=C2=A0=C2=A0 } =20
> =C2=A0 =20
> =C2=A0=C2=A0=C2=A0=C2=A0 if (s->pasid) { =20
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->ecap |=3D VTD_ECAP_PASID |=
 VTD_ECAP_PSS; =20
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->ecap =3D VTD_ECAP_PASID | =
deposit64(s->ecap, 35, 5, s->pasid - 1); =20

I think this is a bit dangerous, the MemTxAttrs only allow up to 8 bits. =
=20
We have a comment next to the definition of VTD_ECAP_PSS about this.

> =C2=A0=C2=A0=C2=A0=C2=A0 } =20
> =C2=A0} =20
> =C2=A0

