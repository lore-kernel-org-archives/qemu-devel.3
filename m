Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0802DC531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 11:42:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnEHp-0007vc-UY; Fri, 24 Jul 2026 07:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnEHX-0007nS-QX
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 07:41:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnEHW-0005OX-3K
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 07:41:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784893293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xDRpoZmK0+wEMfWR8I+z16InGfMrkgjF0WYJPvGqlv4=;
 b=iNTzy09XzMXj9dOGPJyhNeEHoVxJrer+4EONQjXwVaXPo+5kGVuB6pa2Mn6PQH62Ldklrr
 whKnWyVxOJDFiTpiqX7xp5Lsq9hULfw770pWpl52/YaWogLvblWhlhqtxwGGp7udQfNr1b
 gJJq8yqOIzcDbhRggZ5M+x1TI8Pi5fY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-3UFmwv6cMYWAzvhJNvf_Ow-1; Fri, 24 Jul 2026 07:41:31 -0400
X-MC-Unique: 3UFmwv6cMYWAzvhJNvf_Ow-1
X-Mimecast-MFC-AGG-ID: 3UFmwv6cMYWAzvhJNvf_Ow_1784893290
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47f6e8b5996so404818f8f.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 04:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784893290; x=1785498090; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xDRpoZmK0+wEMfWR8I+z16InGfMrkgjF0WYJPvGqlv4=;
 b=bYkDNrLeenggTcoftc2SjXZ7Ie+SgbN9OIPy3CcMLQjCJ4xeUzOrJCpH4q7QhhF+w3
 3YxsQM7bRSR6t8U4nqqk4KMfmn+G/4F1uebcq/uXMLASWThwMUChyDXI4IkWIQTviI9V
 xo6N+jgNF9soODqVdK3RXA1D49oK5lCW88hFXTUM+0RtosEspeSZrCW4DRBBBEH6wVCK
 wP2y+aNUOGBBFFQvMZZ7wP/SKYrY5pcLwMYGCKFRdtuRO1D1XrU/zfgetQ17Ph6CjA4u
 n0KUvctYP6DDMLpNT3y93jHC2spFoWTJHOJRLOsDO+ETDt+Cqx0VFV9TekBqyEvshsRo
 VTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784893290; x=1785498090;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xDRpoZmK0+wEMfWR8I+z16InGfMrkgjF0WYJPvGqlv4=;
 b=ogqP3bqIKQMNj530KT1AbDlLNFjBv736wG13b0o9fpATKfCCvgG5TH70umEvCVLfHM
 ue7grcReFwpCR9nijQeW1NuVBeMLqIsmY/AKi8gKmIDBI/+nQdlMmzCH6zqXfYKIENi9
 x6ENBhtPv/J5/nw48zjkjILbmYDaW5fFYLVOzL3LntFi2lV+E/MgTHSTCz6YHhElIYoc
 0TK7RP3qEu+ZBtM+5LntQfJHd94yKWOlaGMzseeg6imPFJz8zQHya7pqsFIc5b18rCjP
 V6iCBEctOiE1jKUqeYS4Vao5pE/UOjD6Af8Aa2SljXrK/qyevBLOB6xpyDm0PfafRD9L
 nbkA==
X-Gm-Message-State: AOJu0YzrK5N8IVdd1wqRCecZLiJphariUBVrmTImVPb8S+c/68+wqCS2
 vfuO36Fhycf7lZmlqIfLXJmIEFK8n5w004wKDrY8Ij3YIp3sXUMnN4iIvhbCBv18VhoYw3j/o9K
 zx3vc0igA5nZ/oe4jeCa1lHswSmpoOyonbSBF7xvQcuYpwbxcVT05NlBI
X-Gm-Gg: AR+sD11hb3ipY3133ysBtsYRlUs3NzW94SZzA4JviRm5W/QJ3m4tVswzA8Hfdf8tg/v
 rn43K1eNh6FSdMXczGt88scywV2UmBNFU2TgbPwzG4p798DhIvX+SsK7DjYskVJaR4gobgpfUhZ
 IKt0WUh73HqIvyW9cpzRtBU+jNnTRm1EdsfEMi0i48wxXfnpLxRHSyqtDdqaeXG+Hw15BJu8pWi
 +3Y7xHSNaVWFWljbry/JCsN10rvmNX9RmtIFMu5jugDbsvdXzrpE51bRsOCbttspfbNWcPTYZb+
 caxM44W6E37ghup7KkNoha7Yq/fzBNILZ0saDEOFFH8qnaqpDz9OAZvqrDaG44DhGTNAeiXmagW
 v1WUSVhgipKAoNtnLSOdG+w==
X-Received: by 2002:a05:600c:4445:b0:495:f31:7340 with SMTP id
 5b1f17b1804b1-495d9de662amr15550595e9.5.1784893289691; 
 Fri, 24 Jul 2026 04:41:29 -0700 (PDT)
X-Received: by 2002:a05:600c:4445:b0:495:f31:7340 with SMTP id
 5b1f17b1804b1-495d9de662amr15550055e9.5.1784893289106; 
 Fri, 24 Jul 2026 04:41:29 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c53052sm23224069f8f.18.2026.07.24.04.41.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 04:41:28 -0700 (PDT)
Date: Fri, 24 Jul 2026 07:41:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?Cl=E9ment?= MATHIEU--DRIF <clement.mathieu--drif@bull.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v2] intel_iommu: Check address mask before using it in
 pasid-based iotlb invalidation
Message-ID: <20260724073954-mutt-send-email-mst@kernel.org>
References: <20260724111424.376680-1-clement.mathieu--drif@bull.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260724111424.376680-1-clement.mathieu--drif@bull.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Fri, Jul 24, 2026 at 11:15:32AM +0000, Clément MATHIEU--DRIF wrote:
> Prevent a buggy driver to execute malformed invalidation operations.
> 
> Add the same assert as in vtd_iotlb_page_invalidate.
> 
> Link: https://gitlab.com/qemu-project/qemu/-/work_items/3619
> Fixes: 6ebe6cf2a066 ("intel_iommu: Process PASID-based iotlb invalidation")
> Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---

changelog in the future pls.

>  hw/i386/intel_iommu.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index bf4f0f2f6b..8245452d89 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3021,6 +3021,8 @@ static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
>  {
>      VTDIOTLBPageInvInfo info;
>  
> +    assert(am <= VTD_MAMV);
> +
>      info.domain_id = domain_id;
>      info.pasid = pasid;
>      info.addr = addr;
> @@ -3060,6 +3062,13 @@ static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
>  
>      case VTD_INV_DESC_PIOTLB_PSI_IN_PASID:
>          am = VTD_INV_DESC_PIOTLB_AM(inv_desc->val[1]);
> +        if (am > VTD_MAMV) {
> +            error_report_once("%s: invalid piotlb inv desc: hi=0x%"PRIx64
> +                              ", lo=0x%"PRIx64" (am=%u > VTD_MAMV=%llu)",
> +                              __func__, inv_desc->val[1], inv_desc->val[0],
> +                              am, VTD_MAMV);
> +            return false;
> +        }
>          addr = (hwaddr) VTD_INV_DESC_PIOTLB_ADDR(inv_desc->val[1]);
>          vtd_piotlb_page_invalidate(s, domain_id, pasid, addr, am,
>                                     VTD_INV_DESC_PIOTLB_IH(inv_desc));
> -- 
> 2.54.0


