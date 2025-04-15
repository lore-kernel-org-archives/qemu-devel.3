Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C6E8C369B4
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 14:04:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4gt0-00068i-Vs; Tue, 15 Apr 2025 10:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u4gsv-00067J-Sc
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 10:03:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u4gss-000304-VU
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 10:03:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744725807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IK4C7EbbVFDYNUwmjqs9MIeyoQHLlv3c5rFMg4MdztI=;
 b=L3OHI83v+ydfgsIABcQ8eN4jRpoaV1W1MrL/+FJ1ow6oTwfOtYM7AEB6bcdWiZHZWDM3KI
 ytFjEGwzlWlTn0sTjqUfod6Dn5gIZN4sLSiu23iMw3JUqlK3IfPiRhTu0joS8D8lRN16XG
 AgWDzzHtcXbEIVh9ZJn+l2RDsvt1LM8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-nRWcQPJFNWef5aNLDT1AYQ-1; Tue, 15 Apr 2025 10:03:21 -0400
X-MC-Unique: nRWcQPJFNWef5aNLDT1AYQ-1
X-Mimecast-MFC-AGG-ID: nRWcQPJFNWef5aNLDT1AYQ_1744725801
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-39d917b1455so2302289f8f.3
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 07:03:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744725800; x=1745330600;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IK4C7EbbVFDYNUwmjqs9MIeyoQHLlv3c5rFMg4MdztI=;
 b=rmobWXz5CkPiT9c97ZQrv0qH8ZwReAmoIsIv2GlY/+ePnKRVtlOXn7Dpm0uO5CyBS/
 aTnZSVeQb9kVgYuSQv2CfvzVQsrDztcU2cIrYX1BP3OcwJiJ+htR2QbiOCgbwYz7jNsq
 C/5Z0fdbItELT0c0YBfxCAUpA3kV/UToJTTsylWHbA1E3XIYQWN0lhku/CoxLOKFvsfb
 UsPur5rv96Y+xHpc6yCDIy6sLzXZbnuDAUBPPK4MCt59+WtgPasE3IYvr/Q6ugK7/aWV
 yHCfDx4peApkvIiXMpI8zXZkD7+sEIW4NmLe3SO0QAEd4kJIou9VRKzM/XIGvqfB458K
 Uf4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUY2e9VO1FWqPjN8PJN34ttLrKqwxb3IaIskjQk5Ved4izYQ1O0fDYCCf+KrxbK4xfTlaxHaXhGTPi6@nongnu.org
X-Gm-Message-State: AOJu0YzPXzFk1FOkvFFcHRcWUoIOGkb4AqrTBazwEs+eiGjPMZBp9Ugz
 mzvNpTSBlqyhuitGb4fQF7rsfJwKBc2Tl/lLKY7xpXAUFwGIqYaT48SO4knGl3Xum5hgAYIfqoj
 ZSSBCRLF8p7TKFZi9BtAQ/mC+T/Lh22qmAoryBFsUjtA3o8axbcUu
X-Gm-Gg: ASbGncuvOj0zvUw8FfikuDdx8WMPCA7dDE6VjIPnFUAm22sy3utgA3mVKVXip1wWS/R
 FzpdIHyW9k3Vpw3yYxhkm0ZfF0xf0tvPOMvaqGLBAPMxKvhqwHg4lFqqC5M1gOLFi20ZqR1UAft
 Vxah0uBUO1AALJZ7O7rRtTSPEe/q9lfCD4iX0FnPbVzyeEouD38nHx8yi0WWokVn2d3W4h3POSI
 7lmUb6Kyol+zMRQFzx9EfBJZLz5JlstZmBHJ4hi53UApuVcZp4k8JlgNIkGV2JDHpWboxiwoYZ+
 ljevpg==
X-Received: by 2002:a05:6000:381:b0:39c:27cc:7ba3 with SMTP id
 ffacd0b85a97d-39eaaea6238mr13657668f8f.33.1744725800089; 
 Tue, 15 Apr 2025 07:03:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH642L81S6AtyzDN0eKTyprfitvV6ugGj/y5e/YRObn2Oxa+E52oU8Rwqpg7xujPtivsppknw==
X-Received: by 2002:a05:6000:381:b0:39c:27cc:7ba3 with SMTP id
 ffacd0b85a97d-39eaaea6238mr13657352f8f.33.1744725797235; 
 Tue, 15 Apr 2025 07:03:17 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf44561dsm14783926f8f.92.2025.04.15.07.03.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 07:03:16 -0700 (PDT)
Date: Tue, 15 Apr 2025 10:03:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "peterx@redhat.com" <peterx@redhat.com>
Subject: Re: [PATCH] intel_iommu: Take the bql before registering a new
 address space
Message-ID: <20250415100250-mutt-send-email-mst@kernel.org>
References: <20250415061353.185589-1-clement.mathieu--drif@eviden.com>
 <20250415030653-mutt-send-email-mst@kernel.org>
 <20250415123330.GB270228@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415123330.GB270228@fedora>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Apr 15, 2025 at 08:33:30AM -0400, Stefan Hajnoczi wrote:
> On Tue, Apr 15, 2025 at 03:11:00AM -0400, Michael S. Tsirkin wrote:
> > On Tue, Apr 15, 2025 at 06:18:08AM +0000, CLEMENT MATHIEU--DRIF wrote:
> > > Address space creation might end up being called without holding the
> > > bql as it is exposed through the IOMMU ops.
> > > 
> > > Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
> > 
> > 
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > Stefan, want to pick this one up, too?
> 
> Not yet, it may need to wait until after the release:
> - Discussion is still ongoing.
> - Is this a regression in 10.0 or a long-standing issue?
> - Who is affected and what is the impact?

Yea agreed.

> There are still a few hours left before -rc4 is tagged. I will merge it
> if consensus is reached and the missing information becomes clear.
> 
> Thanks,
> Stefan
> 
> > 
> > 
> > > ---
> > >  hw/i386/intel_iommu.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > > 
> > > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > > index dffd7ee885..fea2220013 100644
> > > --- a/hw/i386/intel_iommu.c
> > > +++ b/hw/i386/intel_iommu.c
> > > @@ -4216,6 +4216,7 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
> > >      vtd_dev_as = g_hash_table_lookup(s->vtd_address_spaces, &key);
> > >      if (!vtd_dev_as) {
> > >          struct vtd_as_key *new_key = g_malloc(sizeof(*new_key));
> > > +        bool take_bql = !bql_locked();
> > >  
> > >          new_key->bus = bus;
> > >          new_key->devfn = devfn;
> > > @@ -4238,6 +4239,11 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
> > >          vtd_dev_as->context_cache_entry.context_cache_gen = 0;
> > >          vtd_dev_as->iova_tree = iova_tree_new();
> > >  
> > > +        /* Some functions in this branch require the bql, make sure we own it */
> > > +        if (take_bql) {
> > > +            bql_lock();
> > > +        }
> > > +
> > >          memory_region_init(&vtd_dev_as->root, OBJECT(s), name, UINT64_MAX);
> > >          address_space_init(&vtd_dev_as->as, &vtd_dev_as->root, "vtd-root");
> > >  
> > > @@ -4305,6 +4311,10 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
> > >  
> > >          vtd_switch_address_space(vtd_dev_as);
> > >  
> > > +        if (take_bql) {
> > > +            bql_unlock();
> > > +        }
> > > +
> > >          g_hash_table_insert(s->vtd_address_spaces, new_key, vtd_dev_as);
> > >      }
> > >      return vtd_dev_as;
> > > -- 
> > > 2.49.0
> > 



