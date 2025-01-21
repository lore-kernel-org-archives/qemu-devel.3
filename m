Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 970DAC02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 03:28:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ta4vv-0001zZ-Jl; Mon, 20 Jan 2025 22:28:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ta4vt-0001zR-W7
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 22:28:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ta4vs-0001Zh-2I
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 22:28:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737430081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NAKdcEyZwGs2e7oQA6I4ehKrZroZNx6wPB19Ars03Pg=;
 b=DRNbzuq8EvKV7+epRhFXux8NRtd0yWaedgdHRN903RROuErAITDL2yQYEtIni63CPP3/rK
 HWCrhwI968jUb2bz0wHTA3a6J3amW0v/9R5Q7ctWNXUCeFOFI1/nAJccNBGdr93/uPwbJm
 hcwEzgPo+xGaXP9kjrTji0SBjVR/Ovk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-k7Jm0bo-PqeviEp-RmkXKA-1; Mon, 20 Jan 2025 22:27:59 -0500
X-MC-Unique: k7Jm0bo-PqeviEp-RmkXKA-1
X-Mimecast-MFC-AGG-ID: k7Jm0bo-PqeviEp-RmkXKA
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2ef114d8346so9234989a91.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2025 19:27:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737430078; x=1738034878;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NAKdcEyZwGs2e7oQA6I4ehKrZroZNx6wPB19Ars03Pg=;
 b=NV9bIWs6zrZ7mEpMeiMsLKSzgcy/Y1E2qIOdVI1ofqiXCmkO4ZNTBHk8ZS8HW6sw/v
 M8pBCg7sJZUfiWshhbS5bpKWuvKwt0WAXp4NdyjIm48541lWeqn3aXfjRM50HPBOuBfL
 PAZpH60Q8cvovL7Ke98eRACqhEKHy52iMZHkJoZkeyXbfEqNTch5I9WmDOlo7FHWelDF
 f2p3DoBZSlGfw2GG7bVFVdb/ScTHSycBISpOp1mB7Tty1qqTc+/7J8PvSlxQYjMjVJ2F
 fIyj1vM/+1GvOrIongcTNaUVHMPQRiZk8M6nb3svNI1UUXQZxtAxKPYacALb5yCu+Sd1
 ToSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3GoXrncFEvtUwQI1eCPUH2UrG5Hqv76qJ9m7lmzzEjmVCMGSG+KXH3qsgtgXQpteyTXPOxWx/dVW5@nongnu.org
X-Gm-Message-State: AOJu0YwbB37nbjZGi/KXJFX1jfHI/RFKGrVd89x3dRUvrdui6CvFUgUa
 5cMjvi+VBfMNaiAP67f7qrv1CQHPe56tKE22/Wt9hnSrtNUPXaFm8jioAr3iSm5c3TzIy9+WS48
 wVNGHIWjEajmDggUZZ26PEQ/mMVZ5cmCp1lZR5Y9sDy6n0gv0ZG2c0/wK9fgpnIXsjNo2OlMo1M
 d/1J3E1DeVnkZ0vCkb9gdUyQtGo2Q=
X-Gm-Gg: ASbGnctLoh8/fimR0MUNmdI6140oJMyxlM9q4REE06t86g7M0nyKHjD09IMPIphpykQ
 iMI051K2mHmShVpqcMAsw+XHbPTi2VNPpNLN3ocPQEW3UGN81odZz
X-Received: by 2002:a17:90b:2e0b:b0:2ef:3192:d280 with SMTP id
 98e67ed59e1d1-2f782c65731mr19519842a91.5.1737430078675; 
 Mon, 20 Jan 2025 19:27:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEl8jq4mFYFmtDIntn2UDwjs/jbXeunp98RNAfGTcAQqUycpqjzs1G2nmz6G0IQpHj7zFzUYUSTn6V5sPeYh0w=
X-Received: by 2002:a17:90b:2e0b:b0:2ef:3192:d280 with SMTP id
 98e67ed59e1d1-2f782c65731mr19519819a91.5.1737430078241; Mon, 20 Jan 2025
 19:27:58 -0800 (PST)
MIME-Version: 1.0
References: <20250120173339.865681-1-eric.auger@redhat.com>
In-Reply-To: <20250120173339.865681-1-eric.auger@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 21 Jan 2025 11:27:46 +0800
X-Gm-Features: AbW1kvbdQcbnjg1Wr9wU6aVY4hCNXIu6k9Td11G3UHCKK6pBaAySLIaG4j_J8Y0
Message-ID: <CACGkMEu4oMa8Sf9QXtszeoSMj_67Csr0s7kHdYfbNnJWibu2dA@mail.gmail.com>
Subject: Re: [PATCH] hw/virtio/vhost: Disable IOTLB callbacks when IOMMU gets
 disabled
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, mst@redhat.com, 
 sgarzare@redhat.com, lvivier@redhat.com, zhenzhong.duan@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.036,
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

On Tue, Jan 21, 2025 at 1:33=E2=80=AFAM Eric Auger <eric.auger@redhat.com> =
wrote:
>
> When a guest exposed with a vhost device and protected by an
> intel IOMMU gets rebooted, we sometimes observe a spurious warning:
>
> Fail to lookup the translated address ffffe000
>
> We observe that the IOMMU gets disabled through a write to the global
> command register (CMAR_GCMD.TE) before the vhost device gets stopped.
> When this warning happens it can be observed an inflight IOTLB
> miss occurs after the IOMMU disable and before the vhost stop. In
> that case a flat translation occurs and the check in
> vhost_memory_region_lookup() fails.
>
> Let's disable the IOTLB callbacks when all IOMMU MRs have been
> unregistered.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/virtio/vhost.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 6aa72fd434..128c2ab094 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -931,6 +931,10 @@ static void vhost_iommu_region_del(MemoryListener *l=
istener,
>              break;
>          }
>      }
> +    if (QLIST_EMPTY(&dev->iommu_list) &&
> +        dev->vhost_ops->vhost_set_iotlb_callback) {
> +        dev->vhost_ops->vhost_set_iotlb_callback(dev, false);
> +    }

So the current code assumes:

1) IOMMU is enabled before vhost starts
2) IOMMU is disabled after vhost stops

This patch seems to fix 2) but not 1). Do we need to deal with the
IOMMU enabled after vhost starts?

Thanks

>  }
>
>  void vhost_toggle_device_iotlb(VirtIODevice *vdev)
> --
> 2.47.1
>


