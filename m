Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18EABC52D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 17:20:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1see8W-0006AL-F3; Thu, 15 Aug 2024 13:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@ziepe.ca>) id 1see8U-00068m-9E
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 13:19:42 -0400
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jgg@ziepe.ca>) id 1see8R-0006oj-AV
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 13:19:42 -0400
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7a1d6f4714bso112301385a.1
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 10:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1723742377; x=1724347177; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BqaSFAda1BULnUkvbkqjvUbbEFCCq1QGyMDyl6SYwo8=;
 b=H4delLrSPKQFCtSP5jYPFxTjg7yhSJk97/UaEotEd34tZgkk4gw8W6MyO18fzM+pVm
 ZOg4vGiHs/C0W3QvdlhiyFglhLdp0ZDX3rWTwmMlAddfPetCXNhNuq2E4X8cAm18ptm5
 eFsgX1A1z4gX8pin0HpppNTseU6pREUIcDar4DZloTKA8XxxWvxGhRFw7YMVOcF2y5o+
 RqPcy997Nl/5It0JavW/sZ62UpFAxR1yU9pug9/FkZ/sYsHx/erl0+uZLe7JHTyccEq/
 cLMieDGJsYYiPoMFk9HtPaSxq0eRAR5EkkoGVefiMmObum7dpPc37dl4CnZxY/jhrNhy
 sRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723742377; x=1724347177;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BqaSFAda1BULnUkvbkqjvUbbEFCCq1QGyMDyl6SYwo8=;
 b=mcGNQNLSbxoHlTbzxTVNQFp38U8rzRqM5WmF9x7fboNjxZOVhfSnjzHiiCuxFs78WG
 5GYB8T8lLZ/qtMHUykxOlORNTkWUWXdwKK+GWtiKgSgbIKNLZ3DHPfBYhYxdTA+MdMnj
 JsoWzC/prOLo2JP/4px8qetgKU1HIF5V2YXBHuZ7zzDUZkmxAyrtAxsRFasIDSFZOxJs
 2DWoDGcMqtTk9/cTKo6HzUt+YIgnjZA5uGwNKEn2b3TxbIJMdUG+GyK9fB64XY1RHxl/
 lsQyo5oNKfAy+PjjLSLVv3BtlfidG+n65VkrvUYie+TRiziu7jpZrChaUDPQ/cAq5SeV
 dPgw==
X-Gm-Message-State: AOJu0YwVBP8ulaq0VbuS6vLU+54ViDcAJ/BNf8uBxqamZhuiuaAlR0xO
 6VPYvqjPWEC01TCoAxgFWNE46ptm80ut3zmzmdC/P5x7CPzk2nCpFqtm61NiQoQ=
X-Google-Smtp-Source: AGHT+IGEGC1/A/48dBre5gaeZ0zHau3OBx975u/klzSPGEReClcShxi3bAXTedaOfHOOcJfdHkXOVA==
X-Received: by 2002:a05:620a:294c:b0:79e:f745:5445 with SMTP id
 af79cd13be357-7a506ff0efbmr18473085a.31.1723742377586; 
 Thu, 15 Aug 2024 10:19:37 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a4ff0dcac4sm80966585a.84.2024.08.15.10.19.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 10:19:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
 (envelope-from <jgg@ziepe.ca>) id 1see8N-004EaT-MX;
 Thu, 15 Aug 2024 14:19:35 -0300
Date: Thu, 15 Aug 2024 14:19:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, quic_bqiang@quicinc.com,
 kvalo@kernel.org, prestwoj@gmail.com,
 linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
 dwmw2@infradead.org, iommu@lists.linux.dev, kernel@quicinc.com,
 johannes@sipsolutions.net, jtornosm@redhat.com
Subject: Re: [PATCH RFC/RFT] vfio/pci-quirks: Quirk for ath wireless
Message-ID: <20240815171935.GO3468552@ziepe.ca>
References: <adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com>
 <20240812170045.1584000-1-alex.williamson@redhat.com>
 <20240813164341.GL1985367@ziepe.ca>
 <20240813150320.73df43d7.alex.williamson@redhat.com>
 <20240813233724.GS1985367@ziepe.ca>
 <20240815105905.19d69576.alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815105905.19d69576.alex.williamson@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::72a; envelope-from=jgg@ziepe.ca;
 helo=mail-qk1-x72a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Aug 15, 2024 at 10:59:05AM -0600, Alex Williamson wrote:

> > This is probably the only way to approach this, trap and emulate the
> > places in the device that program additional interrupt sources and do
> > a full MSI-like flow to set them up in the kernel.
> 
> Your last sentence here seems to agree with this approach, but
> everything else suggests disapproval, so I don't know where you're
> going here.

Trapping and emulating is fine.

My concern is really only about skipping SET_IRQ.

That works because of the assumption that the IMS sources are going to
re-use addr/data pairs setup in the MSI CAP.

That assumption is frail, and won't work at all under the proper IMS
support Linux now has.

I really don't want to go down the road and have someone tell Thomas
he can't convert the Linux driver to use irq_domain IMS because it
will break this stuff here.

> I have no specs for this device, nor any involvement from the device
> vendor, so the idea of creating a vfio-pci variant driver to setup an
> irq_domain and augment a device specific SET_IRQs ioctls not only sounds
> tremendously more complicated (host and VMM), it's simply not possible
> with the knowledge we have at hand.  

It seems like you have reverse engineered alot of the necessary
information though??

Maybe there is a more generic approach than a variant driver. If you
wanted to use IMS from userspace generically you could imagine some
kind of IMS focused "SET_IRQ" in generic VFIO. Where we'd create the
needed irq_domains and pass the addr/data pair back to userspace?

> I observe that the device configures MSI vectors and then writes that
> same vector address/data elsewhere into the device.  Whether the device
> can trigger those vectors based only on the MSI capability programming
> and a secondary source piggybacks on those vectors or if this is just a
> hack by Qualcomm to use an MSI capability to acquire some vectors which
> are exclusively used by the secondary hardware, I have no idea.

Well at least that should be testable - but it seems crazy if the
device has registers for an addr/data pair and then somehow doesn't
use the values that get put in them??

Copying from the MSI is almost certainly a SW hack because IMS support
has never really existed in an OS until now. I think your guess for
why it is like this is pretty good.

> I do not believe that introducing a vfio device feature that disables
> virtualization of the MSI address/data _only_ at the vfio interface
> (not to a QEMU VM) provides some implicit support of this device
> behavior.  These values are already available to a privileged user in
> the host and the same is available for an MSI-X use case by directly
> reading the MSI-X vector table.  

To be clear, I'm not really worried about showing the data to
userspace.

Userspace just shouldn't be using it to implement an IMS technique!

Jason

