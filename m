Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E3BC25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 03:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBn7x-0001OY-5j; Mon, 27 May 2024 23:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sBn7t-0001M4-DF
 for qemu-devel@nongnu.org; Mon, 27 May 2024 23:03:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sBn7r-00077M-Kc
 for qemu-devel@nongnu.org; Mon, 27 May 2024 23:03:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716865426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WzEn6uJLI5mPxn+2OO1AIdB2EWxWIjyAvVd9QE+JLPU=;
 b=fnjTbJX7hcaLzkxZgA8K2ZkL534x7v1zIMu0W9aOQ2Q+dgBApcKXAWn7DJG8nyh1C9f9Dj
 MXOAgVi7dfkQRRq1sJd4nWEifucYxxRxsTt7K1+mKUNcUP8oxUzcfx5lbswNeLFD11hMbO
 BuXu5hWJBz6wVaYx9i0cum2Qt3BSns0=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-0cKY8jRpOUeGwSOIvPdtsA-1; Mon, 27 May 2024 23:03:44 -0400
X-MC-Unique: 0cKY8jRpOUeGwSOIvPdtsA-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-681bc7f3af6so2374118a12.0
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 20:03:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716865423; x=1717470223;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WzEn6uJLI5mPxn+2OO1AIdB2EWxWIjyAvVd9QE+JLPU=;
 b=c5VyLK9Mfgx0P+tPrY9BNHhnWIQ2NGY/v3/ssmV/52BHjy6zoektuQrG4SNjJT2CDB
 vuU6Ed1qhi+F2YgQeaNDgez2LGy898aiXMpqAlEywdW+xmfH89aNxVO5w1wwrnHuJYEn
 qFzX97p7CsHUVFb/MuKDrOStaYQvxOmqZI7HoLSPaczMqSdEGCMn9nnu9qcfxwuPAA9m
 Kd6aDt1uU57MLU8LCyoLkZpHHD7ng2I5BU0iYLrlT0csM0fwePrsM9uEambxg5rlY3Yl
 Jx6F2aUXvbZXoxQJ8p9/a0TiqrfH4EQRLJKSRVUf1H4PGCch7Fol6X6m9WJoTEcy+hXk
 82RQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFk1+KArnHj4KSgRDdu9n/nPhrxkR8YEn3WvhxAsS86Im44uHQQ+hAODy01R8RgahotWcK10KLKN4J+JD4lEAu3ePqO8U=
X-Gm-Message-State: AOJu0Yxm7Oj0jXEnDRjC1X3ODe0FPQpCYfXIyBE058cMR4tZgbGzSyui
 G5ngOtbYVVWWLH2qMKEcPRNZpr36VyXY8meLT/CLAOEqHYWgBHIOJsLeoPj5F4aiHGbTViCOIGD
 3c4qHKFRfU5WdaNOyIVSf5z/epW3ik7tVCt0YYIn3oaOcCUS/HnpMJTvMaq7XWSZF0t8GYVE7pm
 yJrYjEjCL1dOPSpiSi803UqBXYGHg=
X-Received: by 2002:a17:90a:55cd:b0:2bd:9255:91b6 with SMTP id
 98e67ed59e1d1-2bddce5c5b1mr19472042a91.4.1716865423412; 
 Mon, 27 May 2024 20:03:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/WZ+F0rjBuNjb18Psuw2xqc7092iNL8EZaO7SsmI/LOL7LK42CE1L8ucrRJKNtBrJTS1G+zyeDg9Dk5gZRPA=
X-Received: by 2002:a17:90a:55cd:b0:2bd:9255:91b6 with SMTP id
 98e67ed59e1d1-2bddce5c5b1mr19472005a91.4.1716865422847; Mon, 27 May 2024
 20:03:42 -0700 (PDT)
MIME-Version: 1.0
References: <CACGkMEvTomFeC1bM3SfY1zGhQ_5i15r6CY6M3jVzau6niNUf_w@mail.gmail.com>
 <SJ0PR11MB6744AECEAA6F9319259B0DF192E92@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <DS0PR11MB752917B52B66A6EF10C10678C3E92@DS0PR11MB7529.namprd11.prod.outlook.com>
 <CACGkMEt5ofYt12A6uKUj=QLcLbOnrGT=UkMpee=MUxO6Xy3sxg@mail.gmail.com>
 <SJ0PR11MB6744C340AAB1B786D3913F5D92EA2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <CACGkMEsV05ujKNEL9JSAsfikWGW582yvfSOdHJgRxZC_1cxgEg@mail.gmail.com>
 <SJ0PR11MB67445F7F8B79D2C2B982C1F692F52@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <CACGkMEuO6T-LqcZ=5oRR83LyhZ7oOtZvb70CUksZDAmC1KnsOA@mail.gmail.com>
 <SJ0PR11MB6744135D8C08CEE42460CAF792F02@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <SJ0PR11MB67448F0D3CE487F125D274AF92F02@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <20240527025023-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240527025023-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 28 May 2024 11:03:31 +0800
Message-ID: <CACGkMEuCqCNhVvXYN6jT5CDHbnt8sEHUk2UfwVaaOVLXfSfv3w@mail.gmail.com>
Subject: Re: [PATCH] intel_iommu: Use the latest fault reasons defined by spec
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "Liu,
 Yi L" <yi.l.liu@intel.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Peng,
 Chao P" <chao.p.peng@intel.com>, 
 Yu Zhang <yu.c.zhang@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Mon, May 27, 2024 at 2:50=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, May 27, 2024 at 06:44:58AM +0000, Duan, Zhenzhong wrote:
> > Hi Jason,
> >
> > >-----Original Message-----
> > >From: Duan, Zhenzhong
> > >Subject: RE: [PATCH] intel_iommu: Use the latest fault reasons defined=
 by
> > >spec
> > >
> > >
> > >
> > >>-----Original Message-----
> > >>From: Jason Wang <jasowang@redhat.com>
> > >>Subject: Re: [PATCH] intel_iommu: Use the latest fault reasons define=
d by
> > >>spec
> > >>
> > >>On Fri, May 24, 2024 at 4:41=E2=80=AFPM Duan, Zhenzhong
> > >><zhenzhong.duan@intel.com> wrote:
> > >>>
> > >>>
> > >>>
> > >>> >-----Original Message-----
> > >>> >From: Jason Wang <jasowang@redhat.com>
> > >>> >Subject: Re: [PATCH] intel_iommu: Use the latest fault reasons def=
ined
> > >by
> > >>> >spec
> > >>> >
> > >>> >On Tue, May 21, 2024 at 6:25=E2=80=AFPM Duan, Zhenzhong
> > >>> ><zhenzhong.duan@intel.com> wrote:
> > >>> >>
> > >>> >>
> > >>> >>
> > >>> >> >-----Original Message-----
> > >>> >> >From: Jason Wang <jasowang@redhat.com>
> > >>> >> >Subject: Re: [PATCH] intel_iommu: Use the latest fault reasons
> > >defined
> > >>by
> > >>> >> >spec
> > >>> >> >
> > >>> >> >On Mon, May 20, 2024 at 12:15=E2=80=AFPM Liu, Yi L <yi.l.liu@in=
tel.com>
> > >>wrote:
> > >>> >> >>
> > >>> >> >> > From: Duan, Zhenzhong <zhenzhong.duan@intel.com>
> > >>> >> >> > Sent: Monday, May 20, 2024 11:41 AM
> > >>> >> >> >
> > >>> >> >> >
> > >>> >> >> >
> > >>> >> >> > >-----Original Message-----
> > >>> >> >> > >From: Jason Wang <jasowang@redhat.com>
> > >>> >> >> > >Sent: Monday, May 20, 2024 8:44 AM
> > >>> >> >> > >To: Duan, Zhenzhong <zhenzhong.duan@intel.com>
> > >>> >> >> > >Cc: qemu-devel@nongnu.org; Liu, Yi L <yi.l.liu@intel.com>;=
 Peng,
> > >>> >Chao
> > >>> >> >P
> > >>> >> >> > ><chao.p.peng@intel.com>; Yu Zhang
> > >><yu.c.zhang@linux.intel.com>;
> > >>> >> >Michael
> > >>> >> >> > >S. Tsirkin <mst@redhat.com>; Paolo Bonzini
> > >>> ><pbonzini@redhat.com>;
> > >>> >> >> > >Richard Henderson <richard.henderson@linaro.org>; Eduardo
> > >>> >Habkost
> > >>> >> >> > ><eduardo@habkost.net>; Marcel Apfelbaum
> > >>> >> ><marcel.apfelbaum@gmail.com>
> > >>> >> >> > >Subject: Re: [PATCH] intel_iommu: Use the latest fault rea=
sons
> > >>> >defined
> > >>> >> >by
> > >>> >> >> > >spec
> > >>> >> >> > >
> > >>> >> >> > >On Fri, May 17, 2024 at 6:26=E2=80=AFPM Zhenzhong Duan
> > >>> >> >> > ><zhenzhong.duan@intel.com> wrote:
> > >>> >> >> > >>
> > >>> >> >> > >> From: Yu Zhang <yu.c.zhang@linux.intel.com>
> > >>> >> >> > >>
> > >>> >> >> > >> Currently we use only VTD_FR_PASID_TABLE_INV as fault
> > >>reason.
> > >>> >> >> > >> Update with more detailed fault reasons listed in VT-d s=
pec
> > >>7.2.3.
> > >>> >> >> > >>
> > >>> >> >> > >> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> > >>> >> >> > >> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> > >>> >> >> > >> ---
> > >>> >> >> > >
> > >>> >> >> > >I wonder if this could be noticed by the guest or not. If =
yes
> > >should
> > >>> >> >> > >we consider starting to add thing like version to vtd emul=
ation
> > >>code?
> > >>> >> >> >
> > >>> >> >> > Kernel only dumps the reason like below:
> > >>> >> >> >
> > >>> >> >> > DMAR: [DMA Write NO_PASID] Request device [20:00.0] fault
> > >addr
> > >>> >> >0x1234600000
> > >>> >> >> > [fault reason 0x71] SM: Present bit in first-level paging e=
ntry is
> > >>clear
> > >>> >> >>
> > >>> >> >> Yes, guest kernel would notice it as the fault would be injec=
ted to
> > >vm.
> > >>> >> >>
> > >>> >> >> > Maybe bump 1.0 -> 1.1?
> > >>> >> >> > My understanding version number is only informational and i=
s
> > >far
> > >>> >from
> > >>> >> >> > accurate to mark if a feature supported. Driver should chec=
k
> > >>cap/ecap
> > >>> >> >> > bits instead.
> > >>> >> >>
> > >>> >> >> Should the version ID here be aligned with VT-d spec?
> > >>> >> >
> > >>> >> >Probably, this might be something that could be noticed by the
> > >>> >> >management to migration compatibility.
> > >>> >>
> > >>> >> Could you elaborate what we need to do for migration compatibili=
ty?
> > >>> >> I see version is already exported so libvirt can query it, see:
> > >>> >>
> > >>> >>     DEFINE_PROP_UINT32("version", IntelIOMMUState, version, 0),
> > >>> >
> > >>> >It is the Qemu command line parameters not the version of the vmst=
ate.
> > >>> >
> > >>> >For example -device intel-iommu,version=3D3.0
> > >>> >
> > >>> >Qemu then knows it should behave as 3.0.
> > >>>
> > >>> So you want to bump vtd_vmstate.version?
> > >>
> > >>Well, as I said, it's not a direct bumping.
> > >>
> > >>>
> > >>> In fact, this series change intel_iommu property from x-scalable-
> > >>mode=3D["on"|"off"]"
> > >>> to x-scalable-mode=3D["legacy"|"modern"|"off"]".
> > >>>
> > >>> My understanding management app should use same qemu cmdline
> > >>> in source and destination, so compatibility is already guaranteed e=
ven if
> > >>> we don't bump vtd_vmstate.version.
> > >>
> > >>Exactly, so the point is to
> > >>
> > >>vtd=3D3.0, the device works exactly as vtd spec 3.0.
> > >>vtd=3D3.3, the device works exactly as vtd spec 3.3.
> >
> > Yi just found version ID stored in VT-d VER_REG is not aligned with the=
 VT-d spec version.
> > For example, we see a local hw with vtd version 6.0 which is beyond VT-=
d spec version.
> > We are asking VTD arch, will get back soon.
> >
> > Or will you plan qemu vVT-d having its own version policy?
> >
> > Thanks
> > Zhenzhong
>
> Not unless there's a good reason to do this.

+1

Thanks


