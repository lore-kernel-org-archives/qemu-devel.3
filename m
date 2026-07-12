Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5261C43458
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 06:49:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1winzW-00049k-1g; Sun, 12 Jul 2026 02:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1winzS-00044Q-Ev
 for qemu-devel@nongnu.org; Sun, 12 Jul 2026 02:48:38 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1winzQ-0000RD-Jf
 for qemu-devel@nongnu.org; Sun, 12 Jul 2026 02:48:38 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-38dd55ad76cso287073a91.1
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2026 23:48:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783838912; cv=none;
 d=google.com; s=arc-20260327;
 b=E25Cn4schOQ7+YIxa0aEVa5p7WMBEG0vp9TAEtoT+LZuDb9DbWr9Lii5XLNI/lLu1+
 1G6lM8kQcWbOAhBHPtX2QSTRaLtgqKJWYekcFXOy3puoIDcrh15w0TLiimjqukDkct7a
 UlGgOAB0nDUPBAsMVG1VjaBaz5tRiw9t6gnMmFbOIpd9C3Y/pZsX3Oy6VG79VgZGrhbN
 57DXQ408riohm3wu+uVl+DkJwKbyTHqSPIWgWSSAx9Z2qMuZlWifMDIQkIex51XCJAoW
 G9XNwqSq3drn2jT07EnnfRX+3PzOwDtgxIZKlL21I6NEZLrvCsdnKvVrjYAoiJJRpM3Q
 zszw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dNrXjFKm1JIyLtCygBLWhrgpdBc4yLiuyy60NitQUsc=;
 fh=rwZmqa7s1Fb8boq/Mlez7inHGFLBifW8Ivfl2UkKLV8=;
 b=c7CgAfLOdgxjn2+5tQBvjwrf6BxudBqgmgMv1EBxiNYLNL87iHr/vxGAoG9G2CeNch
 uBWT6uKOPwAK3fcDtrB8KZnbGjOdK3bCrppjDdgWU6PdyMfkPpUqNL1VNLystwzCYZ9h
 3mCAq+enwwZHqi8kuauGZZ9CY0kwhRq2tOUpo8vSoMcX35SoHxESEDcRZZ0MoxOfjesE
 wasktYlWvYzTplm9QF6ASs7pe4VBIte+eC2Av78bqZwQWGMBzzIv1agKXd7iUGfkuJg2
 fdhDV2LHlKBT1y7Zle1WzvzKVFmY1KapWVJqU2zQmnq+mxfkpdm322uP7hSHfE/n2YwY
 Kydw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783838912; x=1784443712; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dNrXjFKm1JIyLtCygBLWhrgpdBc4yLiuyy60NitQUsc=;
 b=hevSlzycAI1NeeA1lVI8ZJDiUOgd/fJSGklcGwoFIpukbBZRTFr2zjZ3PHM9wuLS3A
 fMGFlj/ChiH1G8ddQ4acDoyhPl3wKFtLNAAeWDsxLlTIICuLIuxyXYH1iHkCdcynF6rj
 f/kxNc9UJuLbQou7HSjZtVUBdClgOYE8SOUFzVuR8l1I97Qxg+VBjJfyU++eGM6ODENn
 yVumJHQI26tIYtAAjeOncTQ+D2DoWYaggYfEv9Wo+VmJ/aoS51DfHBufYf9hr/5UMwVC
 hd/KXyDUeyHnsA/oAtkEx5nVLec72ksaZ24wQoTcORooJI1BqZxIoAKIYExncOLha9uN
 uSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783838912; x=1784443712;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dNrXjFKm1JIyLtCygBLWhrgpdBc4yLiuyy60NitQUsc=;
 b=FiEwUSYOPn3AwefRIjPB0d3ahgSG18K7I8YYfXCZhb9k2ZeLqkM5n66tSBhljQBKxt
 oeLbFxlao9/ZygKq9YPgUf8Js3yMRhiSEbg651bzHPQVf/7JjKKdjgINaWqtVEP/9lux
 wL5WzED2e0Ng33YLxdVp12lefQIWfPyFHRLg2wRVbnvAPYjjGzPYx2C8557mMM0U5da3
 K4ZlPs1V+Ipq6xAvP8foNnTWkl4T3BS28aFm40Sw6HYCe/3QrKFi1N4Nip8JDM0WZudU
 W/tScT/o1dlZRcB4+K21Vzcw0pFxDfSDhPKyj9ge3ApWIvYHjLJjfcjDuil5DNyTY755
 E/4g==
X-Gm-Message-State: AOJu0YxND2qvY0+SWju+4AZZOB2mkSlWuXPddw5tMZopsB12I3pQ2uab
 +63cJcUf6H67uSmhkF+QbWXTRHRliDb6ANVD1Z5Nzaca7PM98dQsPagU+EAZAzkojhj/0Qr5A/L
 PrwLE1qT0ccEClqqVFXC2hG9/IqiRasY=
X-Gm-Gg: AfdE7clgcUy96QvAElbcktx4F6kzTeCw0EHPTX8zt5f2rePEIv7EaDp+0CsBnvgeYc9
 BjAH3S112gG/+1q9TTiaGQCzjN8CyLNX8fS9d/CytAYnt8pyMWS75VOoKPMV0Iv4Usu6B5wa9ZV
 5qPcvHWBTPEnfebR5mv3vWZvuTgh+7Qbt3A4kunYqfTDODhduw2/PN7brULIlI6EC4wdGQHxSlv
 N4Iv8NPwVRjsfTiIqERpsCEg35eKzGr4YkQorvfFNj8XddGPuPjVDFg0ClUeCEVueIZZ2TUYYtD
 ckrRT/vLpxScC5UaqHfXNo5rtmnT
X-Received: by 2002:a17:90b:2d8b:b0:380:ce69:2669 with SMTP id
 98e67ed59e1d1-38d13f80310mr10819893a91.9.1783838912071; Sat, 11 Jul 2026
 23:48:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260710134720.2317856-1-marcandre.lureau@redhat.com>
 <5df23403-6da0-4431-be8a-a74c82298894@oss.qualcomm.com>
In-Reply-To: <5df23403-6da0-4431-be8a-a74c82298894@oss.qualcomm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sun, 12 Jul 2026 10:48:18 +0400
X-Gm-Features: AUfX_mxZVhwX--XhYHLN67KzSZSroY2NUd3T9HqiSXaW3UW9Ic6UpTR2Lm0rw_g
Message-ID: <CAJ+F1C+yCx72e9AE6Vz-2a3cz+GqN-ovvFcSBXdDvyiEh5u8Qg@mail.gmail.com>
Subject: Re: [PATCH] vhost-user-gpu: fix integer overflow in buffer allocation
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi

On Fri, Jul 10, 2026 at 7:35=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 10/7/26 15:47, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > A malicious guest can trigger a heap buffer overflow in the
> > vhost-user-gpu backend by sending a VIRTIO_GPU_CMD_RESOURCE_CREATE_2D
> > with large width and height values (e.g. 65537x65537). The allocation
> > size width * height * 4 silently wraps in uint32_t arithmetic,
> > resulting in a much smaller allocation than expected. Subsequent
> > VIRTIO_GPU_CMD_TRANSFER_TO_HOST_2D writes past the heap buffer.
> >
> > The in-tree virtio-gpu device (hw/display/virtio-gpu.c) already handles
> > this via calc_image_hostmem() with uint64_t arithmetic and an overflow
> > check. Apply the same approach to the vhost-user-gpu contrib backend:
> >
> > - Add an overflow check in vugbm_buffer_create() rejecting dimensions
> >    where width * height * 4 exceeds UINT32_MAX
> > - Promote the size arithmetic to uint64_t in mem_alloc_bo() and
> >    udmabuf_get_size()
> > - Check the return value of vugbm_buffer_create() in
> >    vg_resource_create_2d(), which was previously ignored
> >
> > Fixes: CVE-2026-15264
> > Reported-by: "Vulnerability Report" <vr@darknavy.com>
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3940
> > Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
> > ---
> >   contrib/vhost-user-gpu/vhost-user-gpu.c |  8 +++++++-
> >   contrib/vhost-user-gpu/vugbm.c          | 11 +++++++++--
> >   2 files changed, 16 insertions(+), 3 deletions(-)
>
>
> > diff --git a/contrib/vhost-user-gpu/vugbm.c b/contrib/vhost-user-gpu/vu=
gbm.c
> > index 503d0a4566f..710d5452977 100644
> > --- a/contrib/vhost-user-gpu/vugbm.c
> > +++ b/contrib/vhost-user-gpu/vugbm.c
> > @@ -13,7 +13,7 @@
> >   static bool
> >   mem_alloc_bo(struct vugbm_buffer *buf)
> >   {
> > -    buf->mmap =3D g_malloc(buf->width * buf->height * 4);
> > +    buf->mmap =3D g_malloc((uint64_t)buf->width * buf->height * 4);
>
> Just curious, would this also work safely?
>
>         buf->mmap =3D g_malloc_n(4, buf->width * buf->height);
>
> The GLib description is:
>
>    This function is similar to g_malloc(),
>    allocating (n_blocks * n_block_bytes) bytes,
>    but care is taken to detect possible overflow
>    during multiplication.

Yes, that would be similar.

thanks

