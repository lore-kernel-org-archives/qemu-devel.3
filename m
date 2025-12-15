Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20307D41D74
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 07:34:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV35N-0005NC-Dj; Mon, 15 Dec 2025 02:33:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vV35A-0005MC-8c
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 02:33:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vV356-00057W-Ic
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 02:33:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765783999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7w96pmAH/SkLCF/PexUlaFSAaPQCByO3VVQLrzfZSdU=;
 b=hUXdluK9T+rdDtU0xZSB2N1r2HgnM7YAh/IIEHOVTALfGKJ8UyeTPjyKmO8EaoN0qF4sOj
 wApn8w5VtBq9mTJzfEp0/y7JnMGNVyzPerN/Nswf8nNsMbBiP9MuUNjTbylPav09ztW5J6
 x71Gxv2e7FX9kzUA/5+sZw2QRwCdFSg=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-henWJu-zOX-6XwpHjB-ZvA-1; Mon, 15 Dec 2025 02:33:17 -0500
X-MC-Unique: henWJu-zOX-6XwpHjB-ZvA-1
X-Mimecast-MFC-AGG-ID: henWJu-zOX-6XwpHjB-ZvA_1765783997
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-93f4e170019so6559209241.3
 for <qemu-devel@nongnu.org>; Sun, 14 Dec 2025 23:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765783997; x=1766388797; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7w96pmAH/SkLCF/PexUlaFSAaPQCByO3VVQLrzfZSdU=;
 b=EcDfaEjT8M9ABiukLtURE/+IF6AK9+4fXWeQWLtMYajZWWCVJiEEUH34Ocd7OYD9s1
 AJ2Z6nbHbup2uDmu8/0vduqnoFOIFC/OQgO3J1Cocd6GlWIKV+BgUCsSe39/btiasgpc
 1+a/gsET3SFSY49wJllfbcKjoLZgPK+87+BAtEOqJAf7UDvErITMSJlGTQ7632KnueLR
 cdAfwqsMT8BrKTtZA9lA7EVa/4f2OB7l8a2+2gfyzZmtARmcrMy6TZ7yl8pIGXbmnDX9
 956xzLyoNQUbGf9lgE2q79uRV602QsQZqFxycA0nuvRX1OnQnZvxsxZCyJYWhG2hMj6d
 minQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765783997; x=1766388797;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7w96pmAH/SkLCF/PexUlaFSAaPQCByO3VVQLrzfZSdU=;
 b=doNHBjzQGmbEbzNO2iaDhbIh8K03M4JXmep+yVJJrx3whtQs/XnkVEfeNzqXTZ/ami
 7VLLnCZLJIQrOb532AFVlq/DsXHEEDCvK73xHoJJuMdb/ixQeikBKWeLv1NJ94iZEsp9
 E/bQRhNl8KrJPwg0vp7CwEOQQBrblxn6DmpyZOybaKj1ePie9qKRPeR1BrxVircbKrbp
 PC8+ECq50yNCFBEQXWPX3hj1Qh+xqC3HogJ7ZQLTQ+lnG7DYcjn1CvFtdvc8qjjMMFbH
 K3ErB/HHQ20Vzu9o1C0mAmIazhEsr5hv2Ay5w2VDbqjWyWA+yxVWqygisW3iwRs4pPXG
 WOiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWn32yufz2ID13sSiMoQfSrbDWu+vWOLdhHoJuCYhE35qTBnSYwhR0tpJhZrCP5M71XaBJ6ktxq5hpV@nongnu.org
X-Gm-Message-State: AOJu0YxRX5aK6PhBFYGGWwQjj5qA2v+SKtv5j7Sa6iCOE4QxHBsVTVKl
 q60vP8P/URFtQl/1gnoFbz6Q0sCbAnImSu1x26RuPBYWUzLqlGH6VrxeMk8DHGzKFpCAFwx1Xpz
 qjpK0y/2YtbPBteccJlXeJDuIykBCQrX58YbxkLLbgdT5c4xh8G34hMLxc1cVg4nfFm7JphJOwA
 hkHtuSBZMDXqF1Qlp1nhFTvaQhBEPGyqg=
X-Gm-Gg: AY/fxX4tPSt+eA6xn6L3ewM5c1DBQ/Uf6UcEcv3bEUdwOi7m5XgvNh3HxDu27Mjh3oD
 asudeofOAqbtLtIWqkr3ol+N0QkoGabZPWG8cbPH2SBBT7uqonnhZeDzDkAuRwLrgDemjCvnZTm
 GW04o2YktWx+ev1tNuMf/akCBW2uvwhTVNaNhYBpZuDZTDBDSO4JSpW7kG2adilBatRs8=
X-Received: by 2002:a05:6102:6a94:b0:5db:d07c:21a8 with SMTP id
 ada2fe7eead31-5e8277d7832mr3273395137.25.1765783996821; 
 Sun, 14 Dec 2025 23:33:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6gqEVvlkTJbxfvkQkEciUsqkV24NUoLy7KTPy6DA2wS0pvUOR4KPziVc1M4NS02+hPHZkqNRVSXyQOA2wo8c=
X-Received: by 2002:a05:6102:6a94:b0:5db:d07c:21a8 with SMTP id
 ada2fe7eead31-5e8277d7832mr3273372137.25.1765783996388; Sun, 14 Dec 2025
 23:33:16 -0800 (PST)
MIME-Version: 1.0
References: <20251117093729.1121324-1-zhenzhong.duan@intel.com>
 <20251117093729.1121324-3-zhenzhong.duan@intel.com>
 <CACGkMEtK_KiT+PCvxi2NUQ-gX0ekV3RtZ6E5T7oZSeiOqkSSkw@mail.gmail.com>
 <4618ef6c-9f54-45bf-a95c-5f813f9a2365@intel.com>
In-Reply-To: <4618ef6c-9f54-45bf-a95c-5f813f9a2365@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Dec 2025 15:33:03 +0800
X-Gm-Features: AQt7F2qBkvPbDmgjrJOurzdG4H4MaY7uwkXmX-WF4yL98Gm4qt5kd7EIfqNygSk
Message-ID: <CACGkMEuBNf6wRPOrprbUDBUnWVieaKEXMRhpJhFhTszznsCTHA@mail.gmail.com>
Subject: Re: [PATCH v8 02/23] intel_iommu: Delete RPS capability related
 supporting code
To: Yi Liu <yi.l.liu@intel.com>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
 alex@shazbot.org, 
 clg@redhat.com, eric.auger@redhat.com, mst@redhat.com, peterx@redhat.com, 
 ddutile@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com, 
 skolothumtho@nvidia.com, joao.m.martins@oracle.com, 
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, chao.p.peng@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Dec 11, 2025 at 6:57=E2=80=AFPM Yi Liu <yi.l.liu@intel.com> wrote:
>
> On 2025/12/11 16:22, Jason Wang wrote:
> > On Mon, Nov 17, 2025 at 5:38=E2=80=AFPM Zhenzhong Duan <zhenzhong.duan@=
intel.com> wrote:
> >>
> >> RID-PASID Support(RPS) is not set in vIOMMU ECAP register, the support=
ing
> >> code is there but never takes effect.
> >>
> >> Meanwhile, according to VTD spec section 3.4.3:
> >> "Implementations not supporting RID_PASID capability (ECAP_REG.RPS is =
0b),
> >> use a PASID value of 0 to perform address translation for requests wit=
hout
> >> PASID."
> >>
> >> We should delete the supporting code which fetches RID_PASID field fro=
m
> >> scalable context entry and use 0 as RID_PASID directly, because RID_PA=
SID
> >> field is ignored if no RPS support according to spec.
> >>
> >> This simplifies the code and doesn't bring any penalty.
> >>
> >> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> >> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> >> ---
> >
> > Is the feature deprecated in the spec? If not, it should be still
> > better to enable it.
>
> Hi Jason,
>
> The feature is still in the spec. However, using PASID#0 for the
> requests without pasid is aligned across vendors. So the linux iommu
> subsystem uses PASID#0 to differentiate the pasid path and non-pasid
> path like below:
>
> commit bc06f7f66de404ae6323963361fe4e2f5f71a1e5
> Author: Yi Liu <yi.l.liu@intel.com>
> Date:   Fri Mar 21 10:19:26 2025 -0700
>
>      iommufd/device: Only add reserved_iova in non-pasid path
>
>      As the pasid is passed through the attach/replace/detach helpers, it=
 is
>      necessary to ensure only the non-pasid path adds reserved_iova.
>
>      Link:
> https://patch.msgid.link/r/20250321171940.7213-5-yi.l.liu@intel.com
>      Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>      Reviewed-by: Kevin Tian <kevin.tian@intel.com>
>      Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
>      Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
>      Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>      Tested-by: Nicolin Chen <nicolinc@nvidia.com>
>      Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/devic=
e.c
> index 7051feda2fab..4625f084f7d0 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -483,6 +483,7 @@ int iommufd_hw_pagetable_attach(struct
> iommufd_hw_pagetable *hwpt,
>                                  struct iommufd_device *idev, ioasid_t
> pasid)
>   {
>          struct iommufd_hwpt_paging *hwpt_paging =3D find_hwpt_paging(hwp=
t);
> +       bool attach_resv =3D hwpt_paging && pasid =3D=3D IOMMU_NO_PASID;
>          int rc;
>
>
> So even though intel hardware report RPS=3D1, the linux intel iommu
> driver uses PASID#0 as rid_pasid and ignores the RPS value.

Probably, but we need to support OSes other than Linux.

> So
> I don't think we will ever report RPS=3D1 to VM. Also, as Zhenzhong's
> commit message states, current vIOMMU does not report RPS, the logic to
> retrieve rid_pasid from context entry is not necessary as well. Based on
> the fact, I think it is nice to drop the support. Please let us know if
> you have other ideas.

I'm fine to drop that, just want to double check if it's worth keeping
with an option to enable it.

Thanks

>
> Regards,
> Yi Liu
>


