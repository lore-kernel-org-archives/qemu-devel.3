Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18DFCEBF69
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 04:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1su2HL-0003Vv-Q6; Fri, 27 Sep 2024 00:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1su2HK-0003Or-1R
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 00:08:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1su2HI-0006GT-Gb
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 00:08:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727410102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s7tzts8FG+d/e1j+wzWbfvK4LxyPeqzPVYQemVOR5mI=;
 b=YhstneL4a/w+zq4gUgJqrjWtGGOp8+8CmXkGjz0f63MZOwU86/QpsSZSWADmKXns1nriN/
 NytlcNPa0JroFjyWPWi0LElvIICwT3UAqm1eVdYbC2CCXE1V6DhgGamiQV5BBt1Ep6zLUL
 2xVMonH5LGKxGz5/DmF8yXxSFGvsMIY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-kxckg9feMMCtnLZBLMc-uw-1; Fri, 27 Sep 2024 00:08:20 -0400
X-MC-Unique: kxckg9feMMCtnLZBLMc-uw-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2e0d1a1de58so10947a91.2
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2024 21:08:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727410100; x=1728014900;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s7tzts8FG+d/e1j+wzWbfvK4LxyPeqzPVYQemVOR5mI=;
 b=QILMlcPycrJITjNO7YzNeoNe/xDEkaV3HL2fSIEpDfV73HwDyIJ1EUdI5uMwi+p2ef
 s4HW6XbnEw8hscFfSfckXGQGgS4Tx7kMq1udkSH1JxZBtJNp9lQSgjY/j2MIjuSOEbJC
 3OprxGyAShEkbCjUs/953jzc4xSZbwGrHG5neckC5SO1Qz0xidwMryWhQobn7x3bxigj
 JXL+P0UHjl3zu96XPe+Jhd5XBuVgpB0+yNiKtYORgxB69kyMowlE2Q6cZGvUw66b7tUu
 1OqzKRB/cf6DZ4kBpr9l7LpmAAjQn9TUGDMaLIENgB3Ex5ou5xYyf4rWLJpRkenPC17s
 4uXg==
X-Gm-Message-State: AOJu0YybpJON5vDUymjxp785F0r66+n33GQV0K5iwa11qvGh4eHq/h6h
 O2E2RzCzeucFH9wsRxMk+t9CsH5x8q3qvS8OIgU1tJgK+hy1wlt4U8R5GilFhWZTjbqVE6PUwgI
 Ui49SbIj87OuRtasiPil8GfkIQ3O7+7Q5YLYYdQJfUp/rjib1IhU4H38KsBkX8qumTJf2uGbxyI
 vveE+w4OxsP9pQouJJ4UijKNcO/00=
X-Received: by 2002:a17:90a:bf03:b0:2dd:6969:208e with SMTP id
 98e67ed59e1d1-2e0b899c3admr2379988a91.3.1727410099816; 
 Thu, 26 Sep 2024 21:08:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfXWVoerCUbReUrw50FYJYOejvCfDN5wtFS4cPBmI1zOEX/3PtjAfYFk8wMVwHedOAX16HrpMKEbIZdD0Abgw=
X-Received: by 2002:a17:90a:bf03:b0:2dd:6969:208e with SMTP id
 98e67ed59e1d1-2e0b899c3admr2379960a91.3.1727410099387; Thu, 26 Sep 2024
 21:08:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
 <20240911052255.1294071-15-zhenzhong.duan@intel.com>
In-Reply-To: <20240911052255.1294071-15-zhenzhong.duan@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 27 Sep 2024 12:08:06 +0800
Message-ID: <CACGkMEuV=ZdnGE7N=YehCxpNiVPXai=WUdgJjnxVxwzBnTMEOQ@mail.gmail.com>
Subject: Re: [PATCH v3 14/17] intel_iommu: Set default aw_bits to 48 in
 scalable modern mode
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
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
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
> According to VTD spec, stage-1 page table could support 4-level and
> 5-level paging.
>
> However, 5-level paging translation emulation is unsupported yet.
> That means the only supported value for aw_bits is 48.
>
> So default aw_bits to 48 in scalable modern mode. In other cases,
> it is still default to 39 for compatibility.
>
> Add a check to ensure user specified value is 48 in modern mode
> for now.
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Cl=C3=A9ment Mathieu--Drif<clement.mathieu--drif@eviden.com>
> ---
>  include/hw/i386/intel_iommu.h |  2 +-
>  hw/i386/intel_iommu.c         | 10 +++++++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.=
h
> index b843d069cc..48134bda11 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -45,7 +45,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(IntelIOMMUState, INTEL_IOMMU=
_DEVICE)
>  #define DMAR_REG_SIZE               0x230
>  #define VTD_HOST_AW_39BIT           39
>  #define VTD_HOST_AW_48BIT           48
> -#define VTD_HOST_ADDRESS_WIDTH      VTD_HOST_AW_39BIT
> +#define VTD_HOST_AW_AUTO            0xff
>  #define VTD_HAW_MASK(aw)            ((1ULL << (aw)) - 1)
>
>  #define DMAR_REPORT_F_INTR          (1)
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index c25211ddaf..949f120456 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3771,7 +3771,7 @@ static Property vtd_properties[] =3D {
>                              ON_OFF_AUTO_AUTO),
>      DEFINE_PROP_BOOL("x-buggy-eim", IntelIOMMUState, buggy_eim, false),
>      DEFINE_PROP_UINT8("aw-bits", IntelIOMMUState, aw_bits,
> -                      VTD_HOST_ADDRESS_WIDTH),
> +                      VTD_HOST_AW_AUTO),

Such command line API seems to be wired.

I think we can stick the current default and when scalable modern is
enabled by aw is not specified, we can change aw to 48?

>      DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode, FALS=
E),
>      DEFINE_PROP_BOOL("x-scalable-mode", IntelIOMMUState, scalable_mode, =
FALSE),
>      DEFINE_PROP_BOOL("snoop-control", IntelIOMMUState, snoop_control, fa=
lse),
> @@ -4686,6 +4686,14 @@ static bool vtd_decide_config(IntelIOMMUState *s, =
Error **errp)
>          }
>      }
>
> +    if (s->aw_bits =3D=3D VTD_HOST_AW_AUTO) {
> +        if (s->scalable_modern) {
> +            s->aw_bits =3D VTD_HOST_AW_48BIT;
> +        } else {
> +            s->aw_bits =3D VTD_HOST_AW_39BIT;
> +        }
> +    }
> +
>      if ((s->aw_bits !=3D VTD_HOST_AW_39BIT) &&
>          (s->aw_bits !=3D VTD_HOST_AW_48BIT) &&
>          !s->scalable_modern) {
> --
> 2.34.1
>

Thanks


