Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C0CE9128B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 08:16:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnuXL-0003oi-5T; Thu, 05 Feb 2026 03:16:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vnuXI-0003np-VV
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 03:16:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vnuXH-0003yZ-4l
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 03:16:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770279382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WHIZET8X/6ciVZP7QbD2OHfADqDoA3kbCcvEcXCKcO0=;
 b=PpQZXWM0QRYZKVdCOTlV1Hu6HjopRdODgftsAOFKGIpiC0nYAkR+ywDOp8GGU/YH40I2al
 /N4j2BaOJhaf8GlpSqKX0RC1Dkb1Dp3NmSwwkBeFHTu3GS42kiK8fS3f61qILioT/YGjwf
 nUinIJEWlKZi0p0/Sk16Vm8bNcBx5f4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-ZsWgPI5iOpaFvjmIKNmfeA-1; Thu, 05 Feb 2026 03:16:20 -0500
X-MC-Unique: ZsWgPI5iOpaFvjmIKNmfeA-1
X-Mimecast-MFC-AGG-ID: ZsWgPI5iOpaFvjmIKNmfeA_1770279380
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-430fcb6b2ebso581215f8f.2
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 00:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770279379; x=1770884179; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WHIZET8X/6ciVZP7QbD2OHfADqDoA3kbCcvEcXCKcO0=;
 b=L0ek5gKj0OrRy1a2ZNctw8KsiOXUN/F68Fonkgw61T2Z4kVn85+Zd+WB/wdfHdiDON
 bvq8//TXcCfljtSQfM5A3jHYv0J6goYF1aaE1zpKoP7eJWrKodJAgaJSuKnC2PxACji+
 /r07aK41IEzVuFWtKIUnFTSfprsiJpmpj7wC1g6IXDktBvNHZVsZM79vjd7doEomnBs1
 wenKvmitUFbCfHiO3AHx6EJxKq35FFK+A0Mi7sbEv0xqwApW/gyxR+MbZUkTwnqd2Oh6
 CRrf3e2C8RDtn1ISvcrbuY6ph4wsWdx2nBQp9Ed0ZcpjGoxnnB1PziADE76ABBsDFA1E
 o5hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770279379; x=1770884179;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WHIZET8X/6ciVZP7QbD2OHfADqDoA3kbCcvEcXCKcO0=;
 b=cvFm+zGKHwOcOk+r6IUGypeV5KZJDkrbj8mf3e45fnCN7DGm4B4wRWn4Re08UxLyNm
 iCye0DsP9FKaWDy73nN1Lg5+gEBwNgEjG0Or1eMlC9U4W/QU3P58wnVDN5S0cV84pUsd
 1Na9Md4+LFrBJK9osUjkw+g9SNDs6kt+vZShNu0PJqaA3PjzCv4wkwIDR3NjpSfCdmKY
 F1lVqZC83oKQnRijG992GX58SoahHYl8WBGSFPZQT6V1dTCoI7INXYS0LlXAg/IlSfCt
 34nUWB9YZzkHAMX5HjN++h3gGTIZbdsjiCImjSBo1KznaxkbaJ3GPfL3PtP3rcWZVpbj
 sqkQ==
X-Gm-Message-State: AOJu0YwpCP+VcMsyvlkIOJbe5eB+nAt4ETdlR4juPSA0qwBIuHmvX63j
 /eLtyQez43veAMNyU8V7cPG+oQOm/8hkuTPqxMp56v7OtgDHSnIzkjIg6tb4eVQNEgZml9JBy/h
 rSbJJVSEsOx6ZjhcA9bMBIuCaWaHQyyNiAb8Ju+2/X+FvxUc4csJYyxO6NN+2L9aE
X-Gm-Gg: AZuq6aKxOaIEdeT3B0BxQzkiwZ6olRfjJlEmTDWBwB5smL7slEGmrc0mhxG1jD9unFD
 ksF3IRAF0dNduXOEvJeMuKRWzl+19uelO2lPAQyFjfd4EKMOPO+T3zST6XCcjjoBOi/cEy1kXUA
 AmkcntwCcNV4fl/7rbIYUKQaccIRQa/5QdqoOflrVGmLIjMFHESUFadwOy1zpNSwzQLIj6MyJ4F
 6OOTmymGVRVIIh+OtB/+mVO+s8WdFuBh/Uwsn20AyJipWaVq+IePxoNEPm/Ob7rl3S6fCxJZb0L
 kiZTLMHUAxNuy7uOzkfP4SelPXV7fPhgWN7tsDvDfqI/58lz10qpRbkqtLNZlEmB2h69QrUJkOT
 aAU/zwPLM7Ox40o8GkRRvEFW7yQJu3NwIrw==
X-Received: by 2002:a05:6000:1888:b0:435:9690:f056 with SMTP id
 ffacd0b85a97d-4361805284fmr7987355f8f.35.1770279379274; 
 Thu, 05 Feb 2026 00:16:19 -0800 (PST)
X-Received: by 2002:a05:6000:1888:b0:435:9690:f056 with SMTP id
 ffacd0b85a97d-4361805284fmr7987302f8f.35.1770279378712; 
 Thu, 05 Feb 2026 00:16:18 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43617e387b9sm13140397f8f.12.2026.02.05.00.16.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 00:16:18 -0800 (PST)
Date: Thu, 5 Feb 2026 03:16:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Jonathan Cameron via <qemu-devel@nongnu.org>, linuxarm@huawei.com,
 shiju.jose@huawei.com, Davidlohr Bueso <dave@stgolabs.net>,
 armbru@redhat.com, Fan Ni <fan.ni@samsung.com>,
 linux-cxl@vger.kernel.org, Ravi Shankar <venkataravis@micron.com>
Subject: Re: [PATCH qemu for 10.2 0/3] cxl: Additional RAS features support.
Message-ID: <20260205031548-mutt-send-email-mst@kernel.org>
References: <20250917143330.294698-1-Jonathan.Cameron@huawei.com>
 <20251006101304.000055f8@huawei.com>
 <20251006062628-mutt-send-email-mst@kernel.org>
 <20260102152834.00003869@huawei.com>
 <20260204113526.00001040@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204113526.00001040@huawei.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Feb 04, 2026 at 11:35:44AM +0000, Jonathan Cameron wrote:
> On Fri, 2 Jan 2026 15:28:34 +0000
> Jonathan Cameron via <qemu-devel@nongnu.org> wrote:
> 
> > On Mon, 6 Oct 2025 06:26:53 -0400
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > 
> > > On Mon, Oct 06, 2025 at 10:13:04AM +0100, Jonathan Cameron wrote:  
> > > > On Wed, 17 Sep 2025 15:33:27 +0100
> > > > Jonathan Cameron via <qemu-devel@nongnu.org> wrote:
> > > >     
> > > > > These two features have been used in testing the related EDAC RAS
> > > > > features drivers in Linux which are now upstream. Only minor tweaks
> > > > > from the second part of:
> > > > > https://lore.kernel.org/qemu-devel/20250811085530.2263-1-shiju.jose@huawei.com/
> > > > > [PATCH v6 0/8] hw/cxl: Update CXL events to rev3.2 and add maintenance support for memory repair features
> > > > > 
> > > > > I've split that series up as the two parts were only slightly connected.
> > > > > However there is some churn if this is applied without the other part of Shiju's posted
> > > > > series. That was sent a few minutes ago as:
> > > > > https://lore.kernel.org/qemu-devel/20250917141355.293217-1-Jonathan.Cameron@huawei.com/
> > > > > 
> > > > > Based on: [PATCH qemu for 10.2 0/5] cxl: r3.2 specification events updates.
> > > > > Based on: 20250917141355.293217-1-Jonathan.Cameron@huawei.com
> > > > > 
> > > > > Davidlohr Bueso (1):
> > > > >   hw/cxl: Add support for Maintenance command and Post Package Repair
> > > > >     (PPR)
> > > > >     
> > > > Hi Michael,
> > > > 
> > > > I see you have queued some stuff up on your gitlab tree.
> > > > Just wanted to make sure these are on the radar for possible inclusion.
> > > > No huge rush, but I'll queue some more series up on top of these
> > > > shortly.
> > > > 
> > > > Thanks
> > > > 
> > > > Jonathan    
> > > 
> > > thanks for the reminder, will queue.  
> > Hi Michael,
> > 
> > Looks like you didn't do another pull request for 10.2. If these can
> > go upstream fairly early in 11.0 that would be very helpful as we have
> > quite a few CXL series that I think are (nearly) ready.
> > 
> > I resent the events series but that was mainly because I'd forgotten you'd
> > replied to this one and so might already have both queued. Sorry about that
> > if you have them both already.
> 
> This is the second series that is (I think) ready for merge.
> Applies cleanly on mainline + 
> [PATCH qemu v4 0/5] cxl: r3.2 specification event updates.
> 20260119111542.788389-1-Jonathan.Cameron@huawei.com

question is if there will be v5 of that one, now there
are review comments?

> > 
> > Jonathan
> > 
> > >   
> > > > > Shiju Jose (2):
> > > > >   hw/cxl/cxl-mailbox-utils: Move declaration of scrub and ECS feature
> > > > >     attributes in cmd_features_set_feature()
> > > > >   hw/cxl: Add emulation for memory sparing control feature
> > > > > 
> > > > >  include/hw/cxl/cxl_device.h | 145 +++++++++
> > > > >  include/hw/cxl/cxl_events.h |  47 +++
> > > > >  hw/cxl/cxl-mailbox-utils.c  | 566 +++++++++++++++++++++++++++++++++++-
> > > > >  hw/mem/cxl_type3.c          | 169 +++++++++++
> > > > >  4 files changed, 915 insertions(+), 12 deletions(-)
> > > > >     
> > > 
> > >   
> > 
> > 


