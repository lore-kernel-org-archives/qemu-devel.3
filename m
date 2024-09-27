Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45C2CEBF76
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 04:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1su2Ha-0004Dq-U1; Fri, 27 Sep 2024 00:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1su2HY-00047N-W8
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 00:08:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1su2HX-0006Hu-GB
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 00:08:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727410117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZUb7U2Mg8j+JNmi5ddCtEoRbcC50I7BRzzNqcsX7Qyk=;
 b=fdfSeNb3weshQAolR38LksMGA5/nWzh9orRPjnmhqWy7NrK3VtzwmTchQ5Yngs80F8Fmub
 x0OYKflAZ27CqyST1bSXi1R1n6D5h6dtweLtaTGiZ7No2UCL2VUSseC2C5kf9Jv/uc1giJ
 KzIClBi6LvzZhRhbbt1N9H8ap92oPdQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-ihwyIijTPemyE-DY_6949g-1; Fri, 27 Sep 2024 00:08:35 -0400
X-MC-Unique: ihwyIijTPemyE-DY_6949g-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2e0a47eb73fso1459098a91.0
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2024 21:08:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727410114; x=1728014914;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZUb7U2Mg8j+JNmi5ddCtEoRbcC50I7BRzzNqcsX7Qyk=;
 b=OcA2YDyAOAKB9WgsG5ZDVKoiA8POlOvRCcSwfSpDyjkblDOITFWOJlOF5hjFSoyMPZ
 DnXCvXqsHySm/+QJcawKQPvMG+I6C4m9FxiCuOi7T+5ZQxLzUBc5Sap+tza1IUVfM0KJ
 UQDncq8/n9WvRqSxpOhhaCUtgfbf8uJ54eakk3ZEunBJNTMrj/2NBMKGDWi+9LH7pdlE
 WGL88NtTvVj8Mk4gUuJXT25AlDpAIYZRV8ZjD2GvAvvInO5cFwreoYpd3OF0vid0P2ZL
 /uXnqPhsSUqVcPSXelb1gKBtijxjwTmmYVdm2evHBKPOXS4skuM/nP3WYevx//2TVNEt
 tfmg==
X-Gm-Message-State: AOJu0YysAH6sYJS9lExWSCliLL4rYpWDVkFau3oUQhr4W4Dj44WDsgag
 VZCX5dqiTW7tgabIb4OnjL8jU398p2aPKtK1cCS1xvJqQfnngol0jenrOSh0BcLE+D3xLVk+xCr
 zDxaKxBuThcyJ6u61DaAf8f2JeG3DyJCae+BJWFRnLV4vEscX87pL9stjRIEZmq6n4ReaxfmRky
 NeEVKzLd8jk9sIteuxW8yP7fr+JzQ=
X-Received: by 2002:a17:90b:11cd:b0:2d4:bf3:428e with SMTP id
 98e67ed59e1d1-2e0b8ec7051mr2564130a91.37.1727410114558; 
 Thu, 26 Sep 2024 21:08:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGN9B+rO4TOZgBkaUPn/OyU7JInHLbvx4Do7glLrtUBcP2u5n0Duz3lu6TrQauJinElKIErhDFq0L12jaPwpM=
X-Received: by 2002:a17:90b:11cd:b0:2d4:bf3:428e with SMTP id
 98e67ed59e1d1-2e0b8ec7051mr2564103a91.37.1727410114120; Thu, 26 Sep 2024
 21:08:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
 <20240911052255.1294071-17-zhenzhong.duan@intel.com>
In-Reply-To: <20240911052255.1294071-17-zhenzhong.duan@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 27 Sep 2024 12:08:21 +0800
Message-ID: <CACGkMEtPQGmJvYkfCfjNrsrumYKvBH8SXYdT0ZpToJ3Ac5DhYQ@mail.gmail.com>
Subject: Re: [PATCH v3 16/17] intel_iommu: Introduce a property to control
 FS1GP cap bit setting
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com, clg@redhat.com, 
 eric.auger@redhat.com, mst@redhat.com, peterx@redhat.com, jgg@nvidia.com, 
 nicolinc@nvidia.com, joao.m.martins@oracle.com, 
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com, 
 chao.p.peng@intel.com, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Sep 11, 2024 at 1:27=E2=80=AFPM Zhenzhong Duan <zhenzhong.duan@inte=
l.com> wrote:
>
> This gives user flexibility to turn off FS1GP for debug purpose.
>
> It is also useful for future nesting feature. When host IOMMU doesn't
> support FS1GP but vIOMMU does, nested page table on host side works
> after turn FS1GP off in vIOMMU.
>
> This property has no effect when vIOMMU isn't in scalable modern
> mode.

It looks to me there's no need to have an "x" prefix for this.

Other looks good.

>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Cl=C3=A9ment Mathieu--Drif<clement.mathieu--drif@eviden.com>
> ---
>  include/hw/i386/intel_iommu.h | 1 +
>  hw/i386/intel_iommu.c         | 5 ++++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.=
h
> index 650641544c..f6d9b41b80 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -308,6 +308,7 @@ struct IntelIOMMUState {
>      bool dma_drain;                 /* Whether DMA r/w draining enabled =
*/
>      bool dma_translation;           /* Whether DMA translation supported=
 */
>      bool pasid;                     /* Whether to support PASID */
> +    bool fs1gp;                     /* First Stage 1-GByte Page Support =
*/
>
>      /*
>       * Protects IOMMU states in general.  Currently it protects the
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index bb3ed48281..8b40aace8b 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3779,6 +3779,7 @@ static Property vtd_properties[] =3D {
>      DEFINE_PROP_BOOL("x-pasid-mode", IntelIOMMUState, pasid, false),
>      DEFINE_PROP_BOOL("dma-drain", IntelIOMMUState, dma_drain, true),
>      DEFINE_PROP_BOOL("dma-translation", IntelIOMMUState, dma_translation=
, true),
> +    DEFINE_PROP_BOOL("x-cap-fs1gp", IntelIOMMUState, fs1gp, true),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> @@ -4507,7 +4508,9 @@ static void vtd_cap_init(IntelIOMMUState *s)
>      /* TODO: read cap/ecap from host to decide which cap to be exposed. =
*/
>      if (s->scalable_modern) {
>          s->ecap |=3D VTD_ECAP_SMTS | VTD_ECAP_FLTS;
> -        s->cap |=3D VTD_CAP_FS1GP;
> +        if (s->fs1gp) {
> +            s->cap |=3D VTD_CAP_FS1GP;
> +        }
>      } else if (s->scalable_mode) {
>          s->ecap |=3D VTD_ECAP_SMTS | VTD_ECAP_SRS | VTD_ECAP_SLTS;
>      }
> --
> 2.34.1
>

Thanks


