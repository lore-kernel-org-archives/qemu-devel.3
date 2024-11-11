Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14326D12D65
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 03:04:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAKir-0006P4-SB; Sun, 10 Nov 2024 22:04:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tAKiq-0006LH-ET
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 22:04:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tAKin-00030g-Ub
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 22:04:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731294248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wiAJIZV/m9iBfg80LrFOgfbkKujZORcpmaCucDuEMj4=;
 b=Yqy0XW3uiWafgIGXPDFe4RsQl6ejjI3jMnEJ2QKq9J0eD6M2r3pdzvrdMkzYplqRFAxVT8
 PQRQSmt9u/9KJwlt8jynKfap6kP1Cu441yCNWYqGTuT4eDKGiYzAsXG2Dg3Px66RahjR6o
 1L/in3UZ1HlMfDGcQbBQw4fPS7l76JA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-fNwZSBXtMJyVD4Jo5_FuTA-1; Sun, 10 Nov 2024 22:04:06 -0500
X-MC-Unique: fNwZSBXtMJyVD4Jo5_FuTA-1
X-Mimecast-MFC-AGG-ID: fNwZSBXtMJyVD4Jo5_FuTA
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2e9b723c384so2445195a91.3
 for <qemu-devel@nongnu.org>; Sun, 10 Nov 2024 19:04:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731294245; x=1731899045;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wiAJIZV/m9iBfg80LrFOgfbkKujZORcpmaCucDuEMj4=;
 b=V45a1UUvz0Z4tzmyQzwDCLT74Lwfm+xMItYlqpTHud3aD+U73JjJgQ+gdOv6GKTiLx
 zat5xLzh9DAsLOeO/gUhgHstLyuRsH6XtQlbRAyluol3fZ9KAxYnw8mSqILGQLC9iopx
 i+Nvhlu4ymbcfSkiSTjRmRlBS7so5NhrRvnhQZzqDvu8C6A5sYkvEK+GXe1bxH0U1pXB
 MiPgciutMTCXUiYl9rlsweU7YTWGFQreG70arULa3P5JFzZdpIj4HZAnL80cbRW0i5Qu
 8XPfiKBMw2B4fMQpOXOVHcuDpVzU7YIdjh2E2ONsgQ4ERia2ZgYhG79Hguf5WEgcnYfR
 /GAA==
X-Gm-Message-State: AOJu0Ywg94PiBVBdS1+lzkyn5g6xJvZNnxOOT+5iTTILW9C8sDXJJjrS
 zGLCMJizDFz31B8AFKDB5tXEld5330tYVB0KQhqUNpd1S6JaDzd9MStqwbpMuwLXp8A698HWoiY
 woq/O0A4haiHaXmuvVBxmPojxDbTwF+x/pohrtJNPtPOtD/P2PzPDH6/ZVV91B3l6h1V0pU7AJz
 xrpkTybRzemHGjzOQvh8GyXk//lwY=
X-Received: by 2002:a17:90b:3847:b0:2e2:d17e:1ef7 with SMTP id
 98e67ed59e1d1-2e9b16e265emr14555215a91.3.1731294245395; 
 Sun, 10 Nov 2024 19:04:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjAltVTml2s13JVIRCZhHOG2aM/UHHFjnpWXgnNR5DVf3ZZpoaF5Wj8sa97grjXbgALQqtX2Nt8MrieuPoCFA=
X-Received: by 2002:a17:90b:3847:b0:2e2:d17e:1ef7 with SMTP id
 98e67ed59e1d1-2e9b16e265emr14555177a91.3.1731294244867; Sun, 10 Nov 2024
 19:04:04 -0800 (PST)
MIME-Version: 1.0
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
 <20240930092631.2997543-15-zhenzhong.duan@intel.com>
 <CACGkMEsq+VrxjGMf_ma=6xumwWgb2109XB4+86zH0ZXrce5Kdg@mail.gmail.com>
 <SJ0PR11MB6744B13E0A9C352E4E6EF74D925D2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <CACGkMEvxK_+foQ1WV6ykJyRxzAPZc80wBfw0c-j-D56jsrTvXA@mail.gmail.com>
 <SJ0PR11MB674497448DE5C1CD18E0294A92582@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB674497448DE5C1CD18E0294A92582@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 11 Nov 2024 11:03:53 +0800
Message-ID: <CACGkMEuhoHH9JfawMNQNLzivXrqJ=daoE+e0FaZQ2en29exhiA@mail.gmail.com>
Subject: Re: [PATCH v4 14/17] intel_iommu: Set default aw_bits to 48 in
 scalable modern mode
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, 
 "peterx@redhat.com" <peterx@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, 
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, 
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, 
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.118,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.743,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Nov 11, 2024 at 10:58=E2=80=AFAM Duan, Zhenzhong
<zhenzhong.duan@intel.com> wrote:
>
>
>
> >-----Original Message-----
> >From: Jason Wang <jasowang@redhat.com>
> >Sent: Monday, November 11, 2024 9:24 AM
> >Subject: Re: [PATCH v4 14/17] intel_iommu: Set default aw_bits to 48 in =
scalable
> >modern mode
> >
> >On Fri, Nov 8, 2024 at 1:30=E2=80=AFPM Duan, Zhenzhong <zhenzhong.duan@i=
ntel.com>
> >wrote:
> >>
> >>
> >>
> >> >-----Original Message-----
> >> >From: Jason Wang <jasowang@redhat.com>
> >> >Sent: Friday, November 8, 2024 12:42 PM
> >> >Subject: Re: [PATCH v4 14/17] intel_iommu: Set default aw_bits to 48 =
in
> >scalable
> >> >modern mode
> >> >
> >> >On Mon, Sep 30, 2024 at 5:30=E2=80=AFPM Zhenzhong Duan
> ><zhenzhong.duan@intel.com>
> >> >wrote:
> >> >>
> >> >> According to VTD spec, stage-1 page table could support 4-level and
> >> >> 5-level paging.
> >> >>
> >> >> However, 5-level paging translation emulation is unsupported yet.
> >> >> That means the only supported value for aw_bits is 48.
> >> >>
> >> >> So default aw_bits to 48 in scalable modern mode. In other cases,
> >> >> it is still default to 39 for backward compatibility.
> >> >>
> >> >> Add a check to ensure user specified value is 48 in modern mode
> >> >> for now.
> >> >>
> >> >> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> >> >> Reviewed-by: Cl=C3=A9ment Mathieu--Drif<clement.mathieu--drif@evide=
n.com>
> >> >> ---
> >> >>  include/hw/i386/intel_iommu.h |  2 +-
> >> >>  hw/i386/intel_iommu.c         | 10 +++++++++-
> >> >>  2 files changed, 10 insertions(+), 2 deletions(-)
> >> >>
> >> >> diff --git a/include/hw/i386/intel_iommu.h
> >b/include/hw/i386/intel_iommu.h
> >> >> index b843d069cc..48134bda11 100644
> >> >> --- a/include/hw/i386/intel_iommu.h
> >> >> +++ b/include/hw/i386/intel_iommu.h
> >> >> @@ -45,7 +45,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(IntelIOMMUState,
> >> >INTEL_IOMMU_DEVICE)
> >> >>  #define DMAR_REG_SIZE               0x230
> >> >>  #define VTD_HOST_AW_39BIT           39
> >> >>  #define VTD_HOST_AW_48BIT           48
> >> >> -#define VTD_HOST_ADDRESS_WIDTH      VTD_HOST_AW_39BIT
> >> >> +#define VTD_HOST_AW_AUTO            0xff
> >> >>  #define VTD_HAW_MASK(aw)            ((1ULL << (aw)) - 1)
> >> >>
> >> >>  #define DMAR_REPORT_F_INTR          (1)
> >> >> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> >> >> index 91d7b1abfa..068a08f522 100644
> >> >> --- a/hw/i386/intel_iommu.c
> >> >> +++ b/hw/i386/intel_iommu.c
> >> >> @@ -3776,7 +3776,7 @@ static Property vtd_properties[] =3D {
> >> >>                              ON_OFF_AUTO_AUTO),
> >> >>      DEFINE_PROP_BOOL("x-buggy-eim", IntelIOMMUState, buggy_eim, fa=
lse),
> >> >>      DEFINE_PROP_UINT8("aw-bits", IntelIOMMUState, aw_bits,
> >> >> -                      VTD_HOST_ADDRESS_WIDTH),
> >> >> +                      VTD_HOST_AW_AUTO),
> >> >>      DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode=
,
> >> >FALSE),
> >> >>      DEFINE_PROP_BOOL("x-scalable-mode", IntelIOMMUState,
> >scalable_mode,
> >> >FALSE),
> >> >>      DEFINE_PROP_BOOL("snoop-control", IntelIOMMUState, snoop_contr=
ol,
> >> >false),
> >> >> @@ -4683,6 +4683,14 @@ static bool vtd_decide_config(IntelIOMMUStat=
e
> >*s,
> >> >Error **errp)
> >> >>          }
> >> >>      }
> >> >>
> >> >> +    if (s->aw_bits =3D=3D VTD_HOST_AW_AUTO) {
> >> >> +        if (s->scalable_modern) {
> >> >> +            s->aw_bits =3D VTD_HOST_AW_48BIT;
> >> >> +        } else {
> >> >> +            s->aw_bits =3D VTD_HOST_AW_39BIT;
> >> >> +        }
> >> >
> >> >I don't see how we maintain migration compatibility here.
> >>
> >> Imagine this cmdline: "-device intel-iommu,x-scalable-mode=3Don" which=
 hints
> >> scalable legacy mode(a.k.a, stage-2 page table mode),
> >>
> >> without this patch, initial s->aw_bits value is VTD_HOST_ADDRESS_WIDTH=
(39).
> >>
> >> after this patch, initial s->aw_bit value is VTD_HOST_AW_AUTO(0xff),
> >> vtd_decide_config() is called by vtd_realize() to set s->aw_bit to
> >VTD_HOST_AW_39BIT(39).
> >>
> >> So as long as the QEMU cmdline is same, s->aw_bit is same with or with=
out this
> >patch.
> >
> >Ok, I guess the point is that the scalabe-modern mode is introduced in
> >this series so we won't bother.
> >
> >But I see this:
> >
> >+    if (s->scalable_modern && s->aw_bits !=3D VTD_HOST_AW_48BIT) {
> >
> >In previous patches. So I wonder instead of mandating management to
> >set AUTO which seems like a burden. How about just increase the
> >default AW to 48bit and do the compatibility work here?
>
> Good idea! Then we don't need VTD_HOST_AW_AUTO(0xff).
> Default is 48 starting from qemu 9.2 both for modern and legacy mode,
> Default is still 39 for qemu before 9.2. Will be like below, let me know =
if
> any misunderstandings.
>
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -45,7 +45,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(IntelIOMMUState, INTEL_IOMMU=
_DEVICE)
>  #define DMAR_REG_SIZE               0x230
>  #define VTD_HOST_AW_39BIT           39
>  #define VTD_HOST_AW_48BIT           48
> -#define VTD_HOST_ADDRESS_WIDTH      VTD_HOST_AW_39BIT
> +#define VTD_HOST_ADDRESS_WIDTH      VTD_HOST_AW_48BIT
>  #define VTD_HAW_MASK(aw)            ((1ULL << (aw)) - 1)
>
>  #define DMAR_REPORT_F_INTR          (1)
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 830614d930..bdb67f1fd4 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -83,6 +83,7 @@ GlobalProperty pc_compat_9_1[] =3D {
>      { "ICH9-LPC", "x-smi-swsmi-timer", "off" },
>      { "ICH9-LPC", "x-smi-periodic-timer", "off" },
>      { TYPE_INTEL_IOMMU_DEVICE, "stale-tm", "on" },
> +    { TYPE_INTEL_IOMMU_DEVICE, "aw-bits", "39" },
>  };
>  const size_t pc_compat_9_1_len =3D G_N_ELEMENTS(pc_compat_9_1);

Ack.

Thanks

>
>
>
> Thanks
> Zhenzhong


