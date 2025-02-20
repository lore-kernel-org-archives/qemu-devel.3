Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93749C021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 23:28:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlFwr-0003WF-6v; Thu, 20 Feb 2025 18:27:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlFwp-0003Vy-7O
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 18:27:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlFwn-0003Ka-MG
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 18:27:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740094032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M7BDEihOU8FRiUC7TBy1S3eRxjWFXsCgJLxxpeWivb8=;
 b=Hn0MAZ5Y8HWOjoC2/s8rPnxhcPAVxdc+0UAI4FAw4qMuMvKcevsvUIfoSp9jZ/JAeGKsCl
 oEvPXFbH+E8lOd7QcRSl2zZBuvw4aHO0mqyi29gqz8ZykTpVePEkq438FWG4Xu7f22ebMj
 yAL8tPl8IwK+sldHn4+kr2OnjGvR2tE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-iPmdBwwWPlK3LexUbpSX6A-1; Thu, 20 Feb 2025 18:27:11 -0500
X-MC-Unique: iPmdBwwWPlK3LexUbpSX6A-1
X-Mimecast-MFC-AGG-ID: iPmdBwwWPlK3LexUbpSX6A_1740094030
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-abb8f65af3dso140772266b.1
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 15:27:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740094030; x=1740698830;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M7BDEihOU8FRiUC7TBy1S3eRxjWFXsCgJLxxpeWivb8=;
 b=swi2xo9basXRnuEXwed2eyyc7JgQ2hzdN52+Z1tMRH83qKGpq5Slk7Hz7MANnB9hGj
 yzUHW4alfFQsEqiaXJqA/vTS+evQ2E0cnDMcPQj3NU+flKokHMw5iqGvZDx9pm8BDH+J
 XiBGYQ7JhBwTFhXVBt0LJV6gHbho969nv/5JPODjmb90zqqXpI7sF2AY02fdTGIg981J
 fYyt7909vPRasaa/AFD2uEV2SVrVh1Gf/QGzLh0DkL6Fin/Y1PeNsI8cZAJOiKapD5dt
 6zQsYEsZdggtWe8VyLRfLBzHMsVy+fShAujZYca/8gi6aVuFBF481ZVX9MxdTZ7JTAjM
 2eHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQGwd0bvTK+SssawYcneYbMUfjnHY1dEWqJTc3KTrvV2jK5/21h3inqs3IkZuxRD8Bu/WoXlddnq1+@nongnu.org
X-Gm-Message-State: AOJu0YxEn12VeNgb9DKU1L3IbEDjKhkvMr36iFTf1AzO9mpIyEqdnpAC
 B8ABYkvRj291XCfmpLolUd1oeLWpyVDmHiTpWgd17xFM6XqxXVy9VGTrGfx2gwjfFjwgtMSXJI5
 cchQRmamZ0xBuanN0QenSkyUGEEsHzMq8mngRP+lLdcKCZ3Fi39ag
X-Gm-Gg: ASbGncv5S4JqTGmNUDRXrLXqbSc/N2P5lPHSkxIKD9M+Cv5jXjgD4qJ4KFzVS6hAchg
 YoM5q+b39EImCZgUp44EzKJAS5wtJU/+CDCE9TdWZMDJeo+0wq7EFMjaqYQcJZFUbyUlDP9btKZ
 mwUDjgWGo03kPj+3nUpMwpXCpjE9qeD/UZ3aWI/5HEX0aHxYMQHvsoBxZH4xuN4XXm4O0jV8XCp
 YEetqxfkl/44fIeP9pyUXkM2dM974eFc9Mnh29a4I+o3TynRsSq6BA83BXOsqPQ5r/ZZw==
X-Received: by 2002:a17:907:7842:b0:abb:ebfe:d5eb with SMTP id
 a640c23a62f3a-abc09a4b5afmr118059566b.18.1740094029911; 
 Thu, 20 Feb 2025 15:27:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEft9B6hV5fknXsIT3UL5pslDA1olXqkZecAQVB+qHn/SgLsZOCYqrpAMg+nLpmXX1DTsfPVw==
X-Received: by 2002:a17:907:7842:b0:abb:ebfe:d5eb with SMTP id
 a640c23a62f3a-abc09a4b5afmr118057566b.18.1740094029534; 
 Thu, 20 Feb 2025 15:27:09 -0800 (PST)
Received: from redhat.com ([2.55.163.174]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abbaf6ec730sm677829566b.163.2025.02.20.15.27.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 15:27:08 -0800 (PST)
Date: Thu, 20 Feb 2025 18:27:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 Jason Wang <jasowang@redhat.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "sgarzare@redhat.com" <sgarzare@redhat.com>,
 "lvivier@redhat.com" <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] hw/virtio/vhost: Disable IOTLB callbacks when IOMMU gets
 disabled
Message-ID: <20250220182615-mutt-send-email-mst@kernel.org>
References: <CACGkMEu4oMa8Sf9QXtszeoSMj_67Csr0s7kHdYfbNnJWibu2dA@mail.gmail.com>
 <5a55011a-af8f-483a-99fa-5cb2cdf3841f@redhat.com>
 <CACGkMEv6ec3JLZg6ZedSHdNS5_McX7_xoV4d2MG05x_Y5t=uEA@mail.gmail.com>
 <678babb6-f64a-4db5-ad60-494214a4e673@redhat.com>
 <CACGkMEvyYT7-PTOwO-Jg9a8AHA0AJHoV2BY2RBrJTGKEFYL6QA@mail.gmail.com>
 <25b5bb73-abd8-4008-905d-6c2e9e1330e2@redhat.com>
 <SJ0PR11MB6744EBC0BB7C8CD5F33D0A4E92E32@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <1c073acc-095e-45f0-977c-e22557f180f2@redhat.com>
 <20250220102429-mutt-send-email-mst@kernel.org>
 <fa16f5f1-48a2-4c5d-8b80-4ec012871302@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa16f5f1-48a2-4c5d-8b80-4ec012871302@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Feb 20, 2025 at 04:57:51PM +0100, Eric Auger wrote:
> Hi Michael,
> 
> 
> On 2/20/25 4:25 PM, Michael S. Tsirkin wrote:
> > On Fri, Jan 31, 2025 at 10:55:26AM +0100, Eric Auger wrote:
> >> I tested [PATCH] virtio: Remove virtio devices on device_shutdown()
> >> https://lore.kernel.org/all/20240808075141.3433253-1-kirill.shutemov@linux.intel.com/
> >>
> >> and it fixes my issue
> >>
> >> Eric
> >
> > To make sure, we are dropping this in favor of the guest fix (which
> > I intent to merge shortly), correct?
> 
> Yes this should be dropped in favour of the implementation of the
> shutdown callback on guest side. Did you send your patch, I did not see it.

Will send tomorrow.

> however on qemu side, there is "[PATCH v3 0/5] Fix vIOMMU reset order"
> that needs to be merged to fix qmp system_reset.


Yes that one I'm testing.

> Thanks
> 
> Eric
> >


