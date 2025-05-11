Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B58C3ABC3
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 15:22:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uE8VJ-0004Fl-7U; Sun, 11 May 2025 11:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1uE8VH-0004Fd-MP
 for qemu-devel@nongnu.org; Sun, 11 May 2025 11:22:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1uE8VE-00030k-Re
 for qemu-devel@nongnu.org; Sun, 11 May 2025 11:22:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746976927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zuHWbWetPMANZx0QgiUW+ZBCPwgLxwWx8+7ETBnjLtU=;
 b=htFLJO/EKc9H+PAjkw5/sqgXz+XZHWUa8oBwgKyYJtEq0rP3/VwgnEE8swLru+9zZ//WgF
 u/HfcTYiX6eEmKxQANsh6lLs7LTYKYk2YYw6Ihrc9hcXbFZ7k7AfpNRMW5sbqAgHspZIq8
 bwzwpjlMe8d7UubJyW0Airjh9ReiIL4=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-iLstEaTTPy-3YFwvQ8mtsA-1; Sun, 11 May 2025 11:20:53 -0400
X-MC-Unique: iLstEaTTPy-3YFwvQ8mtsA-1
X-Mimecast-MFC-AGG-ID: iLstEaTTPy-3YFwvQ8mtsA_1746976853
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-70ad3a91ab2so13737817b3.1
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 08:20:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746976853; x=1747581653;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zuHWbWetPMANZx0QgiUW+ZBCPwgLxwWx8+7ETBnjLtU=;
 b=BQxX2zC9cKgHJ+ReystnpNsCWgbyr7tEY7XYBoLe1zqCNhDSzieMjfYtLADCqamxn5
 PTK8ngf+yCkgwueJTTtdKylUKmchl+V9DoCtjti/mSZrqfiMFkLBC58RPNL2mwDDMpOT
 vr/GZdqXFpBlX56l2dxemhoLB+bIK+dpyMBagmT/WBfKSVfoWfBvJqXmFvzeTa+E35np
 sbMFdrbaCKN7TXK2Y8iDVdu0mOL5oZ1z/rpdiohJhJzTXMvS36zefB4WpktcOXl7oFiM
 lorGCSy9cjAaIAyl9NItGxRHXWkL7GwiqkMYO8dc603mLQJdNzJB+8W+VAWIru9J6i8m
 qsew==
X-Forwarded-Encrypted: i=1;
 AJvYcCW205aivLB7k/vZnkIsxiFEp5ANX2YHWNFh4aWNqruaLD4lXuTJlM12FR6au/tGDSrJiyY5v+dAX14r@nongnu.org
X-Gm-Message-State: AOJu0YxpI+PrLlEq71u7RMwZ8qzW3FZgmcRpK6LvEFtpl+wckU9T08d+
 UNoL4Uammx+y/bDm79tBk1KHTlfQPYyxPa/ihdu33/bwEskvGk2AXSJT1/kpZXw+W8V0i+bsyZr
 Ypi0mxn1pft34F8Yx7wOIkgY1+cjF1WdA+uCJti7XW0qZIaPl/G70GMWlm30ss1Kxv//8tMNiNZ
 xkMT76M2rSY7mC2q94k1dr3QYXkGU=
X-Gm-Gg: ASbGncvFTdgApuurwDNPWJ+CsfRsCLu/YxNuLzlO8wXny341nMa6n86VZI2zNKAU3yn
 mc0BBGEqk26bhfL8FtSbgJq6Ab8UfSvj2iljU3gLnWstOk7ihYUoT3TSXuofThbZNMZMs
X-Received: by 2002:a05:690c:4a04:b0:6fd:359a:8fd2 with SMTP id
 00721157ae682-70a3fb0d078mr144843497b3.26.1746976852762; 
 Sun, 11 May 2025 08:20:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdR8/zDxy8jTFvrTByOIVz7fjexuoxR6XxRwoaKp8vr/gE8KD3p4wUAK09sD+FdVx9Q3SrY8FcrdHNqfa9Zpg=
X-Received: by 2002:a05:690c:4a04:b0:6fd:359a:8fd2 with SMTP id
 00721157ae682-70a3fb0d078mr144843167b3.26.1746976852473; Sun, 11 May 2025
 08:20:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250304183747.639382-1-suravee.suthikulpanit@amd.com>
 <20250309094039-mutt-send-email-mst@kernel.org>
 <70b47c11-da90-4f93-b7b7-a522b8ae7def@amd.com>
 <CAGoVJZwg0KvZX7_OCFYp+RBk_fO4kBV3MmY3FxUC=RbnNKLtZA@mail.gmail.com>
 <20250511092651-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250511092651-mutt-send-email-mst@kernel.org>
From: Yan Vugenfirer <yvugenfi@redhat.com>
Date: Sun, 11 May 2025 18:20:41 +0300
X-Gm-Features: AX0GCFu7qyXtlOa67v1pMQoBPqeD6Jw6sj-lf-bOmPVxGaIJOjGuqFUCtpANFO8
Message-ID: <CAGoVJZw=okgUdmSdWWc+iU7cQ0M7B-j0s66pWtqygZdYtJCgrw@mail.gmail.com>
Subject: Re: [PATCH] pci-ids.rst: Add Red Hat pci-id for AMD IOMMU device
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>,
 qemu-devel@nongnu.org, 
 pbonzini@redhat.com, mtosatti@redhat.com, marcel.apfelbaum@gmail.com, 
 jon.grimm@amd.com, santosh.shukla@amd.com, vasant.hegde@amd.com, 
 Wei.Huang2@amd.com, kraxel@redhat.com, bsd@redhat.com, berrange@redhat.com, 
 ddutile@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=yvugenfi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sun, May 11, 2025 at 4:27=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Mar 12, 2025 at 02:43:52PM +0200, Yan Vugenfirer wrote:
> >
> >
> > On Tue, Mar 11, 2025 at 4:02=E2=80=AFAM Suthikulpanit, Suravee <
> > suravee.suthikulpanit@amd.com> wrote:
> >
> >
> >
> >     On 3/9/2025 8:44 PM, Michael S. Tsirkin wrote:
> >     > On Tue, Mar 04, 2025 at 06:37:47PM +0000, Suravee Suthikulpanit w=
rote:
> >     >> The QEMU-emulated AMD IOMMU PCI device is implemented based on t=
he AMD I
> >     /O
> >     >> Virtualization Technology (IOMMU) Specification [1]. The PCI id =
for this
> >     >> device is platform-specific.
> >     >>
> >     >> Currently, the QEMU-emulated AMD IOMMU device is using AMD vendo=
r id and
> >     >> undefined device id.
> >     >>
> >     >> Therefore, change the vendor id to Red Hat and request a new
> >     QEMU-specific
> >     >> device id.
> >     >>
> >     >> [1] https://www.amd.com/content/dam/amd/en/documents/processor-t=
ech-docs
> >     /specifications/48882_IOMMU.pdf
> >     >>
> >     >> Cc: Gerd Hoffmann <kraxel@redhat.com>
> >     >> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.=
com>
> >     >
> >     > Will the existing drivers bind with the device then?
> >
> >     Existing Windows would not recognize the device ID.
> >
> >     Actually, Linux and Windows does not depend on the PCI vendor / dev=
ice
> >     ids to probe devices and initialize AMD IOMMU. Instead, it depends =
on
> >     the ACPI IVRS table.
> >
> >     Checking on a real system w/ AMD IOMMU enabled booting Windows Serv=
er
> >     2022, there is no AMD IOMMU device showing in the Device Manger.
> >
> >     In this case, I believe Windows is not fully initializing the
> >     QEMU-emulated AMD IOMMU. So Windows would not remove the IOMMU PCIe=
 from
> >     the list of OS visible devices and therefore expose the PNPID to th=
e
> >     device manager. And since the device ID is zero, it appears as an "=
Other
> >     devices->PCI Device (with warning sign).
> >
> >     Therefore, it we have two options:
> >
> >     1. Fake the device ID to 0x1419, which is current appear in the
> >     machine.inf as an entry in section [AMD_SYS.NTamd64]:
> >
> >     %IommuDevice_Desc% =3D NO_DRV,PCI\VEN_1022&DEV_1419
> >
> > Considering that this is a "null driver" (no actual driver is loaded fo=
r the
> > PCIe endpoint according to machine.inf), I recommend using this PNP ID.
> >
>
> So this is the status quo really or did I miss anything?

There was a patch fixing it:
https://patchwork.kernel.org/project/qemu-devel/patch/20250325021140.5676-1=
-suravee.suthikulpanit@amd.com/

>
> >
> >     2. Figure out why Windows does not recognize the device.
> >
> > The answer is simple: the PCIe endpoint's PNP ID is unknown to Windows.=
 So
> > technically device is recognized (it is shown in Device Manager after a=
ll), but
> > there are no compatible drivers for it. And in anycase, machine.inf spe=
cifies
> > "null driver" for AMD PCIe endpoint IOMMU device. The device will get a
> > friendly name in Device Manager and considered to be "installed" by Win=
dows, by
> > there is no actual driver associated with the device.
> >
> > Best regards,
> > Yan.
> >
> >
> >
> >     Anyhow, we should still assign some PCI ID value (instead of zero).
> >
> >     Thanks,
> >     Suravee
> >
> >
> >
> >
>


