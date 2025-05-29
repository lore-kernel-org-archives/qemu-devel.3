Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A56C54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 08:13:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKYNN-0002Eb-Gw; Thu, 29 May 2025 04:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1uKYNL-0002ER-QF
 for qemu-devel@nongnu.org; Thu, 29 May 2025 04:12:31 -0400
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1uKYNJ-0002JX-Ku
 for qemu-devel@nongnu.org; Thu, 29 May 2025 04:12:31 -0400
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-4947635914aso7041181cf.3
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 01:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748506348; x=1749111148;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rnM/Z8H2fHXMXVyQJKbHOTYSPT700wIA+x6GI3WO/rk=;
 b=B8lvqWz6d1AodP1JKi8m58uuhUGM7+dAg6ZqQ6zDt0FikjrzNfxxh2pHbnCLia1UUh
 mRNng0hLmKGL2XMAqexidfRChep4tMsaqgWaRJXDJ8K2kriUR2vK8WYyKjVJ0pno0Osi
 84MkJ5MhLf8aUoKdb4nuUWAVw4h16QOSOrtZAx5iEcdy7+KWt1Aol3L83VuN/vRpwoqc
 y7bmjXujlyiN4NHfRmwJCawrHownZ8JueszO+gYAIyFk1Cnv13nWQXMV17TBYFVnurbp
 Lql/i6ueq1BxieJBq97FoOnipeuuE36jaWtmWxdLSwudE8kWFbVZPqIFMJFPtAtP5mUG
 zdkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748506348; x=1749111148;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rnM/Z8H2fHXMXVyQJKbHOTYSPT700wIA+x6GI3WO/rk=;
 b=C0q0dSHxBU/0kSvB8Fym10ukQriaDSrdHksqreqJ7DwhoFVmKS1YFyF3f1eGsPmyfe
 V7W7pEoiZ4fnfcCTF6npUivKR9G4r5RoXD/JgzRomW64Alq0PNYlq9uPk+S4lfOLZfZS
 tr5NEPhoiYOku+1TlS/peZbuO0KOxweKwmB/bFSJKezrocFFcWhCDERRB5paFuQMkKxE
 q8KEPIDGHytk817edXBfDmaipj/N9OZSJGe2dEpxk8T6T5q+ltdjF6l1fE7z7YVjXziG
 lISSUfSyDRzXCcmcyvclj/vKTGFC3qbHZnHlE/ovpeKnMEeQ10JFDVNFBr+aNbUDRNmP
 +0Mg==
X-Gm-Message-State: AOJu0YygtTTfVNPLvjTvIC8ie5rr85i1FYd1HBCif5r5Ab1d2OPfyaed
 qj2tMXA5mkgBnza/TD7h0sdY8zwHKxtqM4QOYeQgjzXuVmnmFgtQfD7BMoNc5s17pQ/bb9aNuAQ
 k98WdOGI8E4G7M6l5E35YPGRTdAiqLPFNzjhJPiTmFAC4FWfP9JlyENk=
X-Gm-Gg: ASbGnctpQGO4By9slsd5WNZP8ZVVnJmm6NHTbyhvZuqDhoqaPARH64k1Yx6gAdhpxiK
 ygDEHALz8lhMbi6EkQAGXkt/qjsji9gVwizL8zN42q0reCFlzKgRILfE3nLSCXzPBgS/0orLVH8
 4+oYnWINGe7tQQxaOOCkXJut8UlhgN2E0t0JBkp7rEPc9JjrPgQPV8e+fyY04hH/Aayb8=
X-Google-Smtp-Source: AGHT+IEm1RfNtZd0HEZexQHgLMUyI2hmGLQ1MaMXhBneUz3hQNZLGnJ/W4I7CroK46bp2gFIUi4CZojem+dyQELfrr4=
X-Received: by 2002:a05:622a:4cc4:b0:494:9fce:28f7 with SMTP id
 d75a77b69052e-4a4370eeb90mr17143621cf.17.1748506347804; Thu, 29 May 2025
 01:12:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250515063237.808293-1-yuri.benditovich@daynix.com>
In-Reply-To: <20250515063237.808293-1-yuri.benditovich@daynix.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Thu, 29 May 2025 11:12:17 +0300
X-Gm-Features: AX0GCFumf1MgKzM0I8a9p0Qq-GbNlmwQYCAOwtleKymyOiN_kVIj8xPDyM91lkg
Message-ID: <CAOEp5OegzUevfFit=qHzhjzSq9FPWq45kYjEgriFB0W111aAtw@mail.gmail.com>
Subject: Re: [PATCH] virtio: check for validity of indirect descriptors
To: qemu-devel@nongnu.org, mst@redhat.com
Cc: devel@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::836;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-qt1-x836.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

ping


On Thu, May 15, 2025 at 9:32=E2=80=AFAM Yuri Benditovich
<yuri.benditovich@daynix.com> wrote:
>
> virtio processes indirect descriptors even if the respected
> feature VIRTIO_RING_F_INDIRECT_DESC was not negotiated.
> If qemu is used with reduced set of features to emulate the
> hardware device that does not support indirect descriptors,
> the will probably trigger problematic flows on the hardware
> setup but do not reveal the  mistake on qemu.
> Add LOG_GUEST_ERROR for such case. This will issue logs with
> '-d guest_errors' in the command line
>
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> ---
>  hw/virtio/virtio.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 480c2e5036..8d185f282a 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -205,6 +205,15 @@ static const char *virtio_id_to_name(uint16_t device=
_id)
>      return name;
>  }
>
> +static void virtio_check_indirect_feature(VirtIODevice *vdev)
> +{
> +    if (!virtio_vdev_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "Device %s: indirect_desc was not negotiated!\n",
> +                      vdev->name);
> +    }
> +}
> +
>  /* Called within call_rcu().  */
>  static void virtio_free_region_cache(VRingMemoryRegionCaches *caches)
>  {
> @@ -1733,6 +1742,7 @@ static void *virtqueue_split_pop(VirtQueue *vq, siz=
e_t sz)
>              virtio_error(vdev, "Invalid size for indirect buffer table")=
;
>              goto done;
>          }
> +        virtio_check_indirect_feature(vdev);
>
>          /* loop over the indirect descriptor table */
>          len =3D address_space_cache_init(&indirect_desc_cache, vdev->dma=
_as,
> @@ -1870,6 +1880,7 @@ static void *virtqueue_packed_pop(VirtQueue *vq, si=
ze_t sz)
>              virtio_error(vdev, "Invalid size for indirect buffer table")=
;
>              goto done;
>          }
> +        virtio_check_indirect_feature(vdev);
>
>          /* loop over the indirect descriptor table */
>          len =3D address_space_cache_init(&indirect_desc_cache, vdev->dma=
_as,
> --
> 2.40.1
>

