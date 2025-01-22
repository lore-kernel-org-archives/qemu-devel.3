Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 063A3C02182
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 07:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taUzd-0005fa-CB; Wed, 22 Jan 2025 02:17:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1taUzb-0005f4-MF
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 02:17:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1taUzZ-00017y-Sa
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 02:17:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737530255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MoYDSAMUTvoBAwTCnub9sdDD9rfclbk7AnEsrKpbJpU=;
 b=BPtgVwnzAZIiGYsnV2da4kcitXUaLJf79q97IISBSrkQ8pdcPd6fHLvmNF8lLYWvKzUR0y
 hQFdOgQS540l7GVvWcEnAdiJuRRDuxi2UGZK290q4+tkWHUvnGCljnhjOGUNKeQfZ6ng2q
 61xPvUOH6QSK0wyaBvdsU4tmyjpgiUw=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-0SFZ4OzOO9CRp9CSQNpHLw-1; Wed, 22 Jan 2025 02:17:33 -0500
X-MC-Unique: 0SFZ4OzOO9CRp9CSQNpHLw-1
X-Mimecast-MFC-AGG-ID: 0SFZ4OzOO9CRp9CSQNpHLw
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2ef909597d9so18113611a91.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 23:17:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737530252; x=1738135052;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MoYDSAMUTvoBAwTCnub9sdDD9rfclbk7AnEsrKpbJpU=;
 b=U6SIoY5/w0CqESzyuER9bXf+h5wkTCpMFKshmlXHeBLTY8lPKOmtrlMigy9dms0Nk8
 rYQdlg8Q8BP0ua/h66L1karbsu6tfiMOLTrMmJQWoj6CXAZiDlscA9AQ/PtQqLcJpEFp
 bLptzAz3E+xgf//ugIGok27uAN9hF20F0UH9jUCoz2858wkE0vj/sGPQfYtPselPgjKz
 sXK/jJdRz2CDgJKMx9TkjU5UoEaxBIMaZK/4lQ8ui3QvIV7vIAa1T5KYkPIUOlCEi4zb
 OOMwJQyu5NxRV0pdnMlCltnzO5w+Dp63aO/glGM/sT74gHxDfUvJ6yh+6CX2MM1Rsjd0
 VVGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5euZccaTowF8Jr25mfik8UoQFn+F9VTIKnKuAz5582qrKNRLJeDJQBreZzGUwkb/9xAwRRCVsfWG+@nongnu.org
X-Gm-Message-State: AOJu0YzbNXCwTecDPYjYOVDDtb2CcOzINI9kntQmPWWiShFmFrAo6LvB
 EdKIQUgyoe5fQv/oHQUCGsmiKuJF8nWPHnkcNJDgc03qJMmBspRM9iwpm4Lap8Bl9RPDIseUEn+
 oPFt26Zod/6kqj1XJE/dsNfDWdTKKnEhMYTGcC27axJwyDbqIffXUKUCy/Wb/CB1nTwq/HtcI2F
 J0NOXGZXkBVE/LYMI83ZF9sro5Flc=
X-Gm-Gg: ASbGnctRO4ZcWV0J1PRF8v8XLqE4RK9VqVq9tniI91xuVd9760TJu8bvrCNwe3RDVdB
 0S669bMhJsyZbAQGZFk0KUK6yHNdMY5ReTso79R3xys9DF2nHDINs
X-Received: by 2002:a05:6a00:989:b0:71d:f4ef:6b3a with SMTP id
 d2e1a72fcca58-72dafba3219mr28293968b3a.21.1737530252504; 
 Tue, 21 Jan 2025 23:17:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMnJBVPh9DVRTj3Imlr+vDbBQ8nlMHrVI40oO/6b5ZwMp0ReBfRxr6InjoYqQRGNq2atgI9SWMu3wEqCuvDco=
X-Received: by 2002:a05:6a00:989:b0:71d:f4ef:6b3a with SMTP id
 d2e1a72fcca58-72dafba3219mr28293943b3a.21.1737530252105; Tue, 21 Jan 2025
 23:17:32 -0800 (PST)
MIME-Version: 1.0
References: <20250120173339.865681-1-eric.auger@redhat.com>
 <CACGkMEu4oMa8Sf9QXtszeoSMj_67Csr0s7kHdYfbNnJWibu2dA@mail.gmail.com>
 <5a55011a-af8f-483a-99fa-5cb2cdf3841f@redhat.com>
In-Reply-To: <5a55011a-af8f-483a-99fa-5cb2cdf3841f@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 22 Jan 2025 15:17:21 +0800
X-Gm-Features: AbW1kvZwQ1nIiCsrgUuzH5GgyB4o9Bj0OsjqaM7L1-FkqqWGjXOhr4vG0FO-ew8
Message-ID: <CACGkMEv6ec3JLZg6ZedSHdNS5_McX7_xoV4d2MG05x_Y5t=uEA@mail.gmail.com>
Subject: Re: [PATCH] hw/virtio/vhost: Disable IOTLB callbacks when IOMMU gets
 disabled
To: eric.auger@redhat.com
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, mst@redhat.com, 
 sgarzare@redhat.com, lvivier@redhat.com, zhenzhong.duan@intel.com
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

On Wed, Jan 22, 2025 at 12:25=E2=80=AFAM Eric Auger <eric.auger@redhat.com>=
 wrote:
>
>
> Hi Jason,
>
> On 1/21/25 4:27 AM, Jason Wang wrote:
> > On Tue, Jan 21, 2025 at 1:33=E2=80=AFAM Eric Auger <eric.auger@redhat.c=
om> wrote:
> >> When a guest exposed with a vhost device and protected by an
> >> intel IOMMU gets rebooted, we sometimes observe a spurious warning:
> >>
> >> Fail to lookup the translated address ffffe000
> >>
> >> We observe that the IOMMU gets disabled through a write to the global
> >> command register (CMAR_GCMD.TE) before the vhost device gets stopped.
> >> When this warning happens it can be observed an inflight IOTLB
> >> miss occurs after the IOMMU disable and before the vhost stop. In
> >> that case a flat translation occurs and the check in
> >> vhost_memory_region_lookup() fails.
> >>
> >> Let's disable the IOTLB callbacks when all IOMMU MRs have been
> >> unregistered.
> >>
> >> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >> ---
> >>  hw/virtio/vhost.c | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> >> index 6aa72fd434..128c2ab094 100644
> >> --- a/hw/virtio/vhost.c
> >> +++ b/hw/virtio/vhost.c
> >> @@ -931,6 +931,10 @@ static void vhost_iommu_region_del(MemoryListener=
 *listener,
> >>              break;
> >>          }
> >>      }
> >> +    if (QLIST_EMPTY(&dev->iommu_list) &&
> >> +        dev->vhost_ops->vhost_set_iotlb_callback) {
> >> +        dev->vhost_ops->vhost_set_iotlb_callback(dev, false);
> >> +    }
> > So the current code assumes:
> >
> > 1) IOMMU is enabled before vhost starts
> > 2) IOMMU is disabled after vhost stops
> >
> > This patch seems to fix 2) but not 1). Do we need to deal with the
> > IOMMU enabled after vhost starts?
>
> sorry I initially misunderstood the above comment. Indeed in the reboot
> case assumption 2) happens to be wrong. However what I currently do is:
> stop listening to iotlb miss requests from the kernel because my
> understanding is those requests are just spurious ones, generate
> warnings and we do not care since we are rebooting the system.
>
> However I do not claim this could handle the case where the IOMMU MR
> would be turned off and then turned on. I think in that case we should
> also flush the kernel IOTLB and this is not taken care of in this patch.
> Is it a relevant use case?

Not sure.

>
> wrt removing assumption 1) and allow IOMMU enabled after vhost start. Is
> that a valid use case as the virtio driver is using the dma api?

It should not be but we can't assume the behaviour of the guest. It
could be buggy or even malicious.

Btw, we had the following codes while handling te:

/* Handle Translation Enable/Disable */
static void vtd_handle_gcmd_te(IntelIOMMUState *s, bool en)
{
    if (s->dmar_enabled =3D=3D en) {
        return;
    }

    trace_vtd_dmar_enable(en);

...

    vtd_reset_caches(s);
    vtd_address_space_refresh_all(s);
}

vtd_address_space_refresh_all() will basically disable the iommu
memory region. It looks not sufficient to trigger the region_del
callback, maybe we should delete the region or introduce listener
callback?

Thanks

>
> Eric
>
>
> >
> > Thanks
> >
> >>  }
> >>
> >>  void vhost_toggle_device_iotlb(VirtIODevice *vdev)
> >> --
> >> 2.47.1
> >>
>


