Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B168BC3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 07:03:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se81m-0003UG-8k; Wed, 14 Aug 2024 03:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1se81j-0003TY-GK
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 03:02:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1se81h-0007QO-CU
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 03:02:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723618951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CkneSoPm6+Orf9AXwbLH3XXYg1RSUbNwxOq8JRHqSsw=;
 b=H9/mKXLUZenzVUxTiSYyoU2Ph8n5eGnKoJPWbadlXr5CUffaBBkQc1pq2YBkNMwFWx7ixN
 VEBSjO/yMDNmdM9nh9lXRzrYi9IyW+5ZVlrnirAfcS+Ubm8PH2ouG/j9KrfiyhzAiTMRPE
 /qrxtQ/i9Oueug7eD8vQgFmN3qbi4Ik=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-hZy28YcGNceq7c3La8jIMg-1; Wed, 14 Aug 2024 03:02:28 -0400
X-MC-Unique: hZy28YcGNceq7c3La8jIMg-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-52efe4c2261so8253391e87.1
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 00:02:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723618947; x=1724223747;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CkneSoPm6+Orf9AXwbLH3XXYg1RSUbNwxOq8JRHqSsw=;
 b=qpwtAreY+wh3UnEQJZedMOoM7gHp/pnh9l6CZetV4YTT85C5SDfUlT5RrkbzxqAHV2
 e2dSuOnDa5dtG2sJyRJ6naBMO3G25TMtOqw0Nqs3IWia/6FFL5ztM1h5nexseDR48mCI
 /6E0ED95Du8W09SV7N7D5DCK9t/ApFP0+BCfyyszXfloSeBnz86vUQnkdSyRXg03t0Ui
 MmXHAwCOjLvcrEtEKT/b05Q2QN14+4e1HgbVJfj3Dk91GSpSvt8yhc/jUeMF77HsyoW9
 WFc4TjazisxB8Awj40f/tPGuon2bJEvJHSN2H4isDV0PjyfzGGleQ9gSVUqHyQ/lfKPs
 P+QQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPo8+AYne/OP5aDDsc74g5VDPmVPgUshFTZJtVieCRuKt0FymmXdayhxHP76HfiwAP3WOJuBpa5+HF@nongnu.org
X-Gm-Message-State: AOJu0YzEe6G2krKzhAp6T7/4ZRZLaEzAoKElg+vfs/TWOBE2Us7QB4Xi
 cZaIsWbPWC18NA4igi7VHzF8vaxYHCc30/Q1QGWnAo/4k2DzD8XpR4ummAkWHERdw3Lno1gU2zH
 2FxwVxnXBCA6V2unR4AT82X8Bpw32G0RiYLlsS1lE9TnCWx65lenX
X-Received: by 2002:a05:6512:2203:b0:52e:9904:71e with SMTP id
 2adb3069b0e04-532eda8a842mr1127455e87.28.1723618947100; 
 Wed, 14 Aug 2024 00:02:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIKtWtFEfBIrSCWXi0sYdMauFUo+2G9i6jwqT/TqgSJvZ4TvYm2njCQfbe/PtMFzK7G3IsKQ==
X-Received: by 2002:a05:6512:2203:b0:52e:9904:71e with SMTP id
 2adb3069b0e04-532eda8a842mr1127404e87.28.1723618946082; 
 Wed, 14 Aug 2024 00:02:26 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:346:dcde:9c09:aa95:551d:d374])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a80f3f49748sm134791466b.4.2024.08.14.00.02.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 00:02:24 -0700 (PDT)
Date: Wed, 14 Aug 2024 03:02:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Peng, Chao P" <chao.p.peng@intel.com>,
 =?iso-8859-1?Q?Cl=E9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Jason Wang <jasowang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v3 2/2] intel_iommu: Make PASID-cache and PIOTLB type
 invalid in legacy mode
Message-ID: <20240814030202-mutt-send-email-mst@kernel.org>
References: <20240814022654.2612780-1-zhenzhong.duan@intel.com>
 <20240814022654.2612780-3-zhenzhong.duan@intel.com>
 <a08417ee-8315-45a4-b065-c6787db92f4a@intel.com>
 <SJ0PR11MB6744F3FD7B8B23AF47E2A09292872@SJ0PR11MB6744.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SJ0PR11MB6744F3FD7B8B23AF47E2A09292872@SJ0PR11MB6744.namprd11.prod.outlook.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Aug 14, 2024 at 03:05:33AM +0000, Duan, Zhenzhong wrote:
> 
> 
> >-----Original Message-----
> >From: Liu, Yi L <yi.l.liu@intel.com>
> >Subject: Re: [PATCH v3 2/2] intel_iommu: Make PASID-cache and PIOTLB
> >type invalid in legacy mode
> >
> >On 2024/8/14 10:26, Zhenzhong Duan wrote:
> >> In vtd_process_inv_desc(), VTD_INV_DESC_PC and VTD_INV_DESC_PIOTLB
> >are
> >> bypassed without scalable mode check. These two types are not valid
> >> in legacy mode and we should report error.
> >>
> >> Fixes: 4a4f219e8a1 ("intel_iommu: add scalable-mode option to make
> >scalable mode work")
> >
> >4a4f219e8a10 would be better. :)
> 
> Ah, OK, Michael, let me know if you want me send a new version.
> 
> Thanks
> Zhenzhong


Yes pls, also pls Cc me on the cover letter.

> >
> >> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> >> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> >> Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
> >> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
> >> ---
> >>   hw/i386/intel_iommu.c | 22 +++++++++++-----------
> >>   1 file changed, 11 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> >> index 68cb72a481..90cd4e5044 100644
> >> --- a/hw/i386/intel_iommu.c
> >> +++ b/hw/i386/intel_iommu.c
> >> @@ -2763,17 +2763,6 @@ static bool
> >vtd_process_inv_desc(IntelIOMMUState *s)
> >>           }
> >>           break;
> >>
> >> -    /*
> >> -     * TODO: the entity of below two cases will be implemented in future
> >series.
> >> -     * To make guest (which integrates scalable mode support patch set in
> >> -     * iommu driver) work, just return true is enough so far.
> >> -     */
> >> -    case VTD_INV_DESC_PC:
> >> -        break;
> >> -
> >> -    case VTD_INV_DESC_PIOTLB:
> >> -        break;
> >> -
> >>       case VTD_INV_DESC_WAIT:
> >>           trace_vtd_inv_desc("wait", inv_desc.hi, inv_desc.lo);
> >>           if (!vtd_process_wait_desc(s, &inv_desc)) {
> >> @@ -2795,6 +2784,17 @@ static bool
> >vtd_process_inv_desc(IntelIOMMUState *s)
> >>           }
> >>           break;
> >>
> >> +    /*
> >> +     * TODO: the entity of below two cases will be implemented in future
> >series.
> >> +     * To make guest (which integrates scalable mode support patch set in
> >> +     * iommu driver) work, just return true is enough so far.
> >> +     */
> >> +    case VTD_INV_DESC_PC:
> >> +    case VTD_INV_DESC_PIOTLB:
> >> +        if (s->scalable_mode) {
> >> +            break;
> >> +        }
> >> +    /* fallthrough */
> >>       default:
> >>           error_report_once("%s: invalid inv desc: hi=%"PRIx64", lo=%"PRIx64
> >>                             " (unknown type)", __func__, inv_desc.hi,
> >
> >--
> >Regards,
> >Yi Liu


