Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B49C5516D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 20:03:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpWyR-0002sW-98; Thu, 30 Jul 2026 16:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wpWyH-0002mH-17
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 16:03:13 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wpWyF-0000Gk-JA
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 16:03:12 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c1c4c7ddaf6so20411266b.3
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 13:03:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785441790; cv=none;
 d=google.com; s=arc-20260327;
 b=YYXyGWXkw/lVxLWThCsCrrWg/9T0l0FwEzOMRKYNHv4WuXmkYWcihe2HEml0kAQToy
 RccwNLhJmX+GYAaK34EhEIemCS7Sg7RgoMxH+6ThzTa+pUPiPSnKqKhh7gzUg9trbWUu
 VHk10D8VEvxRKWpHF/tvNxueuTE5CKInuQRpoZJ0uHRHhsLCeFDmKjva2gJTKROoMBza
 RpHpqI5U3yD0xj5SOdcHmpr/TRcwtQvCiEuXfcOoFB+Ltl7MmFRaqfDKtLQVooNWX9mH
 YCrXLC2FpfesQEpGhBFVExn8ODOGxytqRsd5zZCfRrKYSS84ciPo37XRZQdrmmeIecvj
 pQiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hwJSCqh+t35PmmhWCZfKJy/967KpiYv85ab0iTHIU3w=;
 fh=ZZZ1F3XP1CzKJQYqI6aEhVkOyjjcbpUDD/w/57abD1M=;
 b=eZ5wRUXw0MA/vkpOt1QMz0PlXizyANth5yZhHnrC2aJvzLRZFT626iSXP1LArNVtXZ
 BiRRnViIE/gSsGpdYAVCx4Xv0n8u2UHV54n5XreCXKYCkHmeIwGyX0h8FYC8U0QVc1y3
 DM1P2AGozU1zRvZg4jrCLfDUc04kA+wKdcB8vZupHOt+EtSFpO8YfTMP0yUq2qwzmQJV
 WcuJkA2Q61dGRW53uNJr7JJL9bm3rtDCPorDAfi2qxBZ0kJiAOmlBOQZku6UZG/QskBH
 p7l0QwsVG39uZAcUxZshjoHyl2NO1rF7BGneUV077Acad/LOMPW662CwKfrqQnrhcnjM
 d3Lg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785441790; x=1786046590; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hwJSCqh+t35PmmhWCZfKJy/967KpiYv85ab0iTHIU3w=;
 b=k2fDf90Jr0yHMGJSEfFlDyoiDAydyFxW4APV9gSKt0ZCczWqjWWWEdDlsbIpgv21V/
 w44NAermH3TYamqpK8V3zWDmZq3sE9KSdlS24BfhXeCNdc0oCN6fQ80But52QmzUQYcf
 p2IuTYeOBGgkZKXbXBuWdVglRQx/4upaXAl27vwGkPnlS/ndCQTPjt/Igog59ISiI/wJ
 nqu4+as2ImlZpVgejQuU6dYExHulo7ajF+hVLm/8sExyy6c3GsYwQqAzjyacDiHKTRCS
 sxB8+fOOmQCaP36P/WfNlzt+sdaF1Qq6hWAKKtkS8+3e3Y67vPF+VwW/Qq5HpFBBRrms
 2RnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785441790; x=1786046590;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hwJSCqh+t35PmmhWCZfKJy/967KpiYv85ab0iTHIU3w=;
 b=hupfEkImtd1eXSFAw61arj5i6lAwNVdxds0HVHELBkU+j9oh1liM6YEH3HnNZE2PBC
 hHnksRKvG3w0pFlnUCQiLMl3OmAhYlJX2vgtVtKXsBqZCCLFzAyO9B+9+L841EwUp5y9
 NoS8eNToeWRe2wAbXNiDLRUbLWrZpQJ9aQiWfN22F9EI+LdyA9WQ38dPWrfuNify5R0Y
 raED7xgtEBru82LrY3w/YTBfdeV8/RDXZITk34pFF9Jo9gmQvWHPLqmHTakVVPAp+IUd
 KSsytWkvX3/bSRdsEk9G4z2GpmgTnJsaLkrhJ+nTPi7aKC2wEC+NLAbgW0uDavxWG2N9
 wGDw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrBTs9ipjFc3OKA/exaW4Ux22K6RmHc9bpLH8C6oSV7ZGAOmlxIsx6UmpomRcMzN+hY3eMS/J3JRFny@nongnu.org
X-Gm-Message-State: AOJu0Yy1gpT2B9vLWNN97yMzmwL6ZEIAk4Y8kE71NTLCcJ1q2kJSz81i
 RaxtVJBEyJn/GkNTADyRSXWt4bYZwOwsUUdbCc2a2/Ut2yHehXsyNosbvIqe0FIzZky1rELF+Re
 cyowl/KarPUAgqN2zy1t6RzhzT5gfMKM=
X-Gm-Gg: AR+sD11yXgVs7/NAtN8Wx5yAmx0+bhgYpdrTQZ6Yq3knf4gqrL3zP+JcGVslu32UAcQ
 R5xjQKd6RE0y3vEe/CQeyzeJwNXMD7wkUNjZ/kFbHi2BwEbelXSmvvY4cOcIT2OlXeK876IzoNZ
 6jILDsI13L616M5Yt6ifFmHujn3GiViMrsrDcV9kaqD6tyJwvcl9f0Qfue9DxCbZEU4pKZLlkwL
 XzLpeDC8hNoYxyk5iWj55pGe0mQejyAZ8dFWaynJv10Lq//5eQa80msNT+/pEOkFzwn3/m3Dj8L
 Ey8gQpiKu3+GC/OGwOaLm5MKVzw6I7JKYRxvjleh8LvL3LLsYeC76IOYWzUdDjeAEF4zn6CcHBI
 8pys=
X-Received: by 2002:a17:907:9603:b0:c1f:9c3b:96a7 with SMTP id
 a640c23a62f3a-c1fa56612afmr189628566b.17.1785441789687; Thu, 30 Jul 2026
 13:03:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260730153604.1462722-1-stefanha@redhat.com>
 <CAFEAcA-mn4x9MJ1dVra1jP_5taJJQHwYz-khKXzm8RCeYnaELg@mail.gmail.com>
In-Reply-To: <CAFEAcA-mn4x9MJ1dVra1jP_5taJJQHwYz-khKXzm8RCeYnaELg@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 30 Jul 2026 16:02:57 -0400
X-Gm-Features: AUfX_my9pbbRCyCEqlkvEtjpBL6zm9LVZngVJWsjNsUXqBLABgWyRvwbtB6kE28
Message-ID: <CAJSP0QV5v9BEMG_Y8M73voTvLevRq+gaDbzExJQurew=M12amw@mail.gmail.com>
Subject: Re: [PATCH] virtio: make virtio_add_queue() queue_size an unsigned int
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=stefanha@gmail.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, Jul 30, 2026 at 12:02=E2=80=AFPM Peter Maydell <peter.maydell@linar=
o.org> wrote:
>
> On Thu, 30 Jul 2026 at 16:36, Stefan Hajnoczi <stefanha@redhat.com> wrote=
:
> >
> > virtio_add_queue()'s queue_size argument is a signed int. Coverity is
> > unhappy when that type is used as an argument to g_new0():
> >
> >   *** CID 1664271:         Error handling issues  (NEGATIVE_RETURNS)
> >   /builds/qemu-project/qemu/hw/virtio/virtio.c: 2595             in vir=
tio_add_queue()
> >   2589         }
> >   2590
> >   2591         vdev->vq[i].vring.num =3D queue_size;
> >   2592         vdev->vq[i].vring.num_default =3D queue_size;
> >   2593         vdev->vq[i].vring.align =3D VIRTIO_PCI_VRING_ALIGN;
> >   2594         vdev->vq[i].handle_output =3D handle_output;
> >   >>>     CID 1664271:         Error handling issues  (NEGATIVE_RETURNS=
)
> >   >>>     "__n" is passed to a parameter that cannot be negative.
> >   2595         vdev->vq[i].used_elems =3D g_new0(VirtQueueElement, queu=
e_size);
>
> Though note that the reason Coverity thinks this value can be negative
> is not because the function might be passed a negative value, but
> because it incorrectly thinks that
>         int override =3D object_property_get_int(OBJECT(qbus->parent),
>                                                VIRTIO_QUEUE_SIZE_OVERRIDE=
,
>                                                &error_abort);
>
> can return a negative number. (It can't because of the error_abort
> and because the property is a UINT16 one.)
>
> It might be a good idea to enforce the VIRTQUEUE_MAX_SIZE bounds
> check on the queue size we get from the override property. Since
> I think that can be set by the end-user (though probably it won't
> be in practice) ideally we would not abort() on a bad property
> value, but that's awkward to do at this point...

I'll send a v2 that addresses VIRTIO_QUEUE_SIZE_OVERRIDE.

Stefan

