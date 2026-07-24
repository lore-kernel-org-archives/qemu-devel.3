Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 019A9C531FA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 08:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnBJx-0008Ag-Lq; Fri, 24 Jul 2026 04:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnBJv-0008A5-N0
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 04:31:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnBJt-0002bP-VD
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 04:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784881908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=31mEw0kQfsgvxo1tLpTrx2jvayalMYgVMmEXlYnlDx0=;
 b=TiBtiJUpgZr2bx9yqOq7y3gDXkVPLJH7dIsQf+oWyZciAG/7I2mwQE1LwN/QCgGOjbA0Vu
 2E9t8t/ABisJE4O7BIJ81woYWXScZ3RPwWuAgdA/qZDNAJUSuLSt6OtcDno3I/Ki1Am01y
 YHYeFiJgc9K06lzGYRZax6CwUiIOqFE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-i3awWlv1OTCX3xUMMgHWIw-1; Fri, 24 Jul 2026 04:31:47 -0400
X-MC-Unique: i3awWlv1OTCX3xUMMgHWIw-1
X-Mimecast-MFC-AGG-ID: i3awWlv1OTCX3xUMMgHWIw_1784881906
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-495474a5fbcso2121055e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 01:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784881906; x=1785486706; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=31mEw0kQfsgvxo1tLpTrx2jvayalMYgVMmEXlYnlDx0=;
 b=YwzDJskEtoUAzMA9e0K5yBrOsdWSq8iCeFFMM4yyMHeiLKf5o/iekqnGh7sQPO6WDv
 JXd+M9//790snHxD2rsCgBKGk3KtQ+7PO9ldNStc0WYKrtepq06OK0M/gMkyCGByE6hj
 kSShdYsXHmwpcEEu2+0VL+w9B+CgnL3/YBAFO9BDjxadRXegL3FH/lQ3uBoqnVVCf+WJ
 Pi+Al6ka3O1NP6x+yi28WykTfF3Dlod0C2jg7yD+ETfbapEtf9S/x9v66/QiRVg+oZ+U
 p3fU6+LU5Xpsd51MbQU/YW2EUnK0/SkfRWSIxVHG+lhucVGn+Xmo+VuO8IlsFfvftoIJ
 ac0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784881906; x=1785486706;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=31mEw0kQfsgvxo1tLpTrx2jvayalMYgVMmEXlYnlDx0=;
 b=bab1UmFT2wdZvTnLkGf76EtYJpqdaB7DBL9dVS7Ue5EGTOaiXSLCGdFQpewBPOYdCX
 NbuuO1DA1kzE35aY1036CYzpQQVqsWj13UapIcZE7zE/3YvX4qi+oWyA7r3Eh+2/Jmd3
 TBdXW68lRQ/e1nd0U7kQcvUut6JiMouVK4KvFmP8kRgSn0mbyQPwNuXhlwDKbunAMe2t
 cCzSGZWwNwtn3bF/2qxU+I0F4MqhQHJg7paJymqeL4TPfasi/SIoHEx7GJ3zEDCA5sSw
 EYHbGe50ctuyOEOW9edGotb2AMzmlmosj9n5GGGtTJrqKfq90RlDf1UFkQx9inY3rV+E
 Oe0A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqWbCrJAzy2K9skFxIC7R06VQGx849LDoZFRVXNci6rA4YT/FfJ1o47DRVgK7rhnm5leYJSCXQyQelh@nongnu.org
X-Gm-Message-State: AOJu0YwoHFmY45rPZlPe/4bjiRSGyE7iuwhMl7x9iEeGHsrdnHAroUM1
 +MjlcTVK6n/lsbguUMYLx6Pr/HBfhrZDwd8weQ3S154GZu1NT+IsOvRR+T32vQCU1JRW7g+vRNI
 EpXBJKuvxpu6Kx7R0dZcJ1SuZ0cH10b9t4y4e9aaEOi30+z5Aa5awqwdd
X-Gm-Gg: AR+sD13KlLUmd55L/4dvpB+UGJuOb9qPMYD2Wfs0BYN0+xIOdyidXsMfeESg0tDDz9u
 C6sZ+2OQGc1EeOZo5stZ5ILzU5LQ+Rgw3HukzAt2PJMagraBDbUVSX5joV33mLTXhsLABhXyz18
 YGN5k/hF/3x/LNpRqtLov39/ObBKxx/e+elGsbBouEO8pym65QQR2D7NVSXPQa/O4wb9NfAxeGP
 DBo/voLYSMvG67Y2WlB+V8+FJedt8+QXsc9FkQ6KGrKUA85DyU+/di8DNZQHwhcfrL4EWxNXtMK
 7u7gblfSmnFp5RQDLlHRnB+3gkKGXiSPXHYrpnaCxOKbo7TGkMjXF16KqtjxY8ttvs3XxTqebwH
 c4A1T+QJh4BxpncCUloZV6Q==
X-Received: by 2002:a05:600c:6304:b0:495:7561:a9ed with SMTP id
 5b1f17b1804b1-4957561ab17mr76029665e9.17.1784881905452; 
 Fri, 24 Jul 2026 01:31:45 -0700 (PDT)
X-Received: by 2002:a05:600c:6304:b0:495:7561:a9ed with SMTP id
 5b1f17b1804b1-4957561ab17mr76029165e9.17.1784881904896; 
 Fri, 24 Jul 2026 01:31:44 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85bd77a9sm21234822f8f.14.2026.07.24.01.31.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 01:31:44 -0700 (PDT)
Date: Fri, 24 Jul 2026 04:31:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Cc: =?iso-8859-1?Q?Cl=E9ment?= MATHIEU--DRIF <clement.mathieu--drif@bull.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>
Subject: Re: [PATCH] intel_iommu: Check address mask before using it in
 pasid-based iotlb invalidation
Message-ID: <20260724042948-mutt-send-email-mst@kernel.org>
References: <20260715132652.1488991-1-clement.mathieu--drif@bull.com>
 <0d09f774-df0d-4f5f-90c0-055cf0cd7fc8@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d09f774-df0d-4f5f-90c0-055cf0cd7fc8@oss.qualcomm.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.951,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jul 24, 2026 at 08:08:50AM +0200, Philippe Mathieu-Daudé wrote:
> On 15/7/26 15:27, ClÃ©ment MATHIEU--DRIF wrote:
> > Prevent a buggy driver to execute malformed invalidation operations.
> > 
> > Add the same assert as in vtd_iotlb_page_invalidate.
> > 
> > Link: https://gitlab.com/qemu-project/qemu/-/work_items/3619
> > Fixes: 6ebe6cf2a066 ("intel_iommu: Process PASID-based iotlb invalidation")
> > Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
> > ---
> >   hw/i386/intel_iommu.c | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> > 
> > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > index bf4f0f2f6b..c591d1db3f 100644
> > --- a/hw/i386/intel_iommu.c
> > +++ b/hw/i386/intel_iommu.c
> > @@ -3021,6 +3021,8 @@ static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
> >   {
> >       VTDIOTLBPageInvInfo info;
> > +    assert(am <= VTD_MAMV);
> > +
> >       info.domain_id = domain_id;
> >       info.pasid = pasid;
> >       info.addr = addr;
> > @@ -3060,6 +3062,13 @@ static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
> >       case VTD_INV_DESC_PIOTLB_PSI_IN_PASID:
> >           am = VTD_INV_DESC_PIOTLB_AM(inv_desc->val[1]);
> > +        if (am > VTD_MAMV) {
> > +            error_report_once("%s: invalid piotlb inv desc: hi=0x%"PRIx64
> > +                              ", lo=0x%"PRIx64" (am=%u > VTD_MAMV=%u)",
> > +                              __func__, inv_desc->val[1], inv_desc->val[0],
> > +                              am, (unsigned)VTD_MAMV);
> 
> Better use the PRIu64 format instead of this surprising cast,

I think you mean %llu - PRIu64 is for uint64_t

> anyway:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> 
> > +            return false;
> > +        }
> >           addr = (hwaddr) VTD_INV_DESC_PIOTLB_ADDR(inv_desc->val[1]);
> >           vtd_piotlb_page_invalidate(s, domain_id, pasid, addr, am,
> >                                      VTD_INV_DESC_PIOTLB_IH(inv_desc));


