Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A54F6C02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 07:57:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbxVh-0003p2-Kl; Sun, 26 Jan 2025 02:56:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tbxVf-0003om-W6
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 02:56:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tbxVd-0007ho-Tw
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 02:56:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737878202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UA1aKs2geI2UCclqvopY0JvXRSLzBy5wPgR6WfmViSA=;
 b=fadIPKzcIJ4/AjibN6Jk92w9tffh3vKlS1QmN6XXelSPjzdH5kQiJVBo9mcCPJv3CxV/R2
 l3XKSFLyxzAjKaNwBsyggQVDl+brJlnrtzfIy8sBLtrQe2UfpkjbfjAtzp30AXhG99h4Yn
 UohGhcRt/SjyQWDpv067PrKAgALTI8k=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-UTMu__BcMoSVP3E6iRIa0g-1; Sun, 26 Jan 2025 02:56:40 -0500
X-MC-Unique: UTMu__BcMoSVP3E6iRIa0g-1
X-Mimecast-MFC-AGG-ID: UTMu__BcMoSVP3E6iRIa0g
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2f5538a2356so6299142a91.2
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 23:56:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737878199; x=1738482999;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UA1aKs2geI2UCclqvopY0JvXRSLzBy5wPgR6WfmViSA=;
 b=EqhTWJ/EArQ7SOziRJeeRYTSNvFJ20joaRp9rnlDYiTGmtx4Pt3CM1e5NNnqa7uKGg
 JgPzi0/KtwEskqe1RsNm9rN0WpcLYgWwGiG/gDdAXh5XrXXRG2/RQirUbaeoZU00wwYY
 OxEMHNVzKX3uBIbRd1vHPilWHcCm+1k39zxCa2F6nfyFLiBmrDzi5RwuZuG4MtHLg6IU
 6r76AM8jYmmhkYvdXSSg2h+LuHkv90vTTXMcT9xgqYNAgYsVxef26a7bfEe0IjTu3Uue
 IeAiofn5u2BcLHt8uEVAJoifLdElZj/IPCrxsSAbWC3riYVlD01ynp5AGCaTah2JODOX
 X+Ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfDTo4CVLUXliDbxOxVf8e16s2gx43dJoVFq1/t3YY5fLe1Jo4VqpJQ+9P/YV2wqE2NJxQbRdBDvLG@nongnu.org
X-Gm-Message-State: AOJu0YwMjpRP4xZcGp3KOczNiGUMgjT74HWHkpmNBMbcJhpJqxKvZRsS
 KlbH5PlRU4qWTMRXQhRNJLh6HBrY+pr5XYHbmF7x4nBmk29MuLykV2l/SYUaWPuuNdT4mNAOimz
 Lp6WNUBt9vCUiHjwY5mmUxrr0BG+xN15sWQbRcU1JhL6sN6VgS0peHv6BHXvTd0Aoj1Y+ygXghe
 VHpopqWuYSthQVMXTJQPOmgtY809k=
X-Gm-Gg: ASbGncuq+1cDqz0X5YNVw7lJ47EqTCVkn9AOz5bZ4hrqC8voXz7AqmV8U2FF8VO6KuJ
 XDdHdv/sXUCYJBKQgknzLsNPbk5VqnM2kgv5RjGpIrJ1MEmpIAj3mQywKEctfyETN
X-Received: by 2002:aa7:8884:0:b0:72a:bc6a:3a88 with SMTP id
 d2e1a72fcca58-72dafaaf2f2mr49819488b3a.22.1737878198693; 
 Sat, 25 Jan 2025 23:56:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFIOxLnQ7Frmf52ybq4FzvDfS6SV+W4PHntSf78cn9Gbp4mkXLcO8UspPxbyWcTLvRitT0hxA0WVyP0IeZdmKU=
X-Received: by 2002:aa7:8884:0:b0:72a:bc6a:3a88 with SMTP id
 d2e1a72fcca58-72dafaaf2f2mr49819470b3a.22.1737878198219; Sat, 25 Jan 2025
 23:56:38 -0800 (PST)
MIME-Version: 1.0
References: <20250120173339.865681-1-eric.auger@redhat.com>
 <CACGkMEu4oMa8Sf9QXtszeoSMj_67Csr0s7kHdYfbNnJWibu2dA@mail.gmail.com>
 <5a55011a-af8f-483a-99fa-5cb2cdf3841f@redhat.com>
 <CACGkMEv6ec3JLZg6ZedSHdNS5_McX7_xoV4d2MG05x_Y5t=uEA@mail.gmail.com>
 <678babb6-f64a-4db5-ad60-494214a4e673@redhat.com>
 <CACGkMEvyYT7-PTOwO-Jg9a8AHA0AJHoV2BY2RBrJTGKEFYL6QA@mail.gmail.com>
 <25b5bb73-abd8-4008-905d-6c2e9e1330e2@redhat.com>
 <SJ0PR11MB6744EBC0BB7C8CD5F33D0A4E92E32@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <CACGkMEtQT2yZf93+a3LxSCyfBEXbEDu5S2cFXuAhprDYd2-vhw@mail.gmail.com>
 <Z5OvXaUF6sdEQLgW@x1n>
In-Reply-To: <Z5OvXaUF6sdEQLgW@x1n>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 26 Jan 2025 15:56:24 +0800
X-Gm-Features: AWEUYZlizoZHHlo7Q5mCyGe1diDQaV9OuOyd5fF7Lbr202ECVIoo59DiAyGszk8
Message-ID: <CACGkMEtPvUZh-seF1oDLMOOSiJhdHZeywvk6vKZy+jhEY4AjCA@mail.gmail.com>
Subject: Re: [PATCH] hw/virtio/vhost: Disable IOTLB callbacks when IOMMU gets
 disabled
To: Peter Xu <peterx@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, 
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "mst@redhat.com" <mst@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>,
 "lvivier@redhat.com" <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Sat, Jan 25, 2025 at 12:42=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote=
:
>
> Hello, Jason, Eric,
>
> On Fri, Jan 24, 2025 at 11:30:56AM +0800, Jason Wang wrote:
> > It might be because neither virtio bus nor virtio-net provides a
> > shutdown method.
> >
> > There used to be requests to provide those to unbreak the kexec.
> >
> > A quick try might be to provide a .driver.shutdown to
> > virtio_net_driver structure and reset the device there as a start.
>
> I didn't check virtio driver path, but if that's missing it's reasonable =
to
> support it indeed.
>
> OTOH, even with that, vhost can still hit such DMA issue if it's a
> hard-reset, am I right?  IOW, when using QMP command "system-reset".  If =
my
> memory is correct, that's the problem I was working on the VFIO series,
> rather than a clean reboot.  And that won't give guest driver chance to r=
un
> anything, IIUC.

Yes.

>
> I am wildly suspecting a VT-d write to GCMD to disable it can also appear
> if there's a hard reset, then when bootloading the VM the bios (or whatev=
er
> firmware at early stage) may want to make sure the VT-d device is
> completely off by writting to GCMD. But that's a pure guess.. and that ma=
y
> or may not matter much on how we fix this problem.
>
> IOW, I suspect we need to fix both of them,
>
>   (a) for soft-reset, by making sure drivers properly quiesce DMAs
>   proactively when VM gracefully shuts down.
>
>   (b) for hard-reset, by making sure QEMU reset in proper order.
>
> One thing to mention is for problem (b) VFIO used to have an extra
> challenge on !FLR devices, I discussed it in patch 4's comment there.
> Quotting from patch 4 of series:
>
> https://lore.kernel.org/all/20240117091559.144730-1-peterx@redhat.com
>
>      * (1) Device depth-first reset hierachy doesn't yet work for vIOMMUs
>      *     (reference: resettable_cold_reset_fn())
>      *
>      *     Currently, vIOMMU devices are created as normal '-device'
>      *     cmdlines.  It means in many ways it has the same attributes wi=
th
>      *     most of the rest devices, even if the rest devices should
>      *     logically be under control of the vIOMMU unit.
>      *
>      *     One side effect of it is vIOMMU devices will be currently put
>      *     randomly under qdev tree hierarchy, which is the source of
>      *     device reset ordering in current QEMU (depth-first traversal).
>      *     It means vIOMMU now can be reset before some devices.  For ful=
ly
>      *     emulated devices that's not a problem, because the traversal
>      *     holds BQL for the whole process.  However it is a problem if D=
MA
>      *     can happen without BQL, like VFIO, vDPA or remote device proce=
ss.
>      *
>      *     TODO: one ideal solution can be that we make vIOMMU the parent
>      *     of the whole pci host bridge.  Hence vIOMMU can be reset after
>      *     all the devices are reset and quiesced.
>      *
>      * (2) Some devices register its own reset functions
>      *
>      *     Even if above issue solved, if devices register its own reset
>      *     functions for some reason via QEMU reset hooks, vIOMMU can sti=
ll
>      *     be reset before the device. One example is vfio_reset_handler(=
)
>      *     where FLR is not supported on the device.
>      *
>      *     TODO: merge relevant reset functions into the device tree rese=
t
>      *     framework.
>
> So maybe vhost doesn't have problem (2) listed above, and maybe it means
> it's still worthwhile thinking more about problem (1), which is to change
> the QOM tree to provide a correct topology representation when vIOMMU is
> present: so far it should be still a pretty much orphaned object there.. =
if
> QEMU relies on QOM tree topology for reset order, we may need to move it =
to
> the right place sooner or later.

Sounds like a non-trivial task, so for a hard reset, maybe we can
proceed with Eric's proposal to deal with the reset before the device
stops.

Thanks

>
> Thanks,
>
> --
> Peter Xu
>


