Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F42C5DF7A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 11:49:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvvq3-0001am-HX; Mon, 17 Aug 2026 07:49:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1wvvq2-0001aX-Dn
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 07:49:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1wvvq0-0007G0-Kp
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 07:49:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786967347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/L8FuxJthd7qhw1MpQhyy8aS7y5puImrRhOyNeoD9Zc=;
 b=f7xgPElmfmxGLTmQSD4FrNPlOw8yX7AcL0HCIakFHnadgl5A0ysm3UL1w/kap90LFgzCV6
 +2yZ2385W7GnWb4do5mXXZNs+lvUjKieVHlhuEXpb5mrm13RMJgcEEZyT/ewsHjMkfhbvd
 FAYrS/boGMkMIEiPgeovxj7LaLx4h2I=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-7G-kIiagOsqCzfDSv0EE6A-1; Mon, 17 Aug 2026 07:49:05 -0400
X-MC-Unique: 7G-kIiagOsqCzfDSv0EE6A-1
X-Mimecast-MFC-AGG-ID: 7G-kIiagOsqCzfDSv0EE6A_1786967345
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-81e71be771cso47136357b3.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 04:49:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786967345; cv=none;
 d=google.com; s=arc-20260327;
 b=bRBGDaSErFO11hM+N5ny+BPcPbj94FbY52cSsqIrfXZ4/H0tF6ABpOaSYMExRC/FVf
 TT4dSDaqaVS4zl6kGgt+eGjkk1Z8cafUqHMgvV/NS9XstkdINu+ocDyLKQGeYzw0Et6o
 DhCtlnf7OG2kmpS1EwZDzvLeV25HMul2JBplcSsnHABaiYWg+OxpV23Un18zvMqTOYqX
 n3b/mTKWCoHT7911cFJ+a5YS9H91l2dY/jQjODilz++igULti2jfXvxVnKH6ew2JdjN1
 DB+2dZ8u4JexuFxKriegOoQcMm9ydN56e2zCZ2nwDhttfJSxp2kbQcDl1kHCobDrMqhV
 SZFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/L8FuxJthd7qhw1MpQhyy8aS7y5puImrRhOyNeoD9Zc=;
 fh=FDdpQT0fD5+LDK547S6ytf1b8koo8D7Bbrx2yG0s3lw=;
 b=YODNzlKWEGGiY2ftW3f5yOJMNgtMNO/FNZFkpm27z5frVijX+9Hb+F69gjToucQf0w
 ZeJrRWzopNmOCAKmQ++0Kq9lXbJhlQOzQzkJJCTUXT/eAVRg1EEKNRsKrUHa4eV2ESG9
 Qc0Oe9yndZvXSJB2n5P6dZNb08PEYNj+ulayboOeTd3oBr6WrUhMqT3g3chzxL/ZFq0c
 FB/CDXiOD5VTHRrHKaFQxpUvXRowtZVdtaLgLGflSARY8ERhWW0q5xgka6Je/pOqsCds
 8bEE1qkPXb5alQmMM+Mu55uEr2t24MtvHQpVKGZed3CgCGxzO7i/Yj0wCKncugKEmtzE
 Dpow==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786967345; x=1787572145; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/L8FuxJthd7qhw1MpQhyy8aS7y5puImrRhOyNeoD9Zc=;
 b=Dzcj0TLrRWK76YuMt8jUI+O1kImjjnewihbzqiErUmHy9N4AijHBnzKuqnqNxg0RQa
 dhqulU0bMdEYxkiPnrru293IPvYpoudLLoFXPfhKklwt16/IXLv5aOj0oJ7SYvU0uuGY
 qBZx2vlR81oTthBwkwPTrgBTIx5VeQBezyX6BgYf3S3KDrvhtdhtuEvhLMrcp9WCcbzS
 49Ug3kmFoCnsXeXzwyW4K2jChecuwwphHdCkUT4joenTIA5DVbM2qbcRzFnpxUbL61Q8
 hRu7xN2GmnKZZsVGk/PNYK2tFka4B9EbJayy7/yZ9a3zd+MapgsSBFQcmu2/GLX9tBnd
 1nCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786967345; x=1787572145;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/L8FuxJthd7qhw1MpQhyy8aS7y5puImrRhOyNeoD9Zc=;
 b=kv7sG4iiRKlTyBUipqOSmQ1VOrkID+q9AF6wk2i/YjwDsKT4IbqOFiC19Kk7Ica51S
 i6v5ENzoHiXqLF0lB8IUtIShLUz54yNV0eVJWUALqdYtP0AjzhT0Fu5t83Niz4TZC7Vk
 4VmzXkd5gtBocqSCiBIFy4v6bHnreXzNwQq6Q0nTHrakaLvJMeu8baMhTZ9sgoQoq+fd
 WUbrKOc26b1x14/hBHxFwl33wUrdp52Zn9pcLEPRFFlwsAy54soj99uDCo5vZ32SQ4wQ
 omMZammgtICGrNwWxXQAIWdksMXprWkkLlC1uTP7V5vNj0MOkV2d4w8j8lWazpBDrvrX
 PQSg==
X-Gm-Message-State: AOJu0Yz68LMbyTg4XHg5k7Rm9jRFA0C0Wn/qraiTuW6eeYfiNzEYY9X3
 NiWCLAmyV6HJx1ODdh5J+g3CA0XdNdBiU9yn1bQb3xMti9+YTmOmEetfed26zb0rkE/QcvTqagZ
 9HcHQ/nRk4NAQHEEQTIpd5IYiLyairW6jCE9cyqYIV6jR49dFRCng2XCXuRlnlDxx+oHyYjLKZg
 /YSHfPFnOOKHxS2TZtHZLJb2zuXQhwtO8=
X-Gm-Gg: AR+sD13TA/3KVSoL3u2aXkfzgpQIJQPPasYY3g78QFZKaGjd7Bb28bcFelFyh8raZ8t
 uAXXcvpeN4ekpzVCTAgfMCUgQFjfpT1GfteHHXfIKGMcZf8Cee1ds1mrLqKoyaAG2VB7BcMLfa+
 ZUooju7WZaxdxWRI7AHCKMvItPlcW0gfj61MYeGEy3xObA8kLxGAmWp+U=
X-Received: by 2002:a05:690c:113:b0:826:f78b:8462 with SMTP id
 00721157ae682-834840ed024mr115339827b3.7.1786967345169; 
 Mon, 17 Aug 2026 04:49:05 -0700 (PDT)
X-Received: by 2002:a05:690c:113:b0:826:f78b:8462 with SMTP id
 00721157ae682-834840ed024mr115339707b3.7.1786967344704; Mon, 17 Aug 2026
 04:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <HXrBMZ9Gx9L-VxdMEr26ORPUYQn99p4rgEYVkeMHA4-5M49Ax3_mx1euIWe7uj33nl5mZ19sZeUDyksqxKT7H1WPxWhYtxdomofcVTyMTjo=@proton.me>
In-Reply-To: <HXrBMZ9Gx9L-VxdMEr26ORPUYQn99p4rgEYVkeMHA4-5M49Ax3_mx1euIWe7uj33nl5mZ19sZeUDyksqxKT7H1WPxWhYtxdomofcVTyMTjo=@proton.me>
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 17 Aug 2026 13:48:53 +0200
X-Gm-Features: AcwNN1XDIH2EuVvFdoL1NYQwl7HbVtvJnMvOekLc2gIT_NvxhT7DQ0SIiU8mxJU
Message-ID: <CADSE00Kgb2iLPA+wjAJy9EU7GwxKvD6czmoV_Fn6TD3wZ8hpQg@mail.gmail.com>
Subject: Re: [PATCH v3] vhost-user: Reject SHMEM_MAP when no KVM memory slot
 is left
To: Feifan Qian <bea1e@proton.me>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Aug 15, 2026 at 6:15=E2=80=AFAM Feifan Qian <bea1e@proton.me> wrote=
:
>
> Each SHMEM_MAP request creates a separate RAM MemoryRegion that
> consumes a KVM memory slot. Once all KVM slots are in use, processing
> another SHMEM_MAP request would make the KVM memory listener fail while
> registering the new region.
>
> Shared memory mappings are filtered out of the vhost memory table
> (vhost_section() skips TYPE_VIRTIO_SHARED_MEMORY_MAPPING regions), so
> they never count against the negotiated vhost-user slot limit; only
> the KVM slot budget applies. Reject the request with ENOSPC before
> changing the memory topology when KVM has no free slot left.
>
> Also validate each vhost memory table against the slot limit negotiated
> with the backend before sending regions via SET_MEM_TABLE or
> ADD_MEM_REG.
>
> Fixes: b52e1896e764 ("vhost-user: Add VirtIO Shared Memory map request")
> Signed-off-by: Feifan Qian <bea1e@proton.me>
> ---
> Based-on: <20260717134920.265128-1-dbassey@redhat.com>
> ("vhost-user-gpu: Add blob resource and shared memory support" v4,
> which filters TYPE_VIRTIO_SHARED_MEMORY_MAPPING regions out of
> vhost_section())

Reviewed-by: Albert Esteve <aesteve@redhat.com>

Thanks!

>
> v3:
> - Rebased on Dorinda's series as suggested by Albert.
> - SHMEM_MAP path now checks kvm_get_free_memslots() only; shmem
>   mappings no longer reach SET_MEM_TABLE/ADD_MEM_REG, so the precheck
>   no longer calls vhost_get_free_memslots() or uses reserved_memslots.
> - Kept the set_mem_table check as a safety net for ADD_MEM_REG.
>
> Tested with an ASan/UBSan x86_64 build on top of the base series.
> qtest-x86_64/qos-test passed all 141 subtests.
>
>  hw/virtio/vhost-user.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index fac02a1ffc..f737a05d07 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -1126,6 +1126,13 @@ static int vhost_user_set_mem_table(struct vhost_d=
ev *dev,
>              dev, VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS);
>      int ret;
>
> +    if (mem->nregions > u->user->memory_slots) {
> +        error_report("vhost-user memory table has %u regions, "
> +                     "but the backend supports only %d",
> +                     mem->nregions, u->user->memory_slots);
> +        return -ENOSPC;
> +    }
> +
>      if (do_postcopy) {
>          /*
>           * Postcopy has enough differences that it's best done in it's o=
wn
> @@ -1980,6 +1987,17 @@ vhost_user_backend_handle_shmem_map(struct vhost_d=
ev *dev,
>          }
>      }
>
> +    /*
> +     * Each SHMEM mapping becomes a separate RAM MemoryRegion and thus
> +     * consumes a KVM memory slot. Reject the request before changing th=
e
> +     * memory topology if no slot is left.
> +     */
> +    if (kvm_enabled() && !kvm_get_free_memslots()) {
> +        error_report("No free KVM memory slots for shared memory mapping=
");
> +        ret =3D -ENOSPC;
> +        goto send_reply;
> +    }
> +
>      /* Create VirtioSharedMemoryMapping object */
>      VirtioSharedMemoryMapping *mapping =3D virtio_shared_memory_mapping_=
new(
>          vu_mmap->shmid, fd, vu_mmap->fd_offset, vu_mmap->shm_offset,
> --
> 2.43.0
>


