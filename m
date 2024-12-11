Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A8AE77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 03:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLD1S-0007oH-Kz; Tue, 10 Dec 2024 22:04:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tLD1R-0007o9-4t
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 22:04:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tLD1M-0007QZ-EG
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 22:04:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733886253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=phIQX5Pv3KAoiNM5Wen/fin80sRHF9veoNzx0aS+Uts=;
 b=dQOUckR3pdq83YOn949xmmy6uQQrjC/RKFxMc61F//NfVD/7hXJfoyIHpJITEcUd7P11Mb
 eGm77TzWu9EXCeDmBxo6TekbBLWrMQ6li1SdTK8APBNhh2sOwylp6zNeq6OBtkE5R8WOQX
 qpu59fs2Uu9sFfTpVMc26R7pOWYT928=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-PyIhQKeVMMOLvgC9X0k3OQ-1; Tue, 10 Dec 2024 22:04:12 -0500
X-MC-Unique: PyIhQKeVMMOLvgC9X0k3OQ-1
X-Mimecast-MFC-AGG-ID: PyIhQKeVMMOLvgC9X0k3OQ
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2162259a5dcso62214805ad.3
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 19:04:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733886251; x=1734491051;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=phIQX5Pv3KAoiNM5Wen/fin80sRHF9veoNzx0aS+Uts=;
 b=ti3t5yKJ3lI6ttPE2huFW1l83xtRt2ql51lSMCfjVN7+HiiEkn4gTaaBXHfoLPeOu7
 CCCSVCf+VIxEDHw3bHH50raemI9KbXrl6wZKGKYJlRPI9iVePuuXaIPcAjiu3FWApaOR
 +VheyuvCzZDPiubFuhGkR9voY7/BtqJUg4kQy73ucLcx4P8VRcS+Nmnts0gLGPSiHB3C
 oGlTHsApqK1uThmgb/2D3UGVc+ZPAkfURiv83g23Vt++Jj3JnQJc/8oQtCbMvh2pzsuU
 55aBGLPp8yN+/6IY2RnlrfEErENy3oCR2e3sWH8jqOONSOQvqwzInG8PGvaDDcS62zCb
 GzOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX25ftFT+7SYUCcsoUy3nQiktQeGAp5q6supInkwCqhz7Lc9Lfvi51UYLWVEbxdEiWit/EFH6Ts2lzo@nongnu.org
X-Gm-Message-State: AOJu0Yzbq2ibAVjAPuY137OGohT0nu97PVL1Pkjagd6hRCH1GuHfnOGx
 PcH5ILGvgxol8IqlJSSK7a8DXRcseycTlwwREab+yJnWEk+NmC3z5X6JP8Pm+QT1d1sxhyAshFN
 rsljf+U8hvX0KYZj42KCGjyl25XAKp7bTMQLNNnT5Qim5UsFT3fnGeVpEQ1isx854Gv7HBqYxnE
 +7Qudcg3je21PkL9FvHxd4Wm2KTWM=
X-Gm-Gg: ASbGncvvh8gXuIiOiMAG6/NKYE0WcEzbcQM9XDjatXsW8Jz1pf2aJleKIje426paw8P
 Fom4ZAv4gKw/DH8wLyumKb0qxJ8VzouK+o2IB
X-Received: by 2002:a17:903:2282:b0:215:431f:268f with SMTP id
 d9443c01a7336-217783984bbmr25399765ad.10.1733886251415; 
 Tue, 10 Dec 2024 19:04:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZkhacCi7ApKzK7ld5pQej2BwGNXLjV6lr1k+slh+DL5wkJlUbGbPsI6JwIssO73sG1vsnARD2Ut77jgCWLxw=
X-Received: by 2002:a17:903:2282:b0:215:431f:268f with SMTP id
 d9443c01a7336-217783984bbmr25399445ad.10.1733886251037; Tue, 10 Dec 2024
 19:04:11 -0800 (PST)
MIME-Version: 1.0
References: <20241111083457.2090664-1-zhenzhong.duan@intel.com>
 <20241111083457.2090664-19-zhenzhong.duan@intel.com>
 <CACGkMEtwV51X9ovWB3JHtyW4gpLT8zD8bieKFA2X=BVNZF8ymA@mail.gmail.com>
 <7126398e-fc27-4d4f-894b-f71b012f98e1@eviden.com>
 <CACGkMEvuX4CtADqq0O3TnD1=Jh2aBnXFdTzLS9junGyxkKq+Xw@mail.gmail.com>
 <68d3a523-19c4-4296-9df8-b98b498d4c0e@eviden.com>
 <CACGkMEs0xTf+YeCWmBbyJaQSS2RzBe2pBYzrv3n_mW+6EV4few@mail.gmail.com>
 <bb7df163-e3fe-4d26-93c2-756a7b6be15a@eviden.com>
 <SJ0PR11MB67442853FBF1FAD572A3CC37923E2@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB67442853FBF1FAD572A3CC37923E2@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 11 Dec 2024 11:03:59 +0800
Message-ID: <CACGkMEsRHytcZkR8OcK7cEiAordK9+EcG4Kei0RpABGApnBY4w@mail.gmail.com>
Subject: Re: [PATCH v5 18/20] intel_iommu: Introduce a property x-flts for
 scalable modern mode
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, 
 "peterx@redhat.com" <peterx@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, 
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, 
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, 
 Yi Sun <yi.y.sun@linux.intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Dec 11, 2024 at 10:50=E2=80=AFAM Duan, Zhenzhong
<zhenzhong.duan@intel.com> wrote:
>
> Hi Jason, Clement,
>
> Sorry for late reply, just back from vacation.
>
> >-----Original Message-----
> >From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
> >Subject: Re: [PATCH v5 18/20] intel_iommu: Introduce a property x-flts f=
or
> >scalable modern mode
> >
> >
> >
> >
> >On 09/12/2024 07:24, Jason Wang wrote:
> >> Caution: External email. Do not open attachments or click links, unles=
s this
> >email comes from a known sender and you know the content is safe.
> >>
> >>
> >> On Mon, Dec 9, 2024 at 2:15=E2=80=AFPM CLEMENT MATHIEU--DRIF
> >> <clement.mathieu--drif@eviden.com> wrote:
> >>>
> >>>
> >>> On 09/12/2024 04:13, Jason Wang wrote:
> >>>> Caution: External email. Do not open attachments or click links, unl=
ess this
> >email comes from a known sender and you know the content is safe.
> >>>>
> >>>>
> >>>> On Wed, Dec 4, 2024 at 2:14=E2=80=AFPM CLEMENT MATHIEU--DRIF
> >>>> <clement.mathieu--drif@eviden.com> wrote:
> >>>>>
> >>>>>
> >>>>> On 04/12/2024 04:34, Jason Wang wrote:
> >>>>>> Caution: External email. Do not open attachments or click links, u=
nless this
> >email comes from a known sender and you know the content is safe.
> >>>>>>
> >>>>>>
> >>>>>> On Mon, Nov 11, 2024 at 4:39=E2=80=AFPM Zhenzhong Duan
> ><zhenzhong.duan@intel.com> wrote:
> >>>>>>> Intel VT-d 3.0 introduces scalable mode, and it has a bunch of ca=
pabilities
> >>>>>>> related to scalable mode translation, thus there are multiple
> >combinations.
> >>>>>>>
> >>>>>>> This vIOMMU implementation wants to simplify it with a new proper=
ty "x-
> >flts".
> >>>>>>> When enabled in scalable mode, first stage translation also known=
 as
> >scalable
> >>>>>>> modern mode is supported. When enabled in legacy mode, throw out
> >error.
> >>>>>>>
> >>>>>>> With scalable modern mode exposed to user, also accurate the pasi=
d
> >entry
> >>>>>>> check in vtd_pe_type_check().
> >>>>>>>
> >>>>>>> Suggested-by: Jason Wang <jasowang@redhat.com>
> >>>>>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> >>>>>>> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> >>>>>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> >>>>>>> ---
> >>>>>>>     hw/i386/intel_iommu_internal.h |  2 ++
> >>>>>>>     hw/i386/intel_iommu.c          | 28 +++++++++++++++++++------=
---
> >>>>>>>     2 files changed, 21 insertions(+), 9 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/hw/i386/intel_iommu_internal.h
> >b/hw/i386/intel_iommu_internal.h
> >>>>>>> index 2c977aa7da..e8b211e8b0 100644
> >>>>>>> --- a/hw/i386/intel_iommu_internal.h
> >>>>>>> +++ b/hw/i386/intel_iommu_internal.h
> ...
> >>>>>>> @@ -4737,6 +4742,11 @@ static bool
> >vtd_decide_config(IntelIOMMUState *s, Error **errp)
> >>>>>>>             }
> >>>>>>>         }
> >>>>>>>
> >>>>>>> +    if (!s->scalable_mode && s->scalable_modern) {
> >>>>>>> +        error_setg(errp, "Legacy mode: not support x-flts=3Don")=
;
> >>>>>> This seems to be wired, should we say "scalable mode is needed for
> >>>>>> scalable modern mode"?
> >>>>> Hi Jason,
> >>>>>
> >>>>> We agreed to use the following sentence: "x-flts is only available =
in
> >>>>> scalable mode"
> >>>>>
> >>>>> Does it look goot to you?
> >>>> Better but if we add more features to the scalable modern, we need t=
o
> >>>> change the error message here.
> >>> Hi Jason
> >>>
> >>> Maybe the weirdness comes from the fact that x-flts on the command li=
ne
> >>> is mapped to scalable_modern in the code?
> >> Yes, actually the code checks if scalable mode is enabled if scalable
> >> modern is enabled. But this is inconsistent with the error message
> >> (though x-flts was implied there probably).
> >
> >Would you rename s->scalable_modern to s->flts?
>
> Starting from v4, we replace x-scalable-mode=3Dmodern with flts=3Don on Q=
EMU cmdline.
> Scalable modern mode is an alias of stage-1 page table, so I reuse s->sca=
lable_modern
> in code, I'm fine to rename to s->flts if that's preferred. In that case,=
 maybe we should
> also drop the concept of 'scalable modern mode' totally?

I think so, it helps to reduce the confusion.

Thanks

>
> Thanks
> Zhenzhong


