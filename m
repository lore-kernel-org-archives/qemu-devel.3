Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BDAFC55162
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2026 16:48:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqZMG-0003d5-AH; Sun, 02 Aug 2026 12:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wqZM8-0003cp-9u
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 12:48:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wqZM6-0001jO-Rg
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 12:48:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785689284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wXxmRav3f/UbnZh4bhXnFkDtA8HUKvTnHPOpwg+8Gw8=;
 b=CBsKpKy545GiKYg/HBM7C6mGRJPF5O72v+6bJP44yLwdf3Zj+aboJ89JBrAzkRHw5v76qv
 7iO5FcZTAP4oyHY2ujkk61CBpgC+wXw9D9pfadLE/L7XnUb5Tf+iV98cDodcmnrQk3QCRT
 qXfpWIXXXRDqBdjhngo72QQIwx4ya0g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-7H9u6d5fPLunXUOKX0NP2A-1; Sun, 02 Aug 2026 12:48:00 -0400
X-MC-Unique: 7H9u6d5fPLunXUOKX0NP2A-1
X-Mimecast-MFC-AGG-ID: 7H9u6d5fPLunXUOKX0NP2A_1785689279
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-496b6f97676so15281235e9.2
 for <qemu-devel@nongnu.org>; Sun, 02 Aug 2026 09:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785689279; x=1786294079; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wXxmRav3f/UbnZh4bhXnFkDtA8HUKvTnHPOpwg+8Gw8=;
 b=oXTHHHjQOuquSLOti23w9x6KMheDASFPy3IYE1E42Zu0kbmMbi+ASTsjVE7bsyKOXm
 Z4NJCazrjWHwtTy/ldgp48vYOD4hauqLAgCUbPpenhnlX8OMuiFJnqA73Sl18Js+4bMK
 zcyiDuEEFz2RWO7WarpHgsVJVGijzHwxmywM/qiczwExAbyTYrkjaHrNFccjHx7gJzae
 MHVfAceAZBqYTZBewUbDdx4jwPlMEbxVMqJ0L69FllaRiCsYz0BtkHFVmR7AV3ZSzyX7
 ofRKvAnsTRJcng/Z38Dbelo7HW+hwfjkTWXZh1VIvwuJ9uwAymDtZ9n0EVhBr1fwIWvS
 633Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785689279; x=1786294079;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wXxmRav3f/UbnZh4bhXnFkDtA8HUKvTnHPOpwg+8Gw8=;
 b=W/50+caHnwsCd77elWn4bjA/iPDehFSpDVIIziH8P+s8myH/1/ADM1Z7t8GOcaIYPX
 t/Kry3DrgvhXTkUrXsNROpTdOb2aQuk5nuhtgpM1g9S+30hQF0Ah2xHeVKenW04d7bOy
 IRm7mqpF6ohz33OP/2uU/Mb8PIqFrz4a661XXcAdWD5uh+Hvcn8GRvhxVLkS17c1rLgR
 c5ejAhBEXe9nPWgz1/Ww/BneqHhQQw7PaIUNKrr7Lf/0R/3n8zlgtNXwTuaz0NxsoUIY
 hqR+2dxmvtA9p7rXI/p/7Di2cZfWvyldXVYMlOaBeaUrIhwH7p+KreVq2a5lXRxlB/vy
 QLAg==
X-Gm-Message-State: AOJu0Yw7P0YtMHvhWF+I8vpCaPlibj/bQQ6oqC56/ic3vs83VuOR5l4H
 aEEH85nJq5ERQk7hSJtAid1Dqp9sDqxhTBYNkitglMpzzAW6V7JAGg+h3QfA6Kb4d5xHblvqWC7
 lqH9s6Z2M9FYhvh8jzTmEcVl1jcTPH+q4auXU6lb4tjLhCJO9JNFk2fP/
X-Gm-Gg: AR+sD13DQkz+Fhtwii73iXEdHDGfp0LsdX9AdyXKCjiUZxYbSw8Qoit9WYaMOx7Nwvz
 ME+D4/CjUdF6E+TzEY+mrEBFwdAektIFUOVyvVVQPI0wQ3PsI3we6COeu4f6+i8JrqcJ2sn5hEq
 wbdmMmOSGj/ZXHMvUKmXdpaS6Saznhsd6NECxp2rr8fnhlX2kp71UAalKr1nRx71Xs/IikhW9n4
 t1QXJ+qHmvxp1BX0lIpk/IwqohYD7hlpMJ5bCUbzRAA4ZOmRAyiLTsm/nP5OpyCPxu9xx3fHkN5
 yJUonJE6FGzgIbedKiaNK05wXt6I9zkh2lTKFixOJ0E6jDJAxO1Ixs8DJ8ozGziE6k1GYbrrz8R
 bsiYxOCrJPiLx81XH4cTJQw==
X-Received: by 2002:a05:600c:8b08:b0:495:5b4a:53b7 with SMTP id
 5b1f17b1804b1-4980c694e4amr176817805e9.19.1785689279325; 
 Sun, 02 Aug 2026 09:47:59 -0700 (PDT)
X-Received: by 2002:a05:600c:8b08:b0:495:5b4a:53b7 with SMTP id
 5b1f17b1804b1-4980c694e4amr176817325e9.19.1785689278785; 
 Sun, 02 Aug 2026 09:47:58 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49808191be8sm229684615e9.2.2026.08.02.09.47.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2026 09:47:58 -0700 (PDT)
Date: Sun, 2 Aug 2026 12:47:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?Cl=E9ment?= MATHIEU--DRIF <clement.mathieu--drif@bull.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowangio@gmail.com" <jasowangio@gmail.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v1] intel_iommu: Expose SMPWC when SVM is enabled
Message-ID: <20260802124718-mutt-send-email-mst@kernel.org>
References: <20260802160408.645484-1-clement.mathieu--drif@bull.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260802160408.645484-1-clement.mathieu--drif@bull.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.811,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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

On Sun, Aug 02, 2026 at 04:05:08PM +0000, Clément MATHIEU--DRIF wrote:
> SVM in Linux requires SMPWC as of 780dfed68862. This is free in the
> current implementation as it is already in line with the expected
> behaviour.
> 
> Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
> ---
>  hw/i386/intel_iommu.c          | 3 ++-
>  hw/i386/intel_iommu_internal.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 8245452d89..9f21622a4f 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -5108,7 +5108,8 @@ static void vtd_init(IntelIOMMUState *s)
>      }
>  
>      if (s->svm) {
> -        s->ecap |= VTD_ECAP_PRS | VTD_ECAP_PDS | VTD_ECAP_NWFS;
> +        s->ecap |= VTD_ECAP_PRS | VTD_ECAP_PDS | VTD_ECAP_NWFS |
> +                   VTD_ECAP_SMPWCS;
>      }
>  
>      vtd_reset_caches(s);
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 924e91cb8a..df7a0efa6e 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -202,6 +202,7 @@
>  #define VTD_ECAP_SMTS               (1ULL << 43)
>  #define VTD_ECAP_SSTS               (1ULL << 46)
>  #define VTD_ECAP_FSTS               (1ULL << 47)
> +#define VTD_ECAP_SMPWCS             (1ULL << 48)
>  
>  /* CAP_REG */
>  /* (offset >> 4) << 24 */

Any cross version migration concerns with this one?


> -- 
> 2.54.0


