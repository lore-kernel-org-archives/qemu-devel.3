Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1545EE77173
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 03:14:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKUDd-0003mq-Po; Sun, 08 Dec 2024 22:13:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tKUDZ-0003mb-Rb
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 22:13:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tKUDW-0001r7-IR
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 22:13:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733714026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MBdySX2mAHk8gYLoA7jaB6y4S01k8Ski+efjps3+i/M=;
 b=cGmlnsQ0VpKtXeyw/hiSkeV0Qk50eSL+9Wwwx/2LYMMntohmNeqAq4HndkNKzhx1GavEad
 r6NhOsfh8ETL28keQrsUqvCIZXBFxhEup45LkmPlHAQe/nZRsEw4Y08cNeczjSFwUcn8f9
 EI6i46GqVc2qf4t76+G0XQpVXxsZ1r4=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-qO8wTOsIMCCI8pGQi5uzKQ-1; Sun, 08 Dec 2024 22:13:42 -0500
X-MC-Unique: qO8wTOsIMCCI8pGQi5uzKQ-1
X-Mimecast-MFC-AGG-ID: qO8wTOsIMCCI8pGQi5uzKQ
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2163d9a730aso9120155ad.1
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2024 19:13:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733714021; x=1734318821;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MBdySX2mAHk8gYLoA7jaB6y4S01k8Ski+efjps3+i/M=;
 b=ky42Tu8Rm2xfw9myeowoGWaUutGY/YeGGqJknC5e/sG8vrBBs94nBs2po6VXCm0iPF
 N5XqClmMESl66X/Mvdo8yqM4lWqjzmvA9PfbYK7a1wfkbUsPMwqAcMI17PhUHYA1vBuE
 Kv/rGJaRLO0A0phtiicjwjX3ktlmZS9qkl9WFtPqHq+f17g9huCENajgO/u87iRyfsyn
 RPUyRK+kbqP4Rh4HyevqprZUoxXz3g7mNT/cUMp+t/96DQMJoKhsty6uCF0tQ4iKcgOB
 uJ0uq0y3RAZqfE1SJmdGI2SEJLFbk0Q4Ub7vJRuE0iMw20/9FWeYPHTPll7wXCmHIu1R
 c5iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNOSVu8SpugLajGUFNe3aXDQSTOze8KM+oKfp9jgJbB0xdDHPwmuYJUnkZfha/wou+noubSK7pRK9H@nongnu.org
X-Gm-Message-State: AOJu0YycTAK7qm7ySpskOOJkYP5uZx+/HDMaPr7zepF/HBDqcWh7j1NU
 juCZ8zAkKcShc5gXS8+Bxu8QXoNbXXtOgEsoHRSJj1G1XjaYx0Ivqntb8HPuG0qwMfBPgyOHu9k
 5zjZmk4RKLjBp1tu9SZzttG+j4top3ondk+fCPj5Lany4TBJgqbMCFsG8v4fLGzCsMDNbD7dfQp
 86QEEtSiNdtfmK5Xn6Qzz3Un9sXVM=
X-Gm-Gg: ASbGncsVlN2Q2TXwZ4g5WUiSVWYr3H6/Q9ZjYyJmMkJMg3S2Q4rDIYAGgSI4JZTwUEy
 cfsOTZgGkq0fAUy9DSuIswK3tl2E4aDzw
X-Received: by 2002:a17:902:d4c4:b0:215:758c:52e8 with SMTP id
 d9443c01a7336-21610b3acaamr174947015ad.12.1733714021195; 
 Sun, 08 Dec 2024 19:13:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0R2z797bstWWFA7QemKRr28GzVp1HvZJgHMMMggu0nLlgWLZ5dHh63Y56y5kCxlm9lRT0NIV19WSHyPNnKAE=
X-Received: by 2002:a17:902:d4c4:b0:215:758c:52e8 with SMTP id
 d9443c01a7336-21610b3acaamr174946725ad.12.1733714020742; Sun, 08 Dec 2024
 19:13:40 -0800 (PST)
MIME-Version: 1.0
References: <20241111083457.2090664-1-zhenzhong.duan@intel.com>
 <20241111083457.2090664-19-zhenzhong.duan@intel.com>
 <CACGkMEtwV51X9ovWB3JHtyW4gpLT8zD8bieKFA2X=BVNZF8ymA@mail.gmail.com>
 <7126398e-fc27-4d4f-894b-f71b012f98e1@eviden.com>
In-Reply-To: <7126398e-fc27-4d4f-894b-f71b012f98e1@eviden.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 9 Dec 2024 11:13:29 +0800
Message-ID: <CACGkMEvuX4CtADqq0O3TnD1=Jh2aBnXFdTzLS9junGyxkKq+Xw@mail.gmail.com>
Subject: Re: [PATCH v5 18/20] intel_iommu: Introduce a property x-flts for
 scalable modern mode
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, 
 "peterx@redhat.com" <peterx@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, 
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>, 
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "chao.p.peng@intel.com" <chao.p.peng@intel.com>, 
 Yi Sun <yi.y.sun@linux.intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Dec 4, 2024 at 2:14=E2=80=AFPM CLEMENT MATHIEU--DRIF
<clement.mathieu--drif@eviden.com> wrote:
>
>
>
> On 04/12/2024 04:34, Jason Wang wrote:
> > Caution: External email. Do not open attachments or click links, unless=
 this email comes from a known sender and you know the content is safe.
> >
> >
> > On Mon, Nov 11, 2024 at 4:39=E2=80=AFPM Zhenzhong Duan <zhenzhong.duan@=
intel.com> wrote:
> >>
> >> Intel VT-d 3.0 introduces scalable mode, and it has a bunch of capabil=
ities
> >> related to scalable mode translation, thus there are multiple combinat=
ions.
> >>
> >> This vIOMMU implementation wants to simplify it with a new property "x=
-flts".
> >> When enabled in scalable mode, first stage translation also known as s=
calable
> >> modern mode is supported. When enabled in legacy mode, throw out error=
.
> >>
> >> With scalable modern mode exposed to user, also accurate the pasid ent=
ry
> >> check in vtd_pe_type_check().
> >>
> >> Suggested-by: Jason Wang <jasowang@redhat.com>
> >> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> >> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> >> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> >> ---
> >>   hw/i386/intel_iommu_internal.h |  2 ++
> >>   hw/i386/intel_iommu.c          | 28 +++++++++++++++++++---------
> >>   2 files changed, 21 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_inte=
rnal.h
> >> index 2c977aa7da..e8b211e8b0 100644
> >> --- a/hw/i386/intel_iommu_internal.h
> >> +++ b/hw/i386/intel_iommu_internal.h
> >> @@ -195,6 +195,7 @@
> >>   #define VTD_ECAP_PASID              (1ULL << 40)
> >>   #define VTD_ECAP_SMTS               (1ULL << 43)
> >>   #define VTD_ECAP_SLTS               (1ULL << 46)
> >> +#define VTD_ECAP_FLTS               (1ULL << 47)
> >>
> >>   /* CAP_REG */
> >>   /* (offset >> 4) << 24 */
> >> @@ -211,6 +212,7 @@
> >>   #define VTD_CAP_SLLPS               ((1ULL << 34) | (1ULL << 35))
> >>   #define VTD_CAP_DRAIN_WRITE         (1ULL << 54)
> >>   #define VTD_CAP_DRAIN_READ          (1ULL << 55)
> >> +#define VTD_CAP_FS1GP               (1ULL << 56)
> >>   #define VTD_CAP_DRAIN               (VTD_CAP_DRAIN_READ | VTD_CAP_DR=
AIN_WRITE)
> >>   #define VTD_CAP_CM                  (1ULL << 7)
> >>   #define VTD_PASID_ID_SHIFT          20
> >> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> >> index b921793c3a..a7a81aebee 100644
> >> --- a/hw/i386/intel_iommu.c
> >> +++ b/hw/i386/intel_iommu.c
> >> @@ -803,16 +803,18 @@ static inline bool vtd_is_fl_level_supported(Int=
elIOMMUState *s, uint32_t level)
> >>   }
> >>
> >>   /* Return true if check passed, otherwise false */
> >> -static inline bool vtd_pe_type_check(X86IOMMUState *x86_iommu,
> >> -                                     VTDPASIDEntry *pe)
> >> +static inline bool vtd_pe_type_check(IntelIOMMUState *s, VTDPASIDEntr=
y *pe)
> >>   {
> >>       switch (VTD_PE_GET_TYPE(pe)) {
> >> -    case VTD_SM_PASID_ENTRY_SLT:
> >> -        return true;
> >> -    case VTD_SM_PASID_ENTRY_PT:
> >> -        return x86_iommu->pt_supported;
> >>       case VTD_SM_PASID_ENTRY_FLT:
> >> +        return !!(s->ecap & VTD_ECAP_FLTS);
> >> +    case VTD_SM_PASID_ENTRY_SLT:
> >> +        return !!(s->ecap & VTD_ECAP_SLTS);
> >>       case VTD_SM_PASID_ENTRY_NESTED:
> >> +        /* Not support NESTED page table type yet */
> >> +        return false;
> >> +    case VTD_SM_PASID_ENTRY_PT:
> >> +        return !!(s->ecap & VTD_ECAP_PT);
> >>       default:
> >>           /* Unknown type */
> >>           return false;
> >> @@ -861,7 +863,6 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOM=
MUState *s,
> >>       uint8_t pgtt;
> >>       uint32_t index;
> >>       dma_addr_t entry_size;
> >> -    X86IOMMUState *x86_iommu =3D X86_IOMMU_DEVICE(s);
> >>
> >>       index =3D VTD_PASID_TABLE_INDEX(pasid);
> >>       entry_size =3D VTD_PASID_ENTRY_SIZE;
> >> @@ -875,7 +876,7 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOM=
MUState *s,
> >>       }
> >>
> >>       /* Do translation type check */
> >> -    if (!vtd_pe_type_check(x86_iommu, pe)) {
> >> +    if (!vtd_pe_type_check(s, pe)) {
> >>           return -VTD_FR_PASID_TABLE_ENTRY_INV;
> >>       }
> >>
> >> @@ -3827,6 +3828,7 @@ static Property vtd_properties[] =3D {
> >>                         VTD_HOST_ADDRESS_WIDTH),
> >>       DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode, =
FALSE),
> >>       DEFINE_PROP_BOOL("x-scalable-mode", IntelIOMMUState, scalable_mo=
de, FALSE),
> >> +    DEFINE_PROP_BOOL("x-flts", IntelIOMMUState, scalable_modern, FALS=
E),
> >>       DEFINE_PROP_BOOL("snoop-control", IntelIOMMUState, snoop_control=
, false),
> >>       DEFINE_PROP_BOOL("x-pasid-mode", IntelIOMMUState, pasid, false),
> >>       DEFINE_PROP_BOOL("dma-drain", IntelIOMMUState, dma_drain, true),
> >> @@ -4558,7 +4560,10 @@ static void vtd_cap_init(IntelIOMMUState *s)
> >>       }
> >>
> >>       /* TODO: read cap/ecap from host to decide which cap to be expos=
ed. */
> >> -    if (s->scalable_mode) {
> >> +    if (s->scalable_modern) {
> >> +        s->ecap |=3D VTD_ECAP_SMTS | VTD_ECAP_FLTS;
> >> +        s->cap |=3D VTD_CAP_FS1GP;
> >> +    } else if (s->scalable_mode) {
> >>           s->ecap |=3D VTD_ECAP_SMTS | VTD_ECAP_SRS | VTD_ECAP_SLTS;
> >>       }
> >>
> >> @@ -4737,6 +4742,11 @@ static bool vtd_decide_config(IntelIOMMUState *=
s, Error **errp)
> >>           }
> >>       }
> >>
> >> +    if (!s->scalable_mode && s->scalable_modern) {
> >> +        error_setg(errp, "Legacy mode: not support x-flts=3Don");
> >
> > This seems to be wired, should we say "scalable mode is needed for
> > scalable modern mode"?
>
> Hi Jason,
>
> We agreed to use the following sentence: "x-flts is only available in
> scalable mode"
>
> Does it look goot to you?

Better but if we add more features to the scalable modern, we need to
change the error message here.

Thanks

>
> Thanks
> cmd
>
> >
> >> +        return false;
> >> +    }
> >> +
> >>       if (!s->scalable_modern && s->aw_bits !=3D VTD_HOST_AW_39BIT &&
> >>           s->aw_bits !=3D VTD_HOST_AW_48BIT) {
> >>           error_setg(errp, "%s mode: supported values for aw-bits are:=
 %d, %d",
> >> --
> >> 2.34.1
> >>
> >
> > Thanks
> >


