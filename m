Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90ABFCD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 22:10:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMYp3-0000i9-Im; Mon, 11 May 2026 18:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wMYoy-0000hg-SU
 for qemu-devel@nongnu.org; Mon, 11 May 2026 18:09:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wMYow-0001gW-La
 for qemu-devel@nongnu.org; Mon, 11 May 2026 18:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778537388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8lfM790bPPcW9+6QJ2OF4Giuvz/HJzNJe7b9mqE9Dco=;
 b=fkwjCMsxF1HEEYN18dhkROQsNyP0hwx3xfBN2wUHTg9kspiI4hx72+nFAICrJLHP0D/C24
 /r91rnGAy/zx8QNdiTcJZvE0WQeBmGMnhvBx3tn+UXebeDuHTL7OojZOpdINXe9CEeyunM
 fkAWCIqHkgcY5u31BMTIh3os6fhmG/g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-AjjBu1DQPiy4ex6QeuTqJg-1; Mon, 11 May 2026 18:09:47 -0400
X-MC-Unique: AjjBu1DQPiy4ex6QeuTqJg-1
X-Mimecast-MFC-AGG-ID: AjjBu1DQPiy4ex6QeuTqJg_1778537386
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-44a122a5128so3662207f8f.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 15:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778537386; x=1779142186; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8lfM790bPPcW9+6QJ2OF4Giuvz/HJzNJe7b9mqE9Dco=;
 b=FMcJjA1ZGC5bED3Izb+H5PE8Etjpg8UYILcfPVyMDQxrUyKZHfYd/U9PruDQrsL/Xy
 uLDh6yngYKiigGbFKyXXEjIruZeAcZr9ZC5mbdZ0ZQr/WRmWYT4HsuCyotTG/TFqso0q
 AsYp79uVLtudP50hxdnk1lyTATzyWjFVhTQnlETFZ/vd6v0cZMx3ImRPlbszhvtAxHXD
 kkBO2TkyYk2Tunv4RnflbTWP9q0vm2RXAzWxtzJcbLI1iCPrnQS/wPQp7jCOUv3N0DAs
 DlQJmPSAUK2WGoIwSO1KH0eR/wEHbsZrYfzBdeZ9GN6xCGfvobFzEG2kyicjINT2oM0n
 Tfeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778537386; x=1779142186;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8lfM790bPPcW9+6QJ2OF4Giuvz/HJzNJe7b9mqE9Dco=;
 b=Hf8aflyaq7qH3ztb+k9hSrVnHODTy6FAknpspB1hQqC87UClt22JbTT46bKIIX98Vh
 IzvgWwmroZMZfIjlccoZkVaawOMPiWdt3xDc77rxpLrJDARR0Fjtdj7r55WEbniHsBBG
 9ifPqYRdx6eRVCciuZMKSAPHkOx8s+u40EjvHKKlyM86y+lpxmWxcDPUFeKwTBcZnJ40
 H+q0ZLMjwm9xOW3bwaoPugJnfhfP4UOyYxQL7HJhkBMFn45INiKpvqcpongZxKeMTwPW
 Nw29GRh9h6x6DWdpXXB83cFAtAwovfnt10z50nC/1xHyJL/kyiylvSh18oMjuu2/kMlk
 nlKQ==
X-Gm-Message-State: AOJu0Ywk8Zz77vixVxQiSOFVPnx/r0+/7LcR2oWlePnw47ROcWxxiewY
 cRM8J5jwy+5/S+NlMY2R0D+R64wBetxyOjYrfoIXaa+M/ne6hCKquh4sfPMrMqQv/yZAT2H2MNL
 PVVaduZ3vAXO/7au69stk3tDX8O8bveXzdeKg2k86+VOnPRND05Mbhor1
X-Gm-Gg: Acq92OGBNrc01Q2zGQxangmlJwzODUrkFgF1LwwQQXB99RuGxPAg8litj2vC94hd4oE
 A5BC/KWj+AJpWwrnVFYI/EvKjk9Y4m57QnAkaBg3jpFrclb+FdkBuXSzThca08j5gIl+s8j4txh
 oyg6vUq0GBvdX5+dzn+vGaX+XxMT9pVtwNErYJc5Zf7hp26gLEE6nD+7X/psbLY1WvCylPwuuBN
 BGA2BzByAtw5hoxq1FYC31UPnoVH9TML28agrMU0L78L2brbReqh+jM8OH/FE0gemHoq1R5X8xn
 0TbZ9aEclnF1JMzOF2v2e0L8V/OEHj7JToO9yT3Alew8tsBJ/aG8Vy8sQ+uZ28L+5OBrbxGWJRI
 B+jz6N9E9gk2AFKB28goFnpm3ZfkEqwm2E+Hfu90+
X-Received: by 2002:a05:6000:25c2:b0:448:659b:abec with SMTP id
 ffacd0b85a97d-45460e3f5f9mr23691015f8f.8.1778537385874; 
 Mon, 11 May 2026 15:09:45 -0700 (PDT)
X-Received: by 2002:a05:6000:25c2:b0:448:659b:abec with SMTP id
 ffacd0b85a97d-45460e3f5f9mr23690981f8f.8.1778537385429; 
 Mon, 11 May 2026 15:09:45 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548ec6b071sm27715403f8f.14.2026.05.11.15.09.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 15:09:45 -0700 (PDT)
Date: Mon, 11 May 2026 18:09:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tushar Dave <tdave@nvidia.com>
Cc: qemu-devel@nongnu.org, alwilliamson@nvidia.com, jgg@nvidia.com,
 skolothumtho@nvidia.com, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, marcel.apfelbaum@gmail.com, devel@edk2.groups.io
Subject: Re: [RFC PATCH 0/8] hw/arm/virt, hw/pci: PCI pre-enumeration and
 fixed BAR allocation
Message-ID: <20260511180533-mutt-send-email-mst@kernel.org>
References: <20260508183717.193630-1-tdave@nvidia.com>
 <20260511050459-mutt-send-email-mst@kernel.org>
 <d5190676-11e7-40e8-ab12-da69aa751301@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5190676-11e7-40e8-ab12-da69aa751301@nvidia.com>
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

On Mon, May 11, 2026 at 01:10:43PM -0500, Tushar Dave wrote:
> 
> 
> On 5/11/2026 4:09 AM, Michael S. Tsirkin wrote:
> > On Fri, May 08, 2026 at 01:37:09PM -0500, Tushar Dave wrote:
> >> This RFC introduces a mechanism to specify Guest Physical Addresses
> >> (GPAs) for PCI BARs, allowing explicit placement of guest MMIO BAR
> >> addresses to match host physical addresses for assigned devices.
> >>
> >> On some platforms, P2P DMA is performed between devices within the same
> >> IOMMU group. The PCI fabric ACS is configured to permit direct P2P
> >> without going through the host bridge in order to achieve the required
> >> performance.
> > 
> > Pass this info to guest firmware, let it set bars any way it wants?
> 
> We are using firmware, relying on the existing EDK2-supported mode
> enabled by PcdPciDisableBusEnumeration, where firmware is expected
> to preserve the PCI topology and BAR programming established by
> the hypervisor.
> 
> In our case, the hypervisor is QEMU, which performs PCI enumeration
> and resource assignment before handing control to firmware. EDK2
> then explicitly refrains from re-enumerating or reallocating PCI
> BARs, as this is already a supported firmware behavior.
> 
> -Tushar


I see no advantage in performing pci enumeration in qemu when firmware
is already doing an adequate job of it. If you want firmware to map
specific devices at specific addresses, pass that info along to it.

-- 
MST


