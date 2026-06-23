Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8231BCDB46F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 18:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc60L-00005y-2T; Tue, 23 Jun 2026 14:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wc60H-0008SP-2d
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 14:37:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wc60D-0006e5-HU
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 14:37:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782239860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HbAp3gR82O0Tki/7mrcsfzsxUfaSThyn2zUS4xew+kw=;
 b=Ttj5M4X60keb051gemppHO0EqpgLGvYUiGg0oZJJq4ZMZFzGKsODItg1U4CZf4yyrkIG14
 GkAcJLarWIENvIDegyK3+dWIYpcwocfrkgteENHfu5TArSOwAqQAWRadUquOj9W4EzWa91
 eV6xwt3mc+NRfDWiYlTw87njCtIuywU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-hyILQfUeOjm0vFq6R2V6PA-1; Tue, 23 Jun 2026 14:37:38 -0400
X-MC-Unique: hyILQfUeOjm0vFq6R2V6PA-1
X-Mimecast-MFC-AGG-ID: hyILQfUeOjm0vFq6R2V6PA_1782239857
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490b9cd54f3so1045065e9.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 11:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782239857; x=1782844657; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HbAp3gR82O0Tki/7mrcsfzsxUfaSThyn2zUS4xew+kw=;
 b=EiE1FeK188NbvKCfqLh4TyYnjjts9d4q8OUuPHld1Z84dX9Ig1ySExyjfTR/LAFakv
 gnB8k86spGgdy12+/0h47gWytOMUvJjJ1Mp1fp0ZB6IpGYvQSIygwG2VxOM01KikGPsY
 G8DU3cjMXbCAryja7aoD9R2Iq0ze2u1so9w7no2NN+QG7ywD+YCrVZd3dS57rdm/gc5+
 qi2IbT6mDMQ9uWk8QHS95C4q5T8ATY8TznXZaMbxFmO1v4O+uEGjhBIklWzKARELjIpG
 KVYKfxJCpNStx/akzkK57EYSxu0n8mtO9hbdTtL4OZr1XRNV0J3+4f/I5sdbN/E6RExc
 j3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782239857; x=1782844657;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HbAp3gR82O0Tki/7mrcsfzsxUfaSThyn2zUS4xew+kw=;
 b=VVNLLH+ZC9a0dbmVWATdxm2jO1PmffMVobnhvxgtbFtoiisl8MQRGX5P98rSku1YSW
 Zy2VtKRKuEauT7x2f1igyEJb6HuXqgAJHGjt8fywt6XP7VNDu6lUFvk9+rcVPwZQ8StT
 TPxaPz7FUc3yoWBJUWoam7etBhweFj0p2h9tIed/z5bspXNjPTvHhVutf2yd4VEOizvq
 WqmqQeCTPo/PLXd7YqDSp4R1U2TrwoAAvH4lziH7z1+YkJQFMts+HFRogOB1bNpK3w9w
 uhIabIvOAMXd94HfkzcNFHDXJjA67IWZcF2SIljNqlm9hGKGTcsbeYndc1L2xzPyaUfb
 /eIw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8xStfJIacCp7kUaOb4rrIj+qavUqDLBT0y56qxAFO1hUmrK2iKHIQBs2oh86i0Mbu+YtKMa0ZQDOhN@nongnu.org
X-Gm-Message-State: AOJu0YzJYl4iWi4eChUrnI0/cXVaXUOCVEDapqnkfoP5XJGAjfLiXsp2
 GTi1B9/xli3PfCR8ZHgbqLE0JbaPyyQc4/MPhE9MMl6kg8c+uoe2iEuRaAh8ct7pNGrPEw0G72y
 K6Ji2SiG3EAFyYqQMZ32aYlKQj4FZoizW1QmMgWEwKYfHyvAr+FQoEBVZ
X-Gm-Gg: AfdE7cnz0XFD6Vmfrx4OrKuWWngc6ssEJlg/yGwftkn+SpBnB+HNxfGJ7ElErJsGjVv
 Ff+CVWG3J5ZObgMi2VzADtQGJ+17xeeQQuutKunLCCkMNEwud/UYodwofx0eA25hk6oJkLJ1Stf
 xnnxOvg++QiHND2o2wkdcdNmjtjFeOFs5vGSAtzLvc6EkCNxanUeMrNsHTjMhQJiSFsPofhh6oC
 +HThSsRxyzs86D3KHkIRrTw9SiVO5wcaK+N1/MXQ8gf3Hg7clH+vUyxuD2aKNxoyW1ZFKcuragN
 T3cMqpAplZSKgnamuN28y/Qf7A4HaXYJoMJ5p10xReZlLK9XKbGPGpEVjIkgLKRTo8zHUDuw31K
 Rp70KMGP5YA/Ja3abBtHkhICHm4Ukr+EN
X-Received: by 2002:a05:600c:3495:b0:490:e196:e8df with SMTP id
 5b1f17b1804b1-4925b3aa15bmr61594125e9.23.1782239856652; 
 Tue, 23 Jun 2026 11:37:36 -0700 (PDT)
X-Received: by 2002:a05:600c:3495:b0:490:e196:e8df with SMTP id
 5b1f17b1804b1-4925b3aa15bmr61593705e9.23.1782239856084; 
 Tue, 23 Jun 2026 11:37:36 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923ff821aasm417318305e9.12.2026.06.23.11.37.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 11:37:35 -0700 (PDT)
Date: Tue, 23 Jun 2026 14:37:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 qemu-devel@nongnu.org, sarunkod@amd.com, pbonzini@redhat.com,
 richard.henderson@linaro.org
Subject: Re: [PATCH 2/2] amd_iommu: Fully initialize XT interrupt message state
Message-ID: <20260623143614-mutt-send-email-mst@kernel.org>
References: <20260623005813.984238-1-alejandro.j.jimenez@oracle.com>
 <20260623005813.984238-3-alejandro.j.jimenez@oracle.com>
 <CAFEAcA8NKB6Wg-Gsbv_NXp72PLADS=h7p7KyLCW1gRCbywESfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8NKB6Wg-Gsbv_NXp72PLADS=h7p7KyLCW1gRCbywESfQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jun 23, 2026 at 09:44:10AM +0100, Peter Maydell wrote:
> On Tue, 23 Jun 2026 at 01:58, Alejandro Jimenez
> <alejandro.j.jimenez@oracle.com> wrote:
> >
> > When IOMMU x2APIC interrupts generation (IntCapXTEn) is enabled,
> > amdvi_build_xt_msi_msg() builds an MSI message using the relevant values in
> > the XT IOMMU General Interrupt Control Register.
> >
> > Initialize the local X86IOMMUIrq structure with zero for all fields. This
> > ensures that X86IOMMUIrq fields not set in the XT register (e.g.
> > msi_addr_last_bits) are initialized before x86_iommu_irq_to_msi_message()
> > consumes them.
> >
> > Remove the redundant 'struct' keyword in X86IOMMUIrq irq declaration.
> >
> > CID: 1660056
> > Fixes: cf0210df65aa ("amd_iommu: Generate XT interrupts when xt support is enabled")
> > Reported-by: Peter Maydell <peter.maydell@linaro.org>
> > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> > ---
> >  hw/i386/amd_iommu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> > index 0d273fd33d..9005dc7aab 100644
> > --- a/hw/i386/amd_iommu.c
> > +++ b/hw/i386/amd_iommu.c
> > @@ -195,7 +195,7 @@ static void amdvi_assign_andq(AMDVIState *s, hwaddr addr, uint64_t val)
> >  static void amdvi_build_xt_msi_msg(AMDVIState *s, MSIMessage *msg)
> >  {
> >      union mmio_xt_intr xt_reg;
> > -    struct X86IOMMUIrq irq;
> > +    X86IOMMUIrq irq = { 0 };

Why don't we just initialize everything at the declaration site?

union mmio_xt_intr xt_reg = { .val = ... };
X86IOMMUIrq irq = { .... };

> This is fine for the Coverity problem, but you do also need to
> get rid of the bitfield-union as a separate issue.

Ideal task for AI actually.

> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> thanks
> -- PMM



