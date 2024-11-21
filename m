Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B7B1D78794
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 16:43:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEAGo-0006vd-Sm; Thu, 21 Nov 2024 11:43:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tEAGn-0006vO-Hb
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 11:43:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tEAGl-0005w3-Rr
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 11:43:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732207381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dv36qoeqxPhd6wIqbpElv9enMMoOPXylOkpsQCa/aEI=;
 b=bTlD23QamKSKRQ1X162bxKb0ZprHbHxC/YTzx1y0a3sZGkc/4yRg+jkYuLpO9w1P5jSMqW
 jo5ihtgIuo/6p7TzZWxaqVeuRonEwfVC04eaqBDZE6DlhIgdEvj42bIQ0WuU+t1fun6+dJ
 OOB7MWVsH2biEn4SXXeyUWHU5Vx6C8A=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-DDAz1hFDPVqWRj28fwDJIA-1; Thu, 21 Nov 2024 11:41:22 -0500
X-MC-Unique: DDAz1hFDPVqWRj28fwDJIA-1
X-Mimecast-MFC-AGG-ID: DDAz1hFDPVqWRj28fwDJIA
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7b15659b098so122304385a.3
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 08:41:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732207281; x=1732812081;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dv36qoeqxPhd6wIqbpElv9enMMoOPXylOkpsQCa/aEI=;
 b=oDT5GfghhffozS0+wLc1i3foVmt8aAyOnr7RlgAvaSkvo9JBsiPMw5Lq50gP8XJw2r
 ziDYgkNwIZ27vqNbFSS15Yq2vF6pTe4uRTLjjr8aYs6QQ/06w7BIA+SlEh/1n1/7dpKc
 ge/mfCb2pEgBzVQTfFI3u0iAl4oAXyJt1LWZnGr9NHsqD+ZgNZe7B91g3fumlIgEZUJ3
 PZUpARwiPu4JPcXAuI4O/ZHNMu0gu5b/T8e61UM1wu026ZFYZU/Exks/+55vjuOgXTa4
 xfIvmSjJFD/S6JetjbWH6H2DIcKrdZWrBZBg45PMeyCkfCcXy/nP1RCypQoVb9DrYJ0d
 Uaqw==
X-Gm-Message-State: AOJu0YyqUGRDAKrxurk9w9adfhSnjERvbc1ypwXEoGGUkJJqd9R+yZZL
 VfuxUHsKx4oZFYW8zfs0DRD2RdWKim2F84fQh9uOQhfdNWEahvf/PLiQjGBrbNnzXSTOIkmHO1n
 UOUurYjC0NXIUAJntKvBVOyGBaFKemg7Gu/6eRDIYl8Ad18RQOlLxK0f29XVr
X-Gm-Gg: ASbGncvMQNFX2ohykF5g9280dSmE29xDZ+ZvEBWm8kFG19mTYF7aWTN4ryZnmY+5rrz
 CRwgPwfdWGEQMPYFiymsq4NdKfWFUxQXFEYKfReigLX49rZw7TRdVSSR1cudxiIi4xEmh8CC0x+
 32x/3S/FiBE+NXg6C5SBm5tIxEFDgMTAqE++AyzmnzmqGVBx0SKvxlzUprsBHYFuc0DpA1nEmNN
 RJ1UGZBEZS403+CTjLDHYufXmC3mdB9vc6FothF7GUZg5BNVp2JTt324I22oiZywszw6Iw9ED+F
 J/iOFEBKjAA=
X-Received: by 2002:a05:620a:4710:b0:7a9:a1b5:26f5 with SMTP id
 af79cd13be357-7b42ee1b816mr909902185a.26.1732207281507; 
 Thu, 21 Nov 2024 08:41:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzGHA5XTlYfl97NVEBt6+bHJAQEDg+uzo/RBaJ7IV7X+2IcAbG6E/sSW3w5/Z/fJiWy/ibDQ==
X-Received: by 2002:a05:620a:4710:b0:7a9:a1b5:26f5 with SMTP id
 af79cd13be357-7b42ee1b816mr909898885a.26.1732207281184; 
 Thu, 21 Nov 2024 08:41:21 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b485251000sm228174785a.126.2024.11.21.08.41.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 08:41:20 -0800 (PST)
Date: Thu, 21 Nov 2024 11:41:18 -0500
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Bharat Bhushan <r65777@freescale.com>, qemu-ppc@nongnu.org
Subject: Re: [PATCH 07/12] ppc/e500: Avoid abuse of container_get()
Message-ID: <Zz9irqNkWX3BSDqG@x1n>
References: <20241120215703.3918445-1-peterx@redhat.com>
 <20241120215703.3918445-8-peterx@redhat.com>
 <2c63bf58-108a-4785-ad7e-c7e6446970e4@redhat.com>
 <9e206447-86e6-4251-8e3b-b764b4bf6480@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e206447-86e6-4251-8e3b-b764b4bf6480@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Nov 21, 2024 at 10:48:43AM +0100, Cédric Le Goater wrote:
> On 11/21/24 10:38, Cédric Le Goater wrote:
> > On 11/20/24 22:56, Peter Xu wrote:
> > > container_get() is going to become strict on not allowing to return a
> > > non-container.
> > > 
> > > Switch the e500 user to use object_resolve_path_component() explicitly.
> > > 
> > > Cc: Bharat Bhushan <r65777@freescale.com>
> > > Cc: qemu-ppc@nongnu.org
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >   hw/pci-host/ppce500.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
> > > index b70631045a..65233b9e3f 100644
> > > --- a/hw/pci-host/ppce500.c
> > > +++ b/hw/pci-host/ppce500.c
> > > @@ -418,8 +418,8 @@ static const VMStateDescription vmstate_ppce500_pci = {
> > >   static void e500_pcihost_bridge_realize(PCIDevice *d, Error **errp)
> > >   {
> > >       PPCE500PCIBridgeState *b = PPC_E500_PCI_BRIDGE(d);
> > > -    PPCE500CCSRState *ccsr = CCSR(container_get(qdev_get_machine(),
> > > -                                  "/e500-ccsr"));
> > > +    PPCE500CCSRState *ccsr = CCSR(
> > > +        object_resolve_path_component(qdev_get_machine(), "e500-ccsr"));
> > 
> > 
> > why not simply use :
> > 
> >        CCSR(object_resolve_path("/machine/e500-ccsr", NULL));
> 
> 
> I guess we want to avoid the absolute paths. If so,

It wasn't my intention, but what you said actually makes sense to me to
avoid hard-coded "/machine" if possible.

OTOH, object_resolve_path_component() was actually tiny little faster when
we know the depth of the path.

> 
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> 
> 
> We might want to convert these lookups to object_resolve_path_component
> too, not in this patchset.
> 
> hw/i386/acpi-build.c:    host = PCI_HOST_BRIDGE(object_resolve_path("/machine/i440fx", NULL));
> hw/i386/acpi-build.c:        host = PCI_HOST_BRIDGE(object_resolve_path("/machine/q35", NULL));
> target/i386/kvm/kvm.c:        (MemoryRegion *) object_resolve_path("/machine/smram", NULL);
> target/i386/tcg/sysemu/tcg-cpu.c:        (MemoryRegion *) object_resolve_path("/machine/smram", NULL);

Sounds reasonable to me to use the same style.  I'll stick with this patch
as of now in the current series.

Thanks,

-- 
Peter Xu


