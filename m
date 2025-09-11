Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC451CAC58E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 21:38:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwozM-0008OK-VZ; Thu, 11 Sep 2025 17:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uwozH-0008ND-2P
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 17:37:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uwozF-0002PW-4b
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 17:37:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757626667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FiCyz6EVR6jBzhXKpqtY5pzFlCLeBcC3HA1Stps25ek=;
 b=Wr31ykKtTU2QWg1DQEwOp3oN9TwBHJ6m/C5sHuG91EKTQsDJP5yuczbBFXQteKXM4OSp50
 yiu+wiQINbjDW5jCcuNkIRvBfWXAXl7Nr0EUw3/h9T8QJncW0SCoHdOZw/7V2Jwm3oR5ml
 rj9Rx/oiwZDilOETnw108QoKxu2JC3s=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-C1ioA6ssN16qemAm12yzxg-1; Thu, 11 Sep 2025 17:37:46 -0400
X-MC-Unique: C1ioA6ssN16qemAm12yzxg-1
X-Mimecast-MFC-AGG-ID: C1ioA6ssN16qemAm12yzxg_1757626666
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-810591dd04fso280774885a.1
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 14:37:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757626665; x=1758231465;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FiCyz6EVR6jBzhXKpqtY5pzFlCLeBcC3HA1Stps25ek=;
 b=LUcn0SEh4fSKKL2rIK0i+CsllwYsBJhxFHvOdoc0ogsP6mR3aQSJUJQwL6o4f/z5sD
 sg51CLUKM6+u1Sx8QG9F/lkjPb26r76FqK9UeV+xCR4w0rW3cqzzf70C5TW9bUiWtKNm
 tedULOGZD72urU+qlowOsubBeMSydPSaaCaGVsAvT2SJJcEW9MJXVW3xlZb/WdboLR3q
 z6giwVE/17NS4iRofR1v/caK6VHcssczYs0UGcWzS11sPVhb8eooVxA1gmxG7gIBcG4Y
 H/DsY7KyTy2TUkFn59aBPnCXyjj9pw1ATMqzdIhxjqPmsWPqI+Vt4vRu9eKWO3ub3lfx
 fqBA==
X-Gm-Message-State: AOJu0Yy3/6RJdWDxHOvf5CTdsR3lsaztdk9lHxkCen0TvxtisJbI1ENR
 yrNeJ8p0rXPqoEmAyMbXxHkEtniFON+OuiVI4oW/UIG1mHQYhZoKr20/MQQop8hSsvye5J2iWVQ
 uyQHiQYIuxMPR4aZbdHn4EXbhzGQJUrbfyKWJ+SpQFNw2ttsrBpD83GIA
X-Gm-Gg: ASbGncv29awWwsyAyRtjMDpuPLkiJYVb9Sq3oilR4IzIq10iGN9P6Bgwtk8uPNvu/W2
 CydrtwPhccw0LAxwVCYUmgWtf6scAjvwYgbzhmhOSZI3PQMxU/D9iseDOb1dAFMYOhPgAAHY1kv
 hGSnv3em+7SciDUxwnV3QwHragtuoaj7i/9JlEnWSAWqvg2mMh7d3x0xI8grnAztwC5DAi6kQyy
 /ZBx1xln7m6ya4HyIHAMJwx3cSRLm+elnwqCNt7+8SwPCHFgcRD1XkI57phOMGis2DIe8dwDpmd
 W/VZ/eDuskhaqZ9/6J1PwUdl9XYsYStH2lGJykvygxOUwB4+XoG+cWM57PCvpMyku2KDxt8RCFo
 OLrmWYKDytIULknaZOfnAfw==
X-Received: by 2002:a05:620a:7003:b0:7e6:8f41:2047 with SMTP id
 af79cd13be357-823fbde80b9mr133928185a.6.1757626665446; 
 Thu, 11 Sep 2025 14:37:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9yk4w4dHD8M5emMW19sKHJMCiNE/fqx5xjMFsI706QdPL6bDzxxshfRKNLV/J39M7PNC4Hg==
X-Received: by 2002:a05:620a:7003:b0:7e6:8f41:2047 with SMTP id
 af79cd13be357-823fbde80b9mr133922085a.6.1757626664991; 
 Thu, 11 Sep 2025 14:37:44 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-820c3136b80sm171682185a.0.2025.09.11.14.37.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 14:37:44 -0700 (PDT)
Date: Thu, 11 Sep 2025 17:37:40 -0400
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Yanan Wang <wangyanan55@huawei.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: Re: [PATCH 02/22] vfio/pci: Do not unparent in instance_finalize()
Message-ID: <aMNBJF9E4BYrWEHO@x1.local>
References: <20250906-use-v1-0-c51caafd1eb7@rsg.ci.i.u-tokyo.ac.jp>
 <20250906-use-v1-2-c51caafd1eb7@rsg.ci.i.u-tokyo.ac.jp>
 <aMHidDl1tdx-2G4e@x1.local>
 <1a5b7471-1799-44bd-9c1c-c3c07e478bb8@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1a5b7471-1799-44bd-9c1c-c3c07e478bb8@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Sep 11, 2025 at 12:47:24PM +0900, Akihiko Odaki wrote:
> On 2025/09/11 5:41, Peter Xu wrote:
> > On Sat, Sep 06, 2025 at 04:11:11AM +0200, Akihiko Odaki wrote:
> > > Children are automatically unparented so manually unparenting is
> > > unnecessary.
> > > 
> > > Worse, automatic unparenting happens before the insntance_finalize()
> > > callback of the parent gets called, so object_unparent() calls in
> > > the callback will refer to objects that are already unparented, which
> > > is semantically incorrect.
> > > 
> > > Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > > ---
> > >   hw/vfio/pci.c | 4 ----
> > >   1 file changed, 4 deletions(-)
> > > 
> > > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > > index 07257d0fa049b09fc296ac2279a6fafbdf93d277..2e909c190f86a722e1022fa7c45a96d2dde8d58e 100644
> > > --- a/hw/vfio/pci.c
> > > +++ b/hw/vfio/pci.c
> > > @@ -2000,7 +2000,6 @@ static void vfio_bars_finalize(VFIOPCIDevice *vdev)
> > >           vfio_region_finalize(&bar->region);
> > >           if (bar->mr) {
> > >               assert(bar->size);
> > > -            object_unparent(OBJECT(bar->mr));
> > >               g_free(bar->mr);
> > >               bar->mr = NULL;
> > >           }
> > > @@ -2008,9 +2007,6 @@ static void vfio_bars_finalize(VFIOPCIDevice *vdev)
> > >       if (vdev->vga) {
> > >           vfio_vga_quirk_finalize(vdev);
> > > -        for (i = 0; i < ARRAY_SIZE(vdev->vga->region); i++) {
> > > -            object_unparent(OBJECT(&vdev->vga->region[i].mem));
> > > -        }
> > >           g_free(vdev->vga);
> > >       }
> > >   }
> > 
> > So the 2nd object_unparent() here should be no-op, seeing empty list of
> > properties (but shouldn't causing anything severe), is that correct?
> 
> No. The object is finalized with the first object_unparent() if there is no
> referrer other than the parent. The second object_unparent() will access the
> finalized, invalid object in that case.

Yes, it's logically wrong.  I was trying to understand the impact when it's
invoked.  In this specific case of above two changes, I believe both MR
structs are still available, so it does look fine, e.g. nothing would crash.

For example, I think it doesn't need to copy stable if there's no real
functional issue involved.

> 
> > 
> > I think it still makes some sense to theoretically allow object_unparent()
> > to happen, at least when it happens before owner's finalize().  IIUC that
> > was the intention of the doc, pairing the memory_region_init*() operation.
> 
> Perhaps so, but this patch is only about the case where object_unparent() is
> called in finalize().

You ignored my other comment.  That (using object_new() on MRs) was what I
was thinking might be better than a split model you discussed here, so
that's also a comment for patch 1 of your series.

Btw, this patch also didn't change all occurances of such for VFIO?
E.g. there's at least vfio_vga_quirk_finalize().  I didn't check the rest.

-- 
Peter Xu


