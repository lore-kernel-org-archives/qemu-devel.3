Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FCFD74961
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 08:13:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWVbk-0006QM-P0; Fri, 19 Dec 2025 03:13:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vWVbi-0006Q1-BY
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 03:13:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vWVbg-0005LU-Bq
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 03:13:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766131979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mH4SEylnCH6UbDa9blTl8ZdCiihIaIWOrvbFr9UerHo=;
 b=ZkeIczjfmghpga1HZI2FefQw7xAvRySoJcQ+wn68HmIGV02nMj78TmXskxhDMc9NWZpjDJ
 ZDXSCkNaYH0VRbNP3IF7xKvFihj9RDRi9i92VeJiS3qcwBsKd2G/4F/VUr2MHVoxbSWqUe
 Nj79WIxHouDDxgimlNuFz4FIPSAO0EM=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-KH3IHwH5PNWly4OwNR9TyA-1; Fri, 19 Dec 2025 03:12:58 -0500
X-MC-Unique: KH3IHwH5PNWly4OwNR9TyA-1
X-Mimecast-MFC-AGG-ID: KH3IHwH5PNWly4OwNR9TyA_1766131977
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-6445cf02fcbso1761845d50.2
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 00:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766131977; x=1766736777; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mH4SEylnCH6UbDa9blTl8ZdCiihIaIWOrvbFr9UerHo=;
 b=AF5ZA4UvufDh4BbUBRj+S3+7ViADgezdmo/FFtg6PrJTpjdjAx3UUfKe608DTGdaSk
 fGGTwmZsK5C0hleniJ9q0ZhQg/9Z1BnAZdbd3j9/U5kTneGiLBNSAvsD8JLLv6mEq8ge
 eAY4Swo86/zKmn/LUHhPzqXF8YAK4sn8qVXZdtXy2tf2gPnBwhxVtNGbhnIcPIY378yu
 kFNCloAHBt2mRdMU3tPJwdPkMVqWK9Frx+M8Qo0hWcKlLl1Wl20Zmn4KgQsfgwdsDoeo
 KatzdMbeqLm7wRRvRmepdYTlR+EboQqFEfBTI8oWtE4KyZal8HRsUQLCR06UNfarCLcV
 gMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766131977; x=1766736777;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mH4SEylnCH6UbDa9blTl8ZdCiihIaIWOrvbFr9UerHo=;
 b=Ez7xdj0P5vaPbhAp/Y60iPrbo624pp7UbT4sCAV/KgWJPPsfOZf1i7wSrmhOKaT2Ba
 42gMrR8gaav12SF5mCLE5aygsi+bMymKdRf3MY+JekrsFA5X4mdt90mVvINQr3BP/uNB
 pgPrjenly3BJEbpAOLgl4p+BBykffdtDdxoemMv3+FjEahRdhw447+26eZDqK2QJItbM
 /7ohnkEJhXRfUFaT25zHWLS6CtLl4J3vYvvhNvSAfwIVBEUmJjfNO8jqD2uLleAsTHJh
 AuGGoPkjcx371S8zXxq+aPMX3poiRx2gsA9DV1dETsOnMUzSwUEkOXrLkLlMEeKCIV/1
 gbyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXf0cz6oqV51ufhT65qq/wPHqWoKBwi1ATMNaxH6P2IInJJDiFyj6EvNvh0arlU1N12PYhy0E7b7nvp@nongnu.org
X-Gm-Message-State: AOJu0YxkRb5f99IY9a8Q/0DALubRPZ/QbfuxGjggEw1nYzS80O0iC7nv
 wNYQ7ot7hIgT29dQB1tDbKn93eMRbAEdNvJM1Uu3jDCzGpXfzxKd+TPJt09bmNPmMQ3U1HSLemc
 3uplOs9QQ3Xydd05QKHDwJae9DFcjMndKyUT2pXbAay63NUaqOFVIRbd0EVWRqf8H8qYmKgPfdO
 wnvOBwFasTzWzvY6sE1folW5YMy5Zrgyfh7axgcec=
X-Gm-Gg: AY/fxX7P8nSEccfHqfGdy5XYTNTYCIutfjPyTqnCuEeSRjUl3Wl14HyDrQauhlYcNJv
 4AUnAdC581zP38RQoMt8XsYpapo2xBTsX/Nk4JnKxiBGEJAc/nz2wJfkenveFczp4f7drKsrfxL
 4D8SmvnjWxLVfN/fL+wIA88MxZvfKRLBYqJMNrvzaTXqVzsjLuKbhyEMNg6NwdATY/0C4=
X-Received: by 2002:a05:690c:c4ce:b0:78f:bc2b:83f5 with SMTP id
 00721157ae682-78fbc2b8fd3mr5740747b3.20.1766131977214; 
 Fri, 19 Dec 2025 00:12:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsV7tFr4oroeZRI5hlBnlpoAb8TMLcOW//pp7ZHA8+zNJErlMNiRYEX0zbQ5wTkuW56XDgTK5IeB/KG427oDw=
X-Received: by 2002:a05:690c:c4ce:b0:78f:bc2b:83f5 with SMTP id
 00721157ae682-78fbc2b8fd3mr5740437b3.20.1766131976855; Fri, 19 Dec 2025
 00:12:56 -0800 (PST)
MIME-Version: 1.0
References: <20251216015451.6479-1-wafer@jaguarmicro.com>
In-Reply-To: <20251216015451.6479-1-wafer@jaguarmicro.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 19 Dec 2025 09:12:19 +0100
X-Gm-Features: AQt7F2pT-OFeizpmY30rbz6tfx0MujNSdDFWV8tq6lZQYEOw4MY1O82kbviHV1o
Message-ID: <CAJaqyWcB1C=6Eo54pjiokEDfb0=eXYnii9Vc1NyAQxKaCwtGrA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] vhost: add data structure of virtio indirect
 descriptors in SVQ
To: Wafer Xie <wafer@jaguarmicro.com>
Cc: mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, 
 leiyang@redhat.com, sgarzare@redhat.com, angus.chen@jaguarmicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Dec 16, 2025 at 2:55=E2=80=AFAM Wafer Xie <wafer@jaguarmicro.com> w=
rote:
>
> From: wafer Xie <wafer@jaguarmicro.com>
>
> Using multiple statically allocated buffers to store virtio indirect desc=
riptors
>
> Signed-off-by: wafer Xie <wafer@jaguarmicro.com>
> ---
>  hw/virtio/vhost-shadow-virtqueue.h | 46 ++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>
> diff --git a/hw/virtio/vhost-shadow-virtqueue.h b/hw/virtio/vhost-shadow-=
virtqueue.h
> index 9c273739d6..b0f236f049 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.h
> +++ b/hw/virtio/vhost-shadow-virtqueue.h
> @@ -23,6 +23,13 @@ typedef struct SVQDescState {
>       * guest's
>       */
>      unsigned int ndescs;
> +
> +    /*
> +     * Index into the indirect descriptor
> +     * buffer (0 to SVQ_NUM_INDIRECT_BUFS - 1) if using indirect.
> +     * -1 if not using indirect descriptors.
> +     */
> +    int indirect_buf_idx;
>  } SVQDescState;
>
>  typedef struct VhostShadowVirtqueue VhostShadowVirtqueue;
> @@ -46,6 +53,32 @@ typedef struct VhostShadowVirtqueueOps {
>      VirtQueueAvailCallback avail_handler;
>  } VhostShadowVirtqueueOps;
>
> +/**
> + * State of an indirect descriptor buffer
> + */
> +typedef enum SVQIndirectBufState {
> +    SVQ_INDIRECT_BUF_FREED,    /* Buffer is free and can be used */
> +    SVQ_INDIRECT_BUF_FREEING,  /* Buffer is being freed */
> +} SVQIndirectBufState;
> +
> +/**
> + * Pre-allocated indirect descriptor buffer
> + * Each SVQ has two of these buffers for double-buffering

What does the double buffering improve here compared to just doubling the s=
ize?


> + */
> +typedef struct SVQIndirectDescBuf {
> +    vring_desc_t *desc;         /* Descriptor table size =3D num_descs) =
*/
> +    hwaddr iova;                /* IOVA of the descriptor table */
> +    size_t size;                /* Size of the mmap'd region */
> +    SVQIndirectBufState state;  /* Current state of this buffer */
> +    uint16_t num_descs;         /* Total number of descs (N * vring.num)=
 */
> +    uint16_t freed_descs;       /* Number of descriptors available for u=
se */
> +    uint16_t freeing_descs;     /* Number of descs being freed from used=
 ring */
> +    uint16_t freed_head;        /* Next free descriptor index in this bu=
ffer */
> +} SVQIndirectDescBuf;
> +
> +/* Number of indirect descriptor buffers per SVQ for double-buffering */
> +#define SVQ_NUM_INDIRECT_BUFS 2
> +
>  /* Shadow virtqueue to relay notifications */
>  typedef struct VhostShadowVirtqueue {
>      /* Shadow vring */
> @@ -96,6 +129,19 @@ typedef struct VhostShadowVirtqueue {
>      /* Caller callbacks opaque */
>      void *ops_opaque;
>
> +    /*
> +     * Pre-allocated indirect descriptor buffers for double-buffering.
> +     * These are allocated when SVQ starts if VIRTIO_RING_F_INDIRECT_DES=
C
> +     * is negotiated.
> +     */
> +    SVQIndirectDescBuf indirect_bufs[SVQ_NUM_INDIRECT_BUFS];
> +
> +    /* Index of the current active indirect buffer, -1 if not using */
> +    int current_indirect_buf;
> +
> +    /* Whether indirect descriptors are enabled */
> +    bool indirect_enabled;
> +
>      /* Next head to expose to the device */
>      uint16_t shadow_avail_idx;
>
> --
> 2.48.1
>


