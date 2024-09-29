Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C4D9CF6495
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2024 02:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sujF5-0003kA-EV; Sat, 28 Sep 2024 22:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sujEl-0003Ov-4B
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 22:00:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sujEi-0002V8-Hx
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 22:00:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727575235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J9Hozq1w/4r0Rgda8Xzwj6N2catxdDRwg8mpG6LYZE4=;
 b=JgumkLyNyrt2cX6dJIy7NYo1w0wfO3Lb1kqLvyMkBx8x9kpL2DGDmqLVIqbkiIMl5v1Tyi
 KgtjtYBAhlSQ2t1vtDXtI+WcxKPBQ0ewSL/EuPv4b81BMjcsMXWD2FUsKpANBRCrglZHpA
 ApFjJgJ57Kdb/5oS73RC+Rgsfrc9VUA=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-Ail7W8RAN8ay2GYOdtmWnQ-1; Sat, 28 Sep 2024 22:00:32 -0400
X-MC-Unique: Ail7W8RAN8ay2GYOdtmWnQ-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-20b4efbb863so13524275ad.3
 for <qemu-devel@nongnu.org>; Sat, 28 Sep 2024 19:00:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727575231; x=1728180031;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J9Hozq1w/4r0Rgda8Xzwj6N2catxdDRwg8mpG6LYZE4=;
 b=oOcLzDcue+wtreblAWKNq4EiwkaoWSNhAknIeo8RSnEz91SfsYiwIrKqaC1n9TauwL
 3mjNYfyBXeY4kVCascI6ihvAwo7XTK8r00cnKJrZDBzVi+L8eADOgvaJhSmdXcjL0mR2
 ET3G4Z3/GhUF9HAEu603kt7WoiIux6257tzD4OGN5M9HzGniGT9+EmhOGEe00F36+Adx
 3qoRyAZHMySvztsD723ykn4tJV81CM1i8RWo77w26f9CFDudZBUzt/6+kzsHpQBLUmCq
 3PoPwM9S7URSZ8wdMwvzL94Q6faHfapkRNwAovxCo0ka4HVlDDtoZi6qxpXEKjRn5sZ0
 hQWQ==
X-Gm-Message-State: AOJu0YxXL0NWaMNM3pLrd7tYxByG9uM7FT3iEPOirOYlzmka1BhmDZKk
 biF6+5AxGgqeOxdqWhp8rw3UYc0wyMftEtMU06cumhSZxGLqhIklibhvygY1TZ08ZfgE/+wWksX
 CvjGCyIffsiv3TzV+h4xulUMVgZQ92zIBA2W3eiqjr+Fu7QRUauTU/SHKv8rrJRLMPgAEQohv10
 gy2rRDZJV3sfZcHFAhwYwCBeUQ72E=
X-Received: by 2002:a17:903:2307:b0:20b:5046:356 with SMTP id
 d9443c01a7336-20b504607f8mr85563015ad.36.1727575231349; 
 Sat, 28 Sep 2024 19:00:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmfnSNIgSZZMpRoXVqR7QuMy9dXfbSbvjBOrNDZpQId7D4CjwB7/wVF3Jk75zxNvYNzZYoTnfBs9SQ6ovA7sc=
X-Received: by 2002:a17:903:2307:b0:20b:5046:356 with SMTP id
 d9443c01a7336-20b504607f8mr85561645ad.36.1727575229392; Sat, 28 Sep 2024
 19:00:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
 <20240911052255.1294071-16-zhenzhong.duan@intel.com>
 <CACGkMEutsgWhp0mrCG6A3QA1NXnMj8RFDHMKPq3eBv3WxaQ=Vg@mail.gmail.com>
 <SJ0PR11MB6744EE9C94E4BD7FC7275455926B2@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB6744EE9C94E4BD7FC7275455926B2@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 29 Sep 2024 10:00:17 +0800
Message-ID: <CACGkMEvM1XHr-9Fyts5SZdwkhVh4rf=J-MjD5ZBPUcKqJ1s0dA@mail.gmail.com>
Subject: Re: [PATCH v3 15/17] intel_iommu: Modify x-scalable-mode to be string
 option to expose scalable modern mode
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, 
 "peterx@redhat.com" <peterx@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, 
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, 
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, 
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.095,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Sep 27, 2024 at 2:39=E2=80=AFPM Duan, Zhenzhong
<zhenzhong.duan@intel.com> wrote:
>
>
>
> >-----Original Message-----
> >From: Jason Wang <jasowang@redhat.com>
> >Subject: Re: [PATCH v3 15/17] intel_iommu: Modify x-scalable-mode to be
> >string option to expose scalable modern mode
> >
> >On Wed, Sep 11, 2024 at 1:27=E2=80=AFPM Zhenzhong Duan
> ><zhenzhong.duan@intel.com> wrote:
> >>
> >> From: Yi Liu <yi.l.liu@intel.com>
> >>
> >> Intel VT-d 3.0 introduces scalable mode, and it has a bunch of capabil=
ities
> >> related to scalable mode translation, thus there are multiple combinat=
ions.
> >> While this vIOMMU implementation wants to simplify it for user by
> >providing
> >> typical combinations. User could config it by "x-scalable-mode" option=
. The
> >> usage is as below:
> >>
> >> "-device intel-iommu,x-scalable-mode=3D["legacy"|"modern"|"off"]"
> >>
> >>  - "legacy": gives support for stage-2 page table
> >>  - "modern": gives support for stage-1 page table
> >>  - "off": no scalable mode support
> >>  - any other string, will throw error
> >
> >Those we had "x" prefix but I wonder if this is the best option for
> >enabling scalable-modern mode since the "on" is illegal after this
> >change.
>
> Yes, I was thinking "x" means not stable user interface yet.
> But I do agree with you it's better to keep stable user interface wheneve=
r possible.
>
> >
> >Maybe it's better to just have an "x-fls". Or if we considering the
> >scalable mode is kind of complete, it's time to get rid of "x" prefix.
>
> Ah, I thought this is a question only maintainers and reviewers can decid=
e if it's complete.
> If no voice on that, I'd like to add "x-fls" as you suggested and keep x-=
scalable-mode unchanged.

A question here:

Are there any other major features that are still lacking for scalable
mode? If not, maybe we can get rid of the "x" prefix?

Thanks

>
> Thanks
> Zhenzhong
>


