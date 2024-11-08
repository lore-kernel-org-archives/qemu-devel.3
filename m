Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E1DD5E12B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 04:42:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9Gou-00052j-OW; Thu, 07 Nov 2024 23:42:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1t9Got-00052Y-3U
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 23:42:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1t9Gor-0008TC-JO
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 23:42:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731040920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZJ5WX1idsPO1kZ/IZbohIDPrEqP7rCk1BaQxK5yliQQ=;
 b=MM9xJG/V9HW66KSQEXBDVhUvAAvIEf7JBOwyFhPXe0j0Hz+uDZMDnJ+O4ZWJMELut5r0Fj
 E3LiUi1rvPCCPr+K1YlhkOZTW/8TfJWuG5OjbkdGcPc4iqzvwzaVEveAbL5cWa+XCSm8xx
 rJGny8dWRE8fJs0C8e0m0Wd5cRfFOZI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-BNifDv0xMcayZu_brbBgnw-1; Thu, 07 Nov 2024 23:41:59 -0500
X-MC-Unique: BNifDv0xMcayZu_brbBgnw-1
X-Mimecast-MFC-AGG-ID: BNifDv0xMcayZu_brbBgnw
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2e5bd595374so1513828a91.0
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 20:41:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731040918; x=1731645718;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZJ5WX1idsPO1kZ/IZbohIDPrEqP7rCk1BaQxK5yliQQ=;
 b=xSAvLShu/c1kz+eGe0Y6CmeCx4QAwRsDrAlAux2PjAtCFHQqZAUej+PjF8zI9aBWXr
 yA9Lw8bvLXNOCvdKTDuI8L+7Mnhq+r0fHO6db/1Y9ybJEh2Npm1TM5jiMj5REm0x5s1g
 KuSIFAD8d5YDPm/pID1uwwmlRjylJ09f1I9j9bsmDpMyWONeSKrgASoDZWelYEl6r/BP
 MY1zzTpHgwehJFevjEzJ+sUwo7FCleby6d2n7Lkol9vvcOEkmwcib643jT4FsvsT4KAG
 AqinA+SejC/6LW5T5m8NGsJGjprjnYi6IEDD0sKg8tXRUz4i6Vw3J1hGZyVgemoGiW8A
 iy4Q==
X-Gm-Message-State: AOJu0YxcenrgeD82+OLqK+yFG33AoMO9i5HoscFG4AsCSMtaeb+4J/gN
 v/zdmqIrswYTfBkqSYrXDFfIloJ8j0yGwKvJYVkm0ORyrRhh0fZ1yDk5fAt3RM+LrAZ6u3YfO8Q
 9vAe2GJhkysErpxC1IHS6xXrkyp4NvgACNPiK8rN+jF2jhzjGg7Vp/BHThyhPb/jwWUveUggbY0
 fcsm4c9xOBsScRbPPRuWCDlAj9T34=
X-Received: by 2002:a17:90b:4b45:b0:2e0:8780:ecb with SMTP id
 98e67ed59e1d1-2e9b1f64d99mr2470626a91.12.1731040918215; 
 Thu, 07 Nov 2024 20:41:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYPBReL4LCHfUq9D/Hw4N9mnpMzFbnxXf7t+o2lu9kW0UzZOnSP53RTAXr/GFdu13043po0yWHXUtpibcVWjU=
X-Received: by 2002:a17:90b:4b45:b0:2e0:8780:ecb with SMTP id
 98e67ed59e1d1-2e9b1f64d99mr2470599a91.12.1731040917757; Thu, 07 Nov 2024
 20:41:57 -0800 (PST)
MIME-Version: 1.0
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
 <20240930092631.2997543-15-zhenzhong.duan@intel.com>
In-Reply-To: <20240930092631.2997543-15-zhenzhong.duan@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 8 Nov 2024 12:41:46 +0800
Message-ID: <CACGkMEsq+VrxjGMf_ma=6xumwWgb2109XB4+86zH0ZXrce5Kdg@mail.gmail.com>
Subject: Re: [PATCH v4 14/17] intel_iommu: Set default aw_bits to 48 in
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
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Mon, Sep 30, 2024 at 5:30=E2=80=AFPM Zhenzhong Duan <zhenzhong.duan@inte=
l.com> wrote:
>
> According to VTD spec, stage-1 page table could support 4-level and
> 5-level paging.
>
> However, 5-level paging translation emulation is unsupported yet.
> That means the only supported value for aw_bits is 48.
>
> So default aw_bits to 48 in scalable modern mode. In other cases,
> it is still default to 39 for backward compatibility.
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
> index 91d7b1abfa..068a08f522 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3776,7 +3776,7 @@ static Property vtd_properties[] =3D {
>                              ON_OFF_AUTO_AUTO),
>      DEFINE_PROP_BOOL("x-buggy-eim", IntelIOMMUState, buggy_eim, false),
>      DEFINE_PROP_UINT8("aw-bits", IntelIOMMUState, aw_bits,
> -                      VTD_HOST_ADDRESS_WIDTH),
> +                      VTD_HOST_AW_AUTO),
>      DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode, FALS=
E),
>      DEFINE_PROP_BOOL("x-scalable-mode", IntelIOMMUState, scalable_mode, =
FALSE),
>      DEFINE_PROP_BOOL("snoop-control", IntelIOMMUState, snoop_control, fa=
lse),
> @@ -4683,6 +4683,14 @@ static bool vtd_decide_config(IntelIOMMUState *s, =
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

I don't see how we maintain migration compatibility here.

Thanks

> +    }
> +
>      if (!s->scalable_modern && s->aw_bits !=3D VTD_HOST_AW_39BIT &&
>          s->aw_bits !=3D VTD_HOST_AW_48BIT) {
>          error_setg(errp, "%s mode: supported values for aw-bits are: %d,=
 %d",
> --
> 2.34.1
>


